Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274111;
	b=YYcbEQI6OrHyxJdRZmRDN1G+xKHItmzlRGgPNYqKSJQ/FB1cIn0YTZgA9negbz+fUEZk
	 8f5LcztMSxIQIOxRnsgM246b5dKjbVp0hFzo94+F9oOFN/D1aGGaTbERfSex0PUin1jdN
	 BINjHGZbImejUfc1X7MxI5SehiD1xoT72PkcFa6JZ34G2xLUffxGJaqeG7qCFz85+DzaF
	 XXj98pHvcHta7crxcIcKwVrEAgOyD6+tgz8j9YTtMVFadVa0onakwnqcYSO7o3gCrK5RO
	 5Fgu8xvC4FPo80glZcU+AHW0k6BrkhY1rnKmF/kAphZXV5KU9KoxqyURGg1KL7gR9HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274111;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3au2LnEfWPfil15IZtHNRThsNHjZYck9PX/cNkUQZW0=;
	b=OIrO+dbEJGDskNcTl6/IxdHv5Agr1L9MTA0y1dYArQHYyJ2ywL8TAmgjHPwXQ7P/N0Or
	 nu7jTew3e/old29i/nyCZ2HC9W0vtRnGPog1X4cSREweGKGqoqcrGj325g8UdVC/79n7r
	 cQE9sq2o1OtLXYNFTkCSqMg+vf6NuSCmoI5ceETQe7WpxaD5J2cD4SewzmzL3WkoJhoXR
	 Iai0K1x26AJbdhL+byZhbpz2KxVllhFpsLk27O+0dFH6R2jG1LFqShSeNj76wKAd/tGTN
	 kl/XBHZztQux3W2tmPYdT4RIhiKNLbT+hJLXrEg98d17Tt8GAxJr/Qtx2yagh8mIm3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvQlqxN1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC83606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvQlqxN1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FFC1F0089F;
	Tue, 10 Nov 2026 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274110;
	bh=3au2LnEfWPfil15IZtHNRThsNHjZYck9PX/cNkUQZW0=;
	h=From:To:Cc:Subject:Date;
	b=AvQlqxN1nEXC5IQUwR+0agKGybSGC2WHnJl/sbJ9afbs98ir6N7lkwa/6s9CurW4M
	 eJfLXp7tzf9MvslJVP4l31VOleIvY4YW5PpNMuN1nFmCF+FBPPbA0YXBD4xSftn6Ok
	 oZ5chyz/NQPgTirG55aaBXh7kqcJ34oAWdMDP/6JciaZ1jiY8k7GoascFhCAp75gF/
	 2bDuPCiKWHcklTkwxIPnkxCDUFUJJfPOCdEnV925wy6u2D9K/Rrf9S4pXILStKFvPA
	 YMeM7geFZIoRFbDNcWTFkv2v8COX7xzKUcgfMCCm4xwlzqXRAl2mzOLosSTlgCjlQ0
	 I8MeaoWt7Da3w==
From: Sasha Levin <sashal@kernel.org>
To: bas@basnieuwenhuizen.nl,
	faith.ekstrand@collabora.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: Check cs flags." failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:29 -0500
Message-ID: <20261109202829-failed-5.10-f5ea64f9fcd9@kernel.org>
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
git cherry-pick -x f5ea64f9fcd921bc4e2307a262e19450b8a58524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202829-failed-5.10-f5ea64f9fcd9@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f5ea64f9fcd921bc4e2307a262e19450b8a58524 Mon Sep 17 00:00:00 2001
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Thu, 22 Oct 2026 01:30:54 +0100
Subject: [PATCH] drm/amdgpu: Check cs flags.

Had no validation before. libdrm_amdgpu memsets this, even
for the raw/raw2 functions.

We have a lot of functions touching the ioctl struct, no
strong opinion on where this is placed, but I thought
early would be good.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4d01e15e76358f60ef6734462d2b6d9972b9dfbc)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d69018a14d96d..a703268ceebaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -189,6 +189,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	int ret;
 	int i;
 
+	if (cs->in.flags)
+		return -EINVAL;
+
 	chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
 					cs->in.num_chunks,
 					sizeof(uint64_t));
-- 
2.53.0




