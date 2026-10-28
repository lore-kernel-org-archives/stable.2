Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179163;
	b=hWuwYM8vbXlCBtQV/9pdkoUrDCGXzpIjmbI7HcWd0GSWapFhkc6J9G3lXoa6R5A2vYdr
	 b5BqUmoJHXAmn/En/hpbobKNWCez7lcglU29vSU4JEIadOjiHYnP28dWNsdLiZiv4nb62
	 VrId5VaG8I0apIT0+AyB4E+z3IPsSifTtx0Mq7WoetOnoMiH3Gw/7JFyUYig0ZI7yk7bx
	 p064+r4k77r6bbJCMBCypddq5Nepb4xgxz4IoRGOuhd6zvR9MWm2jR1FRRDLADiDQ09Ai
	 9908EO5z2cE8CQ3KBhSkV0j6AqBLaJPU9hy/FMoe0dSQqDD7EMRxRgoNOSVtiBKJ3pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
	b=zrEMOlUGJNH8IQSkzWo7imLWacVKEkvzFZoe16EdWutIpZbejNrE9Xj7T37uPGoCY7xP
	 ebetJj9FD5sghqS8vme2lZixA0OTXbd2l4sjkjzB0uF/311pdkRPHYBSZ/ZilBmlhY959
	 uyq8blbBiRkoncLG6aXu4LFPGOY4Wi7gDXUr7B5SCC4R5Xpx9DvI5nD+EBHAcYkYqD/6R
	 XaxVTiHLM48slysvrQ5E3jgl5jikagD06VPKb1GP+pBtWs/r7UDYI3+WH82ghUg6KTJlp
	 TYy5jYsGKkSRAqYyOuzLDafF7ClaBLi/JzQP7j7yn4PGfwMqDg2QifSAv2kOO9FMYOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jEPXtPoY;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE52606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE52606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jEPXtPoY
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c79f306e9so8970576d6.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793179162; x=1793783962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
        b=jEPXtPoYHiaqzc8VKI6X2ReBPMPGM90QICrWEY1QCN7K/LrTc9Dj5NP7xx/fnkQ4TF
         96fP5MvhTbrzw+m7TP5vxPRvAiZokKRAfkJ03tmxYWhpkRhvkKvxKkLR63mZwY9jcYBr
         VKs2jQVv92sAEzf9fgoq0uEdelHI4THJJeNPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179162; x=1793783962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
        b=iOhOpaZDc5LgV7DlsTSBfZ7fqbv4NNYFWdvVLjI2cBJyHC5DuLJyaYVzTpCze0fcrj
         kVuPQj2MmPEw9laRQYhuqF8q3zuERHmHmqKUXkP912ciVLBYbqKHh34RExrV/p0jif2g
         WCIT2QuVeLIhMCRhpga52YTd0zws7xDawD2CfDkLgkeCFFfGUKpadi7lCR1NXinDFJhk
         WcJTxU4/ckssk7UfX4GTIek9uQKcvmV0i+mJewtbWpwZ43VlI/BLibrYdoJdIRw0wlgr
         RpypYJ1WuceyspTo4Dqb87LIDJmky+uxjb5+tvFijdiVz/RMK89Cj6kUjed4+YAVV4f1
         c0Eg==
X-Forwarded-Encrypted: i=1; AKwUvByLJgTXvHJgoR5VsTtwEMl//eLUAH3l2A7br4E39xxPWssOJ/CD8InQhZ+SZ+qK6wCakbSp2qI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbLpDped9+iIf/7q0tQwQlCjMI4FgY2LIJEBLASxP9TybXmb48
	I8yA/1cRg4XdLksnMlvazRFWm0ejDNLSjaknesmMR7Mdeuy1GB8a+5G9XW+pcgVE3A==
X-Gm-Gg: AYBFou3Uitlw8ANI5UOqbIpYfMM17w9Xwhchv0aNnnFfbxHq4kVCY3Dpl4he961kezz
	9Eww8PnOl+/M2QKanMAvWRxUZPaC70itH+OYWOfa3Mafj5b1V3UuNMqfS7KT9vsPYitAf7Asunp
	41XmF8kQI7A0ALBuCysgG0ecfc/kx/ijHaIItIoL3TxK/69uRmG/fGJuRFghe1KWYG2Q0xcro5J
	mSIgtMzD9WFLuvw4gnGtkJGcd84bhlrv0MjLK/YY9N9W5Ss5TAeoy9R1t+RcHxp3ckoPe5pC+em
	ljQIZUwvw8WPeNfCAvljg0bZEriGIZaxPj6y9XccpqgpPSu89zBo8luZ10jZk/P2r65jc7OKhkY
	ZHnzHmZ0Db3CIaakmtN0wSVgfS/5sepG6DwumhISdB4SjDfqTX1gPbZvOGVSghX9Fxp6a7oRtr0
	KQ0DQ6Kxw0OuuVFsInivPuHjfFOn1FWu35ZHoqwq0b4ftevTvHE7aAE7evoKmZ+S5xSZCQb5sD6
	wDZdRDEwSdE4z6wNd17mI+S10paXK8ZtNVtT1gLRYFiE7ZPNT/cV445lSueASCALOAL/VrWpCWt
	IRU2aNDb1YBVa5CEkjtW3vgv7htukoReFPZI0ldHqsSXNZdVbGudmrC6iCy4bWtLDDUXp164jQW
	NbbIBoXvTTeDSexU=
X-Received: by 2002:a05:6214:5c0a:b0:919:557c:f0a1 with SMTP id 6a1803df08f44-91c7d1a0992mr27886216d6.24.1793179161578;
        Wed, 28 Oct 2026 02:19:21 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c50e10sm126822716d6.25.2026.10.28.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:19:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Eric Dumazet <edumazet@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
Date: Wed, 28 Oct 2026 05:19:16 -0400
Message-Id: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

The issue:
This is a follow-up to the short link-layer header fixes[Link].  After
vlan pop_eth, a privileged SCHED_ACT BPF program can call
bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().

__bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
only that mac_header < network_header.  It does not check that the MAC
header is long enough or that it is linear.

A SCHED_ACT BPF program can do:

    bpf_skb_change_head(skb, 1, 0);
    bpf_redirect_neigh(lo, NULL, 0, 0);

after vlan pop_eth.  The skb then has mac_len == 1 and only one byte of
linear data; skb_pull(ETH_HLEN) trips the skb->len < skb->data_len BUG in
__skb_pull():

    kernel BUG at include/linux/skbuff.h:2839
    RIP: skb_pull+0xc5/0x100
    Call Trace: skb_do_redirect -> ...

The Fix:
Drop skbs whose MAC header is shorter than ETH_HLEN, and use
pskb_may_pull() to ensure the Ethernet header is linear before reading or
pulling it.  Re-read ethh after pskb_may_pull(), which may reallocate
skb->head.

Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/filter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..4d344ec09736 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
 {
-	struct ethhdr *ethh = eth_hdr(skb);
+	struct ethhdr *ethh;
 
 	if (unlikely(skb->mac_header >= skb->network_header))
 		goto out;
+	if (unlikely(skb->mac_len < ETH_HLEN ||
+		     !pskb_may_pull(skb, ETH_HLEN)))
+		goto out;
+	ethh = eth_hdr(skb);
 	bpf_push_mac_rcsum(skb);
 	if (is_multicast_ether_addr(ethh->h_dest))
 		goto out;
-- 
2.43.0

