Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681748988A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208999; cv=none; b=ADHy7U5ijC7INM0kQ5XCOY7wSKrTvHCuNZtAB4GGnf0kUvDitIdRNXXgM2BwUhM6K9vQvS3D0anOOWQuKWewAYJYJyPpCDpU2zv//dXvMyYzwzqbYWS5aEx3Sp50e8vlCvp6KrY3U0GtS8rif2icRO/aSRfhBqX4DG581SN5uNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208999; c=relaxed/simple;
	bh=Nm9Rlk1A0CWAMYH8VyNSZ7mNCy988xosE+ntU6XhZVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn/UZHTMTJfAQMZnBpNB8ck9AZ33zpZMPWXFLSmZzo8/vx6D4uEz0nDtrdqmkDRMr7IbSp+HzGVybvEOPVaWtHPUjc3EyeLuRBTxyUwTwMtgzpUKC+NgVWh6QrasKsT44jhNpfKIKdHrsuMGfBjqSuT8y2pPLZtH32Gb9QTwJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4y5M/D8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4y5M/D8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE531F00893;
	Mon,  5 Oct 2026 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208997;
	bh=oGbi1kuIU1qFBi2bcm+3PbGpcDMTZCoxCmJf2TIEOMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f4y5M/D8yn/coVGJM7OcS9g7QF5HonPlU8xcpCdLpujzayhvBPOOVZZFbHXWExppT
	 0qPSO4SvAwTXC4z96ZNZ4vPdTTlDegag8BXQFTjlNDkGhI7dx7+Hm+x0TM49oP7sAB
	 ggagBmcfQ03KIYRPOvkJ0K1BGIWut+plvkuXwdYgMcv2sYuRy5YLH56LfkeTRmGpVF
	 yJoJz47lRu7jDqwu9U8w8Xd5gg4lsinY7PbGbVYaqWH7rR1+XreEqcIWqLk6Wvv8oM
	 jsDGnKPVZU0XBBnu1LJ3MQ49dUghhOnlQyzj4oHgdpdm8qrU1VguNa/rnVx3q6nupb
	 xAjk1vfuyeV8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/amdgpu: reset VI ASIC on MacBookPro14,3
Date: Mon,  5 Oct 2026 10:03:13 -0400
Message-ID: <20261005140300.2983832-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005140300.2983832-1-sashal@kernel.org>
References: <2026100528-almighty-whoopee-38d8@gregkh>
 <20261005140300.2983832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>

[ Upstream commit a22e5e4f2ebbdbb962cc3233094d189c4dfaa051 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 162077d3bf765..86be88171bbaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1419,6 +1419,7 @@ struct vi_reset_quirk {
 static const struct vi_reset_quirk vi_reset_quirks[] = {
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
 };
 
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
-- 
2.53.0

