Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64339377034
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199725; cv=none; b=RxAGhnTA33HhmtB0R2E+6eJD6BKxh8CrINsVEvvF88nnU9YJ/pBOx34EI3L2k47i8e5DIkU7gfuvIFPnGz8S6EHaY1dfIPxLa7qdWWKJkGhb+rpcABCfOnCZtbtJeYnaatEm1Ij0HnYOZUzS4c8NhnwJO8/xRbs0Yg6U7pLFA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199725; c=relaxed/simple;
	bh=jLoITTQyqjZRMTDMZmGmGBhR5n73v9b89cpb3oVWsOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ5acltYByrKb8jG9DzEqaDSlzt5Q2SN6h57DnPRT/j3FWYDjbyWyMSDpWZFtOX2b0N14gptjU/3DKMM7EuVgL1XLhvoqmbKp1o/F8tJeFWAmL94m8aKwlhrsQ9He7rbmK0KMECX78v1mmbGS58GUwVmTvEpahCWnZukp2m0998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIcd50S+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIcd50S+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C431F00A3A;
	Thu, 20 Aug 2026 04:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199723;
	bh=4OTUzXBXtUP8Tpt1UpZPhwesai0XAWoBU0ByVUifMtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIcd50S+O8WIIOsMX+58titYtInpe3U4vV2AHeLUtS/R5LAVIhB1zU9tAPgKFSvfF
	 tSIhCAqfn4IcdcYCHJqYtJkrCwo/efoO1OpLz0Fh64w0AX1WAbSry/ZXRBoEisbXMk
	 tVwkvuITkC2YTnf39X6FIRw908PsvdNBFY2IXkRZSmsSUuaHIuTl5FsaZR94tvaWug
	 S3PbEOtaI5Qrz++Arl5TgXDbyok9HjV2whs3OL3xzJV3ztbt2+4QYa00DZLAM9knq+
	 oP25QX4hxU01F9hhaCgwNograux0gCf+8g4KeVvkiheXv2xDOiCEgadk4ZKanbLZLW
	 IIjMrhEZwfopQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] netfilter: nf_conntrack: defer invalid log until after unlock
Date: Thu, 20 Aug 2026 00:22:00 -0400
Message-ID: <20260820042200.1377170-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820042200.1377170-1-sashal@kernel.org>
References: <2026081731-reflux-overcrowd-ff11@gregkh>
 <20260820042200.1377170-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit 2d19b95c9723001f214f7a47d67b09f46238f200 ]

TCP and SCTP conntrack paths can emit invalid-packet logs while ct->lock
is still held.

When invalid logging is routed to nfnetlink_log and conntrack export is
enabled, the log path can re-enter conntrack netlink glue and dump the
same conntrack again. Protocol attribute dumping may take ct->lock, so
logging while holding that lock can deadlock.

Defer the TCP invalid logs by storing only the minimal log context while
ct->lock is held and emitting the log after unlocking. Also make the TCP
timeout-lowering invalid path return whether a log is needed, then emit
that log after unlocking.

Do the same for the SCTP invalid state-transition log that can be reached
while ct->lock is held.

Add a lockdep assertion to nf_ct_l4proto_log_invalid() so future callers
that log invalid conntracks while holding ct->lock are caught outside TCP
and SCTP as well.

Fixes: 628d694344a0 ("netfilter: conntrack: reduce timeout when receiving out-of-window fin or rst")
Fixes: d9a6f0d0df18 ("netfilter: conntrack: prepare tcp_in_window for ternary return value")
Fixes: f71cb8f45d09 ("netfilter: conntrack: sctp: use nf log infrastructure for invalid packets")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_proto.c      |   6 ++
 net/netfilter/nf_conntrack_proto_sctp.c |  12 ++-
 net/netfilter/nf_conntrack_proto_tcp.c  | 132 ++++++++++++++++--------
 3 files changed, 102 insertions(+), 48 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
index 895b09cbd7cfc..49ab379fefef6 100644
--- a/net/netfilter/nf_conntrack_proto.c
+++ b/net/netfilter/nf_conntrack_proto.c
@@ -79,6 +79,12 @@ void nf_ct_l4proto_log_invalid(const struct sk_buff *skb,
 	struct net *net;
 	va_list args;
 
+	/* nfnetlink_log may re-enter conntrack attribute dumping and try to
+	 * take ct->lock again via helpers such as tcp_to_nlattr(), so invalid
+	 * conntrack logs must only be emitted after dropping ct->lock.
+	 */
+	lockdep_assert_not_held(&ct->lock);
+
 	net = nf_ct_net(ct);
 	if (likely(net->ct.sysctl_log_invalid == 0))
 		return;
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index db5c32ca996bd..ed8add7011e97 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -340,10 +340,12 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 	struct sctphdr _sctph;
 	const struct sctp_chunkhdr *sch;
 	struct sctp_chunkhdr _sch;
+	bool log_invalid = false;
 	u_int32_t offset, count;
 	unsigned int *timeouts;
 	unsigned long map[256 / sizeof(unsigned long)] = { 0 };
 	bool ignore = false;
+	u8 invalid_type = 0;
 
 	if (sctp_error(skb, dataoff, state))
 		return -NF_ACCEPT;
@@ -455,10 +457,8 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 
 		/* Invalid */
 		if (new_state == SCTP_CONNTRACK_MAX) {
-			nf_ct_l4proto_log_invalid(skb, ct, state,
-						  "Invalid, old_state %d, dir %d, type %d",
-						  old_state, dir, sch->type);
-
+			log_invalid = true;
+			invalid_type = sch->type;
 			goto out_unlock;
 		}
 
@@ -533,6 +533,10 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 
 out_unlock:
 	spin_unlock_bh(&ct->lock);
+	if (log_invalid)
+		nf_ct_l4proto_log_invalid(skb, ct, state,
+					  "Invalid, old_state %d, dir %d, type %d",
+					  old_state, dir, invalid_type);
 out:
 	return -NF_ACCEPT;
 }
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 3fe813cad6d5a..ef1068f9c2fad 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -480,37 +480,81 @@ static void tcp_init_sender(struct ip_ct_tcp_state *sender,
 	}
 }
 
-__printf(6, 7)
-static enum nf_ct_tcp_action nf_tcp_log_invalid(const struct sk_buff *skb,
-						const struct nf_conn *ct,
-						const struct nf_hook_state *state,
-						const struct ip_ct_tcp_state *sender,
-						enum nf_ct_tcp_action ret,
-						const char *fmt, ...)
+enum nf_tcp_invalid_log_type {
+	NF_TCP_LOG_NONE,
+	NF_TCP_LOG_OVERSHOT,
+	NF_TCP_LOG_SEQ_OVER,
+	NF_TCP_LOG_ACK_OVER,
+	NF_TCP_LOG_SEQ_UNDER,
+	NF_TCP_LOG_ACK_UNDER,
+};
+
+struct nf_tcp_invalid_log {
+	enum nf_tcp_invalid_log_type type;
+	u32 value;
+};
+
+static enum nf_ct_tcp_action
+nf_tcp_store_invalid(const struct nf_conn *ct,
+		     const struct ip_ct_tcp_state *sender,
+		     struct nf_tcp_invalid_log *log,
+		     enum nf_ct_tcp_action ret,
+		     enum nf_tcp_invalid_log_type type,
+		     u32 value)
 {
 	const struct nf_tcp_net *tn = nf_tcp_pernet(nf_ct_net(ct));
-	struct va_format vaf;
-	va_list args;
 	bool be_liberal;
 
 	be_liberal = sender->flags & IP_CT_TCP_FLAG_BE_LIBERAL || tn->tcp_be_liberal;
 	if (be_liberal)
 		return NFCT_TCP_ACCEPT;
 
-	va_start(args, fmt);
-	vaf.fmt = fmt;
-	vaf.va = &args;
-	nf_ct_l4proto_log_invalid(skb, ct, state, "%pV", &vaf);
-	va_end(args);
-
+	log->type = type;
+	log->value = value;
 	return ret;
 }
 
+static void nf_tcp_log_invalid(const struct sk_buff *skb,
+			       const struct nf_conn *ct,
+			       const struct nf_hook_state *state,
+			       const struct nf_tcp_invalid_log *log)
+{
+	switch (log->type) {
+	case NF_TCP_LOG_OVERSHOT:
+		nf_ct_l4proto_log_invalid(skb, ct, state,
+					  "%u bytes more than expected",
+					  log->value);
+		break;
+	case NF_TCP_LOG_SEQ_OVER:
+		nf_ct_l4proto_log_invalid(skb, ct, state,
+					  "SEQ is over upper bound %u (over the window of the receiver)",
+					  log->value);
+		break;
+	case NF_TCP_LOG_ACK_OVER:
+		nf_ct_l4proto_log_invalid(skb, ct, state,
+					  "ACK is over upper bound %u (ACKed data not seen yet)",
+					  log->value);
+		break;
+	case NF_TCP_LOG_SEQ_UNDER:
+		nf_ct_l4proto_log_invalid(skb, ct, state,
+					  "SEQ is under lower bound %u (already ACKed data retransmitted)",
+					  log->value);
+		break;
+	case NF_TCP_LOG_ACK_UNDER:
+		nf_ct_l4proto_log_invalid(skb, ct, state,
+					  "ignored ACK under lower bound %u (possible overly delayed)",
+					  log->value);
+		break;
+	case NF_TCP_LOG_NONE:
+		break;
+	}
+}
+
 static enum nf_ct_tcp_action
 tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
 	      unsigned int index, const struct sk_buff *skb,
 	      unsigned int dataoff, const struct tcphdr *tcph,
-	      const struct nf_hook_state *hook_state)
+	      struct nf_tcp_invalid_log *log)
 {
 	struct ip_ct_tcp *state = &ct->proto.tcp;
 	struct ip_ct_tcp_state *sender = &state->seen[dir];
@@ -640,31 +684,29 @@ tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
 			sender->td_end = end;
 			sender->flags |= IP_CT_TCP_FLAG_DATA_UNACKNOWLEDGED;
 
-			return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_IGNORE,
-						  "%u bytes more than expected", overshot);
+			return nf_tcp_store_invalid(ct, sender, log, NFCT_TCP_IGNORE,
+				   NF_TCP_LOG_OVERSHOT, overshot);
 		}
 
-		return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_INVALID,
-					  "SEQ is over upper bound %u (over the window of the receiver)",
-					  sender->td_maxend + 1);
+		return nf_tcp_store_invalid(ct, sender, log, NFCT_TCP_INVALID,
+				   NF_TCP_LOG_SEQ_OVER, sender->td_maxend + 1);
 	}
 
 	if (!before(sack, receiver->td_end + 1))
-		return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_INVALID,
-					  "ACK is over upper bound %u (ACKed data not seen yet)",
-					  receiver->td_end + 1);
+		return nf_tcp_store_invalid(ct, sender, log, NFCT_TCP_INVALID,
+					   NF_TCP_LOG_ACK_OVER, receiver->td_end + 1);
 
 	/* Is the ending sequence in the receive window (if available)? */
 	in_recv_win = !receiver->td_maxwin ||
 		      after(end, sender->td_end - receiver->td_maxwin - 1);
 	if (!in_recv_win)
-		return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_IGNORE,
-					  "SEQ is under lower bound %u (already ACKed data retransmitted)",
-					  sender->td_end - receiver->td_maxwin - 1);
+		return nf_tcp_store_invalid(ct, sender, log, NFCT_TCP_IGNORE,
+					   NF_TCP_LOG_SEQ_UNDER,
+					   sender->td_end - receiver->td_maxwin - 1);
 	if (!after(sack, receiver->td_end - MAXACKWINDOW(sender) - 1))
-		return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_IGNORE,
-					  "ignored ACK under lower bound %u (possible overly delayed)",
-					  receiver->td_end - MAXACKWINDOW(sender) - 1);
+		return nf_tcp_store_invalid(ct, sender, log, NFCT_TCP_IGNORE,
+					   NF_TCP_LOG_ACK_UNDER,
+					   receiver->td_end - MAXACKWINDOW(sender) - 1);
 
 	/* Take into account window scaling (RFC 1323). */
 	if (!tcph->syn)
@@ -719,11 +761,8 @@ tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
 	return NFCT_TCP_ACCEPT;
 }
 
-static void __cold nf_tcp_handle_invalid(struct nf_conn *ct,
-					 enum ip_conntrack_dir dir,
-					 int index,
-					 const struct sk_buff *skb,
-					 const struct nf_hook_state *hook_state)
+static bool __cold
+nf_tcp_handle_invalid(struct nf_conn *ct, enum ip_conntrack_dir dir, int index)
 {
 	const unsigned int *timeouts;
 	const struct nf_tcp_net *tn;
@@ -732,7 +771,7 @@ static void __cold nf_tcp_handle_invalid(struct nf_conn *ct,
 
 	if (!test_bit(IPS_ASSURED_BIT, &ct->status) ||
 	    test_bit(IPS_FIXED_TIMEOUT_BIT, &ct->status))
-		return;
+		return false;
 
 	/* We don't want to have connections hanging around in ESTABLISHED
 	 * state for long time 'just because' conntrack deemed a FIN/RST
@@ -747,7 +786,7 @@ static void __cold nf_tcp_handle_invalid(struct nf_conn *ct,
 	case TCP_FIN_SET:
 		break;
 	default:
-		return;
+		return false;
 	}
 
 	if (ct->proto.tcp.last_dir != dir &&
@@ -755,7 +794,7 @@ static void __cold nf_tcp_handle_invalid(struct nf_conn *ct,
 	     ct->proto.tcp.last_index == TCP_RST_SET)) {
 		expires = nf_ct_expires(ct);
 		if (expires < 120 * HZ)
-			return;
+			return false;
 
 		tn = nf_tcp_pernet(nf_ct_net(ct));
 		timeouts = nf_ct_timeout_lookup(ct);
@@ -764,16 +803,15 @@ static void __cold nf_tcp_handle_invalid(struct nf_conn *ct,
 
 		timeout = READ_ONCE(timeouts[TCP_CONNTRACK_UNACK]);
 		if (expires > timeout) {
-			nf_ct_l4proto_log_invalid(skb, ct, hook_state,
-					  "packet (index %d, dir %d) response for index %d lower timeout to %u",
-					  index, dir, ct->proto.tcp.last_index, timeout);
-
 			WRITE_ONCE(ct->timeout, timeout + nfct_time_stamp);
+			return true;
 		}
 	} else {
 		ct->proto.tcp.last_index = index;
 		ct->proto.tcp.last_dir = dir;
 	}
+
+	return false;
 }
 
 /* table of valid flag combinations - PUSH, ECE and CWR are always valid */
@@ -969,7 +1007,9 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 	struct nf_tcp_net *tn = nf_tcp_pernet(net);
 	struct nf_conntrack_tuple *tuple;
 	enum tcp_conntrack new_state, old_state;
+	struct nf_tcp_invalid_log log = {};
 	unsigned int index, *timeouts;
+	bool lowered_timeout = false;
 	enum nf_ct_tcp_action res;
 	enum ip_conntrack_dir dir;
 	const struct tcphdr *th;
@@ -1253,14 +1293,18 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 	}
 
 	res = tcp_in_window(ct, dir, index,
-			    skb, dataoff, th, state);
+			    skb, dataoff, th, &log);
 	switch (res) {
 	case NFCT_TCP_IGNORE:
 		spin_unlock_bh(&ct->lock);
+		nf_tcp_log_invalid(skb, ct, state, &log);
 		return NF_ACCEPT;
 	case NFCT_TCP_INVALID:
-		nf_tcp_handle_invalid(ct, dir, index, skb, state);
+		lowered_timeout = nf_tcp_handle_invalid(ct, dir, index);
 		spin_unlock_bh(&ct->lock);
+		nf_tcp_log_invalid(skb, ct, state, &log);
+		if (lowered_timeout)
+			nf_ct_l4proto_log_invalid(skb, ct, state, "lowered timeout to UNACK");
 		return -NF_ACCEPT;
 	case NFCT_TCP_ACCEPT:
 		break;
-- 
2.53.0

