Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870571;
	b=CrgQoWB8qBSUOlKuo5fLc8ZCoW6zpiqAWgGWxrLn1tRvWSL2v3brS1Eodgw2OSyXMQc9
	 kQqMhk6rDuwK8kN6OPFMrCDw7JaQb9czEVxksURjLiWIXngnnE5yFZf8PrCfkZwUr1OEb
	 I4tH5+BjE1kNOY5819XF9cLVYd0fzT0VqGu/2/+ufS0qutXaVOJux3I+dmDN5DldPy+Hj
	 aE7LvQ+wYBXmTtXFQj04ervzCJwHO18lGQ49YiTm2dXOFq7CLZMlsjpR75Xe9yo0NmuYC
	 qlcMBtRc5KSB2sE3i9VTIhB64dvl5vh3pYxuDwcZwroJojvbWrfChbVhMpnoH+SbnHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870571;
	h=DMARC-Filter:Received:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=SyToh2cMEDIhE82RM4ykkXm/LGy+eMRbdb0cyJX6fTg=;
	b=AtwYzTMG73CTRzFAwrTJTWmV8Zwm07qOG3IPzosi+5LAOktSQ88oC7C3X4v5XwCeDpqz
	 sK5sx0whEJdqAfk1CYTLve7vRtD3UNG9LG+RHHDQmG2LHJPgkFfnM+IHa/vkOzj7z9vcB
	 eo4QDpSOwv7kZoHP2+pLc1UvtvHAo2eSB2Ir+LhhjZ/MeVBMkQBAv6kij+JfiipZaCj9P
	 9HQjCmi3ifVTnhZgZkUtAYD1kPiS4KliTh3uSFAJLz9Kdn/2TGhtGRRuiNowN8wTV+NJ0
	 q5jutNPlndnA9p548luQAjmgkEmIp6OVhpMojYXFAxBowz4Sht4eL2Y06vRwvuzUKgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81188606A33A;
	Thu,  5 Nov 2026 09:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81188606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3ULbiSuxquKtcAA--.2994S2;
	Thu, 05 Nov 2026 17:22:42 +0800 (CST)
Subject: [PATCH v2] driver core: cpu: Fix OF node reference leak in
 register_cpu() error path
From: Wentao Liang <vulab@iscas.ac.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, lkml@vger.kernel.org, rafael@kernel.org,
 rob.herring@calxeda.com, stable@vger.kernel.org, vulab@iscas.ac.cn
In-Reply-To: <20260923-uncovered-worthy-capuchin-a75edc@sudeepholla>
References: <20260915043523.1725991-1-vulab@iscas.ac.cn>
 <20260923-uncovered-worthy-capuchin-a75edc@sudeepholla>
Date: Thu, 05 Nov 2026 09:22:51 -0000
Message-ID: <179387057178.2019441.5343067615150853888@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:zQCowAC3ULbiSuxquKtcAA--.2994S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWUJF43tw4xGw17GF1xKrg_yoW8JFyfpF
	45Ka9IvrWDJF4xKw40va4jqa4jga17tFW8u3W8G343urs8X3WUJ34qqFW5XF1DGw4rJ343
	tFy5twsY93s5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU7nmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQCA2rsPxAvYAAAsv

register_cpu() stores the reference from of_get_cpu_node() in
cpu->dev.of_node, but does not release it if device_register() fails.

Drop the reference on failure and clear the pointer, since architecture
code such as PPC's register_cpu_online() checks it for NULL before
obtaining a node reference.

Fixes: f86e4718f24b ("driver/core: cpu: initialize of_node in cpu's device struture")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Clear cpu->dev.of_node after of_node_put(), as Sudeep requested.
- Drop the series numbering. This is an independent fix and does not
  belong to a series with the other patches posted alongside it.
  That is a submission mistake on my side. Sorry for the delayed reply,
  the submission error, and the extra review work this caused.

 drivers/base/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 875abdc9942e..b50ba6a32a3a 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -431,6 +431,8 @@ int register_cpu(struct cpu *cpu, int num)
 	error = device_register(&cpu->dev);
 	if (error) {
 		put_device(&cpu->dev);
+		of_node_put(cpu->dev.of_node);
+		cpu->dev.of_node = NULL;
 		return error;
 	}
 
-- 
2.34.1

