Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049989;
	b=sdxcg9ahYANuv5TKH9GaV/GBmvBtFKfWLQvmvhRikW4Jn5IEFBgitiFnQ2YCFJ2m1l5R
	 xgnBK3E3Tt4X1jKj7ATfjR3LVEXPS3F7CvRUeF5c2XgZsXZBlbsteW9dr/YYo+L1hE2O1
	 re+xDIscLXuFkD8gNkJydSOmG59UR5s9/NfpCmML4bxq67Vx6A4UK4gGcHXqDR+YGr+wT
	 QaLhH31qtndZDwOKMgMI53gVcH0Ao6kAYZP0Lpq3/afc05yWjwYaD4tgBzMVlV1A3SNLK
	 pk5Iv7ep/7h5i7BQUzmAs5pvt19Kicia3W0nPwAKTrOBbq8UiPZap+iS96nncrI2Lhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B/JRjbRrDlENQGXPMY8RzclhkQtBaKD+SGqIythc2mc=;
	b=rkERIdSRytj9NQGFhV8qqGzo23OoqbMQCYplo28CeaXU3/JGxb4otk3ka5qsFZG5jYR6
	 vZw5E+tuQuYbWN8or8jdyWvGscHHFCqZNBTIZ+8s6xnpavNVeZFgu0zNYtQcc1+Gz+Rqf
	 uXwX7vFv/LD21k9ud5K5yXpRs38DF01hoKG1VUjykOVIf4xTgtROByTjqrHLMQzqTINU/
	 afO0d8S4x9ZLtr7nrr3zACt37UEY5zIHz84EgQntPzdRzyPWuq10i3oMzMvTK3sdQ0i0a
	 cPmyaEGsxHXtA3/1gdBNIZ6l2s1dq0DgnFqKLyGyiAgp8M8UeIALJGRHVKPrsVdJkgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGdxwNfU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD43606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGdxwNfU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9851F0089F;
	Sat,  7 Nov 2026 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049988;
	bh=B/JRjbRrDlENQGXPMY8RzclhkQtBaKD+SGqIythc2mc=;
	h=From:To:Cc:Subject:Date;
	b=RGdxwNfUsuR6hbcDNi4Rqmdco3T3IyEELOpY7fCVOkmY82fskNxdIU/I2k3GCpO+Z
	 tgTjoY1OdzCIk1deu8NOyh7wkw0i1D+XD15XnseXSH7eFLTLfSu6dYlSL0rTAzHli1
	 WgWHrqglUJSbYczm+Ykk2aM4fzk3IGkKzUR0GYE5PfQ4UwnLXw8xe4isP4nbElDljW
	 r6m5eJWsgxmXL1Ke/w7OS5m01XuS8rc4nwUvxrgLu4j/TighVby7ak0GaIlsDJipOi
	 KdhV5gHtt0WmCPvOzeRke+4UvOSjmMmEQ6nBHnELsWe4CtjZTuG4ekZcGJk2XDRNc0
	 BpupZm04cm4Zg==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: reject CS chunks too large for kvmalloc()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:07 -0500
Message-ID: <20261107061306-failed-5.15-ba4c3c202919@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ba4c3c202919405f461a393e823e4b72c8518494
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061306-failed-5.15-ba4c3c202919@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ba4c3c202919405f461a393e823e4b72c8518494 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Sun, 18 Oct 2026 19:17:57 +0800
Subject: [PATCH] drm/amdgpu: reject CS chunks too large for kvmalloc()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CS ioctl copies every chunk with vmemdup_array_user() before it
looks at it, for whatever length_dw userspace gives. kvmalloc() warns
about allocations above INT_MAX when called without __GFP_NOWARN, so any
process with the render node can trigger a warning. On navi31, a CS with
a chunk of length_dw 0x20000000 returns -ENOMEM after:

  WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x5a5/0x7d0

Reject such chunks with -EINVAL before trying to copy them.

Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dab5f5280406088591645f499f048dcfefab8d7d)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 65e13ad445bbb..70bc53923d119 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -218,6 +218,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 		size = p->chunks[i].length_dw;
 
+		if (size > INT_MAX / sizeof(uint32_t)) {
+			ret = -EINVAL;
+			i--;
+			goto free_partial_kdata;
+		}
+
 		p->chunks[i].kdata = vmemdup_array_user(u64_to_user_ptr(user_chunk.chunk_data),
 							size,
 							sizeof(uint32_t));
-- 
2.53.0




