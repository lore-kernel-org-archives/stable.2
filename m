Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795392566;
	b=ACtqOmOirTMbIOs40Xr0WgZ7BHuo0JMJfiYLRNtHOMb4Ofs4fOMPcvm9IFmx7nqQkr0n
	 5XM+q9k+FyW0MXhY3H5DZTgf10dz/wtK8Dm+uoRkYZB1gIPjSly3ub+7P+7Jj3beaFngv
	 T1Vr115N9/urhoBLBUktocTdf/q+hXsIkpS+pIHLsMNYjEgmma8zl42tQwcrqkGXZfcY8
	 sK0elmE0tyiQ40syniXq6CxfLUX4qY37WGbSLZeHnVjewN+QOpoU0+OJVVt8b2bQNP2yW
	 c/21ITdHNUO/zsJOg8J+LsGlYgnDu0s4x71l4xnFs8hXZ5Ys9XCpzFw99sDUM/FTe7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795392566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5oZfxZDZESOt7JOg36JOb5NoJDTCRqffJz0J5sNJMMI=;
	b=U+HnCsFximW3rRj5C5cZmXA+dM03NB5Tn3OdxIhzM3j64wjhhwMaNV4VXCYHUCFZEZLB
	 raHdaRNLYPm73NU6MTASqNqa3EluMWJG4xk7d3eyFEA4K8NywUp+Bzj0JSpjwqoF4ym74
	 5ZQTlf4ppeIyMjEsRFS0c/QPArjyF7QXSmmkBRqazV1+p5V8BcyoRZJjDgAEnqkldKD6o
	 cfVspeGvBouaSeNRsVu87EtdD02c9wKX1s3ZbBTAgO0WcarSDLwLbh6h+hFAe6lNQ/U1E
	 cMrFsumA3aTeOevAq1OqFjUN9JWiJJH1O9R7rP+x3VGOjPlE9SNNIwkuLdvBGozAFJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bO3Xvg/G";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB19606A31D
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB19606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bO3Xvg/G
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso1074457a91.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795392565; x=1795997365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5oZfxZDZESOt7JOg36JOb5NoJDTCRqffJz0J5sNJMMI=;
        b=bO3Xvg/GvXSBMOwAZWCHZ1tEYldoTL/n5xhnbPHDS3uQE7Sv8OQh4LJ6JYItRZAiXq
         XvMWlzkSxtPGXkZ9l71qN1dHqUb3fc+VqST8GHnFtZZqiOCeFNhbyoKkCxAJnNE67ZYL
         yCTXW4qcyGBGrntGyiasEEr077JUQQZnBLh9AE/QBfYhitZGWz2MHpNL4CQALeWsvyJE
         fZK2dxbkB8oPVUn7tbLVgYB+dkQ5E5AIFcS1pMibV5hpo5QyjEQtqL2bh/UYXkzA1wU2
         5HZvTnuuMHEnb9rsuwBO6rT0+e/EuKC2+iRhfKdWpSMXnCl/zBSp5z+vWqW91x44iKNP
         SKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795392565; x=1795997365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5oZfxZDZESOt7JOg36JOb5NoJDTCRqffJz0J5sNJMMI=;
        b=ndI3XvNasqPOhN3+HfkQZjudF09AuInpxuiv4ybow8sgMfaPfweY6m3Rngg7boanFo
         0jBsZ613ooPm6f4BIYYuZ7EzYp6sJBDxmeeORqwV6p9qMdTIgYpelKyQC/JuS3Uszpnd
         Ajr/2H6x+LOmYfRUmS+IzF4uF+HEplBKGAPbT5pPrGbL7f79DWDwuHqeL5rhxX0ZQMBZ
         +i1isF/oYJLIuGa0yE1Sp9m3EnULewGonKR5+Db5R1Mt5AbFsb2Z872t9MblXYPsZNrw
         R3HFRpSsccYcK80eousm9RWLKrwxN4/FnM43NEr6LZ/d7kjGzh9n5rCGp1C8x3/Mdi+O
         8SeQ==
X-Forwarded-Encrypted: i=1; AL+hErFT75ggnSfLmOX84rVvuUD1UHLBtdd6OqWFwHmCFlrDhsLLNilbIKTUs355LqaOSaecGs/ZAYA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8a9KHBqEQkd6XKzaR58+NluFinELzRZ0Pc+J27n7COs7AiwlS
	gdMpWIdKJk4PqUZY/arSS/RCERl9L0VqvvgJEWrpKlFQidcQySRyilba
X-Gm-Gg: AZFdTZdFqdf35aZDmAk+J7+DofXg++H+lgZtJmongTTMa/MdpW7gdUQO9NmR61YywEY
	1EF43JVloPIeyvJh+DpToA4ZECZl2PQyf8uo65cNlRI8miJVJrywTEp+6oKwTceC62quM0kZu2S
	e/AkFxcvlm7cUxzWmn5pa7kBj6Nei4kc/rnKUcwLs37DM4EF5Y4F7m0m3XQOy3Z+X0Ox5C101/q
	BOu4BJSGAd0ULx1+GLzC2I4LrQe+XbINIk93slOd28TWqj/AlVPfQVs5uy9eEyii/xa77oYbutR
	EaOin+lelCeEFuyWa7pGSY1hV/bO1tE4yg4W42ORkBO2qJFjR7C6XJ5zoVlKUrx8OJylfDFucWi
	gM/r2Oop+9dLmXG4B5ErX463tjeYtcsjVQIy1T/XE7ktIrkq8z6lkpM75sESACtC/wbEyeGRbHU
	uoL9tiuiKLuBJPWH++r+jzaj8Hd/8WZ3Uf7DMqQZd+UCwXOWF5Uuv2sv+lVTQ0DSNj2Wj0Z/9jO
	sqFfDIskDWyFHJiowuPC1NdcKlc3Hzsv9YroQussCM17WzfZUkfWF7U6Hxrw6OQ1M+GFNok+6oj
	bveTWQhHLOgfwfBlynaBPNtW10bgdUbQ9K4X0QDQzNIJHX02sAS4++R3vwOvYpKS
X-Received: by 2002:a17:90b:2cce:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3b41c909001mr9327128a91.21.1795392564569;
        Sun, 22 Nov 2026 16:09:24 -0800 (PST)
Received: from gmail.com ([116.162.234.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm16532573a91.3.2026.11.22.16.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 16:09:24 -0800 (PST)
From: Xue Boyang <fuchen.dust@gmail.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] can: j1939: fix null-ptr-deref in j1939_session_completed()
Date: Sun, 22 Nov 2026 18:09:16 -0600
Message-ID: <20261123000916.181439-1-fuchen.dust@gmail.com>
X-Mailer: git-send-email 2.53.0
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

j1939_session_completed() distributes the reassembled message of a
receive session. It looks the message up at the offset named by the
last ETP.CM_DPO of the peer, session->pkt.dpo * 7, and passes the
result to j1939_sk_recv() without checking it.

j1939_xtp_rx_dpo_one() stores that DPO without any check. A receive
session keeps the whole message in a single skb, so a DPO with a
packet number >= session->pkt.total makes the lookup return NULL.
When the transfer then completes, j1939_sk_recv() dereferences the
NULL pointer and the kernel crashes in the receive path.

Any node on the CAN bus can send such a DPO, for example right before
the last data packet of an otherwise valid transfer, so this is
remotely triggerable. On a system with the vcan and J1939 modules
available, an unprivileged local user can reach it from inside a user
namespace as well.

Reject the DPO when it is received, and keep a backstop for the
lookup:

- Cancel a receive session with J1939_XTP_ABORT_BAD_EDPO_OFFSET when
  the DPO has a packet number >= session->pkt.total. That abort code
  existed but was never sent. Transmitter sessions are not affected,
  they only see the echo of their own DPO.
- Keep the NULL check in j1939_session_completed() and set
  session->err on that path, so that an unexpected lookup failure is
  reported as J1939_EE_INFO_RX_ABORT instead of ending as a success.

AI assistance was used to analyze the bug, and to prepare and test
this patch.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Xue Boyang <fuchen.dust@gmail.com>
---

Notes (j1939-v2-submit):
    Based on mainline commit 4843f6873f7c4835e62f2c73ba0fd538e57a2f22.
    
    Changes since v1, following the Sashiko review:
    v1: https://lore.kernel.org/linux-can/20261117103516.535910-1-fuchen.dust@gmail.com
    review: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117103516.535910-1-fuchen.dust%40gmail.com
    
    - v1 only added the NULL check. v2 also rejects the DPO in
      j1939_xtp_rx_dpo_one() and reports a failed lookup via
      session->err.
    - The commit message now states the impact and the reachability.
    - This patch supersedes my 2-patch series from September, which had
      the same NULL check and a DPO check limited to dpo > pkt.total:
      https://lore.kernel.org/linux-can/20260918025622.192582-1-m18335910246@163.com
    
    Testing, on v7.4-rc3 based kernels with CONFIG_KASAN=y, with raw CAN
    frames injected on a vcan interface:
    
    - Unpatched: an ETP receive session given a DPO with packet number 256
      for a 256 packet transfer, followed by the last data packet, causes
      "KASAN: null-ptr-deref in range [0x18-0x1f]" in j1939_sk_recv() and
      a panic. The same happens when an unprivileged user triggers it from
      inside a user namespace, with the modules auto-loaded on demand.
    - Patched: the kernel answers with ETP.CM_ABORT (reason 12), the
      socket gets J1939_EE_INFO_RX_ABORT, nothing is delivered and the
      kernel keeps running. Same for packet numbers 257 and 65535.
    - A valid transfer whose last DPO has packet number 255 completes on
      both kernels, the 1786 byte message arrives intact.
    - net/can/j1939/ builds without warnings with W=1.
    
    The reproducer is not included. It is available on request.

 net/can/j1939/transport.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f8..d3644c8239a4b 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1244,8 +1244,13 @@ static void j1939_session_completed(struct j1939_session *session)
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
 		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		if (se_skb) {
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		} else {
+			/* should not happen, report it instead of a success */
+			session->err = EPROTO;
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
@@ -1823,14 +1828,25 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int dpo;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	dpo = j1939_etp_ctl_to_packet(skb->data);
+	/* a receive session keeps the whole message in a single skb,
+	 * reject a DPO which does not point into it
+	 */
+	if (!session->transmission && dpo >= session->pkt.total) {
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
+		return;
+	}
+
 	/* transmitted without problems */
-	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo = dpo;
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 

base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
