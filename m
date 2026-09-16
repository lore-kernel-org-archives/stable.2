Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCE449992;
	Wed, 16 Sep 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543951; cv=none; b=Xd/3GyV43BIMwQcgRFlbxW1qG1wM3Tn3MD2TBEOn6MOGHWmuFyyD3OYrYjEpl5hda+yZV0e9JcsDoyKDPA92cK/O4u/lZX9fCT09cGAt/lih/W5LImpCN9AblkgCnTw0o2FUepqr5m9isqYaXPKIDyInUA4QNUecIrs3wHqhLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543951; c=relaxed/simple;
	bh=v8XXk5oGrKrMCLDA3aWzPxnvnCTJ9uQJ6ePapJ9HMjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PQeWVN3IRoEAPQu9nhoAgFuaQS5vqaIjWBG4PbDnTUl2EzuPgmKmkvI0q9vf7oMJj5ZP1NFJbcX6Zj5RXVvkbOUhn0AySSmRmaFMam8L6FuSpu5UXzQRkLrKuWQD+XhUoLak0PK1MDo7Ilt0cMRMnw3e++vYYPRL3zXXhJ3i2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXmjj0RapqjirfBw--.59973S2;
	Wed, 16 Sep 2026 15:32:04 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	sen@ti.com,
	tiwai@suse.com,
	zonque@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in __davinci_mcasp_set_clkdiv()
Date: Wed, 16 Sep 2026 07:31:36 +0000
Message-Id: <20260916073136.1971673-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXmjj0RapqjirfBw--.59973S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrW5JFWUtF1fuFyfXFW5KFg_yoWDJwc_t3
	WrG398XFW5GF13uFWDtayFvF1vgr9rW3WI9rnYqr4fJry0yFsYk343Ja9xZr1UWayrXw1F
	qr1jvF15ZryS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUCNtxUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2qqPpQfYAABse

In __davinci_mcasp_set_clkdiv(), pm_runtime_get_sync() is called at the
entry of the function. If an invalid div_id is provided, the function
hits the default switch case and directly returns -EINVAL without calling
pm_runtime_put(), resulting in a runtime PM reference leak.

Add pm_runtime_put() in the default case before returning -EINVAL.

Fixes: 4ed8c9b737b6 ("ASoC: McASP: add support for clock dividers")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/ti/davinci-mcasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index f229f847eaf4..1ec42fe02fc8 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -786,6 +786,7 @@ static int __davinci_mcasp_set_clkdiv(struct davinci_mcasp *mcasp, int div_id,
 		break;
 
 	default:
+		pm_runtime_put(mcasp->dev);
 		return -EINVAL;
 	}
 
-- 
2.34.1

