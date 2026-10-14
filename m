Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE43955FE
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946582; cv=none; b=YCpjvvHmOackZxj28H3i/7rLW87s+H0JJJDUo0o6HDgQitoQNsEJ6p+AQkX88lRzR9TGFlzC5wlpU999acAhp4bmC3XVJArcgb6wozHimeBMwNiv4ZyKTxnyiso33h5u0O4Z9ckZDhtEnilIt2MG7tzacUz8/HM11Uj+s26+C1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946582; c=relaxed/simple;
	bh=xlvNzdBEDkNjZ4017cocaTCfcKs9/ceIgmy0m9FwRY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOuUvBQ44qQvJi4nUi7cIRxokhorrub9Ivhv8Xxs2NmMTYW4T9fZXBRrqrLITwMNRcA/tr40FTg6l41+xMSuOVnr0piuor1XlWUzzgNfll0GVAU7u12l9glJ1h1TYOHCfNvpNmCL089QZweJ9bc/XMm3YOe2y7X/4W6RKKDUPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=YAtnaBc3; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="YAtnaBc3"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-141395927feso6889807c88.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946579; x=1792551379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eOt/1BdDYxiMzENqA6TOzLT/rpB6ssuySkd04haqJTY=;
        b=YAtnaBc3Vm3KfG/62r7tE+qpsXEnCF7hvvHeicYJh6Lx7ADnU9Z7sxScRtY3vsNR0Q
         Z9lTZFs+EhUcYo4EHeUMiCu55eBnZ+B3GDA1mWHhe9FpA4LBubsZvcaLneJi34TuBEdN
         f8c3upHfsyoqrebEAPZOb7388SYf3LoKsJQbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946579; x=1792551379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eOt/1BdDYxiMzENqA6TOzLT/rpB6ssuySkd04haqJTY=;
        b=uHb5W0YxlcRqqDheEwXjm+IIZNvfQ4/bTfID2pSVDlEYGvKbOBKcyPhabgFxgDFweU
         Bgr29wJms4t/AL549N6/M7QyBwDzPBTHn0zRTK6tqfp4ssH64VTBSZiNB/hTbSPh3Aaz
         81b4kx2t/dFofEp/ypkb65N9hOvLOCd2h1QXTE0EDzLAi7sKSktm2x9ovtzUSIqJCtGB
         bXNPtnvJ+nBmjZwdBIM0Lf+39H8G+cB0k/hiBTVQs2dIMsXaUOezo2CoLJih6QLebTmW
         lEAM4luirtnASibEBEAdHEMh0sabBgbq/XtcUAOkpPBB2ZM1j0eBZHRKQfYgzKf9hk3X
         tzQA==
X-Forwarded-Encrypted: i=1; AKwUvBw3tqH0e0oc8KVXMM1ICXnp/CzrgMtzTdO2/Axmko25bM6rSgSZ/19u96BK3KA+JN9OYDHvAek=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqWE6Qd/Q+qW8nQ8m3+foHyIPASR0z1sw7dJDJXf8jAryTKrdh
	dv+sPHeLiz0hrrVXORWgUtGwS72ETPJUhpsFAwEK5oCIv+552eVVo0YrL/IXH5CKp4g=
X-Gm-Gg: AYBFou0J80+GFq1iAJAY+Y7AgSSjXVBE1ej0U3ubT5etgtc+G12WL3Is8SDIVbbzUQ+
	r+KYgQdT9JD0daIt/4tbltvX3MEl42Llpu0JNqXhCi1qheUOzdi+NpkJzmUf31SGFjoPdG31m9u
	MMx7RmBPNP/qFRqGDv/qdXfphdLaDykxUTtna5ssMxOYHal8xyKR+P+NV+MOWc2X81ndGVUcSlP
	W4nUD62MMXaC2pJ6LQel3iv+hR3Ap3RYExRM8czPRTfnQBpzHi23o2gjahi/Lxid4+ySo+3WrgI
	hZ2BjszF5k5Spzy95iog4CGErc95bN5jHMjN/vv7zi0BM6hpBAGhPhmxV/xWD9BU8QUiLef/Xa7
	i43AGgS4agYzWPJy3n3Wu8XQfiQgrQVy8U8llnW4pbeMXZigU3Avw5jCxLag3J8qIdU9+a7Jnr4
	qtZ7jwa8Dkl+YueDQFJ8LXA7dFJHg+rGSVOijhGjpgWxyE1EDuHQ8E0vTqIl5p7Zun1C41MrhRF
	9f1/jp6BuC9+5/c9aSMFJzQbB+EOVnFD2Nfjw==
X-Received: by 2002:a05:7022:7e0e:b0:143:72b1:9004 with SMTP id a92af1059eb24-16a61d5c336mr20362920c88.45.1791946578956;
        Tue, 13 Oct 2026 19:56:18 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-17dc865cbffsm2122640c88.6.2026.10.13.19.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:56:18 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: usb: lan78xx: reject short register and statistics reads
Date: Wed, 14 Oct 2026 10:56:02 +0800
Message-ID: <20261014025602.26334-3-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
References: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan78xx_read_reg() and lan78xx_read_stats() read from the device into
a freshly kmalloc()ed buffer, but only treat a negative return value
from usb_control_msg() as an error. A device that answers with fewer
bytes than requested leaves part or all of the buffer uninitialized,
and those bytes are then used as the register value or the counters.

With an emulated device on a kernel booted with init_on_alloc=0:

- A zero-length reply to the statistics request makes ethtool -S, which
  needs no privileges, report the stale contents of the kmalloc-192
  buffer. One counter pair read back as 0xffffffff8a427800, the
  address of usb_api_blocking_completion(), next to several direct
  map pointers.

- A zero-length reply to the RX_ADDRL/RX_ADDRH reads in
  lan78xx_init_mac_address() turns uninitialized heap memory into the
  MAC address (12:85:1f:dc:2e:bd and e6:93:44:41:9b:9f on two probes),
  which is then written back to the device in RX_ADDRL/RX_ADDRH and
  MAF_LO(0)/MAF_HI(0).

Treat a short transfer as -EIO in both helpers. With this change the
same device fails to probe with -EIO, and with only the statistics
reply cut short all counters stay zero.

Found by code review with LLM assistance and reproduced with an
emulated USB device (raw-gadget + dummy_hcd).

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/lan78xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb8204371f5c..e6be066349de 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -612,6 +612,9 @@ static int lan78xx_read_reg(struct lan78xx_net *dev, u32 index, u32 *data)
 			      USB_VENDOR_REQUEST_READ_REGISTER,
 			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0, index, buf, 4, USB_CTRL_GET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*buf))
+		ret = -EIO;
+
 	if (likely(ret >= 0)) {
 		le32_to_cpus(buf);
 		*data = *buf;
@@ -695,6 +698,9 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 			      (void *)stats,
 			      sizeof(*stats),
 			      USB_CTRL_SET_TIMEOUT);
+	if (ret >= 0 && ret != sizeof(*stats))
+		ret = -EIO;
+
 	if (likely(ret >= 0)) {
 		src = (u32 *)stats;
 		dst = (u32 *)data;
-- 
2.43.0

