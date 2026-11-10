Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341400;
	b=gCq+x8fU1Un2YAhdoqkEjFaolcZEYJF9DLWDVNliooaflCZuJ5N1huKspaXYgnBUs/V4
	 LummVWmPXUhn5UstdNcgvxgSuM+wx5spQWNDKq2gyE+51sa7SvoWG3wejrG3+mBy04aUc
	 mPpf3VMlvgTNb1bTEfbeApmokTKXMv5HptASGK6WfAJvL3byz6TIPgZnxJxF4rVJIHTcm
	 jp32uaoxO7PwCYInYKyGWdo09w18v9AYwsArFTVlHjvT15Z0UjTabIpg/u+f1zYrnv/HS
	 g9qOEKPRa5uihgMw5PnRAcjXl2/BVWp7TPe7bueWo2liB93TzaXQ/ByhYKTuFZckh9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rPRbfT02rWKy1hoOpx3LKdUHCEc2ph2DMo7BnEwxFLo=;
	b=gvyJNQhWGftbiE+UeTCR1sMOCvoLXfAiTQzZ7pu8DnuGIBEZLURiDp8EKJNmBgpwiYjX
	 guSL+MbNIo8ExbUnh7s1wUIyw/wK4DiJvwptHaBUYdspFC+BJrsMZMgiuKd7RZH12iC1x
	 3dx643iA9dT2BIq8knCTbsjWUUETImy++UGhcZvVdJudKPW6fCas7lLf9wRjdOC3vHYqp
	 rlDVG3FQeG27dWzR/0gxecw9Ucf2wOipOEcORnn9V8jRFF/3h6fbVoVjJuGyHJSFbWSXn
	 QGzsP4lHdne9YHlokHH6HIX84npr6gB4VFB2q4WMN0Hsd62vyCAnmB++Y7SFxAhLhSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ+1ANpt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ+1ANpt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556B61F008A1;
	Tue, 10 Nov 2026 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341400;
	bh=rPRbfT02rWKy1hoOpx3LKdUHCEc2ph2DMo7BnEwxFLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kQ+1ANpt1aZBTYlEFad0sKWqMFbhX9VVNuwp3b5CKVgk1vjmD4paBRmKGbzu9UFZo
	 9pHHs2ohr/2lT2UD8Y4KWjoEqnZztTgpnHvAlHuTeyZrSUQi4a+mB7hAafL6MiF/0L
	 n7NtRwax32CLGB5jdVqkuJMVsP7FPsX15iAzVjZSWZZ+ImuQO0eM66Y7x9mew6l4Ff
	 w1d3sOlielyYhOt/PHkFF/QNIn2w46VuQUAfW3CDs0I1mdCPSYEd6zJyuolbUEfez2
	 v7pB/bXg3b2Y3g9UxHhR9iZyEm0nre0bJQDmQd0XxkPvHF6EoAkVn3EV4mVRY6Fnyo
	 rfjS6unDzaaCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>,
	Shahzeb Ahmed <shahzeb.ahmed@amd.com>,
	Manjunath Gaonkar <Manjunath.Gaonkar@amd.com>,
	Apurv Mishra <apurv.mishra@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950
Date: Tue, 10 Nov 2026 15:09:55 -0500
Message-ID: <20261110200933.3702189-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110200933.3702189-1-sashal@kernel.org>
References: <20261107052447-failed-6.12-232213c9bd7f@kernel.org>
 <20261110200933.3702189-1-sashal@kernel.org>
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

From: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>

[ Upstream commit 232213c9bd7f703836164f23160b76657094a7db ]

Add extra type-2 TLB flush for GC 9.5.0, similar race condition was
observed as Vega20+XGMI. Add to GC 9.4.3 and 9.4.4 too, as they share
the same multi-XCD TLB topology.

Reported-by: Shahzeb Ahmed <shahzeb.ahmed@amd.com>
Reported-by: Manjunath Gaonkar <Manjunath.Gaonkar@amd.com>
Signed-off-by: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
Reviewed-by: Apurv Mishra <apurv.mishra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 138cfb165ae6aa98c0767b431e718d1a8199db28)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c095a1489bd80..06e4b393d1ce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2324,10 +2324,22 @@ static int gmc_v9_0_hw_init(void *handle)
 	 * (type 2), which flushes both. Due to a race condition with
 	 * concurrent memory accesses using the same TLB cache line, we still
 	 * need a second TLB flush after this.
+	 *
+	 * GC 9.4.3, 9.4.4 and 9.5.0 hit a similar race.
 	 */
-	adev->gmc.flush_tlb_needs_extra_type_2 =
-		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) &&
-		adev->gmc.xgmi.num_physical_nodes;
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 0):
+		adev->gmc.flush_tlb_needs_extra_type_2 =
+			adev->gmc.xgmi.num_physical_nodes;
+		break;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		adev->gmc.flush_tlb_needs_extra_type_2 = true;
+		break;
+	default:
+		break;
+	}
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
-- 
2.53.0

