Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544293;
	b=Me8s1B4JVd0bcbHOpRu33gIiFx1HVn8s/edekpZkkRgW31KeASWJc3DVY8psAANjMYQs
	 pMRbZ/kYQzgaS/0Bwg/giH3Bwut0dNM0uF6EjyUuX9fivqMMxnF+/YrBEiM565Tnovd1y
	 FNfn/njfW129toUMIa3YCJTybjFSGwHfGa9CwLL0LEuwKB9HH3mn+em+a+5BlHoVMJ9EN
	 yj3Ocs0H7SpQRT9l6ZqrUq6h1pfQKQsU9U9lgvDXfrMvgF6Y2TEHN8ZwFf8mNYE32dTWq
	 slH2E3lDsEk/E8oBoY1/sOw3gl5E8WW5NmS2amR3lGIUUq93RJKxrObRFxqkzI7QNRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U4RlhrfBwPHzP90Zy/c+f9A3RL0rfHp6IuDLrwxdd3U=;
	b=alpe40mDRhEdpMMe3UKtUBjfs+sSHtrSRTPzihijWTRnjkbK8tp8Y0ZCuroNYZIXMIMV
	 v2S/p+H6VbQSVnG4cb+T4F89LDHQSYBUARFVP7EU6b0VqeoieCJeSKwYyXglETHQ/EJ0x
	 mdrttNMnOMeb8eowjPWDFnXjeitDUk0n59udCGBdwp6GWuO19J9hrav4MILPLFoYk55pT
	 6So4Z79Mb2+rilQvrboEzKdBWX1lJV8I/lc3KAPjzjdGgUeqV6YItMm0QOSyVTWN3hke1
	 x4xKK0SPmfNo/Y/ywSrqyAUav/v4Miy2js5ft0wQzI2Q47U4he2W1pNKDmagWM1TRWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=MYFZ+lJn;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A7606A69A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 623A7606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=MYFZ+lJn
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386c336eab8so1106883eec.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795544285; x=1796149085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4RlhrfBwPHzP90Zy/c+f9A3RL0rfHp6IuDLrwxdd3U=;
        b=MYFZ+lJncBIycrG649o7p47c79ddDWNQ8TMatBbsZsH0MbbgPPDqbgNBrEerTWsDh1
         XIEVPzIs+WVAPMbarmykJT6/DVrANteAlya407ZUl5GM5udcCxwfu92Z7UCyWCsigD8D
         RNMqyYouLThLWGLxw1KiVYKGRoKrs8Ed+urrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544285; x=1796149085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4RlhrfBwPHzP90Zy/c+f9A3RL0rfHp6IuDLrwxdd3U=;
        b=ncEJF6D8/DtdOqdRwLUR/ogeA3P0O3zsGK9dkVOHlPNRM86uPK5Ba+6W6YfX111Z9i
         lFL0u7fA7rzd2/8vuKPKuPkXOTRdsSCsCZDUlxCpYkdKo7fX9GqctXywDgqwSvosect8
         4+2IyWpMLmkhI1ED9+S1/wPfbruIuSIyQf2dunsmXapnYroB4MfgH8RSYrwNaLZpQCLk
         EE29AQVl3Qflq10OE4kT0W9ikKzcXjjzi4/5OVSE4O72wBHeoHgbEtt3RRvwjeWApeiZ
         SNylu53IPrb5hkeC9czGnxQr81+/sDucl5B4KA2eP1EM0h8un4xv2jtGvUFYW1uiiK02
         Hw8w==
X-Forwarded-Encrypted: i=1; AL+hErHyhlae0JN6j823TfQuDHp9Y0upMM0kOGF8y5ua6ns4rCIz2DzoNr4njk4EAzphGGG2pYOhwRk=@vger.kernel.org
X-Gm-Message-State: APuU4Z83kHAXYZwZnkahpnFCvLAoN7okDCPws2+nRBIIyNZxR8TTiMWo
	4FLG2K868IZj/hr2vtC6LEx4rgg6Bz1c+JwgXqrAVJ76FAdygvNa57UL3+dkAqT67Eg=
X-Gm-Gg: AZFdTZddmWJE7ceS4/9HoDjTF3xisQXl6dRsAvfZTdA3hCkNGtdqJdEEZ6cj+T7Al5t
	teGavq4Xt7SMnVQ+QKPyQueSedXcaie5VRqUBIVYaVOCs5TI0Z1ra03K0rcNvtUWGiffQjJjesC
	lvfZAtZ0rPLOlXrkX3FSr5zwRPWU2iXjtf9lAPzcRwEZdlyV2VjGizcX2DX6QWsa68DdqvmZpEv
	pi0IRkTjfEDrIprZjiv/nwohaGhtm2bfCZ0fMQxo8c50fNeSWz92uPr3IiWKpJT+dfojXKhli12
	VUgxWYKnumlpxqEXNDn0mOc5Y/2c+n1gQxauBrJoVh15dUivF9Qd6h9yIqPhzQVH8Xgao95/XOa
	xG9jIk2g4FLxw78rxz5gUYmVWmnbfUFU4Jzb++qNSbgNoyAil64NFhJ/qKZBr5imEfnl0tmi67b
	WkdvzMsXavk1KxbP0D4Xhu8zsi9GhHwgmy9T5T820WAh7Zts9av+BejTDRUtIIiNTIdmmtamjK6
	JoyrfZMa5h0bMH/bDi5avgSGB5C7tinSKWUN2ciQAFjkLmZiDJh386oXMxddGY82xIdHkiIJEf2
	AtaNt3ugAhxYA9Bgicj9Is8/iwGtNRueu23yimDncK67TSRihbicZVTH16mKH7iCOaJtl+jm+1i
	Llq0bilRk0DZ0rz77cWHnYMxzMqRl4nSZqzKjgeC/YeI3J6KOq4YlUwnvm6DbvND3agVYXlfFa+
	ZSsx+nlhAQbQc=
X-Received: by 2002:a05:7301:dd8e:b0:386:6c8e:b4f7 with SMTP id 5a478bee46e88-3866c8ebd4bmr14565993eec.12.1795544284928;
        Tue, 24 Nov 2026 10:18:04 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm39138429eec.19.2026.11.24.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:18:04 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] can: j1939: reject an out-of-range data packet offset
Date: Tue, 24 Nov 2026 23:47:57 +0530
Message-Id: <20261124181757.638280-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
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

j1939_session_completed() passes the skb from j1939_session_skb_get() to
j1939_sk_recv(), which dereferences it on its first statement:

	se_skb = j1939_session_skb_get(session);
	/* distribute among j1939 receivers */
	j1939_sk_recv(session->priv, se_skb);

For a receive session that getter cannot fail by itself:
j1939_session_new()
queues one skb and j1939_session_fresh_new() sizes it to the whole message
with skb_put_zero(), and only j1939_session_skb_drop_old() and
j1939_session_destroy() ever remove one.  What makes it return NULL is
where
it looks:

	offset_start = session->pkt.dpo * 7;
	return j1939_session_skb_get_by_offset(session, offset_start);

pkt.dpo is the ETP Data Packet Offset, and for a receive session the only
thing that writes it is j1939_xtp_rx_dpo_one(), which stores the peer's
24-bit value without comparing it to anything:

	/* transmitted without problems */
	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);

So a peer can name a window past the end of the message, and the lookup at
dpo * 7 then finds nothing.  An ETP RTS, an ETP DPO with an offset at or
beyond pkt.total, and an EOMA reach the NULL dereference:

  j1939_xtp_rx_eoma()
    j1939_xtp_rx_eoma_one()
      j1939_session_completed()
        j1939_sk_recv()
          j1939_sk_recv_one()            <- skb->len on a NULL skb

An out-of-range offset has no other legitimate effect either: every data
packet that follows is rejected by the "packet > session->pkt.total" test
in
j1939_xtp_rx_dat_one(), which computes packet from the same dpo, so the
session can never complete with data.

Reject it where it arrives, and cancel the session as
j1939_xtp_rx_dat_one() does for a packet number it cannot place.  The
session's own data packets are already checked against pkt.total; this is
the same check for the offset they are counted from.

Look the received message up at offset 0 in j1939_session_completed() as
well.  The DPO window is where the next data packet belongs, not where the
message starts, and at completion it is the whole message that goes to the
sockets - for a receive session that is the single skb at offset 0, so the
lookup cannot fail there.  The NULL test stays as a second guard: if it
ever fires now, the queue has lost an skb that this file never removes
while the session is alive, which would be a kernel bug and not something
a peer did.

What that guard does NOT do is tell anyone.  The session is deactivated
with session->err still 0, so j1939_session_destroy() queues no
J1939_ERRQUEUE_RX_ABORT and a socket watching the error queue, having
already seen RX_RTS and RX_DPO, hears nothing more; no abort frame goes to
the peer either.  That is deliberate: setting session->err here would write
a field that __j1939_session_cancel() writes under
active_session_list_lock, and the path is no longer reachable from the wire
once the offset is checked above.

Found by AI-driven fuzzing built on top of syzkaller, and reproduced on
mainline 7.4-rc3 and 7.3.1 with a 61-line program over two sockets: KASAN
reports a NULL pointer dereference in j1939_sk_recv_one().  The ETP DPO
trigger above is the one in that reproducer; an EOMA alone, with dpo still
0, finds the zero-filled skb and delivers it, which is a separate question
about partly-filled receive buffers and not a memory-safety one.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
Link: https://lore.kernel.org/all/179553126874.3135.14817947057284289051@kernel.org/

That link is the review this version answers, which is a reply inside the
thread of the posting it supersedes:

  [PATCH net] can: j1939: do not pass a NULL session skb to the socket layer

The message-id of that mail is not recorded here - the send script writes no
log - so lore's thread view beside the review is where to find it.

Changes in v2, all from the review of v1:

 - v1 described the wrong trigger.  It said "an EOMA for a connection whose
   data packets never arrived", and the review showed why that cannot be it:
   j1939_session_new() queues one skb, j1939_session_fresh_new() sizes it to
   the whole message with skb_put_zero(), and nothing removes it while the
   session lives, so the queue is never empty for a receive session.  What
   fails is the lookup, because j1939_session_skb_get() looks at
   pkt.dpo * 7 and pkt.dpo is whatever the peer's last ETP DPO carried.  The
   reproducer sends exactly that - an ETP RTS, an ETP DPO with offsets of
   0xffffff, 0x100000, 0x010000 and 0x001000, then an EOMA - and its own
   comments say so; the analysis simply did not reach the commit message.

 - v2 fixes the cause instead of only the symptom, which is what the review
   asked.  j1939_xtp_rx_dpo_one() now rejects an offset that is not below
   pkt.total and cancels the session, the same way j1939_xtp_rx_dat_one()
   handles a packet number it cannot place.  The data packets of a session
   were already checked against pkt.total; this is the same check for the
   offset they are counted from.

 - j1939_session_completed() now looks the message up at offset 0 rather
   than through the DPO window, the review's other suggestion.  For a
   receive session that is the single skb covering the whole message, so the
   lookup cannot fail, and the NULL test stays only as a second guard.

 - v1's commit message claimed "the two other callers of the getter in this
   file already do" test the result, naming j1939_session_tx_dat() and
   j1939_xtp_rx_dat_one().  Both call j1939_session_skb_get_by_offset(), not
   j1939_session_skb_get(); the only other caller of the latter is
   j1939_simple_txnext(), which does test it.  That sentence is gone.

 - The commit message now says what the guard does not do: the session is
   deactivated with session->err still 0, so no J1939_ERRQUEUE_RX_ABORT is
   queued and no abort frame is sent, which the review asked to have stated.

Measured, and not: the NULL dereference was reproduced on mainline 7.4-rc3
and on 7.3.1 by the 61-line program in this series' report thread, and the
KASAN splat is in j1939_sk_recv_one().  With v2 the same program is refused
at the DPO - the session is cancelled before an EOMA can complete it - and
no splat follows.  Both hunks are compile-tested; checkpatch --strict
reports nothing.  We have no second CAN interface here, so only the vcan
loopback path was exercised.
---
 net/can/j1939/transport.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..225467843e42 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1242,10 +1242,15 @@ static void j1939_session_completed(struct j1939_session *session)
 	struct sk_buff *se_skb;
 
 	if (!session->transmission) {
-		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		/* the whole message, not the window the peer's last DPO
+		 * happened to name
+		 */
+		se_skb = j1939_session_skb_get_by_offset(session, 0);
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
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
 
+	dpo = j1939_etp_ctl_to_packet(dat);
+	if (dpo >= session->pkt.total) {
+		netdev_info(session->priv->ndev,
+			    "%s: 0x%p: data packet offset %u is not below the %u packet(s) of this session\n",
+			    __func__, session, dpo, session->pkt.total);
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+		return;
+	}
+
 	/* transmitted without problems */
-	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo = dpo;
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 
-- 
2.34.1

