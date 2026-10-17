Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C6382F1E
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253544; cv=pass; b=ZvymgrYvmzY6uzeJxU2QpWGR1laERjZ7aVg3L7EVMrMi+HwJBCVEqddHZFNqYKQTwrGpBEPg/PmznQ1vdEzOa1jEYarcyfzJm19fRz98rNK8WDKN+FsL+JVRDH7kONGI38C0Gpoo7EWQ/AQ7fZD5Tlpz6V8NTUIkMx07aB4eVpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253544; c=relaxed/simple;
	bh=7pglbWnVJ2gCeS6XwHlxA8hGdO8aKCHIzcG4HF4lU9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aADEs5QhG3BrBGE++Cocm251pH1N+qrqxLYfBwyPJof5Bl5afMprIn1Bp/FA2jBv6DvHYJZA4FtFh5JvOwcDeQxN3PnS4yxe84hdyjI5IviV+ryqktomo5vIfs1N2fmF/nn6HF+JnilFX0cKJfgWmgg2STen61QzvlvCnblLyXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=p09wXJtY; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=tb+FYyog; arc=pass smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="p09wXJtY";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="tb+FYyog"
Received: from pps.filterd (m0355791.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HFi3A63376060
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 12:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=x
	zfFmWAmfqzoRJKnG+bIesrRh2knKzr6XOi/3miEO+8=; b=p09wXJtYE3eQriU9g
	oWiR6bXlwyAXCOlOIP2c0IQ9EpaZrGatLmSApo4/qjSVBhxaZitNA7/Uj3XqDsEX
	iPYkfIFzdz4Z4sSb/lsvGmlDL3s+stI+OiO2gcV9yWyc16WpdpC0Bcx7q+DfDoHZ
	ryaa1TDTM7octpKtuifainPXpTGOD1ilU11+11HsHSVahLumHD24Id9r/60+YkU+
	aT1jlzK1oGPhz/2/4g2GoU92uRIE0OmqR2wWfaFjggqxcOzLLBZ2eTEiW1B0ID5m
	+GPtMs8Yw0uYO0yH9/4MbtNn1+6GIWqkNXLKJH7LQAc9665FArTgy7CPWDqa82Hp
	kOGvA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hc27hwbqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 12:12:13 -0400 (EDT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35a04491c56so1013180eec.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 09:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792253533; cv=none;
        d=google.com; s=arc-20260327;
        b=UZTBV3OKzIUDb7VKGA03gokjuGTP4/Fm5Pw6q+9VnCwbYc5GwQJdGX1k9AOB25mrL0
         2MFBo8wTYTfcgwbBHseTS8RxeOU0QkgLczrCLb45WT2uAwU0XofmL82mv7MRzK7SvBB1
         WRndX0CXV7HzNo2ytEeja60l0824E23ho3mLdFAk5zmqHP7F2iPWVPIEaK55+sQrfgxd
         m/cqJGaj8IRhA22GcxcX6DkMqcYO2UAYXUMcJ+qH47y2gFJMm0iU2xPbFu9FUzrNMuK8
         vF3deQS+qoznWVU9yko6NkFOaVbFx6zcg8axykIPBS56VBVD2QcWyhkzt0qN4ympdOq6
         lOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xzfFmWAmfqzoRJKnG+bIesrRh2knKzr6XOi/3miEO+8=;
        fh=scI3WU5T8aQIRAdMEWHs0Q22DN7Aoaafep6lNGU3Ojg=;
        b=NA8JPcS+qrBlCfhWo7reP1eyYbigFK5hlXTKWmUrDR0XnUtj4S7tgdLXMvTCLX5OAv
         0S5VrGpLDPkwtZRA+EWG0PoEFfULIHfJ4/mlTEtAs9ItJH/J4Une6xD0PqFQhpJP+F61
         koDuGaRx2/KurN1EJRYLJtlHlHFRHG4zkZ7B3F8CXf+SBgrvtFo4UScm6UaAV64W6Kcd
         +YN2BGPbWJKGshU88VVDX3tpjl7wxI1iO+Y72/vY7qbji1VmSNJ7oxgrW9xz5P6ludD/
         sv7g2INJcgXKkjQzoAy8v00N8Z4FrG+Xp0jQhkoqXAUJ+oDx6XQiGdXx2ByJZO1hmVDz
         8WRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792253533; x=1792858333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xzfFmWAmfqzoRJKnG+bIesrRh2knKzr6XOi/3miEO+8=;
        b=tb+FYyogCnMbQvGSEE2fdaC4LvJkUaEozYlWJgWM5OnMyX6dG/369960SaS6bdx2Ox
         WUn8FPw3Vg0ugeqhiKaIbiMId1WFCc4sn2SuETHvpeZwdqL41FNrnWVb8rrG9Zp18eDg
         5NBNssvUycm3NvGDMwJzPVM+51NGNLS4kNZLch0gZtwzcZBLOjcFtEk3N8ni0JPmugEl
         Zpl//RsbsLYmHI/GkWH3Dvx2h3KaYG8pS8wFRiiXmt1rv53T5p/FYVZUTSad6qNdxBWQ
         0mxpzFETHRqsyEmBjewk1be/Qaa4C9CNtG4FrwyVfUJ3QQW5sjz1ftc/anBrIA/31Uy1
         x1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253533; x=1792858333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xzfFmWAmfqzoRJKnG+bIesrRh2knKzr6XOi/3miEO+8=;
        b=amve7RlMWAxth2zvvfG/noa6Yo2ZY3IITXw5osPe4egN54H4Kg4FKhORDzei0jOWji
         j6nDviBzygiAZuvKdcL9axsRjfEpycXMt0IIlmHkk4KqFeqfDofC1qByvgfXjjhoNUTM
         zco/hQtxVpIM8qwGze857GSg0B6Hbcs0YAWYo0d01mKTiJOxYQW44xvx6Nnl6xRESlhN
         KB8HTA5TkFswU6zWM/EATOb0Icietu1aU9G+TZEO2ZgqPZPKBBotznkYxkgLgqU0Iuil
         HgSNrJOYPUVBQLOtCDqD5LNA+HUMoMS+TMMgzZYd51nMWLcRGla8CJm3bcvUB6x7uE0F
         1vgg==
X-Forwarded-Encrypted: i=1; AKwUvBwuUhfZMuV5FVbaFLKqUNnMcof9Iiq0p3dkUWd1hm/pM4R5S2lxg8fWqwSVJOV4XgKc4iuwsAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCUwMhwu0WqFiK3VRHVQ6oGkK5/qutOMzADtsHqyte140ceU45
	1R993I9LrmZNgD1fuUW3AgugvxiIq2Tiu0eIABTc4NxMrY+XWDHKkbvNO+/MAhO1+2697YW9Qbh
	iohAgoSa4jESy5WOmgnXe+CYiYDp/GEo8lDteY1Cf3kHGd65bq5NLTZwwm/Z3f90CI0BFST7FqA
	lARLCpdONcMembnHXTnFDmirjQRsXAGgAY09Df+N2o
X-Gm-Gg: AYBFou1zQUXVGFF7p99//hXxUcG09c4OdA1DBYM/acP9fJb8ON6+81N64mBcW7HCf0v
	g7ZfTayM0pcTiFssACLt2un06mmlxDqFchHQTpsnbFmKmv3EfFGjbaQDM8IDsWeeM/JCB+fBnOe
	2GSUXAjmKkHNrDFDBnHlMmF7kf4pK12+n2yWuX2HGFh/dK7hw1jegINDNl6w==
X-Received: by 2002:a05:693c:41c3:10b0:35c:3057:5ff2 with SMTP id 5a478bee46e88-3602d6e5cf7mr8854930eec.9.1792253532859;
        Sat, 17 Oct 2026 09:12:12 -0700 (PDT)
X-Received: by 2002:a05:693c:41c3:10b0:35c:3057:5ff2 with SMTP id
 5a478bee46e88-3602d6e5cf7mr8854887eec.9.1792253532245; Sat, 17 Oct 2026
 09:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014195640.430824-2-kj2864@nyu.edu> <atCf_85Ei_J9CDtd@kwain>
 <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com> <atHQupHr7_ocAJ_A@kwain>
In-Reply-To: <atHQupHr7_ocAJ_A@kwain>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Sat, 17 Oct 2026 12:12:00 -0400
X-Gm-Features: AclHuK8e-I7BBUngm7S9yxKRzmhND2BEBl1-b8tfPULLKfbhADm0CsNdN-K0XR0
Message-ID: <CAPqbLS0XXB53mnymFVZAVodc73r8E52PWRnxSwj6k8umqC7SAA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfXyqY6Ss6vYp5t
 ccOdmW/WeuSjbzViedbHPpJh7ItcychNhtMDrW6p042GsQltDGwyNfxq83jsA/B8df+KoT1UJZD
 toHWtdOQB0+lqRKzdN7BN1AMZCf4LjI=
X-Proofpoint-GUID: L8dFJtFn0BcXp-7KFRvs-qcd_6AT3J1n
X-Proofpoint-ORIG-GUID: L8dFJtFn0BcXp-7KFRvs-qcd_6AT3J1n
X-Authority-Analysis: v=2.4 cv=aMNlOr9m c=1 sm=1 tr=0 ts=6ad39e5d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=R6YzIN_bpWbBo3jmtC1i:22 a=VwQbUJbxAAAA:8
 a=MwDtoK921BBH29apYfYA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX0u7KpRc/M0Lw
 1NMNhLfBr2GhcwOhJS4sVSczlClP21Xwpq+7BSrZPyBQP296TNKQowNmkdjNill2XYq0ukqIsdB
 G5UdJgFJkNdrlIC5PbymvAQnLSHuOCw7EOkuY8qABjhAYrwfITz863K0uyJdQGTjMKqEK3iy1Ag
 6bHG0/VEQk4B20wFDTW0XwvUNoCJjY7zXt4iVzb2eZEBtlveFiQNXBSKhPoBX06++W8eEi87HbW
 XGJqNY+8V296PB5IVEz+mkK7uX5kj6K50nfdo+y3DwGJAabeS7is7LIaq3H8tajnq49FB/08uNe
 mIZnH84zdGQOws3iEMEcqiO6dwAEyAogBARD/0A/adbwqXAP/Gd65P1Z1wA+m8Lkd5h4DVyU8pF
 sm2ZOLcyK5f/UzWJ5psFD9cgrqECzarbKfBT4Y5F8Kj6gTm3R88x3ltqf8xTZYkLx63k22SsUDO
 cjfbsjeEL4YIYbGlU+A==
X-Orig-IP: 74.125.82.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170064

Afaik, I don't think any changes are necessary to tcp_snd_cwnd_set as
users are completely rejected from inputting 0, which could give the
assumption argument passed to tcp_snd_cwnd_set is a number larger than
0.


On Fri, Oct 16, 2026 at 3:29=E2=80=AFAM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> On Thu, Oct 15, 2026 at 12:57:51PM -0400, Jerry Jiang wrote:
> > I have considered rejecting 0 in tcp_snd_cwnd_set but afaik patching
> > tcp_snd_cwnd only would just ignore the problem. My current patch
> > should completely reject the user from creating a socket if 0 is
> > passed for RTAX_CWND.
>
> I'm not arguing against the current patch. My point is warning on 0
> values in tcp_snd_cwnd_set made sense before but since this is now known
> to cause oops there might be something better to do there.
>
> > On Thu, Oct 15, 2026 at 5:57=E2=80=AFAM Antoine Tenart <atenart@kernel.=
org> wrote:
> > >
> > > On Wed, Oct 14, 2026 at 03:56:41PM -0400, Kaho Jiang wrote:
> > > > User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> > > > This could lead to division of zero error if not checked properly.
> > > >
> > > > Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> > > > Call Trace:
> > > >  <IRQ>
> > > >  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
> > > >  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/i=
pv4/tcp_input.c:4440)
> > > >  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
> > > >  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> > > >  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> > > >  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1)=
)
> > > >  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1)=
)
> > > >  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/=
netfilter.h:319 net/ipv4/ip_input.c:262)
> > > >  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_inpu=
t.c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6)=
 ./include/li)
> > > >  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4=
))
> > > >  __netif_receive_skb (net/core/dev.c:6410)
> > > >  process_backlog (net/core/dev.c:6761)
> > > >  __napi_poll.constprop.0 (net/core/dev.c:7830)
> > > >  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
> > > >  handle_softirqs (kernel/softirq.c:645)
> > > >  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/s=
oftirq.c:758)
> > > >  irq_exit_rcu (kernel/softirq.c:775)
> > > >  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (dis=
criminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> > > > RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> > > >
> > > > Fix by checking if user pass in zero as parameter,
> > > > if so reject the value zero.
> > > >
> > > > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.=
")
> > >
> > > This looks like a refactoring commit only, 814d488c6126 might be more
> > > appropriate but please check.
> > >
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: co+71b6509cb791e531@bugs.sh
> > > > Assisted-by: LLM
> > > > Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> > > > ---
> > > >  net/ipv4/metrics.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > > > index ad40762a8b38..e83a129a25b6 100644
> > > > --- a/net/ipv4/metrics.c
> > > > +++ b/net/ipv4/metrics.c
> > > > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_=
mx,
> > > >                       NL_SET_ERR_MSG(extack, "Unknown flag set in f=
eature mask in metrics attribute");
> > > >                       return -EINVAL;
> > > >               }
> > > > +             if (type =3D=3D RTAX_CWND && val =3D=3D 0) {
> > > > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be gre=
ater than zero");
> > > > +                     return -EINVAL;
> > > > +             }
> > > >               metrics[type - 1] =3D val;
> > > >       }
> > >
> > > My understanding is tcp_snd_cwnd(tp) can return 0 and then the divide=
 by
> > > 0 occurs in tcp_cong_avoid_ai. Have you also considered updating
> > > tcp_snd_cwnd_set to not only warn about invalid values but also rejec=
t
> > > them, preventing similar oops?
