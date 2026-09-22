Received: from mail-pz2-f16.google.com (mail-pz2-f16.google.com [74.125.228.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB642640D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109863; cv=pass; b=TExyAXKmR6TxUHNUFqUilhMvZZHSIgBYOA09gac9z1nrvr8PVbyIwnORoXTgpQH4RBbAUB1ial+XlecIN1VB2em+Cr45Wc28Ki2wdF9FBi6HPzjvr3q+ViE+Be05M4x+14BXvm0BMGrT6ldJT0D2duf0CJOz+nmD+7W0EjDu64o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109863; c=relaxed/simple;
	bh=P+lcMuK5hQh5O0IlQrlqy9m+daoCKm3PxvImyC7y6p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5g/XFUslzMpfce3WrfCq2YTSHk3juK3ZygQSuSJ55nQqvFb3RWViQIkFvppNvFJDDg+CsE+34aUwawP9ZzhjTun4wMOF9XYKqWHbS23sQyiJXBY0SpuvCRx0ys6G6FmZrem1HbI8Sl/BT7Pa/+FnX78vcuHtwUI4eSJxEYeTKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN3AtHDp; arc=pass smtp.client-ip=74.125.228.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN3AtHDp"
Received: by mail-pz2-f16.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so193223a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109842; cv=none;
        d=google.com; s=arc-20260327;
        b=mZzshN31hgOjioPW5JYfuE7+gHUU3X9OP47p6bWBmXSqaL2DFBDxmZzeBcb1oYJ9o5
         u08uJxb2qqDE2EkKXsbNuttW94wUeKktRg7X3IAydWiEGIa2hHkoSOogmA8azAty111N
         3yj7+8BMWSQ4BJFvwdnlLbj6Y/LyuvobZas6L6ztE5FwIaSD4hjEY4zRTcBhWx9qSC58
         HQKSaBQMjrSaXHolz2jyu0oROYngLaIKq+W2d55U1279+ZIb9D1lAKt6p4ChK+S7iWXd
         eDNULnkFxmIPCPRfw3Hg1OhDF9DEc2uAOEh3dsPEoxRexejFW1LUeRyPqXafwGWbKj25
         E8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9uOUnWBMatAL9szZ+HFkI4Lili+9ziWjf14eBlgXmc4=;
        fh=N9E08ZqYWJTyAwqr/OiYqZ1SwtSM8INMWAknFxBfd+0=;
        b=rcD9j3Kn2+K5jkd/ddgojhMkw+s5f+HAuW46JBWLjQqY6iXBPuj15PV00GSIRZAqF6
         0E+ScnKcVU4mxhYtTLMacVSxITyLdfZBqkPnE5d6GgzkYyti3ezopcgx6v29Z4qXe5wc
         n5OPVdtdmQ12+xsJ6chGaTkymfTv+JZeTKNeU/T1TgOxcshS8bpvcAPpjjMiWhVlvHQk
         5/COT2xw3TG+aQ+hmPplN/nQ6am8m6rPQ9nlwNnq+hKBiLLJ26dYlabCnwOh+OoPSlNv
         txLc7upZrnbePzDwKj+wYl1i+1OLgKJllslf3v3K2s0hrBMtDJS5a5Uc6gmyl9SdsoVM
         xOTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109842; x=1790714642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9uOUnWBMatAL9szZ+HFkI4Lili+9ziWjf14eBlgXmc4=;
        b=kN3AtHDpVGwD+cwN/jEw0l059yxgDsYK/hwZ+xBcqWCvp/+PVZH8oiBYiOH9R+Xiwm
         shE9VjxZEllX95TKkzPfgAtVsJBVqe7g3antDH+WhsalUsopqvTIgrmPo9AUKi2SucYn
         6N2sHsFmhe290cp9GtygvUG9DOuBrqFgQhA5sP7g2edfEq3Rdj1BVm6Wgs96JRev4T69
         Sygz6yfy3MEAfBVxoXEyg/q9UQJoA9xuBnjY9qash4Hqznh6YpPTlYT9BTM0OHSVK9g3
         6T0nWp9czZq35/P26b0M2egkhf+RYRKxXOZLqWxvU9NXhnZplRaoEryIMmuFugH6laF0
         1UeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109842; x=1790714642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uOUnWBMatAL9szZ+HFkI4Lili+9ziWjf14eBlgXmc4=;
        b=jQxPEGv3jP4DehFmGXANQRyfkiX+n2W2sMQkMriVeh5MKBBRjXsKxZbvb2B2YCW95g
         7Wvfgd3AHvNW1lfFn4UzbUPx/2S9oaZ098PCz1pIcCeFli5cTir5NlMdx+Y7VmWvi1s8
         VSRK7x9YtsicFSAqxjA+oqlIUuI+XGq7rJXxuL14TnD4d6Gs8ZFhvZfP5p2cgnD9jMB1
         Ppy4WF1tyr/zM8VT7j3ggPjni4wYqKV0PFFMta7/TZnsVathE0g6oFUgW2QYDOLByKwQ
         cYsjbsb60pOIikkix6bUUESEx7fTKQeEtpVlSCKzlbqjw4+rcwu4ISxl53H9+LOVPp1s
         SIuw==
X-Forwarded-Encrypted: i=1; AKwUvByWVg8xYRD9wF0gjGsnElCJE2qMld0S13+n4pglIf9+FMll4vjaiVwojrE5cXW0xz4dpvhpE/E=@vger.kernel.org
X-Gm-Message-State: AFuF++maw8cL88CXwItuPBSdbLS4TUjth9eSy4SltiOWcjc6SAvZiuMY
	6NGjlpyyK28ku3BnUcl9KW+F9ndacmILAeJpDo6bH/gIHWi4dfn6TBqo+OOtZWh/o53dC08stJi
	h64hWBf0+JBAdw8MniwfhxCiyOPK3nQw=
X-Gm-Gg: AYBFou3AyWDkab/rrV2zh2PAiF+ENkBtwVbqqofQHy0Us8JNqOiHshs+F/OHMZaOjaV
	nqDBzJH+TeuVUGR/L8jBXtlL7LeZLGkrsYkbeIxajqwQ9CkGoRStB+P1rb+IpVRGBx1TicIla0y
	9Ji+mOWi/4gWymJiSUdwSimrbN61r1CiacEp7EaKzsqZYtP8R98wEm403g74RRrlbaaLYPJ/akQ
	cZmavE8V1L6bHrSGAuh7tPxvaASkewCU0qcQkWtcjLdMTKAQlB6YGwdEEq8kuiiXSx+VwoaRt3O
	hN+UP7quVghq8oM6M0fClpUT3VwZLOaT5Z1QrpNkrHU8zU0cm046FOklLyzQEUV6Opmq60p6ZBt
	o+TiO8tlMaSh7udXBb1AEMdY/ZYqpfC+Oyeyj5Rq5mBRmPDPFApLsB26NtaKSuvCK
X-Received: by 2002:a05:6a20:7293:b0:3dd:85aa:4527 with SMTP id
 adf61e73a8af0-3ddf82adf58mr565061637.34.1790109842514; Tue, 22 Sep 2026
 13:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-7-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-7-i.maximets@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Sep 2026 16:43:51 -0400
X-Gm-Features: AcwNN1Wxvg5q08SpmktKVndNHz2CGqilUY2VDTceI09JMLfUxf8v9o9CPku839U
Message-ID: <CADvbK_es1LF3eAnX2iTfZKeCxWFOt8cux+9F8E9OSN55SQuc-A@mail.gmail.com>
Subject: Re: [PATCH net 6/6] net/sched: act_ct: fix helper UAF due to
 extensions realloc
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org, Axel Mierczuk <axel.mierczuk@1password.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> While calling the helpers, a raw pointer to the extensions area is
> wired into expectations list:
>
>   -> nf_ct_helper()
>    -> helper->help()
>     -> nf_ct_expect_related_report()
>      -> nf_ct_expect_insert()
>       -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)
>
> In case the connection is not confirmed yet, more extensions can be
> added afterwards with *_ext_add() calls reallocating the extension
> space and leaving the now invalid pointer in the expectations list
> that is later accessed while removing the expectation.
>
> Make sure that helpers are called at the end after all the other
> extensions are already added.
>
> Note that the helper rejection now leaves the mark and labels set,
> but that's not different from how the NAT was handled before or how
> the mark and the labels were handled on confirmation failure.  And
> there are no atomicity guarantees provided by the API anyway.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/sched/act_ct.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index f62051ec9d57d..411e3dd92d072 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1102,19 +1102,25 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *=
skb, const struct tc_action *a,
>                 }
>         }
>
> -       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
> -               err =3D nf_ct_helper(skb, ct, ctinfo, family);
> -               if (err !=3D NF_ACCEPT)
> -                       goto nf_error;
> -       }
> -
>         if (commit) {
>                 tcf_ct_act_set_mark(ct, p->mark, p->mark_mask);
>                 tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
>
>                 if (!nf_ct_is_confirmed(ct))
>                         nf_conn_act_ct_ext_add(skb, ct, ctinfo);
> +       }
>
> +       /* Run helpers for the connection if nf_conntrack_in() was execut=
ed
> +        * or if we're about to commit.  This has to be done after all th=
e
> +        * extensions are already added.
> +        */
> +       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
> +               err =3D nf_ct_helper(skb, ct, ctinfo, family);
> +               if (err !=3D NF_ACCEPT)
> +                       goto nf_error;
> +       }
> +
> +       if (commit) {
>                 /* This will take care of sending queued events
>                  * even if the connection is already confirmed.
>                  */
> --
> 2.55.0
>

Reviewed-by: Xin Long <lucien.xin@gmail.com>
