Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792448824;
	b=5OinSEiV/kME9JsrCZGw5UwFXXx2djg9iGefa43fZEr+jJoYqNhFBMtMdPV3+uJ0lszS
	 ENzPq+KX4uPb9DPB9Sp3n7xcZxgb3/M9irKOdvql2UyYTtcli0cwnbTPfb8fw7ZE3QNYO
	 mLHitmlWFlYnd/xUXUVKwJ3ZDwNe++aQdr0VimNg7moMG6TFrlL3jLe8tFzrAzBvxNGk6
	 71IaA7FJoSZlyJ23g3HfWGJh4d90cuo16ybTT4TGv4zO1AT5S+RfXT2nSTYSQAzkJcT8s
	 4evwA3JLoUmaCAE9Q/PLtsvjwgR9VOr7WYyEuEg7op7ITdyMP7aXt8jmmN217COWCBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448824;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=7W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=;
	b=3Azjx4YBoLHXVKY1eY0phrhb8cL9l7Pp7dMWQm71kPGw+xmu5FeOg1lxq8PeUplmoJQq
	 VNmWRb4H9CKLlfNrZOyEZcm7rR8m/4Qt1H6Elu94siIcuWjvMNuIzs57UltI8UUlvkLGa
	 W/Z0jFTiZ9aEeQTyDP8aI/A+C1cV8isyQQWu9AF++d6jIJ1EBz5yt7a8qjDJ5fx3AX3jI
	 iDoO8jvFmBu+ZklY7Xuox+PsP5+0mEAbCUDaUtBrOBrP1YLE/SPv49Qm3Q7nxZnjCJH2K
	 edl/NSmeZqY3HeN1Io52+8ARtG/L6UdWrZ96WM74WuEW37VresHNveSnsJYIadMGcFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=Ik8aelSe;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=nf9o7U+C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD75606A31C
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=Ik8aelSe;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=nf9o7U+C
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JL8RLb3294123
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=7
	W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=; b=Ik8aelSen+0yPt9sa
	EocafKhobDXbKGKRRviMN6sAcOIuxKAj5l9lAdqzxQe8Kt/1ps6w2LkiPA1OLDFa
	lcRgEKIG0hiEgsV8PwrEQXlRmhPFB2Jkyi2eYBt4RERzLswy3Vmw5HYeT6d0addK
	D1FlUbITAR3x8hg8S9ckM4Z+QA4ebhPOXzyQeSk5GReME2Ua9j+MpLfkE0I3jILR
	JYuihYXTP6C1VVbJ23jV4kI8wVTHEKr1f+/eVq6pw7kDbbxwfSkFckQktuZpBKx6
	qO7EYqiTD4NzfHm3nxB2Xfme353iVlvZS85Jw53Q1I8X9fRG0QBOe67+IjCmwqin
	YZCGg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hdttc91ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:27:03 -0400 (EDT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3592749a017so137854eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792448822; cv=none;
        d=google.com; s=arc-20260327;
        b=nI++TY6jYAdyR1smGkHlaM2JdxtZusEaN3I2xywLoNkY7s+YBxfwtlEA5b4lmfSUfE
         VYMF6jSDfkZchQJII7Qng9OzLK2T+PoJAJ0uWYKegDiEtnFlRvJa2usi4saTsnWgD2hL
         GF2LN3+e1wqqA9S13XUsyld6LBCyweQdv1NUwA5p3I38BCEqTO76svLynrxiZsgET+Rr
         NnWmhA+QnfkpLPcvITxWlEE3qLzrLWwVkzR0DE51s4qaTuVL+Q2s2VSIxJZIXUMPQOw+
         C7LWlrCn9JYNxnvrK/wgNKAESujxxr/S4/lYeOL7ePIjmwpSDUSdDt7tvBtulCNY04mG
         FuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=;
        fh=tdYO7Gl1gRAMC2cnU/RIF0HYHUTvLubMCoKvqCtawLY=;
        b=lZlmeDufVnOu0cBFLMGZKpXPNXfH78jVKqgzoAwjD38f4/Bd8KJA29hQGbDGDDXzLH
         kzt50B4FnOEzWLmOKMqO+1FzJ5mPOFOIrjVrtkBdWlT/E4kojrmEBYc7Zr2rYvs8OSi5
         eu0jAWFyl2SUPbF7CURxRLPCT2To3pinSPzadq4mpF66mISB5T3aVffhfifS29+m7x06
         0a6SLN1cwkqVHwuRlO0is8XvwVmqpcp/XteISElXDOClgDBNqO07q4K+8JaOqnhlmxKs
         5deknKqCgIJpZWlCmNKzCbm8fHugxrwIYXnPIbhq407/RRJwucSWK9nOu0LUQCqrb+bU
         PZfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792448822; x=1793053622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=;
        b=nf9o7U+CdVmNSA8SypncHM+YKDlJKnoP6jBDVVYI5lhlc9p3KaU6f9RGOk4JVolzlh
         kgo9KHZ9+1DnWHtHbKOZb5gmVdQobCb+jpQZBqva8haMFlhvws3VJm4l0Mf4x2HhYfcR
         74MqhWecZjGCVCBFJ4YTAImmvUW9jG7or0pcimmfMWYTT+aloWHcG9xaOQTeaVISOKgI
         ZfEpC8F+VFBPOJBvlB3crO93GfVAu37GQ5X/PfIk/cuxLHXB7WLKWXnbCRJkP/TpeMF8
         YtSQ0Klh2ydpBNhV7KUMppTGPl4JfCj6p+26OlSvA9R1XKxf0/UlPk8YZyH5e3fQ3FmQ
         4G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448822; x=1793053622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=;
        b=iRgPOSxlaGigSNu/H0QGu9jUkOyOjzlUkqdhWnaz1OwT+x2Csk4KuMhiWnB5Xf1cNy
         prhbDTTHeoW9k7DuUKXQq9LFq7UWhAImyB9Rw8itV/ZpU6kfakbc2gW7ylP0IBefp6TN
         V+567QAO3xTyLtvBfUSMR8WPp7cHy+6VsK8JpCn9KyRmFqd52tU7Yynyb7tal8N87DZ1
         uhbwI8yP4/JT9guzS/x4qixTw9QKjcYbzW+sJiVTicFGrkueZAkZT9gTUvgrVdXr3RdE
         VmAZ06mUYMv6nLEaLeunHGee085WrGqb/uHfxJrL6Hf5jKuLLHeXBZyQqe9MaAcpLKNq
         wTXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXjQfKZZuTAb2P9crd6RdxKxJKY9TbSwJ7Fc3rYVPqc+6vwUWkQazHHCHi5BLENo/gG3BhaTI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjbQzKbS73zjb8TTVC2uUclI5B8+MgXXm/4Iy5i/iULsk+rEQs
	xsG7bj/TNJM4OajR0Qv5vWmv1JEKjO9sR+8TiM8GKrReIbCKH3o6H6BF1frmSdwlerPDYVCY9xg
	Ui3n/XhXKnn/XWDcnO6VUjLBhHrtjpEXU03jPmc0vwA1HgXa8g55euLkSH4WyTBWcmDsB5Ce16U
	aqb1nmaef+DkcD5ntfHzgOdeW5+mr4ng==
X-Gm-Gg: AYBFou3z5MsoFTCr0eBXlbY5GVRO9EkxrofcRjt8olDp2LiJVBo33e2XRXtZioxBgMt
	EkUDue7FI4ghPmenr+0P+HNP2FGIXmTMHGTvfKinZev8GiS2z5fAfHK0vvpDOLo70829+8iuYyP
	QCsNCNcBJ7mP/5ZP7D25mfnQCtEu2Ut43CeuJsKqhZY7YTT9j1WbFCN481rA==
X-Received: by 2002:a05:7300:fe8c:b0:33e:61ab:8309 with SMTP id 5a478bee46e88-365fbe702e6mr513094eec.23.1792448822253;
        Mon, 19 Oct 2026 15:27:02 -0700 (PDT)
X-Received: by 2002:a05:7300:fe8c:b0:33e:61ab:8309 with SMTP id
 5a478bee46e88-365fbe702e6mr513046eec.23.1792448821208; Mon, 19 Oct 2026
 15:27:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017214845.28769-2-kj2864@nyu.edu> <atXVqZDUhE9Z8InH@kwain>
In-Reply-To: <atXVqZDUhE9Z8InH@kwain>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Mon, 19 Oct 2026 18:26:50 -0400
X-Gm-Features: AclHuK_OizrKzXhjvZJbJnNHqcKl2cJmdxnoqVFQ_oSZGq_xEOdyc5Kt-heihiY
Message-ID: <CAPqbLS3wzSQTJJRoBGjJ-C-2GZ95qn6GLAwYBYOt3o75uRiW8Q@mail.gmail.com>
Subject: Re: [PATCH net v4] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: UhnxhZhaOvnStZ7pxQmdFsU96MnXTymV
X-Proofpoint-GUID: UhnxhZhaOvnStZ7pxQmdFsU96MnXTymV
X-Authority-Analysis: v=2.4 cv=Qu3LTlyd c=1 sm=1 tr=0 ts=6ad69937 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=T67y4n-0JBmO_r8OIWtK:22 a=VwQbUJbxAAAA:8
 a=hKX_YmtgrgkOCiSBCTgA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX3ar2+CCbLhPd
 4bswFzg/d7lMi7IJ0SftNXna0DETA45+kdQgX++B2rcNBpq5f731xVgisYgCanaLPOYS0qwuR4F
 i7tvhR1oqkObaNUlhVfhikJKQXp86B+0MlmQJ0rujWFFu/A3qze6CAJ5nwC18WxhPep4wGgUrCc
 0r43kUEGBguQWi1zwMmkCxJrXYV547c7HsyEnSrhDTFOU0vpe5bNLVmPaxK+Uoo69uXxuNn6f/f
 c2I/Sm09+sYVCetWcjwLvieJ/KDosMnFrx4DVxRDkK61Crsq2jCDsP8HlvnlVkjT56ogpPi2Cyi
 VWXA7B9hH+Flzp2R7tay35nbGd3bRp8dywFSMNt3w8a7kuuXQg1n4AbEkenzzPkcFPCBJFwqLVp
 SHvmk/2ygLTAfL3p9yoPSCYE73L/KIUzDTXpp6Oc2yFPY97QYGpBzsNiKs6pxIX7BJ2JvIlkO6Z
 6LLI7EUGAAkkDI1MLeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfXyunj3VNE+W6g
 7Oxgsh1xAWjnTyN/Ss4gVqd+gHjYkVlbsFXZlGVs6o1NHNDYpCTj1axAITIm8xZPkIh/mH3u/ZL
 P35xUKkXhw2h++B/CWMxq9qqFzR0n7A=
X-Orig-IP: 74.125.82.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190089

I apologize for deleting the warning.

v5 is proposed:
https://lore.kernel.org/all/20261019222531.1073-1-kj2864@nyu.edu/

On Mon, Oct 19, 2026 at 4:33=E2=80=AFAM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> On Sat, Oct 17, 2026 at 05:48:46PM -0400, Kaho Jiang wrote:
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
> >  include/net/tcp.h  | 3 +--
> >  net/ipv4/metrics.c | 4 ++++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4416cdf9bf30..ad80b8fb8a52 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1521,8 +1521,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_s=
ock *tp)
> >
> >  static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
> >  {
> > -     WARN_ON_ONCE((int)val <=3D 0);
> > -     WRITE_ONCE(tp->snd_cwnd, val);
> > +     WRITE_ONCE(tp->snd_cwnd, max(val, 1U));
>
> Please keep the warning (it's not only about 0).
>
> >  }
> >
> >  static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
> > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > index ad40762a8b38..cb36686973e5 100644
> > --- a/net/ipv4/metrics.c
> > +++ b/net/ipv4/metrics.c
> > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
> >                       NL_SET_ERR_MSG(extack, "Unknown flag set in featu=
re mask in metrics attribute");
> >                       return -EINVAL;
> >               }
> > +             if (type =3D=3D RTAX_CWND && !val) {
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
