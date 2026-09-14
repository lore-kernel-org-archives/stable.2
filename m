Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F63F5BE6
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374844; cv=none; b=c/gbzEYsCaCx4OAGGygg/e7+GhSsQdd93s/Q8WFDDpFIw2cm/cCYTNe0kGqoIEVKfFH4YgnGhqtH4TeLxSN4R4qaFwWyfFJLwrTIpVUOjM6HC7bVkDQ+VH8PV4AP0r3AVziLNAHiiV4RVPDWt6WbyDKxAhghpcrZhh7qJFUOuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374844; c=relaxed/simple;
	bh=Fr43OwQSMJF5lVue8z+acADolENdoITfa6IP9fb9US8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WQvagr1nh4q31+gWiAnlA9E8i+fogUMpnzwsVQ2EWIctVr/15mZvZnVM6yBlC75pNAdq8sfv7d+ssuGmM3dgnUt+eCP2D8LXZ8oGqrOhlNuxOJrqEeqzlIphc+gaN1X/mUDfN4yVB2NaAVN0GVaAimyqoYuH5dII1Vun3fKrNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IOR8Boe6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IOR8Boe6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6C2E8C62209;
	Mon, 14 Sep 2026 08:34:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68C4360323;
	Mon, 14 Sep 2026 08:34:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1561811C7AFDB;
	Mon, 14 Sep 2026 10:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789374839; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=PeLVjuGbstuhVlvHBxThm6mjqWcPlcS3KrEkWoO+f7s=;
	b=IOR8Boe6l6SO8A0EM5wkQgu0ZwHEvDsaMorvOguoHqTIzPqFNdkhTxfuL3iEQJnlXZUq5D
	faVN1lPeKfqAqAMb672zNXwtmCafEPleDb61H5d1IOnBHv53LaI1uNSdIJ+X3msup9D3c6
	vqFvVgvBT3Vr+5kTUKWgbfsUY+rd6XsacBM2GWiQHwtJaVA9ej7UMRxkty88ELmDHEFuc9
	qnXeZUzX+0ivd+lMfk2HKW06aMzQm28dwLMKWmHijciEoF0Rr7Hm4og/ykAvoZOOOMrnMA
	ck3nXWuiE5BbOl2BTLXIUySxg+8nG9QAYfNSC01gvxIqsjlVmimSIzV1qKPIaQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 14 Sep 2026 10:33:51 +0200
Subject: [PATCH net] net: dsa: microchip: Save the periodic output flags
 and index
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-fix-perout-v1-1-9f45531a7585@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsEkSvtKdCjdai8Wa0Ug/j3pO
 AwzCSIJU4ShSiD0cOQjFGjqCtw+h42QfWHQSnfKNi2u/OJJctwXOuNsrxdjfb9CCU6hYv/ZCIE
 umHL+APFkXHthAAAA
X-Change-ID: 20260914-fix-perout-c8c972b89d7f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christian Eggers <ceggers@arri.de>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

When the periodic output is restarted, the request flags and index are
always set to 0. So if a pin other than the first one was used, or if a
flag was set in the request that triggered the periodic output, it is
lost when the output is restarted.

Save the request's flags and index when the periodic output is
initialized.
Use the save flags and index when the periodic output is reset

Cc: stable@vger.kernel.org
Fixes: 1f12ae5b6760 ("net: dsa: microchip: ptp: add periodic output signal")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 6 ++++--
 drivers/net/dsa/microchip/ksz_ptp.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 39cc70d65900..4f924df9e32b 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -222,6 +222,8 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 		return 0;
 	}
 
+	ptp_data->perout_flags = request->flags;
+	ptp_data->perout_index = request->index;
 	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
 	ptp_data->perout_target_time_first.tv_nsec = request->start.nsec;
 
@@ -795,8 +797,8 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 	request.start.nsec = next.tv_nsec;
 	request.period.sec  = ptp_data->perout_period.tv_sec;
 	request.period.nsec = ptp_data->perout_period.tv_nsec;
-	request.index = 0;
-	request.flags = 0;
+	request.index = ptp_data->perout_index;
+	request.flags = ptp_data->perout_flags;
 
 	return ksz_ptp_enable_perout(dev, &request, 1);
 }
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 7067ec9bd1e6..da6a2efb23d7 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -31,6 +31,8 @@ struct ksz_ptp_data {
 	enum ksz_ptp_tou_mode tou_mode;
 	struct timespec64 perout_target_time_first;  /* start of first pulse */
 	struct timespec64 perout_period;
+	unsigned int perout_flags;
+	unsigned int perout_index;
 };
 
 int ksz_ptp_clock_register(struct dsa_switch *ds);

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260914-fix-perout-c8c972b89d7f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

