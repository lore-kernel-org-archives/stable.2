Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541474;
	b=bFjmKxXfOlKcD9A2AzC7gtoKg9BjEbNy9s6ui7e7+sif+q1m+ScWmhb1CDgQcTF+7T2O
	 ErGgnFj/0gygFa+53Cb5/8BbPOIO/n+ueYgYSCOqi1PZRsoIDdumT7n4OrdAbBEvGhfpH
	 t9HBV6amSHQJKMhDhqp9MwgIdN+xk5C6uHEzPN3qIzJZ8O355FdNbYefy82N5m3BRBEyo
	 lW25O/trDnBSLUFVSwpKUB5e0wvcwUcA9hk/GMqCQ5DGVDlYGtEL3xEs/Av7bTZEnkV5M
	 v7Ik4Fk8lopZ5yiEnYDaCJ87RGRiOSnhJJfLqHUwQ4AP/ud4MQelDYBHgCz69JX2vIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0RR5LvreyxciSo64ec1mUeCjNpiSiP2wPe91sNz/dzI=;
	b=awsVV2oentn5zIzkPpc7A0b4ufVdNLEUP2UpraNsgq4sil+BoSrysS6s22ZPE5sopRNr
	 di1CClD7X+iu7r8Q5Pw5b9ALk6pmEAxSy7iRStg8ParR/GWWY11v6IBzVWQaKmgLMlsCH
	 yn2/Bv9cAU09sVv/Iha2uX2RGhtkVF21DYISMP1ntD42CJGgmlXhgxudnthksTLzHkdHx
	 igTOnodIVrQN26eReOodiPGjsBVhWEMm1AezynpIUlrS1BpuRy9QMzH5A5g8rBDUuVS2e
	 RPEAv84CfUCx9lrQoqkpVqfCF1QkhNRB1BGQyT9YFY2qv+5ogAueugmpqcqRkv/4H1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Aa6JGeOV;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FE606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB6FE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Aa6JGeOV
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc758830601so3669554a12.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795541452; x=1796146252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RR5LvreyxciSo64ec1mUeCjNpiSiP2wPe91sNz/dzI=;
        b=Aa6JGeOVqgmBHeyX+CVHplahTzuhVl0rCOAqE63zoW/1gMj5sgVfQP4M/KQSltCw12
         KvG79kdzE1xh+zyzMhOhOz+XgyACK0vAmnofsMbkan46pRx64ah6a/Ua7sBgxA4pfnlR
         KeQg9O4XwM0HuhBkzFzbbaQnezPzAuUXfJLQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541452; x=1796146252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RR5LvreyxciSo64ec1mUeCjNpiSiP2wPe91sNz/dzI=;
        b=i82yCchjxagM6lb0BiTUFq5ZMvOoRaV74VkUYwsdySl2sYsGIC3eh84XSN3azwgkUO
         OXs4ZO1KD5hQ006ZZuRtIOHin4ygm0s0h2axD+Swhv4LPHYPjEQRtxuSSUBK07AMNW9J
         L/3BA94ulUdJTzNvCE4dh1i1m7E3RPP5NZ0jd6bFDbFbfaYtoWpqFHLrR9goTLqWzynk
         K30fiOnhqbuUXioy626tHC4z3gCx8aPGkbE+J3OpIJmdKnl2VALjY/v+kP3uq58HDIRD
         n0i5AD8aDD0ucqimf/+ma8oLx27T8ErOEmJz3AcBYkSYsDcLKAfERqxsuPHxyp/g6vmu
         hkJQ==
X-Forwarded-Encrypted: i=1; AL+hErF7M/bwWwfVTY9rRrVF+R3YJjiQQ+pSNJxIbA7I5vfLqK98r8Slhe75ltNzC94/xYDoKW9KHoo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xIRW6Um2a3yOFwlpzWI94lRUtRB8azXbb9tbWNVlALHteNVKt
	0+7ihHwlfd/8qPEqQxdXLJbXEX8TLNxdTFP0kBGg3L0yYKCfhBZbKh8vx497PLh0MN4=
X-Gm-Gg: AZFdTZeUuYodFm1DwmS0t8G74eSvO6RKWSfPRn8vkPio5VwMFlua1OMIZ3kvg7a484P
	zndLl+Dve+m70ssESkj/tLeiAiJMuObhKum8OnZjIn/N/Vd2ShXiO+1F3tCbbFoZdQOBjsjLwgU
	w/Ukqv7buZkbadFHv49dD+iGi/Mn2Hx2H9YhPednwLbiQ3ye1VjW+bALWLALWCxWMigSiOMV1Bh
	y5vEuczhNi0hGDdQWt3DTMGsdTcAcur8vtN2enaSkqmsZOK3tbDpqG+dEHC3Y8O/JA6cKGd7U9S
	g39DHcJP9tNgpHwZpTkf9jgml4rHuCYjMfCFGWHatgAMfNCSad5IonuJcHtXokf11TXxZWu87np
	iRe1Rr5wxB5peUPipZXDPisAjsSYJT+6KTN13I4uT3wu97l/e1/CXn3spJUyEylt103DLQabgYl
	wHZ7BBvj6lI0qPFI+5Edng4HT/ok0g/9FHF9VH2G9iRN3M+3Jg5HH4frkB2eiX9zQjjfHq/LVn5
	nlgkXk9K9qaQNOP5VAgPbuD0+5VFFl5StxiNBzs81t14IOlm3v6vqujwWRaIKmL8F42D9Jm8caN
	NSe3L3R9E/Q7rKF1hIAel0m0t08+VmNtB37UEmBj46CfDujZxP0wjNEjHutu/+H6JBDbLilHuqK
	pz7NP3ULnQyc7q7cQqevIg06ACHCZGt9jeWf6Z5v7Nb/xV0JdYBf1qWNROihcEWsN
X-Received: by 2002:a05:6a20:e614:b0:3e2:a849:64bc with SMTP id adf61e73a8af0-4014a271f0cmr15099410637.9.1795541452264;
        Tue, 24 Nov 2026 09:30:52 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285ccf4sm7249487b3a.12.2026.11.24.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:30:51 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kapil@presceralabs.ai,
	stable@vger.kernel.org
Subject: [PATCH net v3] net/smc: drop the connection when the peer's failover cursor is impossible
Date: Tue, 24 Nov 2026 23:00:44 +0530
Message-Id: <20261124173044.591937-1-piyus@iiitd.ac.in>
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

smc_switch_cursor() credits conn->sndbuf_space from the consumer cursor
the peer reported, with nothing bounding the amount:

	smc_curs_copy(&cons, &conn->local_rx_ctrl.cons, conn);

	if (smc_curs_comp(conn->peer_rmbe_size, &cons, &fin) < 0) {
		diff = smc_curs_diff(conn->peer_rmbe_size, &fin, &cons);
		smc_curs_add(conn->sndbuf_desc->len,
			     &conn->tx_curs_sent, diff);
		smc_curs_add(conn->sndbuf_desc->len,
			     &conn->tx_curs_fin, diff);

		smp_mb__before_atomic();
		atomic_add(diff, &conn->sndbuf_space);

local_rx_ctrl.cons is whatever arrived in the peer's last CDC message.
smc_cdc_cursor_to_host() drops only a cursor that moves backward within
one wrap, so a peer can advance cons.count by nearly peer_rmbe_size and
report consuming data this side never sent.  diff becomes that amount and
sndbuf_space ends above sndbuf_desc->len, breaking the
"0 <= sndbuf_space <= sndbuf_desc->len" that smc_cdc_tx_handler() states
and the tx path reads as free room in the send ring:

	writespace = atomic_read(&conn->sndbuf_space);
	/* not more than what user space asked for */
	copylen = min_t(size_t, send_remaining, writespace);

The first chunk of a two-part write is clamped against the buffer, the
second is not, so memcpy_from_msg() copies past the end of the send
buffer.  The two cursors advanced beside the credit can also leave the
ring: smc_curs_add() subtracts the size only once, so a diff of two
buffers or more leaves tx_curs_sent.count at or above sndbuf_desc->len,
and smc_tx_rdma_writes() uses that count as a source offset.

A peer reaches this path on an SMC-R link group with a second link by
asking for the active one to be deleted:

  smc_llc_rx_delete_link()
    smc_llc_process_cli_delete_link()
      smc_switch_conns()
        smc_switch_cursor()

An honest peer cannot have consumed more than this side has prepared and
not yet had confirmed, which is sndbuf_desc->len - sndbuf_space.  A peer
that reports more than that has broken the protocol, so drop the
connection the way smc_cdc_msg_validate() does for a sequence number that
cannot be honest - out_of_sync, peer_conn_abort, abort_work - and leave
the cursors alone.

Capping diff at that value instead was tried and is worse than it looks:
the cap keeps sndbuf_space and the cursors in range, but it leaves
local_tx_ctrl.prod behind local_rx_ctrl.cons, which is the state this
block exists to repair.  smc_write_space() then computes
peer_rmbe_size - smc_curs_diff(size, &cons, &prod) over an inverted pair;
with cons.wrap == prod.wrap + 1 that is negative, smc_tx_rdma_writes()
returns early on "rmbespace <= 0" for every later call, and the
connection stops sending for good.  Dropping the connection has no such
state to get wrong, and for a correct peer neither path is reached.

How this was found: by AI-driven fuzzing built on top of syzkaller.  It
reached the overflow through the other writer of sndbuf_space, the
DMB-nocopy credit patched next, on a loopback-ism connection with the
peer's consumer cursor forged by a debug patch: KASAN reported an
869056-byte write past the send buffer in smc_tx_sendmsg()
(use-after-free in _copy_from_iter).  The failover route above was then
found by reading the other writers of that counter; we do not have a
multi-link SMC-R group with two RDMA devices, so that route comes from
the code and not from a run.

Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
Cc: stable@vger.kernel.org
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
Link: https://lore.kernel.org/all/20261122053223.2497832-2-piyus@iiitd.ac.in/   

v2 was a two-patch series.  This is a respin of the first patch only, which is
the one the review covered; the second ("net/smc: bound the DMB-nocopy
send-buffer credit as well") is unchanged and is being answered separately.

Changes in v3, all from the review of v2:

 - Replaced the fix.  v2 capped diff at sndbuf_desc->len - sndbuf_space and
   carried on.  The review pointed out where that leaves local_tx_ctrl.prod:
   behind local_rx_ctrl.cons, which is the inversion the block exists to
   repair.  smc_write_space() then computes peer_rmbe_size -
   smc_curs_diff(size, &cons, &prod) over an inverted pair - for size 100,
   prod (0,90) and cons (1,10) that is -80 - and smc_tx_rdma_writes() returns
   early on "rmbespace <= 0" for every later call, so the connection stops
   sending for good.  The cap traded an out-of-bounds write for a permanently
   mute connection.  v3 drops the connection instead and leaves every cursor
   alone, which has no partially-advanced state to get wrong.

 - The bound is no longer called "sent", in the code or in the subject.  It is
   tx_curs_prep - tx_curs_fin, prepared and not yet confirmed, because
   smc_tx_sendmsg() lowers sndbuf_space when data is copied in rather than
   when it is written; the review was right that "outstanding" described a
   tighter bound than the code applied.

 - The violation is now visible: out_of_sync and peer_conn_abort are set and
   abort_work is queued, as smc_cdc_msg_validate() does for a sequence number
   that cannot be honest.  v2 silently continued.

Not addressed here, deliberately: the review also found that
smc_cdc_tx_handler() updates sndbuf_space and tx_curs_fin under
bh_lock_sock() while smc_switch_cursor() updates both under
conn->send_lock, so the old link's completions can race the switch.  That
is true before this patch too - the unpatched smc_switch_cursor() does the
same atomic_add() and the same tx_curs_fin advance under send_lock alone -
and it needs a completion to land in the window rather than a hostile
cursor, so it is a separate bug with its own Fixes: tag.  It is answered in
the reply to the review rather than fixed blind here: we have no multi-link
SMC-R group with two RDMA devices, and the obvious drain
(smc_cdc_wait_pend_tx_wr() before the send_lock) may stall on the
smcr_link_down() path, where the old QP's completions arrive only after
smcr_link_clear() flushes it.

Measured, and not: the overflow was measured on a loopback-ism connection
with the peer's consumer cursor forged by a debug patch - KASAN reported an
869056-byte write past a 65504-byte send buffer - and with the bound in place
no report at forged cursors of 100000, 1000000 and 2000000, with ordinary
SMC-D traffic unaffected (SMC_DIAG mode=2, fb_reason=0x0).  The LLC
DELETE_LINK route to smc_switch_cursor() has not been exercised here; it
comes from reading the code.  smc_core.c builds clean and checkpatch
--strict reports nothing.
---
 net/smc/smc_core.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index a3164201c142..ccfc3b1dc849 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1055,6 +1055,7 @@ static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
 {
 	struct smc_connection *conn = &smc->conn;
 	union smc_host_cursor cons, fin;
+	int unconfirmed;
 	int rc = 0;
 	int diff;
 
@@ -1069,6 +1070,38 @@ static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
 		 * fin above, so now prod is smaller than cons. Fix that.
 		 */
 		diff = smc_curs_diff(conn->peer_rmbe_size, &fin, &cons);
+		/* The peer's consumer cursor is taken as it arrives, so diff
+		 * is a value the peer chose.  It cannot honestly exceed what
+		 * this side has prepared and not yet had confirmed, which is
+		 * sndbuf_desc->len - sndbuf_space: smc_tx_sendmsg() lowers
+		 * sndbuf_space as data is copied in, and smc_cdc_tx_handler()
+		 * raises it again as the peer confirms.  A larger diff credits
+		 * sndbuf_space past the end of the send buffer - breaking the
+		 * "0 <= sndbuf_space <= sndbuf_desc->len" that the tx path
+		 * depends on - and pushes tx_curs_sent out of the ring, which
+		 * smc_tx_rdma_writes() then uses as a source offset.
+		 *
+		 * Simply capping diff is not enough: the cap would leave
+		 * local_tx_ctrl.prod behind local_rx_ctrl.cons, which is the
+		 * state this block exists to repair, so smc_write_space()
+		 * could return a negative peer_rmbe_space and the connection
+		 * would stop sending for good.  A peer that reports consuming
+		 * what was never prepared has broken the protocol, so drop the
+		 * connection, as smc_cdc_msg_validate() does for a sequence
+		 * number that cannot be honest.
+		 */
+		unconfirmed = conn->sndbuf_desc->len -
+			      atomic_read(&conn->sndbuf_space);
+		if (diff > max_t(int, unconfirmed, 0)) {
+			conn->out_of_sync = 1;	/* prevent any further receives */
+			conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
+			smc_wr_tx_put_slot(conn->lnk,
+					   (struct smc_wr_tx_pend_priv *)pend);
+			sock_hold(&smc->sk); /* sock_put in abort_work */
+			if (!queue_work(smc_close_wq, &conn->abort_work))
+				sock_put(&smc->sk);
+			return 0;
+		}
 		smc_curs_add(conn->sndbuf_desc->len,
 			     &conn->tx_curs_sent, diff);
 		smc_curs_add(conn->sndbuf_desc->len,
-- 
2.34.1

