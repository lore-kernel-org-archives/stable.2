Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047243;
	b=ZoiEqLGvZ1EwsI930tm1iO4sWiLu5c4O9PEWukGQSxYfWxtTu8qKkSBH0EdbAA/hFeIy
	 l34273C41JmzlEUd1JxltSBsPOdboNGlimrZx7btfUJCeem4VOyjdrMgTD11OxRuSQDc/
	 odHa6xBWjBQReLCCtnlVea+GJsWjhvW//2tZ6BHSWTHaufSe46ykIp+ehbi4BcBZfViN4
	 2Qvqg5f1jUCM1zlVAgnq0fipZ36IrluRXT5GoZk/r1PvBZy7LCeJ3V+KeMHJmUmzNZEUd
	 kbtPFtH1BZlsk9b4j9MxWu0FRTFZQGy7v+1UAUA3tmjpZL4gEmnIM961ls5vBBcDObA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047243;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BB3cDCMLNA8TloIbZYsOuIn2lBbCqnCem5SPTiAjgcs=;
	b=V3krB3oSFzuKOxrQ6dw7+tzQmHva5YqfcljOUHSqni6wWYqmChe5FLwbfkqoo7Hh3y8S
	 MJq7mbHNLDk4kviMtwa7gYlvayL5dkgGr+IaPGNenEP5Jufzb7Z+udP5rdMW7E8NvxzES
	 lTdDqR6xtev6xcRjd1Y32SOmB2u9Deowd9kz/C5xaT+IFCG5ZLBMlrxCFzM/HKXShJGUj
	 srxFXGzNCcoSSdF9JWURb1s083K+9hauS6IgIKYuyHG7juPi6moEgscblyNSPvodIS8PC
	 rEOJmgjh9m347sHzMS/H/i9opt+2q+PbE6UKL2d/EMMezSM67QZADyoi5+fg0DP4jJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UE0C/5RQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4EB606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE0C/5RQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F8A1F008AB;
	Sat,  7 Nov 2026 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047242;
	bh=BB3cDCMLNA8TloIbZYsOuIn2lBbCqnCem5SPTiAjgcs=;
	h=From:To:Cc:Subject:Date;
	b=UE0C/5RQQK3jlD+jNyjDJwKlfBZAVBpNu/ns2qn7XkuIrufoxKGK3riExBt3BnmsV
	 4r6pV61hfl5b1DUDrwe3aqoK7yFXMfRsph98+Y7reGH+uQUMnpyMLJvV/t3id3md6p
	 cYlKOlf3wdrCInPaeM03vCzWoNXTR8oOkxEGwiRCt1IvNI9bC8sWgX6iQLxsd011jB
	 ZFvMKy1uDv6TqKbIZdUWJODczDPZcrHAu9ngLxCcL+eOXEdORSzhahqo4kLbXN8U9C
	 wQnT+iut96QwF92Dy+xNzOTQzO0HROb0PeMCts5R4+5SS7fQowIbnVMxCh9nEBM2lb
	 iDORy0x4W70Ww==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: reject CS chunks too large for kvmalloc()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:21 -0500
Message-ID: <20261107052721-failed-6.12-ba4c3c202919@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ba4c3c202919405f461a393e823e4b72c8518494
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052721-failed-6.12-ba4c3c202919@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




