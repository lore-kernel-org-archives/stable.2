Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662603ACEF8
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769346; cv=none; b=QkaiA3UoUuF/b0SOKu9hlbe99GcfMvOovuEpcLVhkz+S09LDBtI/V00Nf1wWxdm6QBWw4U7p46eyPyFEIWSiNbR+tD0iuJCRCAn/l2feCo/Yo9a7Ad9QiJAQW6ucdRWqWhBZSoRqAH2Ua1wu+0IILUDd5A8ZUopIgdtB59zvGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769346; c=relaxed/simple;
	bh=BFWl428ntXrBei0RiqNWDXaOv2FBLg5fAlaE5qTw+/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufeBcJ8S0/3PljtovOG+ZglyFCBSWyexvFlNIAszBWaAk6zn6eMJD7avpm/gxLtMvSYxDk4PCa5ln/M0OC7OJZW1G+0/RBLFrrZ7Y7JPjzbkFd/GnI6fwRl2jKDtqE8TMWhpeQA5vtJmc/k70xb09Jgfh5kUjG8E9ZwIFZ3+ulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RPI4axgo; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RPI4axgo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769313;
	bh=P6RfweEM2bvOof007i1Gznpl5Sy/fqGKjvLvj1mLQgE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=RPI4axgo5/SwSCRkEdoCNPek+KWoe1AdCxe+IA6lnhQPfcE4/+lQwZeKlkTDjcPpG
	 QprHYLMXFSHw4036GROUNGvNIn17eOOpu6zZ76oGYxPEdphQXY+q646wJ6BiHz4LLp
	 ZIQ0fUjEU4f2MolDgmd8iBYR5fMphfuIC2wCW/M8=
X-QQ-mid: esmtpgz14t1781769293t24b0ed7d
X-QQ-Originating-IP: Ytf8qtNquFKOFjQMK0B1jilA+zzZjq5VNYxZplWFaZ8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:54:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14279584568306015866
EX-QQ-RecipientCnt: 19
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Max Tottenham <mtottenh@akamai.com>,
	Josh Hunt <johunt@akamai.com>,
	kernel test robot <lkp@intel.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.10.y v2 7/9] net/sched: act_pedit: Parse L3 Header for L4 offset
Date: Thu, 18 Jun 2026 15:53:48 +0800
Message-Id: <20260618075342.1599593-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618075342.1599593-1-guanwentao@uniontech.com>
References: <20260618075342.1599593-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OSwb8t2Gu9Ge0iHiTLCovm3Ymt10gXE/nE4PieU1N3jamY22jxpPhk/b
	QPChBA9OURLWcpUMtwqmZNMxidY6GUrOLzZRl3UjnSjJ9iy4axasz6VdK4Qr2nj6LDxBvlc
	h7nSAY99tAnDhlxVAxY6Ps8FignL6fslUflN5jNcCGFf7lHgLNjUZk6XylCfLVWYoO3v89Z
	OU6A84K5Agw8ZG3ZahASVcAbJM8/0W/COxTH5/wBui4BnYfYAeBL/SyJpc1K3PXuMmh2YmL
	RW13rO14SZMgpM5upBUIqoTBkrjblwIQTbBWPwyKdMolkZQMOlowzFAzDpaUjqdA8QKzdue
	LLW0KvywUcWFxFXe9oMUF21veR70NsLBZh2gVR6WB72wLOq+X0Oh7QAtXs9ygEYC7EzpHm3
	OTyIDbTj7jDG0l8fNsV34FZwq7K5mrCnwKMIr9LjYmT/huuSNj5tdvAT/iweq3v0uYKY8Gm
	eVL14s4jBB1tRIy5w04YKMnqqYFlAmjLNdG544ap12zreN3hyAdEgQ6clw+owZEC0kLOYVJ
	DISN/pav3/PzlbXQE3f4e9fbC0BWc16RsJyZaWTSdRgfmc07sWJLjTMPEEWAsC+1D3HbBGm
	NaMyPC/Qgac4MwA8mRXxn7GXpTW+3Al6I7F+3+bKlf2JUwAkbxfqyVRVBTF5MWGKZlECftO
	VwqsB9xtYrWz7Pgi8YKZCSMhssVtjwK/KPwcotM46XIdSOP1i6HHYqCaJ6hQZev3Wzq6jDe
	UNpX4oWwRsa+q4VoYk5mMaY9Mr6RPBTB9bqyJwkpp/Xvc0BQpXojwJOf5HSM79b8R7kDzA1
	nXqAJPtnoKbuIdth583hOKliSR4XFfjP1YR3z4Tjj7xaMEuhhH5ye9/KPhE3ma5UrDGJqbu
	1ZlaExF3FjKrcL1gnFrmVQUxylA/61luey8kVYjs531dyXpkrZ2ELrWCtogDtEErQCLzh/x
	xGP/c8pybC4/Por94a6r3Q8MeEt/gLHfGyL2kvSUBhj8ZoVDierdVkTxW6IIIkNVXKBK7U0
	ArTxvlzEo9qfAgGgIzxG4X02I1EADpMHEmOrX2HjlubLcKr0EbejfzGxVdUCX0EGzg8rCpO
	fi4UHpLA+V6UV3da+qGpK9ZycQWfemNiw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

