Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C42286D5D
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097556; cv=pass; b=D4uVGu8OODmAJooggFXnpQSbQeJCG3UE0qlmqFj5nloYMKJaf0puCDg9eiqCjwhLaOoTTjh2McaawLKID1jvZurZJBAhMWR3jUU6bAMFzI3AAh5MjPuY7yQbAwZx7nNf8aTC1cuFaTHiuQXrILmJ3K8tcuh0uVb6ClTGGj/9Qv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097556; c=relaxed/simple;
	bh=2Dt4ze1PRtPcKMOQhYhXAM2HdUXW7CpVLr79L/hKjIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmHbxKX9q1RzZ0a0jx6PDJMvwRqYWyaFlgOriTUBAX0a40NXgqIeNNgFGqO7Q6Jx3gdPrFNjfPe5GLq8JS6ff+eT2UQFxGouTv7eOtro2DL0ZK1CAgcR4S4bFaRpoTMcY9SF+XavaOPIq68/wqlB8LLeJ/HJZ+4TkS9zXr8bsHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=Z7o6TgYO; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=K8WY3vQ6; arc=pass smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="Z7o6TgYO";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="K8WY3vQ6"
Received: from pps.filterd (m0355791.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FIHOqt663417
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=E
	jTzUdIh1JiWqCTQbTHIx2EY+cLBJ9IwG0EzO3Un/kw=; b=Z7o6TgYOAwaocZQLO
	RxsZ08glAUbeb+v7CAkOpuPO0q/dOErfoxhuK5uQke00iop+ZU/GfPu9/yjc4K7L
	tg3+W6ARyztVBI6V08Ii3DkMT5A6Eb56P5IS2NyAbGqtR7efsZhcvJyvHpH4pG30
	ixz0BxOkWAF58vdWCzRQsx8gA75itOI7ES74KCkTI5DXmrNfHGS+CN1F62pKlFkT
	xwGVC7QXh2YhkDR6v1Pbm/ZVqvSJcorLcbuVCkculNPfW1Zk5tt7lJXnGFvsXIp1
	rA1OoWfGDpbU739KHDyOJEWLfXUI6oMz7ikerdPq0xZY0r5EDCBd33PU1Nd0L93u
	dz6ZA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hb190p0w1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:18:35 -0400 (EDT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3580c07911eso14740267eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792095514; cv=none;
        d=google.com; s=arc-20260327;
        b=QbxzukKt+eQStBzTOf2EAOF9rzaqi4BKYtARD4y16QJTtuzPesC39pFfTQpULeQqLt
         +1LMHCjtyXqn55wz6ByWbMtjGIs8QZU97rVhID5cPODtw629/sd35hBJSfVkhEyb6uXZ
         geJTtHfT1+A4OZwSRD7MQnmlPrKv7/DINM9VN6nXL9tSNCi28B0mTBMRSIiG0b7+svh8
         g6CnBTZmEnj9YshHsx00daBRs0gFn1RidLokqksH8Zfw3VtRLaHBdJFpl7pGh9xQGEb8
         HSg9fbhoyx0NN6nH6q8fd1Cvj24IIfQ/oJHfO0V6zP2ePHQA1LobbRg9KBOwg0BHmmv/
         nkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EjTzUdIh1JiWqCTQbTHIx2EY+cLBJ9IwG0EzO3Un/kw=;
        fh=VxRRVch0FOTAXn0mZ9Y9SawSKbf46f4ut3Bhuje/hDw=;
        b=rFtIB5GsBtnj3m9nFtR9cyoKkbIjdw2Y3f1m/lU93sitEYBTd/B0O7pewGwMMmcTRo
         wkZtsW360oyRWYBAaWIb7WYFoo3UZdrbdPoT1NOUc+XdsymfnRFhyDEa9h3Mks1rSXEd
         h0JumRNbDjeEGFqxH6P0k5alafXmndrnN05NApKCkSBYHvYBKMdWXN0XPnV2jjirWJqb
         IKTmWASdNa4YDmP/tno5j6598WynToHF88Fx7/NFr7qfNdaVm1x+YVC0Yu3bDV9YzEw1
         gVwV5KbahNBZ8R6NDvRpqJiohvKmp/yfKujTnijJrmwYeT+VK8tIMDMTfsxLtdro1nIY
         ID4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792095514; x=1792700314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EjTzUdIh1JiWqCTQbTHIx2EY+cLBJ9IwG0EzO3Un/kw=;
        b=K8WY3vQ6UZoCX9/UXiHzZ1vOREfRJRlDPOY0vkrjGHoYIt8x+MPtath/6jW9mP7hZ+
         f3gzP71OopiwjZNi/RDL5f0ob0VZw3texzFEIvyo3ls1RsBdU+eW7rN+16VvP4WeEXEM
         Z1pL4bF2PqgUgb9HdKKZssvVSpIncBajOHNmGkH1iHWIa+5aM913PDdEBxarzMkpg1u5
         1rzXfjIAnUFeBU/T9N6vNMHbnXEOdojAKA8GMJSS8z3E3CL5Jxin9cU5BZ9vmtgHJ54s
         gjzptCPihKnIKSjXx43JV+V1mPFXUUz53HIl+ZgjK/YJ4xqbRPxzJscXiJJgui5Pc0Nd
         6hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095514; x=1792700314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjTzUdIh1JiWqCTQbTHIx2EY+cLBJ9IwG0EzO3Un/kw=;
        b=cv4B3DNVJ9WgpIFzPcRg4OiHMwQsFhZLNwc60KpsY+CvcJ9KGSZJ2ExNjkNUDIcXMl
         wqWMmeb1yT29gKPxsDKMoC0FrrY5v3J1e3L8Xl5uKwfxw6H3jHEP5vbsuia/QNIyrvfF
         IvB/+siIEQJj9xi/yxL+p9tVBsxfIQ2o2cURhMLZ/rpK9Gnxu6PMq+dZgl5CmcON0rat
         VL0BSGnLV6W/Ch970Mjdcq/s/0TL+2q97GaZgThS8AEkyKgDfYjbWeYX8qQOvebUJ2ov
         YoumtwkptVJjMtvhX0BW0W+0NTNEjw3MeXEHLfxvj1cSQ4R4GqxiB0dQwh67F97QGOgX
         ZHsA==
X-Forwarded-Encrypted: i=1; AKwUvBxaspIyC2WyXOGFYAMhqhcloHKd4b+djhVSMJzMeNfCZjPipc7P1FHk0E51Yt3zYZ72C7Xcw78=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ4BqzX1Ofbaq3H5abRT/prfHoyLSbFynFfR4sfOgKqBfXJi+P
	3VuMFuMHuvVopttOD+6VuLjmiWdvzelO6xRlJ0pQo20jgmKgvnY7wJSmFUV0nIxust1wtz9SdJh
	V2xqEYi7VRXyttYX8sdIMFz8FWDnl75tumG5CtsieVXi2/6CS5E062FLGeMW9bzQAAxdSttRikR
	WVtGtMq8tvGqDSMQhKFtn+jXy0xfJ9wg==
X-Gm-Gg: AYBFou1dhxAke6kAPBX+lqoC0ShU9H5+RMa9nso6DyAR7aSTfakPxVKrp67otwQ3T6t
	yjBR8EsxFPDs6JqaN5xWqQFM1/S/A+MMaR0V7aAGXlJdTJdM1GV4j8zbsYU/JSAvZVNjZ7FeA+H
	z7qJurKz6qGi3AfK91aYD34sMYiMbTgWEeTwJXaoQVIs9C7VqOkoL1s5wF1g==
X-Received: by 2002:a05:693c:8381:10b0:360:444f:a56b with SMTP id 5a478bee46e88-360444fa971mr1156933eec.12.1792095514023;
        Thu, 15 Oct 2026 13:18:34 -0700 (PDT)
X-Received: by 2002:a05:693c:8381:10b0:360:444f:a56b with SMTP id
 5a478bee46e88-360444fa971mr1156906eec.12.1792095513407; Thu, 15 Oct 2026
 13:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014195640.430824-2-kj2864@nyu.edu> <atCf_85Ei_J9CDtd@kwain> <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com>
In-Reply-To: <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Thu, 15 Oct 2026 16:18:21 -0400
X-Gm-Features: AclHuK_Gij50KpJSzBvvPkxLcAi-zGcFI58uFnfwogGtPPy3-y0tsgfoZbC6PZ0
Message-ID: <CAPqbLS1dK9wqSCtDGJx=cYTJnO8PE5YONj3bykomOFuGDyYmRw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Uvz2pOwB c=1 sm=1 tr=0 ts=6ad1351b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=R6YzIN_bpWbBo3jmtC1i:22 a=VwQbUJbxAAAA:8
 a=GMUWeUELocx5WyZuTCQA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MCBTYWx0ZWRfXzPAVNQt/UYTD
 rPOHRcH/8Xur0Hda9O4zeUgaw3VjCowgY9x0gkrtjMIcYBZF9AXgsbd9DU7pR9O8EwnGx90EDBe
 XOmqylXPcFOSXgWpFEzbtTZC24kd3R7MKk/aliN38L+Tp/X3ltvRcQrBvQhEuWGyszOidEyM4a6
 QqINKVzbEMLej7OY7ai+GifxgoP9nC0DOg3JSZmlY6IgxdeOessp/glyN5NTNIj06D5igl/BXo9
 Oi257KSZAGMGMohtL51AUDlVHTZxuWt962W4oZ1n0bUrtl1my77z5ZT+VfOAXsDUf/OpNHjgETR
 T4t+lbXc0h/Gnj3VrfvPlaEilVeQ3ep0/qwCqRkK79vkqez4Y5FerHGup9CqTCVJnLHiWnNjO+/
 bY7HyKJweDMa/aBy7qo+UxlpCBnS6mH+9Ixk6btbjENs5BpgpWJvRuyRUEgVR2vl9F3sFj5fW7d
 2GhSJd3AyIUfwk/HhsA==
X-Proofpoint-GUID: AxPH0iQ4cX_GgjwJQxUzB23Q8J_IpScD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MCBTYWx0ZWRfX07Lo9SQ+hXM9
 UceGkkRC6fr0PvLcuKyHkxDaBLGKtfPDKaxTZ0knL9HdzpG95GHSzIsjmjo5udESQEMXTJV0soa
 ajW+WxTBAdKSYWQHBpFiCHOqMYKN0Sg=
X-Proofpoint-ORIG-GUID: AxPH0iQ4cX_GgjwJQxUzB23Q8J_IpScD
X-Orig-IP: 74.125.82.197
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150080

You are right to point out the refactoring commit, 814d488c6126 would
be more suitable for this.

v3 has been proposed:
https://lore.kernel.org/all/20261015201549.4023-2-kj2864@nyu.edu/

On Thu, Oct 15, 2026 at 12:57=E2=80=AFPM Jerry Jiang <kj2864@nyu.edu> wrote=
:
>
> I have considered rejecting 0 in tcp_snd_cwnd_set but afaik patching
> tcp_snd_cwnd only would just ignore the problem. My current patch
> should completely reject the user from creating a socket if 0 is
> passed for RTAX_CWND.
>
>
> On Thu, Oct 15, 2026 at 5:57=E2=80=AFAM Antoine Tenart <atenart@kernel.or=
g> wrote:
> >
> > On Wed, Oct 14, 2026 at 03:56:41PM -0400, Kaho Jiang wrote:
> > > User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> > > This could lead to division of zero error if not checked properly.
> > >
> > > Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> > > Call Trace:
> > >  <IRQ>
> > >  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
> > >  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv=
4/tcp_input.c:4440)
> > >  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
> > >  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> > >  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> > >  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
> > >  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
> > >  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/ne=
tfilter.h:319 net/ipv4/ip_input.c:262)
> > >  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.=
c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) .=
/include/li)
> > >  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
> > >  __netif_receive_skb (net/core/dev.c:6410)
> > >  process_backlog (net/core/dev.c:6761)
> > >  __napi_poll.constprop.0 (net/core/dev.c:7830)
> > >  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
> > >  handle_softirqs (kernel/softirq.c:645)
> > >  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/sof=
tirq.c:758)
> > >  irq_exit_rcu (kernel/softirq.c:775)
> > >  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discr=
iminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> > > RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> > >
> > > Fix by checking if user pass in zero as parameter,
> > > if so reject the value zero.
> > >
> > > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> >
> > This looks like a refactoring commit only, 814d488c6126 might be more
> > appropriate but please check.
> >
> > > Cc: stable@vger.kernel.org
> > > Reported-by: co+71b6509cb791e531@bugs.sh
> > > Assisted-by: LLM
> > > Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> > > ---
> > >  net/ipv4/metrics.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > > index ad40762a8b38..e83a129a25b6 100644
> > > --- a/net/ipv4/metrics.c
> > > +++ b/net/ipv4/metrics.c
> > > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx=
,
> > >                       NL_SET_ERR_MSG(extack, "Unknown flag set in fea=
ture mask in metrics attribute");
> > >                       return -EINVAL;
> > >               }
> > > +             if (type =3D=3D RTAX_CWND && val =3D=3D 0) {
> > > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be great=
er than zero");
> > > +                     return -EINVAL;
> > > +             }
> > >               metrics[type - 1] =3D val;
> > >       }
> >
> > My understanding is tcp_snd_cwnd(tp) can return 0 and then the divide b=
y
> > 0 occurs in tcp_cong_avoid_ai. Have you also considered updating
> > tcp_snd_cwnd_set to not only warn about invalid values but also reject
> > them, preventing similar oops?
