Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615D2E7386;
	Tue, 23 Jun 2026 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199615; cv=none; b=nkewMgrz4YIa819gs5PW2fU+5x+9lC57KxpAF2EaePNTAtXo2js1F8Q9uHJeZa91NWkAG+JPXIHdNx2FZ8R6OdTP6eS+3WbFdqscOblbeQT+uUBsSkQaN4g5LhG1sjjbiQrvYaiV5zulglrXFnpJ/qLTucDvS2HjIWDsd98lbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199615; c=relaxed/simple;
	bh=rYSLMaaP3Nx9YwTnfketvAH5z+T8xmvNYuoC4Bw1ky0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoCpDa3uQh/pU+fhQDuYF6HynMJ1/RMxKsL70j5t2CCq55eqZFl3eYMQ6AX7WCY9A6G0mRZfD0SGsQabiv1/pnDOrGlH1W1tT/Toe2+qqHOFIB0LxT1XTA22geYOpyK8Pe0n3dh4+zEAWDkqWB+OjGF9baq3XcLM/HWAZBBrmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T8lNrf1K; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T8lNrf1K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=PN
	4+aDsAu1UBBqtMfoO95odoovyt5n75yyVL3bxa65c=; b=T8lNrf1KZXZqdURLFm
	zWhHr07bqDcLIKPHr6GPYbZ//EuGN0YCDLNSmn65lBKi4ymejiMPvXba7kv9PBKc
	dUr0hZ34i4u1HMFUdod4QnKb7XpSZJj1kjRqATMowxk2nkIz+lqCt+UwJpgdC+dh
	kdEHEiW5KWSr8IggtZruf8J7w=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHrrHvNDpqB1a6Dg--.16039S2;
	Tue, 23 Jun 2026 15:25:36 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: paul@pwsan.com,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ARM: OMAP2+: Fix a reference leak bug in omap_hwmod_fix_mpu_rt_idx()
Date: Tue, 23 Jun 2026 15:25:34 +0800
Message-Id: <20260623072534.1997680-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHrrHvNDpqB1a6Dg--.16039S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4fKF47Zw13AFW3tw4fXwb_yoWDCrX_Ww
	s2gw1kWr4rtF409w45Aanxursayw1xGrW3Ar18tFsFkrW3WF1Iyryvv3s3AFyDXF4xKrZr
	Zr4Iyr1Y9342gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNWrWUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxRBy4Go6NPBPIAAA38

omap_hwmod_fix_mpu_rt_idx() gets the first child node with
of_get_next_child(), which returns a node with its reference count
incremented. The function uses the child node to translate the MPU
runtime register resource, but never drops the reference afterwards.

Add the missing of_node_put() after of_address_to_resource().

Fixes: 1dbcb97c656e ("ARM: OMAP2+: Fix module address for modules using mpu_rt_idx")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 974107ff18b4..1d7677ca3802 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2176,6 +2176,7 @@ static void omap_hwmod_fix_mpu_rt_idx(struct omap_hwmod *oh,
 	if (error)
 		pr_err("%s: error mapping mpu_rt_idx: %i\n",
 		       __func__, error);
+	of_node_put(child);
 }
 
 /**
-- 
2.25.1

