Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466D3A8755
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497342; cv=none; b=p4lIUPKn+5PdrCieis9iRMAgjO2T4zRYQ15HKFoi7/3FuwR7vwBEJrhCSuwHBI8E3QQ+SyK4/49yKE6x7pz6nZJ57UEWtdiKntFk2Vl61UoBwSUlxjp5WHzwPisl/V22gfv1v59ejlsl3nnGk5QDzPjl1eAQAQVfm0PsTlCzB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497342; c=relaxed/simple;
	bh=BFWl428ntXrBei0RiqNWDXaOv2FBLg5fAlaE5qTw+/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bg7jFbrMl7EDVworW6PNRq8vuUN+KKkBbioymnW8K43JAg7pYQs+G14s6wkyqEuHKopnL0Dav3Vz7AwCQzoFXgNdvXOo92V+vEa67CismS3RmRon3VLY9eI/ULG60HbjIdcNQSJEYG3McJFXtvPEzlIBzuU+H2DAK8pb8bmp4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oU+xYCmw; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oU+xYCmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497306;
	bh=P6RfweEM2bvOof007i1Gznpl5Sy/fqGKjvLvj1mLQgE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oU+xYCmwclinL2+k+W0os9/RdXn/xgpBDzj3RuOpd0r4oA0f1QOJ6yS/nv+KqMgFo
	 GVylCmxxRLXJcc2rjsRjTDpDfIf9Zt1x8a8W199Gb+J91TI6QodRP9ecIsRv6s1UU5
	 6gLWIr3bn59k9zkMeA19bSqdE0C5QFK3+Oh7X340=
X-QQ-mid: zesmtpgz6t1782497300tb0865e15
X-QQ-Originating-IP: TYdpe/Dit5ORmQZ8x2+RB4bm9sub4cad7rQX5D7ImwM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:08:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10334551416734904696
EX-QQ-RecipientCnt: 20
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: 2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Max Tottenham <mtottenh@akamai.com>,
	Josh Hunt <johunt@akamai.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 5.10.y v3 07/10] net/sched: act_pedit: Parse L3 Header for L4 offset
Date: Sat, 27 Jun 2026 02:07:32 +0800
Message-Id: <20260626180735.297017-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626180735.297017-1-guanwentao@uniontech.com>
References: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
 <20260626180735.297017-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MoSajO47AaeeWA7HdJw9Zo3x9DqoAn9kAaOQXTETj94qGm2dc+J2N4DY
	tSVi879MasS+cbSyY7IhNEGfRr7htAXtSyCVK7ZfkNIVyrz0zWTZ3BSwxeVxPyWRsu+x+UO
	wDSHk2t87HwkyMRhQMRSZ+vqdDeFGoeTmK9yCJml9f4GtVvxpiu+3dvf36SedNqP1zN8umd
	ME3YGQ9Ha0btPrf8AFlNRLuyTr+/FDPfTRQJIw2Cr9q5DW/tZiHNzrSns0ezeUkAm/Tp4Wl
	MwrGqU0HJjPPvFEnWQUh1ha1iYqvG9SQkN1/s4YAhoHWjjkmMmLqFdLYXDuTC4Ljx9MfU5V
	aDC1Xo0c7/JC3C3g8D5027idPEiuL9T6CNqpWtXfBzbR+Xe8HJZiO/4oO19p2pKoyvMe0ob
	CQzLvfD7wuRYQgP9V3WM6mC5kFbTETYHvoB0WfqkUmOvuhufEu5fqKU4FiTdJwZDCZri2+M
	ZBlJCCXxoGo9PbIYAym1s0lst7vukJnQCyCf2rMhSczi0I3aBJIWLZr7OdIsNDUqBG8/WHl
	YWkGXXgWSGQ43w6NiQuuOgondKn5Y2V1EzpqcLzVIZIIR6iDS/p8MwzasEZ0kWlDGomOa7q
	KGEIGcU8n7hh61DrgnvSYr9X+mge8KfWwcHbVztg6vTGr6sCo/GRlcvd/d1IvwyMsj34g5V
	cs8GiUEjSEut+vnq1JOoiOG16hoYhPa0Hrf6ebigYjBo/UFPCJE5T7/N8WF8jnA98JlVxH2
	V2MYqW7SZWG1WgjKMEEyEoU7Mn+GiezQDrmuZegFRL8dLtN2SscyoIT8DsZi5MNLRrTLF01
	CkGw+IVasiYGMRzenSFWliG7maI4Q1Syk1RHDSo94WEcnG77a7HXFyK+yhXpxUPpkIEXCD+
	6Pqr3/8mwYH7V7yweLAmap7+iWgzRT0yWuUItN3P1H5OiQVM7AhqmMcojTXFm+XgUEDWnAl
	FLy8RqLprzSPOODO6KImO7dO1U2rMdxZ/FzZYAhfvlH32T+fS/TJzRw8ia1hHD9SOarQEju
	9xROJG9gEIFsdqQwR+BMXPPuzTt8QXzBVWMWwBQMLGBPc8jGDMJA/ro+FUDjH37OZgdJec+
	q01oQ5JOECxMjRc06iqP38sl5cfaNVGviyiKucBx1vX
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Max Tottenham <mtottenh@akamai.com>

[ Upstream commit 6c02568fd1ae53099b4ab86365c5be1ff15f586b ]

Instead of relying on skb->transport_header being set correctly, opt
instead to parse the L3 header length out of the L3 headers for both
IPv4/IPv6 when the Extended Layer Op for tcp/udp is used. This fixes a
bug if GRO is disabled, when GRO is disabled skb->transport_header is
set by __netif_receive_skb_core() to point to the L3 header, it's later
fixed by the upper protocol layers, but act_pedit will receive the SKB
before the fixups are completed. The existing behavior causes the
following to edit the L3 header if GRO is disabled instead of the UDP
header:

    tc filter add dev eth0 ingress protocol ip flower ip_proto udp \
 dst_ip 192.168.1.3 action pedit ex munge udp set dport 18053

Also re-introduce a rate-limited warning if we were unable to extract
the header offset when using the 'ex' interface.

Fixes: 71d0ed7079df ("net/act_pedit: Support using offset relative to
the conventional network headers")
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Reviewed-by: Josh Hunt <johunt@akamai.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305261541.N165u9TZ-lkp@intel.com/
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 6c02568fd1ae53099b4ab86365c5be1ff15f586b)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 48 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index ecad6fc39dc3d..df31b2b7b4225 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -13,7 +13,10 @@
 #include <linux/rtnetlink.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <linux/tc_act/tc_pedit.h>
@@ -313,28 +316,58 @@ static bool offset_valid(struct sk_buff *skb, int offset)
 	return true;
 }
 
-static void pedit_skb_hdr_offset(struct sk_buff *skb,
+static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int header_type)
+{
+	const int noff = skb_network_offset(skb);
+	int ret = -EINVAL;
+	struct iphdr _iph;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP): {
+		const struct iphdr *iph = skb_header_pointer(skb, noff, sizeof(_iph), &_iph);
+
+		if (!iph)
+			goto out;
+		*hoffset = noff + iph->ihl * 4;
+		ret = 0;
+		break;
+	}
+	case htons(ETH_P_IPV6):
+		ret = ipv6_find_hdr(skb, hoffset, header_type, NULL, NULL) == header_type ? 0 : -EINVAL;
+		break;
+	}
+out:
+	return ret;
+}
+
+static int pedit_skb_hdr_offset(struct sk_buff *skb,
 				 enum pedit_header_type htype, int *hoffset)
 {
+	int ret = -EINVAL;
 	/* 'htype' is validated in the netlink parsing */
 	switch (htype) {
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_ETH:
-		if (skb_mac_header_was_set(skb))
+		if (skb_mac_header_was_set(skb)) {
 			*hoffset = skb_mac_offset(skb);
+			ret = 0;
+		}
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_IP4:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_IP6:
 		*hoffset = skb_network_offset(skb);
+		ret = 0;
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_TCP:
+		ret = pedit_l4_skb_offset(skb, hoffset, IPPROTO_TCP);
+		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_UDP:
-		if (skb_transport_header_was_set(skb))
-			*hoffset = skb_transport_offset(skb);
+		ret = pedit_l4_skb_offset(skb, hoffset, IPPROTO_UDP);
 		break;
 	default:
 		break;
 	}
+	return ret;
 }
 
 static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
@@ -369,6 +402,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 		int hoffset = 0;
 		u32 *ptr, hdata;
 		u32 val;
+		int rc;
 
 		if (tkey_ex) {
 			htype = tkey_ex->htype;
@@ -377,7 +411,11 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			tkey_ex++;
 		}
 
-		pedit_skb_hdr_offset(skb, htype, &hoffset);
+		rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
+		if (rc) {
+			pr_info_ratelimited("tc action pedit unable to extract header offset for header type (0x%x)\n", htype);
+			goto bad;
+		}
 
 		if (tkey->offmask) {
 			u8 *d, _d;
-- 
2.30.2

