Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543394;
	b=fR0/snRumc9c6aA59H8o/Z0ReUOLRtR7gYbjiTyitsZ9JMxW5cvcIkhy1m5VYN0hSeKQ
	 VcBTuLhjCuMIPCwJujxPfIByfH1ckgjtMsrj0PR8lW9oLj02czN5yv7qsDbt7O2dWEwzi
	 8iZQPrYnXRfljmxm65D2mv1JAGU1dUOVPpPfnn/pcenSBLVhDhOpFrOx+jAvmTA1l1Axu
	 s+M09MALxG4fLvmTJo0sZUzEJKTQ6YMQ6e54qn5lglM0wNIVldAIVoEDe36XTiLcTetNW
	 GFfZpDYDmhx0W28ZdrbFD590dlInE/NviqfYF2vvfnt8jo8nFQgsxM/Xk+BNqrajDlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1jUuBF7eQNwXtL5wRLiBR7q4uAQORLCmzJW5JBoOYGk=;
	b=cf32h1F6tEKBxD/AfWQKRT0FGdRbElMqr/Gawv986/LduhFU2lPMC2pasfgvMYjPaKCB
	 C9WmpzGyVxImVJ3RXrhZ519wvf7BapemkvYynFPZXODNCP/G3p4C+DeDG09Mhpzlp7slq
	 30m1carVhE06WmF33SEUkxk1fkgciy5YTZHGu9+ZgKHOi6vJNiux+GnnGlx4SuAUUfMr5
	 5tb2r36a/5mN/m6+mo3mtSja96N/naBQM3ijx6MkVrxWPiep98AdSrvr+EXGPxjvf16E7
	 2pyIJpM4z7eph9Gpkeb2/m1bT20DYuSxzk2Xoy2MPEooN3gZVLdPsRe9tEyIlrA+kDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=SqpCvpCy;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48961606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48961606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=SqpCvpCy
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f0458cc9easo37662485ad.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795543385; x=1796148185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1jUuBF7eQNwXtL5wRLiBR7q4uAQORLCmzJW5JBoOYGk=;
        b=SqpCvpCyRwlp6GpqNAhP4gjrE7Uzjjt/OmvmkNhJMeILJsze4lAEbUoGo7NKwOsoS5
         2bOufsGFfdqwVRaAKw5vhXkSSPcROmPUvBLRn2LJAUKQ8QfxxInIzY0rNd8G1RH3ksgi
         8N0sE4K5LfcNfepKJdQGzGzq21p3m/CegXhzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543385; x=1796148185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1jUuBF7eQNwXtL5wRLiBR7q4uAQORLCmzJW5JBoOYGk=;
        b=GsTdxo2QC85ytYScNm6e378p1KMX2/N9RpQBO4R8QAnQ7E9oMWVum1j3adxKvEbw4p
         BU78q9uXZMN64aIh5cLyBly7SBKyslc2Z8HrDKCpRks000BjdcvIDS1h3pR8tbKf2ez8
         9+lB8z38QejeHAZPA8ihKOyDko4R7vYxUTZRG4OPe+WeEsj8Oc3C8ngu/YInUGI1SgUC
         g5htBPTa91KFsV/TNWAqXDPyMDxOpE+ORIpY8op0USaaoNK/wHQt41VRd1lOvA6YRNzu
         +nPYKa4CNHgQ8BjQIpwl863InO+t8Zh+IHw68l827iz8w/E4sbf0FwALSBLDlokCxgQ7
         5Sog==
X-Forwarded-Encrypted: i=1; AL+hErGXxxMTyveEpSdhHPuYAZxV9+jl0L3uVqYa6+iVkI6exA+LkgYmzsjPAxJIzxcVAHozsIF1Kgc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/k8aVyp62D4zzrDWk++UL9UJ5Y64K1XH5fYcYxX2vuY47xbKn
	8t6sJGRFKaBGBF/ZhEE+W0mIZYTLPndtRRZqBhdznjLDdlz6UZXMDf0ZwHP7xSa3j+5lVTKdZsX
	gQQFVDjc2bg==
X-Gm-Gg: AZFdTZeOw2RBFqX4rmuQV3YpyXQ+SyzzPGWkJbjqEKY2T32Q42qjF7DqcQ+p2QJX2GC
	jhOrcwrcqng4MTus51GTiQxW6J3yk0lolZWKxNOCiWjtMGkt4IYt4UQ/72GvdRe5HvD5kXT8fzH
	Mz7Z2NSPmUFXRsLH1c7668lQZ5alZtBAfQjPOgQDl2ONuJ0LTHFK9cEaJnGCFwuDer6u50QOdib
	4AxQ4fq3gW5PvfI6FnvUAmFjja3DXHL1AIKJsalL2hpsipEfx9LA5u9Wd4AwJO34VkrETtIfZsG
	QDXkFEa1lpKZLlui58Hx7P1U015OdjAbs94xLlcJEC+wXxjzXIN46rS5Di8mN7EEWtqpF5W0mZ5
	NWVWad3V2p9O2Kiuz8BFX8QXAdGbh2398efkayP3qUCFM0XXhnCIZiaK9TnYmGBTlpJzVKEVlun
	SUMxsqScALLLfNQcgV1UIysmoMq/z9c/gPTot3xFuyMk6edirPcvIQ30/n+uSRr3Ofl294Ojj3f
	ILrr+hCJyJ/vPVzIJMKmF5YSP6cwGMehIYqwZhqWpoQnOWNO/yUWGFDpp4NGdN8sslJ3fJMm+FC
	aEwiUR63vOPqeJBLTPeApcwteQmjR9tMsqi/qBZb3A1kxJvMd0H5mHv9M9bGMW9h5M+cO7F43bN
	rpLJq13twcV72BgN3yggYm2d/0h5T2UPz1PlD7t4HndNZRXc7OMsBa5oxGvudY3n/
X-Received: by 2002:a17:902:fd8c:b0:2f0:7f99:e46b with SMTP id d9443c01a7336-2f07f99e585mr87061925ad.47.1795543384579;
        Tue, 24 Nov 2026 10:03:04 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b76sm73488545ad.50.2026.11.24.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:03:04 -0800 (PST)
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
Subject: [PATCH net v3] net/smc: bound the DMB-nocopy send-buffer credit by what was sent
Date: Tue, 24 Nov 2026 23:32:57 +0530
Message-Id: <20261124180257.622064-1-piyus@iiitd.ac.in>
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

smc_cdc_msg_recv_action() credits sndbuf_space from the peer's consumer
cursor on the SMC-D DMB-nocopy path and then assigns that cursor to this
side's tx_curs_fin:

	diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
				&conn->tx_curs_fin,
				&conn->local_rx_ctrl.cons);
	/* increase local sndbuf space and fin_curs */
	smp_mb__before_atomic();
	atomic_add(diff_tx, &conn->sndbuf_space);
	/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
	smp_mb__after_atomic();
	smc_curs_copy(&conn->tx_curs_fin,
		      &conn->local_rx_ctrl.cons, conn);

sndbuf_space can already be non-zero when this runs, so the sum can
exceed sndbuf_desc->len and the comment asserting otherwise does not
hold; smcd_cdc_msg_to_host() takes the cursor in host order with no
validation, so tx_curs_fin can also be assigned a count outside the send
buffer.

Unlike the failover path in smc_switch_cursor() this is not reachable
from a hostile peer today.  The branch runs only when
smc_ism_support_dmb_nocopy() is true, which needs a dibs device providing
support_mmapped_rdmb(), and the only provider is
drivers/dibs/dibs_loopback.c - where both ends of the connection are the
same kernel and the cursor is written by SMC itself.  So this is
hardening rather than a fix for an observed attack: it keeps the
invariant in the comment true by construction, keeps the cursor inside
the buffer, and stops a future device that implements the op from
inheriting the problem.

Bound the credit by the bytes this side has sent and not yet had
confirmed - smc_curs_diff(len, &tx_curs_fin, &tx_curs_sent) - and
advance tx_curs_fin by the bounded amount instead of assigning the
reported cursor.  For a cursor that reflects real consumption both are
the value that is used today.

That the bound is tx_curs_sent and not tx_curs_prep matters here.  The
peer can only consume as far as the producer cursor it was given, and
smc_tx_rdma_writes() advances that cursor together with tx_curs_sent, so
sndbuf_desc->len - sndbuf_space is the wrong quantity: it is the
distance to tx_curs_prep and admits bytes that are only prepared.
Bounding by it would move tx_curs_fin past tx_curs_sent and break the
fin <= sent <= prep order the three cursors are documented with in
smc.h, after which a later smc_tx_sendmsg() could wrap out of
tx_curs_prep into [tx_curs_sent, tx_curs_prep) and overwrite queued data
before it has been advertised.  smc_switch_cursor() uses the longer
distance, but it rewinds tx_curs_sent to tx_curs_fin first and advances
both, so the order holds there; here only tx_curs_fin moves.

How this was found: by AI-driven fuzzing built on top of syzkaller, on a
loopback-ism connection with the peer's consumer cursor forged by a debug
patch so that it reports consuming data this side never sent.  KASAN
reported an 869056-byte write past the send buffer in smc_tx_sendmsg()
(use-after-free in _copy_from_iter).  With this patch the same forged
cursor credits nothing beyond what was sent.

Fixes: cc0ab806fc52 ("net/smc: adapt cursor update when sndbuf and peer DMB are merged")
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
Link: https://lore.kernel.org/all/179552966151.3135.8162716126718648323@kernel.org/

That link is the review this version answers, which is a reply inside the
thread of the posting it supersedes:

  [PATCH net v2 2/2] net/smc: bound the DMB-nocopy send-buffer credit as well
  posted 2026-11-23

so following it reaches that posting and its discussion.  The message-id of
the v2 mail itself is not to hand here; lore's thread view beside the review
has it.

v2 was a two-patch series, and each patch drew its own review.  This respins
the second one only; the first ("net/smc: drop the connection when the peer's
failover cursor is impossible") is answered in its own thread.

Changes in v3, from the review of v2 2/2:

 - Changed the bound, which is the whole of this patch.  v2 used
   sndbuf_desc->len - sndbuf_space.  The review pointed out that this is the
   distance from tx_curs_fin to tx_curs_PREP, so it admits bytes that have
   only been prepared, and that the peer can only consume as far as the
   producer cursor it was given - which smc_tx_rdma_writes() advances together
   with tx_curs_sent.  Bounding by the longer distance could therefore move
   tx_curs_fin past tx_curs_sent and break the fin <= sent <= prep order the
   three cursors are documented with in smc.h, after which a later
   smc_tx_sendmsg() could wrap out of tx_curs_prep into
   [tx_curs_sent, tx_curs_prep) and overwrite queued data before it has been
   advertised.  v3 uses the bound the review suggests:

	unconfirmed = smc_curs_diff(conn->sndbuf_desc->len,
				    &conn->tx_curs_fin, &conn->tx_curs_sent);

   smc_curs_diff() already returns 0 rather than a negative value, so the
   max_t() that guarded the subtraction is gone with it.

 - The variable is no longer called "sent" and neither the comment nor the
   commit message says "outstanding".  The value is what was sent and not yet
   confirmed, and the text now says that.

Not addressed here, deliberately: the review also notes that peer_rmbe_space
is credited from the same peer-reported cursor with no bound at all, a few
lines above this branch, and that its "guarantee 0 <= peer_rmbe_space <=
peer_rmbe_size" comment is therefore false for a forged cursor.  That is
pre-existing, as the review says, and it is a different counter with a
different Fixes: tag which runs for every SMC-R and SMC-D connection rather
than only this loopback-only branch.  Both of its questions are answered in
the reply to the review; it wants its own patch, exercised on real SMC-R,
which we cannot do here.

Measured, and not: the overflow this guards was measured on a loopback-ism
connection with the peer's consumer cursor forged by a debug patch - KASAN
reported an 869056-byte write past a 65504-byte send buffer - and with the
bound in place no report at forged cursors of 100000, 1000000 and 2000000,
with ordinary SMC-D traffic unaffected (SMC_DIAG mode=2, fb_reason=0x0).
Those runs were made with the v2 bound; the v3 bound is narrower, so it
admits no case the v2 one refused.  smc_cdc.c builds clean and checkpatch
--strict reports nothing.
---
 net/smc/smc_cdc.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df321..ecac93023d32 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -333,6 +333,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 	union smc_host_cursor cons_old, prod_old;
 	struct smc_connection *conn = &smc->conn;
 	int diff_cons, diff_prod, diff_tx;
+	int unconfirmed;
 
 	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
 	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
@@ -361,13 +362,34 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 			diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
 						&conn->tx_curs_fin,
 						&conn->local_rx_ctrl.cons);
+			/* This difference comes from the cursor the peer
+			 * reported, which is taken as it arrives.  The peer
+			 * can only have consumed what this side actually
+			 * sent - smc_tx_rdma_writes() advances tx_curs_sent
+			 * together with the producer cursor the peer sees -
+			 * so bound it by that and advance tx_curs_fin by the
+			 * bounded amount rather than assigning the reported
+			 * cursor.  The invariant below then holds by
+			 * construction, tx_curs_fin stays inside the send
+			 * buffer, and it stays at or behind tx_curs_sent:
+			 * bounding by sndbuf_desc->len - sndbuf_space would
+			 * also admit bytes that are only PREPARED, which
+			 * would move tx_curs_fin past tx_curs_sent and break
+			 * the fin <= sent <= prep order the three cursors are
+			 * documented with.
+			 */
+			unconfirmed = smc_curs_diff(conn->sndbuf_desc->len,
+						    &conn->tx_curs_fin,
+						    &conn->tx_curs_sent);
+			diff_tx = min_t(int, diff_tx, unconfirmed);
+
 			/* increase local sndbuf space and fin_curs */
 			smp_mb__before_atomic();
 			atomic_add(diff_tx, &conn->sndbuf_space);
 			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 			smp_mb__after_atomic();
-			smc_curs_copy(&conn->tx_curs_fin,
-				      &conn->local_rx_ctrl.cons, conn);
+			smc_curs_add(conn->sndbuf_desc->len,
+				     &conn->tx_curs_fin, diff_tx);
 
 			smc_tx_sndbuf_nonfull(smc);
 		}
-- 
2.34.1

