Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776065;
	b=G3N0Izz9vqm63qVn7y9uu57Loz1Bvnb2nnbF99t4TAXY8KmgSMfKD59pENch4+Xt7Svi
	 rbwhV4SH4MMLHh/1TW10tuai52fmtj5qIxZsqqPkWTEgnirTW7DBFPkOZ/Nr0J68Vliga
	 vAaxkgxJ+3vxnpkcyoWNwPNg+m3Y24MqmAZOLhIB31XsJ4Mu8udrO2kDp5DDN8K8oYWL6
	 n1ABtKcMrJX6ob+JnD0pjfZgVIAcyfxHmSBHjao4U5/0Dn0qQf3/cAoDThAkSCw5ZNUkg
	 mThIbYGQ3CWmK85zpydTD11EHk7gnpKhBDlXvDmOdz7EaIaFYqtBEdxYB4t9u1i2CzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=N20fGOx6HVq4KHr1wxvnFvc1GZbdma2ueBGXHUzirkg=;
	b=Opwghlj2x/saRz0uWB9c26HvxlnC1oaQTrJIQY5beJgYC5O45zE576NB5dj8+UI3bf7m
	 0din9pjfUFqOzicEP80vR8PQtcWTTxUGr9gj4W1uIqJjRTXDj5RLVCQWvvCplXoNP3edS
	 nbjymO3ARf2/5XP7Gbqt42kRiCSotRjnbFdwuAH+BkM0QG8JajNO6vrrqkqhu14dSZTmk
	 CeHFYDn+gyOvElKujCoYypXcpPnk+h39ZwFRtBzSoXJaAswsX0arCdvuFcNtxXJDDEBQA
	 kUM2sfaH3TlxLjwTCdexo5PK2xkEhuMj3239GhLPVlxSLEo7SzTnzS00sZGeehgB05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=6NGKMMJ+;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AD606A6BB
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04AD606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=6NGKMMJ+
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so4968804f8f.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1795776063; x=1796380863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N20fGOx6HVq4KHr1wxvnFvc1GZbdma2ueBGXHUzirkg=;
        b=6NGKMMJ+zGpniK0z8lLNVGpJJkAxHbacv7TQ6r49VLB6XpOEqyfXP6qoAc5MO+vJ8o
         nLNz8+NQmY5EEJfR73XL/bZAqhSzxGTbnmgY0u3gtPEwvdLmfGCfZowHJ5RJGQYiGzPj
         MwmQuwa+W8+VrbWQJtPBofdtzj73kPBd9AG5itNgmov6xmXpGqtBGMjtv+wgdU0TTnmj
         NRDWqBQsTyFMTmdrPMrxTv2BcGwk6R8OMfQ4Pm+zFQfSR2EtykQ4iI4swoQfbIEMWURr
         wiwQJaqlnZT9CtUXfPUsbh9n5ClTul2cXp1DSV/m595HdKG11ZnIYrwRNXzMkX+qwIsL
         54YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776063; x=1796380863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N20fGOx6HVq4KHr1wxvnFvc1GZbdma2ueBGXHUzirkg=;
        b=tZsV4GYIOn0SjcTPHmPYIZ1BupzJhxximUmAhj5miOw8HSmi7WBe8tOD8CmX5gzJlw
         e9QI/0pe5wq3Xlcrf5rH4hiOTkoFhnEB/LNjN5jZNUWOmQejG3yoOuWwNWFkKz71jzOW
         w8An/TkMDZ0q5Su9cXfFFUYe3SUDirz/eNfakfeRPiG6oP6SfsAybVJbT88c+sbcLQUA
         Kk+SB8hPSEulS0OKUDKV05D1b68eDs+NJS68AphNtIqBLIm2R1iWOa9/vCUVLlbeDsy5
         SpxsCO/Dr11VUb5l6m6pIbR6NflcnIpVnA9KDTfHCA/MvUfBzPNgADuGYazpi/cEy0E7
         smsw==
X-Forwarded-Encrypted: i=1; AL+hErEGcTI2jlAR4FLwidrHkvW76GQsIaKPCFcBGaBHYHlc+iY+NeIE1LYSUS2WYvuJ7+mdgLJ4C9I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cv6VxgJQcp+60DzJuDpvVcb5uioSzEQG3rDpj4yImxRSwa1S5
	RR9zVpAJ2XzfRr09KyYrbC/r3GrOGlbYr2kbIUnT2uELsYH5w8XVjXW7cCu07/unOMw=
X-Gm-Gg: AZFdTZeIuE02LvcK9J0b9ijYAJwz1TJfYOjmI6zSBwUuYmEefDYV4OH5ia/tpAf8trg
	yLqA5OwIwa1ziC3Tv3U7NX8MIDeDDhw26hOKWT7YfS5yXVo/oWVcfRpNbY7gjLENbytrLLGlm5R
	QzDkOVt8InkUKorKtcVwIcGSSl1qrKZ1JY/9x/4NMKt+w+q5nj5ic5vK4wyfhTU0mdi1W7Sl6jd
	iyREqB4y16LLtfBlmQtjMe45c7WQo1csyUV721zFvADsh2ywlF6zu60QMG5kM9EExHRVefo6GEm
	VCBQUT2knqyef2rooEjsI8OJ/OCWiniJBguiYxPWZC797Pjci7Ijjli6u5sE85hw7UFE3Sj0nPh
	G5hH1V9TLo30ZQNSR3OQcfRQE6A5QCH1HqcJ+sFoMHqwURjXfd59H8vN6JXrvLj7hqSdLFFiDP+
	m2H3pWfAvprtg18KO5Px3wDWc4m22AKvUTqJjuuCx45Gw40TqKW6ElTjs4l4/0j74zFJKyIxSef
	qoNMV9EX8Y4z4j5IWVxnqc01DeoGvh5VyY5W8UQ+w3Nic9E00iiOOMjdmIXXjeaq7rL8/eVTixy
	JR0gPjW0zCeC2knZccQVAIZVivfOL3kpRYuwCUJsjRubT2spoKNrJMY900R+dGMmhVF/7QmgSRr
	a99J0TAAC
X-Received: by 2002:a05:6000:490a:b0:4b7:80c1:11bd with SMTP id ffacd0b85a97d-4b780c1127cmr20888918f8f.35.1795776063087;
        Fri, 27 Nov 2026 02:41:03 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm45597649f8f.32.2026.11.27.02.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:41:02 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 27 Nov 2026 14:40:48 +0400
Subject: [PATCH v2 3/6] usb: typec: fusb302: Read out the RX FIFO rather
 than flush it as PD RX goes on
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-fusb302-getsourcecap-v2-3-6770eb1e7945@flipper.net>
References: <20261127-fusb302-getsourcecap-v2-0-6770eb1e7945@flipper.net>
In-Reply-To: <20261127-fusb302-getsourcecap-v2-0-6770eb1e7945@flipper.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Yueyao Zhu <yueyao@google.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7439; i=alchark@flipper.net;
 h=from:subject:message-id; bh=O5zo30DMU4B42IcNMdWqxNCDgBR82hr7Up/HY/MQfVU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRzxpntFF69/02s2QP+8qyseU8XJGo16HCVXxA1Ei+9/
 WWxuNW1joksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKZ6TR0jwwoTswNXfpccP/qk/OCMbv38ALMX6c5bZaZqiaz1X3rcnoGRYbf+yXW
 7p3TPshPaHXl0xbunHCqr+vbW3sn62Pil57BsKw8A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Messages that come in while PD RX is off go unacknowledged, yet the chip
still queues them in the RX FIFO. Turning PD RX on flushes the FIFO and
only then turns automatic GoodCRCs on, four I2C transactions later. A
message that lands in between stays in the FIFO with no GoodCRC sent,
and the driver hands it to TCPM all the same. The partner, failing to
deliver it, keeps its MessageID for the next message, and TCPM drops
that as a retry. On a Flipper One attaching as a sink, this happened in
1 of 30 attaches: it took in the first Source_Capabilities that it
never acknowledged, dropped the Accept to its Request, and soft reset on
the PS_RDY that followed. The flush can also cut short a packet coming
in, leaving the rest of it to be read as junk.

Read out and drop whatever is in the FIFO while CC is idle, turn
automatic GoodCRCs on, and then pass on a packet that was on CC at that
moment only if the chip acknowledged it, and any that came after it in
any case. The chip decides that at the end of the packet, and ACTIVITY
drops between a packet and the GoodCRC to it, so wait for CC to stay
idle for longer than 195us (tTransmit) before looking at GCRCSENT. Should
CC stay busy instead, flush the FIFO after all, as what the chip
acknowledged is then unknown, and should anything fail, turn automatic
GoodCRCs off again, as TCPM then treats PD RX as off.

With PD RX turned on 0-30ms late in 39 attaches to a partner sending
Source_Capabilities, every copy that came in before is dropped now, the
3 caught on CC as GoodCRCs came on were acknowledged and passed on, and
every attach reached a contract with no reset.

Fixes: c034a43e72dd ("staging: typec: Fairchild FUSB302 Type-c chip driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/typec/tcpm/fusb302.c | 124 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index d57f9ae6621d..5cf1b78e7669 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -133,6 +133,8 @@ struct fusb302_chip {
 	bool rx_resync;
 	/* Only look in rx_buf, as the FIFO has nothing more of what it holds */
 	bool rx_buf_only;
+	/* Drop the messages read: no GoodCRC went out for them */
+	bool rx_discard;
 	bool vbus_present;
 	enum typec_cc_polarity cc_polarity;
 	enum typec_cc_status cc1;
@@ -900,6 +902,8 @@ static int fusb302_pd_set_interrupts(struct fusb302_chip *chip, bool on)
 	return ret;
 }
 
+static int fusb302_pd_rx_start(struct fusb302_chip *chip);
+
 static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 {
 	struct fusb302_chip *chip = container_of(dev, struct fusb302_chip,
@@ -912,22 +916,26 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 		goto done;
 	}
 
-	if (!on)
+	if (!on) {
 		fusb302_pd_set_sop_prime(chip, false);
-	ret = fusb302_pd_rx_flush(chip);
-	if (ret < 0) {
-		fusb302_log(chip, "cannot flush pd rx buffer, ret=%d", ret);
-		goto done;
+		/* What this cuts short is read out and dropped on the way on */
+		ret = fusb302_pd_rx_flush(chip);
+		if (ret < 0) {
+			fusb302_log(chip, "cannot flush pd rx buffer, ret=%d",
+				    ret);
+			goto done;
+		}
+		fusb302_pd_rx_reset(chip, true);
 	}
-	fusb302_pd_rx_reset(chip, true);
 	ret = fusb302_pd_tx_flush(chip);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot flush pd tx buffer, ret=%d", ret);
 		goto done;
 	}
-	ret = fusb302_pd_set_auto_goodcrc(chip, on);
+	ret = on ? fusb302_pd_rx_start(chip) :
+		   fusb302_pd_set_auto_goodcrc(chip, false);
 	if (ret < 0) {
-		fusb302_log(chip, "cannot turn %s auto GCRC, ret=%d",
+		fusb302_log(chip, "cannot turn pd rx %s, ret=%d",
 			    str_on_off(on), ret);
 		goto done;
 	}
@@ -1677,6 +1685,10 @@ static int fusb302_pd_read_message(struct fusb302_chip *chip)
 
 	fusb302_log(chip, "PD message header: %x", msg.header);
 	fusb302_log(chip, "PD message len: %d", len);
+	if (chip->rx_discard) {
+		fusb302_log(chip, "PD message not acknowledged, dropped");
+		goto out;
+	}
 
 	/*
 	 * Check if we've read off a GoodCRC message. If so then indicate to
@@ -1835,6 +1847,102 @@ static void fusb302_pd_rx_recheck_work(struct work_struct *work)
 	mutex_unlock(&chip->lock);
 }
 
+/* Tries at reading out the RX FIFO, before turning PD RX on */
+#define FUSB302_RX_DISCARD_TRIES	4
+
+/*
+ * Turn automatic GoodCRCs on, and keep messages that came in before from TCPM:
+ * the partner, failing to deliver one, keeps its MessageID for the next, which
+ * TCPM would then drop as a retry. Read them out rather than flush the FIFO,
+ * which would cut short a packet coming in, so that the chip may acknowledge
+ * it and leave the rest of it behind. A packet on CC as GoodCRCs come on goes
+ * to TCPM only if it gets one.
+ */
+static int fusb302_pd_rx_start(struct fusb302_chip *chip)
+{
+	bool gcrc_on = false;
+	u8 status1, interruptb;
+	int ret, i;
+
+	chip->rx_discard = true;
+	for (i = 0; i < FUSB302_RX_DISCARD_TRIES; i++) {
+		ret = fusb302_pd_read_messages(chip);
+		if (ret < 0)
+			goto out;
+		ret = fusb302_wait_cc_idle(chip, &status1);
+		if (ret < 0)
+			goto out;
+		if (!ret && (status1 & FUSB_REG_STATUS1_RX_EMPTY) &&
+		    !chip->rx_len)
+			break;
+	}
+	if (i == FUSB302_RX_DISCARD_TRIES) {
+		fusb302_log(chip, "RX FIFO keeps filling, flushing it");
+		ret = fusb302_pd_rx_flush(chip);
+		if (ret < 0)
+			goto out;
+		fusb302_pd_rx_reset(chip, true);
+	}
+
+	/* Clear GCRCSENT: nothing sends GoodCRCs yet */
+	ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTB, &interruptb);
+	if (ret < 0)
+		goto out;
+
+	ret = fusb302_pd_set_auto_goodcrc(chip, true);
+	if (ret < 0)
+		goto out;
+	gcrc_on = true;
+
+	ret = fusb302_wait_cc_idle(chip, &status1);
+	if (ret)
+		goto out;
+	if (status1 & FUSB_REG_STATUS1_RX_EMPTY)
+		goto out;
+
+	/*
+	 * ACTIVITY drops between the end of a packet and the GoodCRC to it,
+	 * which goes out within 195us (tTransmit): see that none follows
+	 */
+	usleep_range(300, 400);
+	ret = fusb302_wait_cc_idle(chip, &status1);
+	if (ret)
+		goto out;
+	ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTB, &interruptb);
+	if (ret < 0)
+		goto out;
+	/*
+	 * Only the packet that was on CC as GoodCRCs came on can have gone
+	 * without one, if it is in the FIFO by now: whatever lands after it
+	 * got a GoodCRC from the chip
+	 */
+	chip->rx_discard = !(status1 & FUSB_REG_STATUS1_RX_EMPTY) &&
+			   !(interruptb & FUSB_REG_INTERRUPTB_GCRCSENT);
+	if (chip->rx_discard) {
+		ret = fusb302_pd_read_message(chip);
+		chip->rx_discard = false;
+		if (ret < 0)
+			goto out;
+	}
+	ret = fusb302_pd_read_messages(chip);
+out:
+	if (ret > 0) {
+		/*
+		 * CC stayed busy with GoodCRCs on, so which packets in the FIFO
+		 * the chip acknowledged is unknown: flush them all
+		 */
+		fusb302_log(chip, "CC busy as PD RX went on, flushing RX FIFO");
+		ret = fusb302_pd_rx_flush(chip);
+		fusb302_pd_rx_reset(chip, true);
+	}
+	/* TCPM then treats PD RX as off */
+	if (ret < 0 && gcrc_on)
+		fusb302_pd_set_auto_goodcrc(chip, false);
+	chip->rx_discard = false;
+
+	return ret;
+}
+
 static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
 {
 	struct fusb302_chip *chip = dev_id;

-- 
2.56.0

