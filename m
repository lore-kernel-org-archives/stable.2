Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6E175A7F;
	Sat, 27 Jun 2026 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782528410; cv=none; b=bT3j+i3WwXfkM/gzXS8CHdFj+b0+UwDU/gCT5YgG8pZdgqWbGgtpRFBZ7DC1Cpx/l1geG2Wkg1phq0SnDkJB4UTOwk6r46qbAWlgOUjBFl5bANeUu1UsXztvx3riEN7WJNk1R3UGvdgc7PE4vMuHG7Vp6v+LT2IF0I2ND/kL7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782528410; c=relaxed/simple;
	bh=HdoWjHdoEfjs1PkH9wRCRKwzOkckW09lBTy5GKEV1fU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGy/leFfrlKodQIK7+tRNJT+MLWa+VEcNDEqIuxJ8P8FDWlY6sPjncCSpI/14BddGB/KfbULKlITV67/eDlZNyvfVnlAJqUOEeUumXT9tOVjCraU3XVwhRDBYVcPHoLjvc9POThHg52mxHJd/zk+NPzm/OBnE655brA99r1kBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowABnPJOROT9q9KAAFg--.30S2;
	Sat, 27 Jun 2026 10:46:43 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: andreas.noever@gmail.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drivers/thunderbolt: tb_tunnel_pci: missing tb_tunnel_put on success path
Date: Sat, 27 Jun 2026 10:46:40 +0800
Message-Id: <20260627024640.57118-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnPJOROT9q9KAAFg--.30S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF17Xry3Cr1rArWkZF4kCrg_yoWDKwc_Ka
	4kWwnrXwn0k39Fkrn3tr1fZ3W0gasrua4Iq3WvkFZIyryS9FnY9r1rur18CFWxKr4UGFyD
	Aw1UGr47Zr9rXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgELA2o-DDpfPQAAsO

In tb_tunnel_pci(), tb_tunnel_alloc_pci() allocates a tunnel with kref
initialized to 1. On the success path, the tunnel is added to the tunnel
list via list_add_tail() but tb_tunnel_put() is never called to release
the initial reference. On the error path (tb_tunnel_activate failure),
tb_tunnel_put() is correctly called.

Add tb_tunnel_put(tunnel) after list_add_tail() on the success path.

Cc: stable@vger.kernel.org
Fixes: 99cabbb006f1 ("thunderbolt: Add support for full PCIe daisy chains")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/thunderbolt/tb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..57c9839b133f 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2313,6 +2313,7 @@ static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 		tb_sw_warn(sw, "failed to connect xHCI\n");
 
 	list_add_tail(&tunnel->list, &tcm->tunnel_list);
+	tb_tunnel_put(tunnel);
 	return 0;
 }
 
-- 
2.39.5 (Apple Git-154)

