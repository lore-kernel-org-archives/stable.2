Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796644;
	b=XYTWBJNZf/J1hJ9GLFVs9sE5ezDfr+ozlzlLDYzYbdmf0gKav0QCjea22y5Lgm3Nl3f/
	 WfclRxD9q9OxKymqfYO9/7nWtF02JxPBCNENnfOflZeeL5BRqk9iQarT4dL9ntAYmmBiF
	 L2Wj+7R57VVgOjCmcXBEOOqoX0OjUf10TA1+iE7UWwZWjWGj6jwlcrrWX3pcspQ69OKbD
	 yMo7rQhxOYr6k0t6+49cy7RZM+8FpIOw+P97Y+vlrKuSYXn5tvq668eiML180TgGlpoKD
	 kofqGMgp+bptEXfwuCyLftx9+NJhgIYPbyLt7WCLFDiXVZXo2OtPvxepNt9wDmuiEFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
	b=U0UpIgjcDlGegc4bvlxb08h04jzjxuvttVFyaK6UQD4cEqjw0j8RO0SOBYMkkpyFiLOF
	 1PDSazDhoAXE7GIJfPwmygDYl900sJqfMQh496cWep5cJlQ76Ku5CizM/w+tdIIchg1tM
	 Aqf13ieeuUXKBe1rtet6taYcnQ8RihAl0BE6HUgWxmPQr+nGW3f6MW2aoCjOI+aXbu/DY
	 eq7YXI7q43PnOJOWUMF0zu/h1Y5YgL+sWSQPRE26/4odQwhlLOyJWmbtzMTcGHqz/IBdM
	 5UBoY4lJB/91f/X00D9pdrPqLBBB3yGQL5hGxc4H8Xx/MPPq9KEpgYEGv3E6YXKYtIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMFbhM2y;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C99606D80C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3C99606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMFbhM2y
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so391260a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 04:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793796643; x=1794401443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
        b=sMFbhM2yZqNp1QsenblfNuflgzQqV1qIObFqoNvDmLTQFwizMshMoTwqd8c4j1nWgZ
         9Gp9IJfRt46fUxRXrTIak+2sUq4S47NY9nxJfxRMpK8imKTNijaiNhaw+2yJMJOEsZFd
         VUawj8RRrkmetGzGGDk0flaVR2vTq6H2HA78cfwxkFN1qycwxpZ2YFu7VgMZpiQKyaiD
         ILfLXOB9ZC92ffaonCtnpKqFmonnZonmbaFltOqJfl7BZKMCRQlkb0rXVLgbLWizU0K/
         Dv3V41nHfiKuMxTcoPr6OH3+53EAvEPhOwTuWXayNZRvm0Kca6vSCVav8JoPO+45nmhZ
         pw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793796643; x=1794401443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
        b=Xq5vl+ri+yDwoeg9iPwiWXcSUGQZQFm8wWdy2YeM9B1cPH4R6O3HK9kEODJNwBwUDY
         eNM9m//1qtdHTm5ZcqLUM4NT00UZx/Xa5CgH62dt/Gm2Aj3Z4KtlxooJqzA7X1WLzk9z
         +VakShHkIhlVN2LcUiuLT4CrSoBkcb1GMROfwPEmt7hLp/kfDyJbxU8T/3CHoB7EY+Nb
         oAFVoxXti7L0gL2bf/IHHJYU5J1x/CWZ+bgWCkx2lXmuxsKyPxIg6EtY3fUrwd138XTS
         QI58Wo7XMpHq7IrCicqimMO500KLcRxaOJaGd2J4fHYRncCruBDwstvrQVzO1fp0vfW5
         Z0Ig==
X-Forwarded-Encrypted: i=1; AKwUvByVfVYh0yIk68ffcf5sA5e98zguwTP6zYvpFRVuSc5EUkflR1ihTqgy0KhbtkIk1yBX2yJnt5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+L0tXTjeA/XRSZZ5DiKvbJwaZmDDadlb8AiXglJpDVJR3rzsDN
	lqgsA7vpYthJP7DWFyM3CKTwTaeWHYUALkZ5uKv+/ObcMWWjuVLFEEuG
X-Gm-Gg: AYBFou3Ai3/bPdNheXm0TJoVMrSFuv5Crqw58OBqd5xREt80QYuc4Gv9+Q3K9pkezkv
	H/R7iIz6c+z0gLirPqsoTmN2qXeZtF+3UWuve+ZLRKddQ14Xqm4H82iMBHLMm2nReKVNw5LVkWZ
	8htPi6PDZfAv7ToWDD/Qkmv5RpeTmL2nLd0fNIiVZ5+n8QJR1V77u8AQVBP7GkR/ODJTfHV+qE8
	AGOaxWU77t1/57hWSPgpBQO/GLLbHlaekNTi6jyULOGlYI31ktvhoo+LOPAMQSAG/fP5d1KrURY
	+Yal5dM5Y+qcksRPMhavFcvQH4Pkk9CgxCRYBTlAjA/EdQdPuNS3QvJSq2b8Th3Z5sr6n9ZWQTL
	ihutMzCrsnqcnhvc7knIwxPQyTYEEj9gZmsStAAGuYPKeIPGwzRin2d7HMQQiXdmqe0Qooa1YO6
	t78G6VJ+t0Srr2rBy+MIosHGN4DBF0HjOkFDYPrrG9+qeINKw2T0MFRBSQWnAcpVWphAViqxeUW
	sgQpE4KRNSt8Rp1fwwROyNt2Md4FFYMfMqteYR4c5n8aSlowGaiScj08cJLSBGFMMZ5OCgwM9Jw
	35/nrlE5kBYV9d3SnOFEpkcJZ2xy
X-Received: by 2002:a17:90b:17cd:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3ae89851212mr12650512a91.61.1793796642926;
        Wed, 04 Nov 2026 04:50:42 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm3920799a91.9.2026.11.04.04.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:50:42 -0800 (PST)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v9 1/3] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Wed,  4 Nov 2026 20:50:28 +0800
Message-Id: <20261104125030.1183146-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104125030.1183146-1-zxyan0222@gmail.com>
References: <20261104125030.1183146-1-zxyan0222@gmail.com>
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

The Agilex5 smtg_crosststamp() handler polls XGMAC_INT_STATUS for TSIS
to learn that the auxiliary snapshot is latched.  TSIS is a transient,
read-to-clear status bit, so the poll is racy in two ways: a stale TSIS
from an unrelated event satisfies it before the snapshot is latched,
leaving *device unwritten while the call reports success, and a
concurrent reader of XGMAC_TIMESTAMP_STATUS can clear it and make the
poll time out.

The FIFO level is also reported by the ATSNS count in
XGMAC_TIMESTAMP_STATUS, which reading the register does not disturb.
Poll ATSNS instead of TSIS, after waiting for the PTP_ACR_ATSFC FIFO
clear, so a stale ATSNS cannot satisfy the poll before the new snapshot
is latched.

Hold aux_ts_lock across the whole sequence, and refuse the request
with -EBUSY while a channel is enabled, so the PTP_ACR mask
programming cannot disarm it and a concurrent request cannot flush the
FIFO between the poll and the drain loop.  The lock is held across the
SMTG register reads as well, so a concurrent PTP_SYS_OFFSET_PRECISE
cannot retrigger GPO0 while they run.  The internal snapshot trigger
is disarmed on the way out, including the error paths, so it does not
stay armed in PTP_ACR after the cross-timestamp.

Fixes: fd8c4f645496 ("net: stmmac: socfpga: Add hardware supported cross-timestamp")
Cc: stable@vger.kernel.org
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 52 +++++++++++++++----
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6d4bc1fe8f75..2d3c6702e203 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -304,13 +304,15 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	int i, ret;
 	u32 v;
 
+	mutex_lock(&priv->aux_ts_lock);
 	/* Both internal crosstimestamping and external triggered event
-	 * timestamping cannot be run concurrently.
+	 * timestamping cannot be run concurrently: the PTP_ACR mask
+	 * programming below would disarm an external channel.
 	 */
-	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
+	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) {
+		mutex_unlock(&priv->aux_ts_lock);
 		return -EBUSY;
-
-	mutex_lock(&priv->aux_ts_lock);
+	}
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value &= ~PTP_ACR_MASK;
@@ -337,8 +339,21 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value |= PTP_ACR_ATSFC;
 	writel(acr_value, ptpaddr + PTP_ACR);
-	/* Release the mutex */
-	mutex_unlock(&priv->aux_ts_lock);
+
+	/* Wait for the FIFO clear, so the poll only sees snapshots from
+	 * this trigger.
+	 */
+	ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
+				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
+	if (ret) {
+		acr_value = readl(ptpaddr + PTP_ACR);
+		acr_value &= ~PTP_ACR_MASK;
+		writel(acr_value, ptpaddr + PTP_ACR);
+		mutex_unlock(&priv->aux_ts_lock);
+		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
+			   __func__);
+		return ret;
+	}
 
 	/* Trigger Internal snapshot signal. Create a rising edge by just toggle
 	 * the GPO0 to low and back to high.
@@ -349,10 +364,17 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	gpio_value |= XGMAC_GPIO_GPO0;
 	writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
 
-	/* Poll for time sync operation done */
-	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
-				 (v & XGMAC_INT_TSIS), 100, 10000);
+	/* Poll ATSNS instead of the transient TSIS: the ATSNS count is
+	 * the FIFO level and is not cleared by reading the register.
+	 */
+	ret = readl_poll_timeout(ioaddr + XGMAC_TIMESTAMP_STATUS, v,
+				 FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v),
+				 100, 10000);
 	if (ret) {
+		acr_value = readl(ptpaddr + PTP_ACR);
+		acr_value &= ~PTP_ACR_MASK;
+		writel(acr_value, ptpaddr + PTP_ACR);
+		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
 		return ret;
@@ -364,8 +386,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		.use_nsecs = false,
 	};
 
-	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
-				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
+	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v);
 
 	/* Repeat until the timestamps are from the FIFO last segment */
 	for (i = 0; i < num_snapshot; i++) {
@@ -375,9 +396,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 	}
 
+	/* Disarm the internal snapshot trigger, so the PTP_ACR mask does
+	 * not stay armed behind the software state.
+	 */
+	acr_value = readl(ptpaddr + PTP_ACR);
+	acr_value &= ~PTP_ACR_MASK;
+	writel(acr_value, ptpaddr + PTP_ACR);
+
 	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
 	system->cycles = smtg_time;
 
+	mutex_unlock(&priv->aux_ts_lock);
+
 	return 0;
 }
 
-- 
2.34.1

