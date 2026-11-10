Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272981;
	b=MO/209S3VGoJpyWyzJSHaw50FPJjdPXG1f2yE8GD/GeZHoZQ/oSNepeSvxi4yyHmP7wV
	 YAd6Ut3nDJuh/k7R+xroJ6N+m7niLYmf236303nr2979z7QZQkHSJZmD6TS5MCT4PpPNs
	 eJlG//9wLf662ECxD/AQXRj387FRsAWwmQLpzqb8Bzs74tl2bS194Oz4+qKGRAeYpLW5v
	 3jPpF+Oj8bAtHdtBynjCH9EhskUGHj2HbWT++Fw6e/0QlnrLSKoW5Z24nLikA7Yr/c9Hx
	 vuR5Lf4Fck8gh+Etrj0wF5K+jno6CAyGlNd4/AgaZ3GyknMsaKvlxjLT8pT6P/BgDIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272981;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fe+6Ua30rDbGGnDW/MyNrD2GWrLvb6Oi9hPCXt/4zbg=;
	b=q2xpvXFBfAGMvNPB+NfaqqQBEvPgaUKFXcl0baviM4LEiTiPzk94qWX3BH3nIO1JqXew
	 qs7JhgbwAmzBw9e0HJtdRzW7Vi276U8KiH3TS3grGxv0u+DVddCmLHs/j8u81/51bDhUB
	 5hqGvQJaQ0zl9XRQ1QupdOHZhDM/mPItUkol721YBC/yKX65edaefM1HMDGuLnQRBmWZR
	 TsRzsgMk7/F5SpreopHTa409+OYmeSwVkEozl5u2Ozw/SeUD1tPCgPe8o2XpEt6QAXYkJ
	 VmAlXTy+EmnOaFB9Q/tO7kJ/4nzSDY4fUbbvfeD5RaWBWRleUF+5AQq06njHBeRW+TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OW+HBs85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28B60A2608
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OW+HBs85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C6A1F008A1;
	Tue, 10 Nov 2026 01:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272980;
	bh=fe+6Ua30rDbGGnDW/MyNrD2GWrLvb6Oi9hPCXt/4zbg=;
	h=From:To:Cc:Subject:Date;
	b=OW+HBs85Eq1Zq4lRjleEDDwDVEbd1Oh1gyDL7zmnWiaW7RpeI05ce45uWjtbdIO8C
	 xwbavSKjXJm6MljvCnujW2lAN0Byi4WSMpMjl5vfFY/vDf9RdXQAIc7Q9sJV/ACt2q
	 V1up5CbI3hW2jzASR2kQIHZRIhn0E+lqoc4PRzTFAFKzydsk9FHaRoBPBJNzZCSVMb
	 +Nj8LwukZSIRT6yfUODslCrPpIhw0py3htafvog93/CDOEpvfpCwoVr2ZuRuORSjS0
	 O0Jfvc70uD8uS/HnkFbT3rwLkdMyLkJlopiS+vTgS6rgjA++Asz4/bkpwsuNKmsnuJ
	 jDtpHzRieXQ/A==
From: Sasha Levin <sashal@kernel.org>
To: bas@basnieuwenhuizen.nl,
	faith.ekstrand@collabora.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: Check cs flags." failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:38 -0500
Message-ID: <20261109200938-failed-6.12-f5ea64f9fcd9@kernel.org>
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
git cherry-pick -x f5ea64f9fcd921bc4e2307a262e19450b8a58524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200938-failed-6.12-f5ea64f9fcd9@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




