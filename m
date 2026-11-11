Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399804;
	b=Dln2p6s6uf1ImE3BCNqsxSUL4tBxGFVcsUBPOq2XFmDUAnmPdEo6T14bOI4dsy/5Kn3e
	 3NTfibkfWcqixBoYjF4BNJaPbIwNSDb3nSl+ecXiOlDNlLPX9eqCx3ztFqyERr1SZW/cz
	 QwtmrCVjJp3tzR0AmD59JBGof7+hBp6JVithc/475jWjEeJ4rETpR+8hV37ZaQXcBP2Gk
	 0JHwu/rLavikU9jt4nhJxYMfnw8R7KeklIYGdutlK5+E+Juuq+PSWBStbSIG9QwxvIT/l
	 d70qcSbmmbTLVYD0gVjyRqR4MObqv+wpwE692WX0WwtlsvKrLD5IMESre4nmUBis1fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399804;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=5ft7sNkyBnZQKcl8yjWTxI0pp9pDYp7fOU712sGAOFU=;
	b=KvZA7dPPVvNeX0/W3/DHEP6CgS6rBgrvKWlIEpK8ciAuUK1+pXG6YMQLcyO+Dd6G3KCu
	 449iKOHRGkaq79nbr5J/oW8g7QTO7UpfJXGwUoHCD/OV2bBF4ha6IC3VsFnCgSaSrMYH5
	 Jl7xIHQl9WX8imW59twZlQCfzriYkAn08jXV1W3tCz2nfG3msodn2US0Nq7y3Q3vhv65z
	 fSH161cirIpIM+HUQzOFijnI3Q9uTsBA8V1Jv+t0mzfxVzrG3TZ+PjN4iJH7KH6uYpIGI
	 Wg4rp3x5/f1QGE/AWKtvXNvOwHzO0veC3AjOGYZUOJC5UvPGbLxiEDriVRcZAahuL6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=O3btiuwd;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6460A2621;
	Wed, 11 Nov 2026 12:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03B6460A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=O3btiuwd
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54502a177;
	Wed, 11 Nov 2026 20:23:18 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] perf: starfive: Fix potential per-CPU memory leak on probe failure
Date: Wed, 11 Nov 2026 20:23:16 +0800
Message-ID: <20261111-e5624093d6-perf-starfive@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa1ca90038103a1kunmb074d2a81b3671
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQk0eVk9NGklKTxkaTh1MSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=O3btiuwd6QfNJ9dRzz2jF7iTYo/iKofY+oPbwVvUqzAwaleCEdUZPcWPV6lKlgN1exIdLvoi5ReLhmk/m9UICfXnqSE9YifETztp9x8aQw0H8NgcIz77vHflnsobErL7R+ytS+WnaVxS3p6e+SaTtaSwcqMi0bjW5j3KxSfnx+s=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=5ft7sNkyBnZQKcl8yjWTxI0pp9pDYp7fOU712sGAOFU=;
	h=date:mime-version:subject:message-id:from;

The per-CPU hardware events remain allocated when a later probe step
fails, although the device-managed PMU structure is released.

Allocate the events with devm_alloc_percpu() so failed probing releases
them after the interrupt handlers have been removed.

This issue was found by our static analysis tool under development.

Fixes: c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/perf/starfive_starlink_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
index d9843645554b..25d57b904028 100644
--- a/drivers/perf/starfive_starlink_pmu.c
+++ b/drivers/perf/starfive_starlink_pmu.c
@@ -519,8 +519,8 @@ static int starlink_pmu_probe(struct platform_device *pdev)
 	if (IS_ERR(starlink_pmu->pmu_base))
 		return PTR_ERR(starlink_pmu->pmu_base);
 
-	starlink_pmu->hw_events = alloc_percpu_gfp(struct starlink_hw_events,
-						   GFP_KERNEL);
+	starlink_pmu->hw_events = devm_alloc_percpu(&pdev->dev,
+						    struct starlink_hw_events);
 	if (!starlink_pmu->hw_events) {
 		dev_err(&pdev->dev, "Failed to allocate per-cpu PMU data\n");
 		return -ENOMEM;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
