Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215585;
	b=B7dGMuUq96EFwNNMqRAg5JEqj0YLLmxAo3oideZmS8WMw87B4lQxozyz0bEcaAXSulMt
	 Gwe8C7JRPdTto95jYnZFjCY/v8EL8LzdCBdg8LSiC5ksAEJtTghVefn8Fk7zO3mC215Dc
	 OZZUSqrB3O6FLfCqqhUv5JpdBco751enlnURerB95J7VD/wEpcSnnnRlICOP+aknRf3ZI
	 aaAKrNVnnCuVpMIt8CdbqSr54z4fY2CQEIcuWdHE6I8j+J7T2HaUhljGFZCPnmt+l34nK
	 iV7vZbb+aGq6ElAv0jk9YolsegmDmcGhqv+LsuzucLs2i44AN1Hjrm9MIFPgZcNUdjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YPDsvFkr4i8FkAzmO1aMvRKcZ2VOzq57ruv3ddaJg+E=;
	b=DToX9cYCK7Af1muZLnla0TnEobOvxcKQpBykX8XUCTlEHlcd0sHkrZgog3TDWjUp85Du
	 IKWgo9fgjyDTRvkeG7nBduHo49R0UHHDOjJ9xU+QrRxFePgvGDmJqOwEmGjxZjHjfdpS3
	 AC7FD4J+/YC59TPDPi+j/YdYrdJAMYO0BmMhdVp10qDUIgTy91t1wUZlX6FRF3WpoJD3e
	 MoWpf4xXC/TqLg/AHLSMAt2VsIlGT4RK3BpcleSRlzBDENtU1Apxf53tsmLBTQN6q/CsO
	 KOlIVcC1BWKJBXhcZGRuVXcCT9T3q4p9wehBOU+dwus035KNkrI3xGuS+G0Hg6ut9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Q/CunrUC";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0FF606A6A7
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0FF606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q/CunrUC
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so12463925e9.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795215583; x=1795820383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPDsvFkr4i8FkAzmO1aMvRKcZ2VOzq57ruv3ddaJg+E=;
        b=Q/CunrUCCCYy0T/k7VAhBD+gvhvoI6xzmbTMZXnbbhVp5ChLwSQfU2l7Wz0KBndhln
         dWXqyuwyBILR2yxInR0MFYB/i7IwSYkVJBiAKVcJhRmUJ+Sqj3AIxWLjsfw0QiZolztd
         +Jeu7N0slmqGNw0/xosPOIqYKKloP9tzBRmidT9jJoKtUvJYcaWKHM8vavk599QYsGjO
         fj/GbtPfq4Dg8FefkuAuM1vu0MPE5amntWtjqWcLWto8vqmnVaRn19zpLfuF8m4uQqgt
         7SagGCceJ7UTZvlhsfxATzJrSzgfltOtUM4yT8Mtd11p110Hneho5GPUP3RK3m5WMDYk
         r0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795215583; x=1795820383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPDsvFkr4i8FkAzmO1aMvRKcZ2VOzq57ruv3ddaJg+E=;
        b=VrVdERBvL2erNRoWQhbN59rKswTeS3DAodTUygyBpQUmNdHTAXxxrSDLTlcnQu+aV8
         tribrK+foB+pBL2+YvAOXLEpQcRGUU81exZOpUcNY8RMCc7uRD4PaxVJTeiqizWUaVTm
         9dH+h9yT30VepoAkMUeM4e6AwjiiGwlv9k1z5JZSlIaQVvZLHo5TAIP8oCfC7+KxOVke
         VyNwQymwyfsEAx8OFJqo2Sv6GxvmDb2oNKvXcQILecp/iALRaWJyojOQwlCGvAmRfYLI
         5cKtIqrvwwQm26KgH4dEkvHoI9VjWYzLdIbN31GIHFDANCQK5fcgbeiQvUefl9Ntjb5b
         cm/Q==
X-Forwarded-Encrypted: i=1; AL+hErHf3kk67JjRsBkQlyRg6PDHhh6hrJL42aWKdiP2cPgTFsXB6aPLi+5HngcqqJENoGQwyeGKBVg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EtmiGG4GYkjtZaP7TirBZJd68vGpu4/+5VqLTvgnAEoVE9nbs
	NU7XFM+LMkt86/DF7V+FHEbm6umK2s2Jv3tDz54syDcXpnoSy7txmSo=
X-Gm-Gg: AYBFou1Qrg3RnNmLcIeA6svReNGU4KbLCHkT0A3OLCVxux8xwr2JrBRX+X9tYaGZvEP
	ZcMsY25QwoMDtmQbjStvqCOM4ynPis79x0ZEfkWoYxJTUrpKO/T8lVVz3g3ft9Y+75KXJPHiKb9
	lvERcGPtgNFPzQ1XGZGotGn2F3LIp5XmLRdtpp5TOB+KOPi3UVa7ZEjKMRrWUnddoNmOHEKONys
	dfXOWO40LgX+nYaNSEGwHU7NuQuOcOinbusfKmPHeEp77qTVr3vWgeNXBZz2iF4JwlHBkN+0F8d
	tRO/FKwPJy70JzcoPXg6XA6d9yojXoeIb1vsWypAcKvzEYsiucvAkqU9knuM73iPU05or4wCpAY
	mdBFJL+NYceT0ApDQJNdiKEIqedzUuOzTTUlbVCWDLWaxsnYlyDop+HQ1qMJaWlF2UxKoS+ePOr
	1PpRtNmE2N3P9w6mlihQv/yfZ4yyZ0xKHsXA8x4jZQsBWQ/9hF7eyE7FyODSHqRwXy6wwmoF3Q3
	JEBGTPKcUlZ/1OYfsEWJnAPqQZRbHmBNnH3RJLSlIMvOP0zuSnKYc/gxx5k9Eg0KnbCmJz64dyr
	h8HphrIjpRoG5vaOJYX5btrnn2Uc
X-Received: by 2002:a05:600c:37c6:b0:4bb:7033:c938 with SMTP id 5b1f17b1804b1-4bb888147b7mr102309785e9.14.1795215583026;
        Fri, 20 Nov 2026 14:59:43 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm128863475e9.2.2026.11.20.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:59:42 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 1/2] wifi: nxpwifi: validate ext_scan buf_size against event buffer length
Date: Fri, 20 Nov 2026 22:59:32 +0000
Message-ID: <20261120225933.1148680-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120225933.1148680-1-tristan@talencesecurity.com>
References: <20261120225933.1148680-1-tristan@talencesecurity.com>
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

nxpwifi_handle_event_ext_scan_report() uses the firmware-provided
buf_size to determine how much scan response data to parse, but never
checks it against the actual event buffer length. A firmware response
with an inflated buf_size causes reads past the event buffer.

Add a check that the declared buf_size plus the event header does not
exceed the event skb length before parsing scan results.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/nxp/nxpwifi/scan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/scan.c b/drivers/net/wireless/nxp/nxpwifi/scan.c
index 4eeba6700aa72..398c3f8ec0781 100644
--- a/drivers/net/wireless/nxp/nxpwifi/scan.c
+++ b/drivers/net/wireless/nxp/nxpwifi/scan.c
@@ -2443,6 +2443,15 @@ int nxpwifi_handle_event_ext_scan_report(struct nxpwifi_private *priv,
 	u8 *scan_resp = buf + sizeof(struct nxpwifi_event_scan_result);
 	u16 scan_resp_size = le16_to_cpu(event_scan->buf_size);
 
+	if (sizeof(struct nxpwifi_event_scan_result) + scan_resp_size >
+	    adapter->event_skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "EXT_SCAN: buf_size %u exceeds event length %u\n",
+			    scan_resp_size, adapter->event_skb->len);
+		ret = -EINVAL;
+		goto check_next_scan;
+	}
+
 	if (num_of_set > NXPWIFI_MAX_AP) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "EXT_SCAN: Invalid number of AP returned (%d)!!\n",
-- 
2.47.3

