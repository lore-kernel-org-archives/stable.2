Received: from garuda.barc.gov.in (garuda.barc.gov.in [59.185.236.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938793BBA01
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.185.236.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136609; cv=none; b=pqR0wpMSY66AEED6yZAXAR5VPOF75UOOUo8KF3Qm2KFHTCKw+CZBfcS/Rs2wdzAPIfvugPjFdIn8NKc/iHd9w9maOZuq+bk5WPWpa7Rii016VR5s3A2d0UIhwLK8UOC8JUGbByPazByEOa6iYtKyUcyxU7nYwtL1PHQFOMizGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136609; c=relaxed/simple;
	bh=k+LW0VCv097wT1DDcBbdJP4hW+MwzaSqIlugtAQ44nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iu3esiID7urR5j4Iijh+zWIDkNL9oToOPDyPX/xtzsAayMXMWMR8cLiKkRYq4iY4pYqkumkzAONGx98IKowSJBYIeSYlRMa89hHCuVwp+RgvpNDd9H74QChhb8CKj3iCV/BusOQALAkIZELEZEfledWpG4EIAopdAJTOdj5qacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barc.gov.in; spf=pass smtp.mailfrom=barc.gov.in; dkim=pass (2048-bit key) header.d=barc.gov.in header.i=@barc.gov.in header.b=QCqJJCKJ; arc=none smtp.client-ip=59.185.236.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barc.gov.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barc.gov.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barc.gov.in header.i=@barc.gov.in header.b="QCqJJCKJ"
Received: by garuda.barc.gov.in (Postfix, from userid 1002)
	id 497C3EAE16; Wed, 23 Sep 2026 09:33:21 +0530 (IST)
X-SenderInBARCdomain: spam
From: Subham Pal <subhampal@barc.gov.in>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barc.gov.in;
	s=barct062026; t=1790136201;
	bh=40+xJXJ0IhkWrroGe/b++SiNvRR7JqabMSRC8RIniuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QCqJJCKJGoIYyivOX4n2mTLwPY+tbJjT4efVQdx4zJs2ZdmJ2mbSBMCamwwXO40xO
	 su9ksvBViEJw/VyPG2/sSZ0dQYKOMrj4hiCrrrn9wja2tvi+0nTKs1/uXT4sa7joAP
	 kzpWvoOGyqZdnF/PAvQEyKvILQSKo8mx89vutyj1QLWdWb9lhhlCi6zA575EUO0hVx
	 i9hhiasO62ZC1FGL5ohQzolib8A5zBVZSLQZcJLel7dkVITTS4dZqN3at6chxBHEZ4
	 o422G13PsN3FCBR7UMO/vBNqbDJ3ATfU/KsTlKzsMVG7QeLy4D2aKmTbVZ42C8cHRB
	 0UWs5OCBeMtjw==
To: subhampal@barc.gov.in
Cc: Subham Pal <subhampal789@gmail.com>, stable@vger.kernel.org
Subject: [PATCH net 1/2] netfilter: nf_conntrack_h323: do not bypass NAT helpers when tuple source matches reply destination
Date: Wed, 23 Sep 2026 09:33:12 +0530
Message-ID: <20260923040313.5921-2-subhampal@barc.gov.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923040313.5921-1-subhampal@barc.gov.in>
References: <20260923040313.5921-1-subhampal@barc.gov.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79
X-BARC-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 68N43F3t017364
X-BARC-MailScanner: Found to be clean
X-BARC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-99.01, required 6, BODY_RULE_1 1.00,
	USER_IN_WELCOMELIST -0.01, USER_IN_WHITELIST -100.00)
X-BARC-MailScanner-From: subhampal@barc.gov.in

From: Subham Pal <subhampal789@gmail.com>

The expectation helpers (expect_h245, expect_rtp_rtcp, expect_t120, and
expect_callforwarding) test whether NAT is required by comparing the
forward source IP against the reverse destination IP:

    memcmp(&ct->tuplehash[dir].tuple.src.u3,
           &ct->tuplehash[!dir].tuple.dst.u3,
           sizeof(ct->tuplehash[dir].tuple.src.u3))

This check is broken for multiple reasons:

1. It incorrectly evaluates to 0 in the reply direction
   (dir == IP_CT_DIR_REPLY) even under SNAT, because tuplehash[REPLY].src
   and tuplehash[ORIGINAL].dst both represent the remote peer's address.
2. In Destination NAT (DNAT) and hairpin setups, the sender's source IP
   is never modified, causing this check to evaluate to false even though
   NAT payload rewriting is necessary.

As a result, NAT payload mangling is bypassed, leaving internal addresses
untranslated inside the signaling packets and leading to call setup and
media stream failures.

Remove the redundant memcmp() checks across all four expectation helpers.
Verifying that nathook is present and that ct->status matches IPS_NAT_MASK
is sufficient to determine whether NAT handling should execute.

Fixes: f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
Cc: stable@vger.kernel.org
Signed-off-by: Subham Pal <subhampal789@gmail.com>
---
 net/netfilter/nf_conntrack_h323_main.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index 4cb1665bba02..0c2aa608ae60 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -250,12 +250,9 @@ static int expect_rtp_rtcp(struct sk_buff *skb, struct nf_conn *ct,
 			  IPPROTO_UDP, NULL, &rtcp_port);
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
-	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
-		   &ct->tuplehash[!dir].tuple.dst.u3,
-		   sizeof(ct->tuplehash[dir].tuple.src.u3)) &&
-		   nathook &&
-		   nf_ct_l3num(ct) == NFPROTO_IPV4 &&
-		   ct->status & IPS_NAT_MASK) {
+	if (nathook &&
+		nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+		ct->status & IPS_NAT_MASK) {
 		/* NAT needed */
 		ret = nathook->nat_rtp_rtcp(skb, ct, ctinfo, protoff, data, dataoff,
 					    taddr, port, rtp_port, rtp_exp, rtcp_exp);
@@ -310,10 +307,7 @@ static int expect_t120(struct sk_buff *skb,
 	exp->flags = NF_CT_EXPECT_PERMANENT;	/* Accept multiple channels */
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
-	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
-		   &ct->tuplehash[!dir].tuple.dst.u3,
-		   sizeof(ct->tuplehash[dir].tuple.src.u3)) &&
-	    nathook &&
+	if (nathook &&
 	    nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
 		/* NAT needed */
@@ -643,10 +637,7 @@ static int expect_h245(struct sk_buff *skb, struct nf_conn *ct,
 	rcu_assign_pointer(exp->assign_helper, nf_conntrack_helper_h245_ptr);
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
-	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
-		   &ct->tuplehash[!dir].tuple.dst.u3,
-		   sizeof(ct->tuplehash[dir].tuple.src.u3)) &&
-	    nathook &&
+	if (nathook &&
 	    nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
 		/* NAT needed */
@@ -770,10 +761,7 @@ static int expect_callforwarding(struct sk_buff *skb,
 	rcu_assign_pointer(exp->assign_helper, nf_conntrack_helper_q931_ptr[0]);
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
-	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
-		   &ct->tuplehash[!dir].tuple.dst.u3,
-		   sizeof(ct->tuplehash[dir].tuple.src.u3)) &&
-	    nathook &&
+	if (nathook &&
 	    nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
 		/* Need NAT */
-- 
2.43.0

