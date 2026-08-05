Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F03FF896
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924106; cv=none; b=X79cWrYIdMrsayl3NztMaTaB3i3ssqd7jqF9GR0tB1WJWljRdTLFziwbAn28hIY1bjGmWXbNEzDUYBb+p469YGYxbbmyKEqR/EsWZ2p2ln9T6flciCtmTpmPg5nm0J/m5wZfiUcuoMU6Qg/mBnHZB21MnZYqy9uoNtYxieImcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924106; c=relaxed/simple;
	bh=7GT3cFMblh8d4JT4vpM1PGuCKQLpDo4D1LyV7c5pVCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTWg4p9a8huE6KUb9t3NAJkZzFWgvIzxzmuNqzZhRWemYa/VZFuupuVRRJscZynn9dO3ehnVvrrDzG04pVNcPatZBzz65lWYpDfVxTXJ9yQyvr+vg7xDRxLlz2bphJMT2AllUwCqd0ks2PpF+Gibd6BX9G+6IXNBNMZlj80dGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHy7TLxq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHy7TLxq"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47db714766aso1120084f8f.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785924103; x=1786528903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvfYSf2Y/ppNSh+MrXHyeNORXj9DnMxf1Ar7j3eDWYw=;
        b=ZHy7TLxqRClm/6txomPKbzOT0CTdf7Z9rhC3pKmvhhjhGoMX8J5fgze+Gxs0LRsl9A
         ah259S38N7EB83EGzy5hSGd8jR3RnOjbgcRBxD68Bt1Fg2BtH0Q2oeQZ/Eng/U6+iei2
         Buh+Jt96LLa9VqqZegUUsu4UCXNRUsTHtFqg7zs6BWU/cnVzMXPnzJPCS3q2GYrXoNi5
         YfP1OfBtrr8X4ay6ScOjKsO35DwLD8HVviDkZ193F1Kn939vteIEQpG4DrLMUvt16TI6
         ivaXFcY2P9EZGB1+5TjHZnmiJLMv70RC8AZYFemFG3oTKI6SO5gpG+QhAvRJK3aOgRKl
         U8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924103; x=1786528903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvfYSf2Y/ppNSh+MrXHyeNORXj9DnMxf1Ar7j3eDWYw=;
        b=mHuD2BiBLjwnQEm2kwogO346d6T70mmxm/sAyotMQ2OA48LLBBiWYwIp6vl9JyOV9G
         3BEmXF+eylH+5+TUBLDJNAk32DIn0SFPR5dQlyv2MzWMdPsAluh0yC3b/GqZop2sdozY
         XfYmAsprCNp1ceBu10xmuOZb1m54kfNPwbG1HY0p2FZyR1f1DFx+jG/qKpFRZpkeTi/N
         2gO0UGP3QrlfqxxCWGQ1ydTeL6wDE3aPCILLdC2rT+s3Ob9gIxiVoPg4bXV1fA8DNZWX
         E/txl8hkNSAn5kFuH60wua8jcn+qcHKOZJWRmAbmPD7cYEUj+qsYdM1w/E7nI3DL19ow
         PaHg==
X-Gm-Message-State: AOJu0YyMUCYAO6uJN0KwAQo9dfgBzWtnnUZYJ3kkawOL3zTd15AzPUr9
	dCpQ7C+gmKvuw5kB6CNlp8gbqR1CGmFtyQBjZLYdAHeFjfTf5dFXPBuAk7IZ6MDN
X-Gm-Gg: AR+sD12gtvPK7HJnGxMFxhw2f0xl9zXRVgHOB2gCPdpmQxEkp84vJWIRdOEexZdVIeL
	43C5vlF67txIEpejdWAHwvCeEVvMyO/Cf8gp8sbS8TrajtzpI8voNvWXciLxyML+X+g7tE59Bs3
	9qqkmwOitZ1eKVGdhBVd6BXQBWx0Z1Y7zPmvhIbRkXpE0z89Mq40pJobn0JoQeEG8FWyum+7Bui
	B6amJ7fww99dPvQ3eN68JnuVdjVI7jU+ecKT/Qb98s37wqH7ea99HshpX9TSOiKgWbW0+ZQpd7y
	3IWwQElqET1zR8QvGHe5wJPOXPipybWqGjpeaTiuBiD1qiPN7LByzS07DoHmOjMBJI5epaICyHA
	RL3Vzs4lrlfHPFkmdBbcPFHcfyOL25yaYJafnvlWnooUfF7suM7+KORFGXD62+yY7p8NaGdUF7g
	YbDoil5TdjcDtQW1opdf1X7fzv73uLCwSnK5Ge4hGsGOMJc8UKY+/3L2fvvqeEdU+pswf04HnLG
	93j
X-Received: by 2002:a5d:5f4a:0:b0:475:da0e:744d with SMTP id ffacd0b85a97d-47fec50b902mr8977646f8f.8.1785924103060;
        Wed, 05 Aug 2026 03:01:43 -0700 (PDT)
Received: from arbab-X395.dbs.corp ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec249a5fsm7344776f8f.33.2026.08.05.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:01:42 -0700 (PDT)
From: Arbab Haider <arbabhaider649@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yun Zhou <yun.zhou@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0.y 1/5] net: mvneta: re-enable percpu interrupt on resume
Date: Wed,  5 Aug 2026 15:01:32 +0500
Message-ID: <20260805100136.59101-1-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yun Zhou <yun.zhou@windriver.com>

On Marvell MPIC platforms (Armada 370/XP/38x), mvneta uses a percpu
IRQ disable/enable scheme for NAPI: the ISR (mvneta_percpu_isr) calls
disable_percpu_irq() to mask the MPIC per-CPU interrupt and schedules
NAPI poll, which calls enable_percpu_irq() on completion to unmask.

If suspend occurs while NAPI poll is pending (between
disable_percpu_irq in the ISR and enable_percpu_irq in poll
completion), the interrupt is never re-enabled:

  1. mvneta_percpu_isr: disable_percpu_irq() + napi_schedule()
     => MPIC masked, percpu_enabled cpumask bit cleared
  2. NAPI poll does not complete before suspend proceeds
     (on PREEMPT_RT this is highly likely since softirqs run in
     ksoftirqd which gets frozen; on non-RT it can happen when
     softirq processing is deferred to ksoftirqd)
  3. mvneta_stop_dev => napi_disable(): cancels the pending poll
     without executing the completion path
  4. suspend_device_irqs => IRQCHIP_MASK_ON_SUSPEND: masks MPIC
     (already masked, but records IRQS_SUSPENDED)
  5. Resume: mpic_resume checks irq_percpu_is_enabled() => false
     (bit was cleared in step 1) => skips unmask
  6. mvneta_start_dev only restores device-level INTR_NEW_MASK,
     does not touch the MPIC per-CPU mask

Result: MPIC per-CPU interrupt stays masked permanently. The NIC
generates interrupts (INTR_NEW_CAUSE != 0) but the CPU never
receives them, causing complete loss of network connectivity.

Fix by calling on_each_cpu(mvneta_percpu_enable) in the resume path
to unconditionally unmask the MPIC per-CPU interrupt regardless of
pre-suspend state.

Fixes: 12bb03b436da ("net: mvneta: Handle per-cpu interrupts")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20260622074350.1666290-1-yun.zhou@windriver.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Upstream commit fd398d6480987e4c84fff0aaab6b9d6642a93343 ]

---
 drivers/net/ethernet/marvell/mvneta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 9ba4aef7080c..22da95d46bef 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5897,6 +5897,9 @@ static int mvneta_resume(struct device *device)
 	rtnl_unlock();
 	mvneta_set_rx_mode(dev);
 
+	if (!pp->neta_armada3700)
+		on_each_cpu(mvneta_percpu_enable, pp, true);
+
 	return 0;
 }
 #endif
-- 
2.53.0

