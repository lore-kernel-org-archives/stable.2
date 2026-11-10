Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274133;
	b=uwpgnMvD7yNrYkNqjKS7XuZXxF7cTyrKJ7TJSEY6FU111plY+oIDHMatHoREY+TvK2B2
	 fcVXDUEnYCt6e7flF5fSQy4lqTVKMjYz2cMOJHIQ5lZj0ESE7WW1ZqCPNN6YiKft07rHp
	 VooflWhdWOicDs5tR57CgIkRqcozm9EuRSPZYj4lMFLzRuMoFoK0Doj1MgYxzcDgrW5dk
	 4KzUu8JN7BNs2y/vnyiO+h8we6dLKdiajmhtPP2HEV1/M4s1PZ69uuJSvFgpC8S1TOA5e
	 6bm/d6b/KZkDYGanDgBBL2PVjLs6vdkpEgnuBZnfuM0sY3fhr8IVqMpuk63scvFF1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274133;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IEtYOXdujhhB8+1cQaXRs8HKzxPGlPe8xnXT8ltWZws=;
	b=0lSsrnI4919K5q0XTdzgF6SCRmjSYdO6g6jO67JYCtaIHZQ0ReQqdGoiYMWYjfpeneCX
	 snJkwAuS3WiCFYRSXYA70yqlzkKTrAfK3eYQJ37IL1MNaN440uHPDyMfzYJfmtFlt6Pn9
	 e8OViC7u4376kNcFisSUBFU+N5ts33+yh8I/z6OFSCaBonO+K0ts1I7tSAwX/JB1psewf
	 ELvt98WLMVrGjvAhqLLbZhwP/C9mGjZg3gTCPWfXeFjDnzhOmyqYb3w2uPiiu6RdW2xiR
	 5IQ4Zvxa6WTYfBv6FL/3m4Lhu4ZAxuO0xVS7kq8husXISO5S25+9ipbvN/0vqAYY4eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTLf7jbf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTLf7jbf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C151F0089F;
	Tue, 10 Nov 2026 01:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274132;
	bh=IEtYOXdujhhB8+1cQaXRs8HKzxPGlPe8xnXT8ltWZws=;
	h=From:To:Cc:Subject:Date;
	b=jTLf7jbfzuxloF5cTaSwe8pZjaBCwbZ93R4USukAt7gj5LR+x8+5vFJnwIYe765ed
	 9z+keyMegwIwa4qaogX+KgPPXWPgpPXd7VjVo0m57MVeZvUyyCfaFz+qVX5PLmsr0L
	 A31h+oqCzsq4991G5YVIPkBGPZIv3R4850yYOawtA99FRff86AyU0ltm8p/cbn5sA0
	 R1JveOlSvNwiXyvfSvALihPpv+v808BbU1kFmO9aRp4Pv/Xd9nRentpiR7sTFHsOLC
	 KI4rIOYGiGRujryokIp9P1GbfQNtMCYnOOTezg/eoxsuZXsoBSvl0LFbeMOEcfAL/3
	 vvTh9goe5GkUg==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:51 -0500
Message-ID: <20261109202851-failed-5.10-63a596375176@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 63a59637517682a920f86da1a189a3e639dd4fb3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202851-failed-5.10-63a596375176@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 63a59637517682a920f86da1a189a3e639dd4fb3 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Tue, 20 Oct 2026 17:53:16 +0800
Subject: [PATCH] drm/amdgpu: parse CS IBs at the BO offset their VA mapping
 starts at

For rings which parse or patch the IBs on the CPU, like JPEG and VCN,
the CS looks the IB up through its VA mapping and maps the BO, but
ignores the offset in the BO the mapping starts at. It then parses
other data than the GPU executes. On navi31, an IB of JPEG NOPs in the
second page of a BO, mapped with offset_in_bo 4096, is parsed from the
zeros in the first page and rejected:

  amdgpu 0000:03:00.0: Invalid packet [0x00000000]!

while the same IB submitted through a mapping of the whole BO works.

Add the mapping offset when locating the IB in the BO.

Fixes: 4802ce117786 ("drm/amdgpu: fix UVD/VCE VM emulation")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 74ba1d87d67d0a38d8248928241c3e1c73d0d53b)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a703268ceebaa..ac32530c1b488 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1075,7 +1075,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 		if (r)
 			return r;
 
-		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
+		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE) + m->offset;
 
 		if (ring->funcs->parse_cs) {
 			memcpy(ib->ptr, kptr, ib->length_dw * 4);
-- 
2.53.0




