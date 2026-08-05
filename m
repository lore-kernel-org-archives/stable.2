Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7353D3326
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952771; cv=pass; b=JKZEOQFrTS2lKXE1l6eNCGn6cpeJRVRYiXO8Tqs26I6jE4wS5783h0w6xTDybjTWZBUiX7l4AK6g5dGowA5CUqht8I7S4IEKQPhlwckJJZdraYNR4Mmraxyzm7l82dPqJ/hdZNWjND5JwJ3ldzGUtkzHbZ/BPFd/aThFfHH9JBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952771; c=relaxed/simple;
	bh=FQiUpankytKxTKHY7NyDfEfHcihzlbQLQJ2TP95U4oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTcGrwOO1j1UEPjpfyabThvv7COkTkRgxklRJCJmiZA4yLdNRoJbQK/BufIhwITTsc+E4F9ABviIgSz4w1uuomkyF9zcTEwWjQ+f3w3dFKt7hbI0daysnX7hlU0kJ1nw0Thi0ybaBrKpxPp0F74y51/XXvZGTla727nj4MeKdBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=VGRKFAqR; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="VGRKFAqR"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8484f229529so1174574b3a.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 10:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785952768; cv=none;
        d=google.com; s=arc-20260327;
        b=rfcZ8SWMGwAE1oqKlxGuhUAji3Z0F6TckhmZwgjN2zTsh55dJ8vP8b+QZiTfRPaozu
         uswsG4shq9jEvhcL7m2m2/2Q+9A9jR33Ew7hfop6pmG+uvauqjSBqKhWKBF0VBSKERoX
         HwmrCStGC9+353UUafJft3RUus4ZaQ23LjjH3RrlAUzpZKwVPsILgQ168jc8Z+RFqKnd
         Xb4L3vLIFH1rDNJZ3Je5cWb4+OlXZ5xZZkJk7KnicALTX6SGxhsEbh6SbMewTuJ6n7nn
         Fy9DwKWiiuEwTyog78iZ7CvUspwqM6/4F9FtjzPOKI5DQ4+xdT8ST8t1rfgtHxqRwWQE
         8Wbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M7jF1a+Tnblkzl0EN5L5CVmkRWVjrInbwpB8M3Jjow0=;
        fh=dL1b7L2pcqmZXca3z/DRvF1Nadsc7zyGiOUkrKO7iqQ=;
        b=Q5S6Ex+n55qJueJls61gdAH++PvlHtrds0h/2IX4EdB0bKo3XF5PjjIC+yWmVl+eko
         yOPc6vZK12dAl+IJxOpp5Z8ehAsMncKiF/lUtVox1pljXvxDA5w3W/yuwVCXETQucIv7
         Ixjua3HtrAPv5Sf4gOnLR1uRtVsAzYIjhCcSFPbzfzRs1f7n9Ooy3rHss8pMOd57K1by
         5Oc1WBNdjWpozUy6t8bsW3kyhEeENfHbL4CWYgOVVSxqUXGhD07ZR2E4fufuybQYzxoL
         Bn8CiVj5OltidR9zGjKGW1P4uc2x/UxxAs6njuwx2ornSosd7MFN4EEWZD98BozMN4xD
         Farg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785952768; x=1786557568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M7jF1a+Tnblkzl0EN5L5CVmkRWVjrInbwpB8M3Jjow0=;
        b=VGRKFAqRW/Z4nKjne4+s8eMij6oQG1KEUcybdcpYYpfCN4D6lfqw0R36lPubPIw4Yy
         /H5bsTXz3yqOSttukZQcR3bac8X8e5QUYMxCwHtniqjvcpgREAMkJxvRhD5OQq94NVL6
         yutiJlu90lTGPfIFXucfkjhRGdFbjmFoRAze4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952768; x=1786557568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7jF1a+Tnblkzl0EN5L5CVmkRWVjrInbwpB8M3Jjow0=;
        b=lfYJzFCVY5QZLFJSXo2INq9VFWAeyjBOTVEk51Vm6TnKP+YwCoCw8wxHoEFLOg7uor
         dKr1XNugW+K3FDuAWGZxNo4/Bc0bVJqykWSr8a7DnvQmPh/8c61k23ZIeDuxRyw+6iqw
         idpCWDx1NgMCcWqOkA00nU9UtQWb2/SCOhPRmIOLlv2eyjeKMGmutH2KiQe64536Avp9
         Xj4tSV6cp3gY9gI5RiXZKtzX1+ytBMuNxB/lK3oJiY58HPNm/fn7hqKTsehJdjXFnElo
         l/ObM1Lde7UWv7AaFmKT991+nsW65XnRZw0nCe2O2Yl8w2bUUqP7R3Iqb+lInBjmhgPf
         gnag==
X-Forwarded-Encrypted: i=1; AHgh+RrYYw6pnWZX0xbKAMt7/TeDspo8BdNFLWXcPbTDT9Y0x/6oaQgP9weuB5D7w753JhGqvdqPE04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWArrIafahGnAWK0RDaynuC8vVWTQvtklLNQXVujtswsq7qFUR
	aXBhPy/c5NhVdfAaWkW+4pyqXQt48kyY+3jCte2ov91zBgmFaP1ZW+4ly0gWJHuW4e4Oam0sqUe
	jHa9/2Bx42OEEKqrZh3O7I91ChWOCxd32q+CAPqee
X-Gm-Gg: AR+sD131dGsfT93mstGDOzW++npPUYYOWVdo0iUhDlKUlNKz1m1PnAQhaANnCtDDLHM
	/7TMN491YPeANKpLowFggs+RdUZmV+eq+9ZzkZV/XUw4+QZ6msV8fnMEq6GvftYYwdLDY3MGRrv
	Cx+CTFhHND4cT8xCeiUcfpX6jJuxAjI49a1v7U270dFCSY8K5eTE/TVoqxnwv1bkBjh+DTh6vaV
	3+DFzaH/RDLIAA3GJ5f256D3idhdBXk++j5AmH4Bv2EGHfzzOLAusAqZ51zT1IA84nUvWhNhUWd
	XdaiBLCM81yr2fTZPYbd3ID7rNaGJx4gcv9PnThYTBjXhg==
X-Received: by 2002:a05:6a00:3cc6:b0:847:9267:2104 with SMTP id
 d2e1a72fcca58-84f2e031753mr9496436b3a.12.1785952767790; Wed, 05 Aug 2026
 10:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805095527.204088-1-hj351016@gmail.com>
In-Reply-To: <20260805095527.204088-1-hj351016@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 5 Aug 2026 13:59:16 -0400
X-Gm-Features: AUfX_mw7KHINX7ExRnnhU-LXBcyk2KKAMoj9Afc75rGtgo1eXfQsICDF53NDjEY
Message-ID: <CAM0EoMniQBhncxxUyOVLt-EB-hwE=P93p-hS-U2ERkphmcEsLQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_gact, act_police: range check the
 fallback control action
To: hyunjungg <hj351016@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, John Hurley <john.hurley@netronome.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:55=E2=80=AFAM hyunjungg <hj351016@gmail.com> wrote=
:
>
> From: Hyunjung Ko <hj351016@gmail.com>
>
> tcf_action_check_ctrlact() range checks the primary control action:
>
>         if (!opcode)
>                 ret =3D action > TC_ACT_VALUE_MAX ? -EINVAL : 0;
>
> TC_ACT_VALUE_MAX is TC_ACT_TRAP, so kernel-internal verdicts above it
> cannot be set that way. But act_gact and act_police each carry a second,
> independent control action supplied by user space that never reaches that
> helper - TCA_GACT_PROB.paction and TCA_POLICE_RESULT. Both only reject
> TC_ACT_GOTO_CHAIN, so any other value is stored verbatim and returned
> verbatim from the action.
>
> In particular user space can store TC_ACT_CONSUMED, which is
> TC_ACT_VALUE_MAX + 1 and is deliberately not part of the UAPI value
> range. That verdict tells every caller the action took ownership of the
> skb, so nobody frees it: sch_handle_ingress(), sch_handle_egress() and
> tcf_qevent_handle() all deliberately skip the free for it. The result is
> one leaked sk_buff plus its data buffer per packet traversing the filter,
> unbounded, for all traffic on the chain including kernel-generated
> packets.
>
> Both are trivially deterministic. act_gact clamps tcfg_pval to >=3D 1, so
> with pval =3D 1 gact_determ() returns the fallback for every packet.
> act_police has no mandatory rate, so rate =3D 0 leaves tcfp_mtu =3D ~0 an=
d
> tcf_police_mtu_check() always passes.
>
> TC_ACT_CONSUMED was added by commit 720f22fed81b, after both goto-chain
> guards were written (9469f375ab09 and c08f5ed5d625, Oct 2018); neither
> guard was widened when the new verdict appeared.
>
> Factor the existing range test out of tcf_action_check_ctrlact() as
> tcf_action_valid() and apply it to both fallbacks. The helper cannot call
> tcf_action_check_ctrlact() directly because that also allocates a
> goto_chain, which is exactly what these two sites must not do.
>
> Reproduced on v7.2-rc6: kmemleak reports one leaked 232-byte
> skbuff_head_cache object plus its 704-byte data buffer per packet. With
> this patch both configurations are rejected with -EINVAL and kmemleak
> reports none.
>
> Fixes: 720f22fed81b ("net: sched: refactor reinsert action")
> Cc: stable@vger.kernel.org # v5.3+
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Two things:

1) We test almost _everything_, so to get a review - even if it as
trivial as this: Always, always send a test case to reproduce even if
it seems as obvious as this. Preferable will be tdc. But you can send
or point to an AI generated poc as well if you cant ask it to create a
tdc test. If the issue is sensitive - send the poc to the tc/netdev
maintainers in a separate email.

2) If you got assistance from an ai - please add assisted-by tag.

Same goes for your other patch...

cheers,
jamal

> ---
>  include/net/act_api.h  | 19 +++++++++++++++++++
>  net/sched/act_gact.c   |  5 +++++
>  net/sched/act_police.c |  6 ++++++
>  3 files changed, 30 insertions(+)
>
> Reproducer needs CONFIG_NET_ACT_GACT + CONFIG_GACT_PROB and
> CONFIG_NET_ACT_POLICE, plus CONFIG_DEBUG_KMEMLEAK and kmemleak=3Don to
> observe it.
>
> The bad value cannot be set with tc(8) - iproute2 only parses symbolic
> action names - so the fallback has to be planted over raw netlink:
> TCA_GACT_PROB.paction =3D 9 with ptype =3D PGACT_DETERM and pval =3D 1, o=
r
> TCA_POLICE_RESULT =3D 9 with rate =3D 0. Attach either to a clsact ingres=
s
> chain and every packet leaks its skb.
>
> Before, one sk_buff plus its data buffer per packet:
>
>   kmemleak: 166 new suspected memory leaks
>   unreferenced object 0xffff888103baadc0 (size 232):
>     kmem_cache_alloc_node_noprof+0x2f1/0x3e0
>     __alloc_skb+0xe5/0x860
>     alloc_skb_with_frags+0x82/0x750
>     sock_alloc_send_pskb+0x658/0x7e0
>     packet_sendmsg+0x1833/0x4860
>     __x64_sys_sendto+0xe0/0x1c0
>     do_syscall_64+0x102/0x5a0
>
> After: both configurations are rejected at netlink time with -EINVAL
> and "invalid fallback control action", and kmemleak reports no
> unreferenced objects.
>
> For the same reason tdc cannot express the bad configuration, so no
> selftest accompanies this patch. A self-contained C reproducer is
> available on request.
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 20d9e55f8564..fd03f6319e88 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -270,6 +270,25 @@ int tcf_action_check_ctrlact(int action, struct tcf_=
proto *tp,
>  struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action=
,
>                                          struct tcf_chain *newchain);
>
> +/* Range check for a control action supplied by user space.
> + *
> + * This is the same test tcf_action_check_ctrlact() applies to the prima=
ry
> + * control action, factored out for the *fallback* control actions
> + * (act_gact's TCA_GACT_PROB.paction and act_police's TCA_POLICE_RESULT)=
,
> + * which must not reach tcf_action_check_ctrlact() because they have no
> + * goto_chain to allocate.  Without it, user space can store kernel-inte=
rnal
> + * verdicts such as TC_ACT_CONSUMED, which is TC_ACT_VALUE_MAX + 1 and i=
s
> + * deliberately not part of the UAPI value range.
> + */
> +static inline bool tcf_action_valid(int action)
> +{
> +       int opcode =3D TC_ACT_EXT_OPCODE(action);
> +
> +       if (!opcode)
> +               return action <=3D TC_ACT_VALUE_MAX;
> +       return opcode <=3D TC_ACT_EXT_OPCODE_MAX || action =3D=3D TC_ACT_=
UNSPEC;
> +}
> +
>  #ifdef CONFIG_INET
>  DECLARE_STATIC_KEY_FALSE(tcf_frag_xmit_count);
>  #endif
> diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
> index e949280eb800..565860cccba6 100644
> --- a/net/sched/act_gact.c
> +++ b/net/sched/act_gact.c
> @@ -89,6 +89,11 @@ static int tcf_gact_init(struct net *net, struct nlatt=
r *nla,
>                 p_parm =3D nla_data(tb[TCA_GACT_PROB]);
>                 if (p_parm->ptype >=3D MAX_RAND)
>                         return -EINVAL;
> +               if (!tcf_action_valid(p_parm->paction)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "invalid fallback control action")=
;
> +                       return -EINVAL;
> +               }
>                 if (TC_ACT_EXT_CMP(p_parm->paction, TC_ACT_GOTO_CHAIN)) {
>                         NL_SET_ERR_MSG(extack,
>                                        "goto chain not allowed on fallbac=
k");
> diff --git a/net/sched/act_police.c b/net/sched/act_police.c
> index b16468a98c55..ce08f6840ef7 100644
> --- a/net/sched/act_police.c
> +++ b/net/sched/act_police.c
> @@ -128,6 +128,12 @@ static int tcf_police_init(struct net *net, struct n=
lattr *nla,
>
>         if (tb[TCA_POLICE_RESULT]) {
>                 tcfp_result =3D nla_get_u32(tb[TCA_POLICE_RESULT]);
> +               if (!tcf_action_valid(tcfp_result)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "invalid fallback control action")=
;
> +                       err =3D -EINVAL;
> +                       goto failure;
> +               }
>                 if (TC_ACT_EXT_CMP(tcfp_result, TC_ACT_GOTO_CHAIN)) {
>                         NL_SET_ERR_MSG(extack,
>                                        "goto chain not allowed on fallbac=
k");
> --
> 2.43.0
