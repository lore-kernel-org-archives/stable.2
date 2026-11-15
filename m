Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756385;
	b=WyzAyelgq7kbixq82hgDBuhp4+p9v5MuDqKr+Kq0bbKY11xN7tV54nvxU8WLqt/KmOOa
	 gOJqI1Ki/LywaR8g5W+ISiIhXiL1wG5aJwfNoFM1TxpmLdmSBKS8250RYQSm0eTLp9UUJ
	 HAHBV0Q6LUZahqGFpRS8N/s7GOCjVzMjlvqhmq7XrdnR0NYI7ubh7/KMduSvh3n1ay+iz
	 h1cYgkkq4i3ISxNiErwMZYGdwJFkmGKGWYC2N062NGux8WPtjLfyXxlpP4qyToCRmZjYp
	 HiLDd89AHFI/mWqZ4SlGYlGJAlXt9B+5FUj0Y8IUzagPnOiNqF6cVVFhB+yNJik23Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qY5qUBPjBxKClY1aZRWh6X4+uPR1qaEFbrL+tBFy6VY=;
	b=RSzS/vQ9z2QuGjHsBHw145NSCN/7fE1+cPI5kECp6knD7m+0wp0WBHMDrHTkOKE/WWn1
	 ajh8dq7KS0qTjX2wVYEdGDk+uLsTQIAzwLd+/9wpO8LqJsBVrrs/pNyLriROerXM/2wQg
	 uUW1CYr72Hel9H/OFy43M7rtK33ZXuVeAraqrjoBCZhQJJbpyRjQt66PBr/rqikGSzddg
	 RipUw81sSRvASAM2BIALNE772K5/oSONzsTCWeLu/X7TdmWUHX8rcVrl5i7Jad1aub+t2
	 DvDwbjq67ueDajYEa1gs2OfRLazy+mmoqEobgB9mU8CZAXGEN0zblm2LWpPC2xqhnXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE6qGEU9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8F606A33B
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE6qGEU9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C91E1F000C4;
	Sun, 15 Nov 2026 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756384;
	bh=qY5qUBPjBxKClY1aZRWh6X4+uPR1qaEFbrL+tBFy6VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EE6qGEU9afBqjTEvCg36y+49odRERdcp7MFBQkJWJn3h0XHHWjgiWDVDlW+ZsB+IV
	 yNpzctip6cdZ3OOs1nAuZQZdu4FXi03mvsbY4Io54zrBZAL7fbBUrgfre4Hq4a9QT4
	 YJcjwiNZqrrinP+FMrnGc6A+vvk1TeocqTFe14pG579Kl7gneBKSOgXJ4BqZZl/pFR
	 ciHu0+oSFI4Gk8PbW9WYhfhzliGFhs/Bol/QGatY7shwZeGDq+bvXLIpJStDvXsb0c
	 9ntEOJxxXmzB0MDjwSMysEBoRvDLzNHNG5ii3Xo7S05bsPuv1ELCtaCrfBEwCrTKbs
	 71mIpedyni2dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: Check cs flags.
Date: Sun, 15 Nov 2026 10:26:22 -0500
Message-ID: <20261115152527.1436957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201357-failed-6.6-f5ea64f9fcd9@kernel.org>
References: <20261109201357-failed-6.6-f5ea64f9fcd9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

[ Upstream commit f5ea64f9fcd921bc4e2307a262e19450b8a58524 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 99de46eda59be..3019a5b393b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -208,6 +208,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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

