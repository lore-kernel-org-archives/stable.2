Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49935DA47
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188346; cv=none; b=owud8kSHAdPFLAb9thUv/0Ub8QSiQaa4JuO+HV/ZaUo0Ho42MsPU8mpqT4+P5gsJoKPaPfgr18Hy34cvcXZpCmWPZxpdiLW57ho7xwfRniuXZUAK7wgVTVhmBKBHCgLbyRwxJpYrwl6Yz/OB9WQa5e4tJM24SMQf7nCChRFfiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188346; c=relaxed/simple;
	bh=D3Y6uvtgWaKTYYaKnTIAlysD9qf4fv1PZWLoE32GZko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pJak1sRmX+JEI9+0G2VHzqPMUujM1OGEgoEw6ZXzdEDeCM/h1RZAj49NzrVTD8u8NRrYlJmm2VKGVWsBUgEWejB6hfQIQpqvx9VBPjepX9LYNyMhhhwRnCi0IYITMTqPjtScybswavZUPfY0+fVHwxuvNixfsoLgDpZS4vg7AYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whe19dNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whe19dNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68AE1F000FF;
	Mon,  5 Oct 2026 08:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791188345;
	bh=f6SDAkxX1pi9oE8lJA269hnMsqzCleAQG6YT5uN0p30=;
	h=Subject:To:Cc:From:Date;
	b=whe19dNPn/gvY5dXc8UjTd6C+zyYGOjy8e5oZ0XeHPW+jrlq9M32e7m8YIAFJ5/kw
	 U34g2IqWyBfySmMFKfaP6XvarZvCUzR5VY8gSsR4eybDQTGznCnHOSLKQKqclYa0tt
	 exGBm7y+5W1K6rALkPRDBVMTAjhBMXyNh5++9gms=
Subject: FAILED: patch "[PATCH] drm/amdgpu/gfx6: fix firmware leak on teardown" failed to apply to 5.15-stable tree
To: williandossantosdeoliveira287@gmail.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:19:02 +0200
Message-ID: <2026100502-reprise-spinner-8d6e@gregkh>
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
git cherry-pick -x cc172e177795c5f87bc2d71768d077e1c10633e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100502-reprise-spinner-8d6e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc172e177795c5f87bc2d71768d077e1c10633e8 Mon Sep 17 00:00:00 2001
From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Date: Mon, 21 Sep 2026 22:54:10 -0300
Subject: [PATCH] drm/amdgpu/gfx6: fix firmware leak on teardown

The firmware requested in gfx_v6_0_init_microcode() is not released
when the GFX block is torn down, leaking the firmware resources.

Add gfx_v6_0_free_microcode() and call it from gfx_v6_0_sw_fini()
to release the PFP, ME, CE and RLC firmware.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 386e81346f95ab0be5a82c5535de932e7a456924)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 563abcf718b7..493ccfa26655 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -322,6 +322,14 @@ static const u32 verde_rlc_save_restore_register_list[] =
 	0x00000000
 };
 
+static void gfx_v6_0_free_microcode(struct amdgpu_device *adev)
+{
+	amdgpu_ucode_release(&adev->gfx.pfp_fw);
+	amdgpu_ucode_release(&adev->gfx.me_fw);
+	amdgpu_ucode_release(&adev->gfx.ce_fw);
+	amdgpu_ucode_release(&adev->gfx.rlc_fw);
+}
+
 static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
@@ -3249,6 +3257,7 @@ static int gfx_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
 	amdgpu_gfx_rlc_fini(adev);
+	gfx_v6_0_free_microcode(adev);
 
 	return 0;
 }

