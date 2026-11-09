Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231928;
	b=U0wrRcg+C+vojbuFuTyWOJFLE48UKQw1MLAcDAfsEmX4T6TmDdKwyQ9h7734mWUaUkZa
	 l489UIS88kETTrjmEkmQ9RRqeH/9ynlEpWo/zHldhrXcSm1F0hYz7k1zg89JCiltTBuMw
	 I8GRDizvIMWYqA82Od5HF7oCnCLhek/2dLG3fcj4pqV3tHKlalFW+loodXpEV5FGw46Fd
	 aU1xmPT09zSpgbh05TZK6vhRcd0t46CNcfs5uT5H6PWS47OP6dYwuOF5xQlQHkK9aff0G
	 uR6ZJiUu2kcZFiw+7ZydHjO8e68EmgDSDgtTwDG5Z7ml8mn0GX6nYZpSfRSfeTCoxKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
	b=BXIcRVdQWGptW1wLqXLjN+LstS440Z0NxGDMI572rSG6XT/v5xgfOQs0PqMsqflfOX+V
	 WgrSb2RsQmf89/g3GRNzRqBKQKaOkbgul85TnOU0nhdrWJc+PpgN/oE7gPYM/tXqx6guE
	 8OVXaRVXWdHxs7/9p+hS7iHxty6j2aKCYdzQZi4qLf8f1CCxv5uwpTrUhK9mkHFcn/Q9E
	 DqcY2bxdI/E1hMavSDY2zrupF5mUuauNhYUk92uEy5hVEjGmCzoJStSkP3w/ysKpLThcy
	 6HTXj24RSZBp85bpdao0fkdZrGp3d4Q57366mYeLdVaPE1IB7rCuf77/UU9mFoTZUQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lntKLG1W;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CA606D802
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B90CA606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lntKLG1W
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so331561a12.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231927; x=1794836727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
        b=lntKLG1Wz33t5Qj17jC/tC3S0IIMyWb4WPH64F0oOzWRxmWkzGRPHy5SJSuJIMKfZm
         Xjw3giTGvEKF97qFw8CSiRId0IdtdkLIZ1BB2z97PVXdqcWDR7PighHDGpUmoZ7fqG2X
         MDlenkCrXSjTl6R63MZKr06JUwHvyraCtHLF8Dzo4qe+PwPlRzSlrod39B5S69V8TyL9
         xxmXcgvQxUIYgVr0f17mPipJ1Y3RblEwuqLsQGbFJU+nV+S3s5B12GiH49bAeh9n/3mD
         SRl8FJpdCdg8flaAN8vVgmuYKh2yljVGLClNOD4BhBgZQBwbALYG1wnbubo7kOXGhyQE
         ofPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231927; x=1794836727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
        b=h4xbt0RK3Li0h3dkcZ9Vr8gK/n4fBsOyCWK2/gcMs/na5fdsReFONMXQabjvffZqU8
         Z7/N7ivoeallyqEdFoDriYMeUcTVpUGGIcae7CkjfrE0DDt/beJEigNZ/7ezvh6ivqSS
         nyZV5YwRPClrwsluQk93cWMp8iFR220WYlyYhaF1Al/LjywfkFHvD5aY37mf/Gh12AmT
         cqEspov/xrgQPGTHU2Rci+BuqVa5XNInIz84b6C/TOUOKUJNkyOKa1OkE17Rz0KHJDPt
         Ap/lx2xpnSTYZu3kEGcoqZ/DFK+qmbp50i/DmTJMyIdCwANE6QD+rfHOQyUneg98inkK
         ByPg==
X-Forwarded-Encrypted: i=1; AL+hErHemLQDOKGslmmm3wgUVrv2QNAmFTIRPmX2AvNlquOthWsRFf8qe0FmjdDbvZcn1sEmwS2Jxuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/a0FQJ25uOs1emW5pJaIZIxufIslPMuG0FtFJsxPy1LAB2hpQu
	e/1UEG6l971r10L37KyD7aU8DU3pG+eGVR6xJQeWqGTqT9aiEyFfyt99
X-Gm-Gg: AYBFou04V3GKaET8FHdUnj8t1TYryydwPWlI/4nuTOub47SLODJ30D6URll8/PPz1FQ
	Oq9N7tWxq9mFvj+yXx7VK55xyKi++jr4ns/7fp9lLrTMPfvGk7k8BqaVOK+JgswiqzyXgyQrY9F
	yTV6eQRAHDUDXgbL2yUTtdwOzhtHTO3s0WWuhPT9hU0MWm1ghpxy1iTQnIUNB0+5vfgmVMXdqp9
	hojpvai5ARWlx0wEy7hFHs/h/6yS/3lLm7uAXsKO01Voz/9d0OOdjdNovkmw1wuLt4BvvSF5Y1+
	Wm976ElELMnLIBmLhJFZjKrLOLFvyle3GWU+kb9MOZg2sTCbF3Mxsn6C/zQltWS46Jp+DY5G8Qv
	qjHfxMhxF5jcOUGyAscQRNDnoWX4cGNaF+CJPiZS5qlX9eAmgts1jmlZerOhyAt9SAOok9mwdyf
	o7FJAETej5CbQN7cyobakpt8gWPK5K+R+SSCH2anwjPUzKJSbQq3I4nCAJ3HFxNpnyuF9+ND8Zo
	9cBW4Z8iTOlzjCAcYa9Xx6JlH2lBamOYNAiX2W1ZsvVxPngxp7KQDDhDkpRT0JyoGzN0crLGRpG
	ogBUf7OaNzUHpntUSY7enFNPa9V0
X-Received: by 2002:a17:903:3890:b0:2ea:1b9b:b938 with SMTP id d9443c01a7336-2ed83791011mr36027055ad.55.1794231927034;
        Mon, 09 Nov 2026 05:45:27 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81727f9bsm11014285ad.57.2026.11.09.05.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:45:26 -0800 (PST)
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
	rmk+kernel@armlinux.org.uk,
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v10 1/3] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Mon,  9 Nov 2026 21:45:04 +0800
Message-Id: <20261109134506.2794160-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109134506.2794160-1-zxyan0222@gmail.com>
References: <20261109134506.2794160-1-zxyan0222@gmail.com>
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

