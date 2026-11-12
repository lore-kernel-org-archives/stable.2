Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466580;
	b=dgu97/zR0xMwoNcmKb0zWqG3gUvyvj1y/QoDCaxeFumHl+1x4UgQscoOYZk0vmeeAqi6
	 k8FGZl/SXnMBeGPT+aazU8nJpW5CYAsAxBMvfM0RnPz7c+5VgQjYPDITWFLQPUUKpGVhG
	 eeaesHl/kadb2tEVdnlDORkt4JkNehiJsEM1yrDLdP9KQsfT4w2GOTKYPSty8pKUFLWVt
	 FEF0qHxt3el8fWeqBGUT6qPiVjrqD85Ox2Sqz65kMMPOoYJB1gMeLI79sTLt23zo2E6xV
	 5BBqwXL+T05hytYlSVwBYn5LiU6p90GLO66MPZlzwq8od8Yne8Zha6sptT6MQJxaeDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ISyFWiqCRRUPMHI/QOqOoV6Eq81C65f9fR84q9yGmq4=;
	b=BTYf9izlJV/j9uzfU6dZ+2zyLbVVpe15bP7C6uyM1KXMGi8kFoz/YrO/X5ZtMNufIngZ
	 /kEbWcMklX617q4vsssX4cCYQi3UDsRGywSWQHkC5Oj70gJS5H4xE2Cif3+3NvXyDo8BG
	 C4wtF0k07eNuua0wX4sRxkf5xrMcVDLQE83BzSCR3pNqoogG6NSW7M8HXWvy5yAr2OOfX
	 P9OWDNm0TTkLthqaSwfUEg16PEJJkBft+qSbNzjUlaeCvxnk/cL+jkpUeF12woteOUiG1
	 mJ5b6IGEfiswzpiNWX6CrFpBFdT/cV2kWK209TAvUqrWuIA8AjROD4amPaYh1qXdRFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odvJf4eh;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A97606A882
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A97606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odvJf4eh
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5364042eecfso49554841cf.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466579; x=1795071379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISyFWiqCRRUPMHI/QOqOoV6Eq81C65f9fR84q9yGmq4=;
        b=odvJf4ehN4ApwZaG7qInnaJeVXp00XWchW5Y8c0/6w7/MeOapSJXEGyKLrcXlLPC26
         ThAxZWjnXYDChcive0/WLAEML9ClSaf8uTU44FBNfw2unHz6hmTbPPVxmICioDDDwuHL
         YIV5nV58/M97KY+kL5GNcUARM8ArBz4EdewHvau3u621kjNhcFUXrPkhix6rBDUog7sY
         wXuNRvfDryBXC/56XRa9BlL7WW8dfziobpgJQ8grkbmmdmN5WkapYg6q+OHoHb/2e4za
         lk4IWaIH+8VIuda6tuK66xX8HKvrcQvboyqKBqx1o8hOwZHxL2UFoTPkL/56j3IAQ2fH
         D9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466579; x=1795071379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISyFWiqCRRUPMHI/QOqOoV6Eq81C65f9fR84q9yGmq4=;
        b=vNkb6xKeP/lJ4sBbER+acqYwFPjBaVbw2dThIwmoaOI9hExzsy922KRhFthmew5CpR
         RU7BOITbQCjkTU6+YMbTTXksycLEIUPY3zDcfOu/73DGg3TpERo7/auQhZY5NrxagPOe
         0YLfa4VxDuL/RE+Emw9NEs2qnLJJSDdz67fk+HbeKDnjAgwuvin6kimcae2tNfgScNhf
         Cg1iZ8vgr678Rd2kqmFkrtnpRQ/NtC5odbAOir7jCjUCxkWMKQgtwi6D1PnqesRqzlRw
         oFSv3ZFgJ20Dz01VaX0JTahkfwQOPdKsLOC/bEd8nw9qBh/BUu/fgCC0FK/oH57yrGHO
         hq0A==
X-Forwarded-Encrypted: i=1; AL+hErHKHeoEMmGy8RBIJBqEqrcn6rFCQGq1PmY9J76M8UUpWN88PG5gOgUPfTioDYWJmnT9Wnk6q0g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Dsnryj7RMRezl8cYiHe7M5/sDF/kjW/pN/kR0eujhqcIwY4Kt
	CUWiDRI92s1sYuEAmJezoA5a8wj+zMMHTWZW24w6u2YgwciPO1KA4mk=
X-Gm-Gg: AYBFou3eOlZ4JxrmPhs8S4ZScD+GiFZbjYb7dk0MUrLQFyruyqZ6klKIundrH5vyCgD
	6mHzBoM/cLpO/W8QFOJ1BaQHyPZva2AcxSWII0VG0H/mPFhlEmouOFLLGPEqtt8G7om0vA4rN9P
	sBy2Jft7Xp5zxuSRJWAhIuOwQmMu3814bRm1w5fWjbY7MkY/e6tRm94r+LJ3YGm2WnPo93frT5A
	gSMnaru2yb6gei0UuyY73jwxRpd65sKPda7wm/KuK5eb3wgarck3rGFYFEMDBrdpRxZX1/GdVOW
	8CydqUwifF/UM71XSyv/dqfSy230BZkvla/6CWop01c7WXQbEXd21TaB89Vovt/lp+3uo1EbIe1
	qp5FsrGDMVgyEeyuJbZnH9/FjKWUHU9qWwjIbkpXO8F9P/VIxJBQVFlNn+Ym6XjgvWhqys+XvUu
	nhlUrOcPtedScWhmKiGUSx7LT3U++/ZqvXUsP2i6VKVI1vLUm5Eo6Diek4M6BxMg9TBh/FeoQiC
	APyg9Hh0g1rK3xoAhzpGCcHaoDxHt3GmCVczqajWl3inGFyen2I0zIwSPUPgpLdAFKe5jwo/K/3
	SA2l9rqWaf8p5WPNzMjlhr9dWV1lvY2bJjtbdFB7YojxlyrqDfYD8/7rcjqMAyiPAZw/x+D6Nqm
	u6i5DmedmIs8VOgTWsw/Xusna0h6x6jV6MzfBGLDdhg2OB9+1MnO1kY18JqiYHTbIqPH+AcZJkQ
	x2QpWxVpO0qbn3cmnwurBEyiGEu7dtHfRT
X-Received: by 2002:a05:622a:c06:b0:535:1e4f:4ed2 with SMTP id d75a77b69052e-556bdfcf0e3mr75884541cf.11.1794466578580;
        Wed, 11 Nov 2026 22:56:18 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-556f374c4ccsm32807681cf.28.2026.11.11.22.56.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:56:17 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Radulescu <ruxandra.radulescu@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] dpaa2-eth: free the DPNI interrupt before releasing its resources
Date: Thu, 12 Nov 2026 01:56:16 -0500
Message-ID: <20261112065616.34209-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

dpaa2_eth_remove() and the probe error path call fsl_mc_free_irqs(),
which returns MC interrupt resources without removing the devm-managed
handler. Until devres runs, a link or endpoint change can race with MAC
disconnection or access the freed MC portal and net device.

Add dpaa2_eth_free_irqs() to release and synchronize the handler before
returning its MC resource. Use it before disconnecting the MAC and freeing
the portal and net device in both paths.

Found by a static analysis tool under development.
Not tested on hardware.

Fixes: 6e2387e8f19e ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 7227a35dfaf2..91462b88b34a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4824,6 +4824,14 @@ static int dpaa2_eth_setup_irqs(struct fsl_mc_device *ls_dev)
 	return err;
 }
 
+static void dpaa2_eth_free_irqs(struct fsl_mc_device *ls_dev)
+{
+	struct fsl_mc_device_irq *irq = ls_dev->irqs[0];
+
+	devm_free_irq(&ls_dev->dev, irq->virq, &ls_dev->dev);
+	fsl_mc_free_irqs(ls_dev);
+}
+
 static void dpaa2_eth_add_ch_napi(struct dpaa2_eth_priv *priv)
 {
 	int i;
@@ -5044,7 +5052,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (priv->do_link_poll)
 		kthread_stop(priv->poll_thread);
 	else
-		fsl_mc_free_irqs(dpni_dev);
+		dpaa2_eth_free_irqs(dpni_dev);
 err_poll_thread:
 	dpaa2_eth_disconnect_mac(priv);
 err_connect_mac:
@@ -5104,7 +5112,7 @@ static void dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	if (priv->do_link_poll)
 		kthread_stop(priv->poll_thread);
 	else
-		fsl_mc_free_irqs(ls_dev);
+		dpaa2_eth_free_irqs(ls_dev);
 
 	dpaa2_eth_disconnect_mac(priv);
 	dpaa2_eth_free_rings(priv);

base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
-- 
2.43.0

