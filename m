Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C622BEFEB
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788116388; cv=pass; b=a2QThAyv8wBnYBmvw/FWglFFjawDrgQc3bxXo3BxhgzJlel19xKKb+8ivwj9VYTtSC9xfaIUYuoWKSgsS5RthU2teXxwBdbIdmPWSgiXPTuNkCB/K2fw9eLGdI6sxCUepkcqOzHwQT49Pu4DSNtBsFf+VDpdpxxTu2wBPue8FOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788116388; c=relaxed/simple;
	bh=xbpg2TRI0C42OXAMFayac9Bn6jFq7IN06oCls2Xxiiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV2zrqW+BDyxqv3V5fogMo7AfSKiUTBKFD0KdazNxoew31JspBiqciZpjZ7TZ0kQOzCSED3My9HfcwMj+FNHBxXCmEsL/gDd0j6g5Odxu2lRCwc3+ColC6gieNYOCAaEP+EwRQbCoDZC5NHsVXwsEpkzjyo/YfYCE0VcXfDQNes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=xH/AXU2q; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="xH/AXU2q"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso2419516b3a.1
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 11:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788116386; cv=none;
        d=google.com; s=arc-20260327;
        b=JBSSnrqATcLwSsGrl/IPlLGnWhZijLlxn48ExUt3aNv/dKNWHsLCiJvC8IuQXVk3f9
         FiSgrjcopgyyJpv1lm9v4vcx3ptEFv+emY4gn1LbeyqIPV1yYyBAUojiB2LZuVjs+CvK
         J6AocFashCOQJ7r2CkK2oWhXMcKkVgrxaJLlciij9Cwq1mbiOJPzYYDkgROhY2ZLcUET
         wgKNLr2BNM4PVIgLUrcJDnMhxNpH89eakrnbBp9te0DQBPfyLVa8Jpuv9uEVLLW3RB+e
         pLaKntxFlgR4flbSBCltu6Gs0hmJRAJ2iX0Ir0wli41Mko85Ho9H8WuIycsnjmrrKV7L
         qhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QbXewKwmqwNuSHKKlHe85Bu7vpV4AuPa4cAJebOCRp0=;
        fh=H3U4s9LObcbUnuvGMCWpllFkw1R2APYODpFVZY4ods4=;
        b=ejejg0H8b43+fqvReVOKPILYvQQVf6dd0JC+k+dOAZ29+j9SqF2s6V6tp+06cLv9Rh
         bubGrxTXnz0hFCwekEu5wfVHy96JCIMdYdKib259K3FQ/f4+0Anovyq7KWUUlrmpjxaL
         c6kNoRjxjrwTXK8vjxNHfFeW+7X9hkOURNmwwYusg28wM7zMwf5KnnzyYlMA1BnVbkT5
         om6KRM5ycqFBxM7kjeUWZtoSOFU+lFC4Px4aaYcEe9Mtmm4vcGafVL+dWWgwCRTnHD9t
         5ZnT/SaY9LjPl2HGUkN44zSPQskMPwhBY/Mqh2fnuzIiWarlXeXAuy5KThQE1mrACGpn
         3KvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788116386; x=1788721186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QbXewKwmqwNuSHKKlHe85Bu7vpV4AuPa4cAJebOCRp0=;
        b=xH/AXU2qd0kes6xERLoSBWaDqc/myo5emxdHzviXkOvYXNLJFcHPlH9OhRIre++Cyp
         wNpmZgiuNhjl29Tjc0OhKCCwyMNtaotJqmXiUBrODOR7KWO9x4TlJ17yhgw/M8Zgkevr
         hyflwL0B1ZIAUH6B/dNgm09Ken77mBNhnNboI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788116386; x=1788721186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QbXewKwmqwNuSHKKlHe85Bu7vpV4AuPa4cAJebOCRp0=;
        b=KqdX5VQJ5nYZ4bMC6HSrH3v6A8XOBqJ+X+k5xm6UmarjL7xjckhjDrAbDuAGRpYSc6
         IYPLTr1pTu07J6CXO4DwaKRBkibyIZzfzHwRoJ8iOS8ycEuFZj+hj+NhIM4PrfzxuKFy
         /hIVt18CEmidfGxdCTu/gCZKVmrkP7GuJ7d1MeWAyNXC2Yx1HtJOWFicjj9eZDz7EIQZ
         kkMM6CAmW/dyY4qzJ5QA2ymKwLujxqhlWxkcgRgYztVZIhDsjh5zeAIL74zMTGy+l4go
         ifI3y1pZi3Y6J3kvuXcQ3KAEEx42f22rvBY1Ym9xTDCrtFf0m7o//bbuK7z11slMRnUp
         4FNw==
X-Forwarded-Encrypted: i=1; AHgh+RoQBvz4z7a2y7IJaBjnYmAM2FSD/q1qK89A7+pGLFEwqTgorDalTuMa9vi+b2Q7v6M3nZO3KmM=@vger.kernel.org
X-Gm-Message-State: AFuF++lpWg89AFn76Q/Z3snSMR6cGxFDv7hOBh948i5W8vsaEVPanGwb
	tX7Rmb4ApYGQ85lYuIITvHv1mYmqkAnu7WjglMtkB++uYp9iiJ3U1HnWqrdv8OTJEepbWhDaRm+
	iGaCxpIJ+AcjdDVKxUCV3wLQrRTzDKjM/jWJpePpL
X-Gm-Gg: AR+sD13Re9MBSkJJkVEKsWWSNy+u/UQMNybS++DWqJrCUXXXvBMaicwd8mn6L4OBADV
	L/ZA6A9ENgp8vAJUloaeBblXutTxOwI5O08q3fMUWXdgLBTM2Qg6YWdryRVL7YsHhOrXlMVDkoI
	KcMCSXUyGsLtOUMxSV19XFIMZeyuFvTVqJdxD4izxdgk6hEfXqqfbDYvInOthUaGtqw+1/X3nFy
	DHR2EjrDUMxH8uJw9kWAwedhsz7FeS78wDRtQvOi14Ymxi5mFMq3mzgmgyvZ3CSl7UN+j/+52+k
	anwdHHuzM1G0N7B/a+EXNP79QxB5NOANE0O5zv6MeLLt2+W7qAYtkkMF93LsXQQoWuSMaYIvVYI
	+M5WBZGmZVDUsviRjQP14VuU=
X-Received: by 2002:a05:6a00:4398:b0:851:8bde:7861 with SMTP id
 d2e1a72fcca58-85994a72f67mr2596918b3a.1.1788116386341; Sun, 30 Aug 2026
 11:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829081229.81708-1-jhs@mojatatu.com> <20260829081229.81708-9-jhs@mojatatu.com>
 <20260830110317.3357a4ea@kernel.org>
In-Reply-To: <20260830110317.3357a4ea@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 30 Aug 2026 14:59:35 -0400
X-Gm-Features: AcwNN1WY7UoDBrjlFHjnDqvoutGF0gDv1OHIC7YEbWS_c6uGwqVFCgouc_47OkM
Message-ID: <CAM0EoMk6t2FB_3ewLHrh8rqnaj_ecO2L2w7BA0xRUXGJSoqJeA@mail.gmail.com>
Subject: Re: [PATCH net v2 8/8] net/sched: ets: clamp quantum in parse and
 fallback paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, vega@nebusec.ai, stable@vger.kernel.org, 
	toke@redhat.com, chia-yu.chang@nokia-bell-labs.com, 
	subramanian.vijay@gmail.com, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 2:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 29 Aug 2026 04:12:29 -0400 Jamal Hadi Salim wrote:
> > ets_qdisc_change() falls back to psched_mtu() with no floor for bands
> > without an explicit quantum. With a crafted size table qdisc_pkt_len
> > reaches ~2 GiB, so a zero psched_mtu on a headerless device makes the
> > deficit-refill loop spin under the qdisc lock.
> >
> > Move the floor into ets_quantum_parse() so explicitly configured quanta
> > are also clamped to [256, 1<<20], not just the fallback path.
> >
> > Conditions to recreate the bug:
> >   CONFIG_NET_SCH_ETS=3Dy. Requires CAP_NET_ADMIN (namespace-local via
> >   unshare -Urn suffices).
> >
> >   tc qdisc add dev dummy0 root ets bands 3 strict 2 quanta 1 1
> >
> > Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> > Reported-by: vega@nebusec.ai
> > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  net/sched/sch_ets.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > index 25fcf4079fec..6cc902a03838 100644
> > --- a/net/sched/sch_ets.c
> > +++ b/net/sched/sch_ets.c
> > @@ -83,11 +83,7 @@ static int ets_quantum_parse(struct Qdisc *sch, cons=
t struct nlattr *attr,
> >                            unsigned int *quantum,
> >                            struct netlink_ext_ack *extack)
> >  {
> > -     *quantum =3D nla_get_u32(attr);
> > -     if (!*quantum) {
> > -             NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
> > -             return -EINVAL;
> > -     }
> > +     *quantum =3D clamp_t(u32, nla_get_u32(attr), 256, 1 << 20);
> >       return 0;
> >  }
> >
> > @@ -632,11 +628,13 @@ static int ets_qdisc_change(struct Qdisc *sch, st=
ruct nlattr *opt,
> >                       return err;
> >       }
> >       /* If there are more bands than strict + quanta provided, the rem=
aining
> > -      * ones are ETS with quantum of MTU. Initialize the missing value=
s here.
> > +      * ones are ETS with quantum of max(MTU, 256). Initialize the mis=
sing
> > +      * values here.
> >        */
> >       for (i =3D nstrict; i < nbands; i++) {
> >               if (!quanta[i])
> > -                     quanta[i] =3D psched_mtu(qdisc_dev(sch));
> > +                     quanta[i] =3D clamp_t(u32, (u32)psched_mtu(qdisc_=
dev(sch)),
> > +                                         256, 1 << 20);
> >       }
> >
> >       /* Before commit, make sure we can allocate all new qdiscs */
>
> Does this run afoul of one of the tdc cases?
>
> # not ok 39 41f5 - ETS offload where the sum of quanta wraps u32
> # Could not match regex pattern. Verify command output:
> # qdisc ets 8004: root refcnt 5 offloaded bands 3 quanta 1048576 256 256 =
priomap 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
>
> https://github.com/p4tc-dev/tc-executor/blob/storage-dbg/artifacts/799938=
/1-tdc-sh/stdout

Yikes. I will resend with this fixed.

cheers.
jamal
