Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717931;
	b=2kpiLSMLVLRSIeRdSnpWrc8EBrrsUD10qIZacHte+QLuQAk5M4aQsWATK/8yiEwUG3pM
	 +dc1cJG/srv4ZcOl28Hp3/hrlNjWB1H2wdJY0uTY+k4hK+7pyegI3kH+XwGydCcL0jJHz
	 6rpkpoqB4ghmau9pWoGldc/ARSFnFODI8YuOwtxF1lIkzukClnOopn6ykHRJb0AYGgQ8k
	 8Rkzlm8K4APslQ1vAF+QAq8GJ4ldBpDh/dfY7zqyi/K4ve3p6B9ykKpn5qiGQjwc9CpSR
	 YgWKzsRSF78uPvEBe52j86/FyMyuzv7g/S2uAaF5gAECWgUn9LcoHyh9rBzDU0Mk8Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I7WPGaj4cxMwtTPuWkS+noNv0Yv0bpfaJVZPZdLBfI8=;
	b=R5CUQF/5xZ9lRsq0l+tzsRJpwbyPJPVM0a1DiiiwowNZrjP2mw9NsfOYTmXmgBG72w8R
	 Vm34OZAiWAv/hvJSl5+5A08zqNrHlsUuaucR7eB3LrK3Ebeu4C29z2MeVrUdtaP2HOuUU
	 KJLwvCgZ6I5BpjR9300jkyR0p1efJIVv37s73pW6Spd9zbg2xZE8IREFzzdzqhQLXzImr
	 6wa0X+lP6mJxAWHd+mE8l3pzXYNZVxItlpZVYXRL3ypYSprIPcOuVSMeo3a24sPu9Acij
	 5cIWExR7QFUT9qxsIe5wuepY67BvzsO0dYsgabmKDAeJs1byj9OwP6ze2sq19oF/6AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfVKfjpi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D296070A82
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfVKfjpi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A401F01801;
	Tue,  3 Nov 2026 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717930;
	bh=I7WPGaj4cxMwtTPuWkS+noNv0Yv0bpfaJVZPZdLBfI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QfVKfjpikHNRBtMTfk5F34zxD1xSlsBAkpNMuTleXMpHwBzDNsmVmZ+ScjOs4H5CI
	 neHCpiGTEvfUc5Z6nbTjchBSH2YNkHGJw0y8Zamrn3v+2uKw6G2ko4oj2QEnasRVwI
	 2A3QPLHbFBYIVWKJsrwwDR6sbxBqZuiNRt9FSz+Z5CtjXfb89s9YOu3vVBaeW94Yi0
	 xXR9OM01VWZsGgFBgCCX23lU+cLlBwlcatZ1VFJw7HVHJRB7CLx3WAVJkJziQJe7TA
	 vTx5ZjUoJgLUdDdRR4MHsOJW+Vj6Dtl03KselimqCRgjrFNBXS7TbLmb2AZ7A/A4pa
	 yhPHIUdFeQyPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	"Daniel Thompson (RISCstar)" <danielt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] backlight: lm3630a: Cancel delayed work before destroying workqueue
Date: Tue,  3 Nov 2026 09:58:47 -0500
Message-ID: <20261103145824.4109030-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103145824.4109030-1-sashal@kernel.org>
References: <2026110358-afar-payable-c2d6@gregkh>
 <20261103145824.4109030-1-sashal@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 2cf184caab8b406fdd9db126ee40d62418237456 ]

The interrupt handler queues delayed work to read the interrupt status.
After free_irq() stops the producer, this work can still be waiting on its
timer. destroy_workqueue() cannot drain delayed work that has not yet been
queued by its timer, so the timer can outlive both the workqueue and the
devm-allocated chip containing the work.

Cancel the delayed work synchronously after freeing the IRQ and before
destroying the workqueue. This also waits for any running status read to
finish before the chip's resources are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Link: https://patch.msgid.link/20261003030439.599330-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 0886bbce25e54..118a91321b603 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -589,6 +589,7 @@ static int lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
+		cancel_delayed_work_sync(&pchip->work);
 		destroy_workqueue(pchip->irqthread);
 	}
 	return 0;
-- 
2.53.0

