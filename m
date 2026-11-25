Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645483;
	b=Xm2qt1NiMUpsDIfgKAbq+Bm9gMd4F2tqqdt/Q90L6wtfa/IguKEcobKiHLhh9EC9RP0c
	 GESUnaWUIjaOuQCBMgTdrEkdPTMolC9Nrm8M42KeUoHa/MOt0A+GSgEzej3KOFumNFOLC
	 witHbhS5w7u+iflqTaH4E6ubb9jc6odhEjFrbxzEuXN54OQbg6JE/NJhbfKH9P5TZYUG3
	 9oaSGuqjWSedxTssZI7P3QnHRnClQyffuNBFUvQLXOez/HA0m72vx6yc5+AeIoh3LGFqS
	 mTo9XhMO0EEx0OiLhiaJnA1LyjbYcqIdgrhY17KuQ3g0iNHJWACPJDob8JMkx9ShyyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jDuBt5Cw+ANUexZtA4dNwo8xhQaNML2KuCiDPiA1qKE=;
	b=smdgZscbFeEjMRrWl45h+s5aReCuh5gV1GKIa1bTKbW8ahhm7kcTpyTArJqSvWwnNcmz
	 C4brzkgrPqt34lVL/Ytmg3SnGKo+8wBqO6uGkY4RBULVGwUp5qzSnuGEBoIwryjeZv2V3
	 UM0ji9fVHviOMatQPoCPsqSuP9pjbXuWa2pbfUeVlbs7Ru9/MiLdDCDI/wtLU/K3qUNyy
	 xeLvzot7au+gjyFGCSkEvO8iWhECGjxWKvjwoTxRjlw5KIX8rzPoD/jiTSB25yX8t56jm
	 lU1BKpHXvTgR3DyEz6AVRiLg8v+0PpnlNW1GJmUTy8qrf77NWfJkqnehJUZwyZh5OxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JXRLJNAt;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A4606A69A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 230A4606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JXRLJNAt
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3846d5f54c1so7335661eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645482; x=1796250282; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jDuBt5Cw+ANUexZtA4dNwo8xhQaNML2KuCiDPiA1qKE=;
        b=JXRLJNAtqY2xrrTdJrj1OwqP8qcbbDOO/xgOwggr4RT/JkRo7IusUASaRTFh+44RR7
         6ti/rmoDIQtVOlH6Rnyc/zrJ0NOi88npY2ptZpdREQQrMhjNe+XisDkcxNWjNYVcsaDn
         PeO0ABd2Qk2g5u0QB4T2RqGnFntRv+fNKY7b5R5fy+3HlisMC/d5yizhHs/5LMLe3vF8
         29lS3FyHAN8/d0+LBtNBvuaAPYzu/fv09ZtO5X07hzvTCJ2QYxtTRVQYMonbjesh+xE+
         oyjb0w8wV4MtzSPUsWuzGS1/lIWvH1IFXZEHfpDnR95A9mL+w9HWkD47zWmgruRR9aRm
         fDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645482; x=1796250282;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDuBt5Cw+ANUexZtA4dNwo8xhQaNML2KuCiDPiA1qKE=;
        b=JC32OLO9RofVXb+Bdu/fHxscE3N5KdatSoJgd19upJioOT7sRX6lGQzEW1nGsl9IVk
         f6sZ5VKN3ilyiFDywJia3jibUhpoxFDnxAPzwIfXz0qWvffoCUvt4jKRNMeCioRUggiW
         1fAkGg9AUIyjzZr62DjpeX7e6TkCGr+HaRQY3NFVt9FW0HhxmPKY/edIu7JJzqO5BgoK
         y4n/7vaFswVMU3tC0G0E6q2fEQXbuSQVx0le5FowFkMuIKtP7wnWHsgTkC4Bu5qrLb59
         e2nUiIG9f8FnqjLI7ymg0FT6A8bQgGyVcfplFdrJ110vVYI0RK8gX/rDQT/1f59mvS3u
         8dRw==
X-Forwarded-Encrypted: i=1; AL+hErFlc2N8Gr7/fhW6ASOFsE8J5+DH4s2ar/yW8EjrTcNqNvlzww/lu+Etvk+uyhCzJuhjewqL+cI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UzioSHZ+sqaY75j75qwtBmBDa9cSeRNsu0qWA1krUzFkvTFDN
	qr0DyPY2PU1CIFUuds026EhhEffUCHdzxUYI9AgKi13pDJiAhO5So4SJd0OzewvkE4P3TWdC+Ef
	YMg==
X-Received: from dycuf5.prod.google.com ([2002:a05:7300:105:b0:386:9be5:2d95])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:638d:20b0:375:c862:31c
 with SMTP id 5a478bee46e88-38571816d35mr18955075eec.40.1795645482015; Wed, 25
 Nov 2026 14:24:42 -0800 (PST)
Date: Wed, 25 Nov 2026 22:24:33 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222433.1442338-1-elkin@google.com>
Subject: [PATCH] iommu/arm-smmu: Fix use-after-free in nvidia_smmu_impl_init()
From: Elkin Cruz <elkin@google.com>
To: Thierry Reding <thierry.reding@kernel.org>, Will Deacon <will@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Krishna Reddy <vdumpa@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In nvidia_smmu_impl_init(), smmu is reallocated with devm_krealloc() to
embed it within struct nvidia_smmu. When devm_krealloc() moves the
allocation, the old smmu pointer is freed, leaving nvidia_smmu->bases[0]
dereferencing the invalid pointer.

Read base from nvidia_smmu->smmu.base instead of the stale smmu pointer.

Fixes: af9da91493e5 ("iommu/arm-smmu: Use new devm_krealloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 2fce4f6d4e1b..a3884966dc29 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -319,7 +319,7 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 		return ERR_CAST(nvidia_smmu->mc);
 
 	/* Instance 0 is ioremapped by arm-smmu.c. */
-	nvidia_smmu->bases[0] = smmu->base;
+	nvidia_smmu->bases[0] = nvidia_smmu->smmu.base;
 	nvidia_smmu->num_instances++;
 
 	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
-- 
2.56.1.839.g22a8290db9-goog

