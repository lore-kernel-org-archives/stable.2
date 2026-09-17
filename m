Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B74FECFF;
	Thu, 17 Sep 2026 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648667; cv=none; b=rHcDORqAD4COHNFo7oW4ZVhwweVsZ4W9JkTXQoKFvSRzEX/uVmSls/19eOuiy2CYh7gHC4Sgt0lCKcAjfthJgF4e9NJn6eVI+mC8tOs8A2BDSSnyLVHrbqMNsgtJwLG4TpAv0IS0bDJXHIXM4q/uW/OeOoZ9A9ogH1K0uWb+ggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648667; c=relaxed/simple;
	bh=WZrUZBuBNeDKUGvKvqBtw3kK94Y/3aLJjqsDXnl8Kk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ukl49hrBjVJOjm7sqJc6IBqWQWb0BG1r/sOAMx84ekJcpTfaCwGTiYV5Dt+Ygvg4sYchAk4n9lpWf3KuwAUwQmUJKO0wGY/8heMhesDhCZdaGBt3jpOdG754ay/bbqADtM7BKihSl7ZS3yc3UgZe6zc84u7q4A3o63d5fKFv76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkAP36tqrKmACA--.2797S2;
	Thu, 17 Sep 2026 20:37:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	mwalle@kernel.org,
	srini@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nvmem: layouts: sl28vpd: Fix np reference leak in sl28vpd_add_cells()
Date: Thu, 17 Sep 2026 12:37:35 +0000
Message-Id: <20260917123735.2151431-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkAP36tqrKmACA--.2797S2
X-Coremail-Antispam: 1UD129KBjvdXoW7WryrAryUtFyxAr4xCrW3ZFb_yoWftFc_uw
	1kuFWxXa48AFsrJw13tF1S9ryIqFy3Wrn7CF4IqrsxJr47uF13G3WFvws8Z34DZrWFqrnr
	Grn0vF95Z347GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQNA2qrrJqcHwAAsy

of_get_child_by_name() returns a node with an elevated reference count.
nvmem_add_one_cell() only takes ownership of that reference on success,
so the caller must drop it when the call fails. Add the missing
of_node_put() before returning so that info.np is not leaked.

Fixes: d9fae023fe86 ("nvmem: layouts: sl28vpd: Add new layout driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nvmem/layouts/sl28vpd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index e93b020b0836..79de1e6947d0 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -126,6 +126,7 @@ static int sl28vpd_add_cells(struct nvmem_layout *layout)
 
 		ret = nvmem_add_one_cell(nvmem, &info);
 		if (ret) {
+			of_node_put(info.np);
 			of_node_put(layout_np);
 			return ret;
 		}
-- 
2.34.1

