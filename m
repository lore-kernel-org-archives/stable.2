Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784963A4F4A
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273933; cv=pass; b=UITwZUUjszt5/0tXeKSZ2uFjPVPt79N4DCm+NNn7ECGQ6YUOz/EmLRDLLW7D3Ee7CVGCDiqwjbTaw6V/bw+e/RBBoDdG/6lNvj1fn7UT1Y7P1fX4TOKhqwCq3TmJYPUbVcpKSoqsBxrHbGM8G6OXTLXKJL8FGVF3r1jQGPHYBAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273933; c=relaxed/simple;
	bh=d8B6iYTbhPZ4eQhHbMclnxqxpRbx9Q0XEc7yVaOrrpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCAjsdhH9vZ3DIveRfBJSvyXiMBWYdqe4SSLWG1X2UhmaGyYRvrDJKJHWdzxrcGg7hIVuDXd9Jriedn+TsAzzH++f4LWXAz0m132w63m03x2iXozr6m1dqYdFYDA7pLOw/kUsNEoZYiz0rARymYcN3WoCKzaGdyMbkXUPdzHceA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=hmE9i7Zy; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=lPN/qBNM; arc=pass smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="hmE9i7Zy";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="lPN/qBNM"
Received: from pps.filterd (m0355792.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HFi6dY4076022
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 17:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=8
	qt7LuF8GRgjS8yzBLI9aYUymptt8k72tgwjkn5uLH4=; b=hmE9i7ZycV02BfcjP
	HkDp3dloe3OyHmC1Fk+R34beoPq8p5iKPRXyIscXZXqM7RiOOR70OS4oSzLDHmQU
	8yuH0mLCQZ9+/unn5SYfpDiHbOWIKPIYvdzOb5BaZRIjyZRfIoadh79pxCJ7P9zQ
	M1FeuUlEx4A48kiQDGcaLeozjbDkCP7vvTCX8VtJBnl1k7rDgIrzO8aNOob41768
	ToEAGFSgOS06zU2fzsqxzMpxa3mMByIgmeS2MHPHvpI9cdej2uh64rmp90kcXdd1
	cdE6GvwJLTl95m1IfDFkBei08WbqRs8SB9viHHglyd62uMKbR85YNIc8Oho2TX4l
	TMwEA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hc57n6yfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 17:52:10 -0400 (EDT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35a04491c56so1189616eec.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792273929; cv=none;
        d=google.com; s=arc-20260327;
        b=D+pwjKnwFazAWQB0DurmzH/5v2V0HAAL26jbdqVKp75a5uh9bUhi9ktRA5l99NmCXn
         C+RTdUJT6186jE3AtS19jOWKd9nqtx/xJaNXyvHLv5iKfDxrcUAfUtqot77FW8eLAplh
         SKesXE68Et/k+DwLYjtKQg22hihlAWditY9L++cIih1qLQnHe7CJp6E15pxx9WfXmUVT
         A0aCe7HYZhnHNRg/xrr9c87TAVWUjWVI5PMUU1namRKw47Ya2FybeqfVjhF5YSN5NCOR
         fogAKfAa4VptGbqBtjjX01Sq7qyfSM72W2wpt4pTfFc5XPJ2J6/nu8ViN+y8KqDrBygS
         mi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8qt7LuF8GRgjS8yzBLI9aYUymptt8k72tgwjkn5uLH4=;
        fh=hxhTmuTAnH/eolgp+l/nLnsiZ3Y6rwyPhazeVhbRWbs=;
        b=TsnbvMJUmLNJX2+Dgn/4YSUqED6PcsFmnULWUobdkNsm/fyelw/KBvIA7LE28zXGo0
         EziDBlovWJUEK8dB/ZXwVa1IDv6hK1GRDX5Pd+39+2SRKwVXtCkapiyzPRrr4VWsWElL
         Hv8hMxSu8mfxZLqK8UDCF3SzLeTiJO809jFK+CzePQjR7r94jIobooaTkQRNRH6gLSa4
         9TZGiHlkNYPsdUu2VlFc5levoB26TdL6CdhWzQN7/FwqNBKLtmT8EKkt5VOJpkErfb8p
         20jkgz92iwXUFPhbqe8rVN7RFlAvKMOtuMEcwX8A+QvwYo1i2UDFgo0nRn4CAjBllcq9
         ZFJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792273929; x=1792878729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8qt7LuF8GRgjS8yzBLI9aYUymptt8k72tgwjkn5uLH4=;
        b=lPN/qBNMb3s7F/uEvK7v2u3wVZmyOWknoqR4J1UH4O3aEr4eE7EwJzv33Nhr1R1Clo
         +f7grPHEa/xrehMVdyb02DZnvj9v1y4k6lLYS9I2+NmAslczRwtAnRQhJba9Fu38JD+8
         ReXIlY+HVGmiA5BU4GgUiMsjJBaDgzMgDuq8DrNQuf4iIti65XmPNHlMrh14PpDONALJ
         SCh6TCFYNzLi87JjHEhfi/SvshXAFCTwykvElfzwK/lrt51qZWKJ+9k+De7kZ0mbc6o3
         7NWIldeeNvxsL3NT/62EB2a+3NtvC9yTk+Bok5oCWJ29ZPFupyZjxIcAic2iwMe5F52u
         DIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273929; x=1792878729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qt7LuF8GRgjS8yzBLI9aYUymptt8k72tgwjkn5uLH4=;
        b=VIUORqXo2XwWwkVYHWg8Mi8iVVOBQJHbxQnL66lhUpujLFgPEyrKBxvCcoaehowhco
         E/P5VUgH5V9uZvsy74JROpUL/MbjwqvisHJo5mF6qGAaV1Cxz4u6moWU1m6V+HgDjr+F
         Q7lNvgJ+Sdi07+WW3qv5l0xgxY5+KkNIHy6bY1YFDAh7R62JwdB4YdPZhSrc8FVlOfVU
         lhTjB2tOJgl7BVY+iMdXnKV132RKL5EDixt7oVzfaqnFtqdIpAmVoOJz+/MFXE6TblZT
         mMx2djDMqIooMyrAS378saqBHlXSRlSucK9Fm6pFGHjOLnRziS+CEMI2BHb/DrwLsD94
         cEnA==
X-Forwarded-Encrypted: i=1; AKwUvBwQLF8L7ilGp5JlD5ulkS61p/nyMH72B77DuRCjjy2sQ7AhjXa4rXN707UuRX0IXCWMwpKajaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHhCvCsKs9h7fbL9mHRq/YoyHCo6uO5ULIN7HpA7MFK610KwRN
	Oas45DiorZhSSPQYPBaNrkjJwmYgdKCRLHRSaPiqsrvFk1I4R8qjnKaRsCRWUqH0JY6xe9EmZzz
	RyfoUnCodS32A4YfNN8+U8QbbCCNzk81S/ZDLl3VnYsm4jh41OxYqt3FTsd+GB0ZG5og/YTyUGi
	TP0wRb1Ee51YdM9pMK1MwX9tvGuxmZaQ==
X-Gm-Gg: AYBFou09cAO66FbEtgcz5fITsUab4jTjwh3wDuG7unL/Oz7Bs2VQhZRzQv9LADRPszW
	CLPSOJROEhFvJDVn56iJ0KD32ts8j6aycG3Rf1yCJLgdLMqTu+qpYAwp0L32T2x+TVQ1Ycq8VA1
	Euj5wmA8OptIeYeV3zuSjTWYpEeegCXbRhTvJ8Vf5mFbdCQNrhFKiObExMYw==
X-Received: by 2002:a05:693c:42d2:b0:34b:3f7d:6105 with SMTP id 5a478bee46e88-3602e3a6861mr8093130eec.14.1792273929001;
        Sat, 17 Oct 2026 14:52:09 -0700 (PDT)
X-Received: by 2002:a05:693c:42d2:b0:34b:3f7d:6105 with SMTP id
 5a478bee46e88-3602e3a6861mr8093109eec.14.1792273928367; Sat, 17 Oct 2026
 14:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015201549.4023-2-kj2864@nyu.edu> <atMFPKhON1IK5cxc@google.com>
In-Reply-To: <atMFPKhON1IK5cxc@google.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Sat, 17 Oct 2026 17:51:57 -0400
X-Gm-Features: AclHuK8V8PqtlumCUfPitjiENks2rIhGVpjBZixB0b_eQMRRbzEBuswi5lOYgMA
Message-ID: <CAPqbLS0vsCAPqoAwqZ=HSCqfH4SigQTuv+dn_ByED-b2ickRXg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: ipv4: add zero check for snd_cwnd_clamp
To: kuniyu@google.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, edumazet@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: TOYmuHb8YRtUeduwQhhnFQ5FGSwwdoeB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfXzO/IULUXsj6x
 AY480eqlBVuz/xcSMY0jwNuwBN6cx/xLeLXOF26YITbAjYwcU4kuDd9bPHyqjTGJPl7swCMMC8I
 5MqUmUEbCm1OTmvOKTA55XwLLOl8ZodtD0sdeivcZKUQ9rBwj6BWZcEax3ygRMbEg85BbjzB5pN
 k9vPrymCwiZG3ndg6Cx2pUnMoeONtjVNGfMSdcf9rwD2N6YRJv/7jxn+ym5EDPDejtwGFnIkG3z
 3rY7m+gnqD6UITD7jBVOavmHJx8KxLwn7e4Q1phxNNJlraHzKJwXtIv4Zaq+PfoiSv3xA40xevG
 xIi5KV51ZN7OkVBqSoQ0md0Y3SOw6y89T5JTj/FaltLp86FwkKxb3C/qyi0q0/QaYK3/k87AffV
 DelyWZXAcQQSueKldoRCI3TaJukZt0Th6y4DXF89/RPLzAvA54wQaUtO/8UdKoog3l4DYlyuOaA
 dShcMmv/1jZbBivYTtg==
X-Proofpoint-ORIG-GUID: TOYmuHb8YRtUeduwQhhnFQ5FGSwwdoeB
X-Authority-Analysis: v=2.4 cv=HINWhYtv c=1 sm=1 tr=0 ts=6ad3ee0a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=16cGfGHOS5B3VL_TWyp6:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=LDwnR17CkXKMPNxMdHAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfX+kY9IvoSemCp
 mOuWxFeYzceSJ6WhVOH8VddkUjF8TFM++2aYZ1NDshQ68Y/CTmMSn0rNLREmyimNiju/3yj7a3i
 epDS8mnnPCif7w6VFI9xIyWl2Q+H8mg=
X-Orig-IP: 74.125.82.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170087

I've made some further changes using suggestions on my v2 patch and
using !val. This change should prevent all future errors regarding
snd_cwnd and snd_cwnd_clamp being 0.

v4 has been proposed:
https://lore.kernel.org/all/20261017214845.28769-2-kj2864@nyu.edu/



On Sat, Oct 17, 2026 at 1:21=E2=80=AFAM <kuniyu@google.com> wrote:
>
> On Thu, 15 Oct 2026 16:15:50 -0400, Kaho Jiang wrote:
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
> > Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch A=
CKs")
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
>
> While at it, please check RTAX_INITCWND too (although it is
> ignored and TCP_INIT_CWND is used), also use !val.
>
>
> > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater=
 than zero");
> > +                     return -EINVAL;
> > +             }
> >               metrics[type - 1] =3D val;
> >       }
> >
> > --
> > 2.43.0
> >
