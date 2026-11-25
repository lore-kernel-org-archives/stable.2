Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644937;
	b=MBluOA5yveQ4hcQFbmal57RTRDtEXlQ5Ww0UgRWybjs1H/QV2p7o4AclPubvdG2+EYwA
	 SyRM8usPQSS1ipKse7VgK2RkyNAWUKNHoDP1NgjyQoODzV5jBRFQIu3BkywqiEoE8HFIJ
	 qkk9JnOUmVelhvIQ8Y2OF1zAnK8e9d0abJUnOVZMWTFuwzwSRMKv5G2uKCRHbVa23wyn0
	 bbp+ZqmiZ7XpM9P5lhMgZ5GrHXljxHxp603kCqDF7Aoeh27THYthnJgLuhHn9OJQ5Esbv
	 MU+HoPbsM3RKIoY85yQA3RgA+B7HHoDj5Zufb/vA4lvluCP09iim0x+tCZJuPkD8Y8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HoLpNZUPpAV0s/IN4AE3BuQqpTSM/yM+54mb7fzDFTw=;
	b=yA/WABp/X/R0aw5/kTHfSvLzcjViPONuBLB18AkmJT/nYZcOmwDn4cVNm/DaXTEl8rQm
	 hnNetIyp9i+zmpCbh6wWeKziys3GYnyEk8Wj18Baw9tgmCX1ifZaHqXGTN3flv9gP5b+n
	 bXdZUPE+Ad2Hr6Fw0Vzh6nz6K68jwwZDv8sG2AahJAnwhy3WfNn9S0JkZsld9J2I1azey
	 lg6vrxMeimGsJa63xMtqTDLO79gYzr0OJUSkSXop6k2+/21V14+Z2pWWmIdrXnmWaWlmo
	 oGkvajfXAyTzL72/TQryIew+gFizzRl9RBUtZG8sDcVvv5V7X3gYSBKxa9QvqS7YtgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="eQN/XD6H";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B61606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B61606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eQN/XD6H
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso10341130eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795644936; x=1796249736; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoLpNZUPpAV0s/IN4AE3BuQqpTSM/yM+54mb7fzDFTw=;
        b=eQN/XD6Hq8wMXIj1ecSVa1boHANg4KhmxmXSv42V30BijwxyKn9dP/cEnIHUx72yJm
         mi66UrhqpqZGm7vA85JDOFVORQL5WAPpi4T0DPthelVppjHBX0ZnnD6BL8QR+u76L+Jv
         mbpQmftPDARFAYpQDVayDuhbYa2gYjTLWuT3yCsw6i59uREfA5iajifhdYLcz6hApWm7
         nbTvmDaVO94Mvqwyp/pEXzyTpceH9Gbog0Mr3ytJahErNL2HwY/aA00EmtYxkE4Ev+4u
         TOJY0DqP+dQTbHeAlJ0in894XvDmVMA6Twnr6Q+EwGfk50WQ4zk3hAWNtneRFdvFO0ND
         +VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644936; x=1796249736;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HoLpNZUPpAV0s/IN4AE3BuQqpTSM/yM+54mb7fzDFTw=;
        b=c0ccFHw6uoU4pOUkSuZhQE5FQNdrwZq0dUDtIXdfiQueI+onr5pd9g5KvXCDMsT9TZ
         E9f4IPqw+vDKQXP2Gut09OMlOQuOD8/waxsvGhXF+Q1dUIlNxHiSAXhgBGXJQNOlrGWi
         GNeo48RBki77BP8K2AoaKOQ1V+TNXJ/bE0QZU/GdB1kXgjt3jEm3k3mZ35gziWlKGgfV
         VvGqPLuZWE2Nk6jxdlOowKUITIQTyrJ3dMRzJvlZXy3fDSjsdLmZXI8nFeUmT7EZNkfw
         mb2+pEVxPOoS3tSGqZMEYYP5xdx2zoUwU7EPxyFC+qTNazdAEE6ChJPufpU9N6zEJ1KF
         VyLg==
X-Forwarded-Encrypted: i=1; AL+hErEVG2Yy8QnFBpcA7AcIVicWxzNsMVsAkO3uoDNL0ZuHk/2d20lJUfR9dpMgI7m5/hxXDaLxdK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tlXE+94H2IY9zFPmIGjMznffPBdEPLdCPstNRR04MlIV/R2O5
	FmuZDi69LQar7cLvFCLYQFkUn7OAK+Ig0KE1AB0VZSMD8tQywoHOVwfcfwW+qnmDz0PzRBECgE5
	Uow==
X-Received: from dybqf1.prod.google.com ([2002:a05:7301:6481:b0:386:a9a2:8031])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4143:10b0:36a:1f4f:3e9
 with SMTP id 5a478bee46e88-386b1067bf5mr12106547eec.20.1795644935493; Wed, 25
 Nov 2026 14:15:35 -0800 (PST)
Date: Wed, 25 Nov 2026 22:13:22 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125221322.1412935-1-elkin@google.com>
Subject: [PATCH wireless] wifi: mt76: mt7925: fix UAF and skb leak in mt7925_mcu_rx_event()
From: Elkin Cruz <elkin@google.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mt7925_mcu_rx_event() caches rxd = (struct mt7925_mcu_rxd *)skb->data
before calling skb_linearize(skb). When skb is non-linear,
skb_linearize() reallocates skb->head via pskb_expand_head() and frees
the old packet buffer, leaving rxd dangling into freed memory when
rxd->option is subsequently dereferenced.

In addition, mt7925_queue_rx_skb() transfers full ownership of skb to
mt7925_mcu_rx_event(), so returning directly when skb_linearize() fails
leaks skb.

Free skb on skb_linearize() failure and assign rxd from skb->data only
after skb_linearize() succeeds, matching sibling mt7921_mcu_rx_event()
after commit 4361f1660101 ("wifi: mt76: mt7921: fix memory leak when
skb_linearize fails in mcu rx event").

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index bfc1660d1c6f..42af38941aed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -715,10 +715,14 @@ mt7925_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
 
 void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
-	struct mt7925_mcu_rxd *rxd = (struct mt7925_mcu_rxd *)skb->data;
+	struct mt7925_mcu_rxd *rxd;
 
-	if (skb_linearize(skb))
+	if (skb_linearize(skb)) {
+		dev_kfree_skb(skb);
 		return;
+	}
+
+	rxd = (struct mt7925_mcu_rxd *)skb->data;
 
 	if (rxd->option & MCU_UNI_CMD_UNSOLICITED_EVENT) {
 		mt7925_mcu_uni_rx_unsolicited_event(dev, skb);
-- 
2.56.1.839.g22a8290db9-goog

