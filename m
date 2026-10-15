Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE95519BD
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.150.240
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083502; cv=pass; b=oIjNRCYZvmQCOGSVUBkYoYyh9oP8c7w+wWwoK1APQgzBuMdmHB8BCT5QueoSPThFcmFmXi3lu/W7SFbGvmJtNAt5bG2yiooUUiEe13rhXfnRUZwHTgrOdJYjTdR914wFC7yruRJr+R/aLZ6KJPaGtJFqmWBVIiZCE2f3uHP+5/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083502; c=relaxed/simple;
	bh=5SvIsi7SBbQT+gfq4uEUynEUgBhqEiqCCRbjzgQhmF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq0J3Jr4s39GGoGaMrFJsqx/J5kQgLZrP5BUCzkW9lzmWdjOb3F9PESxHjHZVjtG2ujDWDWO+Mi4HmXQRnAb8F1x1P2lhq2ANFkBnUKGJcGwjP4lMeeg7LgJDs0ZbGxlKwXuAnAk/nl9vgPnC70x5eqAn77/ntOhOHwl68OSX8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=TbCtNgZ5; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=bBmUaKBv; arc=pass smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="TbCtNgZ5";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="bBmUaKBv"
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FGBkOK996445
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=E
	WnJ+H2sZYoV2Jv8w7ejHJBb3pXYIPz2WtL3bUBFqA0=; b=TbCtNgZ5pqfGfWlB2
	tTsfdWcTYueTaUtyJr+orPiDsvFGfaS69yMaAWatqFLx2NtKrF6Zu13UJ01cq7Xn
	V3+H2PDs9qAVotq9eL2qLCx9fJ1HScrXh9f5EkfjMkjwQ2mRGzTJsVQSwV2bvykH
	Yc28NcSRAYqM/ZhW2nF1yxIpjIAAGrsQmClK1Hp1lSjbo5e3Wf2mW6OL1jEVyL6k
	2YZWh5Y1bXRyLRc6YMfhtxepxtA9lWLuPqc5ONgY5JlN0/9hhyGzJaCOW6mAsFHF
	EfJ/FFUm+0DmLQnnDmL8FFPT/uhn1xhmF3AwpWVrTM9p8qnCIVlj4h3JSsbGoRuo
	CPwsQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hayeqcyde-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:58:05 -0400 (EDT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso11114449eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792083485; cv=none;
        d=google.com; s=arc-20260327;
        b=FFwB0tNU2+UZJbVeOLGVXZsx4jb3XvEK6dSBKItTMEa4/lYfeqvvXw4HZseqtyq3v+
         D08ZTpJa1KSi1co8J6rGjydBILOWcB20hVdp1jjfcsxwfmDhim44xiEEeojOjV9gNTfz
         b7ZcmZSLf+Z/S7VFxcApG7Snqceg5fw1IiHoQbfu+VN3hsVcMxJin9msc3XKzNZjcic8
         aa5qIa1IYe/h+luRxcOQocCr1dF4rfrLX6nLSyiViOxVudrqb2u1GNo4Vp2bhIWYvQg/
         fqqIV/+c534Qb4aUDEpNx0+Eb3At1y2gI4sQIN0/2iJ/LNcuJKc2zrDHyEUG6fo/7azP
         jgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EWnJ+H2sZYoV2Jv8w7ejHJBb3pXYIPz2WtL3bUBFqA0=;
        fh=M2saqNEtsEz9udePt/7LY0orCni9yChyy2b7jUeiuE4=;
        b=Q5jDioT9YldSr9eI6y24ODRlAlaevyqPlD4N3VAmfXEDtLWDWiCoORTa6fhHmqtDdS
         +BTrtxpckKJTiQRiIUj0ig/uZZyQZX8ItC7ebptTKEE+1e1/429jRH0w7+2ORE8jYKpF
         22R3Sk1bUpNiq8ovZ7wkHM4hpmiFarQ7m35Qz+EqeokoczCa8yBTtb3lcvI3hwBQvLCw
         Mv8o0nvz2y640jUyysawPDy6bAfEgKhLgw3i61gDS/rAIR3tOAoas1og0GccYcTyGlPo
         WB3lmp4efcEAVtLeUnmzOFfkMvahRtVaWIMmrVPTMH4xqp9uqZWrti5AdX084qhUlw3O
         uVgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792083485; x=1792688285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EWnJ+H2sZYoV2Jv8w7ejHJBb3pXYIPz2WtL3bUBFqA0=;
        b=bBmUaKBvnlJX02vrsVg2r6HZCYmvG04U7c3pBVLhhsVpx5a5hhvevfTvwMM0AwqK6i
         TdKh63hypbN/DA7c8gSh8dXKFpZX5k9kgxy2MceToRIyf04p2iSzlos2BKa3ttUBZnFt
         wJhaFyIa3FEijd2BJTs7spKJmfznPWJ2Gbwg+40O+w1Qd4cEhjkaTEp6C6o4ur0+2cW6
         2tSjyZHIPrfyrCDBIefsGcZ+sSEnHMWRdbfifiwGxWPsX2x9yPLDcXODFYoEio+jerkv
         qe6+pd47PZkeuO11i2EAWy5hKEH6sx4GueLZ8ke2ggSocfdMcyAxhAI+pY6NGDefoGCr
         i4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083485; x=1792688285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWnJ+H2sZYoV2Jv8w7ejHJBb3pXYIPz2WtL3bUBFqA0=;
        b=vHWBY121hf70Bi3TQYewQapN8JBEYtr6vTW71+ZqMWRPQj1GYlZLEqNz2e6vHIbsag
         n1PCL6XKBLpFnGc0e6uBwgGtTchpHqVzpCsWiGX9C5DDdi/xLmsJCI4jCUCP37a8QX6V
         7IiHxPhN323RBiuQo3x2PVR2MGd3LuRLALhWpOtmpZ/ZYvRRC6/bDuOe/7o1q5FxUoUd
         mONbV7jQd83VpPtexf2UZm0TWOabOpl0riH/If665YBKsvA0JvpKxDUxTGX8RGZnUiIe
         Ka6pDBgLlpMGaE8LNQK1y+ocz+kmtaNNy0AeHGW9KQgZzCdmPpQxKoZRWOG3jM0jgXCs
         2wEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKo9xx1YG2F9JX7dcv/kVkUfg8zasa/C+XDFiS5ugnx+me8OSf01hRwNSLOX7j3JryDPeY/ZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1U3lK0+fEF2mX5zHa9XLpgHwl+ybNfNA8DspmabTGTgnUCgXn
	qkvZMx4GOcIlr7CI1bz3dtI/PqiFA+wdbpFpqRc5bwwvv/CuDFoOXJHKRB+fgRWG8CjCsm4kJnt
	AABJSaGKtvrozCf2Hv1Qfyh+PMdw3vJ+uiU04tsu3XTH8zhtVqOEE6GmLTeGwNnNKsdlFzlP3bf
	A/mB3cKd3qBC9+4IvmcHHqxrk2teNwctvOt/SGiPvB
X-Gm-Gg: AYBFou1CLeOeCkRWPRhA2/BG8bj4cJmkTfIDZ2rX0EVFVW0+ZjhmM8+0k1/ZP5X53Xl
	gJ7TUJ5ZjOjkm+/f6AmSx2VHBNjJSh8wQ0jueIvW/578NrQupdK1nqDb260Cfhx4aQ94r+HQOe6
	z4ZA/yonuvsoOyBnEGm6fueCpCKPd+Xs06sLZ6FS1myh1o/KRbCkj0P5pOdw==
X-Received: by 2002:a05:693c:66ca:b0:35c:f667:8b9a with SMTP id 5a478bee46e88-35cf6678c8fmr10408715eec.6.1792083484510;
        Thu, 15 Oct 2026 09:58:04 -0700 (PDT)
X-Received: by 2002:a05:693c:66ca:b0:35c:f667:8b9a with SMTP id
 5a478bee46e88-35cf6678c8fmr10408674eec.6.1792083483848; Thu, 15 Oct 2026
 09:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014195640.430824-2-kj2864@nyu.edu> <atCf_85Ei_J9CDtd@kwain>
In-Reply-To: <atCf_85Ei_J9CDtd@kwain>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Thu, 15 Oct 2026 12:57:51 -0400
X-Gm-Features: AclHuK8axhoL9SJOQPtXMgXZpb7I487EoomfVtbK9W7aQp2W5VgW_o_At6K7uXg
Message-ID: <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: fJ1zyEuYmL-EwRMjjVjtR7EcaWu3eHOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NyBTYWx0ZWRfX63srBOezMnLa
 36ncuhXNX7U7kXm6b2wuSc/JlUlUAeipnEi7i4XCuc4SH3p+/xx5umVLHN95ce1aOLwfSoMBqsh
 dyLEWy/0tDqZ0e7jkeWZ1zMPPZv+dzAK9tQ+9pivl5Wa2mrQfLOPUPKBMcb4pxA28WoVBoILzd3
 2FIMy3BObpIw4fzufari0O+/898KfycNV1yVzqF4Z4GHqneYf4HLbYv1YBP6IxelGGUwiNfFMkr
 ydFfhRw0xoGfRvafBmMUke5e2YKBtd/dqKlu6xYZQUTMIQhyfIvS7X/awX1oRAkLQ9D5Pv++aHj
 TRb9QMzt9yTluEamHNLX9bOo81UL44sU5Pv/2P2C7R2m5cE0JXjdD4zjzsVaWpuw6WdmJ9HzJAv
 yqDLHr96mdLoegoj0G10rOhs3WRugXJ27kdpZaL9/VfzvfS3KafS+cvctUTCo9iAl2St5HmArFw
 kjmCZ5yHIY2610OgVhQ==
X-Authority-Analysis: v=2.4 cv=DvbDa2/+ c=1 sm=1 tr=0 ts=6ad1061d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=T67y4n-0JBmO_r8OIWtK:22 a=VwQbUJbxAAAA:8
 a=hKX_YmtgrgkOCiSBCTgA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: fJ1zyEuYmL-EwRMjjVjtR7EcaWu3eHOR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NyBTYWx0ZWRfX/1xCwntQVe6B
 +LguQjzHRbGnkngxYBcwxuc4yWgZJDF+TANAQ40UxsagoycEvU3Xo1aOAjLM8WWxmSzhrJVIxoj
 mQz3ihxuhS6XR3NBvZuo/cz/2uDPdWI=
X-Orig-IP: 74.125.82.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150067

I have considered rejecting 0 in tcp_snd_cwnd_set but afaik patching
tcp_snd_cwnd only would just ignore the problem. My current patch
should completely reject the user from creating a socket if 0 is
passed for RTAX_CWND.


On Thu, Oct 15, 2026 at 5:57=E2=80=AFAM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> On Wed, Oct 14, 2026 at 03:56:41PM -0400, Kaho Jiang wrote:
> > User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> > This could lead to division of zero error if not checked properly.
> >
> > Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> > Call Trace:
> >  <IRQ>
> >  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
> >  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/=
tcp_input.c:4440)
> >  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
> >  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> >  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> >  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
> >  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
> >  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netf=
ilter.h:319 net/ipv4/ip_input.c:262)
> >  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:=
492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./i=
nclude/li)
> >  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
> >  __netif_receive_skb (net/core/dev.c:6410)
> >  process_backlog (net/core/dev.c:6761)
> >  __napi_poll.constprop.0 (net/core/dev.c:7830)
> >  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
> >  handle_softirqs (kernel/softirq.c:645)
> >  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softi=
rq.c:758)
> >  irq_exit_rcu (kernel/softirq.c:775)
> >  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discrim=
inator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> > RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> >
> > Fix by checking if user pass in zero as parameter,
> > if so reject the value zero.
> >
> > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
>
> This looks like a refactoring commit only, 814d488c6126 might be more
> appropriate but please check.
>
> > Cc: stable@vger.kernel.org
> > Reported-by: co+71b6509cb791e531@bugs.sh
> > Assisted-by: LLM
> > Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> > ---
> >  net/ipv4/metrics.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > index ad40762a8b38..e83a129a25b6 100644
> > --- a/net/ipv4/metrics.c
> > +++ b/net/ipv4/metrics.c
> > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
> >                       NL_SET_ERR_MSG(extack, "Unknown flag set in featu=
re mask in metrics attribute");
> >                       return -EINVAL;
> >               }
> > +             if (type =3D=3D RTAX_CWND && val =3D=3D 0) {
> > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater=
 than zero");
> > +                     return -EINVAL;
> > +             }
> >               metrics[type - 1] =3D val;
> >       }
>
> My understanding is tcp_snd_cwnd(tp) can return 0 and then the divide by
> 0 occurs in tcp_cong_avoid_ai. Have you also considered updating
> tcp_snd_cwnd_set to not only warn about invalid values but also reject
> them, preventing similar oops?
