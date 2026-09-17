Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1B48E0C8
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634377; cv=none; b=LyF6oTSr5XxVipqwMSft5w0Wo5W6K6bnUl+JN5bVdU72tDdKGzPzGLabfg8O7oJsrHi+QNZH+JSTlm4GDN3oCVmjag91ODqI6psZeaWm741bpFGnPMOTnoWNzOyKfxWHGU4T5NXDzUGbGRB588VUfQF4jSQAOAOGMv8CYjEGEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634377; c=relaxed/simple;
	bh=XvreuLeOtfvNywpcxb8bwQSkEogyi1YRQ/XuBi2qtaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KarSmvV22X+3yUUWn1iUWZwmhGHQ1FmbmquY7wrNMNY0DwzKvIkJGR22c6kEawbMsA/6oSEkmqzMrO2owm1vPME9za1ue/qnk34mjvYUbr3pFotQSRnJ6ZQvruowllxjpBSJR1HksaQoclQqAsX9MxehFzsDgZxjMlN9jifmFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p43hO+iZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p43hO+iZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C570E4E40790;
	Thu, 17 Sep 2026 08:39:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8D6965FAA3;
	Thu, 17 Sep 2026 08:39:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B3DF11C7B03D;
	Thu, 17 Sep 2026 10:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789634351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QuoRrFfTxIZUivKnEfDlkI8xh2XYY3hVccu5BeUQVu0=;
	b=p43hO+iZNKIVcVxx0knz5+yLFxD+GWfHsSWNxKV047TChC0YUx5bFYrHLZUv3OPEUZTgu2
	cE/YxOyAjapcOisgMFuumn+H3mvQj9Kut6fVmGJx4mQQTkwatNSTUHsIenzvzft4mT62C3
	zlxq7OLFrxkSeTKuVEX6ApPdq9D+5GQ9BNF2r56Scobfr8YVnOnSDitvxotPURizwFP6oM
	Kk15WmMFy9E2NcpbtYbUt+CCtbTWa1cXvSNO2tIRvXKEb6TYrWj09i40wc2ZNTW8yZBhuH
	bHA7VwkIcp5zJdb4SghgU+4RnM5v7rJIBOS318ijEdcvWR8ABi9W15LMn/7c+g==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 17 Sep 2026 10:39:04 +0200
Subject: [PATCH net v2] net: dsa: microchip: save the periodic output
 request
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-fix-perout-v2-1-d8acf3eea6f7@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBREr9L8tZiCRaAr72G6aOnH/kShASSap
 neXdO1y5mXebJAwEibomw0iFkoUfA3i1IBdRv9ARnPNIFpxbQ3vmKMPWzGGd2ZWW6PEpM2sHNT
 BGrHSQ3YHjxmGWi6Ucojf46DwA/1zFc44M66T8sJHJbW8TSHkJ/mzDS8Y9n3/Af7w4xOrAAAA
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

When a periodic output is initialized, only the start and the period are
stored, not the flags nor the pin index. So when the periodic output is
restarted, the request flags and index are always set to 0. So if a pin
other than the first one was used, or if a flag was set in the request
that triggered the periodic output, it is lost when the output is
restarted.

Save the full request when the periodic output is initialized.
Use the saved request when the periodic output is reset

Cc: stable@vger.kernel.org
Fixes: 1f12ae5b6760 ("net: dsa: microchip: ptp: add periodic output signal")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v2:
- Save the full request insead of only flags and index.
- Link to v1: https://lore.kernel.org/r/20260914-fix-perout-v1-1-9f45531a7585@bootlin.com
---
 drivers/net/dsa/microchip/ksz_ptp.c | 30 ++++++++++++++++--------------
 drivers/net/dsa/microchip/ksz_ptp.h |  3 +--
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 39cc70d65900..0979b6e04d1e 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -189,6 +189,7 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 {
 	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
 	u64 req_pulse_width_ns;
+	struct timespec64 tmp;
 	u64 cycle_width_ns;
 	u64 pulse_width_ns;
 	int pin = 0;
@@ -222,13 +223,11 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 		return 0;
 	}
 
-	ptp_data->perout_target_time_first.tv_sec  = request->start.sec;
-	ptp_data->perout_target_time_first.tv_nsec = request->start.nsec;
+	memcpy(&ptp_data->perout_request, request, sizeof(struct ptp_perout_request));
 
-	ptp_data->perout_period.tv_sec = request->period.sec;
-	ptp_data->perout_period.tv_nsec = request->period.nsec;
-
-	cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
+	tmp.tv_sec = ptp_data->perout_request.period.sec;
+	tmp.tv_nsec = ptp_data->perout_request.period.nsec;
+	cycle_width_ns = timespec64_to_ns(&tmp);
 	if ((cycle_width_ns & TRIG_CYCLE_WIDTH_M) != cycle_width_ns)
 		return -EINVAL;
 
@@ -249,9 +248,10 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 	if (ret)
 		return ret;
 
+	tmp.tv_sec = ptp_data->perout_request.start.sec;
+	tmp.tv_nsec = ptp_data->perout_request.start.nsec;
 	ret = ksz_ptp_configure_perout(dev, cycle_width_ns, pulse_width_ns,
-				       &ptp_data->perout_target_time_first,
-				       pin);
+				       &tmp, pin);
 	if (ret)
 		return ret;
 
@@ -763,6 +763,7 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 	struct ptp_perout_request request;
 	struct timespec64 next;
 	struct timespec64 now;
+	struct timespec64 tmp;
 	unsigned int count;
 	int ret;
 
@@ -773,10 +774,14 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 		return ret;
 
 	now_ns = timespec64_to_ns(&now);
-	first_ns = timespec64_to_ns(&ptp_data->perout_target_time_first);
+	tmp.tv_sec = ptp_data->perout_request.start.sec;
+	tmp.tv_nsec = ptp_data->perout_request.start.nsec;
+	first_ns = timespec64_to_ns(&tmp);
 
 	/* Calculate next perout event based on start time and period */
-	period_ns = timespec64_to_ns(&ptp_data->perout_period);
+	tmp.tv_sec = ptp_data->perout_request.period.sec;
+	tmp.tv_nsec = ptp_data->perout_request.period.nsec;
+	period_ns = timespec64_to_ns(&tmp);
 
 	if (first_ns < now_ns) {
 		count = div_u64(now_ns - first_ns, period_ns);
@@ -791,12 +796,9 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 
 	/* Restart periodic output signal */
 	next = ns_to_timespec64(next_ns);
+	memcpy(&request, &ptp_data->perout_request, sizeof(struct ptp_perout_request));
 	request.start.sec  = next.tv_sec;
 	request.start.nsec = next.tv_nsec;
-	request.period.sec  = ptp_data->perout_period.tv_sec;
-	request.period.nsec = ptp_data->perout_period.tv_nsec;
-	request.index = 0;
-	request.flags = 0;
 
 	return ksz_ptp_enable_perout(dev, &request, 1);
 }
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 7067ec9bd1e6..eb3827203b96 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -29,8 +29,7 @@ struct ksz_ptp_data {
 	spinlock_t clock_lock;
 	struct timespec64 clock_time;
 	enum ksz_ptp_tou_mode tou_mode;
-	struct timespec64 perout_target_time_first;  /* start of first pulse */
-	struct timespec64 perout_period;
+	struct ptp_perout_request perout_request;
 };
 
 int ksz_ptp_clock_register(struct dsa_switch *ds);

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260914-fix-perout-c8c972b89d7f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

