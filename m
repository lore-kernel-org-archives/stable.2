Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F88367B67
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199723; cv=none; b=VpZkn4YyVeEZ1TRmw87WL1PCSiAFCeyGUMRnCDQJqrKDY1RhlDyNWoUbCm+D41CIwZIFAM65skdPiljwUrkf2pbdb+ARoc/z13lThSBbwNXgxKyXSBCOk/iXFuwr2Iupej6z/+9KjoE8InL3nzJyT/+p1Jh9rINQHDK5JYUomXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199723; c=relaxed/simple;
	bh=WeRBdW2Ufcow++y1ET1evh7lHZh1v2/cRqJLMOa4Sd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtwgbaHTh1GYuwLcEnAlUa2hHqQX437qzjpwK6yftPvGKpCl3DE7kFxgwxoni4p5TP2Gv0J+/JwZR1O0AARyKwR4ONH8uf1vDFDKL/Rjiyya+EWQvIgsBt017e2A6tObnIEngLcJMdIFlbYEzFnjMKHQ0UHZ8bQyqiWQcj5fOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIR/OHri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIR/OHri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CB31F000E9;
	Thu, 20 Aug 2026 04:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199722;
	bh=WVjujSXwxC/vTGmrcGa4P0Dk776aY2BPDcvDOVE7qdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CIR/OHrieKA27y121byFbEOa1ICET3KBZ+FP4U7tyJA4nC6vpvSL56pYIPBTr+eUs
	 2BTFtQXD2rmv9MJmf+AEUDMNxTHWVxa/ck58Lb3KTZpmh/H2AwsBqBhLK0417ItFex
	 j8HgnE0Ba4/DZl4aBM3DquJtU7neqwrN61qwutILlqmnDKIhxbm7xXIfUOJl+LsSEM
	 ubiCMbGLCJE824xbKRE5zHN66SyElTuzoUtsOhsonftfInjpmURjGjwl1uSSRFxMDa
	 7J0Mgc+jowo+eqMLlAPheNCNRNLNBVorteOUWT1hcSY/r8njfq91E0QTIVbVsULqnR
	 i64l1w8GKa5hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] netfilter: conntrack: sctp: use nf log infrastructure for invalid packets
Date: Thu, 20 Aug 2026 00:21:59 -0400
Message-ID: <20260820042200.1377170-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081731-reflux-overcrowd-ff11@gregkh>
References: <2026081731-reflux-overcrowd-ff11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit f71cb8f45d092a1805e9ad474b6c6a17219cede5 ]

The conntrack logging facilities include useful info such as in/out
interface names and packet headers.

Use those in more places instead of pr_debug calls.
Furthermore, several pr_debug calls can be removed, they are useless
on production machines due to the sheer volume of log messages.

Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: 2d19b95c9723 ("netfilter: nf_conntrack: defer invalid log until after unlock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_proto_sctp.c | 44 +++++++++----------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index ae89f3c590e8b..db5c32ca996bd 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -152,7 +152,8 @@ for ((offset) = (dataoff) + sizeof(struct sctphdr), (count) = 0;	\
 static int do_basic_checks(struct nf_conn *ct,
 			   const struct sk_buff *skb,
 			   unsigned int dataoff,
-			   unsigned long *map)
+			   unsigned long *map,
+			   const struct nf_hook_state *state)
 {
 	u_int32_t offset, count;
 	struct sctp_chunkhdr _sch, *sch;
@@ -161,8 +162,6 @@ static int do_basic_checks(struct nf_conn *ct,
 	flag = 0;
 
 	for_each_sctp_chunk (skb, sch, _sch, offset, dataoff, count) {
-		pr_debug("Chunk Num: %d  Type: %d\n", count, sch->type);
-
 		if (sch->type == SCTP_CID_INIT ||
 		    sch->type == SCTP_CID_INIT_ACK ||
 		    sch->type == SCTP_CID_SHUTDOWN_COMPLETE)
@@ -177,7 +176,9 @@ static int do_basic_checks(struct nf_conn *ct,
 		      sch->type == SCTP_CID_COOKIE_ECHO ||
 		      flag) &&
 		     count != 0) || !sch->length) {
-			pr_debug("Basic checks failed\n");
+			nf_ct_l4proto_log_invalid(skb, ct, state,
+						  "%s failed. chunk num %d, type %d, len %d flag %d\n",
+						  __func__, count, sch->type, sch->length, flag);
 			return 1;
 		}
 
@@ -185,7 +186,6 @@ static int do_basic_checks(struct nf_conn *ct,
 			set_bit(sch->type, map);
 	}
 
-	pr_debug("Basic checks passed\n");
 	return count == 0;
 }
 
@@ -195,64 +195,47 @@ static int sctp_new_state(enum ip_conntrack_dir dir,
 {
 	int i;
 
-	pr_debug("Chunk type: %d\n", chunk_type);
-
 	switch (chunk_type) {
 	case SCTP_CID_INIT:
-		pr_debug("SCTP_CID_INIT\n");
 		i = 0;
 		break;
 	case SCTP_CID_INIT_ACK:
-		pr_debug("SCTP_CID_INIT_ACK\n");
 		i = 1;
 		break;
 	case SCTP_CID_ABORT:
-		pr_debug("SCTP_CID_ABORT\n");
 		i = 2;
 		break;
 	case SCTP_CID_SHUTDOWN:
-		pr_debug("SCTP_CID_SHUTDOWN\n");
 		i = 3;
 		break;
 	case SCTP_CID_SHUTDOWN_ACK:
-		pr_debug("SCTP_CID_SHUTDOWN_ACK\n");
 		i = 4;
 		break;
 	case SCTP_CID_ERROR:
-		pr_debug("SCTP_CID_ERROR\n");
 		i = 5;
 		break;
 	case SCTP_CID_COOKIE_ECHO:
-		pr_debug("SCTP_CID_COOKIE_ECHO\n");
 		i = 6;
 		break;
 	case SCTP_CID_COOKIE_ACK:
-		pr_debug("SCTP_CID_COOKIE_ACK\n");
 		i = 7;
 		break;
 	case SCTP_CID_SHUTDOWN_COMPLETE:
-		pr_debug("SCTP_CID_SHUTDOWN_COMPLETE\n");
 		i = 8;
 		break;
 	case SCTP_CID_HEARTBEAT:
-		pr_debug("SCTP_CID_HEARTBEAT");
 		i = 9;
 		break;
 	case SCTP_CID_HEARTBEAT_ACK:
-		pr_debug("SCTP_CID_HEARTBEAT_ACK");
 		i = 10;
 		break;
 	default:
 		/* Other chunks like DATA or SACK do not change the state */
-		pr_debug("Unknown chunk type, Will stay in %s\n",
-			 sctp_conntrack_names[cur_state]);
+		pr_debug("Unknown chunk type %d, Will stay in %s\n",
+			 chunk_type, sctp_conntrack_names[cur_state]);
 		return cur_state;
 	}
 
-	pr_debug("dir: %d   cur_state: %s  chunk_type: %d  new_state: %s\n",
-		 dir, sctp_conntrack_names[cur_state], chunk_type,
-		 sctp_conntrack_names[sctp_conntracks[dir][i][cur_state]]);
-
 	return sctp_conntracks[dir][i][cur_state];
 }
 
@@ -369,7 +352,7 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 	if (sh == NULL)
 		goto out;
 
-	if (do_basic_checks(ct, skb, dataoff, map) != 0)
+	if (do_basic_checks(ct, skb, dataoff, map, state) != 0)
 		goto out;
 
 	if (!nf_ct_is_confirmed(ct)) {
@@ -392,7 +375,9 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 	    !test_bit(SCTP_CID_HEARTBEAT, map) &&
 	    !test_bit(SCTP_CID_HEARTBEAT_ACK, map) &&
 	    sh->vtag != ct->proto.sctp.vtag[dir]) {
-		pr_debug("Verification tag check failed\n");
+		nf_ct_l4proto_log_invalid(skb, ct, state,
+					  "verification tag check failed %x vs %x for dir %d",
+					  sh->vtag, ct->proto.sctp.vtag[dir], dir);
 		goto out;
 	}
 
@@ -470,9 +455,10 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 
 		/* Invalid */
 		if (new_state == SCTP_CONNTRACK_MAX) {
-			pr_debug("nf_conntrack_sctp: Invalid dir=%i ctype=%u "
-				 "conntrack=%u\n",
-				 dir, sch->type, old_state);
+			nf_ct_l4proto_log_invalid(skb, ct, state,
+						  "Invalid, old_state %d, dir %d, type %d",
+						  old_state, dir, sch->type);
+
 			goto out_unlock;
 		}
 
-- 
2.53.0

