Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387901;
	b=LBQHyBHIOO9fTDkoVcNBCmELfiD1puB1TzmBcvvkh+mJPCSMfgytMdcNKIp4ZZXb4V0A
	 v0SvD1daNz2VugZ5/HeHTOxYc2C4HJHTmcK18hw3T0dY8ev4FEYkpLo5tWGDgcXM4kNcn
	 MsRJkWRI67X4H9qraHgv4rcHGGAmmcMC0IhvBenkP+0nEEcXtZqg8SS+eYs0A/50WWK+f
	 zCGUu5AOxEnHbd+Q0j1/bwKBspsPc2jm7dHHiIUjd5Z2Ukixxd2qhn1WDVo5M3w6eosRU
	 8Pm52ToywAYpjh24pZ03741zYtHdwkWErRq29WGA+kiSAytmt0yvjluMp8+jw//R1MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lWvHlJP/BhWXCtzu8EBRNTpvuRwa2bkgzs02+RZsqMY=;
	b=YYG1yUgrPkmqZYhMZ8OVppgAnG9P9sqzytOZoEg8pTBZx1sJdzATQbZ3upHFnTAO8aDf
	 agtxWUAXm9wFMcqjJEyUl2if2DgTw2zE7bTGIjCFQqiU7mmKYPQvpZJpwKs9F11wRgCwM
	 zZWJGy0eZzEuz2voJAXbo0h9ZkOZU1CBzw4ENygQgbD/Hc0i0ZdqMgFX8gHpXKcZmAeBM
	 5UFSy4rLXdk/+hYKcV6X+HDbRGJ8a/zU7QJg6rsHgdZ/fJe8dUAlC3B34xJ0lq/sFP09Z
	 3oInY8bDbX1t3+yq6jlBvaA5B5Xoj7TbEhydTQTlGLWUxn0q3taAcXFEO3oV/RUluHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JSkSDtEp;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E7606A33C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C9E7606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JSkSDtEp
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37071c0f42aso5126852eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794387900; x=1794992700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lWvHlJP/BhWXCtzu8EBRNTpvuRwa2bkgzs02+RZsqMY=;
        b=JSkSDtEpMeWO+FjL9oZ11YGGFfiza8PqjVEz02vDfborSl2ArjiU6T7kiZvSti2uRv
         JXWJcA0sRmc8xsm6KiwPOrokbNO5aLtOsm14+va23tDpoQu5bAd6CPUxCHkLO1aAuj/F
         LCgd4VmqZ4tzOu+EcJGUkTBpDk/2x6gKQd6Iwn+9qwl/cWh16Nlm8gcoqUBWz/rvZv7x
         LZm+H7GUt6C2489UZQ3GZeO9tXk09ysy+OYGIozg/YI7/z8npcL2+smoEs6XWtNtMfW6
         qF0/TYBEIVJcB8nDs/GWEDw5emYryvRLNQWH7PMl4yByiOjdWMrszAk5bq1hinAuVOKh
         LdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387900; x=1794992700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWvHlJP/BhWXCtzu8EBRNTpvuRwa2bkgzs02+RZsqMY=;
        b=CSoJssPxzQstZLeHY8KHtm119gz7xG+qPyKSeSGqrGm+r5YcGGCI8bRL1ODv0hQNY1
         Ys23hjJRM9GuWUguQYD6oxuskFYHVE3b6YEJdPBQPHBaPFPGaeSPcw/WiEjR1BQ2rqar
         tvNdcqBsnA00fZMoIkuObeQaxm0CnVOA4vEYA1xRMQOC0yQ8M6wfUDvyjy3uzrf3IuMI
         Bks7PLOhLplRaOSil7tU62qLAk6Gz0nFqNOn8afYZq2kLeClUZSlrCrqPZzlV0U2U4ol
         e7+l0TodBwf049yJrt2mWJKy/tdDUyX+fI69NgMoyGFV3taxtUD5ZxMWitwu3suzGTNI
         MtSg==
X-Forwarded-Encrypted: i=1; AL+hErERrFbMr74aq4NQGi3fZcKhdtrJtq8diXGqPY9ZrDCe2oOG0FNbnZI539lR4oebKn34OPHwHh0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Quksh6eN4eSZyt++6phC3ExIe+neHQ20bsqzTWrEoDcoipZuq
	GbgR05KwDYNf3SCl4ni5dAvLYMbi4JSfTwevCCOvwdylH9zkKtgjxVL5
X-Gm-Gg: AYBFou3+l6llEgNaJKLfIAXtYfUXusH9z1hJxjbZotWtK/TnREV48XMtC2N6tsH49Em
	AnAdbz3t+2Gfm6iagHiJRTXfffsT57/K5217X0ri7fs1qNpinndYQu2OnDc5yxz5mx6dFoa656s
	8H7Yfwk7xVwknUuBkg9B7K6fzcEHwzoxnsUFBQSpffMZctphAarQsc90eF+qJgJ5mArxFJ9njxP
	nVq1BM6pmzOE+HBcWOCjrwQYYiRS1LeZ71o1USChxEGemQEH7Ojwzy0NMDKbK6bYV60CmU+2IGZ
	+mJUzgG80r020r8U++Erq7vaPb37n2g0NllG+X+ojdNijoHolkpBkLlhE48Hhk0hj/3GPMjgUJ8
	XVYEucraclJkjoEWl/WuuioQDdMHg5oTL2P0CIIBOLpYkymEoEwwwTl/Cx/lC7K21tHad2Qmz3h
	YIRZWl0QP3q+qPR0+zNPqXykv9LtrUxUeycbFeptnbPD572IaIVdnllGc9SmAvqgZY+kX9qq9cF
	kMuc3xau0kQT1rKIXCvdGpzXF0DAjWxkOwDSw7zciHqRp/JDfOeV6QOrxAivr5LIdg6nbnoxo/V
	elY31DT4JD8S+IqaSJLz/u8RRPw3Ljdx+1D/IBOGO7YpU0mq
X-Received: by 2002:a05:693c:8012:b0:376:203e:7d7b with SMTP id 5a478bee46e88-3768385dbc3mr2405165eec.2.1794387899983;
        Wed, 11 Nov 2026 01:04:59 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ff2ab59sm14180891eec.6.2026.11.11.01.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:04:59 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HSI: ssi_protocol: don't cancel_work_sync() under ssi->lock in ssip_reset
Date: Wed, 11 Nov 2026 18:04:47 +0900
Message-ID: <20261111090447.3047656-1-hj351016@gmail.com>
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

ssip_reset() calls cancel_work_sync(&ssi->work) inside the
spin_lock_bh(&ssi->lock) section. cancel_work_sync() calls might_sleep(),
so running it under the bh spinlock triggers "BUG: sleeping function called
from invalid context". In addition, the cancelled work ssip_xmit_work() ->
ssip_xmit() takes ssi->lock itself, so waiting for it while holding the
lock can deadlock.

Move cancel_work_sync() out of the locked section. It still runs in
ssip_reset() before teardown, so the use-after-free fix is preserved.

Fixes: e3f88665a780 ("HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/hsi/clients/ssi_protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 7c6ca8391a6b..96c20850fd66 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -397,11 +397,11 @@ static void ssip_reset(struct hsi_client *cl)
 	spin_unlock_bh(&ssi->lock);
 	if (test_and_clear_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
 		ssi_waketest(cl, 0); /* FIXME: To be removed */
+	cancel_work_sync(&ssi->work);
 	spin_lock_bh(&ssi->lock);
 	timer_delete(&ssi->rx_wd);
 	timer_delete(&ssi->tx_wd);
 	timer_delete(&ssi->keep_alive);
-	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
-- 
2.43.0
