Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218725;
	b=zkAPbrfv4KMXkxBIlg95F1FF+qON7zEy0lcz/KrqRXXY3iFRWSdcKsOIon1gpvmP8Ys7
	 68/0+X80RmiJfOFcxyWjo12oaOd6OcjhdlCdtbIvua7267AEI+CJj+aNtXeGqMC5MaPqN
	 opjPURfl9LBjkD/+lDHL1lFurCx6qKoLnNJAy8BSBzDkQDhjrgqb7iEkXQkkuMS/Sq14V
	 ARcU+cEBDIe/wXIGyPn1ONpjoXqlbHI1tr2rbgAOWSgX9BLo7q7pOqBTHd+JKoi02SuxO
	 CFMoajCh4YdlTJQiCIILVlUqoKu/kYUaZU0fu95s1cjvv31qbgKqFx60VPdi1rk39oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DsOK3xaIdRnyMSa9XbrX3s3+g6voTmIrmONsKMzeqsQ=;
	b=IzYBEwdHvKeqcFIMvJEszKDvoKumf6P3LtN2lX6+QbYQx970v9TRelBnfmym1SLMcmpR
	 gLGtLINtjcFqdx1KdK4lRJlcS2/Ca690ruYV2YRf22wIGIovnR0OB0dRrKggRqFV/y0mR
	 DRQdXoPICTazLF6mq0+xT3n1DzGIeEkcIVRVYqE8Qjyq6g+BOnXYLGBdeRqOmwzlVt7+B
	 5PSnfKYq2sOCxcL/+5N4hnxjjxIEpLpjgSvHHFXM/4rTfWCDC6mX3A1lmA+gtoYx2yKNO
	 dH9394KBnQ3m6C5//t+rxZ1WWlyu34j+XvtrSBhpFyql4JA3TPcoxUaK7IEj4BaG/Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlromTHX;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0AB606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA0AB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlromTHX
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-372bdb942dbso948042eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218724; x=1794823524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsOK3xaIdRnyMSa9XbrX3s3+g6voTmIrmONsKMzeqsQ=;
        b=wlromTHXqlNDcGqKiVJjw0vw8vMkcQ1/dgdG8oGvptPI4AKx5hzvAG2oPLaNgi3FBT
         XraKeqI/g8Gp0q0uMl2+LBqAgILgLLZc5vCw5niwDJPw7nKvkPpMs7ntvKsBSXRqkjna
         NVHAEaV8MmPp9AVPrRot9jIqdzXn/WpvtKgR+SzbYBa+0Svk8rib0suTI2KlgKul0Yxz
         HgDP4YKrJuv/N93lA8UcqFu5pGeZaDig9ONXQELh3tWEp7lKyUCgT8uEYmdx8Wkx2Xuj
         qDH8HYZUQ517c1Sge5DDjO5vNfJIzN6PWXTRo7OVriuRACwBtT6vWoUsqe3EQbnw7gtG
         onTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218724; x=1794823524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsOK3xaIdRnyMSa9XbrX3s3+g6voTmIrmONsKMzeqsQ=;
        b=Q8n8jj8R/Sh8u/RYvShmN2EyjNTrENIMx/gpkEo9ROX+dcTd1lhatHd/0GcjOoDrRB
         yRVlH6WZNf8z4pl95LnOMyXaEIPPAfvS9GhA5KnQojUCophCZ47DUXDWy9YcRW9zTvND
         Tx5lCGckbcyGkQ4vTFijrdMr1Iba9IAM0J4VfoyWoADABIQy0DWMNJLl04rGNYQoEkGN
         rXdDR6NLSWZxXd+0QjhHh9MybGCCLFgh0KWgKXmfA9Ik+9ShDJ4ZZRxwVY7Wj5uQYYbm
         y8b3iA9PqpxyqRETjxYHBDtavFQc0E6r/6YN3sF6fSvPo9IiGU/0qfa4amPZCiQPVl1N
         gwIw==
X-Forwarded-Encrypted: i=1; AL+hErH7CzaAZTLcC+GyGqwrf1mUB9AY99tJEvxCeHSDROLlOf/7hlN+8ag2zMOutoUJIl8ZDRPTaxo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9onNyc70G0sEqaGlsaQ+rle+taSgRT82HRZ0pZnXciDwQOsPFS
	1xdDb6C4x9+Y655lot1IVn36JQ0HhPtrEvXwZyAz66481yCtJg055dYr
X-Gm-Gg: AYBFou1X2rTW67j7EpxJe3wRZiPwGJVsFIBUy/NQKVCvHBu4djtRG7jBf7pKzSPKmap
	lP6grw/AMMiq1uM2EmmLT6czG3qphK3xBCOBI3z6cXBhnV9ixUjkSJrYVIW/TFzfc0ewW31KVsC
	woPK5oTfdydvj8tHILITS48Pm+uoq680N80YKvmUxHgsSzP5iOznCmHOLoPWUUsjcGO+uH8eAKJ
	1QKFk3JnThkAEnn8u00pJ+0jEbZLw+YTJJo6aPBU+3GaoiMAxZE4oKGKKEUs75mTd8Ru8taaDmD
	lVaZ9hIGAXy0hlEen9TzEDJ7sSP/wZUMrpvzgo9iNnDof+4815V9PzwaHBiat43v6m3u5AENjTR
	6OuOxskZ9uI7kJnq8TFPfMjOsC7HXrTnQFcrhBCP+hjCMZ1FeEhLt19DRZHNCdcwjH+N8/wkAuz
	H81bzFzzhHH815ewL7utokHUr6KijC2bLSbJTz5IuzWQKTdwlNY7E3V87Nx60Yh48l0NP7wdNpz
	TomjrxV1yWLQvIhm7RCgeWRZ7NJssLtMwg/S+x5sM2hWG+PW3PkeRit20HQUXwCSrGhL+XdbVBf
	X7YG3D/vyuA1ew8Ng8rbPFZZSTSKU1DQwZ6HR5AU/GZS
X-Received: by 2002:a05:7301:da0a:b0:36a:1434:c691 with SMTP id 5a478bee46e88-37256bed190mr6227845eec.14.1794218723536;
        Mon, 09 Nov 2026 02:05:23 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:5a62:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm12886710eec.26.2026.11.09.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:05:23 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
Date: Mon,  9 Nov 2026 15:34:36 +0530
Message-ID: <20261109100437.331423-2-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109100437.331423-1-amaan.cheval@gmail.com>
References: <20261109100437.331423-1-amaan.cheval@gmail.com>
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

Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
verify_xdp_configuration(), which until then refused every format but
GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
no XDP features for DQO-QPL and gve_xdp_xmit() rejects it, but the core
only checks that ndo_bpf exists, so a native XDP program, and an AF_XDP
socket on top of it, can still be attached on a queue format the driver
does not support.

The DQO-QPL RX path was never written for that. Its page accounting
assumes the driver keeps a reference of its own across every handoff:
gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
recycles it with gve_reuse_buffer(), so a redirect target that releases
the buffer synchronously, such as an AF_XDP socket in copy mode, can
drop the page's last reference when pagecnt_bias runs out. The page is
then freed while it is still DMA-mapped and registered in the QPL, and
the driver posts it back to the device.

Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
advertises no XDP features for the current queue format, which today
means DQO-QPL. A zero-copy XSK pool bind is already refused by the core
for the same reason, and a copy-mode bind never reaches the driver and
is harmless without a program.

Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA")
Cc: stable@vger.kernel.org
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
v5:
 - Check dev->xdp_features instead of queue_format, and reword the
   subject and message around that (Joshua).
v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval@gmail.com/

 drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2437cd8ba633..fe560f5c5408 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
+	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported on this queue format.");
+		return -EOPNOTSUPP;
+	}
+
 	if (dev->features & NETIF_F_GRO_HW) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "XDP is not supported when HW-GRO is on.");
-- 
2.47.3

