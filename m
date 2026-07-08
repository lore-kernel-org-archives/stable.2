Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3E3BB66B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534327; cv=none; b=Npt1azVGAjDBfkeZSQxeG9jBERH3ljSWF1cfOdcy68yOX+BQwY36Ch8v0hz0fXWrBgInqeNKQ5mLzaDJbtSwyA5tkqRB20RWZqEtzy4sXc83OOj+yjUNEoXyORoIHuvEyUGCql4x46OxeZgWo7Jh9nP30rLJ6YJqJjJHSryWlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534327; c=relaxed/simple;
	bh=l8GFelL0rMozLzXKhSXMvAK+Hz6wk24SoDq74J3vLDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lA/W2d9mYZPNoF9JQ5EO10c0id0rpzKMAZaHezSp96lr3erm8Q+06QS80z4XvHc2e/MJP79YAZfFyaNT4EK6KMO3BtoQ28bbbKyoA4H6+Z1AdfCOxEmGDRgGoS6I+R1VO/Jf4wqWWuqn6yw1nTOP+WYfI1BcUOSh3fiwh/HXEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VD+NNV33; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="VD+NNV33"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso1123968a91.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783534325; x=1784139125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0BR+SF/CxmhPdAIZMWxo2CbL+bjRHrbqDrG5ybWBgFU=;
        b=VD+NNV333+ei9F/wIwOZ098hJ5gmuDxdOhlEiQALpevUZ3bAMUAi5Dd9RevhLGFHlX
         N7unnAsINveskg1JFr2m5ZTbdGN8IUrRHxAZy4DL2x4aBwSCy3thSrAo44C6GfKt7AFj
         eLUS4yzK9rqOqDuIrWKk1+o2LQxFasmLTETvI2Y8z1cCehonnPmU13HYx6+zgz3omcrK
         kIgpTwTriCcx87F4ubwph0MXAPtAvxpSSd3WFVu2d1YwY8BD83omfu3qKhNZz3+mwtmT
         TKcH0ChVLZByeRQLe4q92ifSR26E4nO5eWLIGSOorAmzbrrXt+xDHWaLdW+whl5FWn/w
         zCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534325; x=1784139125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BR+SF/CxmhPdAIZMWxo2CbL+bjRHrbqDrG5ybWBgFU=;
        b=ae1sDivAL9wbxayUTwdPGAtnVyIJI/CHIQR2vxC7CmvNDQDZ6l7K2BFvZYJLkdRCAf
         v9FzjBvyHUmh0A0ExmRGdGGZP1J0ONjZexCsbUkZTGyw457A5vax0VwtQdpwvzfJlDTB
         QSXoMbD64yj75l7kOk35827a4tKcFyGzgRJFKaqYxSTYTV8+aC+p3xqJNBslAH5WC5MS
         EPavjNOQlJmkYolBYG6pvGrN3OFGAmbt54flQElLIyPp/x9C1KD9Nq5CCoZCfIZNyUYp
         QucDKmD5ruRSkPPKKxrtOr5k2XLUGfYucNk2AsDMYDuGYyyBMz8obS5em/7iYq/qJBSy
         WFqg==
X-Forwarded-Encrypted: i=1; AHgh+RpQdMK9Wo55xrdDrfwpR52EG807yP2eXlLy3VtCR/kTIvI0lEu0M5VLh/kDcBaSDPlFFV2HrME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kKmrH9GuQv4cgXvbBKg6UouK2bDujFXQ0xoYEDK4FDy3NzHY
	WqQGCteZAROPIEilMn0VAb2LxDenZppqVG+l5tE7r4/v6R0eyDMG6SKa/xKnltQnsw==
X-Gm-Gg: AfdE7cnF+EQTcwCf+vz6XqtLyTj4wg5++sky6NhG1DTbrWyDn/lh98kBMiKNLPL9kKi
	rOhWWXw4+WlFtYEkYw9CDv1KyBNwGzSRJqJqaAbfOF4DBsSTfLYZF4mMbCKW15CZNIVCtiYfuLN
	b8qqQhKWhOfgtjaZDgBR2rlSfqdcoWTcSaYN5tuF5RfWgimrKjzR4eXaX/msLLdKY6ykYolZ8Eh
	OSGOKd+3sjA+lWM2QlTgKoU6Shhfu9k4A8FyeeSyB5HwztvYESHoivOpSV47mwvtFvqXlNMJKTu
	2RkGNIQ5pxFxq6H4hpKabMUZb7HxuKVMqMsuxpxWI1RcDsRVvNuiuqtsQxeZfVMagnyR4U5yzkv
	5iM2jq4RsloxBt+a0o/hYDOtljmNKTpIPWlI6KboDk5hkcgGUNsIT3LrvuCFPI5Yaqv15e+/acy
	6UAqvaYCnLCn/TLWka9g==
X-Received: by 2002:a17:90a:c106:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-3893d33d9d4mr3982591a91.0.1783534324758;
        Wed, 08 Jul 2026 11:12:04 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm23336464eec.16.2026.07.08.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:12:04 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH net v2] netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()
Date: Wed,  8 Jul 2026 18:11:50 +0000
Message-ID: <20260708181150.3944015-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_ip6_fragment() gets prevhdr, a pointer into the skb head, from
ip6_find_1stfragopt(), then calls skb_checksum_help().  For a cloned skb
skb_checksum_help() reallocates the head via pskb_expand_head(), leaving
prevhdr dangling.  It is later dereferenced in ip6_frag_next(), causing a
use-after-free write.

Save prevhdr's offset before skb_checksum_help() and recompute it after,
like commit ef0efcd3bd3f ("ipv6: Fix dangling pointer when ipv6
fragment").

  BUG: KASAN: slab-use-after-free in ip6_frag_next (net/ipv6/ip6_output.c:857)
  Write of size 1 at addr ffff888013ff5016 by task exploit/141
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   ip6_frag_next (net/ipv6/ip6_output.c:857)
   br_ip6_fragment (net/ipv6/netfilter.c:212)
   nf_ct_bridge_post (net/bridge/netfilter/nf_conntrack_bridge.c:407)
   nf_hook_slow (net/netfilter/core.c:619)
   br_forward_finish (net/bridge/br_forward.c:66)
   __br_forward (net/bridge/br_forward.c:115)
   maybe_deliver (net/bridge/br_forward.c:191)
   br_flood (net/bridge/br_forward.c:245)
   br_handle_frame_finish (net/bridge/br_input.c:229)
   br_handle_frame (net/bridge/br_input.c:442)
   ...
   packet_sendmsg (net/packet/af_packet.c:3114)
   ...
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv6")
Cc: stable@vger.kernel.org
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv6/netfilter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 6d80f85e55fa..a7025ec87035 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -120,7 +120,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	ktime_t tstamp = skb->tstamp;
 	struct ip6_frag_state state;
 	u8 *prevhdr, nexthdr = 0;
-	unsigned int mtu, hlen;
+	unsigned int mtu, hlen, nexthdr_offset;
 	int hroom, err = 0;
 	__be32 frag_id;
 
@@ -129,6 +129,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		goto blackhole;
 	hlen = err;
 	nexthdr = *prevhdr;
+	nexthdr_offset = prevhdr - skb_network_header(skb);
 
 	mtu = skb->dev->mtu;
 	if (frag_max_size > mtu ||
@@ -147,6 +148,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	    (err = skb_checksum_help(skb)))
 		goto blackhole;
 
+	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(skb->dev);
 	if (skb_has_frag_list(skb)) {
 		unsigned int first_len = skb_pagelen(skb);
-- 
2.43.0

