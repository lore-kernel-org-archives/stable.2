Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED84BB260
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212528; cv=none; b=AFwV7DwsjaA4/PBXa+TNGk+U5Oq+omnWP662FKFFy3nADQobdJIEQ1Me9On6b0VEMQAKgKygEvbEVk5+d34ziV+OTk/Jza8mZn+MN98lIU+OD2CQWC1Vyie0eOVC7TZ0ZZvB3+vDsE4vAV3/MHCxSLU05T7k9gvzQBOpLonFWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212528; c=relaxed/simple;
	bh=3SBem2f/OBiH2vIvQVumd7R7eYkwPe9khoZZnyKIyaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNaoIvzxhDyg8f1E57SKIAFrtHgne8hxhI8DvRhkrlEEiv2jWy5oVbw6Jn9U50biGfBdUf01oWhpfhS2044mcPFbv4uXZ7KdA8pK4PW+eyhdE8xqKDJq8grNK6X0UH05j/OB6LSuxgD92Vf6e+HxsHoW+mGIAQB33/EVhKE5X78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBpx79UO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBpx79UO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D38C1F00898;
	Mon,  5 Oct 2026 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212526;
	bh=YuUuhJfZ1ViReXwXHMe2Z8e+cn9xa1+UizWQ3aezj8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBpx79UO54KC3qk+s5CFcoQpBFOztRybkfkdINMdJS2z1GAwlk2Avx1V+zfiOUI9b
	 Ncrgp9A+H6Ek4Ie1mQKfw4gqIt7uzyz4CSThkERQ0Bo2IqTEPU7W94PKZkJTsHS8rD
	 ruBTDHtkMxCrkKIpDbjlKj8Ss7CgUQwJYMfVkAkORRqCvnx2CXaqmw+ZOnQBM4l5b9
	 boPyoEJGJXzpSmRugUR4njkafUMCaMnA6SpGjWkmcJUssTf5HEqrAgiSg5D0LpyH7Z
	 NmxOPT2Bvn8d5obJUqjyBUkmnLnZeknAr3swGbmkbO/yD4Zotql/IY5dJ3VJYA6cya
	 /U4jqQ7aiTOSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] drm/amdgpu: reset VI ASIC on MacBookPro14,3
Date: Mon,  5 Oct 2026 11:02:01 -0400
Message-ID: <20261005150142.3024473-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005150142.3024473-1-sashal@kernel.org>
References: <2026100531-defraud-otter-4082@gregkh>
 <20261005150142.3024473-1-sashal@kernel.org>
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
index 39c51dc897879..1ceb23f2fd92d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1068,6 +1068,7 @@ struct vi_reset_quirk {
 static const struct vi_reset_quirk vi_reset_quirks[] = {
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
 };
 
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
-- 
2.53.0

