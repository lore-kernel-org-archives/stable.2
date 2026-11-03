Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689738;
	b=KFs222KKzWBNGjKY+TwBoYQwrJrzBaAxkMaqcp87bBbdeqJDWf/mC/o5SEunKa/XKRC3
	 +mpMOnjOzM3/Lw6HSRphcx6WyPO8OheD+nysk+sGOxE8lFW5Y/WwsdOH3lAJp1SGeFEqS
	 en8dcuEgBGGo7mOR5Ii/GHhqU08HJl8gNCJQ7cp/uNmzYswDPFeQ7JVdtvRmna8g9oGiu
	 2UhCoTn4tYyGaMZpp1u6qTd1VdRFWUDpXGqz7B/wNtuKMHviSX5IybYhgpSD4TZlbN1j9
	 sC9nj132cyhMo9Qx28b7TyIVtxTyz+LNhCbTAqpdrICyCU2oZnbR0xCWSe4xiUA/gTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689738;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=m8AuPCOFAf/2S2nvWRU/STz1Sg7kLIO+T08Yd5N1l88=;
	b=n7/TB+tbAoSrjxXdgcjWE8qjekmi0QUwhXOkR5C3Mfu35bnKRh5gNxyQQlm6tUWfQz2Z
	 J75rYEBHwNcwMQ3+fo7j6ePJ/en+G9AqKoI4tElTsIp/BT14Bn9ItqGcyBXzD34X3q4n7
	 3FpuW75VqcFGdcN/bpHNaSMPkoPE9TJjuoJ8thEN1XK6jMLkDyZvO4fsQ0JZoeN6+yX+w
	 OZByykJtuydN79tAwPwcYOzfbzqAsp0Ddl1qgYrLMsaFs7Hy7PjjMRRPCb6jffBTltl0l
	 gePmykCqm2GdbI73FzoqPDbc6jUXGikxFNK9Kxi4po+aMDjlT1FesL5+cDyLu8/1prQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145E606A324;
	Tue,  3 Nov 2026 07:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7145E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHk5SHiOlqkLQ5AA--.4125S2;
	Tue, 03 Nov 2026 15:08:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.shishkin@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] intel_th: Balance the runtime PM reference on driver removal
Date: Tue,  3 Nov 2026 07:09:04 +0000
Message-Id: <20261103070904.1085387-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHk5SHiOlqkLQ5AA--.4125S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UXrWfCw17uF15Xw1fWFg_yoW8Jw15pF
	4DXFy2kFW7Xw42va12yrnrZFyYgayftrWfGFykGa4rZa45Aa42qryUKFyYqa4UtryrtF9x
	tw4ktrW7WFW8tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYzuWDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUAA2rpWfWghwAAsX

intel_th_remove() resumes the device with pm_runtime_get_sync() before
calling the driver's remove callback, but never drops that usage counter
increment. Disabling and re-enabling runtime PM does not reset the usage
counter, nor does the driver core's subsequent pm_runtime_reinit().
Repeated unbind and bind cycles therefore retain an extra reference each
time and can prevent the device and its parent from suspending.

Drop the removal reference with pm_runtime_put_noidle() while runtime PM
is disabled, before restoring the existing active state.

Fixes: 142dfeb20209 ("intel_th: Add runtime power management handling")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/hwtracing/intel_th/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 56acf31546da..1c1f59b8ed3f 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -162,6 +162,7 @@ static void intel_th_remove(struct device *dev)
 	}
 
 	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 }
-- 
2.34.1

