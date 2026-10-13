Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9AC1A7264;
	Tue, 13 Oct 2026 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897073; cv=none; b=DNj0lzLEatERfP0OMNCi8KM4EmHjlUxqMvJ2zP8oanghUbkXfY/giWPMzUMMAf/4sjx/lQtfL+UgI+jfvR6chW7fXADNq3qsnzE86O17RaEK24RsJhKNGlWyasxyBiIl7K+bsAGMGP/A3IUoIlatsQohWU9ML7ZrRm8fsmShZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897073; c=relaxed/simple;
	bh=Fp34FYfTQc+YTGKGK6lC+tQUOsD84gcR8WE1MZCV/Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r+0d7wHS4ephoLATA2ulmTQ4fSkKetpYBA8SVVJUboLqCC2vm8Y5yx2FsZr6a/mv4eVaoufXoLDwpkMifZlmiia+dUJHkAZDa1sJGiAm7QL/X8XjX1EEG/sPpdsAP3UbZLCYJWJLbBAJprdC19WQLv6OOObMW9rbJLLBLrneA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=lf+pnWGm; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="lf+pnWGm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1791897064;
	bh=Fp34FYfTQc+YTGKGK6lC+tQUOsD84gcR8WE1MZCV/Mw=;
	h=From:To:Cc:Subject:Date:From;
	b=lf+pnWGmlEynW4sOeWDlcSnQWC01WGZgxN8e3CIF+168MqmblIN1yD7cnfCMRHbEb
	 WWfbLIQvuSY1jtaaDeWIHfNyE+IyQzVJ8kL5yx2vve+ZQ10+fU1fM1vLU07uetzKcb
	 hScSuztXKesZ/EM99dfuLa2iIhOoZ/khPc25+/JazboE5E//nIFKJEyNLc4aer8/nF
	 uN9sL8g5UFo8GT8qg8cH7jXoDpiu5y/PaOa6yPC/PmeFAe/88l5kiWUdFW3PJ7T50b
	 RCh/hk91k/zfVrKTLyalZWsYOhPNCg70jUqgRWw7Gho48MpcqnfjoHpZfyHsF5gtMh
	 RMzjg3GiTjZxg==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id BFFE625222;
	Tue, 13 Oct 2026 16:11:04 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 16:11:03 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.63.202])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j3vnM0xN9z19Bw;
	Tue, 13 Oct 2026 16:09:43 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Eric Dumazet <edumazet@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH 5.10] net/sched: sch_htb: limit htb_classify inner-class filter hops
Date: Tue, 13 Oct 2026 16:09:00 +0300
Message-ID: <20261013130903.1223-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/13 12:30:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;patch.msgid.link:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206634 [Oct 13 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/13 04:56:00 #28679670
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/13 12:30:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Jamal Hadi Salim <jhs@mojatatu.com>

commit 729c4896ab829169f95915d65edd530325910b37 upstream.

htb_classify() follows each filter-selected inner class by switching
to cl->filter_list, but never bounds the number of hops. A filter on
an inner class can point back to itself or to another inner class that
points back, creating an infinite loop in the packet classification
path with the qdisc lock held and BH disabled — a soft lockup / panic
from a single packet.

Bound the traversal with a hop counter and drop the packet with a
rate-limited warning once the bound is exceeded. The counter is
incremented at the point the inner filter chain is picked up, after the
TC_ACT_* switch has consumed the classifier verdict, so a terminal
TC_ACT_QUEUED/STOLEN/TRAP on the last permitted chain still sets *qerr
to __NET_XMIT_STOLEN and the packet is not charged as a drop by this
qdisc or its parent.

The bound is TC_HTB_MAXDEPTH, taken from HTB's own parameters rather than
from the qdisc hierarchy depth limit. Class levels run from 0 to
TC_HTB_MAXDEPTH - 1, so a traversal that strictly descends in level can
take at most TC_HTB_MAXDEPTH hops. That descent is what a sane
configuration does, but it is assumed here rather than enforced:
htb_find() resolves a classid against every class in the qdisc, so a
filter may equally select a sibling or an ancestor. The normal
root -> inner -> leaf path takes a single hop, so the bound does not
affect legitimate classification.

htb_classify() can now return NULL irrespective of CONFIG_NET_CLS_ACT,
whereas previously every NULL return sat inside that ifdef. The NULL
handler in htb_enqueue() therefore cannot stay conditional either, so
drop the ifdef around it. This matches hfsc_enqueue(), which has always
handled a NULL class unconditionally. Without it, a kernel built
without actions would dereference a NULL class instead of dropping.

Conditions to recreate the bug:
- CONFIG_NET_SCHED, CONFIG_NET_SCH_HTB, CONFIG_NET_CLS_U32,
  CONFIG_LOCKUP_DETECTOR.
- Create an HTB qdisc on a device (e.g. lo), add an inner class
  1:1 with a leaf child 1:10, install a root u32 filter selecting
  1:1, and an inner-class u32 filter on 1:1 also selecting 1:1.
- Send one packet (ping). On the unfixed kernel the classify loop
  spins with the qdisc lock held; with softlockup_panic=1 it panics.
- Reachable from unprivileged user via unshare -Urn (CAP_NET_ADMIN).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Vega <vega@nebusec.ai>
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260826143339.271935-1-victor@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-90053
 net/sched/sch_htb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 75ca5e5def3f..c6cdbbb8c898 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -213,6 +213,7 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 	struct htb_class *cl;
 	struct tcf_result res;
 	struct tcf_proto *tcf;
+	unsigned int hops = 0;
 	int result;
 
 	/* allow to select class by setting skb->priority to valid classid;
@@ -255,6 +256,10 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 		if (!cl->level)
 			return cl;	/* we hit leaf; return it */
 
+		if (++hops > TC_HTB_MAXDEPTH) {
+			pr_warn_ratelimited("htb: classify loop detected, dropping packet\n");
+			return NULL;
+		}
 		/* we have got inner class; apply inner filter chain */
 		tcf = rcu_dereference_bh(cl->filter_list);
 	}
@@ -596,13 +601,11 @@ static int htb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		} else {
 			return qdisc_drop(skb, sch, to_free);
 		}
-#ifdef CONFIG_NET_CLS_ACT
 	} else if (!cl) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
-#endif
 	} else if ((ret = qdisc_enqueue(skb, cl->leaf.q,
 					to_free)) != NET_XMIT_SUCCESS) {
 		if (net_xmit_drop_count(ret)) {
-- 
2.43.0

