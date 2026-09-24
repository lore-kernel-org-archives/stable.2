Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A734A7C90
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267557; cv=none; b=PVe4TdtuDl29kJJVKq4SuH/EfsrrXuKPnS1vkC2xzCYbnbCCGHTYebqh9n148Sx8R/uqati06B23w2aMkx7FcXlg08e2ayoTaTf1lgOiMJca1mgZVAx6aQ4fYM7zBbF2c3CZ6DQRTOsNjieBxAL7/qsJE/i1q3g41TKo1QM7R9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267557; c=relaxed/simple;
	bh=QKqK1SED9TptquiMTz8o6iZFWqc1IryB3SoRM75XzX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkD5xL2cVub+ZnYUeoIUTn3C96JJr5bWf4TwF4oyHeaBfK/ze3ezDEWxx89G8z8+MXmC50rKUYFvq6z0yy9RpCU4g9kh8NghvuMsBEi+IWFw4t9CJkscGp75vswGmVq0IhY35NgIRN8o1oVASspgqv6fe7ERHgj559PAcA/wq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=PBvZraeb; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="PBvZraeb"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2df8de41d6eso2500045ad.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790267555; x=1790872355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6+HJ+r+UptjiSYMsQZ7F0EyXLti6EdIuXZaMaexHnY=;
        b=PBvZraebqGE3zm1+ACk/qywFTCYltCibeQFmvZWXv+uH31/vqAbvX6T78fisI8oH7h
         rQtbIUssL87exwt7DUQ1YMwyVsz+HVLbqKCeaDprxfRGmpIXFTl9qJzve3nRMsVCGo/5
         ZJeEkNjRD3r38pAveUgnm9DHZRd9ZtUK46zZ2baSCXS9B9gyxCMdxpvNck49rUJPn/az
         YuLANk/LNeAfMf4La4mzS7Q4hE+etLVegTJ7Q0RSDKrvMHa9nEuEIS25VeZoUTay5Lau
         YHwIgy+NMKS/6raVXq6blGA0bxgn1vCxNDWXyZL4Y0OUqW3ybb3t/quSWqndvDjZQkux
         AiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267555; x=1790872355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6+HJ+r+UptjiSYMsQZ7F0EyXLti6EdIuXZaMaexHnY=;
        b=CmdVlmg1+BX1xOqmIEEJl4nI8QWGSM93QV4Nyd5WLZsTz6jcpktWIlRVjL11ezxNq9
         KKyLhtkRbQMAr6xLP/OYwNdxM6TTJpEoSaSMhXB6Tcr/nbeZE63sbfpm7Ytl38qPDjNf
         MjC6F6aATf+gE2F7xkArcm517DH5jCqm41QOYDOfMjQTka/GPOc5tByAA2BUNVLk6SkY
         oLC1Et60wZzTAQlkSm8+F+/h0jVSXcE7HaJYBmQDbt8B5CV8V4EwOS+AL+xg/QxzlyE3
         9kMvc1LIpUhs4syQHfye3WYNz++tgCiGHpL6VU11nAFp4cnoMR4zAajMjLldyxGxbuKp
         UhfQ==
X-Forwarded-Encrypted: i=1; AKwUvBybTPep/Mf3TizOczlMvEknzH2QR/fFsLnouxajrxMrFtzwKtHAzU+WZKn3nOqQKga8uY7ShWg=@vger.kernel.org
X-Gm-Message-State: AFuF++n6Rznv27ksc12SqX+tBkw3MMfVppbCMrCSMsg0DbR2KnylquUK
	aJdC25jeyo45Ov4onh4NflKUyPToVTBQShCHxIMVddpdcD6W2Nvih0tVdhjX0iAMMnm6
X-Gm-Gg: AYBFou1rIx4G5e8kbL3e7AT4eX38dcNhzjqSeiddumi/QZjoLumcPuQCTGieSo6H9xs
	lMaJroWhcqako+GGJGYaxiVLwowUcUdg63RYJUbkCsfRDbInw2495QTSTX55oGu1a5zqaoicT0K
	oolYnxkCblkRUYRT9KRyQV8oAKhdUEjodIoQZRpR6/fzY4W1TogHxm9cj64wT1eRZ9Ma/Rd2oA8
	0xJHc+GO78fzlaMj5N4i7VTpDvJnldU0SOiPUQ9rTHekrwjCj29gu/juvQW50NY8FC1dn8tIBP2
	SVpaeOjKjr/IPJ3H29TM7KH37YdmE+fkIV430/eFkSx56RUvRFoA45tTwmZ0+qnQ5olglTiZquY
	YZDnab87JQRLSyTrFj78GQRNDm/YFx9Wczya/VY9XEDoDAerE1dazUOLiIc0zM0zOaMdNznbrv5
	PP7WjwyCg3mMro5rVX6NqKUPUzChuiY9XlMtWCGronp+1+stZRlncXoq0zhTbWC+vDEVmeipfiw
	r8nvoqksG3YPEwMSojg+4GzK8f1cg==
X-Received: by 2002:a17:902:f54a:b0:2dd:c100:b2cc with SMTP id d9443c01a7336-2df7dd61e8amr25516075ad.55.1790267554822;
        Thu, 24 Sep 2026 09:32:34 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm30365205ad.64.2026.09.24.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:33 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: zihanx@nebusec.ai,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v12 1/1] llc: fix listener child socket leaks
Date: Thu, 24 Sep 2026 16:32:11 +0000
Message-ID: <2af9949fc349d17b53db432893abb4d2e97932ce.1790255682.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790255682.git.zihanx@nebusec.ai>
References: <cover.1790255682.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLC listener processing could retain child sockets and their SAP and
netdevice references when passive-open setup did not complete, potentially
exhausting kernel resources.

Tie unaccepted-child cleanup to the connection indication and handle
failure and listener-teardown paths. Account pending indications against
the accept backlog, and retain the receive device while deferred packets
are processed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v12:
  - Order llc_conn_handler() locals in reverse Christmas tree order.
  - Limit child creation to SABME; preserve listener-side DM responses for
    DISC and other P=1 commands.
  - Hold skb->dev through backlog processing and drop ownerless deferred
    SABMEs if the listener leaves TCP_LISTEN before drain.
  - Keep accept-queue accounting and release unaccepted children on
    failure and teardown.
  - v11 Link:
    https://lore.kernel.org/all/cover.1790062133.git.zihanx@nebusec.ai/

changes in v11:
  - Defer listener child creation until backlog admission and disable
    bottom halves while publishing and processing a new child.
  - v10 Link:
    https://lore.kernel.org/all/cover.1789824800.git.zihanx@nebusec.ai/

changes in v10:
  - Complete SABME failure and teardown cleanup, count indications against
    the accept backlog, and serialize child publication and lookup.
  - v9 Link:
    https://lore.kernel.org/all/cover.1789216793.git.zihanx@nebusec.ai/

changes in v9:
  - Narrow the fix to non-SABME listener leaks; preserve the SABME child
    lifecycle and handle DISC/P=1 commands with listener-side DM replies.
  - v8 Link:
    https://lore.kernel.org/all/abc8b115321dbd417b8491d9e51f1988998ff50e.1788707641.git.zihanx@nebusec.ai/

changes in v8:
  - Correct queued-child reference handling and prevent stale or released
    children from reaching accept and backlog state-machine paths.
  - v7 Link:
    https://lore.kernel.org/all/cover.1788414881.git.zihanx@nebusec.ai/

changes in v7:
  - Drop the overlapping LLC state-bound patch and keep the listener leak
    fix, with child teardown and reproducer/crash evidence updates.
  - v6 Link:
    https://lore.kernel.org/all/cover.1787752861.git.zihanx@nebusec.ai/

changes in v6:
  - Track pending-child references across accept, receive, backlog and
    listener close paths.
  - v5 Link:
    https://lore.kernel.org/all/20260822082354.3109-1-zihanx@nebusec.ai/

changes in v5:
  - Reclaim pending children on listener-state/close paths and split the
    LLC_CONN_OUT_OF_SVC state-bound change into a separate patch.
  - v4 Link:
    https://lore.kernel.org/all/20260814185843.4748-1-zihanx@nebusec.ai/

changes in v4:
  - Introduce SABME-only child creation, listener DM replies and serialized
    rollback/close cleanup for unaccepted children.
  - v3 Link:
    https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/

changes in v3:
  - Remove an unused local and rebase the patch.
  - v2 Link:
    https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/

changes in v2:
  - Preserve SAP tuple matching while tracking pending children and
    reclaiming them on failure/drop paths; correct Fixes attribution.
  - v1 Link:
    https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/
---

 net/llc/llc_conn.c | 175 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 163 insertions(+), 12 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54c..77044720f12ff 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void __llc_sk_free(struct sock *sk, bool sync);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -90,6 +91,8 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 */
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
+		if (sk->sk_state == TCP_LISTEN)
+			sk_acceptq_added(sk);
 		sk->sk_state_change(sk);
 		break;
 	case LLC_DISC_PRIM:
@@ -765,14 +768,124 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
-	dev_hold(dev);
+	netdev_hold(dev, &newllc->dev_tracker, GFP_ATOMIC);
+	/* Serialize packets that can find the child after it is hashed. */
+	bh_lock_sock_nested(newsk);
 	llc_sap_add_socket(llc->sap, newsk);
 out:
 	return newsk;
 }
 
+static bool llc_sk_unhashed(const struct sock *sk)
+{
+	return hlist_nulls_unhashed_lockless(&sk->sk_nulls_node);
+}
+
+static void llc_free_incoming_sock(struct sock *sk, bool bh_locked)
+{
+	struct llc_sock *llc = llc_sk(sk);
+	struct llc_sap *sap = llc->sap;
+	struct net_device *dev = llc->dev;
+
+	if (!bh_locked) {
+		local_bh_disable();
+		bh_lock_sock_nested(sk);
+	}
+	llc->state = LLC_CONN_OUT_OF_SVC;
+	/* Keep both objects alive through timer teardown. */
+	llc_sap_hold(sap);
+	netdev_hold(dev, NULL, GFP_ATOMIC);
+	llc_sap_remove_socket(sap, sk);
+	bh_unlock_sock(sk);
+	if (!bh_locked)
+		local_bh_enable();
+	netdev_put(dev, &llc->dev_tracker);
+	sock_orphan(sk);
+	/* Initial SABME setup arms no timers before it can fail. */
+	__llc_sk_free(sk, !bh_locked);
+	netdev_put(dev, NULL);
+	llc_sap_put(sap);
+}
+
+static void llc_conn_ind_rfree(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+
+	sock_rfree(skb);
+	if (!sk->sk_socket)
+		llc_free_incoming_sock(sk, false);
+}
+
+static void llc_conn_send_dm_rsp(struct llc_sap *sap, struct sk_buff *skb,
+				 const struct llc_addr *saddr, u8 f_bit)
+{
+	struct sk_buff *nskb;
+	int rc;
+
+	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, 0);
+	if (!nskb)
+		return;
+
+	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
+			    saddr->lsap, LLC_PDU_RSP);
+	llc_pdu_init_as_dm_rsp(nskb, f_bit);
+	rc = llc_mac_hdr_init(nskb, skb->dev->dev_addr, saddr->mac);
+	if (unlikely(rc))
+		kfree_skb(nskb);
+	else
+		dev_queue_xmit(nskb);
+}
+
+static void llc_listener_send_dm(struct llc_sap *sap, struct sock *sk,
+				 struct sk_buff *skb, const struct llc_addr *saddr)
+{
+	if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
+		u8 f_bit;
+
+		llc_pdu_decode_pf_bit(skb, &f_bit);
+		llc_conn_send_dm_rsp(sap, skb, saddr, f_bit);
+	} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk, skb)) {
+		llc_conn_send_dm_rsp(sap, skb, saddr, 1);
+	}
+}
+
+static int llc_conn_rcv_sabme(struct sock *sk, struct sk_buff *skb,
+			      struct llc_addr *saddr,
+			      struct llc_addr *daddr)
+{
+	struct sock *newsk;
+	int rc;
+
+	if (sk_acceptq_is_full(sk))
+		goto drop;
+
+	local_bh_disable();
+	newsk = llc_create_incoming_sock(sk, skb->dev, saddr, daddr);
+	if (!newsk) {
+		local_bh_enable();
+		goto drop;
+	}
+	skb_set_owner_r(skb, newsk);
+	rc = llc_conn_rcv(sk, skb);
+	if (unlikely(rc || llc_sk(newsk)->state != LLC_CONN_STATE_NORMAL)) {
+		if (!rc)
+			rc = -EINVAL;
+		llc_free_incoming_sock(newsk, true);
+	} else {
+		/* The indication owns the child until accept() grafts it. */
+		skb->destructor = llc_conn_ind_rfree;
+		bh_unlock_sock(newsk);
+	}
+	local_bh_enable();
+	return rc;
+drop:
+	kfree_skb(skb);
+	return 0;
+}
+
 void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 {
+	struct net_device *backlog_dev = NULL;
 	struct llc_addr saddr, daddr;
 	struct sock *sk;
 
@@ -786,6 +899,10 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		goto drop;
 
 	bh_lock_sock(sk);
+	if (unlikely(llc_sk_unhashed(sk)))
+		goto drop_unlock;
+	if (unlikely(llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC))
+		goto drop_unlock;
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,11 +912,14 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
+		if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+			llc_listener_send_dm(sap, sk, skb, &saddr);
 			goto drop_unlock;
-		skb_set_owner_r(skb, newsk);
+		}
+		if (!sock_owned_by_user(sk)) {
+			llc_conn_rcv_sabme(sk, skb, &saddr, &daddr);
+			goto out;
+		}
 	} else {
 		/*
 		 * Can't be skb_set_owner_r, this will be done at the
@@ -813,13 +933,16 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
-		llc_conn_rcv(sk, skb);
-	else {
+	if (sock_owned_by_user(sk)) {
 		dprintk("%s: adding to backlog...\n", __func__);
 		llc_set_backlog_type(skb, LLC_PACKET);
+		/* The backlog can outlive the RCU protection of skb->dev. */
+		backlog_dev = skb->dev;
+		netdev_hold(backlog_dev, NULL, GFP_ATOMIC);
 		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
 			goto drop_unlock;
+	} else {
+		llc_conn_rcv(sk, skb);
 	}
 out:
 	bh_unlock_sock(sk);
@@ -830,6 +953,7 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	return;
 drop_unlock:
 	kfree_skb(skb);
+	netdev_put(backlog_dev, NULL);
 	goto out;
 }
 
@@ -852,12 +976,33 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct net_device *dev = NULL;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
-			rc = llc_conn_rcv(sk, skb);
-		else
+		/* Drop the reference acquired before the skb entered the backlog. */
+		dev = skb->dev;
+		if (unlikely(sk->sk_state == TCP_LISTEN)) {
+			struct llc_addr saddr, daddr;
+
+			if (llc_sk_unhashed(sk) ||
+			    llc->state == LLC_CONN_OUT_OF_SVC)
+				goto out_kfree_skb;
+			if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+				llc_pdu_decode_sa(skb, saddr.mac);
+				llc_pdu_decode_ssap(skb, &saddr.lsap);
+				llc_listener_send_dm(llc->sap, sk, skb, &saddr);
+				goto out_kfree_skb;
+			}
+			llc_pdu_decode_sa(skb, saddr.mac);
+			llc_pdu_decode_ssap(skb, &saddr.lsap);
+			llc_pdu_decode_da(skb, daddr.mac);
+			llc_pdu_decode_dsap(skb, &daddr.lsap);
+			rc = llc_conn_rcv_sabme(sk, skb, &saddr, &daddr);
+			goto out;
+		} else if (unlikely(llc->state <= 1 || !skb->sk)) {
 			goto out_kfree_skb;
+		}
+		rc = llc_conn_rcv(sk, skb);
 	} else if (llc_backlog_type(skb) == LLC_EVENT) {
 		/* timer expiration event */
 		if (likely(llc->state > 1))  /* not closed */
@@ -869,6 +1014,7 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 		goto out_kfree_skb;
 	}
 out:
+	netdev_put(dev, NULL);
 	return rc;
 out_kfree_skb:
 	kfree_skb(skb);
@@ -964,12 +1110,17 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
  *	Frees a LLC socket
  */
 void llc_sk_free(struct sock *sk)
+{
+	__llc_sk_free(sk, true);
+}
+
+static void __llc_sk_free(struct sock *sk, bool sync)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
 	llc->state = LLC_CONN_OUT_OF_SVC;
 	/* Stop all (possibly) running timers */
-	llc_sk_stop_all_timers(sk, true);
+	llc_sk_stop_all_timers(sk, sync);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
 		skb_queue_len(&llc->pdu_unack_q),
-- 
2.43.0

