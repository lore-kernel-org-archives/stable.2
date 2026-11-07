Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047089;
	b=FAmo0Qu5PSOfQsTX7HDro0/5ACqUm9JM/C447j9ttNHSgvn068okURHh0oDBuVOXA9b+
	 nstNJMLgyqTpIsul/eOb4MyrXW88SXD7uZyk40RGOMLMTggPVOSFU7leBGtfvEN+e2/y8
	 Y5HGerBHCN/xVZdff9cBl/jj1CPJCKQUpajWEWiOGrwwhrBjSencPLH2A2p6d4DLPpUe1
	 7TuPaOwunFsJiPGFBd1Q8+YA5ErqneV5d/JeYTG2+xy6uX37zx9Ew5YPmOZ3EV8Hs2liM
	 hGX52B3DgG/Lq3hlbGW3PasxQ6jJimzaOjEM5JAkgojvqR5R/YTFFhsTiFvfAL8T+Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y1EzmIODiir9Sr8PQajFXErtSswgNn6i61zKs3l9YlY=;
	b=NgMTH7syLxvDbb5vzLsuGvrW6/ksLLOdKqLSGl/3Q+jhL/b/sv5b4s0sRJiyrFTw2tQM
	 eKEJCyw5IeaSgKXr5Gos0uCPgoUoo1R51UYKHmzWrC2cTp/5C2IibRD+Jmh4x6La+6J6o
	 8zpCekIvFirYGW2HbqgVkvQy5YtYxHWHdczg9QivcSsKPkbqG9wGuhmVAma/mD/kEeWy3
	 GwdCCLr+d4g0aKEPVzhL7Bz9a0htmjCBtsZR9+s/1jz2aGdPCR9CQr45Zdh7zLMkJsRCd
	 /BoelfDDQOkyu3NlRPHm33/qfrhTAf7EKTC12Ng0CNDTX34WFMZRf/EeE74lSj3s1XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqXIkZFQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D2E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqXIkZFQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BAC1F0089F;
	Sat,  7 Nov 2026 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047089;
	bh=Y1EzmIODiir9Sr8PQajFXErtSswgNn6i61zKs3l9YlY=;
	h=From:To:Cc:Subject:Date;
	b=JqXIkZFQ3qEl8S90rZWFgJTZtdzL2q1pp79CWQK7t76NGbNOJXkSXfChf7PL21jQO
	 OYnhhXZV4fonrKUuC5bZePcKTr1s93RTxWJ+UTQNI5SSP0gb6rWHm0P9N72jy56nAo
	 1RQ9T20urMUpcZiLlSl1EDOmnguBkZR/2I25AffqgXtVOmWeeFk30N/44gwtH7OzSD
	 nhSib1AYCXmiutxE3vvn2wy88feaPMzgVy2jGctHaABDNoNHSJzLBzjGQhK0ogu6nK
	 oaz6LpDnIISIwJiVp08i4+UO/4GXeAhFASYNHF91M17iqv+askz7Wm1kYTbjiK+rUz
	 VZK5OUUVo76Ww==
From: Sasha Levin <sashal@kernel.org>
To: elena.sakhnovitch@amd.com,
	shahzeb.ahmed@amd.com,
	manjunath.gaonkar@amd.com,
	apurv.mishra@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:47 -0500
Message-ID: <20261107052447-failed-6.12-232213c9bd7f@kernel.org>
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
git cherry-pick -x 232213c9bd7f703836164f23160b76657094a7db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052447-failed-6.12-232213c9bd7f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




