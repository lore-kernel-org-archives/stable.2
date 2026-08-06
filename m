Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152AC424D57
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011168; cv=none; b=KvxoPYyMLEWwPTWzYgA4TeNALPh4Glhwx7VHz2tlQzG/oxN3g9qA8OyyOaDrPFrJRPUW2tkRYjUakTvjYqjfADyCVg+Yb0Wd/DQ3I29tTyl0Ht84bMSVcJdQQJITYAKz3VYexAplnfJJ34PsjD8lX1X0xLPhz2QeMfbStQ5npnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011168; c=relaxed/simple;
	bh=tJZkQVtwb2qjjFvyr3KVCnCJ7+UJG/qi4Xu2JXjyjgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eqrWnOUH2wZun3oY/eTi6yQiZEmnbjTNWcCh0h2fObYQOvx5XfJILj4DvU8aGystkih9MjeVS3de8/z1xKgQKpeT1dPfiDBT4Y6Ru5FdstLiPFVdZivwpBEdypDm6GS7O3YpiXKlfUr2o29yoLY2BC91J2dlArQvwRoAuAMAsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MREQxzRY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MREQxzRY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84847482584so581400b3a.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011166; x=1786615966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uyan3HYAysDdmSD1Jx4k3XmyCNsWmK9jFSOoc7MH43M=;
        b=MREQxzRY8v4WXkMZMbD1JzwklBY7hxvRGecGLm+nG654XrNM3nkoGtrxSbQQk/IhPR
         /pr1Up4S2UQ6p95kSGJD2+CnjlptWJRL1iFGVA5TB8uzYhdy6oTyxAjXwyCvxR//MqML
         EH+UdszWRAiXLzj0c/FjjQqpIpUqB3GRfYk4Rf6V9/k+ZPT2j7KIpqQLlpxeHucbBdvK
         ELryKOGM9JR9rOKgZ7/oEDmKMxhPDTCv79tOHv1JRRgNkBznSmPgINEfPlScINwf6eEF
         m9wz/7bxoDykhp4VERekbCaILosNeIfWzi8zs5trVNtH3jgWlFWGV4/8NyK1bDSRZRhV
         MBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011166; x=1786615966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uyan3HYAysDdmSD1Jx4k3XmyCNsWmK9jFSOoc7MH43M=;
        b=J/az7roKeC5LmkFp7WUF/EIi2jJ/C5moOO9dpyy5O/451aWMF/VDZkIKag5aBPsyUu
         WcTh6WdCguhe+PEIJOL0T/8+KOkg5aNnuNCdibpn5jkVS/OLI42Xhg/kSr38yJWPPeF/
         NTAXUJvtd5AgPruAyPUmfuaRLiO5PXwWtkT0KZJX7dLKS0U8j6KS9LrP6DMVz+etkrJa
         VoDJYiaQd/MeD1nkqrtc/dZie6zZsacMhM7y+TYSCgAm4C9hTiG1ucRw/ULwaqQ3b7uo
         QhT8AgkQjZt58LQeSWmy5m+xGbpYHz902B3Y3/VlGRzJcmMeXctJNqx3GL8GlJtSMymt
         SYTA==
X-Forwarded-Encrypted: i=1; AHgh+RpD1G3x8Emb4XIjcrAUjPluQsFPyTvkxH6xm/X7RCE5WW8wHx7pWRUDU4kJtvFGjhu9M8P2dyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtjVeu+ActTRyDd2flNeTviCEOc8UcNtD+iWI+CihtoFKrYKD
	e4Pd7ugL/wvakgcuw07I4CX7I8q3CO9VwW1qDArIXWZzHmzGjvAw1sJG3EiCoRc9EAU=
X-Gm-Gg: AR+sD13iWzYzcPVqi8LTS4xOCRuC/Is2VuX2y4Wjj+kmMlXCBXqOkrCrpJS3r5gYgcD
	f8aqIvY9SA+ejZ0ja/IYcio+pnswBH71KMBiczDwC+8QKnPH51F2rDj/vJQk7ntEtpnnPNVYXSy
	Bdzu7NKg4WcVfucSwiuEiSfSu3r7lvePdT8+tWOEszuFgeWE+mCB4+En+NeQoVa85DYCrISx6f2
	7YiIs0sj1G4PXjRQuOqRmAm11gHKE2ba/YZbxvook2MXO+LwqPrq46CvRmgJ057azlbiwSHag95
	cxE0n+jxHieBAPKglzh3cNdMuUaUfUEoEm/bVYYRpXTq0mx+Cb0B/0/k53fO/Bz6dcE9xHpccSY
	XQjJwrmrOHP6dECGqGGo4c/Phy/r1uks/MIi39iHeK1WNTh9/2Mj0MbE0iqmi3lRuGanF/39bJL
	YJ82im4FyNPoAbR53/GIfCDpkPaF0gl8s7jeWPy7P2wnS3PUbXZGbZjtQ9tDyoX7hszlLAPF+hn
	JoHUX7fx6Ue1vU9tNzcd+Rc0zuQFttUJFgPDmM=
X-Received: by 2002:a05:6a00:2e14:b0:842:446a:4cb5 with SMTP id d2e1a72fcca58-84f418a3e81mr6318346b3a.0.1786011166071;
        Thu, 06 Aug 2026 03:12:46 -0700 (PDT)
Received: from BOOK-P74QMIQ7E8.localdomain ([220.73.18.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc9cffsm1090371b3a.59.2026.08.06.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:12:45 -0700 (PDT)
From: Hyunjung Ko <hj351016@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tao Liu <taoliu828@163.com>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net/sched: act_ct: fix sk_buff leak when the header checks reject a packet
Date: Thu,  6 Aug 2026 19:12:34 +0900
Message-Id: <20260806101235.809370-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_ct_handle_fragments() runs its header sanity checks before handing
anything to the defragmentation engine:

	if (family == NFPROTO_IPV4)
		err = tcf_ct_ipv4_is_fragment(skb, &frag);
	else
		err = tcf_ct_ipv6_is_fragment(skb, &frag);
	if (err || !frag)
		return err;

tcf_ct_ipv4_is_fragment() returns -EINVAL or -ENOMEM;
tcf_ct_ipv6_is_fragment() adds -EPROTO when ipv6_find_hdr() fails. None of
them frees or queues the skb, so on that path the caller still owns it.

tcf_ct_act() however funnels every non-zero return into the
ownership-transfer exit:

	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag);
	if (err)
		goto out_frag;
	...
out_frag:
	if (err != -EINPROGRESS)
		tcf_action_inc_drop_qstats(&c->common);
	return TC_ACT_CONSUMED;

TC_ACT_CONSUMED means the action took ownership of the skb, so no caller
frees it - sch_handle_ingress(), sch_handle_egress() and
tcf_qevent_handle() all deliberately skip the free for that verdict. The
skb is therefore orphaned: one sk_buff plus its data buffer is leaked per
malformed packet, unbounded. Note the drop counter is already incremented
for these errors, so the statistics claim a drop that never happens.

Three different ownership states reach out_frag: today - the skb may be
queued by the defrag engine (-EINPROGRESS), already freed by
nf_ct_handle_fragments(), or still owned by us. Tell the caller which of
those it is, and free the packet ourselves in the last case, which
restores the TC_ACT_SHOT behaviour that predated the Fixes: commit.

Reproduced on v7.2-rc6 with a 54-byte frame carrying a 40-byte IPv6
header with nexthdr = 0 (hop-by-hop) and nothing after it, on a
clsact ingress chain with "action ct". kmemleak reports one leaked
232-byte skbuff_head_cache object plus its 704-byte data buffer per
packet; with this patch it reports none.

Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
Cc: stable@vger.kernel.org # v6.8+
Assisted-by: Anthropic-Claude-Code:Claude-Opus-5
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 net/sched/act_ct.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

v2:
 - add a tdc selftest (patch 2/2), as requested by Jamal
 - add Assisted-by: tag
 - no functional change to the fix itself
v1: https://lore.kernel.org/netdev/20260805095539.204356-1-hj351016@gmail.com/

Reproducer needs CONFIG_NET_ACT_CT, plus CONFIG_DEBUG_KMEMLEAK and
kmemleak=on to observe it:

  ip link add veth0 type veth peer name veth1
  ip link set veth0 up; ip link set veth1 up
  tc qdisc add dev veth0 clsact
  tc filter add dev veth0 ingress matchall action ct

then inject at veth1 a 54-byte frame: ethertype 0x86DD, a 40-byte IPv6
header with nexthdr = 0 (hop-by-hop) and nothing after it, so
ipv6_find_hdr() fails with -EBADMSG and tcf_ct_ipv6_is_fragment()
returns -EPROTO.

Before, one sk_buff plus its data buffer per packet:

  kmemleak: 50 new suspected memory leaks
  unreferenced object 0xffff888103ed13c0 (size 232):
    kmem_cache_alloc_node_noprof+0x2f1/0x3e0
    __alloc_skb+0xe5/0x860
    alloc_skb_with_frags+0x82/0x750
    sock_alloc_send_pskb+0x658/0x7e0
    packet_sendmsg+0x1833/0x4860
    __x64_sys_sendto+0xe0/0x1c0
    do_syscall_64+0x102/0x5a0

After: kmemleak reports no unreferenced objects.

Note /proc/slabinfo is not a usable check here on a KASAN build -
skbuff_head_cache active_objs still grows because the quarantine holds
the freed objects. kmemleak is the reliable signal.

Patch 2/2 turns the same case into a tdc test, using the clsact drop
counter as the discriminator: before the fix act_ct returns
TC_ACT_CONSUMED, so tc_run() never reaches its TC_ACT_SHOT arm and the
counter stays at zero while the skbs leak.

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index be535a261fa0..e250969c84ac 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -840,8 +840,15 @@ static int tcf_ct_ipv6_is_fragment(struct sk_buff *skb, bool *frag)
 	return 0;
 }
 
+/* On error, tells the caller whether it still owns @skb and must free it
+ * itself.  @skb is ours only when the header checks below reject the packet
+ * before it is handed to the defragmentation engine; once nf_ct_handle_
+ * fragments() has been called the skb is either queued (-EINPROGRESS) or has
+ * already been freed by it.
+ */
 static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
-				   u8 family, u16 zone, bool *defrag)
+				   u8 family, u16 zone, bool *defrag,
+				   bool *skb_is_ours)
 {
 	enum ip_conntrack_info ctinfo;
 	struct tc_skb_cb cb;
@@ -859,8 +866,12 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 		err = tcf_ct_ipv4_is_fragment(skb, &frag);
 	else
 		err = tcf_ct_ipv6_is_fragment(skb, &frag);
-	if (err || !frag)
+	if (err) {
+		*skb_is_ours = true;
 		return err;
+	}
+	if (!frag)
+		return 0;
 
 	cb = *tc_skb_cb(skb);
 	err = nf_ct_handle_fragments(net, skb, zone, family, &proto, &cb.mru);
@@ -977,6 +988,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
 	bool add_helper = false;
+	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
 	struct nf_conn *ct;
@@ -1012,9 +1024,18 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	 */
 	nh_ofs = skb_network_offset(skb);
 	skb_pull_rcsum(skb, nh_ofs);
-	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag);
-	if (err)
+	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag,
+				      &skb_is_ours);
+	if (err) {
+		/* The skb is still ours only when the header checks rejected
+		 * it; returning TC_ACT_CONSUMED for such a packet would leak
+		 * it, since no caller frees an skb it was told it no longer
+		 * owns.
+		 */
+		if (skb_is_ours)
+			goto drop;
 		goto out_frag;
+	}
 
 	err = nf_ct_skb_network_trim(skb, family);
 	if (err)
--
2.43.0
