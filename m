Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B2379EE6
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188335; cv=none; b=LDxDsQ87exrHSRJTGOTJ0djUAxd6zPuqIS2qW3mCU9Jl3Gmw7/Gac/oMc78zeBGdpNEyYqqzqT/gFN0pKPRVMPrV8rC81k8Jn76nK8KWdAk9fw0oxRJWByU9yZwTJuQSP3/KXNlozE64gj1HDA1u9sqKD7yKHJINUcPdO0OwqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188335; c=relaxed/simple;
	bh=CTl0vjYwIiAczRgAXGsEY0bKrcmBDRXSRaF4XSbrVjQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U7ks+WxEolsC9sOpn4Kx+vaFZCRlCstEfyBFNDd1mP/l9zQ7h/4CodMVdNqTkGThXX/2+hIbNAoDeYZdf6mNAN4GaLqTdTBfw+9tgVDS3xiFQpfF8Kus9pnehj22BmxGb9cburpmkZQHK4FxgZTDdU1Rw5gInJ4rrG6azUN3al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ORRMz76c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ORRMz76c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0FA1F00893;
	Mon,  5 Oct 2026 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791188333;
	bh=ufCpNKdZaf4qYVfW+j7vJG6caMeNQfzPGsBdKpOq9tI=;
	h=Subject:To:Cc:From:Date;
	b=ORRMz76cpNEMyyDZLVIokc5X7vIj2ObPmcgnKS90RAtRUNRVBi68HxsL5joYJj+fL
	 vbaidoJaqVbC+8O4Gl2+2tbRZVSLyMTWgcx8UvA+nGya45pIcF036D5vsm+qtCZG1o
	 e+jPFZtFj3TKGyjagHIsOhrur673sO8TpyJhsK+w=
Subject: FAILED: patch "[PATCH] drm/amdgpu/gfx6: fix firmware leak on teardown" failed to apply to 5.10-stable tree
To: williandossantosdeoliveira287@gmail.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:18:50 +0200
Message-ID: <2026100550-achiness-flaky-b759@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cc172e177795c5f87bc2d71768d077e1c10633e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100550-achiness-flaky-b759@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

