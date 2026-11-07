Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053060;
	b=AV/kf4U3ZjfxnBKdTh+DV/vFKv8PDYC8DmtGYBLzn/JpzVgPATmG+HUi70oIa8PZgP1e
	 Ba4GW7kQsDhwdRzIELAgwKpVuycB9aPRtRPCtIUDHcuwNc5EPoZ9pqYg4eeqEOUKNEPD7
	 RlhJdSmLFNQdTw3N2vqQcN4TGqQEF1+p9k7UpezL0zGK02ee3+21ZQ14ALA5jFcC6eobL
	 PuyyF2z8M6rafxhWW/R2zgQKsKPIWE6Xc9247EYJtqv5auLf4Nnt2pAYhtp7FkTcA9IsU
	 VFRpSgGTsJKuN1715JAU/meXgcLX+NVK0Gbta+25eHqyxvS50Od0OywsJFj6tVDvLUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0wEPOPRkzmcCVluHi7awEBcRiIpVo6w+uyJsThFok18=;
	b=t91byCc9qzh9YJIPzJUWmIOnVBsyXThW/r9zDmKcd+/QYLt7SZGUyFHwIb1dRnVzHH4E
	 9SFrIBDWxbmmunPMOrCH5er4zT/YG4wDxhH5gNFLdPSJ7HGLiVZmY0DcLfMboIhsjebnL
	 vOXv1T+Q+7sGHE6XaNdWohLaDM7fSEHbsDBaGWoWSZAomiOlenlJn/BLKfLNnaJu8A83h
	 5ZOmhfBAR4aHAOwkW1AO7fj4ouDjNdw2pLt4CHwtP1Y4mGBXgUSNvT+pdaTa4kPYMi2No
	 uX8K8zso2ciZFZRKtV9Vo3OBpD0/CI5DGW5FbbemsT4rCxvjdEDRk4qXzQCJBhz8FtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmftnUCu;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F61606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F61606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmftnUCu
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so721713a12.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 04:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053058; x=1794657858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0wEPOPRkzmcCVluHi7awEBcRiIpVo6w+uyJsThFok18=;
        b=XmftnUCuM3ejrgBzOC0vQZVP2FAU6H4KefgwOeeWd7dwI6MBhxBKVnKm/Xh726AZ7R
         e+ARdbzecb6d10m77ndqLpuZnmNkdwkDRqTwog07wQj9abtmqFXQrEIFpMUglcGBSuid
         xX09WxoFtAwlrqABREk7yLdGGCCuS0YZx3WfTOWd7vCLRx4xB4IcpnTUsL/wILhJTEIA
         JAqHglKaNg/VpmJBvhYYmNuX2QfftTHmvX9X1Dsq/yvIZJGKM7DAZYDyu9mpqaKMwxj8
         ot615bqxc04N8y+mDMi8JVle6OrmsAGHeyHVJUA+y6JnCBHny5YChIjTnAoHeE31ruXi
         ofGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053058; x=1794657858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0wEPOPRkzmcCVluHi7awEBcRiIpVo6w+uyJsThFok18=;
        b=CnbQB96c8F0pi/oPkaTFxeYm7jTr9v8EZRCst9okNz3iAdBc4u+G6y9M0QPUxgrgli
         y4om5DPnCssJ6feZmvq/3S5c2gCAMwt9nV4Yk8KZiZJN9k2RPAui2oWNJ3bGl54HpPoj
         zjtSs7Hq1OH51f71eQ9CJ6JP6L0Ygl0WLbK3aycNlS1KR9m/mr1TUQfQXOjzP2HJpDC4
         zwHAOK8tCEFgmGdlswf7NUO0zBNYva3slVCFhYHCx8FAwKzIG2CrznW8r4cXuw+5Gbyo
         XpRA6+Cd12mlPZFVdQ7jbUZ2UVZJ/irC2U1rMzbsWdyNIGIRch94G4hGpffGJmq7rpoh
         LATQ==
X-Gm-Message-State: APuU4Z8FdTINXwE9ULVfxVj5YSdttZh8dNsDoF1A1Omv1DwfImeUjSCp
	XRciObmK2eWbyfBI9g6haIFKwjkuDY5ndUCDIfE0lSqcoCqbLKsbPHKf2w8Xbg==
X-Gm-Gg: AYBFou3ihphzQZzDgKVtkh0sVt+N7bdMZf5PCms6Jfhaxkwp9VLQOFy4fYcXtZLc1a1
	s7Pzk50ngEbopfA/PAOBJL1ypUvxT3a3zO6lkGUKaI2+5pCt0dQZfNEQIXS0YyTspKiJ+ppp9Bt
	qBsWrx0hCDTporwTVNYugjQse3LseeX1M+y7xMLvJZFa95MVjyAD9+g4bThCg+ws66gzRkDRm74
	+BHHxmJ+7aeFnt55UYVE0O8MuVe3uaYBZH7xgrzjVk29UbR2WWHXRZLatrPjPpKBfqQMPl34zqU
	rYQVjBjBd7qlzcOG//gynaLs/Gru/tpjICtgQ0R/7hklwF0Mgxre5ItxXM1wjquAHbgq+gUhHQI
	oYerz/rhs5RhTYpr7dWbNlDkPKS6E9zPm4/XLn+c/oA7radJbgQucEzj1UzjYO5dzoFcwPQ9mmF
	emypJll0faKINKG86gB8DqNBYoWGVtVOk9B279m05LSm6qGmrT9CaIQCdA+EBlu8LDVr9nwZHOP
	F8QIOICVLyqWcvMMQp87XSpn0W42HBsE/CAFLnE5wXzji6Om2+sc0JhAyUbF4m+PK7tkODJ1cFH
	sn92ixKdsZFaKQ6YibnxYvxEH2IKZmtcfWvPOCiBvBrqt0AYN2q7RY7KvPPXFNnE
X-Received: by 2002:a05:6402:11cd:b0:6b5:76bb:4522 with SMTP id 4fb4d7f45d1cf-6b6fad28dfcmr1067709a12.2.1794053058446;
        Sat, 07 Nov 2026 04:04:18 -0800 (PST)
Received: from kali (83.11.29.10.ipv4.supernova.orange.pl. [83.11.29.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ad2901sm1807772a12.6.2026.11.07.04.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:04:17 -0800 (PST)
From: Kamil Sawicki <user148783812897@gmail.com>
To: stable@vger.kernel.org
Cc: willemb@google.com,
	kuniyu@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Subject: [PATCH 6.1.y] net: limit priority VLAN untag depth
Date: Sat,  7 Nov 2026 07:04:08 -0500
Message-ID: <20261107120408.29497-1-user148783812897@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055616-failed-6.1-d3ff07f5acc5@kernel.org>
References: <20261107055616-failed-6.1-d3ff07f5acc5@kernel.org>
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

[ Upstream commit d3ff07f5acc573e5f72bf1c581bae5d05191ba61 ]

The priority VLAN receive path can repeatedly remove VID 0 tags and retry
packet processing. Unlike the read-only VLAN protocol parser, this path has
no limit on the number of nested tags it consumes.

Each skb_vlan_untag() advances skb->data and resets header offsets. The
offsets are stored in 16-bit fields. With enough nested tags, the network
or transport offset can wrap. A later protocol handler can then derive a
large pull length from the wrapped offsets and access memory outside the
skb allocation.

Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
Count the tag already stored in skb VLAN metadata as the first level, then
stop before untagging a ninth level. Keep the accounting inside this
uncommon branch so the regular VLAN receive path is unaffected.

A single VID 0 priority tag before a real VLAN tag is valid. No normal
deployment was found that intentionally emits multiple consecutive VID 0
tags; permitting eight levels is therefore conservative.

The issue was found while researching the Linux network receive path for
Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the analysis. The
affected path, reproducer and fix were manually reviewed and tested.

Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261024004835.17862-1-user148783812897@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 6.1.y: __netif_receive_skb_core() has no local
  drop_reason variable, and this branch does not define
  SKB_DROP_REASON_RECURSION_LIMIT. Omit the upstream assignment
  and keep the existing SKB_DROP_REASON_UNHANDLED_PROTO drop path. ]
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
---
Backport based on linux-6.1.y 08889840163ebcdb7e24bf7ec311bc2e6fc3aaea (Linux 6.1.191).
W=1 net/core/dev.o built without warnings. Full KASAN/ftrace
bzImage built with W=1 CONFIG_WERROR=; unrelated files emitted
pre-existing W=1 warnings.
Boundary test on two isolated KVM hosts: the eight-tag packet
was delivered and the nine-tag packet was dropped.
Original nested vhost/TAP trigger on each host: ftrace recorded
eight skb_vlan_untag() calls and zero tcp_v4_rcv() calls; no
KASAN report, oops or panic was observed.

 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7c0d0905dd31b0..4140ef78e56deb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5546,6 +5546,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+		unsigned int priority_tag_depth = 1;
+
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
@@ -5557,6 +5559,10 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 			 * 802.1Q or 802.1AD and vlan_do_receive() above could
 			 * not find vlan dev for vlan id 0.
 			 */
+			if (unlikely(priority_tag_depth >= VLAN_MAX_DEPTH))
+				goto drop;
+
+			priority_tag_depth++;
 			__vlan_hwaccel_clear_tag(skb);
 			skb = skb_vlan_untag(skb);
 			if (unlikely(!skb))
