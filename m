Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794785219;
	b=1GfjpAV3dVZAtbopZw3ZnQz1ydm76FWQqnhyTO4LF0923vWtPXiWFLgrIkodbbio+2H+
	 4puYtVWDeMX6s1y07kbfQMjO1kuc3h6qGn8JYFw9Sa9/ELHbQZW1zKNlm5Hkl0El//3cM
	 EnB9hyEuZQAMu/g3R/XgeiV0LWh9Rl5q8BbnBWJB24tWvOppyg/PD0qZlh3Pb63GZJ7Kc
	 4NZUEI8ou62VmMI06ocjsfDhi/MQinaxIeB7Wgsn48G/pd3Le09wsM3NAAf5KgBVVXmGO
	 SnRZJ0lRNxQq4SSXFZQ/W62Gq8lwxPe0Hq1CTO3As/gOwjk/WKeYcSkHlq5G/O6uOYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S7sUxxOjR8dG97fsnQkso2azf9gww/Gfl7/yzKc8Re8=;
	b=TGS1Z0KoG2fHEar0wUt2WaDBu80gg+4CZUDj5EElMCnB3lmBrrCprE83hhePaC1B2M4A
	 zml16b3jbQxCeeiBo7cbme/kzplqG1Pj/gi/6j09WruuqhIukzmfvDZJJ9xntQuYiL1kN
	 /Nhrhb/WN2rbg3To7eC+70Aybn3TElr9xowWBIRLVDEN8ZySJybZN/EZgmN6LqQWi8/XX
	 4vKikRollAarrofPfjKpnnscGVcsghC5UqHGPyacwXccv6AIXYfSTdnUHu8x049Aj0aDS
	 sJrnbnSljeExOfk2I3qtUnvRw8vM5kS1X7XbldCiH65qFdkJSiKN7Gw6zmjAOD+r8kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rEWXnzDK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC1606A32C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACC1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rEWXnzDK
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-886e61fa30fso1110446b3a.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:26:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794785218; cv=none;
        d=google.com; s=arc-20260327;
        b=ljDYURxZMyeDIvPeaTKB+o1RbkqYZQomjJWGQXZXHKkarPFcydfssJp7To7dAyAMEy
         Y/lPRtbZFPk0oWNQW00aXIzVOjxEmQbuouco4igWR8X61R4Un9yiRmy22G0BS07IXibO
         raROreZD8KhTRd5u8s0I8tvuCa49XdkJvPIlqRgO6fwfsLg9CWqLL391kMx1Qi4VsO/b
         lPz0AkRi2clBL7bscZVzFSzTiwviClqWPw4D0B/qcwx+AcRiEPJoKEBFxQM5RMXxFiD/
         tRNrKCXk8mRYAryUIPs7OLva06/D+0X9jLnyk38Wu2wT1k7ml1PK/I0p1K+lVa5R8RbE
         bqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S7sUxxOjR8dG97fsnQkso2azf9gww/Gfl7/yzKc8Re8=;
        fh=OUihlJUS8lPfthzmckYijWyXxLnfQO+7smBRwSZ7Euk=;
        b=s8fTsCIFB2BDlbdyUibIzCZO6hRrAwQzoL9Dgwh6JkTLwtrYNUirWyEdzRI0cEQRbM
         Rs0K4TBeL8aHKE5zPGLulILGq9W57Wo7vEZ42py/IPgmWchsGeP1rhXfSVEszXOs4PM5
         i2bCiDEFajHwgcIK57wa6I9kLE75itMzrG4iTWUecFMoUsE+7JMCApkVxRbk+8vWfSvf
         fmOwDezO/MC5rRivNx25thckKte+EFa3TIZ65fpSg9vbfQQ/hTu1kFGJlbzNCKCfGuu9
         WBfXiDICv1zrW7cWIn9XWHRzw5UQqkNXAmafgXR3Zn8tVbnLBQT/x9QE6mEaSSG3tcAC
         Ax0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794785218; x=1795390018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S7sUxxOjR8dG97fsnQkso2azf9gww/Gfl7/yzKc8Re8=;
        b=rEWXnzDK2MWC7y6VIpU145cB4rjCv0L5lm5GGhn79QDKjesIZIFdyfJZ0NRN6M2vuV
         hQPJlYXHXrl9/lwiUfrMSZsGMY5WlgyfDAPLGYi8NDPvNcBC1DK64dRbqANpJHDO/o9v
         A3cnDVs3Kbv9fDDA0m+ZVEtyICkNq/BcqQLHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794785218; x=1795390018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7sUxxOjR8dG97fsnQkso2azf9gww/Gfl7/yzKc8Re8=;
        b=NuuVnBZK3n4npGWiEH9Lz4553mNaw0UoQPYDulDm9f6LDp0WDCR9zhMZrqs9UZWr77
         Co30zO7FHPaQJpQHYCKOv3QxtkHw8XRLya33mTQPGQVJU9QH5k4BllM842tJqpWkNC+7
         TElipInHP1Mea0/viB9mVZ2x3GSh1gQ5lPa9OZb8FopIMG0uPz657t+oCNhEB9EPFb03
         4FKirGuYznkHBbxMS0Srh0819bqohXRBMsaZ5I0vEWTPXNROss7xVV3i2zsxL8R/VyzS
         efygFnovsL6NCLSa9D0CeBwE9d+lkXZOTDTKpgr7c7i73vRJU0/go5M2MrNvCb9fgYJG
         nNOg==
X-Forwarded-Encrypted: i=1; AL+hErEOK//nNiFmQ2j/o7as15pos5D7NiOEL9GFrTtUs2FeE3nFlbF6/YkctEHEF9k+M1F/HXkB/I8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y9lUiQbWL8q6hKMGYKRIgCfF1SMoZWZyW+r9ZmhQ1/jSr9a98
	+h2qhKAOax7t77PE8O5kT/il/bNQSwRiTiPxS+r80RA+boAgjW8yxsajS3DIIdhQCHaDqNvNmKd
	exyUql4KztV3RuSy9jaKc3dD5+QDYNHd2ECS7FUpa
X-Gm-Gg: AYBFou2hSr3LIS5DN7mJciY/Lt9SO7NZlzX0xWTDbby9q92S+H7WgwVpOPZ891d+TAe
	AmKLS21cNz34Cz+7k3/pupLpat64+ECJcj9ev9IbjQvoCSKiDhJnx8JUDi+RCjrkCNz20msd10R
	EZJzQWvFObIUUujd63izx7NtsVfFyFMcKku4UKqPW5hNtK6ToQ2Di397jxeQAbB1LkvZiHD1Q5y
	scQZeg3txVCJmnY8He6ic7Ya1WqWB5GYHhmBkxHV/bIcWZuyqynI9yl4Ckaebt/q/j0ZPFq5zwV
	o3VAd9ll7sZD7pJh9EhCpg7aOYuLNQS2vD9VRSqhWyRpJ6zcx1XmkNUlGS1E1nF7SbMYzMyZOaX
	nQiLE3DbWFjkn+g0NjbODAuSkakugGzREIcfhiKYmgwQv+EpDPGtYcGva37A2KHW/rB0hz6AkN+
	HVR+q8QRV8NXagSU54KtnL5R5pQyOnsbaPTYvT
X-Received: by 2002:a05:6a00:22d2:b0:878:34d7:69b2 with SMTP id
 d2e1a72fcca58-8beb7a246c3mr7580094b3a.57.1794785218099; Sun, 15 Nov 2026
 15:26:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v4.r0.20261111094338-1@mojatatu.com> <179475765049.2199510.14948882455046575190@kernel.org>
In-Reply-To: <179475765049.2199510.14948882455046575190@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 15 Nov 2026 18:26:46 -0500
X-Gm-Features: AclHuK_eTuwrE8e6HXSsCYU9ijyR2ZQyojeGZtN2xoEOB1ZZirMWjoCaM0BPz_U
Message-ID: <CAM0EoM=SAaQUa0vZnBAPeAtRpQ4FPxng1hdNbm2LqOo00FrxBw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/3] net/sched: sch_teql: unshare the header before
 writing and fix retry strip
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:47=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The fix leaves a gap: `skb_cow_head()` in `__teql_resolve()`
>   (net/sched/sch_teql.c) only runs when `neigh_event_send(n, skb_res) =3D=
=3D=E2=80=A6

I think this one deserves a respin. Will send a v5 in the morning.

pw-bot: cr

cheers,
jamal

> --
>
> net/sched: sch_teql: unshare the header before writing and fix retry stri=
p
>
> This patch calls skb_cow_head() in __teql_resolve() before
> dev_hard_header() writes the slave's link header, so that a header-cloned
> skb does not corrupt the other clone. It also records how many header byt=
es
> each slave added in teql_master_xmit() and pulls back only that many on
> retry. As a result, an AF_PACKET frame with no dst keeps its user-supplie=
d
> header.
>
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
> Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
>
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index dc21cd9704a25..3f781a3ffb41a 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
>
> [ ... ]
>
> > @@ -293,15 +293,24 @@ __teql_resolve(struct sk_buff *skb, struct sk_buf=
f *skb_res,
> >       }
> >
> >       if (neigh_event_send(n, skb_res) =3D=3D 0) {
> > +             int off =3D skb_network_offset(skb);
> >               char haddr[MAX_ADDR_LEN];
> >
> >               neigh_ha_snapshot(haddr, n, dev);
> > +             /* Unshare the header before dev_hard_header() writes to =
it. */
> > +             if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
> > +                     err =3D -ENOMEM;
> > +                     goto out;
> > +             }
> >               if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, fal=
se)),
> >                                   haddr, NULL, skb->len) < 0)
> >                       err =3D -EINVAL;
> > +             /* The bytes prepended above skb->data, pulled back on re=
try. */
> > +             *hlen =3D skb_network_offset(skb) - off;
> >       } else {
> >               err =3D (skb_res =3D=3D NULL) ? -EAGAIN : 1;
> >       }
>
> [Severity: Medium]
> The skb_cow_head() only runs when neigh_event_send() returns 0. What
> happens to a header-cloned skb that takes the else branch instead?
>
> Suppose every slave neighbour is unresolved on the first pass of
> teql_master_xmit(). Then neigh_event_send(n, NULL) fails, teql_resolve()
> returns -EAGAIN and nores is set, and no unshare has run. teql then
> restarts with the same skb as skb_res:
>
> teql_master_xmit() {
>     ...
>         if (nores && skb_res =3D=3D NULL) {
>                 skb_res =3D skb;
>                 rcu_read_unlock();
>                 goto restart;
>         }
>     ...
> }
>
> On the restart, neigh_event_send(n, skb_res) parks the skb on the slave
> neighbour's arp_queue with its header still cloned:
>
> net/core/neighbour.c:__neigh_event_send() {
>     ...
>                         skb_dst_force(skb);
>                         __skb_queue_tail(&neigh->arp_queue, skb);
>     ...
> }
>
> The usual reinjection path is covered. The skb's dst resolves to teql0's
> own neighbour, whose output is neigh_direct_output(). That re-enters
> teql_master_xmit(), where the new skb_cow_head() runs.
>
> However, neigh_update_process_arp_queue() can fall back to a different
> neighbour:
>
> net/core/neighbour.c:neigh_update_process_arp_queue() {
>     ...
>                 n2 =3D NULL;
>                 if (dst &&
>                     READ_ONCE(dst->obsolete) !=3D DST_OBSOLETE_DEAD) {
>                         n2 =3D dst_neigh_lookup_skb(dst, skb);
>                         if (n2)
>                                 n1 =3D n2;
>                 }
>                 READ_ONCE(n1->output)(n1, skb);
>     ...
> }
>
> This happens in two cases:
>
> - The dst became DST_OBSOLETE_DEAD while the skb was parked (for example,
>   a route delete that ends in dst_dev_put()), or dst_neigh_lookup_skb()
>   fails. Then n1 stays the slave's neighbour.
>
> - In the tc-mirred setup from the commit message, the dst belongs to the
>   physical device, so n1 is that device's neighbour.
>
> In both cases neigh_resolve_output() writes the link header without
> checking skb_header_cloned():
>
> net/core/neighbour.c:neigh_resolve_output() {
>     ...
>                         __skb_pull(skb, skb_network_offset(skb));
>                         seq =3D read_seqbegin(&neigh->ha_lock);
>                         err =3D dev_hard_header(skb, dev, ntohs(skb->prot=
ocol),
>                                               neigh->ha, NULL, skb->len);
>     ...
> }
>
> Can this overwrite the link header of the other clone, such as the mirred
> original still pending on the physical device or a PF_PACKET tap clone? I=
n
> the mirred case the bytes written are usually identical, but they differ =
if
> the lladdr changed in the meantime.
>
> The commit message says "a header-cloned skb is unshared before the write=
",
> but the arp_queue handoff does not seem to be covered.
>
> The later patches in the series don't add an unshare on this path either:
>
> - "net: neighbour: reinject a parked skb through a headerless output
>   device" only rewrites skb->dev for a headerless n1.
>
> - "net/sched: sch_teql: keep skb->dev consistent on the arp-queue path"
>   only moves the skb->dev =3D slave assignment.
>
> Would it work to call skb_cow_head() before neigh_event_send(n, skb_res),
> or once at the top of teql_master_xmit()?
>
> > +out:
> >       neigh_release(n);
> >       return err;
> >  }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-6HS9.v4.r0.20261111094338%40mojatatu.com
