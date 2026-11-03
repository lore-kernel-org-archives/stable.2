Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709563;
	b=BNM3u/we0DO3CG4yR92M5BpShfESkfaIu7rlR5T2p3DZ1dqcMrzwwrf1h64wKVpfucn/
	 5JrkMtA21Aocwhzb1zZaD3WtSO2nrsiLli1nAuTh1XdnJ+cWgwr4cnq0DXpzMvU2laZa4
	 GIjc1mj534Ik7Ff2lrkLBYBOI9jOyJp42virXE7/JH3lkQrvwOVnSomwzwUPOciTpS4DH
	 ZXVwnd2xkZW55NrGi+S4mOEiWxLu+DTSRKBydciEqtm8BjhWxcJcSNhwYMgQILjNXozAz
	 /OfUkzFZ5/kh44aJu7XZWMmJjkeWpA6URmUR6CM4YnSUDF2oENedIjsCZxKVqvC0QSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tm2LiE4/DJlGbRR1Qduao2CPxUSYAOE/zxSX5BBGV6Y=;
	b=AFmGjNNMj7Yy2ztO4IpV/5nX6Rc2aoC92NPlWOBn2TrKrJa2cwEwBmOaW6SenPWKuWKl
	 KJn7aEa8Wq4uVUOF/LxCb7rzJvFeeKlxoyoVMDpXYKgC3Z8NHBtYntPmP5+1WUMDdHtYf
	 Um19shsHW+vpxndltkNoUNMLvNHaOJB9VrrQjliMHcY0xLvvm1rNiDL1iRoxgZyYlmmKR
	 3gMx9agN2TafvuCD8TMzTuDfQGix1gO6wPoepf6OEXDGMQU6ng2GiiR3mWJWdENlGimtU
	 XnM+J7/7D3HU/M4wvgxQvQK+aaqfoDEtPH/t+lPKgmBdOxDeeAS7/S/5DdOWFubIBAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=irhBASRD;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676AC606A330
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 676AC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=irhBASRD
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab395abf79so35704967b3.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 04:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793709561; x=1794314361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tm2LiE4/DJlGbRR1Qduao2CPxUSYAOE/zxSX5BBGV6Y=;
        b=irhBASRDKUcKRumnEaAmTY2ljeO5oCcgsk6kEBR8a2L4NCX98cPcs9ddKJ7VCMF0bB
         /NPLlHLqyZ3pxOvGm4BNU6TcS+ZBe3qgRwutMuR8kZZCVxDvq7EYK3JKyijVasvpZhI3
         ZKRwvNW5+q2TepaNm+aUKPjdfo+joRe9qGLAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709561; x=1794314361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tm2LiE4/DJlGbRR1Qduao2CPxUSYAOE/zxSX5BBGV6Y=;
        b=Rp71I2jJR98Dpao+ehhPdjcyRYMnHvDXfyRTFz4Pb7xDn2xaaTIcIMsIfQWG0Qxv9z
         pOVTs48TlgqKKE3ZyyOwZKJTGzZy1H48BSWdD+wwzC8zgJOq3rz9rrhn/IUuWfElRCsL
         3T0y//iYTXMp1XSP7Tml1NERDJXKx66yZcTtSUq3bueHCowy0gOB6uRJz9FXjUWfdi14
         MezdqE/1LBwq1CME5MbGGWKh/Q3GvW6Gvl2o2Fo58gnk0/Zvop2HXN8cDMv15ErTgTwn
         Sm7nHW/YjPZ7E1ZPXrwXX/nb//rPSEFcLkryVy/8D497okzCEBtRNNLtdFEORuzUznXM
         mGOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWJ3F5OmGXaN9xTn9If+BI0kbd/2HD8q4kfYEWcm0an6nOGlJj0FHWD58/l07guN8lDhzZzXw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bai3jnI8OsrvXDAxFn6RWyaIdVslhusJoBfcVZZDgGBq1UFuO
	rykVpWN6bSfVZXN5l+vDnIz3ghTTlH0/MWJiF2ircE4JjcbaLK1SN8yaBlV3mDJfvw==
X-Gm-Gg: AYBFou2dHTu9mvJx2ZbuMy6Y2QKn5ejpTx6bMjmiZtNpCnO5sgiRgyLHoYOTCrMloOr
	yvcK+FxKKu2a67dh/OjceD6AJ/yua8s1TPvyQoaxKMZFod+VHZcqP5r40w/qhjeh8Y/b/Aaka+M
	mCwC6YTa3zTIovALRxFe8Eg6SurJC2oVf9M3Ti5SsWA4dW+/2F1TEk/jhEsHgV8AC5OnbLzfpJl
	kb3mceISx51HXVDYGG4Ro/JUth5Zb9/UF0wuMfUvomMOvGctxD2ThioqyLxkPxRehOJsIDirijC
	buvLc3MhZTk3DgCKDE6mgb65BbYFoj0gG5nyoXVfYwthzBPSGQs6eD4C1FSjG7z1+7njaQHWXWi
	3Z2VFvzKq9XDc2FEpz+434j8axv4sUoKi1ObIla0QjuJStqJVOClgaj4eCqKOfCizsYS9LeyPKu
	XL5Efgy3xAuczNGFbIy7RG+dzHWrv/2oRTFT78VvWOsO1dkXV09srbPgGrHwLyVABRPP/eXcFLc
	IV4g/xVlrT1UTnvQdwDXZyI1/cfn4wCLS9AutxO0bUzy6gV1VECTGe58JNuk8z/g5U1JYAHgW9B
	bi/8OEpt6MiDtgCreyvm62BfABQGIZRDzA6L1rktTRLKetgMoYvg770TnOf4JrCsxHhve4MXZTW
	QUE3EYkDLNiG2Xus=
X-Received: by 2002:a05:690c:3481:b0:8b0:c71d:2b2b with SMTP id 00721157ae682-8b2b67a315bmr89336457b3.45.1793709561190;
        Tue, 03 Nov 2026 04:39:21 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b716d420sm72011827b3.33.2026.11.03.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:39:20 -0800 (PST)
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
Subject: [PATCH net v3 1/2] net/sched: sch_teql: unshare the header before writing and fix retry strip
Date: Tue,  3 Nov 2026 07:39:15 -0500
Message-Id: <QDISC-6HS9.v3.r0.20261103073017-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
References: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
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
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
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
