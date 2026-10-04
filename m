Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D84AA004
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791149087; cv=none; b=T5AoHWLM3UJdNWkVeY/6wn13YDJNWiks9da9TNu7ViCG8NYHlf3V4xbFF2ZCi2/ZWQ0Vs2TYrlZIPXzJlAW7kosWYL7ZIj/O3uE9jU13EJTAr0AQ+RAK8XAlg6I5YybD4zGz1Bl/HJA/F3mRr96K3joDX5q1Up4YneB9YPBieoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791149087; c=relaxed/simple;
	bh=9hCcjqOT46xAP7xaIdc0Z4fk9Wd1Z9HkTA12fTdiRn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAIt62bG0S8T5JPIRj+nAIP8O16am7Ymd/02qVgxGZqZJpVjSCEFU6of9ODtzUDl89b0WhXuP6GyKlEyhWANKLnVdYDapQdUcdjlPVcf384cNlzyy1DGqqHzmX+sjdiAhptjb5r+t6A8407y0uJ6TlAE5xx/VV89Xs8G6opPHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhxsxrQs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhxsxrQs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48bbb06e746so441365f8f.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791149083; x=1791753883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1iTQTid8V/cmqf8L65z4iELp7ouOSYsaWQ30R10Lt58=;
        b=BhxsxrQsyF4jlJd29+D9OP1vZV4eqt4xrC5NiT82mwg1NvMuLWC6eS0hVRDVaSEglJ
         QEHBHBiZMp5wkb8uFSPAFWvmp7sfGqX0TTkQZ4tet4NJwSbTLfTliPaELg6mi7P00ooZ
         j+oSddjMc89E99LIQ2Yw0iyS+rCPUEepVC6jz3p0BOdvP8LRsXdoNWyyxUURn01G11dp
         7QehuLQdK24uNWctiTSHCCjtO5VRheqjdgMVMdUp/ZKRCKOYRHd9FTCrx7YQV9pfiSO2
         odhSm1m00N8spa3Afz8vELj5O3f4+4cHXRQHv2fXG+iThZRzBzc7VUv7M92Trs/JdwNn
         Hs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791149083; x=1791753883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1iTQTid8V/cmqf8L65z4iELp7ouOSYsaWQ30R10Lt58=;
        b=XzO2H8FxayMUsP0XUvDwNSOJsTEIgOojDEN4ShrwyoIEDX7LfnphyHl7dCnLwOObyk
         +FMzyxrdVeLnSH5Bnf3syFatVYSWSJc7XkTI852DUyumXXezDD66uh/yQ6lL4kfzKnW0
         z7gfOk9sIk0QBBdtP5MAFKLyEybr9gKsTq8WOdmEa/zGr8Tvy1lDP5azIv7CTgcGORPj
         5bwR10/Fv/JGSWTwzxFgx/UAVJ8p9vFxg8wt0YxXjoRIrqDbOceZpEdAlGQ/biv4PalY
         iceV0E70b2ri3qsQQQrwon6mTuSIuWeOiFEvFbpJyj73ZyCCpnrtLSsvGf5QVOAyBjDI
         WT0w==
X-Forwarded-Encrypted: i=1; AKwUvBw2Sne4+YYpA5aPtvvORA3/61Ek2z/X81CWddlp4UgNoYuPJqwdfoH341vmCCCtEEGbreUyo5k=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9jwHLSsaYq0CJzHjoYmvgLxKBmXmJ+alOEVDzf15KRlRRrw/M
	D6ufuG8Nif+1WA0H8h+2QRG3NehNgZmJxSGpFK9C5IxnQNGIGlJ4uw28
X-Gm-Gg: AYBFou1PQJFVZ76tU1dQAU4ZwRLlKF3/bFawYzdeZ8xNw/ddYVLsQCnGdhLI9Pw7lp1
	L6cDX3D/OMUK2D6u0qJw6pN/WqzEJQ9u94qXYq3J3oOrq4SO28ctCB2XKCWWWMLpim2TodvIcG8
	7wpjVKgDiMnPZACwaMyjUtMHenA+k89OD0pgvww4dNs3y04SWOcX+dHcc/oBbtgihgEU8NHVSVu
	H51nmH+DVsZ/I4VH5GQmwFA/0YHAQtIGNWMec00H/AkVw3fK3zVwlhY39IsxwR1fuOkCmSuYuKV
	GzoDTubbN/tlHrPLO87JAic6k5lgZ1hGm23fMIYT4fxgq2pFGwAQ1iZavkq2t76+aarIJuCWOwG
	TexVMdacyitASUq8Q28CQAy1jMrcJmy8J3DHSoTRoAB6fXcZhJpJdVV9dLyhHwKYJT9+MBenVbR
	nEaJrWBxgr+ohLuUmSg7cVTt2hTYPYrojlftNR3W85wYoaMsqEemG+LyPlSIvqsshHinJj+P08x
	Hr7aVc/bvggmL2Jv1BXnMZtnGkig3WYjJiXQAvDzIERI9ai2w==
X-Received: by 2002:a05:6000:2912:b0:48b:ec8:b0d8 with SMTP id ffacd0b85a97d-48c47fe556dmr8699999f8f.32.1791149083490;
        Sun, 04 Oct 2026 14:24:43 -0700 (PDT)
Received: from andreayoga.localdomain ([195.122.200.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104417sm20407354f8f.27.2026.10.04.14.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:24:43 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bernhard Thaler <bernhard.thaler@wvnet.at>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH nf v2 2/2] netfilter: br_netfilter: clear stale VLAN tag on refragmented packets
Date: Sun,  4 Oct 2026 23:24:28 +0200
Message-ID: <20261004212429.3648-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004212429.3648-1-parri.andrea@gmail.com>
References: <20261004212429.3648-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bridged packets that conntrack reassembles and br_netfilter refragments
can leave a port that is an untagged member of their VLAN with all but
the first fragment still carrying the ingress VLAN tag.

With bridge-nf-filter-vlan-tagged enabled, conntrack defrag keeps the
original fragments on the frag_list of the reassembled skb, and each of
them keeps the tag it had on ingress. br_handle_vlan() only strips the
tag of the head skb. When that skb is not cloned, ip_do_fragment() and
ip6_fragment() send the frag_list skbs as the fragments, and
br_nf_push_frag_xmit() only ever sets a tag.

This was triggered with a reproducer that sends fragmented IPv4 and
IPv6 packets in VLAN 10 to a port that is untagged in VLAN 10, through
a static FDB entry. The first fragment of each packet left untagged and
the others left tagged:

  ... ethertype 802.1Q (0x8100), length 1514: vlan 10, p 0,
      ethertype IPv6 (0x86dd), fd00:10::1 > fd00:10::4:
      frag (1448|1448)

IPv6 became affected when commit efb6de9b4ba0 ("netfilter: bridge:
forward IPv6 fragmented packets") added IPv6 refragmentation.

IPv4 has been affected since commit 7885198861fc ("bridge: Implement
vlan ingress/egress policy with PVID.") made the bridge strip the tag on
untagged egress, when IPv4 defragmentation retained fragments on
frag_list. Commit 14fe22e33462 ("Revert "ipv4: use skb coalescing in
defragmentation"") later restored unconditional frag_list reuse.

Clear the tag when no tag was saved, as nf_ct_bridge_frag_restore()
does on the nf_conntrack_bridge path.

Fixes: efb6de9b4ba0 ("netfilter: bridge: forward IPv6 fragmented packets")
Fixes: 7885198861fc ("bridge: Implement vlan ingress/egress policy with PVID.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/bridge/br_netfilter_hooks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index fe8d2910dae21..2519c3820fb00 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -795,8 +795,12 @@ static int br_nf_push_frag_xmit(struct net *net, struct sock *sk, struct sk_buff
 		return 0;
 	}
 
-	if (data->vlan_proto)
+	if (data->vlan_proto) {
 		__vlan_hwaccel_put_tag(skb, data->vlan_proto, data->vlan_tci);
+	} else if (skb_vlan_tag_present(skb)) {
+		/* Fragments reused from frag_list keep their ingress tag. */
+		__vlan_hwaccel_clear_tag(skb);
+	}
 
 	skb_copy_to_linear_data_offset(skb, -data->size, data->mac, data->size);
 	__skb_push(skb, data->encap_size);
-- 
2.53.0

