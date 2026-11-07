Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048750;
	b=aQAFqI3VOsZJxTKZ3mBljbZlKHkV6ezRKR6JjjAZWjggtoL8JZFu+O/bTVt03hlTeuQz
	 0PBxij6H+DsVfpBF3sPjsxLYY0XHOYUedT1MKC0QgrWkjFH4inFHEgBjdyy7o/9xrhhsp
	 Tya9eoF2+RuWVJm9jXHvsiOdqnO66EE8/IMem75HO5ts5OBbf97f5NY8dF0XkWDEidYff
	 0fOF/6kMvbby6vyxNU5n8xEbRuv/XUW7WxUM6FFBfEWROdWYsPNs3n3vRUvDAOzfH8FDk
	 Zrb3ujZuNa2z+SCYHzi/FULoefIscgReJJ/VuM9jhLxRof2bh+PQFRadD6IwLIv7rYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jy5ldhMwfM7isMzlRMa8eGheFnDvqcpXnxXZ6o01A7A=;
	b=Vv6PxZLNNcjB+vEreazv0wK1e6Jjj2LxSu1ObxzttRq/mK7lHfO5zTWbcMAfD7vYLppa
	 NbmqT7IysQkm/cncOYJwwphbQwsEi62dD8jXuY3RUDb6Ax/bxVX5PdheSoWTQK8VyVjJF
	 pA0D2UaLBMfkm9ybqISoGDKvEkf9hGW2vNOLMsel0+KRyA6yuhXt3DWUKpRm96HU+Eo8e
	 biggXsmrIppkv1Wy3GsDp9jw02p383sd1MNExzkLhd4prSoTQsXYsLkvVpuxjAtcATIOn
	 snHpNGXeO93a1TjAIUJ80+JpBNqw+OOYDiLIF6fJ+5c70J/5pFoX2to8BDUwC0QMoOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr00fdmu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr00fdmu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDEA1F0089F;
	Sat,  7 Nov 2026 10:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048748;
	bh=Jy5ldhMwfM7isMzlRMa8eGheFnDvqcpXnxXZ6o01A7A=;
	h=From:To:Cc:Subject:Date;
	b=fr00fdmuJ9vs0ZqP86iEtkhM/bfhNNQQg3w1Y2ReV1KNDCPowBGzwPmFlGwQG1o8/
	 +9C6xQ4tBVeMP2h5vCTe2Ji1e7KYbs8ndEq+p0+sOYiLTXbKzN6oSP2+NHVI2Nqmye
	 oqMyUF+yxQRXA2xJLWMJrtB5WVfOyq/a7sZOdHWaVe6pQJdMURAfSrWdxiN4jadihg
	 Tp1jqwN7IRWOU6vJAiK+drp+5Ncvf/xlkBVYoEaz315GEupjCGy5R2RYxOmQMHO+mc
	 fGjHxw8IHGHk3nmiPZ+U0RCei5syEvRxNlbupL+RzrjKau0GLTukSVGuYiiqCAq1HQ
	 DG4IfNMO6GwnQ==
From: Sasha Levin <sashal@kernel.org>
To: elena.sakhnovitch@amd.com,
	shahzeb.ahmed@amd.com,
	manjunath.gaonkar@amd.com,
	apurv.mishra@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:26 -0500
Message-ID: <20261107055226-failed-6.1-232213c9bd7f@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 232213c9bd7f703836164f23160b76657094a7db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055226-failed-6.1-232213c9bd7f@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 232213c9bd7f703836164f23160b76657094a7db Mon Sep 17 00:00:00 2001
From: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
Date: Wed, 14 Oct 2026 14:29:35 -0400
Subject: [PATCH] drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950

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
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 85ba228f002d0..822681635a655 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2179,10 +2179,22 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
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




