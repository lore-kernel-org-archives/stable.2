Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F899429CFF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888526; cv=pass; b=bHvjWBU21qKHKd9vcIOAcgmQdPkTfiJmTXdFC5W9XGnh3KlXj9CsaKV3JMOUddVnU9o9mYKLloR5iDbLX2gDtL2aIJIIU4ZLZjXiedRnFyYZ94YgpkN1FrHGa55UTAqPQL2HkRDiTK7KR+T9tP2KTQvWZEf7HFBmvOJXbH5stEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888526; c=relaxed/simple;
	bh=Kxf5qhGPM5N3lnT1RzqB/ekC/7LhalxrQQ9FOhfAQec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hloPiORin4q+A6KIqbJNsrdmTChprdeiv7M6SXC0EyDIwYfdbnAni1E0iTGIz5HhWWLviw13MHV89NezCou/iI6RxeBWn/cYIOTAu+9Mdmtjpr+AdNQ/KD0hZlHwMbHg8ow7PUqY1J1rqtnNvBve6HagS4XwmW4qxK2yxSzni20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TGDhjeFD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IleUhvDw; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TGDhjeFD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IleUhvDw"
ARC-Seal: i=1; a=rsa-sha256; t=1784888520; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hK1In0eHP5DWj0RufOtnIF3ygm/nGfkes9aIYsBbi1r3+4+TcKp4M6ZUbNB+hqrRiR
    +CSmfoNDNL5V4TiXvgkKrNfRjiXHkUDfItlR9DPSKqbImIQvawywdxD1VvTDQzt3aPCg
    VlCgDAWtOdzc7peGSLxtc0PBncqHiySW98dIn1PKkpFwPZa/d0LKw1M7KZJo9QnSuEyL
    Wu+r66bVDzFUfsrWypZZrT5gBJJazj7O9R21vG9fuScgzkclUq5mEs++VDcRwxEHGDrh
    RXh3omOy5iX1dBP1tH2O3iqdhmc9abB/saIRAIrmJVpVxZ3bSv7VFpk2RyubcTl6R7iq
    xxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I+6E+U3XH2imCk/2kxzFLRVExuHXUt8zim26IL7dPi8=;
    b=F0gPtaRkr0f7Kku6irFiChv2J4PoVrir/gijyLKgweDwvCsxwKlYwQYAungkjoPaUU
    YGmfPqPJSkJ9z2SHQQeItpQhknhYtyFpF4UuWHV3XN4jFjcFyGLJeyeXGYC4ut5Zldzz
    Co1cWVH8WhFcCGrqDwIy57g/rNcWNDUY/H7AhaLt+6fPXj0l4KqDJ945rzWjNK/bj8i/
    84Z9yFA94Oz9QpcDOXGp9vAC8JxpvIESP2MmocnjSpTFe6ip5H82sP54+HuaRgSXB1j7
    EHRf8OQR2fITAjyTg+45wZmxtrUJIID4oJJlnr8QWNjVAzhjJz2ZMDWRuzMi1kLxsUwI
    +zlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I+6E+U3XH2imCk/2kxzFLRVExuHXUt8zim26IL7dPi8=;
    b=TGDhjeFDz66VFdpAEdYBI0O6wcE3fUrbxZ6+AlhCEpIjvqAFHaUIrEgN20ixvNEltG
    DTtk0bBYcafaQT4khwJscB3CoSPjKKPdJ3uDrobXdwDeJGTuGaF40aQoKAX+V8QN5q5L
    RW5OUc/FNIKOfbt0LRkQNM2MqUTLhqVP9lMhfi5KyotJ3aOAUvZArwVZGOpmZL3l38kZ
    AHp8LzJfA74dy4dS76HNKb/Njlnkllr4RuOaRyT/qvb/dRkD5iHJgTsD50Gu/UzM3vcS
    i+KVhTBlKm3anZiD3mQophr9BMzhgbcilSiSPbcfmUAwf9Hpb4Bf8FgPkOlrgNDsmVVm
    wMmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784888520;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I+6E+U3XH2imCk/2kxzFLRVExuHXUt8zim26IL7dPi8=;
    b=IleUhvDw+xvWmfMRAktvpQqAXZW0PlxOvNjyAbUAHrsIPaK8w99hEcKJkskqO/das8
    H7LjpnTjciMN5eo1ilAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926OAM0tHf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 12:22:00 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y 5/9] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
Date: Fri, 24 Jul 2026 12:21:45 +0200
Message-ID: <20260724102149.16440-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102149.16440-1-socketcan@hartkopp.net>
References: <2026072036-giving-knee-3a33@gregkh>
 <20260724102149.16440-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

commit 62ec41f364648be79d54d94d0d240ee326948afd upstream.

bcm_tx_setup() validates cf->len against the CAN/CAN FD DLC limits
before installing frames for TX_SETUP, but bcm_rx_setup() never did
the same for the RTR-reply frame configured via RX_SETUP with
RX_RTR_FRAME.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260714-bcm_fixes-v15-7-562f7e3e42da@hartkopp.net
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 59 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 090f31b..1263822 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1194,22 +1194,37 @@ free_op:
 	return err;
 }
 
-static void bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
-				   struct bcm_op *op, void *new_frames)
+static int bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
+				  struct bcm_op *op, void *new_frames)
 {
+	struct canfd_frame *frame0 = new_frames;
+
+	if (!(msg_head->flags & RX_RTR_FRAME))
+		return 0;
+
+	/* this frame is sent out as-is by bcm_can_tx() whenever a matching
+	 * remote request is received, so validate its length the same way
+	 * bcm_tx_setup() validates TX_SETUP frames before installing it
+	 */
+	if (msg_head->flags & CAN_FD_FRAME) {
+		if (frame0->len > 64)
+			return -EINVAL;
+	} else {
+		if (frame0->len > 8)
+			return -EINVAL;
+	}
+
 	/* funny feature in RX(!)_SETUP only for RTR-mode:
 	 * copy can_id into frame BUT without RTR-flag to
 	 * prevent a full-load-loopback-test ... ;-]
 	 * normalize this on the staged buffer, before it is
 	 * ever installed into op->frames.
 	 */
-	if (msg_head->flags & RX_RTR_FRAME) {
-		struct canfd_frame *frame0 = new_frames;
+	if ((msg_head->flags & TX_CP_CAN_ID) ||
+	    frame0->can_id == op->can_id)
+		frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
 
-		if ((msg_head->flags & TX_CP_CAN_ID) ||
-		    frame0->can_id == op->can_id)
-			frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
-	}
+	return 0;
 }
 
 /*
@@ -1272,7 +1287,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				return err;
 			}
 
-			bcm_rx_setup_rtr_check(msg_head, op, new_frames);
+			err = bcm_rx_setup_rtr_check(msg_head, op, new_frames);
+			if (err < 0) {
+				kfree(new_frames);
+				return err;
+			}
 		}
 
 		spin_lock_bh(&op->bcm_rx_update_lock);
@@ -1345,16 +1364,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (msg_head->nframes) {
 			err = memcpy_from_msg(op->frames, msg,
 					      msg_head->nframes * op->cfsiz);
-			if (err < 0) {
-				if (op->frames != &op->sframe)
-					kfree(op->frames);
-				if (op->last_frames != &op->last_sframe)
-					kfree(op->last_frames);
-				kfree(op);
-				return err;
-			}
+			if (err < 0)
+				goto free_op;
 
-			bcm_rx_setup_rtr_check(msg_head, op, op->frames);
+			err = bcm_rx_setup_rtr_check(msg_head, op, op->frames);
+			if (err < 0)
+				goto free_op;
 		}
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
@@ -1456,6 +1471,14 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	}
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
+
+free_op:
+	if (op->frames != &op->sframe)
+		kfree(op->frames);
+	if (op->last_frames != &op->last_sframe)
+		kfree(op->last_frames);
+	kfree(op);
+	return err;
 }
 
 /*
-- 
2.43.0

