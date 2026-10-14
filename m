Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEC3BCD3A
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951027; cv=none; b=A0sOQ+/SJOzJT13U7KZz3AfQb0mwBbbu5buzpBh5bfa/Jb+URF1CBq10VBGDPealPCCektBTlB3XKvh1yVmzS0Pc878WfW5lMSKCJH8kPWtxFcZeOgwXSgc3CtMdInXRM0i4uOcIsMZKWImK0vQCt7esIoR+3z62tA0d4yJwmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951027; c=relaxed/simple;
	bh=V4ngBpPUODuuWu2An2bhgPhwDi9OupCikjo5ZiTj6uY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cRz7pDFz+3E3V9X1Khedb7CC8UceGEHHRmZj9IH0W2ZpaqusYQC1/TKYVg+AwRf4hY6M2Db0wvOwwR2H5BR3zXYMZf4feNjvEkvNkO4ZIdW2F+sCMp7Q1M/0AbjSeCr8r+dcYpRwXdt2PUizrBj0DRht+vPRMRhkaHZ+Yrpai3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crh0/b6q; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crh0/b6q"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67989a98f8bso226651d50.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 21:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791951025; x=1792555825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ljQtddetZrnHdZkhpewiA0nv8+K0Dn1c6TsFqcV3Ues=;
        b=crh0/b6qeHxfbLpCS7mTQbEah3x1+AZmPE5EIHcMjrrHZ7tgdUI14W9aOugAZxzycw
         ohqQ3RhOypRFYyX84th92UAoznpNg7eXE40Ff9viYmYCQ/xagSMX3LD3jTEB+6vK/Myo
         savjdWLABbnm4y44VYj8ukZSOZo9+ifBtqgJYkvi7yots4Wg+W0VgbmOZ/rhEZnMCSoi
         ueY2Cr+oR72Pf/GBgTrBytPqL5uZaHI7p5E6/+EtbWNWiMoxM++YQabo7TmP4LXtW9qO
         0YIbr9wup7rLsRKaiu4dvE3LwsuErwwdqYXo1ktFjw+P72lhMbYAgKnJz+q52/jCPc0j
         G3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951025; x=1792555825;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljQtddetZrnHdZkhpewiA0nv8+K0Dn1c6TsFqcV3Ues=;
        b=rfF9+QPQ/JjsegtFgH15zQwizytJ/IB0l2n4IzqZ/56M+pLjWyemlLgyZcZrpp7WDN
         fE7vT0zsuhA+wMJa19KNt9DfAMW7gfihIuqQcR7lbTxlKJ2H4LucJL3aLX9JmL868Yes
         QuhWNr51w9RcAmadqJvweeu/la2JoPGDlzKSvsCX8enLdgPEixg+VyZmBdVf06D+KwwU
         OvQGMWbx1eK/A53JlkimFltjo0i5WA6ei/eS1AtN9qREWMbRjzHVpEJynr52O8pSNF3A
         sbjWBUVFvxBY/ZNfhxfNTzKuS7T7aEkx3Duykl1id0Oa6GNMRWGjeL2gUaCJwceYUR+U
         M0jw==
X-Forwarded-Encrypted: i=1; AKwUvBxvtlmS5A+woTHIB2IENydxg4W6cafO2R6o1Gz0SxL28eoDAqQKpFcrKfJKyTb7xyNTD9iTXeQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKQ3rcmeBDTDISPc65FDpmGl9p1rN5+8bjVhixHeiOI5fflPLU
	+bDhRjjGSgrJdprdjhnN8QDz8zbUOt31DiOCqcv+iFL0t+qWIhmjtX/x
X-Gm-Gg: AYBFou14uqf6FMXzqUSDVWDLKrRACRwXB+qufOTVBwQWgiaATnjChSuT/Q+xxM00ZYV
	azWn8L6wrbq/rGOuKOCFEOg0TMT8X9lqWIdkW+85W4nRsOgWHfmMeyKPXSQgRRDTN+2kdSwFW2q
	Xxc3w10ArYwI6z3EJH+tuh3MVUyCd4IqaFIkAvbINsNgxaCk9/YjdzD3lXb9lWiLF3bVUNaMqYz
	iHDz5nBQnlyNjoOhMg0QCLFQ3pCUvL7bgpvVJlIs4t6y689IH7AWykY5Fku5BCaVsQeWndB8dFd
	B2BCigT5nKtvTScz5WB198Cnh0FW2dFmbBB8I3Osj6YvnipwrR9Ul1uzOTmiYFo0yei2Mm2KgTD
	PQ3VaFpHA/hLA58SnPPKQ0uuRQO98rL37JvbdluaQYzyEDFf9El/J2BYhhlrTvQonnvK+7i4Azk
	cXCGFhFWqHmisraWNbnzBTse+qjN7o50u7fAorITIx4JTM2ZnOYmP1p8hUrt5msWvWrIQ8hH+rO
	tR1osH+ul813y7xv4T2QFSdqnbTu9+1em4lTU9GQAaVOwaAowrOgXAa0cgBHy4aqqEcZkIicFO7
	i4rdkrdinLWjoLAplHBuc2wDa3B4GSbgyJDsnA==
X-Received: by 2002:a05:690e:e8b:b0:675:4269:156b with SMTP id 956f58d0204a3-679369e3642mr4947534d50.59.1791951024885;
        Tue, 13 Oct 2026 21:10:24 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a16470sm592229d50.4.2026.10.13.21.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 21:10:24 -0700 (PDT)
Date: Wed, 14 Oct 2026 00:10:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 shiming.cheng@mediatek.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 nbd@nbd.name, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, 
 steffen.klassert@secunet.com
Message-ID: <willemdebruijn.kernel.26605ed441a3a@gmail.com>
In-Reply-To: <179161428655.434549.7066789783316941855@kernel.org>
References: <20261009060319.6229-1-shiming.cheng@mediatek.com>
 <179161428655.434549.7066789783316941855@kernel.org>
Subject: Re: [PATCH] net: tcp: fix fraglist GRO flushing on alternating TCP
 PSH flag
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 1 =C2=B7 Low: 0
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [High] Forwarded TCP FIN/PSH can be dropped from the wire when a
>   fraglist GRO skb falls back to tcp_gso_segment()/skb_segment().
> - [High] FIN/PSH in a fraglist tail segment is invisible to netfilter,
>   conntrack, flowtable, tc and BPF, which all read only the aggregate's=
=E2=80=A6
> - [Medium] The commit message calls the removed check 'redundant' and
>   only discusses PSH.
> =

> --
> =

> net: tcp: fix fraglist GRO flushing on alternating TCP PSH flag
> =

> This patch removes the unmasked TCP flag word comparison from the is_fl=
ist
> branch of tcp_gro_receive(). Segments whose PSH/FIN flags differ from t=
he
> held packet can then be appended to a fraglist GRO skb. The goal is to =
stop
> premature flushes when a sender alternates [ACK] and [PSH, ACK] segment=
s
> in forwarding and tethering setups.
> =

> > This redundant check causes premature flushing on any incoming PSH pa=
cket,
> > shattering aggregation and increasing softirq overhead.
> =

> [ ... ]
> =

> > a single fraglist, and are safely flushed together upon encountering =
the
> > PSH flag at `out_check_final`, preserving the required TCP push seman=
tics.
> =

> [Severity: Medium]
> Is the removed check really redundant? Commit 8d95dc474f85 ("net: add c=
ode
> for TCP fraglist GRO") added it to the is_flist branch on purpose.
>
> The general path can mask FIN|PSH out of its first comparison only beca=
use
> it later ORs those flags into the held packet's header:
> =

>     tcp_flag_word(th2) |=3D flags & (TCP_FLAG_FIN | TCP_FLAG_PSH);

Indeed. PSH bits are important information and are expected to close
a context.
 =

> The is_flist branch jumps to out_check_final before it reaches that lin=
e.
> So the unmasked comparison was what kept every fraglist member's flags
> identical to the head's.
> =

> The removal also relaxes FIN, not only PSH. Data-carrying FIN segments,=

> such as the last segment of a response, can now join a fraglist. The
> commit message doesn't mention this.
> =

> The claim that push semantics are preserved seems to hold only when the=

> skb goes through skb_segment_list(). Could the commit message describe =
the
> FIN change and the cases raised in the comments on the diff below?
> =

> > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > index e74d99ca9face..54b40ec95a080 100644
> > --- a/net/ipv4/tcp_offload.c
> > +++ b/net/ipv4/tcp_offload.c
> > @@ -328,7 +328,6 @@ struct sk_buff *tcp_gro_receive(struct list_head =
*head, struct sk_buff *skb,
> >  	flush |=3D skb_cmp_decrypted(p, skb);
> >  =

> >  	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
> > -		flush |=3D (__force int)(flags ^ tcp_flag_word(th2));
> =

> [Severity: High]
> Can this drop a forwarded FIN or PSH from the wire?
> =

> Without this check, skb_gro_receive_list() links an in-sequence [PSH, A=
CK]
> or [FIN, ACK] data segment into the held skb's frag_list. The is_flist
> branch then jumps to out_check_final. That skips the only place where
> FIN/PSH reach the head header:
> =

>     tcp_flag_word(th2) |=3D flags & (TCP_FLAG_FIN | TCP_FLAG_PSH);
> =

> tcp4_gro_complete() and tcp6_gro_complete() return early for is_flist.
> The head can't carry FIN/PSH itself, because out_check_final would have=

> flushed it. So the head header has neither flag, while the last frag_li=
st
> member has them.
> =

> tcp4_gso_segment() uses __tcp4_gso_segment_list() only when the geometr=
y
> still matches and SKB_GSO_DODGY is clear:
> =

>     if ((skb_pagelen(skb) - th->doff * 4 =3D=3D skb_shinfo(skb)->gso_si=
ze) &&
>         !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
>         return __tcp4_gso_segment_list(skb, features);
> =

> Otherwise it falls back to tcp_gso_segment()->skb_segment(). That path
> copies head_skb's headers, TCP flags included, into every segment.
> =

> tcp_gso_segment() then clears fin/psh on every segment except the last:=

> =

>     while (skb->next) {
>         th->fin =3D th->psh =3D 0;
> =

> The last segment keeps the head's flags, which never had FIN/PSH.
> tcp6_gso_segment() has the same fallback.
> =

> These can trigger the fallback on forwarded traffic:
> =

>   bpf_skb_proto_4_to_6() and bpf_skb_proto_6_to_4(), reached through
>   bpf_skb_change_proto() (for example CLAT/464xlat when tethering), set=

>   SKB_GSO_DODGY on GSO skbs.
> =

>   bpf_skb_net_grow() and bpf_skb_net_shrink() set SKB_GSO_DODGY.
>   bpf_skb_net_grow() can also linearize frag_list skbs when
>   BPF_F_ADJ_ROOM_FIXED_GSO is not set.
> =

>   Any pull or linearize that changes the geometry has the same effect,
>   for example skb_ensure_writable(skb, skb->len) in NAT mangling.
> =

> In those cases the receiver doesn't get the FIN until the sender
> retransmits it, and PSH is silently cleared.
> =

> A fraglist skb redirected to a local TCP socket after GRO (DNAT/TPROXY)=
 is
> also parsed from the head header only. TCP has nothing like UDP's
> local-delivery fraglist handling, so the FIN would be missed there too.=

> =

> ORing the tail's flags into th2 in the is_flist branch doesn't seem to =
fix
> this. skb_segment_list() emits the head skb with its own TCP header, so=
 the
> first segment would then carry a spurious FIN/PSH.
> =

> [Severity: High]
> Does this also hide the tail's FIN/PSH from netfilter, conntrack,
> flowtable, tc and BPF? All of these read only the aggregate's head head=
er
> before segmentation.
> =

> In conntrack, get_conntrack_index() only checks the head's tcph->fin, s=
o
> the FIN transition never fires. tcp_in_window() computes:
> =

>     end =3D segment_seq_plus_len(seq, skb->len, dataoff, tcph);
> =

> skb->len covers all of the fraglist payload. The +1 for FIN is missing,=

> because tcph is the head header. The peer's ACK of the FIN then hits:
> =

>     if (!before(sack, receiver->td_end + 1))
>         return nf_tcp_store_invalid(ct, sender, log, NFCT_TCP_INVALID,
>                                     NF_TCP_LOG_ACK_OVER, receiver->td_e=
nd + 1);
> =

> That ACK is classified invalid, and so are the peer's own FIN and the
> final ACK. A typical "ct state invalid drop" rule would then drop the
> teardown packets. Without such a rule, the entry stays ESTABLISHED inst=
ead
> of moving to FIN_WAIT/CLOSE_WAIT.
> =

> In the flowtable, nf_flow_state_check() reads fin/rst only from the hea=
d
> header, so NF_FLOW_CLOSING is never set for the offloaded flow.
> =

> tcp_mt() in xt_tcpudp and the nft tcp flags match also read only the he=
ad
> header, so a FORWARD rule that matches FIN or PSH won't fire.
> skb_segment_list() copies only the MAC header from the head and keeps e=
ach
> member's own TCP header. The FIN/PSH therefore still goes out on the wi=
re
> and bypasses that policy.
> =

> Before this patch, the unmasked comparison guaranteed that the head hea=
der
> described every member of the fraglist.
> =

> [ ... ]
> =

> -- =

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20261009060319.6229-1-shiming.cheng%40mediatek.com


