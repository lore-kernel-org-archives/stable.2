Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D107476CF4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196060; cv=none; b=CZM0MzEXNnaOtY8uHJmGYfZM93d0hMdUjlv/r49OkevKkzPAOFVMQ3OXilKpyvI/7aOZg/ebK08mi/Fv2rsNMZ3ixvaEYElBUPMyvFjFW9mNOfrbaSNo9Pbo3j/lSnL4fKuJuyyTE9vPgqxvhY8eBvSWOEQ3Se9ODjm4s8aaGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196060; c=relaxed/simple;
	bh=iosooUUqd9X8McSMlUCEryVJVgziChHPXJZnW/t46c8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tm1QgTwMX45ibIFkZWVEfExuzPyGxooTdqA/2ZpBlO3iJ7MHYhqEZJFhjq9z8xxtVrkl0/yoHPehhfsLTKiuco6DYr+XS5M+x5ILAHfFkyl72ixKnscHKFlZ+Ch4+KSoZGH2fRXk+MQi+AWrERfSjvFkzFF6dV39NA2KvvAVDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rXSWktIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rXSWktIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996861F00893;
	Mon,  5 Oct 2026 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791196059;
	bh=H8PIChVqVm/R3u5/qccigI7fTM0iw9CHB0qYqmMBD1w=;
	h=Subject:To:Cc:From:Date;
	b=rXSWktIBpPHifrHBbwRMT3U781YQZBiQPOP3V/DdpOD+SFIZ4mEaXj8aSuZK9GnGv
	 hHMhhgcDnEGGrm+oSB7GcsTEzgq5FOn1+b2KMFK+SZQVeRa2N3IDb/z3besdVm2Jnx
	 xNRxnUJIUptyeQVIB3JCaP0NhQ8ML1iO6QVam18Q=
Subject: FAILED: patch "[PATCH] EDAC/altera: Fix memory leak on dci allocation failure" failed to apply to 5.15-stable tree
To: dinguyen@kernel.org,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:27:24 +0200
Message-ID: <2026100524-payer-capricorn-e50f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3e4a10a4718e3d963ee4d6c5f26bc5ad57c1d2b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100524-payer-capricorn-e50f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e4a10a4718e3d963ee4d6c5f26bc5ad57c1d2b1 Mon Sep 17 00:00:00 2001
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Fri, 11 Sep 2026 07:06:26 -0500
Subject: [PATCH] EDAC/altera: Fix memory leak on dci allocation failure

Sashiko reports:

"If devres_open_group() fails, the function returns -ENOMEM without freeing the
dci structure allocated earlier with edac_device_alloc_ctl_info()."

Free the dci structure if devres_open_group() fails.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org # 6.18+
Link: https://patch.msgid.link/20260911120627.2634225-4-dinguyen@kernel.org

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d8a3438fb5f4..ccdfb35178b6 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1516,8 +1516,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL)) {
+		edac_device_free_ctl_info(dci);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;

