Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990551;
	b=KvpNlC1DYVoyMdoToWbQQP3Mxcc9VcmA4gawcN2M2dbzVgDcH1Rtc7MdMbv3By+VAoA6
	 Dbv8BjfFVZ7EVS9C2e/Wer+63+/7XtRMffcp3e5Ocmu9NVOmkyqCM/wr0DhchlTndaiHL
	 +1svcN0sAmRcClwPayjyqRBlV5SpGzts5kLnlYV7bDl2Vt0bVQVjnOMb+eYfVrHo0LcHE
	 s9yAlZbjlLcTvBxmAOVk4FCYXOXgLUZsxdCqHlTYkKeBK8BB7Y1Cnvu8ziFQKWsUlVO6X
	 k3lqeWLVuS+5xbKO3I0R1/CDvUFTiDIeXSkHCNtbuU6cE7GMvZgoy7hYLMzVp1PA6HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9UGBPvO48P3EgdXF7lGcaY7uZ9DVFVaWCHXXjikO568=;
	b=AHRvG00GN1IfuWxrpnTl1H4RRdu99wAOCNkQAJ3NRmHBszzoqA66HlgR6YW9dWJiDTtF
	 u/Jtq9LdEaSMZnTmNDJMRV/Z8dSoQNrB1CyRT5MNCTXGhTJoOMsTO0XqaH9Xlmys8bre9
	 //YMMcaYercmP0yODQhicFycIbe9+3fTNTcfuog4BCuT+Hsq7Yy/gNn34QgflAAzrv+p3
	 Q4QAL86u4WHR+inpwMD4NbzABkZveZUuXdRFHgjWloarZgWilAGja8ZyhNOS+4kpXMpDp
	 kvrqQkW+uyZ0zhUv5pPYETG9hVxWsN18PVJlbfm3SDz7hzSodPCxJkFiisffhYw5Gwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cuk7bWkz;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC5606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24EC5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cuk7bWkz
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso610438b3a.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794990550; x=1795595350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9UGBPvO48P3EgdXF7lGcaY7uZ9DVFVaWCHXXjikO568=;
        b=cuk7bWkzMMm5x76oCo5yGlxbnQnQQiyj/9+xGoCzHelgE73VaiREeZ0xkR0PSNGHJH
         uti9RHNYBagVOenN4MN74Me5QLp2oOkcGTF5V0ONhIs5tiaxkzKrT1A2PZZVPwDMIiiR
         qLZjgeuXhf9lkh+8XBcA+IzR0jzsfhovUOj0FuStEWGRZROhZqsSvCXk0ZTla4gm6//5
         hoYC/VKHwjXxoLEPPxrDD9M1brVnmFax6vsf+zog4J+M1HKuFuruvVzLrYugEPVZryxM
         cxKM/7M6CxXo6S2C77W5PioobfmhLP8nUlhY+9YL8nyK2nQ6qrtNL8vyAaALRvaQjEwm
         BfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794990550; x=1795595350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UGBPvO48P3EgdXF7lGcaY7uZ9DVFVaWCHXXjikO568=;
        b=N0eflf3Yv+jVi4fkbc3rIU9ghq6uZYt17Scexr+06g7Kt7pEpwYX3478nSxnKy7pBh
         IaeyXehezIV5NJeSMUSIl6kRM6RD+/uKoL3LCDhAbdOv0ZPGiTMYdO++3Eevqm4rKwR5
         AwkoKKQp2Ikc/uAEolrhPKM5dh02PCq17rAp3P43LmC5ic/udJn8oGsx3OUPqumOZ42z
         kv40IniR1eXmL0Ru4BsEKoM/FdRjefajq43a7+thK7/HbruWYNjcBCrjDvsF1BzZAS1s
         6bbHgExIvDq9UO0BP0UgwyEpRtyAJfflDKMw/yTy5jGXDRTxagWchymnwHDaLqOFRnFY
         sBJA==
X-Forwarded-Encrypted: i=1; AL+hErEKxtzGhgwkE0RL/+/S7j7349XrbkLKhIkOkbVxy2czLs8f8rWGOKD8xAXOY8fbsY1t4uxyQeU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W5h7ujjMXAaICO1paRkWiti+SaDvvBADnHKySkRYqHfbnANRh
	XLU+CWB2NqiKSqItF6Tk7r0Oz47xnUZiqVjM07E2q0ZOvomLYv9TDJ77
X-Gm-Gg: AYBFou0f7+VayTZBRp0PjEl+43qgOcDMkLf+0zwaqcXqoSMj8NgGO2OMtHtkzX+he2l
	708Um65HeguBiJGzadz7WnTbcqAD3A4EAJ7mcUSRo8vTV1J7rDXy9YEwI9OjQwwqOnwtJAu48q9
	VP1wyaLv4pf3HswWvlfV1SJhoZrg+Sc4O6/m4WusI5YQXKShzA+QMjMQJb0NrL4serekZpPkgLq
	ZZFPbwPLZt9WKH5kjOYSyVxd4nQjX1dvTMru1WwM97FlPyQZnAY1ZxznKoEtrEHXSw22TWmJIS8
	wMtlJnr0htfxqMkhvMs21If+EA5/nktqwyAmKNsK3H2dh/SmmIR1PHkPmA/i3XwJPhRmEkNI+3h
	S42ZYzKvx5M3+WMC9xccYpA/2NGw2hgmiIrEs8BQTd2Zc2ZTG/I+77gseW+7TbhOdz9ROsEZOPr
	yZOJ7Ft0iLM4DrYx5b42Ey0VpKAK22aMPRgL0+h41tSSY0J7BJp67W0wRrHIj1re0q0DiNeSMZ1
	pPJx+X+2bHvGEHCq8LTexACZxtjA+ga1PKpk/widD0AvG1iJARY43E+s5ZnzIRitMtWR/wq6kmf
	FRunNp7jOw3yn9sPxMPEStcOuPz4TES5tt++Bj+bLAvsrO0Y+A==
X-Received: by 2002:a05:6a00:1da0:b0:899:5183:acdb with SMTP id d2e1a72fcca58-8c5d0f24a1fmr1572117b3a.1.1794990550197;
        Wed, 18 Nov 2026 00:29:10 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb35db4esm784426b3a.35.2026.11.18.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:29:09 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: =?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] dmaengine: stm32-dmamux: don't resume runtime PM under a spinlock
Date: Wed, 18 Nov 2026 17:28:53 +0900
Message-ID: <20261118082853.926607-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

stm32_dmamux_route_allocate() calls pm_runtime_resume_and_get() while
holding dmamux->lock with interrupts disabled. The runtime-resume
callback stm32_dmamux_runtime_resume() calls clk_prepare_enable(), which
can sleep, and the device is not marked pm_runtime_irq_safe(), so this
can sleep in atomic context.

The lock does not protect anything here: the dma_inuse bitmap is already
updated under the lock earlier in the function, and this second critical
section only wraps the pm_runtime call. Drop the lock around it.

Fixes: 4f3ceca254e0 ("dmaengine: stm32-dmamux: Add PM Runtime support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/dma/stm32/stm32-dmamux.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
index 57318715d9f3..890328b3d302 100644
--- a/drivers/dma/stm32/stm32-dmamux.c
+++ b/drivers/dma/stm32/stm32-dmamux.c
@@ -139,13 +139,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	}
 
 	/* Set dma request */
-	spin_lock_irqsave(&dmamux->lock, flags);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0) {
-		spin_unlock_irqrestore(&dmamux->lock, flags);
+	if (ret < 0)
 		goto err_put_dma_spec_np;
-	}
-	spin_unlock_irqrestore(&dmamux->lock, flags);
 
 	mux->request = dma_spec->args[0];
 
-- 
2.43.0

