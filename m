Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAF3AAF62
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342050; cv=none; b=ZmF+Wke67JlgU/1zTq3WdS+Ftj7qYPBzsmzqRnnKkE5gH21Bc/+BmBfml4GtvKUoQ4dEMcBLz2jj9f7vofvarKVrLW24a2TEiUbp3WbvFL3xEov8+a9+B04AIJCWCxf7vhrWk7hS3o7Tl4PBcxxT1JY7ZIKIzNZFYMEvXs1Hnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342050; c=relaxed/simple;
	bh=XIW50STIu1JlYFLSvEIqDf7uXiB+sH9c35EfU/YUABQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c7wtqbm2npo0F9bjCHDiMyo9p50Jv4DM2ZnmyvMRo/yCJeFaTJZ34x9I1YriddFp8rHbDJ1Hxz1xDsG+X+9wUwiDcjjWCMB/G0V3efaTMQv63yf7VNoUfE6ixtFz0x0M1RYiHzRUT7fLXeQqInokBYV7QsEbNipFoM9vCdGFqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JijUDXCq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JijUDXCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052851F00A3A;
	Wed, 29 Jul 2026 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785342048;
	bh=rOU5Hg8PqTs1tBxSzuAC42moFmsmUABP3w+4bqtYyNI=;
	h=Subject:To:Cc:From:Date;
	b=JijUDXCqCYuLa+nCdovPIK7vkceWk02NBIb5o9wV2q98p5seHpu+hV/5R+qI9Vv1w
	 Ge/kd0r9xTvSps3bK/hLYY/LDOsyUM4akA0Ec65+xCWDEXCULjmfylzd7KHYwajl49
	 AgyFOVuEH0Qt9WxP4LGRcV6/gNcZ80jx3en9ph4I=
Subject: FAILED: patch "[PATCH] drm/amdgpu/soc24: reset dGPU if suspend got aborted" failed to apply to 6.12-stable tree
To: jakob@linke.cx,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 18:20:34 +0200
Message-ID: <2026072934-scary-aflutter-5331@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aff079bdce65f6d085e4b0091fdf87fffa95b0d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072934-scary-aflutter-5331@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aff079bdce65f6d085e4b0091fdf87fffa95b0d9 Mon Sep 17 00:00:00 2001
From: Jakob Linke <jakob@linke.cx>
Date: Wed, 17 Jun 2026 08:24:15 +0200
Subject: [PATCH] drm/amdgpu/soc24: reset dGPU if suspend got aborted

For SOC24 ASICs (RDNA4 / Navi 4x dGPUs) re-enabling PM features fails if an
S3 suspend got aborted, the same issue already handled for SOC21 and SOC15:

  commit df3c7dc5c58b ("drm/amdgpu: Reset dGPU if suspend got aborted")
  commit 38e8ca3e4b6d ("amdgpu/soc15: enable asic reset for dGPU in case of suspend abort")

The aborted resume fails with:

  amdgpu: SMU: No response msg_reg: 6 resp_reg: 0
  amdgpu: Failed to enable requested dpm features!
  amdgpu: resume of IP block <smu> failed -62

Apply the same workaround for soc24: detect the aborted-suspend state at
resume via the sign-of-life register and reset the device before re-init.

This is a workaround till a proper solution is finalized.

Fixes: 98b912c50e44 ("drm/amdgpu: Add soc24 common ip block (v2)")
Signed-off-by: Jakob Linke <jakob@linke.cx>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit fed5bdbfe1d4a19a26c70f7fc58017dc88be1c18)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 265db9331d0b..9dce30d2bb8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -496,8 +496,36 @@ static int soc24_common_suspend(struct amdgpu_ip_block *ip_block)
 	return soc24_common_hw_fini(ip_block);
 }
 
+static bool soc24_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg1, sol_reg2;
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset dGPU side.
+	 * 2) S3 suspend got aborted and TOS is active.
+	 *    As for dGPU suspend abort cases the SOL value
+	 *    will be kept as zero at this resume point.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3) {
+		sol_reg1 = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
+		msleep(100);
+		sol_reg2 = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
+
+		return (sol_reg1 != sol_reg2);
+	}
+
+	return false;
+}
+
 static int soc24_common_resume(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (soc24_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend aborted, resetting...");
+		soc24_asic_reset(adev);
+	}
+
 	return soc24_common_hw_init(ip_block);
 }
 

