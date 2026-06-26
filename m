Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7A3E2AA1;
	Fri, 26 Jun 2026 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488563; cv=none; b=pGw/zgmqDymcW0GZJgUdQNI3zA7hQXQOUnYyti03yOgEFyarDxPRacFAYm7jrXHNPwvJWog4GPdC8O9rO0urw6QYPSIuKMGoSj1BpZf1JkFMwKoFHccfVpHPHpNy2cliDNlSxmdSvCQpG1L28oqM9E8UdDBJWqXgOxejaABfzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488563; c=relaxed/simple;
	bh=E8e+5QqXd9QkvyTTpY3Cd4I1C13tuYuunN03zrlBf8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uil4LJvzU2gGgnWFdyZ4+20YjdNdkYmAUy8mh++JtVPBXsuR/tOSy/187J4y9WVeVPQFkLGjLxBI6GyCyDeCbH7T14LnjA6XtJ3F1sTSBTEVEDmMtabLjnUVaIOu4Ap4HPdZWy0zJti3JznOH3zZlFcpNAz4o2e4+gGsZmXaO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAC3UsvtnT5qIbNsAw--.57125S2;
	Fri, 26 Jun 2026 23:42:37 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: nvmem: sl28vpd_add_cells: fix missing of_node_put for info.np on   nvmem_add_one_cell failure
Date: Fri, 26 Jun 2026 23:42:36 +0800
Message-Id: <20260626154236.53449-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3UsvtnT5qIbNsAw--.57125S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4kGF1rCry8uw17KFyxGrg_yoWkGrb_uw
	1kuFy3Xa48CrsrJr1akF1Sgwn7tFnxWryxCFZ2qFZ3J3yUuF45GF9Yywsxt34UArWFqFsr
	Grn0qF95Z347JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUdpnPUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMKA2o+iCg7ZAAAs4

In sl28vpd_add_cells(), of_get_child_by_name() acquires a reference for
  info.np inside the loop. On success, nvmem_add_one_cell() consumes the
  reference. However, when nvmem_add_one_cell() fails, the function
  releases layout_np via of_node_put() but does not call
  of_node_put(info.np), leaking the device_node reference.

Add of_node_put(info.np) before returning error to fix the leak.

Cc: stable@vger.kernel.org
Fixes: d9fae023fe86 ("nvmem: layouts: sl28vpd: Add new layout driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
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
2.39.5 (Apple Git-154)

