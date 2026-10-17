Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A8346FB3
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273944; cv=pass; b=F+LnfpcDUPdZzlT+d95B9RqVxpRgNosy7cQtA3h+om/ab9TRDu8TdjG5eICc1lT5g6zxnL/RSDViF3J0JcEe5ZUNcidkHKaX6dJ43Mugn31a6iNK/mkoh24XOpuj6Pcvc8ml3W0xM4witKKbOl2+5jglQTI3kubnuHt0nUthq2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273944; c=relaxed/simple;
	bh=2z49YO454x+6uu0rrqxdOYf2rOaScddUZyoqUeAIaBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuonIx9/RI4gXOfmINDkmkktP0VlPRozE1LJ3NE5/nIARCedCrQ4tpR6N0zUr2TGsQVrGBElbTypRjDmshRCTVWcoG2sqJSqfBJp4YK7DUy3vMpqdqQ2sIzSmDHl1qCSp0xuavQsm+DNFE+29yI2IAQ+z53tM9Sfyz/x0UPgtXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=k5GDwwz0; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=csRmr1rj; arc=pass smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="k5GDwwz0";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="csRmr1rj"
Received: from pps.filterd (m0562594.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HFiMAu2198655
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 21:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=s
	LoXZ4zrSuG0DF9gDAxCqxwkk2HrNuzfj+cEZxHtwEw=; b=k5GDwwz0SksfR0foN
	zeOQAVNr0qigINCmH47KF3LDZHH4QR+xJxgzSfVVnXFifJqBm+XL2MYTq4n4UYVC
	swm+bd+QBGfKF+TQSndFVcjnegFHXZeFp4+rtBHIod3ORqtbChfixDqUG3FH0rB7
	SslL5A7gY6L24mKyAeruDMtLc3Sk6yozF24+v8Gb7YY2lJcE94R/4XEDQhMBToIa
	Z9QF8YXt3a6yv6Pk0veNwzQ6BgmZYkA5KLxaDEWCchpSVwOr5iI5SSLKXxQatgMY
	V/e5paQHUhZtFUOYIsTrpW8ad46llDUePcIH8mu2+CRzPMny+Fjme4qkXvQlCEnX
	w3peQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hc9tecm38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 21:52:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2021587eec.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792273940; cv=none;
        d=google.com; s=arc-20260327;
        b=Jeh58181Svtg5yjuoz7C3HzeCn9x23oexZMSZ0eVdV5oXfDPpVde1DM29wECHi86b2
         AZ1prwYoydhxTzWcpyUxW58W/bmk9K8L6mdPgJ0naO24YXFmi/TWNNnz+IVeuo+y1l8m
         iHC1+whViKZWT4Q+E6Ti3forbnj3sYYYofA/57mH/eGJD9CnG+WZi9q2h+zrEhE/SXvo
         m2I0FO919XlbjdtF/HgIP5X4q2cTtVrk6qGjhGgwzF3Lo36yOyChWnF0kxZmjl7qOk4j
         oHLOjnTtcmHZp5LqivCCVBS5J8ZYPh7/DEH8JrqX+/GY8ivK/HamwPvqhOYfntiH1IcI
         x9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sLoXZ4zrSuG0DF9gDAxCqxwkk2HrNuzfj+cEZxHtwEw=;
        fh=55LrY0cnT4otHCO4Komm/9X9fmRSe0PB2Hq/ZtQD8dg=;
        b=U7Xk5a1AmS4GCGelh0c6NQ88KU1JfAwwXo3LkCKrZ6TbiEhPHcBMQ67v2ITaKdffo9
         jnh0JL8qVXRJLgj+Lr7atF8/p1osyjF2hIfGGxO56UR7cH2zGgz+6G4jmhLj5o8jw6oA
         KzXjHSMbK7ZSSjrWRmFbODqTJJDD9dbrqF1i4gsFvK0QZX6FsGWdxrFlOLeoOvNp3Cdx
         WDcQBtZyPQ5c3rKfb1witB+gEJjTuZZ4TQ2OhUmKDNhAtOqLMaC2Gqdk6rMdruiLNOvw
         D4gi7SZMhSG4OhkNlf4c1UlfWWWINJE7ovPNSal4q92MgvFfe5knacjlMyZgISQTboxy
         DJQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792273940; x=1792878740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sLoXZ4zrSuG0DF9gDAxCqxwkk2HrNuzfj+cEZxHtwEw=;
        b=csRmr1rjJfeLVFrvJPCxSndI+Be6ru8Hx1tEVI+GGUEL5RDHwLzRxaRnFa9dN1TznK
         wg+q406hIlWMm3EinPudV+XUUzYRSttB7+CfiTE85XNOXJKlQrN9ityO9WXi+3W98xz4
         T7FLPHerizTBw1zflkzn9KW70ncRn8WO9M2zkfk7xpuyBj8vrdXqraQDbEniYTJjeMWD
         Igg0qt12PLQ1OptXYuyLFN1WaDoLKdi74U9d3vRAJNJj6fPyU7bGT94dch2Fvc8x7r+M
         ec6k72+rZXIv8GSjeKB/P8rlnm72IuzvHzV2AjWwAHCHeIX2kh0cnwSaJ+amILMf0/do
         hMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273940; x=1792878740;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLoXZ4zrSuG0DF9gDAxCqxwkk2HrNuzfj+cEZxHtwEw=;
        b=1gZcwXlVrRbMvi7E5jLOOGLRBMNOV2LF64Trfz98z4pJIAWfljopFLypaxDLWzoDbe
         K7oJr5w6NxDJotfQRskOkH1+hRTdpk5TD6ACPlsyAsfZPTP5aZ58e+0OV9DuH22J5erR
         KU//nozrkr/ghe1zyoQY3kILRHypPjI7aXpwtj1/eo40/u6bnK/NICyYISz0SOKd403i
         RLxP5bSgcVmmKWWbfbGfTAoGI0eefs+94FgcLDvrk+mHi6wxYAtgN8Ts5ZE+y22tDsKx
         bebKXityuRm7CA1sNJJXCdAQo56AZA0Jew//mHB5hJGMpQkZMOMPAPlVSuB/lk3d3n6K
         GeXA==
X-Forwarded-Encrypted: i=1; AKwUvBywHSpd5UQVQ8CoXeWysr9ycplP6CrM+1iH58BgJ/POwyo7G6/RlQi5Z5qirP33fZ/ZVxJgZ0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwRzs6YoU1RiEiQBIJI6IDSI9fAya7s3cd2D/HigOzEc4ZCo6j
	Tgvb/fQ552bY/WnzV98FCGn8njEf79N5HvyjRHErm70If0q9tP8w/vjdX+3ScyhyZSNLm6IwEnd
	e64OyjvVGp6l9XSLEAuZqSGjdsMBXndgkLZwFwtNckTVT+JWBkjgmmvOUiNUnN35H6JO7ugNUTV
	d78KbfrKafe22aHmaUfb52VJdh8CpTIw==
X-Gm-Gg: AYBFou3H0orOFf8961wcDdaECAYIS7KNjRygHg05VKIoO0ZpVKb7IrM7tO4fdrXOO6u
	FtCkB1YUfID2yeXF5r8dA65c7KLIvUcQtx9C+JyOBZsdqcem43XTq2zW7FMT4niT8x4amnQFzxl
	VZOvm4kn8Izc4183WDEE5ckL33zow8ww5oOkBzJwybHnhftIbzNhheFon0+Q==
X-Received: by 2002:a05:693c:66c1:20b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-361a264acaemr5212450eec.38.1792273940373;
        Sat, 17 Oct 2026 14:52:20 -0700 (PDT)
X-Received: by 2002:a05:693c:66c1:20b0:35c:85fa:5a61 with SMTP id
 5a478bee46e88-361a264acaemr5212420eec.38.1792273939584; Sat, 17 Oct 2026
 14:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014195640.430824-2-kj2864@nyu.edu> <atCf_85Ei_J9CDtd@kwain>
 <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com>
 <atHQupHr7_ocAJ_A@kwain> <CAPqbLS0XXB53mnymFVZAVodc73r8E52PWRnxSwj6k8umqC7SAA@mail.gmail.com>
In-Reply-To: <CAPqbLS0XXB53mnymFVZAVodc73r8E52PWRnxSwj6k8umqC7SAA@mail.gmail.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Sat, 17 Oct 2026 17:52:08 -0400
X-Gm-Features: AclHuK--2zbQAhbE8812SRoKdfqvhlJ6jnYw1O93FmhhB5V2pen0FpVk25aFiKQ
Message-ID: <CAPqbLS1uQ94We27Ot54oZmQ+iEwZfQztmOvz8dDRo3kOCq12PQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NdJzRGD4 c=1 sm=1 tr=0 ts=6ad3ee15 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Ea0mjXp3HgiUWvWh_zl4:22 a=VwQbUJbxAAAA:8
 a=s1qTDB3tYtKRdSl9UekA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Z0bIjp7adMhJndlGRzAA9ai73sQBSdqu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfX4D7492jKxvOU
 FLehUeDJuhRhvfx4TIxANI1crCdMCdvFuaAzKJHJ4meiaV4/QR2KLcOsxKipUiaGsjk8nQAS+pq
 PzLx+9rH0I/7jHYCT9b7+CDR3gbSPXhMJmTVCGRVfEAheXkeN36UpCy0LMdRTu6xOgUutPUm41p
 M4SxmGSuM46PbMmsSHELbC/yAoB7CykR+8JjEi6+L7lVvLVUMazF+LcxqjVyV0sBiE0NJYxKxj8
 wONlYNrA4ZKanvODeUEH1TTD8EHIfXU+Tj4zc1yt2zA488r9llIGng0NADvhlv1VAv87qs58dZz
 9K7tVH3nhmymXhAWAURbB5/XEMw7HOeYULiNw3A1NpOtGdctiH78KFHevsvesfhlTktetmJoAYC
 AXkDNUmFvZllyL40bmxGgk86GBR+ypO4PTx8L4cC3kFNVsctoCUxUZZnk2jpPiZkFyiDZfv1q+L
 KFIOop3U9rZnNmbDRQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfXwTIvjzl8vQNn
 VU0vTup/HFLZi7A9jvVOlKOttlzUAaEM3OOxn5H7mmk/X+QzCZoVD1Y6vtDrAxxienryoc/p7WM
 msIkDXfPjgRnqxVQrc9Iz/4Tt+iI4X4=
X-Proofpoint-ORIG-GUID: Z0bIjp7adMhJndlGRzAA9ai73sQBSdqu
X-Orig-IP: 74.125.82.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170087

I stand corrected, by not passing any argument to RTAX_CWND, the bug
can still be triggered. Doing fixes on tcp_snd_cwnd_set would be
valuable. One idea I have is that if 0 is passed in tcp_snd_cwnd_set,
a default value of 1 is written instead of writing 0.

v4 has been proposed:
https://lore.kernel.org/all/20261017214845.28769-2-kj2864@nyu.edu/





On Sat, Oct 17, 2026 at 12:12=E2=80=AFPM Jerry Jiang <kj2864@nyu.edu> wrote=
:
>
> Afaik, I don't think any changes are necessary to tcp_snd_cwnd_set as
> users are completely rejected from inputting 0, which could give the
> assumption argument passed to tcp_snd_cwnd_set is a number larger than
> 0.
>
>
> On Fri, Oct 16, 2026 at 3:29=E2=80=AFAM Antoine Tenart <atenart@kernel.or=
g> wrote:
> >
> > On Thu, Oct 15, 2026 at 12:57:51PM -0400, Jerry Jiang wrote:
> > > I have considered rejecting 0 in tcp_snd_cwnd_set but afaik patching
> > > tcp_snd_cwnd only would just ignore the problem. My current patch
> > > should completely reject the user from creating a socket if 0 is
> > > passed for RTAX_CWND.
> >
> > I'm not arguing against the current patch. My point is warning on 0
> > values in tcp_snd_cwnd_set made sense before but since this is now know=
n
> > to cause oops there might be something better to do there.
> >
> > > On Thu, Oct 15, 2026 at 5:57=E2=80=AFAM Antoine Tenart <atenart@kerne=
l.org> wrote:
> > > >
> > > > On Wed, Oct 14, 2026 at 03:56:41PM -0400, Kaho Jiang wrote:
> > > > > User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> > > > > This could lead to division of zero error if not checked properly=
.
> > > > >
> > > > > Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> > > > > Call Trace:
> > > > >  <IRQ>
> > > > >  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
> > > > >  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net=
/ipv4/tcp_input.c:4440)
> > > > >  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
> > > > >  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> > > > >  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> > > > >  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator =
1))
> > > > >  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator =
1))
> > > > >  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linu=
x/netfilter.h:319 net/ipv4/ip_input.c:262)
> > > > >  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_in=
put.c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator =
6) ./include/li)
> > > > >  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator=
 4))
> > > > >  __netif_receive_skb (net/core/dev.c:6410)
> > > > >  process_backlog (net/core/dev.c:6761)
> > > > >  __napi_poll.constprop.0 (net/core/dev.c:7830)
> > > > >  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
> > > > >  handle_softirqs (kernel/softirq.c:645)
> > > > >  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel=
/softirq.c:758)
> > > > >  irq_exit_rcu (kernel/softirq.c:775)
> > > > >  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (d=
iscriminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> > > > > RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> > > > >
> > > > > Fix by checking if user pass in zero as parameter,
> > > > > if so reject the value zero.
> > > > >
> > > > > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cach=
e.")
> > > >
> > > > This looks like a refactoring commit only, 814d488c6126 might be mo=
re
> > > > appropriate but please check.
> > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: co+71b6509cb791e531@bugs.sh
> > > > > Assisted-by: LLM
> > > > > Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> > > > > ---
> > > > >  net/ipv4/metrics.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > > > > index ad40762a8b38..e83a129a25b6 100644
> > > > > --- a/net/ipv4/metrics.c
> > > > > +++ b/net/ipv4/metrics.c
> > > > > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *f=
c_mx,
> > > > >                       NL_SET_ERR_MSG(extack, "Unknown flag set in=
 feature mask in metrics attribute");
> > > > >                       return -EINVAL;
> > > > >               }
> > > > > +             if (type =3D=3D RTAX_CWND && val =3D=3D 0) {
> > > > > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be g=
reater than zero");
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > >               metrics[type - 1] =3D val;
> > > > >       }
> > > >
> > > > My understanding is tcp_snd_cwnd(tp) can return 0 and then the divi=
de by
> > > > 0 occurs in tcp_cong_avoid_ai. Have you also considered updating
> > > > tcp_snd_cwnd_set to not only warn about invalid values but also rej=
ect
> > > > them, preventing similar oops?
