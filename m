Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20232332614
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852916; cv=pass; b=MChiI+dwp7Ru0tFqqX11otDn5SUyPfuAQ4aaGop56ywvXubIJhfMI3Uf4bENtvXGEJtfji4/2xhKLPygFtEyLa78MHWRVdRZV3gX1nacY2TI8iYseNTKOC+gaLvepSI0fGkepsacF3bctBR0wj8DmPiKIzE9dfvdpJiSkTN2sj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852916; c=relaxed/simple;
	bh=s4iC0oPHtM2xTR2guRivNW0jOnigPWNa0R5PIlMDi+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp2QVZTntJZEXYcy8Pj6Qux3efOQRTvolXUq1BI1Fn0wi2i9pZSzivXXcLjs/IQsUfkZ/9KX1dc0a/3itsdUvuErXcT5iT13krA/TKk901lBbCqtek7UdVttdcW35pmk5MpVsCOMY2wThUcfkpkkeLcdeG5rtYuX/JkFFuTimVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=eDCU/fcT; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="eDCU/fcT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso223789b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852914; cv=none;
        d=google.com; s=arc-20260327;
        b=opqwq0sjVzhdD4x6Z2Wo3XxBjZPaRDVBB4CN1rlIdez74z91rBeVqX9Uppf1Z2XlrF
         Vnpr/NRF9TBEakh3JFTj70XOMLKXwnFphSM2lrZiT6WOsxoKPj5/9qe6d8crFH2P6hxs
         Ept84wzsX9xK571DEWDH2wYs/7uppP9tPKVAUGJ7Lxct3TnJPzkhsWad49CtCtSErFvd
         SnyafILY6WReBFnodrscN+XDHBQKL66+xJbogyMsRbOSYuGb7N2H2cHlqOlWl5JcQIdh
         VtbJUHjNoebGezcwrhAhTbotHh9SjZ4KZKlnTwE0NsAZP3tn5R/4M02FkrFF+qMrBJAt
         tn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LyT9m6vYgvCboypQm7Wqmumh+kl8ebK0ZWBWK+xDPrY=;
        fh=1ZCAQn///O92mIAjx+8sKqPQEkWJHhvG//guyf4I2Es=;
        b=YOFgekuJhA0xtr0APkQRXdm8P68hRwuNrHTw9clrUAGcWQNCsuGQ1NjOASIy7D7yI3
         uA73B/FuiEs+mtSbl0k6uMOObtYjhn51NAUU3r6aHNpklcNvrvw+CUmhqLYLMxJQsCtO
         I99zSLlNJxX1dsO7YX3zEHETr/g6dX+d2+ZC3pxToktuh+OWTwhMHWKKEIOyQOVe8JRg
         7/CybA2oiz9AlhIpegUtLLFgGz9EFQGPc3/7ytwbQi6ZoxO8ObC5o0Y2FpZ6LmAe/1SJ
         Od6r2ZEWjEOPvSQWOQwSRR9wJ+Pn2l3ORj5R1zCshA3IAQypwEYcDGVpMB8Wew9ilaBf
         QJVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787852914; x=1788457714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LyT9m6vYgvCboypQm7Wqmumh+kl8ebK0ZWBWK+xDPrY=;
        b=eDCU/fcTjex6ImzmMfBEWNOmcQQB9qsHFZ6V21wq5+9KrNZjB5MTh2floQVe754MRf
         zQSrQ5PQ8K2qcYt+gvmH+CZCtmR3WgYXerzk0Wj16jlInjMbo3tktu9Rw1B6/natnOeM
         JY59hfo/wDbCfGbTM9F5UsDMgN6cicRaA1lBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852914; x=1788457714;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LyT9m6vYgvCboypQm7Wqmumh+kl8ebK0ZWBWK+xDPrY=;
        b=IrSSNvU9PVLf5kravN/VUIekDpnIiYjuiLuvBqh3sxBK6CXBPmV9yzZmz0COFpZArQ
         /uNnxhIE5vFqIG/emBn6G/FcbHf8xeFArJBk+L5jEcCr4Lm5aWizkBCzkNoa2QySo+AM
         JNhcSVETQrfUbm+7N9kKR5pR/EG2euGasNiuX9jHTru2bzKYDvmo+zgYmZSkPP7MTv7V
         gTbOoB6nwEwgHVmtNZWVeZBJnfsEOcQKRJW9e/6w94GsNRPzN2+ob/4Wg8WT8VA/CD10
         gumm8DZsIWJbvv5obGBh/u/ksq244VBmvVQKi4oc1nRCEh7rX0IHihrw1jBC1Sh0ye1h
         PicA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Sogxqd2dbCnsBBkMf8jjTsdBxC7vGwELx5AdOL7FkRjfxb0k7DXN+JhcN7Q+21ZlhuWbVJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nckbnOfCMOYZ1wetxsmmm7gX/NheYgq6croFYRzw9s+0un4B8s
	MRb5qo6Oejxo1yIkcaKiyEwcx8Vb2xDoyki1ky3zPnNxqFuB/mjSD/S+uHB1pwgb+zch2KueMrB
	fMQl5ddftki2UAlQLY+NwoUWuU+N+VdZ8HVUQxuI1
X-Gm-Gg: AR+sD10dxdDlGOtr3SnhJvFkr7AxfGVj6GSbgck3KGrvRDc+m1EOBeFKbQ+zap15q+i
	o9BsnHRcYs0wpcyp5owAEv/mbJLwNfZll/mmj7o48IVYXq4wC62/zilYhc9hv14cswY/Pa4Ar5m
	BapO3yvySXePpbE/DT+1e/abCK2OQ9h/IMST8kUKR9xWtxJGip1+yH+d6kEi6ff7u7DttLh2VWT
	K+7ca7AnBYSpz6VzmQ8gAXtVTlpAKboeIWGYiJkwJKv+Gtj6EXFRBKA0fUsRwcdjCa3geK5kHLS
	N+YM6ellH2myE4OYUU2ydD6x7y/XDogZw+atIgx9KAld/s673/wxV1HsrLaxzUr+osPmjXFcinr
	652W85Qh6FfYHbEG0J7zd5BnrjHzG01KS88vbsA==
X-Received: by 2002:a05:6a00:14c1:b0:84e:24df:3870 with SMTP id
 d2e1a72fcca58-85625744b34mr1835179b3a.0.1787852914280; Thu, 27 Aug 2026
 10:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825081403.133992-1-jhs@mojatatu.com> <20260827110116.180569-1-pabeni@redhat.com>
In-Reply-To: <20260827110116.180569-1-pabeni@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Aug 2026 13:48:22 -0400
X-Gm-Features: AcwNN1Xisaq6K8bC0YznwHG6b1MniRy0iqbFR2TGreidXeFcIaSECmie-xf1g9E
Message-ID: <CAM0EoMnA==Hyf4rROCxnuyHcjone30=XbeQK3HD7AGf8_k99AQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, 
	stable@vger.kernel.org, vega@nebusec.ai, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/

I have two followups both targetted for net-next. Both are valid but
pre-existing different-root-cause bugs, not things this patch
introduces or should fold in tbh.

cheers,
jamal

> ---
> net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
>
> This adds QDISC_PKT_LEN_MAX (1 MiB) and clamps the value computed by
> __qdisc_calculate_pkt_len() into the range [1, QDISC_PKT_LEN_MAX], with t=
he
> stated goal of preventing a crafted TCA_STAB size table from driving the =
DRR
> and ETS deficit refill loops into a multi-billion iteration spin under th=
e
> qdisc lock.
>
> A couple of questions about the fix and about the arithmetic it now
> consumes.
>
> > diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> > index 18a419cd9d949..90d3e7943b19a 100644
> > --- a/include/net/pkt_sched.h
> > +++ b/include/net/pkt_sched.h
> > @@ -12,6 +12,7 @@
> >
> >  #define DEFAULT_TX_QUEUE_LEN 1000
> >  #define STAB_SIZE_LOG_MAX    30
> > +#define QDISC_PKT_LEN_MAX    (1 << 20)       /* 1 MiB */
> >
> >  struct qdisc_walker {
> >       int     stop;
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 65b35528d125f..90503e59e6e3b 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb=
,
> >
> >       pkt_len <<=3D stab->szopts.size_log;
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the new clamp consumes the
> result of arithmetic that is done entirely in a signed int on unvalidated
> user input, so it may not bound what it is intended to bound.
>
> In __qdisc_calculate_pkt_len():
>
>         pkt_len =3D skb->len + stab->szopts.overhead;
>         ...
>         pkt_len =3D stab->data[stab->szopts.tsize - 1] *
>                         (slot / stab->szopts.tsize) +
>                         stab->data[slot % stab->szopts.tsize];
>
>         pkt_len <<=3D stab->szopts.size_log;
>
> qdisc_get_stab() only validates tsize consistency and size_log/cell_log
> against STAB_SIZE_LOG_MAX:
>
>         if (s->size_log > STAB_SIZE_LOG_MAX ||
>             s->cell_log > STAB_SIZE_LOG_MAX) {
>                 NL_SET_ERR_MSG(extack, "Invalid logarithmic size of size =
table");
>                 return ERR_PTR(-EINVAL);
>         }
>
> The overhead field and the u16 data table are not range checked (the
> changelog itself notes overhead 999999999 is accepted), and size_log may =
be
> up to 30, so the shift overflows for any table entry >=3D 4.
>
> Is the signed left shift here reportable under CONFIG_UBSAN_SHIFT, and ca=
n
> that be reached by a namespace-local CAP_NET_ADMIN user?
>
> With the usual wrapping behaviour, is the new clamp monotone in the
> attacker-controlled inputs? For example data[slot] =3D 65535 with
> size_log =3D 16 wraps to -65536, which clamp_t(int, ...) turns into 1, so
> shaping qdiscs such as TBF, HTB and fq would account one byte for a packe=
t
> the table describes as huge.
>
> Would doing this arithmetic in u64 (or unsigned with saturation) and
> narrowing before the clamp make the new bound actually hold?
>
> >  out:
> > -     if (unlikely(pkt_len < 1))
> > -             pkt_len =3D 1;
> > +     /* A size table can inflate qdisc_pkt_len() beyond any real packe=
t
> > +      * (via overhead, the data table, or size_log); cap it so deficit
> > +      * schedulers such as DRR/ETS terminate their refill loops.
> > +      */
> > +     pkt_len =3D clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
> >       qdisc_skb_cb(skb)->pkt_len =3D pkt_len;
> >  }
>
> [Severity: High]
> Does this clamp actually bound the DRR/ETS refill loops, or only one of
> their inputs?
>
> drr_dequeue() round-robins the active class list, and each unsuccessful
> visit advances only the head class by one quantum:
>
> net/sched/sch_drr.c:drr_dequeue() {
>         while (1) {
>                 cl =3D list_first_entry(&q->active, struct drr_class, ali=
st);
>                 skb =3D cl->qdisc->ops->peek(cl->qdisc);
>                 ...
>                 len =3D qdisc_pkt_len(skb);
>                 if (len <=3D cl->deficit) {
>                         ...
>                         return skb;
>                 }
>
>                 WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quant=
um));
>                 list_move_tail(&cl->alist, &q->active);
>         }
> }
>
> Since every active class advances at the same rate, isn't the iteration
> count before the first packet becomes eligible roughly
> nr_active_classes * (qdisc_pkt_len / quantum) rather than
> qdisc_pkt_len / quantum?
>
> The minimum accepted quantum is 1, since drr_change_class() only rejects
> zero:
>
> net/sched/sch_drr.c:drr_change_class() {
>         quantum =3D nla_get_u32(tb[TCA_DRR_QUANTUM]);
>         if (quantum =3D=3D 0) {
>                 NL_SET_ERR_MSG(extack, "Specified DRR quantum cannot be z=
ero");
>                 return -EINVAL;
>         }
> }
>
> and drr_enqueue() re-arms the worst case on every reactivation:
>
> net/sched/sch_drr.c:drr_enqueue() {
>         if (!cl_is_active(cl)) {
>                 list_add_tail(&cl->alist, &q->active);
>                 WRITE_ONCE(cl->deficit, READ_ONCE(cl->quantum));
>         }
> }
>
> So with quantum 1, the new 2^20 cap and roughly 1024 active classes (clas=
s
> creation is not bounded, and drr_classify() maps skb->priority to a class=
id
> so an unprivileged socket can steer packets per class), does a single
> drr_dequeue() still run on the order of 10^9 iterations with the root qdi=
sc
> spinlock held and softirqs disabled?
>
> The same shape appears in ets_qdisc_dequeue(), which is the other consume=
r
> named in the new comment:
>
> net/sched/sch_ets.c:ets_qdisc_dequeue() {
>                 cl->deficit +=3D READ_ONCE(cl->quantum);
>                 list_move_tail(&cl->alist, &q->active);
> }
>
> with an added per-iteration scan of the q->nstrict strict bands.
>
> Also, is this reachable with no TCA_STAB at all, for instance ~16k classe=
s
> with quantum 1 and ordinary 64 KiB packets? If so, the deficit-loop stall
> does not appear to be gated on size-table amplification in the first plac=
e.
>
> And can __qdisc_run() interrupt it?
>
> net/sched/sch_generic.c:__qdisc_run() {
>         while (qdisc_restart(q, &packets, quota)) {
>                 quota -=3D packets;
>                 if (quota <=3D 0) {
>                         ...
>                         break;
>                 }
>         }
> }
>
> The quota is only evaluated after qdisc_restart() returns, so it cannot
> preempt the internal refill loop.
>
> Would bounding the loop itself, either with an iteration limit or by
> requiring a quantum that is sane relative to the maximum pkt_len, be
> needed instead of clamping one of its inputs?
> --
> This is an AI-generated review.
>
