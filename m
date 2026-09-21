Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60C4EF134
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013503; cv=pass; b=jBRa1ULamRjBCjEI2F1u/Hsqj8GkQUNcteNOh0r68JoV6uTHtW2GXP7XHLdG0/uOJM406LECkEsybG1cpOFpA+ZvABKFLh2IOIHes1o65trzF/UeZqw5HIdTiqtsSty14Aury8MkxIxpjGGrkKfPYzEhl5Wc5cKXwHl1+cEc5hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013503; c=relaxed/simple;
	bh=XVIYV9FVnMFewydRoY4sZQFy/bO7vE60jVchHBCjxBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rs9c7cl09hSYetb7XuBjLb1EM+g/FSBZwPgAepIkiFSO6TFKxd4hjbTyXXkLl+ukyc7ZJdyQgiHkdJXjY8zpxoF8C1Ll/mtGytNLm0M2wmRenqB3MJoUOTag/XGBRzBenE4Wzl/eeBz42y+FD7XOqyX2dLtgSvYyi3OWAkO1kDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=dTc3kkeP; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="dTc3kkeP"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-868cfc5c244so1741066b3a.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790013499; cv=none;
        d=google.com; s=arc-20260327;
        b=ez9hmIN1Eokds5LJCJzxXBDx9Cmtyd9slp9/tKaMAgbzHZLUKmSQsM99/sZmhRj/j1
         0WyzvNE24ER4a8yDVzgTOdBnvWOnxS39Az+koJK7SRCOh7Wng5T71pYrmoJnXb16vTNm
         /zR5K5bEhaYx6Fbq8g4j6IA4eLhIi7961LDSihXVE6EiHZo95aa5AEDw3kxWIACwqKIa
         Sp2eos56LSvuXCPO9Rt3l3m7g7C6TaO9RvEv/noWOqNmfx+qY90oyKyeG6Bum/s0DXYM
         EItXHAb+5/Ma5/Ly8nLpJik7Ktxt8mFnW6Cc48vtskoqthJH2sV+D8NuVIHmVrD+Ypi/
         2N2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFClP2GWIVn7JBUWb2z+jSETSVb0ynsKzTcWUBX9Qes=;
        fh=y2EwdWvGm9ZgCP2P0nlNAZWV3fe2vZUFuUAEuTHGheg=;
        b=IUf+mWh318fMgeH1xdOcrWEB3GjcD6czYbZsIpbakSMaKhAT4NRNF5gVMbnmh8+gNs
         FylmFPiSr0YE4o/O80WDm5iNrNCk9XwcQ7iIeYK9We7YJrqCZZ3t6eq0fqr6WkDH0/cp
         qLpLKSHa3Ups6wDBGOTK+7u0wp3nlCRXKwuEtwcOsqZmYHGb6AzPDBXN1PJXuCyk5RXC
         rjynCPZFlK5LPR1JtBrWZkIvMU/hHWEdO1ylWv7Srw/2XN5f7TEj2VGAMy3Wq1DCCecf
         stcgwxLI02fls9Euo/d0nn105pEcoCubttXmS29ZMhb1QaOn8ZHFr6Ql1SludQtW2pF1
         L4aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790013499; x=1790618299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFClP2GWIVn7JBUWb2z+jSETSVb0ynsKzTcWUBX9Qes=;
        b=dTc3kkePc238S9WB+7dCv4pIamb/iA6uGrUIsLfMaFkLq23RMaAayNFmG/OUSaQtlp
         QPw0bZNs2v43AKhxsU6UegHpe2dkLU4V3F9znzbC0M9VMsNJF3kmKhW5y4MTsMCBCUW+
         LVoEECU4XO6GsWmDT+N19VswebrRNahQQ2i38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790013499; x=1790618299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFClP2GWIVn7JBUWb2z+jSETSVb0ynsKzTcWUBX9Qes=;
        b=S7+mKyqTBdPH5gAF/od/wRqHkqCmIJdnsweNAOzSg6PZn8V9CCEXAxSjKjkN8sWcMb
         VJxG6caw3HhN1/SgNV6wbF0U5k5P5GPq+AZqpJEiCxsV0FpjjgUw1CvACeXpF991Xzbe
         Plq5zKTrZb68MI8cjDhmf13PZvtWytdX6vT4DMvp2GClSkwGePYsHaWxyuZt2MLQPypN
         tP974IFuVSb5omnu1R8OgtHcFLup8Hbo+u5J0T1e24xvDfssUL8nIQus3L3ZzSjdbMHq
         uyPkFQ5q7QeQkSwBEEwudp2nAQag1eKs7mD2XnRoPZpJCyh5qpvEMLSDdkzAX90c+pmc
         n9Ng==
X-Forwarded-Encrypted: i=1; AKwUvByNvU0NtwJnk3xwQBBfQHTufxCs+SBzVm8ceDwkr+5Qs2yMDT/a/zLdlyYdSZ6Q4c0lKq/Npks=@vger.kernel.org
X-Gm-Message-State: AFuF++kIRo0qP495dD9E51kix6bRb0NvN7ei0MVPy++++TgbxQNStREc
	qFRUJGnDL3nAsvzW+MQqm6JvEk4kJr8ME5MqBgRrjzL2TuXNcJ937ImkK8MHgFcbQwAxfIsOhCa
	gR3sVu5wpCYo3hORQ9boZ3WE7uR6O3XlLJbPxT17g
X-Gm-Gg: AYBFou2j6nNnBp+W2a8Swu+aTb9OlTLSpvgpyoBsZxzAWBz2TXWRVA4XsA1t/1wmJiQ
	Pb3Eru8BwiFmTWmO24KlFXaq4S0qgBMRd7nK7lnsEgR6YfkuQ2zu3OaeLFmiQd2APrOQQG/HuZl
	3W9i8GbymzacNaP73sNe/+lpZZgDfPDU0v44RRT1xiA+AGpP/h+bCI4wZSjSV1cXqcvWiww39wY
	5UgbJVfGg86ZzmBfUpqy94vBltcj9DkJQOf/nnuGTOe9pj8cPLw5NHc+oRAnKnqTuxijqB4Yd1+
	qKE/+Knbr3ndaIUUcI4ybfPb8F3U08LKRlURazJQ/7Sn7q5IwoiJSzVRhMuXhnNXHmyzbf/L9UE
	oWzX5B9Y4OcfhDOI4IkwvqcXKfdpfL5iW0gDGH9LzTBgXxBAA
X-Received: by 2002:a05:6a00:1ca9:b0:874:705d:f640 with SMTP id
 d2e1a72fcca58-874de20a543mr13521909b3a.34.1790013498828; Mon, 21 Sep 2026
 10:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-4CSL.v1.20260917072652@mojatatu.com> <CADvbK_e0-1JsCSMAQXGP3yxrvmtJDvG3TBShft=EfLKEGkBR=A@mail.gmail.com>
In-Reply-To: <CADvbK_e0-1JsCSMAQXGP3yxrvmtJDvG3TBShft=EfLKEGkBR=A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 21 Sep 2026 13:58:07 -0400
X-Gm-Features: AcwNN1VBdmzBlwDPWlbZg6XBeCj-MYlPDpLBOwS6X5iUNuIDd4zwM1zc1uZ0OBE
Message-ID: <CAM0EoM=u3XqrGTxyTxCbbh4fobfPv+ZFKh1LESbjgsoPh4g0rw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_flower: exact-match ERSPAN key when no
 mask supplied
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 9:11=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Sat, Sep 19, 2026 at 5:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower=
")
> > removed the unconditional memset of the erspan_metadata mask in
> > fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies th=
e
> > encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
> > TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
> > zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hw=
id
> > (v2), then matches every ERSPAN packet's values instead of exact-matchi=
ng.
> >
> > Mirror the with-mask per-version defaults on the no-mask path, keyed of=
f
> > the key's own version: v1 index to 0xff, v2 dir and hwid to their
> > exact-match masks. The mask cannot just memset the whole union -- that
> > would re-mask the overlapping timestamp/sgt bytes of the v2 header that
> > the fix (292207809486) deliberately left to 0 in erspan_opt.
> >
> > This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
> > validate mask pointer after nla_next()").
> >
> > Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
> > with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
> > TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
> > match mask is zero (wildcard) instead of exact for the supplied fields.
> >
> > Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower=
")
> > Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826025=
123.62758-1-ljp1205831794@gmail.com
> > Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp12058317=
94@gmail.com/
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Tested-by: hybris <hybris@mojatatu.ai>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/cls_flower.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> > index 1cefea571efd..f5acdeb0e2a6 100644
> > --- a/net/sched/cls_flower.c
> > +++ b/net/sched/cls_flower.c
> > @@ -1358,17 +1358,29 @@ static int fl_set_vxlan_opt(const struct nlattr=
 *nla, struct fl_flow_key *key,
> >
> >  static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_=
key *key,
> >                              int depth, int option_len,
> > -                            struct netlink_ext_ack *extack)
> > +                            struct netlink_ext_ack *extack, u8 key_ver=
)
> >  {
> >         struct nlattr *tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX + 1];
> >         struct erspan_metadata *md;
> >         int err;
> >
> >         md =3D (struct erspan_metadata *)&key->enc_opts.data[key->enc_o=
pts.len];
> > -       md->version =3D 1;
> > +       md->version =3D key_ver;
> >
> > -       if (!depth)
> > +       if (!depth) {
> > +               /* No mask attribute supplied: exact-match every field =
the
> > +                * key set, keyed off the key's own version so the v2 d=
ir/hwid
> > +                * bytes are masked without touching the overlapping
> > +                * timestamp/sgt bytes of the union (see 292207809486).
> > +                */
> > +               if (md->version =3D=3D 1) {
> > +                       memset(&md->u.index, 0xff, sizeof(md->u.index))=
;
> > +               } else if (md->version =3D=3D 2) {
> > +                       md->u.md2.dir =3D 1;
> > +                       set_hwid(&md->u.md2, 0xff);
> > +               }
> >                 return sizeof(*md);
> > +       }
> >
> >         if (nla_type(nla) !=3D TCA_FLOWER_KEY_ENC_OPTS_ERSPAN) {
> >                 NL_SET_ERR_MSG(extack, "Non-erspan option type for mask=
");
> > @@ -1509,6 +1521,7 @@ static int fl_set_enc_opt(struct nlattr **tb, str=
uct fl_flow_key *key,
> >  {
> >         const struct nlattr *nla_enc_key, *nla_opt_key, *nla_opt_msk =
=3D NULL;
> >         int err, option_len, key_depth, msk_depth =3D 0;
> > +       u8 key_ver =3D 1;
> >
> >         err =3D nla_validate_nested_deprecated(tb[TCA_FLOWER_KEY_ENC_OP=
TS],
> >                                              TCA_FLOWER_KEY_ENC_OPTS_MA=
X,
> > @@ -1607,9 +1620,11 @@ static int fl_set_enc_opt(struct nlattr **tb, st=
ruct fl_flow_key *key,
> >                         key->enc_opts.dst_opt_type =3D IP_TUNNEL_ERSPAN=
_OPT_BIT;
> >                         option_len =3D fl_set_erspan_opt(nla_opt_key, k=
ey,
> >                                                        key_depth, optio=
n_len,
> > -                                                      extack);
> > +                                                      extack, 1);
> >                         if (option_len < 0)
> >                                 return option_len;
> > +                       key_ver =3D ((struct erspan_metadata *)
> > +                                 &key->enc_opts.data[key->enc_opts.len=
])->version;
> Do you think it would be better to pass &key_ver to fl_set_erspan_opt() a=
nd
> set it there, avoiding the dereference of erspan_metadata here?
>

Sure - that will avoid some casting.
I could change it if i have to resend. Let's wait to hear from
sashiko-nipa. I have gotten sashiko-gemini feedback but it was spewing
some new (meaningless) stuff about things it was claiming then
dismissing ;-> So nothing useful there.

cheers,
jamal

> Thanks.
>
> >
> >                         key->enc_opts.len +=3D option_len;
> >                         /* At the same time we need to parse through th=
e mask
> > @@ -1618,7 +1633,7 @@ static int fl_set_enc_opt(struct nlattr **tb, str=
uct fl_flow_key *key,
> >                         mask->enc_opts.dst_opt_type =3D IP_TUNNEL_ERSPA=
N_OPT_BIT;
> >                         option_len =3D fl_set_erspan_opt(nla_opt_msk, m=
ask,
> >                                                        msk_depth, optio=
n_len,
> > -                                                      extack);
> > +                                                      extack, key_ver)=
;
> >                         if (option_len < 0)
> >                                 return option_len;
> >
> > --
> > 2.43.0
> >
