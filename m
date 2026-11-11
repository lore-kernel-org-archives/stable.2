Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410258;
	b=cDJG0ZHPgZMojQU+dweQbKPUpgukkrA4eju7/0NiVkRI3epvzyI0iOMHKQLudZ9tYo9h
	 TtJr+W/FYxXUXTn86mCUCEdsP06ndEvyckmGr2ONXYACtYO+leabShTHln+9EcdH6rJNf
	 dfp35AyGsUxJpmAi50C5M7P3yQZilFWtrMpICK0sn5IEo6Mr6ajGzzQ5gWkmoVYya4tBU
	 eAPT8Q1kcOE6WQerkrmfVTcAcOg63SvYlDZH2b5pgwWrKe3Cis+6swGBYHH1rjqol3m6J
	 y1jnC2Jk3qYAf+xeTxa+YaZ1e8bSGRfTsDWSwj47eCiHeETLljuZLpg0rf/xYCs67pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H0K9/2yWQc9yGlSZDG/efoWRwME1E9flXkl10e5iCWM=;
	b=2uFMKdtMMAnr7yXES3Xu7toH91VloEEXqJndiw17OzxylUW+xiKqy+vIV1b6Rh2d6MtM
	 ZXrSOr5VogpgFdzoG3iq4quF82xuF45VNlviNboGaG6Bdkwn9EpGDc06uW9DwRH26lqq/
	 nd216ij3Q2rZsYsnCS4G1ZwHQ5VhQ6xuGpvvkTExwSNLn7fF8UPVJREg3us8Dx46p+NnA
	 gsp4nViMSx/1M9IQG54N0LPqVnhaxoGBkxVHKP9kWmayJqksnS+UzucSTEVLLCKjttLhj
	 xgi1o2grJkjm12QchO7YKvpSVhBHyLKp6GPMjppsw1vkV7/9ajPT5EXvprn9kLVFUlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="wW/zwBl6";
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5260606A338
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5260606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wW/zwBl6
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b315dd057bso25309407b3.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794410257; x=1795015057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0K9/2yWQc9yGlSZDG/efoWRwME1E9flXkl10e5iCWM=;
        b=wW/zwBl6BRNfowmy2+Xmisuk6gUggNWb+udYXwP5kuBeWyqudLQo+MBdELJCVXjWgX
         G9IgE/gJDpJttZjdULhGDAcTFqmOZa2XJyUSuf8yWkm0WNSiyj7cmVr0Tj/ZfvS2xYvk
         7rEENF4N4U3r7dB0Yiu9gUrmy5m0AHM0BSvlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410257; x=1795015057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0K9/2yWQc9yGlSZDG/efoWRwME1E9flXkl10e5iCWM=;
        b=PY/cy5Q+uP6h4hUgsaWswuzzPws80VWLCFc1HZFxKY2ugSTDvAdQqXFNE89XlmKw5n
         wVCmOBedsazutfqvTdgtqioypRY5rn2t4YyVJME9z7rXLSpoSVxKjayW4Eaxq37OJVKV
         d78FPMPy7+jm5rVkr+X8jppljB5TA4Knnj2jw0Oy6gXyFeiw+eE9XG4iM3TOsE5mrzs6
         oJIge63LEYmvBfCA+u6CUGg3ssY+Xn6+qBtiyzMfRm+vX9SSpRfV9jTs+nAaLg+Mpyjx
         AoD8kC9St0wDHAX7/g7fOIOr/D0buJxqh/g9/uv6GV0y4QTFFeSpcglPaP8ysm2Pkzjq
         Iryw==
X-Forwarded-Encrypted: i=1; AL+hErF7fMpilUXrY6wo2XZ9J3eAKvjlYuech91CqkrmB1wtytt0zUPJ324/vlU3VZUUIgdM8PX8ZG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+aRXLRx6qEXA8sh7vwCz4S6+CSTCmC0YBQn72pUWeaREui3dC
	JhUvvX97r+w7hd2lHkHWQkD51RtlXGYdl1fc8H0t2i5Ziw7I3/mlLSOMRYTr5P4Rlw==
X-Gm-Gg: AYBFou2qFcoiMl+lA++uJIoQtBUiWU86Om1QDqA3CroO2zilk2wqFhqRqyJhXxxv4Sl
	HyqO6p/Fij262ktmjz0NO+jV3PLjZfVEGcUCTuiwrGK879VtN0Ie3lDEr1spkTdhYoa+QAPSpcI
	XOPEXgxMpj5j4754SEKLV3P4l/B1cs5K5ry4S7cjar85fjZQ4aakqZdoqzAp2BAfdu+BioxI/y1
	lFVTGv91D+0/RHMxHlYNjsT77AUm3cMwOLEOzbhHAzcQeoUiOYebJRs+S5S0vjbTUtpPnySSKoR
	iQPQ5WVTu2YTOtMVs1Uib8U2Fu6l5kkqtv8aoyyFg+JE2BbWsd/IBkof+wFunGy5Hggwf1oCjPA
	DPaw8ZwZH2Az5dXKJ0Jyg1KGD6AHfEZOqzGgi/ojYEd/KGYn5+CQY4cwDjVO9spYV0axwIzH9XV
	/XnZMBTntcYCkltCXOCmbHjDDgfhhuiYGQA8wWFJ5S0q8oZA5EOuKJV2VcH3nKMrSjM047Y9Aw+
	FItairnNbLUF+AUezcu+HMEgNi2U5PVOZztiJOllSZ5yHa+Jc6ap1k71y84e7zaEMVR/phPFV78
	qma+0ARr2UlzMvi2M0n1LN6tak0m3IjK8GKmC/mxMjwGBSuuXSS4RZt8vRN3Y9FP+y2EOlLqM1Q
	iRExcYrCs0596iUg=
X-Received: by 2002:a05:690c:e01c:20b0:8b3:5969:f279 with SMTP id 00721157ae682-8b3a7e06f55mr17465347b3.3.1794410256810;
        Wed, 11 Nov 2026 07:17:36 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm46499187b3.27.2026.11.11.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:17:36 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 1/3] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Wed, 11 Nov 2026 10:17:28 -0500
Message-Id: <QDISC-6HS9.v4.r0.20261111094338-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
References: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
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

The issue:
teql_master_xmit() writes the slave's link header into the skb in
teql_resolve() and on retry pulls it back with __skb_pull().  Two bugs:

1. When the skb's header is cloned (e.g. a tc-mirred action on a
   physical device's clsact egress redirects to the teql master), the
   write corrupts the other clone.  Call skb_cow_head() first.

2. The pull always removes skb_network_offset() bytes.  For an
   AF_PACKET/SOCK_RAW frame with no dst entry, teql_resolve() adds no
   header, so the retry strips the user-supplied one.  Pull back only
   the length this slave added.

The Fix:
Track the added length per iteration; a header-cloned skb is unshared
before the write and an AF_PACKET frame retries with its header intact.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y and CONFIG_VETH=y, run as root. A teql master with
two veth slaves, the first slave returning NETDEV_TX_BUSY without
consuming the skb so that teql retries the frame on the second one:

  ip link add vethBAD type veth peer name vethBADp
  ip link add vethGOOD type veth peer name vethGOODp
  ip link set vethBAD up;  ip link set vethBADp up
  ip link set vethGOOD up; ip link set vethGOODp up
  tc qdisc add dev vethBAD root teql0
  tc qdisc add dev vethGOOD root teql0
  ip link set teql0 up

Send a SOCK_RAW frame that carries its own link header on teql0 and
capture it on the second slave's peer. A veth transmit does not return
NETDEV_TX_BUSY on its own; to hold the skb pending this reproduction used
a test-only IFF_DEBUG accelerator in veth_xmit(), which is not part of
this patch and was applied to both the unfixed and the fixed build.

On the unfixed tree the captured frame arrives with its header stripped
(176 of the 208 bytes sent, starting at the payload) because the retry
pulls skb_network_offset() bytes while this slave added none. With the
patch the frame arrives intact.

The shared headroom case needs a cloned skb: a PF_PACKET tap on the
master whose socket is never drained keeps the clone alive across the
transmit. A kprobe on eth_header then reports cloned=1 on the unfixed
tree and cloned=0 with the patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v3 -> v4:
- added Simon Horman's Reviewed-by, given on the v3 posting. The patch
  itself is unchanged; the series is resent because 2/2 had to be split
  as asked in the review of that patch.

 net/sched/sch_teql.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 70c948a26f80..ed8faa848f18 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -257,7 +257,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 static int
 __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	       struct net_device *dev, struct netdev_queue *txq,
-	       struct dst_entry *dst)
+	       struct dst_entry *dst, int *hlen)
 {
 	struct neighbour *n;
 	int err = 0;
@@ -288,15 +288,24 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	}
 
 	if (neigh_event_send(n, skb_res) == 0) {
+		int off = skb_network_offset(skb);
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
+		/* Unshare the header before dev_hard_header() writes to it. */
+		if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
+			err = -ENOMEM;
+			goto out;
+		}
 		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
 				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
+		/* The bytes prepended above skb->data, pulled back on retry. */
+		*hlen = skb_network_offset(skb) - off;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
 	}
+out:
 	neigh_release(n);
 	return err;
 }
@@ -304,11 +313,13 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 static inline int teql_resolve(struct sk_buff *skb,
 			       struct sk_buff *skb_res,
 			       struct net_device *dev,
-			       struct netdev_queue *txq)
+			       struct netdev_queue *txq,
+			       int *hlen)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	int res;
 
+	*hlen = 0;
 	if (rcu_access_pointer(txq->qdisc) == &noop_qdisc)
 		return -ENODEV;
 
@@ -316,7 +327,7 @@ static inline int teql_resolve(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	res = __teql_resolve(skb, skb_res, dev, txq, dst);
+	res = __teql_resolve(skb, skb_res, dev, txq, dst, hlen);
 	rcu_read_unlock();
 
 	return res;
@@ -330,6 +341,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct Qdisc *start, *q;
 	unsigned long flags;
 	int nores;
+	int hlen;
 	int busy;
 
 restart:
@@ -356,7 +368,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		switch (teql_resolve(skb, skb_res, slave, slave_txq)) {
+		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
@@ -403,8 +415,10 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			nores = 1;
 			break;
 		}
+		/* Pull back only the header this slave added. */
+		if (hlen > 0)
+			__skb_pull(skb, hlen);
 		skb->dev = dev;
-		__skb_pull(skb, skb_network_offset(skb));
 	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
-- 
2.43.0

