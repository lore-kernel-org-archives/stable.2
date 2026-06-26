Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D93DFC8D;
	Fri, 26 Jun 2026 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489812; cv=none; b=XD9zQ0C//EjEkPk8xgcvhMxmv8jmOikRSEVhs18y0OvV2WshQDjpZkEEa0OI6EANcekr1c4qLWTxyVIACa+O7YYy0wsgNFIqV8nu0zcMDbYszzVEMrwl0BXV4wJLt/FuW+SAGwVtFoCQIno7/Qg8y5n5KPsPCtF9gJoeNAV9DXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489812; c=relaxed/simple;
	bh=Kgnqnq+nSTs+Kb2t3+bC2vDS30+SjA/iqwRfhFIGMPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RvXjfs9EvCzr6pBUSxvRcqjXS13sfbPjmpV2e28jRwPmCx5AYbbdViva9TRk0IXb/52G3PABptaVn0IowebNpEPg56rcfz6BCPEQXDqCs0fylpNoe4xCikr4fmxcLy6MVGA8dG3NWhKt6NuBPGdpn14k6hwnUczmwqPPUvid9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowABnB9DOoj5qvk9tAw--.532S2;
	Sat, 27 Jun 2026 00:03:27 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: regulator: max8998_pmic_dt_parse_pdata: of_node_put on reg_np after   ownership transferred to rdata
Date: Sat, 27 Jun 2026 00:03:26 +0800
Message-Id: <20260626160326.54457-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnB9DOoj5qvk9tAw--.532S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1kAr4xXrW5Xr4DArWfGrg_yoWkKrX_Wr
	y8Was3XwsrCrs8Cr1IgFsa9r9IyF10ga97Gay8tFZxGa4DZ3WrGr1fZ3y3ZwnrX3yUtrn7
	Gr17Xa9xAwnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5oGQDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIKA2o+ids-3wAAsh

In max8998_pmic_dt_parse_pdata(), of_get_child_by_name() acquires a
reference on reg_np which is then stored in rdata->reg_node, transferring
ownership to the regulator data array. The subsequent of_node_put(reg_np)
at the end of the function releases the last matched regulator node's
reference, leaving rdata->reg_node as a dangling pointer for the last
entry.

Remove the spurious of_node_put(reg_np) call.

Cc: stable@vger.kernel.org
Fixes: 156f252857df ("drivers: regulator: add Maxim 8998 driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/regulator/max8998.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 254a77887f66..52ab2208675b 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -582,7 +582,6 @@ static int max8998_pmic_dt_parse_pdata(struct max8998_dev *iodev,
 	}
 	pdata->num_regulators = rdata - pdata->regulators;
 
-	of_node_put(reg_np);
 	of_node_put(regulators_np);
 
 	pdata->buck_voltage_lock = of_property_read_bool(pmic_np, "max8998,pmic-buck-voltage-lock");
-- 
2.39.5 (Apple Git-154)

