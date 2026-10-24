Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843625;
	b=Vp3JhdOAo+VagdddWgtFTSecis9aMionhrJ8vRN/97Iq35MlNFnRLUJo19/AkH/rEN2t
	 Kaz0opdBHv4E7ILMWdUxfQuXrrTAKQaTVv/szz1lNYEG/pHoom+cD82FZXRJm7bbhbmpM
	 FJIRWWSFZ4GNoj26X6dYGxkymnndX5JuMKp8tb+Np3LQwPKEwzFtb1yMjx93C3Y1YwOBn
	 vo9NCZBa84RTOvzMGJWZRPIEq7fugGuuW3hMM/pe9j6KL3rV8+Y+zAB7hisD4qPz/ZIqf
	 hjRV1FpWjt86lkfipsa36jYQjZT2aAPpxtTIn2b3BBoguwmrVDL2uJwoagMOmy75tdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uu2r4qQ7rKcf6lbXrzsJwe2/zZRt2DJE0rOckBQSdno=;
	b=Sq+QmLC9oT1cnTSyEg0b4g2t6/2O/fE5AbITZ9jyVCyoVpqQKTeklqPgLdhqzMShr3X/
	 9SXzyXFirGm7lqbJXuA3Y2pxNJho6rECbNBCzI0N9fIqXFPhb8TRYrtfOhh6PqOUbLWv8
	 MZimJozg03/YAtsQONosrguQWWf6Xcq+tAgt4mfxmoJ+JmGvgTGBDCZDE2GZWgv9Ea2f4
	 pJYMpGts1ZNScTkYkjxExjLZa2oKboxv5Usnsg/1fZA4Cc/dfTyxlGbG5q2xwATyxaTbt
	 K7Fg/AiykD9suexxN9vGmabQl1ZiUY023JtemVaavW2VsMLeRQmlFVxsqltxMMnJDOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6Wq47Lk;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A8606A324
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C37A8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6Wq47Lk
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35b2c599f43so320638eec.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792843624; x=1793448424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uu2r4qQ7rKcf6lbXrzsJwe2/zZRt2DJE0rOckBQSdno=;
        b=g6Wq47LkpNSXLVvWGqo+/fi+41t47IPWvkfYMZFDqx4EHQiiWc7J4b8x6w7zI3Pnie
         9fVZV44lvv8ZCyOT0bNan0aWOd/XwhORdEHjRtrMRbiqqDtlym9RtONcOJ4TIJ7SMRnq
         PMm10VAstwJffYFwx0sJHFX+Z/lnUaoVE8GdIUiKNpTzLGG53PDSODbaXqT77RizDjyG
         0EDCXbJbyR231ZfoTmdQm87gnYi+oCmmXGMc6tnNoQsTDZ/EwQeXLRZv2YT4xu6JFaYH
         NpjbJz385mrTGE+iB7i1dW4LsxsojO0zs7CPZeGr3sjT2sMLDJc58k6HDQRc3xRSq9Dv
         wO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792843624; x=1793448424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uu2r4qQ7rKcf6lbXrzsJwe2/zZRt2DJE0rOckBQSdno=;
        b=pBLXllSCh487UtRP53oGsfbwKYNunEAa4Fl1SfeuUTeAJhMoKp8rhf47pPKBaB08Dk
         BspB2lMnpFajG+qTm3tQN+yjrzzi5XUm2FjE8niSkeaGRhwX/3SYbVel2nFhpbxCxs6P
         NtMI5bq9GjYYVvJ9jR+stm+aLzF6+VRORbyaX/LMRDaz1d3QJe188c8nLldiK4zlzQLM
         oT67GZy4GVvE3Dabevq2ybG8pD5aYOJEns9jX+iNWmSbiPkrT1O0cZNVDTN4n/9G+wNw
         u0cenT5t1T6PdR2fkhHFKRwd7HTbFV4235moFYoQTGzhlRkxszWmLNCEarFJcqi5/rI9
         vvWA==
X-Forwarded-Encrypted: i=1; AKwUvBxayrGOEbS6XTnKZEnjiJiDXv9sGIQxjpBAFWgWFGmHI4ceaxGpVfBkUu/0WXS+jE4gMaXx5tM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpOD/scdADNR3h2rouVvQ7wO9nFMeyBXtgWf2ECfsIG+oapxIs
	0pdD4d5pnmQRXRmTlkQrGNjg6G/5U/dupnZbhlt18oKVaRC6R6gOR07E
X-Gm-Gg: AYBFou2x3zbNK3jcxEqNq7RWsACJmKHM+d1MvfXVrZZYbcu3lbMY+qG6AJFtHNJTZov
	X1Jr5q/kiHQsDttpOoVpjZsgwbzb+m0HShvWVklMR1bZBCfnSDPWymuEwILVa3uEqJVk7/HCPXp
	cXzUe3aTWD5rI1PiVQ4axM73XaUEJEPE4A7Vkm8uwFbn2Rnir7rbqudltvWJRlv2w4HWTSevi93
	aJl8hMCRhZ3r8nfeD2rUswqALWMIYT1nE6Kb7xL38Sc6kvNv7nnFJ6i2+BqsPE/HUUdUC3IjFfU
	OcxwML/9sDgwv89Vmi9C5LzPLf5osuG0Ac584Z41Z7a39DdiyA6/vrlTwpi3MqhWkBh54rmY6LT
	95X6bxxLgkHzyzQJ/J9RaQ4C/r4TZ5I4aW9fxZskIY81ZnDk7NeFw2sdHs2HMC5yI5EzmIeFSi4
	4Xq9l5/Y63kfOWfeNMu1G411PLyeBsD/0jZi2NB8o61eu5aukiyVxLI7wNOeq9gfXky2pDm0sYk
	U5p2nwkyUOeJg8PK0i/x6ub7ixXvRGNJIJQPOet1P06xjepxjmeJ77W14lprl6n3ysAEEXCb8++
	kCaOhpzJuPNLwz5G97Gwj/FS+g==
X-Received: by 2002:a05:693c:8354:b0:35e:a117:8fd8 with SMTP id 5a478bee46e88-369e845c762mr2593551eec.17.1792843623579;
        Sat, 24 Oct 2026 05:07:03 -0700 (PDT)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d95e91sm8120722eec.15.2026.10.24.05.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:07:03 -0700 (PDT)
From: Tim Budding <tim.budding@gmail.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Budding <tim.budding@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/4] sctp: purge abandoned I-DATA fragments by stream and MID, not by TSN
Date: Sat, 24 Oct 2026 05:06:24 -0700
Message-Id: <20261024120627.837568-2-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024120627.837568-1-tim.budding@gmail.com>
References: <20261024120627.837568-1-tim.budding@gmail.com>
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

When an I-FORWARD-TSN is received, sctp_report_iftsn() calls
sctp_intl_reasm_flushtsn(), which frees every fragment in reasm and
reasm_uo with a TSN at or below the New Cumulative TSN. That is only
correct for DATA chunks, where the fragments of a message use
consecutive TSNs. With I-DATA, fragments of messages on different
streams can be interleaved, and RFC 8260 section 2.2.3 says the receiver
"MUST NOT make any assumption about the TSN assignments of the sender".

So when a PR-SCTP message is abandoned while a large message on another
stream is still being received, the fragments of the large message below
the abandoned TSN are freed as well. They have already been acked and
are not retransmitted, so the large message is never delivered, its
remaining fragments stay queued until a later I-FORWARD-TSN covers them
or the association goes away, and on an ordered stream every later
message is blocked behind it. Also, received fragments of the abandoned
message above the New Cumulative TSN are only freed if a later
I-FORWARD-TSN happens to cover them.

The skip entries of the I-FORWARD-TSN already identify the abandoned
messages by stream, U bit and MID. Free the fragments from
sctp_intl_skip() based on those instead. An entry carries the largest
skipped MID for its stream and U bit (RFC 8260 section 2.3.1), and a
sender fragments only one message per stream at a time (section 2.2.2),
so all fragments on that stream with a MID at or below it can be freed.
The reassembly queues are sorted by stream and MID, so the walk stops
once it is past them. Fragments that no skip entry names, such as a late
copy of an abandoned fragment, are no longer freed by an unrelated
I-FORWARD-TSN; they stay until the association is freed. The association
reset paths that also call sctp_report_iftsn() are not affected: they
pass the highest TSN seen, so sctp_intl_abort_pd() still flushes the
whole ulpq for them.

Observed in real use as unexpected message loss when sending messages of
mixed sizes over one association; the cause was found by AI-assisted
code inspection. Reproduced on an unmodified kernel with the ordered and
unordered tests of the sctp_ifwdtsn.sh selftest added later in this
series, which pass with this fix.

Fixes: 47b20a88566f ("sctp: implement report_ftsn for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Budding <tim.budding@gmail.com>
---
 net/sctp/stream_interleave.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index 840f24045ae2..f8c818a5533c 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -1203,28 +1203,21 @@ static void sctp_report_fwdtsn(struct sctp_ulpq *ulpq, __u32 ftsn)
 	sctp_ulpq_abort_pd(ulpq, GFP_ATOMIC);
 }
 
-static void sctp_intl_reasm_flushtsn(struct sctp_ulpq *ulpq, __u32 ftsn)
+static void sctp_intl_reasm_flush_mid(struct sk_buff_head *reasm, __u16 sid,
+				      __u32 mid)
 {
 	struct sk_buff *pos, *tmp;
 
-	skb_queue_walk_safe(&ulpq->reasm, pos, tmp) {
+	skb_queue_walk_safe(reasm, pos, tmp) {
 		struct sctp_ulpevent *event = sctp_skb2event(pos);
-		__u32 tsn = event->tsn;
 
-		if (TSN_lte(tsn, ftsn)) {
-			__skb_unlink(pos, &ulpq->reasm);
-			sctp_ulpevent_free(event);
-		}
-	}
-
-	skb_queue_walk_safe(&ulpq->reasm_uo, pos, tmp) {
-		struct sctp_ulpevent *event = sctp_skb2event(pos);
-		__u32 tsn = event->tsn;
+		if (event->stream < sid)
+			continue;
+		if (event->stream > sid || MID_lt(mid, event->mid))
+			break;
 
-		if (TSN_lte(tsn, ftsn)) {
-			__skb_unlink(pos, &ulpq->reasm_uo);
-			sctp_ulpevent_free(event);
-		}
+		__skb_unlink(pos, reasm);
+		sctp_ulpevent_free(event);
 	}
 }
 
@@ -1232,8 +1225,6 @@ static void sctp_report_iftsn(struct sctp_ulpq *ulpq, __u32 ftsn)
 {
 	/* Move the Cumulattive TSN Ack ahead. */
 	sctp_tsnmap_skip(&ulpq->asoc->peer.tsn_map, ftsn);
-	/* purge the fragmentation queue */
-	sctp_intl_reasm_flushtsn(ulpq, ftsn);
 	/* abort only when it's for all data */
 	if (ftsn == sctp_tsnmap_get_max_tsn_seen(&ulpq->asoc->peer.tsn_map))
 		sctp_intl_abort_pd(ulpq, GFP_ATOMIC);
@@ -1260,6 +1251,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 			sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x1,
 						  GFP_ATOMIC);
 		}
+		sctp_intl_reasm_flush_mid(&ulpq->reasm_uo, sid, mid);
 		return;
 	}
 
@@ -1271,6 +1263,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 		sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x0, GFP_ATOMIC);
 	}
 
+	sctp_intl_reasm_flush_mid(&ulpq->reasm, sid, mid);
 	sctp_mid_skip(stream, in, sid, mid);
 
 	sctp_intl_reap_ordered(ulpq, sid);
-- 
2.34.1

