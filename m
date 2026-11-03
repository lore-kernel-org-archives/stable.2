Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702549;
	b=CVxDmGS9Ajyv8GSU19gJ0+7aA07Lj3P7/19xVaPZvL5ib3owiI20P8gRhpQjzBlFSuhs
	 m++TdQ7iOuOTSNiUPVoif/uYi/3e7k2gnoS9HyYnZ72g4R8G4D5ijjadrnHN2D04PE1n+
	 6sjU/2hbiiLUrnCgx9t0y4/YL3vqS1ZhZLiLFChnVlqLY84LRJPmSESbfEVijMi0erwBg
	 l23AYjl0kK3hqvB3b0rXMs8ELzrHsoTJ7Wg0o0WWwx8XSokKugFnZ5uXRNpw5VSQQpb7k
	 PrC5NcyRdperf5FWm3UeocV5/1NtjIBmM0G0IAhyBkue2c8ElrQx5PX3Ow+3+cIjF+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702549;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=d7jU0eXCbkNhSLkTaZJUyYuvXfwJizUYTCCD6ZuG3PE=;
	b=JXxUshubDpAor6uQQF31M3tKHUi2mQ5SLyPdZz6pJTaIsefMiVcTtz2sgmYZZpO7+WzA
	 jWXgIy4U7tT95lKpBr2Pf1SMNS89yD1pZS83eqIJ6IEpyT2sCOUdnScUqBWNv1f+tyh8k
	 r5Lp+HkSm81R4vVX3XXDOIyoYBD+JBIhRUUYTM/DzIERbKiVrcoGi+2kLc8MG6tAfvHXh
	 CUT0+aYenAWc1afUkAhfnaWUuGa8ItExMdLkdM18zaqs8dhTV8P0GJZTjc/R3r+b4/2Vq
	 w+TExfehltJUWSzNnRAS1SmFJhmZ7dvV62WWx/1IbO8am5cSRTDAMmzbRkcK2Q04VXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833F606EDA5;
	Tue,  3 Nov 2026 10:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0833F606EDA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXaJmRuulqZsg7AA--.2863S2;
	Tue, 03 Nov 2026 18:42:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: fix node leak in of_dma_get_max_cpu_address test
Date: Tue,  3 Nov 2026 10:42:34 +0000
Message-Id: <20261103104234.1373570-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowABXaJmRuulqZsg7AA--.2863S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyxXr18Zw1kXw4rKrW8Crg_yoWkJFX_WF
	9rZr9xGrWkCF1DWw1fXr13ZFnIva4jqr4kWr1jyr9a939ayF17Jr1S9wn5Awn8Zw4avF9x
	Kw1Du3409rnrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j
	6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUrv
	38UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggAA2rpnIR9AwADsr

of_find_node_by_path() returns a device_node with its reference count
incremented. of_unittest_dma_get_max_cpu_address() passes the node to
of_dma_get_max_cpu_address(), which does not consume the reference, and
then returns without dropping it.

Release the reference after the check.

Fixes: 07d13a1d6120 ("of: unittest: Add test for of_dma_get_max_cpu_address()")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index d2f5c7ef3178..8133c954d335 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1145,6 +1145,7 @@ static void __init of_unittest_dma_get_max_cpu_address(void)
 	unittest(cpu_addr == 0x4fffffff,
 		 "of_dma_get_max_cpu_address: wrong CPU addr %pad (expecting %x)\n",
 		 &cpu_addr, 0x4fffffff);
+	of_node_put(np);
 }
 
 static void __init of_unittest_dma_ranges_one(const char *path,
-- 
2.34.1

