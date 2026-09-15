Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9D432E76;
	Tue, 15 Sep 2026 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446963; cv=none; b=Ovg5F1uy5vDb+TkBPwMAA1arWaCHQR5wyklA8m1i0I81HRrWUM6JAcF0ea7tR/8M05prm+eYKoTfQVMxptH4eu5b0zE2l6IGDT9FL/jZKkMJCwyzDlkzwu6fqk5Hw4VA+qmxpjhFuCvcx//QAiPPXe+GwfyBgcg/v9omiNP10Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446963; c=relaxed/simple;
	bh=fV0P8oC4XejGVLUDGNjYYJFloM7WZQ6GtX6gRj/qFMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sw52tQzOhHRkQ07rxs5Wnt4AwX3+hRDRYwj2m18Tu8F3RYqygECkHWeUuOgfyBGAzb3V38TWJz3fxEAZm9p652NLMALgEZpe36ypYFBaPsp1Ht13/a+fl3zLEIS82vborn8M3Qs12VEuzEiLPXES+872CtnMBLw1eMP1vql2Rzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAn_O8oy6hq2cQICA--.32678S2;
	Tue, 15 Sep 2026 12:35:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	rob.herring@calxeda.com,
	sudeep.holla@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 5/6] driver core: cpu: Fix OF node reference leak in register_cpu() error path
Date: Tue, 15 Sep 2026 04:35:23 +0000
Message-Id: <20260915043523.1725991-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAn_O8oy6hq2cQICA--.32678S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKrW3ZrWfZw1DAry5tFyDAwb_yoW8Jr45pF
	4UGa9Ivr9rWF4Ikw40vFyjqFyj9a12yFWrW3W8Gw1a9rs8Xr98J390qFWYg3WrG3ykA3W3
	try5JrWfury8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUtgA7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMLA2qowpAg5AAAsY

register_cpu() assigns the device node returned by of_get_cpu_node(),
which comes with a reference, to cpu->dev.of_node.  If device_register()
fails, the error path calls put_device() and returns, but nothing ever
drops the OF node reference: cpu_device_release() is empty and the
driver core does not put dev->of_node on the failure path, so each
failed registration leaks a reference on the device node.

Release the OF node with of_node_put() on the error path.  It is safe
to access cpu->dev.of_node after put_device(), since the statically
allocated struct cpu is never freed by cpu_device_release().

Fixes: f86e4718f24b ("driver/core: cpu: initialize of_node in cpu's device struture")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/base/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 875abdc9942e..bc96725c8d4c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -431,6 +431,7 @@ int register_cpu(struct cpu *cpu, int num)
 	error = device_register(&cpu->dev);
 	if (error) {
 		put_device(&cpu->dev);
+		of_node_put(cpu->dev.of_node);
 		return error;
 	}
 
-- 
2.34.1

