Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADA37BE7F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187905; cv=none; b=MSdXSoWWr4EOw48HHb/Q/grheDhYxvbZC4ZBG11pTDWE9cf5LyIeKgJcyCi919DTCOqjeu2+ce8Z3k+6EVtu6mJZAjZ9qzOCIvMBlrJZJ5fzXDXgm/bzqUheny7XF97f4jxmWgG5RGTt5edPZwgUu6ejdtjB4oktPUBrN9Qr2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187905; c=relaxed/simple;
	bh=WNOO1pDnkNAa2UxrT5oCLA453SHr7bjJLJZ+YlYc77A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eZAeWbMdBBIXQmfzS9x/jigNa+i1iEx9kdm7pszfN+Y2oXisa6lI1qhTCC5R8WpEii1WAvSKNKypTU4hlKrfhf+pJTtsPsoFHdmqZNdLhU4ykcficis3Q5g9s+JtlLXSUewgh3l1NUKPMnIttwySJbKYyQZWd5I249x7Ml9oryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1VQGsD1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1VQGsD1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51741F00898;
	Mon,  5 Oct 2026 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187904;
	bh=BK5pOFKlyH60zCHXoBlZQJdc3oDWYQavNbGWfeMbOBw=;
	h=Subject:To:Cc:From:Date;
	b=1VQGsD1Lophz/zh7sSTv+vAsa+iQSr1XmOJqnFbmXYwJw4sNVzNsnqpeewxtbmuLc
	 hrkYDyayEKltV2BgZYDcxavjZvhkiPjpJxLnuAnMnV2jYO1RrA9drE7HM+mRkex0P+
	 PLHgl+QT24i2EOoh4lHaDkbDUNd8JAlcel2uFAMA=
Subject: FAILED: patch "[PATCH] drm/amdgpu: reset VI ASIC on MacBookPro14,3" failed to apply to 6.1-stable tree
To: fbeltranmillalen@gmail.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:11:29 +0200
Message-ID: <2026100529-unstirred-endurance-7a1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a22e5e4f2ebbdbb962cc3233094d189c4dfaa051
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100529-unstirred-endurance-7a1b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a22e5e4f2ebbdbb962cc3233094d189c4dfaa051 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>
Date: Thu, 24 Sep 2026 18:05:23 -0300
Subject: [PATCH] drm/amdgpu: reset VI ASIC on MacBookPro14,3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On a MacBookPro14,3 with a Radeon Pro 555 (Polaris11), the framebuffer
is at MC address 0 when amdgpu loads after a cold boot, as the firmware
leaves it (MC_VM_FB_LOCATION = 0x007f0000), while the VBIOS ASIC_Init
table places it at 0xF4_0000_0000 (0xf47ff400).  amdgpu reads the
location once, at init, so after a re-POST (S3 resume or GPU reset)
the framebuffer has moved and the driver keeps programming the old
one: the SMU is handed a table that was never written and the GPU
does not come back, which leaves the internal panel black.

Resetting the ASIC on load makes ASIC_Init run before the driver reads
the location, so the driver uses the VBIOS placement from the start and
every later re-POST puts the framebuffer back where it already is.

Add the Radeon Pro 555 used in this machine to the existing VI reset
quirk table.

Tested on a MacBookPro14,3 on 6.18.49 with the quirk table backported
(the kernel also carries unrelated local PCI and ACPI patches for this
machine).  The framebuffer is at 0x000000F400000000 after both cold and
warm boot, and the GPU survived 9 S3 cycles (lid close and rtcwake, one
of them with the lid closed for about 7.5 minutes and a USB-C disk
attached), each followed by a few minutes of 3D load; no ring timeouts
or VM faults were reported.  The reset adds about 0.23 s to amdgpu init.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/all/20260924132952.25054-1-fbeltranmillalen@gmail.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b6b1d97218518003107d4446fac278fa3e0a19a0)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 352c27103305..e926d09128e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1397,6 +1397,7 @@ struct vi_reset_quirk {
 static const struct vi_reset_quirk vi_reset_quirks[] = {
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
 };
 
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)

