Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BB4E1C75;
	Thu, 17 Sep 2026 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648852; cv=none; b=XlA0lqN2EzD6EhZg4qNcwZHpC6WCCm7A17LOPbdw2l3GoS+7Y9rcv3nfgc52vd7qYBndwa9oCCEkUauYbdWMJF0yljk2hQrYE7vwcLAZ6FYNHeeMqUvHNx4CNJFmfbbhh7kMiFzxK8N/d0UuhXzfq48cycP9hq8qQ4dOBVT9P60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648852; c=relaxed/simple;
	bh=aDWobUv2c6xGAnov2tgotjh2pxQ6OIF/tqyaPJWh6/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TUUWec7VnCieSSwB8WPPuDJ/U4sq4iDwhm4QHcUzJOybKsAwkmPs/O+ElZukE7UpKsiJsx9/kgu7CO9BVBBRXMQW58hEs6ql1TJZu+uivJauuVqsdyaa4YXdtOHQEdEpuKdbD4SoI8bQQ5DoD0GCpGfTIsvT0V9KA7O+J9o1HYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHsTvH36tq6LaACA--.2796S2;
	Thu, 17 Sep 2026 20:40:39 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	maz@kernel.org,
	robh@kernel.org,
	robin.murphy@arm.com,
	saravanak@kernel.org,
	will@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: Fix phandle_node reference leak in of_map_id()
Date: Thu, 17 Sep 2026 12:40:39 +0000
Message-Id: <20260917124039.2151588-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHsTvH36tq6LaACA--.2796S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF47Ww48Cr1kCFW7Aw47urg_yoW3Crb_Gw
	n2qF97J340kFyv9r1aqr15Zr9Yk3W8WrykC3s2ga9xtFyaqFy3XrWrZ3s5GrnrWrWfuFyU
	Jr1DAryrCFnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUNA2qrq02m3AAAsP

of_find_node_by_phandle() returns a node with an elevated reference
count. When the caller passes target == NULL it only wants the
translated ID, so that reference is never handed over and must be
dropped before returning success.

Fixes: 987068fcbdb7 ("of/irq: Break out msi-map lookup (again)")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index a650c91897cc..0f548d103037 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2201,6 +2201,8 @@ int of_map_id(const struct device_node *np, u32 id,
 
 			if (*target != phandle_node)
 				continue;
+		} else {
+			of_node_put(phandle_node);
 		}
 
 		if (id_out)
-- 
2.34.1

