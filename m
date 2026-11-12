Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451890;
	b=OTamI6fnxvtTxO+x3rtcNEN8gNACrb/3TDcClUhjSnfwmmnFgX/IDLGa0bnrAjtANYE1
	 hDdYAnsTFsVY4QXPTt/VUm4WrvyMs3AsVAxQhDduqTJI35ts07wpONKBepAWdSngXcaU0
	 O2B636QLopv52wJJcO2XfvloZkEGJZVxE+RBBNSSmf3hGai8i4ypfjXwHnhQ4fdbqOTXe
	 nUFuqlCAknO8cJ7mIZtS1pIqx5GTYDQL/wTNZjlhLcURp0UJ78bYkJzr/UN178CcbHnLi
	 Fvh4mubbAiGSjusrhaH+RVEOxRzb4E2NVOuXoMLmcvZQ0vp02o/7d/EVfFUEJuBYBAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451890;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1bs7GAw2zMWUiQ4B+9AIpFbOZhlENJLuh1/oVgPJHnQ=;
	b=j0yiK92kRtbydFbjDYwUdK47uLSWqnol424igNuTvCQy/JOnQZgezCwtmJk1vXLW2O+7
	 NY7ggvqiYAbhrkL2eFx32CGOXpff9+FrfxnbT5/o66CXZNh5q2SRUkSIrgZBpIv8FNigh
	 o1oBawa06SigLG7KduZ/MtiwCxQ0MaEiLOxXT+mIq/Yvg5sDwxTPLX4YUlSBMhOQdA/E6
	 NDy+uOERYmWO0zDLQ0Wx5AOwUjK2PRZ41ag9t74wInNxZ+evksmV0Nltv2pWg8aoZ4/i9
	 qtkJmD1Cyml8t0JtyVDZq+UPsvtoZyMnoOZg9QdagHjWLoZy5an24DtyQv3rB7mkXAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVVPlONp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3E606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVVPlONp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ADE1F00A05;
	Thu, 12 Nov 2026 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451890;
	bh=1bs7GAw2zMWUiQ4B+9AIpFbOZhlENJLuh1/oVgPJHnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YVVPlONpDUG8XFQrQZV+t00SoeKSfkX1cfL9J2lygKd6JXBhiZ4gSlg9XtQGEV4pd
	 hWA+3Vq+C9sG98qWNUjAyNO+Md/QIcbytpypvh9udmm/pajVV8UNk7v5yNeOGx/vo0
	 2Ki1/SmmMLZPefnhaiIKnU/SQjMpK+ONoT3KyKIhp4t1ng2tUN68jmhLu1ZrT5if7E
	 DXbtLkHho5AA48bfCjTJr6N+d1+lxbE8ttueFIA0KNB5ebA8tasBo69rTgvDIx/Hnr
	 pchYtuFBiAToTnhbowpztzJ4LhA4SVIr5ucsPSAlrfAvOgtXl0O3GM9m5yOKrn/EMI
	 Q0x7C7potQblw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Date: Wed, 11 Nov 2026 21:51:27 -0500
Message-ID: <20261112025121.1435065-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201610-failed-6.1-1f1f8e8c5176@kernel.org>
References: <20261109201610-failed-6.1-1f1f8e8c5176@kernel.org>
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

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 89aa3619d141d6cfb6040a561aebb6d99d3e2285 ]

As the comment in this function says, the code currently just clears the
CIPSO part with IPOPT_NOP, rather than removing it completely and
trimming the packet. The other cipso_v4_*_delattr() functions, however,
do the proper removal and also calipso_skbuff_delattr() makes an effort
to remove the CALIPSO options instead of replacing them with padding.

Some routers treat IPv4 packets with anything (even NOPs) in the option
header as a special case and take them through a slower processing path.
Consequently, hardening guides such as STIG recommend to configure such
routers to drop packets with non-empty IP option headers [1][2]. Thus,
users might expect NetLabel to produce packets with minimal padding (or
at least with no padding when no actual options are present).

Implement the proper option removal to address this and to be closer to
what the peer functions do.

[1] https://www.stigviewer.com/stig/juniper_router_rtr/2019-09-27/finding/V-90937
[2] https://www.stigviewer.com/stig/cisco_ios_xe_router_rtr/2021-03-26/finding/V-217001

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1f1f8e8c5176 ("cipso: fix optlen corruption in cipso_v4_delopt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/cipso_ipv4.c | 79 +++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index fd139daf9dfb3..7229833d08612 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1813,6 +1813,29 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
 	return CIPSO_V4_HDR_LEN + ret_val;
 }
 
+static int cipso_v4_get_actual_opt_len(const unsigned char *data, int len)
+{
+	int iter = 0, optlen = 0;
+
+	/* determining the new total option length is tricky because of
+	 * the padding necessary, the only thing i can think to do at
+	 * this point is walk the options one-by-one, skipping the
+	 * padding at the end to determine the actual option size and
+	 * from there we can determine the new total option length
+	 */
+	while (iter < len) {
+		if (data[iter] == IPOPT_END) {
+			break;
+		} else if (data[iter] == IPOPT_NOP) {
+			iter++;
+		} else {
+			iter += data[iter + 1];
+			optlen = iter;
+		}
+	}
+	return optlen;
+}
+
 /**
  * cipso_v4_sock_setattr - Add a CIPSO option to a socket
  * @sk: the socket
@@ -1988,7 +2011,6 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		u8 cipso_len;
 		u8 cipso_off;
 		unsigned char *cipso_ptr;
-		int iter;
 		int optlen_new;
 
 		cipso_off = opt->opt.cipso - sizeof(struct iphdr);
@@ -2008,23 +2030,8 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		memmove(cipso_ptr, cipso_ptr + cipso_len,
 			opt->opt.optlen - cipso_off - cipso_len);
 
-		/* determining the new total option length is tricky because of
-		 * the padding necessary, the only thing i can think to do at
-		 * this point is walk the options one-by-one, skipping the
-		 * padding at the end to determine the actual option size and
-		 * from there we can determine the new total option length */
-		iter = 0;
-		optlen_new = 0;
-		while (iter < opt->opt.optlen) {
-			if (opt->opt.__data[iter] == IPOPT_END) {
-				break;
-			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
-				iter++;
-			} else {
-				iter += opt->opt.__data[iter + 1];
-				optlen_new = iter;
-			}
-		}
+		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
+							 opt->opt.optlen);
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
@@ -2244,7 +2251,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
  */
 int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 {
-	int ret_val;
+	int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_hdr_len,
+	    hdr_len_delta;
 	struct iphdr *iph;
 	struct ip_options *opt = &IPCB(skb)->opt;
 	unsigned char *cipso_ptr;
@@ -2257,16 +2265,37 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 	if (ret_val < 0)
 		return ret_val;
 
-	/* the easiest thing to do is just replace the cipso option with noop
-	 * options since we don't change the size of the packet, although we
-	 * still need to recalculate the checksum */
-
 	iph = ip_hdr(skb);
 	cipso_ptr = (unsigned char *)iph + opt->cipso;
-	memset(cipso_ptr, IPOPT_NOOP, cipso_ptr[1]);
+	cipso_len = cipso_ptr[1];
+
+	hdr_len_actual = sizeof(struct iphdr) +
+			 cipso_v4_get_actual_opt_len((unsigned char *)(iph + 1),
+						     opt->optlen);
+	new_hdr_len_actual = hdr_len_actual - cipso_len;
+	new_hdr_len = (new_hdr_len_actual + 3) & ~3;
+	hdr_len_delta = (iph->ihl << 2) - new_hdr_len;
+
+	/* 1. shift any options after CIPSO to the left */
+	memmove(cipso_ptr, cipso_ptr + cipso_len,
+		new_hdr_len_actual - opt->cipso);
+	/* 2. move the whole IP header to its new place */
+	memmove((unsigned char *)iph + hdr_len_delta, iph, new_hdr_len_actual);
+	/* 3. adjust the skb layout */
+	skb_pull(skb, hdr_len_delta);
+	skb_reset_network_header(skb);
+	iph = ip_hdr(skb);
+	/* 4. re-fill new padding with IPOPT_END (may now be longer) */
+	memset((unsigned char *)iph + new_hdr_len_actual, IPOPT_END,
+	       new_hdr_len - new_hdr_len_actual);
+
+	opt->optlen -= hdr_len_delta;
 	opt->cipso = 0;
 	opt->is_changed = 1;
-
+	if (hdr_len_delta != 0) {
+		iph->ihl = new_hdr_len >> 2;
+		iph_set_totlen(iph, skb->len);
+	}
 	ip_send_check(iph);
 
 	return 0;
-- 
2.53.0

