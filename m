Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02A4D0CE1;
	Thu, 17 Sep 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649230; cv=none; b=qw4sJXkTtCb/3N4dJuoYibv/f80bTWAy3L8QOLBIJ9N5+ctnFNAqOnbk0P4r+wVi1vFjxRldyQeCASAaX9aWZLorRYW02hnAvAxn9gPrB0113K1Np8u8NoLACcXaQwULU6XGRDfL2QLUZ+zzNHlk2TAd30YW6niYHTsXUT24jQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649230; c=relaxed/simple;
	bh=62WRxwQae42z9n6SQ2uBqamJn+Rw8Ji0Bi2NI9NBb1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=alQJvkE3YonB3BF0u8TkjCMTnLqEFu0xO/LPtiUf/MRtGmaL4C4nOtzYd7+DT3Y2u5ChStOVlD49ihreTccf74tV8aOMxOnN1I0beNiGezWpML4sPabzMeGmePMz4G8iAyKhB2tmPoJxPYH8HEU6qJ9dTxWGuPYi4pqaXX8Ur/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oDo94atqs86ACA--.2858S2;
	Thu, 17 Sep 2026 20:46:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_bus_3cell_ranges()
Date: Thu, 17 Sep 2026 12:46:53 +0000
Message-Id: <20260917124653.2151894-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oDo94atqs86ACA--.2858S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyDtr4rWFW5Wr4rKF1DGFg_yoW3ZFb_WF
	9293ZrWF1rCF40g343Ar13Zr9F9a4UWrWkAr1qyasxCayjvr17Xr1I9r95Jw1rAF4Y93sr
	A3yqgr18trnrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jngAwUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwENA2qrrRmfPwAAsd

of_range_parser_init() can fail when the node lacks a ranges property.
That error path returns without dropping the reference taken by
of_find_node_by_path(). Add the missing of_node_put().

Fixes: 3d5089c4263d ("of/address: Add support for 3 address cell bus")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 226debdaa5c1..e8257aff17b3 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1350,6 +1350,7 @@ static void __init of_unittest_bus_3cell_ranges(void)
 
 	if (of_range_parser_init(&parser, np)) {
 		pr_err("missing ranges property\n");
+		of_node_put(np);
 		return;
 	}
 
-- 
2.34.1

