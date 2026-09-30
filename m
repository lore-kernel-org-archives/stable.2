Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B242EEE65
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 05:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744610; cv=none; b=hMvIIB2Fa3nK/KwyULpMAMrpzYWa0piQ3watNkEX1IU7HORWoNXd2MizD5xiys+KCIk/UiLanTifP7PhaFcothJ060aiugfA61RYNpo0AiCyCBvF7yZ3IQ6WcWGGo52PuBmKUo7W1PTlXgtalcFginNqyu5xSyy+j6OhA8qAsLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744610; c=relaxed/simple;
	bh=cz7Y88W1/MR7TOjVwtNAZwqRv3ta4ZweRoDB77wkbwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaD9fQNDXsYvg4xjyw0L5CkE1cV8u2owc7mOG9thcwPLCVNyX304tb3TGYN8alg1GnQV1YkRDHQbpuqh1li/eEcnGLJwMCWb2Yk1HAjDlTrkftG2U5lgT6jjJ1gIgQtP/bauwIKb60gBvpSk0QORP/4vwnzjf/TQ6psUvmJJy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZPw6IMA; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZPw6IMA"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so4709589eec.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744608; x=1791349408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p812JoT9Qpf/qzrDI26kiElznMM0AcMiAysZGcluPEo=;
        b=TZPw6IMAXb2rUwGv2ko6bI6GEop1jS66s7rmQ1CZZqble+iJy2VUo2jRD7a786ZwMY
         Mpdvu1VOkmaqtr8X+p10S4TtCJM9EgRm8SWiMZj1Vn4WMHQuRNoQppBMt4I+CqAz2KAV
         VRbXztFmUVzhxIpiQw9vV+mZqwUjdv00x5NeV5FGwj0Jl95xWdSSnYfTz1pOSSREOLE+
         9/sGLvCag0ftfiNLRC+k/3KUdSwZGsEmSudkdPvgpP+sXdaRqWCUt800tw+NHbOVX3u1
         vqPydA/NyhebMNxOCgLa+IeFsrgZ7DN1ure8kkmRxrhpmUerGYhJCrSiAkNh/6W7krvm
         NK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744608; x=1791349408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p812JoT9Qpf/qzrDI26kiElznMM0AcMiAysZGcluPEo=;
        b=asEB2RBzEDgRqESH99ckoct7toyKvw7x9bSbaNCcp6ffgwMOtExE34rsm8iwlKXoZY
         SQUuFIoFvWRxreOcv0qlOiS8s9mNaL+z5G1Fns2qks4cRd4CAEOFpBcJZdufCGxREo13
         s+N44gIbL0ToH3v/U2qz2QWqTmeo5GI6TQPU1Qe8QMVdIODp1Q9eKOs4OLCAzOYJntKc
         Y21lXVLvuLswhX5yeJ5pfo7BQ+Vrqvz2Qtcserle0AnO7yyEWk/TrMNC6zeLrBRSdOwx
         1SKcd9IXfP4g4aH0CeMYjIdFCKsxwGLxD5x3nUcAwhtyi4CYWtu4RaYBCQ/ChoIZePZt
         7lZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCIXVg9NWko9zXHhMlfDSm5JGMmi6MV91A6pmgpRZVFch/Mu2B8zeHaThhO5RRXy9v/hRxAHg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzl05nXr5/N7sknbiLuLyb4kYrME42KlmH1nd4jWHFMGb9mwic
	AruuHmCQNmuBc+SMCk6/RpvzOFJaDkdPrUdcVPlGS9N/it2Sq5A7R6xn
X-Gm-Gg: AYBFou0CGNqgp4Jk3+4dHlsLsiY2BSdIFoPhKayUYhuiT11DuAnTHxWKfJabxbN4bhk
	hB9ar5IUK/CjXzoJbBhvnmrh4nyWXJX8r2fwWPt17Q26Y4B2tq70ctrnKzP1Hl11QEm9dO4733P
	o8x2F4SUb51syZp9sBFIfmHASJdOX+PAc2mq5rqgo79pw1PjmfBkoby/nyLIZN2NEtYyQti5c/4
	famzSGR/ez5e2JG+miTAGzVwYhEPIYCg60wcXvzgP5aa65bVKbCHhOYcQyPvQcMxT89eI/k+LyG
	2QeWIjAgvR1XDwLn8lW7CEJ20S1wsdtXI92nKMlAw9rRVm75VO3KW22aYC7uf+BVwRVh/phD0Cw
	bKEEYGlK+XQx+xDiTpZbBKHnnJudrPTuPVxCWUFMz5JxW5SsSU1KvcipvoHtXF93ZNtv0yOD/7w
	XceYzZ4j45gBe4Kv3R9edf2sJe2KBAerZfokLzhHp2g7FBLOvAASs7C2OVJSEw4X/fxGtFXqs=
X-Received: by 2002:a05:693c:2808:b0:34c:e77c:f92b with SMTP id 5a478bee46e88-34ce77cfa16mr437889eec.38.1790744608003;
        Tue, 29 Sep 2026 22:03:28 -0700 (PDT)
Received: from fox.. ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf4a63ac9sm772160eec.10.2026.09.29.22.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 22:03:27 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	chopps@labn.net,
	linux-kernel@vger.kernel.org,
	lilly@aronleigh.au,
	shubham@octane.security,
	gio@octane.security,
	robert@octane.security,
	paolo@octane.security,
	Roshan Kumar <roshaen09@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] xfrm: iptfs: track independent drop deadlines
Date: Wed, 30 Sep 2026 10:33:06 +0530
Message-ID: <20260930050307.1978654-2-roshaen09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930050307.1978654-1-roshaen09@gmail.com>
References: <20260930050307.1978654-1-roshaen09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP-TFS uses one hrtimer for two independently queued states: an
incomplete inner packet and the receive reorder window. Completing or
aborting reassembly cancels that shared timer unconditionally, so packets
in the reorder window can remain queued indefinitely.

Merely leaving the timer armed is insufficient. If it was armed for a
completed reassembly, its old deadline can expire a subsequent reassembly
before that packet's own drop interval has elapsed. A reassembly created
from a runt also does not arm the timer at all.

Record an absolute deadline for an in-progress reassembly. Whenever either
kind of queued state changes, arm the shared timer for the earliest active
deadline. On expiry, drop only state whose own deadline has passed and
rearm the timer for anything that remains.

Reported-by: Lilly Aronleigh <lilly@aronleigh.au>
Link: https://lore.kernel.org/netdev/20260824072851.301644-3-lilly@aronleigh.au/
Link: https://lore.kernel.org/netdev/apaRiWQn54Pr9hpm@secunet.com/
Fixes: 075694765446 ("xfrm: iptfs: handle received fragmented inner packets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 81 +++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6920940a35b4..e538cc98e257 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -143,6 +143,7 @@ struct skb_wseq {
  * @drop_time_ns: timer intervan in nanoseconds.
  * @ra_newskb: new pkt being reassembled.
  * @ra_wantseq: expected next sequence for reassembly.
+ * @ra_drop_time: deadline for dropping @ra_newskb.
  * @ra_runt: last pkt bytes from very end of last skb.
  * @ra_runtlen: size of ra_runt.
  */
@@ -172,6 +173,7 @@ struct xfrm_iptfs_data {
 	/* Tunnel input reassembly */
 	struct sk_buff *ra_newskb; /* new pkt being reassembled */
 	u64 ra_wantseq;		   /* expected next sequence */
+	u64 ra_drop_time;	   /* reassembly drop deadline */
 	u8 ra_runt[6];		   /* last pkt bytes from last skb */
 	u8 ra_runtlen;		   /* count of ra_runt */
 };
@@ -703,15 +705,38 @@ static void iptfs_complete_inner_skb(struct xfrm_state *x, struct sk_buff *skb)
 	}
 }
 
+/* Arm the shared timer for the earliest reassembly or reorder deadline. */
+static void iptfs_reset_drop_timer(struct xfrm_iptfs_data *xtfs)
+{
+	u64 expires = 0;
+	u64 now;
+
+	assert_spin_locked(&xtfs->drop_lock);
+
+	if (xtfs->ra_newskb)
+		expires = xtfs->ra_drop_time;
+	if (xtfs->w_savedlen &&
+	    (!expires || xtfs->w_saved[0].drop_time < expires))
+		expires = xtfs->w_saved[0].drop_time;
+	if (!expires) {
+		hrtimer_try_to_cancel(&xtfs->drop_timer);
+		return;
+	}
+
+	now = ktime_get_raw_fast_ns();
+	hrtimer_start(&xtfs->drop_timer, expires > now ? expires - now : 0,
+		      IPTFS_HRTIMER_MODE);
+}
+
 static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
 {
 	assert_spin_locked(&xtfs->drop_lock);
 
-	/* We don't care if it works locking takes care of things */
-	hrtimer_try_to_cancel(&xtfs->drop_timer);
 	if (free)
 		kfree_skb(xtfs->ra_newskb);
 	xtfs->ra_newskb = NULL;
+	xtfs->ra_drop_time = 0;
+	iptfs_reset_drop_timer(xtfs);
 }
 
 /**
@@ -845,6 +870,9 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 			goto abandon;
 		}
 		xtfs->ra_newskb = newskb;
+		xtfs->ra_drop_time = ktime_get_raw_fast_ns() +
+				     xtfs->drop_time_ns;
+		iptfs_reset_drop_timer(xtfs);
 
 		/* Copy the runt data into the buffer, but leave data
 		 * pointers the same as normal non-runt case. The extra `rrem`
@@ -1162,12 +1190,9 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 
 			xtfs->ra_newskb = skb;
 			xtfs->ra_wantseq = seq + 1;
-			if (!hrtimer_is_queued(&xtfs->drop_timer)) {
-				/* softirq blocked lest the timer fire and interrupt us */
-				hrtimer_start(&xtfs->drop_timer,
-					      xtfs->drop_time_ns,
-					      IPTFS_HRTIMER_MODE);
-			}
+			xtfs->ra_drop_time = ktime_get_raw_fast_ns() +
+					     xtfs->drop_time_ns;
+			iptfs_reset_drop_timer(xtfs);
 
 			spin_unlock(&xtfs->drop_lock);
 
@@ -1336,7 +1361,7 @@ static u32 __reorder_drop(struct xfrm_iptfs_data *xtfs, struct list_head *list)
 	u32 scount = 0;
 
 	if (xtfs->w_saved[0].drop_time > now)
-		goto set_timer;
+		return 0;
 
 	++xtfs->w_wantseq;
 
@@ -1363,13 +1388,6 @@ static u32 __reorder_drop(struct xfrm_iptfs_data *xtfs, struct list_head *list)
 		__vec_shift(xtfs, count);
 	}
 
-	if (xtfs->w_savedlen) {
-set_timer:
-		/* Drifting is OK */
-		hrtimer_start(&xtfs->drop_timer,
-			      xtfs->w_saved[0].drop_time - now,
-			      IPTFS_HRTIMER_MODE);
-	}
 	return scount;
 }
 
@@ -1423,10 +1441,7 @@ static void iptfs_set_window_drop_times(struct xfrm_iptfs_data *xtfs, int index)
 	while (index-- > 0 && !s[index].skb)
 		s[index].drop_time = drop_time;
 
-	/* If we walked all the way back, schedule the drop timer if needed */
-	if (index == -1 && !hrtimer_is_queued(&xtfs->drop_timer))
-		hrtimer_start(&xtfs->drop_timer, xtfs->drop_time_ns,
-			      IPTFS_HRTIMER_MODE);
+	iptfs_reset_drop_timer(xtfs);
 }
 
 static void __reorder_future_fits(struct xfrm_iptfs_data *xtfs,
@@ -1660,16 +1675,15 @@ static void iptfs_input_reorder(struct xfrm_iptfs_data *xtfs,
  * The drop timer is set when we start an in progress reassembly, and also when
  * we save a future packet in the window saved array.
  *
- * NOTE packets in the save window are always newer WRT drop times as
- * they get further in the future. i.e. for:
+ * Packets in the save window are always newer WRT drop times as they get
+ * further in the future. i.e. for:
  *
  *    if slots (S0, S1, ... Sn) and `Dn` is the drop time for slot `Sn`,
  *    then D(n-1) <= D(n).
  *
- * So, regardless of why the timer is firing we can always discard any inprogress
- * fragment; either it's the reassembly timer, or slot 0 is going to be
- * dropped as S0 must have the most recent drop time, and slot 0 holds the
- * continuation fragment of the in progress packet.
+ * Reassembly and slot 0 keep independent deadlines. The shared timer is armed
+ * for the earlier one, and this callback expires only the state whose deadline
+ * has passed before rearming for any state that remains.
  *
  * Returns HRTIMER_NORESTART.
  */
@@ -1679,6 +1693,7 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
 	struct list_head list;
 	struct xfrm_iptfs_data *xtfs;
 	struct xfrm_state *x;
+	u64 now;
 	u32 count;
 
 	xtfs = container_of(me, typeof(*xtfs), drop_timer);
@@ -1687,15 +1702,22 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
 	INIT_LIST_HEAD(&list);
 
 	spin_lock(&xtfs->drop_lock);
+	now = ktime_get_raw_fast_ns();
 
-	/* Drop any in progress packet */
-	skb = xtfs->ra_newskb;
-	xtfs->ra_newskb = NULL;
+	/* Drop an in-progress packet only after its own deadline. */
+	if (xtfs->ra_newskb && xtfs->ra_drop_time <= now) {
+		skb = xtfs->ra_newskb;
+		xtfs->ra_newskb = NULL;
+		xtfs->ra_drop_time = 0;
+	} else {
+		skb = NULL;
+	}
 
 	/* Now drop as many packets as we should from the reordering window
 	 * saved array
 	 */
 	count = xtfs->w_savedlen ? __reorder_drop(xtfs, &list) : 0;
+	iptfs_reset_drop_timer(xtfs);
 
 	spin_unlock(&xtfs->drop_lock);
 
@@ -2702,6 +2724,7 @@ static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 	xtfs->w_savedlen = 0;
 	xtfs->ra_newskb = NULL;
 	xtfs->ra_wantseq = 0;
+	xtfs->ra_drop_time = 0;
 	xtfs->ra_runtlen = 0;
 
 	__module_get(x->mode_cbs->owner);
-- 
2.43.0

