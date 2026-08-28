Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15D40B11F
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914977; cv=pass; b=meKx7OJPisWkM8tV5C9TZVD08HWsV+bTKhwUam1OvqmSnihD2lcd1SfCDncmk9ob9bnMdwsTFVyDOl0vYtobLLvfiNtFEBwCOKYK77ry8RKpKUyiyLvt1u2pgDorZkHYTbKnQX2TS8WKQSIqko/cSQksahb534Jdao34VjKiWmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914977; c=relaxed/simple;
	bh=gpIFjKFqNx1M+mi/+eHtLwGh46kv7Jb2uCc+Wo5YwJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a35fAkJq9U0+JSVNZKKfsNdBbYYx2oFL36UHWAin4CuRnbRRO24C6Fy9QKFLKM/DJEq3H65w8131xw3X6jfpWwzFbbV0eMUHQIK94SlvsnNg950/pAzhe3oidz3ZpPhd34BqqwoPxFQWY+MPMc08nJFn7DYSnaxl4koEf/SgGLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WRZGJ8/g; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WRZGJ8/g"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-85590c5aeabso823193b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787914968; cv=none;
        d=google.com; s=arc-20260327;
        b=p0AHhEQkx5forQAWGYDklfjddvEbJA017f6SG33nXnKLsqUZQkHekS5808W5IRdZ2w
         0NAZ3Q9t/m4PDI1NdwbdVthTcJeunwZ8gXNFOBJil8VmZ/z8b43Bx6kT98Dm6xj/XqwO
         OOgNYMvK+MFCwz0Udgjfc228G6hHR91YXWa5J2n6nUg7Vo9BDiW7nN7vFSP9UCtsd26K
         Z4KBSNed2EPhJT32Va783ws8rIlbP6eVEfFSM4sdjCew8SW1sROODAvNDebL5j7l+jqr
         IhKAznb4jKG2iARViXAk0MI6eIN5VIxTcn+8FuzAEBlEr/7Xf7rF2MHMni8QTANRz/kr
         ODwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZPn2t55uUQtWn+e2wBwLty86elpm5h5HddwIpEVEuo=;
        fh=Pz88RF1nkG4E8RjQrJWkvtWvS0kHFH1f3FVyb9JJjxs=;
        b=IX49Fc0MVk2RWrOKfbDFM4GfPkHaaHNRISlMuBXWeOMpwbmcSfJAVb43bdBq3t5RTk
         vo1gJFsqfIngBDycRETE+Xq0UQVb6utsu4kzJJqX5FDytMVXZrvWPHyUBiKsl85oUotM
         AgJSxQBSP+WXjnvHuYzJTU7SKVDV3B9bJrMYCbAMxcHqWwrCIyD5c9ULls8uENEDM1Zb
         UOsdYPbtE4WqpTks/yb1yG744hrHyVeDIW+yOv5zUoGHJP/GSxkNGgVmd+EfWYmBLRIv
         Jr8kmpJW8mVSIPTihoYg7osu2X74wBO8MEpewS+uWujTfQbrFaVvkYRccJBB9jjdgkAf
         44ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787914968; x=1788519768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GZPn2t55uUQtWn+e2wBwLty86elpm5h5HddwIpEVEuo=;
        b=WRZGJ8/gcka8NUDEyA+2dEH/XLCPmftiaHvV1tN0deaScZMbEDe+Ypofa7CVBhOWLg
         dzyzAiY3ta8yi1n9sSiwWm1QCbTVgh6Rz52nMD5L2Kh2n/1NOZIaw164uDEbzuIoDBik
         vidrr8q/AEjknX5L7fXKt45O/hma/0wL5ZZEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787914968; x=1788519768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZPn2t55uUQtWn+e2wBwLty86elpm5h5HddwIpEVEuo=;
        b=Wca7DFu4WtAacNGTl5MQiw2zMG1uvwponbkR5NL5afq3ChsZ+NliyYozzgL0sc2gkE
         9m18Oy1Bg18nTHOvBQuuLYG5x3qva889+mXHLeTI7JI9RLFVIQJFPk/EUFctiGQ6gRDS
         FOjpcQ+/nGtig5vn1jMjUtevuZj7buaRbMDA5sBDTclxIIILm7lZOUuVqsYVEusSHJYC
         9xEXKi4pKLlGi96yVp7b3JvI1LLvMDEZgGjefZ5nzMpKgKqnwa+eNB3+CY0/LoblkE9Z
         ZxhLuF5ZCfoCjMJEHPWaDPsX+xnRpuG8FEw83kE7uGDT23SCxkNUR+/6hDz5gneufoRU
         2nZw==
X-Forwarded-Encrypted: i=1; AHgh+RppRyHsIP25rWpkNTCfP0EtimwWLOI724nBu0470n/JRWubm3ITUVZUp+AY6Pw7zPOr+OZ47hc=@vger.kernel.org
X-Gm-Message-State: AFuF++miC2l0zH9HN5FO4/yS0sVh/ojoo6tdvrUOS1levsadBlt3zFsX
	esXAmTiEoCIOP0EeDhM+nqxZi/M00V8PKOcQq5QMNKzopJVlU8BxsRf61EmGXkku9LFbUwXqc6j
	fKY2nrcA1+5WPyRW87rJLnDsfjI473vCOaUi27xAv
X-Gm-Gg: AR+sD13lIN+gR43JNj21Qi9X9QD4s8SErLNHXXDVNMmuot2VSCXAV7Iiasbcm9Zej+o
	DgNAQnZ/r72CGiaTTVugffaZ92fRBbl8/LfeAd4aW/D1/wqNLtJwudNTR3IARZs6tmodLKnhJcr
	hB0lJUk0wGNbt1vMOj9Tb/iEKubCqssbE3/RwWDxgy9J1ZTuVIvMdblYXUdDNIoBkjmiTchb2i1
	9ZBH8CXzqbl8CFGF/Qt4ukxcyjUI9wARrHtIeIFhE4226SW/+fP7LxWiFYU5Jpd2Rtd4IHru7K+
	ffuft79wsK39OEYFjPt+Cjbufyxzgi06GJB3FWxad5uPU8Da/KlO4dQBtapr5cgxLK3tQ774I6k
	mZBH705yGb//kRnS1azpr3OpgJuc=
X-Received: by 2002:a05:6a00:f04:b0:848:2c2e:c79e with SMTP id
 d2e1a72fcca58-8562b498507mr13806728b3a.12.1787914968372; Fri, 28 Aug 2026
 04:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825081751.134086-1-jhs@mojatatu.com> <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
 <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com>
 <38a2e111-799f-4c8c-b46b-501999f71e52@redhat.com> <CAM0EoMnV66aObnjNJg-FLbvXaE21b1_K-yOJ1s==+z+xj5RnEg@mail.gmail.com>
In-Reply-To: <CAM0EoMnV66aObnjNJg-FLbvXaE21b1_K-yOJ1s==+z+xj5RnEg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 28 Aug 2026 07:02:36 -0400
X-Gm-Features: AcwNN1VoHD5i7PF84EaS3zQlKqco2v_CfCqD7w1P9-OmJDzCtP7wO0_FbEQP4Xs
Message-ID: <CAM0EoMkXybVnrmic2NDfRR_U=MyQo9UwNJqxhnSqaydU0wPzmw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring
 and account to memcg
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:29=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Aug 28, 2026 at 2:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 8/27/26 7:39 PM, Jamal Hadi Salim wrote:
> > > On Thu, Aug 27, 2026 at 7:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > >> On 8/25/26 10:17 AM, Jamal Hadi Salim wrote:
> > >>> pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
> > >>> ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
> > >>> bound. An unprivileged user (via unshare -Urn) can set a huge
> > >>> tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
> > >>> memory, causing a system-wide OOM.
> > >>>
> > >>> Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
> > >>> in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
> > >>> Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
> > >>> via extack whereas for the resize path, the error propagates to
> > >>> netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
> > >>> the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
> > >>> are charged to the allocating process's memory cgroup.
> > >>>
> > >>> S16_MAX is the virtio virtqueue size limit: the virtio specificatio=
n
> > >>> stores the queue size as a u16 with a maximum of 32768, so 32767 is
> > >>> the largest tx_queue_len any in-tree driver can meaningfully use.
> > >>>
> > >>> Conditions to recreate the bug:
> > >>> - CONFIG_NET_SCHED=3Dy, CONFIG_VETH=3Dy, CONFIG_USER_NS=3Dy, CONFIG=
_NET_NS=3Dy.
> > >>> - Unprivileged user in a fresh user+net namespace (unshare -Urn).
> > >>> - Create a veth pair, set tx_queue_len to a huge value (e.g. 500000=
)
> > >>>   while the devices are down.
> > >>> - Attach mq at root, then replace each child queue with pfifo_fast:
> > >>>     tc qdisc replace dev veth0 root handle 1: mq
> > >>>     tc qdisc replace dev veth0 parent 1:1 pfifo_fast
> > >>>     tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
> > >>> - Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_ar=
ray
> > >>>   rings of tx_queue_len entries (~12MB per qdisc at QLEN=3D500000).
> > >>> - On the unfixed kernel this exhausts global memory in ~28 iteratio=
ns
> > >>>   on a 2GB guest -> OOM panic. On the fixed kernel the oversized
> > >>>   tx_queue_len is rejected with -ERANGE.
> > >>>
> > >>> Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
> > >>> Reported-by: vega@nebusec.ai
> > >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> > >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > >>> ---
> > >>> v1 -> v2:
> > >>> - Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE)=
 (Jakub)
> > >>> - Changed cap from 65535 to S16_MAX (32767), matching virtio's
> > >>>   virtio16 ring size limit.
> > >>> - Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_M=
OD
> > >>>   already prepends KBUILD_MODNAME).
> > >>> - Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
> > >>> - Fixed tdc teardown to use JSON list form for acceptable exit code=
s.
> > >>> ---
> > >>>  net/sched/sch_generic.c | 14 ++++++++++++--
> > >>>  1 file changed, 12 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > >>> index ef2b4bf51564..eb5c0d3f67c2 100644
> > >>> --- a/net/sched/sch_generic.c
> > >>> +++ b/net/sched/sch_generic.c
> > >>> @@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdis=
c, struct nlattr *opt,
> > >>>       if (!qlen)
> > >>>               return -EINVAL;
> > >>>
> > >>> +     if (qlen > S16_MAX) {
> > >>> +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > >>> +                                    "ring size %u too large (max %=
d)",
> > >>> +                                    qlen, S16_MAX);
> > >>> +             return -ERANGE;
> > >>
> > >> Sashiko noted that setting a large tx_queue_len to a down
> > >> interface gives an inconsistent behavior:
> > >>
> > >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081751.1=
34086-1-jhs%40mojatatu.com
> > >>
> > >> (all other comments are IMHO noise and should be ignored)
> > >>
> > >> I don't see and effective way to avoid that, short of falling
> > >> back to v1, WDYT?
> > >
> > > I changed my mind on this. See this thread and let me know what you t=
hink:
> > > https://lore.kernel.org/netdev/CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNm=
EevLu=3Di=3Db+xKg@mail.gmail.com/
> > Whoops, I missed the last message in such a thread. I think it makes
> > sense and will cover all the sashiko-reported concerns. You can probabl=
y
> > also additionally get rid of the old test:
> >
> >          if (new_len !=3D (unsigned int)new_len)
> >                 return -ERANGE;
>
> Good catch; that check becomes dead once the S16_MAX cap is in place.
> I'll drop it
> How do i "withdraw" this patch? Is it sufficient to say:
> pw-bot: cr
>
> Based on what you said to Victor: Should i keep GFP_KERNEL_ACCOUNT or
> make it a followup to net-next?

Ignore this part -  i am not going to make any changes to pfifo.

cheers,
jamal
> The tdc test patch is still valid.
>
> cheers,
> jamal
>
>
> >
