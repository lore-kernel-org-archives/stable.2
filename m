Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF73FB075
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706237; cv=pass; b=hHIQ4+JCSIBXDoM/RcfNqjDzBHtbaFWNqopdcPTvfRdAo1PrO2CTFw2OtsI8G662UjDMFDLpHBMrmrWnQhy74uBg+je0WMG718aLDihW3RpiqTmefZiEiacayS7IdvDcf7AbFLxgbWavNqnQmi67aDwZOC5KyWUi+6cVgLishcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706237; c=relaxed/simple;
	bh=d2KpV3nRxborC2VGa1wXFo1AV+iEyH9ShCvH3k2md1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL8+m3VeEKmynxRjMJg7+MmEjpr2o80O+VuxBgEohF88proZ82CHSef3mbjTOIwg8ug+2ddvtVtytJQhVP0nsDyM5Zx6/LzGpgCmp9mtSugx68dy0Sc/YJf717vUNnxGUBiY+0ht1JxZlYyFyQoQZ89Zz5Co43i4udDR56k0s7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=whOxRqH1; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="whOxRqH1"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so513852b3a.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 07:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781706235; cv=none;
        d=google.com; s=arc-20240605;
        b=P6Evd+2v2uA1hiUN6LlLiuG54i3IXyt8hlHxpF7DSHUKHPEPJDePhtbTO0UOfyK472
         n9+dN2ImCfB1xaizT9F8tDke3511JfohR39sCIiQLH3d5RuY8g4G/1SyBvcyBFKepKmq
         bxx/SgZJKwzHG36rDb5MsheR1ScwxY7NqlprvS80aYKbG0yo7d5nzcfNjme3PF8yXLxM
         t/SisDlcdXoYzLOrTomh9zrgMUAQI0I5ErDRaZ8xvuDPRh9dc3++LFKSizGp+cdMESbf
         zddnqkjD7cLINpnAbxSUl3X4sLL9dM55c/QYIL99eIA3kmiaME8Yr2Z5hONZBG867hbd
         4lDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BsASFJTY9+IbIGlounf67kcAErjxSmbfmJjiw+y7eG4=;
        fh=Q4RIqjFS3OyvQuKAgqyeFCDjke1YgvhUKle0nSwDc28=;
        b=ZPsG44selK5MILjtFPEPNTm7shgAqI7e443avUiKz4yKFLgIui59qVvecM8Z5diGBy
         CgRIK60ZT9dXMkjw1BhUiyRvM2Ld3wWvw0jAKFbACvIQtSZyrSQ3NuDtlmVnuC4Cws7z
         utJH6+jNTzg6+Clqh/FL8wHth35VcVJR19CcIihTuWRNWWAF0aI1yOfA9IWB37nbgwXV
         wOQrwelMfPAg8IKVdrAkNTkTm6bu8SamPwotQuWqxuEr0pAAxSfDxM302xMqpU/p35XH
         E+pgO2cAzbJD9WhkOu3RSuIBivu2x2ebW34Sdvfg6zhw5PVzF4zifipl2kh10SSiD6OG
         L6kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781706235; x=1782311035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsASFJTY9+IbIGlounf67kcAErjxSmbfmJjiw+y7eG4=;
        b=whOxRqH1VXNs3mFhxdajn6H/aN4KYj7InpGr17zbWIIJ7N/kpY8ynNxVXbzB3XBNgm
         c8wO5klG0hSxouPH9JzcahipbCRwtilg3WIBNcqDwXdPVH8dW32NxIzoMppG37VNTtqt
         3uwcYnf28RYaLUw7wIozfGcrAmGkoJU8aVM5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706235; x=1782311035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BsASFJTY9+IbIGlounf67kcAErjxSmbfmJjiw+y7eG4=;
        b=RDn1IBq62xmMrhBsoaxNtylJ8FZtOhjIz1gqTGbb7QdI8iAEzBhAXnYqIBTylD0Cx1
         bnaT06JC809va7AWi4wkYA1R29NvWlHYIzVPU3xYefVUJi15jluBDnmeQgwbxMsn5lmG
         VC89PmyD2XmciptYmC7HS+Jjr08PaZ9H/L05tiTnYZzK1e02+hAX28Y9qPQNFpJ6PqXz
         r+/zQwcEMojOpbUqnjj03Mo4SXxwpJDGzJTQsABOIe5rSIQq5OaePdCXYuOYev+obmKK
         iIcMd3hVeHFW1brlEJHLc0cl5Ox0aQoigfYgEPtF3OdAXFTma3v5+6bZ8GCEc5Ha0LB8
         jpqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pR1TMe0Gzdn0mN08Yp4REOxwbFuBNHQtOZSbvwPE9LgDjRTBO46aayCNzSMUw9vnwvq5WMno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXDvLXmERVxJLK8aAt746BJHzCZ/QfiHHvlj4eWE4V55HXDHB
	aLEaUf++q/SHrxJ+viaWFY3umQp5SDF4zwFb7Gcg3E+nRWAP7CJ3vNt2ZViBSZ6RKUeaT1kDUYB
	3kdANiGgbGi6Z8hxI97VbbSGbMWhes+n4FpwVPhMn
X-Gm-Gg: AfdE7ckLCiym/zbT13J8zLLku1CwmmoStnM6MPF7cT1uMMF8RI0zyLS/hBJGpfQggBt
	poRwLl8gVPvtwoyR7dPiDRR+7yH/CYJV0F/FhTqeJW+qQaDQcihC1jNNVbicixIVIZpVijJ2QBY
	KiSVCqQL9T8Dh5HnzugEFHnu3phKrvC0u71+Qk/LrF4DzlnoIP/2YO8kRFCEo3Zq5cpxFrl8uVX
	rWG/yPuHNXdz/ht6AV46bN/7Z+zjhsiPxTvTdvoNqX6FNlLQiCcax9bCWYiFpBdt5y3e+hVig==
X-Received: by 2002:a05:6a00:80e9:b0:845:2737:717f with SMTP id
 d2e1a72fcca58-84527377605mr2217986b3a.12.1781706235061; Wed, 17 Jun 2026
 07:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616220303.31552-1-b1n@b1n.io> <CAM0EoM=o+kBQNND8ViMe8bZQmFAtATav+CFMmtp1udzu+tpTzA@mail.gmail.com>
In-Reply-To: <CAM0EoM=o+kBQNND8ViMe8bZQmFAtATav+CFMmtp1udzu+tpTzA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 17 Jun 2026 10:23:42 -0400
X-Gm-Features: AVVi8CeQXDxrWnfMhd1LM_yWZOqeqMQ-64bu2UnFzcS5c8W8jDqmjX6QegYuXNk
Message-ID: <CAM0EoMmXrZ5pUAkuVScgQjPFm3-dSC03mygDm3sAaFO=TQgvDw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 6:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Jun 16, 2026 at 6:03=E2=80=AFPM Xingquan Liu <b1n@b1n.io> wrote:
> >
> > When DualPI2 splits a GSO skb into N segments, it propagates N
> > additional packets to its parent before returning NET_XMIT_SUCCESS.
> > The parent then accounts for the original skb once more, leaving its
> > qlen one larger than the number of packets actually queued.
> >
> > With QFQ as the parent, after all real packets are dequeued, QFQ still
> > has a non-zero qlen while its in-service aggregate has no active
> > classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
> > the result to qfq_peek_skb(), causing a NULL pointer dereference.
> >
> > Count only successfully queued segments and propagate the difference
> > between the original skb and those segments. Return success whenever
> > at least one segment was queued.
> >
> > Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xingquan Liu <b1n@b1n.io>
> > ---
> >  net/sched/sch_dualpi2.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> > index dfec3c99eb45..37d6a8960310 100644
> > --- a/net/sched/sch_dualpi2.c
> > +++ b/net/sched/sch_dualpi2.c
> > @@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *sk=
b, struct Qdisc *sch,
> >                 if (IS_ERR_OR_NULL(nskb))
> >                         return qdisc_drop(skb, sch, to_free);
> >
> > -               cnt =3D 1;
> > +               cnt =3D 0;
> >                 byte_len =3D 0;
> >                 orig_len =3D qdisc_pkt_len(skb);
> >                 skb_list_walk_safe(nskb, nskb, next) {
> > @@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *=
skb, struct Qdisc *sch,
> >                                 byte_len +=3D nskb->len;
> >                         }
> >                 }
> > -               if (cnt > 1) {
> > +               if (cnt > 0) {
> >                         /* The caller will add the original skb stats t=
o its
> >                          * backlog, compensate this if any nskb is enqu=
eued.
> >                          */
> > -                       --cnt;
> > -                       byte_len -=3D orig_len;
> > +                       qdisc_tree_reduce_backlog(sch, 1 - cnt,
> > +                                                 orig_len - byte_len);
> >                 }
> > -               qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
> >                 consume_skb(skb);
> > -               return err;
> > +               return cnt > 0 ? NET_XMIT_SUCCESS : err;
> >         }
>
> This looks like a behavior change?
> Ex: If the last segment failed you will return XMIT_SUCCESS whereas
> before it could be with __NET_XMIT_BYPASS, NET_XMIT_CN,  etc.
> I am not sure what the best answer is and maybe it doesnt matter. Did
> you look at what other qdiscs do? I dont have time right now but will
> later - or you can before i get to it.
> Also, you didnt add the owner of this qdisc on your to:  - maybe he
> has some thoughts..
>

After looking at what other qdiscs do, your patch is fine. But please
fixup the commit to something like:

---
When DualPI2 splits a GSO skb into N segments, it propagates N
additional packets to its parent before returning NET_XMIT_SUCCESS.
The parent then accounts for the original skb once more, leaving its
qlen one larger than the number of packets actually queued.

With QFQ as the parent, after all real packets are dequeued, QFQ still
has a non-zero qlen while its in-service aggregate has no active
classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
the result to qfq_peek_skb(), causing a NULL pointer dereference.

Follow the same pattern used by tbf_segment() and taprio: count only
successfully queued segments, propagate the difference between the
original skb and those segments, and return NET_XMIT_SUCCESS whenever
at least one segment was queued.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Xingquan Liu <b1n@b1n.io>
-----

Do you know how to create a tdc test that will recreate this? If not
either Victor or myself can help you create one.

cheers,
jamal

> cheers,
> jamal
>
>
> >         return dualpi2_enqueue_skb(skb, sch, to_free);
> >  }
> >
> > base-commit: fbc6a80cb5d3fd4ac4b56e8c9d791dd17be890c4
> > --
> > Xingquan Liu
> >
