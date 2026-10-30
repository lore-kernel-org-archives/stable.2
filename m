Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379286;
	b=I8FSD0t3AfjxyJexNEi0kXBUPogxFXZ9rOaycLTB3uzcHu0d5w4/1CUnkMwHu2d3yVLB
	 XZubl81WMFysl8DIoMdD6NlDwrPS0E3tfBNVyV5ltz6oG4xUeB37bLsGliTPjnEe553Jt
	 PniZrjFWwkdvH5VmIstJrlQIFrOyhCyLMPHLyA+hWW8kVeriXxwZ47HHninsh9kKJdR0H
	 9fJHsXMi7ydtA8hjZ/C+CV8PXiQBgeVJUhLn8b/IbkBFAnaSuLkoAEy99UATlvZ5dxp/e
	 ORIIvquZvIdRqwTZAr+4IkZOb/iNXqIya/bYHQLu06gC8K6wRJ7D2OL3+ZhRvYMFSnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379286;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=wVuG7q5uMpwLdeNdNqczhbqcCJJG1XE+6CcI8ium2FY=;
	b=agR3x8U8O4TZhE9J+FnforlZdvtjTH1ZSpZgIJppaBG4iWo6NArAHfBFBTzKkcje4IZ+
	 5sUX8KZE2+C/cD5Qrx6kBT0nzrbjRoUDlShIuO8WtVtg7qsS1xMVxPVp1760XfBI/wGrX
	 nDHpC12v2uKUIykkL2ot32rY7kJ1YjBuIxFahgid+UDvZZP9EmyZFlJ+79CyH2RmrGrrS
	 jlZm9zZ0ZEDPJxovy7WQ9o067bP70mr2Yc5x/lcPng0hooqGZthVkqX24A+nPzrYbAuqw
	 hVavq3wX5joBDB5Fo4sERhnD2pvfZNPNGUXaQioFMwz48QOCF8NO8Xs1RvRNFmnj57w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=IH6pW7U2;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B14606A32D;
	Fri, 30 Oct 2026 16:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4B14606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=IH6pW7U2
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f74f11e;
	Sat, 31 Oct 2026 00:54:37 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Lee Jones <lee@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	mfd@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mfd: stmpe: Fix potential use-after-free during removal
Date: Sat, 31 Oct 2026 00:54:27 +0800
Message-ID: <f25172a8ca446456fa3e856b1b8b76e11dace293.1793377422.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
References: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa18dbc199a03a1kunm46158e5a52a29
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEtPVk1NT0NIS0xLHU9KH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=IH6pW7U2J4IPfcChpf6c2jBoUJlT7AjgPqMcSPjDAvH7wI1GVrtbeu2zLTGUFhAixV+e5e1v5B6MKMolBfR7nEZL3IFiQ0OFJ4gxzce9OGTI1CvqGH1xoaZncIpouPMTJuS17B0x3OWbAVH3yIVY6RYTE3xeJodqeodh+R2ALGE=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=wVuG7q5uMpwLdeNdNqczhbqcCJJG1XE+6CcI8ium2FY=;
	h=date:mime-version:subject:message-id:from;

stmpe_remove() frees the IRQ domain before removing its children.
Deactivating a child's interrupt can then access the freed domain.
Remove the children before tearing down the domain and supplies.

This issue was found by our static analysis tool under development.

Fixes: 57bf2a312ab2 ("mfd: stmpe: Remove IRQ domain upon removal")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed object with x86_64 defconfig plus COMPILE_TEST
and the driver dependencies (W=1).
No runtime or fault-injection testing was performed.

 drivers/mfd/stmpe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 3c5c2f157f52..89c1c8deadc6 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1486,6 +1486,8 @@ EXPORT_SYMBOL_GPL(stmpe_probe);
 
 void stmpe_remove(struct stmpe *stmpe)
 {
+	mfd_remove_devices(stmpe->dev);
+
 	if (stmpe->domain)
 		irq_domain_remove(stmpe->domain);
 
@@ -1495,8 +1497,6 @@ void stmpe_remove(struct stmpe *stmpe)
 		regulator_disable(stmpe->vcc);
 
 	__stmpe_disable(stmpe, STMPE_BLOCK_ADC);
-
-	mfd_remove_devices(stmpe->dev);
 }
 EXPORT_SYMBOL_GPL(stmpe_remove);
 
