Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ADB33AD9B
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437125; cv=pass; b=GJUGydkBPyUrd5ZdF+lWj3eir5dG/aat7dN05B25j1Opttbwi1C8wfeXc/KjswAuBV4KeilN9RpJ2O9hV1/XQU8HPY0G5SZLv4YRM6fBxe2FRt1RsjtSGh0MLXVeYP6Qfz6TwPgw1Q6z7IAFn0SpBF2MBr4NKzimYV6aj9nn6ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437125; c=relaxed/simple;
	bh=0LQfbC28wQPqpsJLmKjizPe8zAukg2aykmojR9qN+UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=RHYnCXlMhAwH/xz9xFJMHdJ4IopXcOcfPsUy+yDbk7xO9pfaNhxybzLRtYs+VgPx+7LNYKxjVmW3LzagR3jmyfnX2QAUCXifAiy2hl+iyWLv7Uzw+iwDQWszmW6mejZk6z74J0tl47QxDWW50HHLcfH6z9T9bPOPt8mIHbUR1BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bzM87XyJ; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bzM87XyJ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1566781b3a.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787437123; cv=none;
        d=google.com; s=arc-20260327;
        b=qSTp3yWG/kO9LQneIRJbLzPQu9BYvk2TYq6n7v8s7fZ2wFKiN0DAL+OrNQ1yuDJSua
         OZkY8hCLf3ljiUqXZeGP3kP1A3Mblzg0o9FyelxhkU3LSmffrA7hyJwgUF9Xc80CyQeE
         jUL6UNqBEa/rMGK0C2+8B/4NdX03theO/JZQApOmIePo76E5vcoD8oOAY6R/C0Y2dJxB
         fZ4GM/xJama3Wy+yjyubW4w0UesQdzyKsEz4hx8PhBlc0djEaTyAGt8g/ZSIpFNw+0Yk
         2gBMKOwHgX/BuwaiFk7M2xd0eAWK3xIww03wb/g/raCIazwjch0rPbXovDpTDB8Jz6eU
         GfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WmNxAX9rZwONdZEBFOGPZvflnngYRTUDj0WyROJOYf4=;
        fh=5Xam9xhC6IVtATwF86jEJFFW/aS2oNMzgBrLxtbIzhQ=;
        b=qvYAQCKmNSxYq0s+1F3VuD6IoSA22zaIsI8PQdxX5aBzZfN8h38bk0Jk3twjLYpeFd
         pAc5Mpgl9iO1XDPfdj1iYtizUuOmwzY1OswWbQ8DWtlJCnY7yD7FenVS7Sz6N6kONDHC
         JW+J8pYcKTorUd/vr981Vgms+KQUuM7T6wwZgdUaHnExPLqqTr4XtJnWdtA9B2hktn2r
         MqQ93v6M94eIFpHGUITN5RkmRoigQpHDdzf/bHsKCko7umVVhy333K9/ntgORLMjbZYA
         X6vQNgTqBFSEJaMc73v/fKEX80/PGTXIT/avLiExcq/Xck6xKgTfIf7TMJTFVdzHPUli
         WJxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787437123; x=1788041923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmNxAX9rZwONdZEBFOGPZvflnngYRTUDj0WyROJOYf4=;
        b=bzM87XyJEkF1AZA+nHs2ypPTtM37xvdAFYhfCoRestk+W8FEGcdO3HRhoMZ9feUzpS
         DventpZkrtJuPn8ukb5y1n/G/bWtVYdB2RC5LNZFRxyijyqmyMQvbCDWQrjFB39etkGb
         R7Ceseya73YLmvDh5D1qYDIK+VgjzU4NYIjyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787437123; x=1788041923;
        h=content-transfer-encoding:content-type:cc:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmNxAX9rZwONdZEBFOGPZvflnngYRTUDj0WyROJOYf4=;
        b=SVL7XiIrXKNl3Q6uyi7R0876zKQiljLsEvrsPpNfa/8a36EFQ+ExqN+Aemt+71DB03
         kBrR38zSY4rpAWzgLFtYuT6rw/LcxmzwrlKArhZNupcN0syz9kPDIbcEtsqmPHaXJf7z
         c0eQBfOLdtaIfuF2oocTqW1GnjyMuSCOut2XUsiTxHhz37nN1ccqG5ydtuQaKC1FxZBz
         HP3/MeYyejG6vid3Rc8e4YASk8BxWLxHWLrBb5aqa2VpphR2GM1J4ERUExypTHHnJdra
         DSrJI0zDCjRTRQFq0PUz0zrYCXSZDCc0UQD/x0IWZwwbyRaqOE+GwJo0sVgojwL1ycpO
         UTBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqascBc3QuyuGMah9Ion4z6P0r2M4U+tiYqBnFtKK9rf0ET4IX+ceUT2GmGyT9/F2xuQLwf2bQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m9jYKQkbOOSpUYAjNb+kuVhpymAutgmXBFTUooViOaoQY/tcGt
	LRb9pAEyLNrQFLvIXfzcBZrr/PClL/RQgrmT5orTwdiO10+lOvUu733UDtXmK1StV64kd6H/YRg
	VX0we5b4N02ysrALTUxfKZupAUnAVhQY0Aa5KLn1/
X-Gm-Gg: AR+sD13e2YTqAuFNs2DiEQCUFMDXp9ASOn3/2Fii+Hiuv68U+9VyJ100hLBkx0puIpG
	tWAQ7Dfas8A1REc5XdZfjcTF1zEr6uBGYpjwuBxLndmd82c3o7Lz/6peblb5s3eO0/BIP4rmN5f
	zQiCmEeDeUzAFbg2KUvtzcEIPuh7TQrmKDFiox98jjMk2BKkk9rZK4i//V4VqFf6yhsu/FNrKeR
	wbK4fI2E1WXDMFWrTsg23/6NjCPc7vaC3qqB1HI34VrHMVYON9I5N4MxzZL8VbAYDdJriLCm3le
	84+D1kHFgLWLv1tIyCpwTRVZdz8azlZA3Uo4jSfTBKLfhA==
X-Received: by 2002:a05:6a00:2ea1:b0:84c:5b65:ef86 with SMTP id
 d2e1a72fcca58-851fa060bf6mt23281275b3a.17.1787437123342; Sat, 22 Aug 2026
 15:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821210440.102177-1-jhs@mojatatu.com>
In-Reply-To: <20260821210440.102177-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 22 Aug 2026 18:18:32 -0400
X-Gm-Features: AcwNN1Ue9yrwnAijOx9mYt5ITN_nYW6q7b8xdMODatpKeMx-A4D8fCPHL78flmY
Message-ID: <CAM0EoMnYEkK1LAq8tQ-cZQSvB2kaDxs8v6GXHZoxW7AG++=FYQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: cls_u32: fix duplicate handle when
 node ID pool is exhausted
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, stable@vger.kernel.org, 
	vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 5:04=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> To: netdev@vger.kernel.org
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: vega@nebusec.ai
> Cc: Victor Nogueira <victor@mojatatu.com>
>
> gen_new_kid() falls back to returning max (htid | 0xFFF) when both
> idr_alloc_u32() ranges are full, instead of reporting an error.
> u32_change() trusts that value and inserts a new knode with a handle
> that is already live in the hash table, breaking handle uniqueness
> within the table's node ID space.
>

Sigh - my scripts screwed up;
i was wondering why i couldnt see this in patchwork or lore and its
because i didnt send it to netdev.
I will resend and prefix the subject as a resend

cheers,
jamal

> The handle was never reserved in ht->handle_idr, so every later error
> path that does idr_remove(&ht->handle_idr, handle) removes the
> reservation of a different, live knode, which is then reused =E2=80=94 on=
e
> failed add compounds into further duplicates.
>
> The 4095 limit is per (table, bucket) =E2=80=94 ht->handle_idr is per has=
h
> table and the range is derived from htid (bucketid), so a table with
> divisor 256 can legitimately hold 256*4095 knodes.
>
> The sibling helper gen_new_htid() has the same silent in-band failure:
> it returns 0 when the tp_c handle pool (1..0x7FF) is full, and
> u32_init() publishes the root hash table with handle 0 without
> checking.  Two root tables with handle 0 alias in u32_lookup_ht(),
> allowing cross-tcf_proto knode add/lookup/delete.  Add the same
> exhaustion check that the divisor path already has.
>
> Return an error so u32_change() fails with ENOSPC/ENOMEM when the
> node ID space is exhausted, and so u32_init() fails with -ENOMEM
> when the hash table ID space is exhausted.
>
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED=3Dy, CONFIG_CLS_U32=3Dy (or =3Dm with module loaded)
> - Create a clsact qdisc on a device, then add 4095 u32 filters with
>   auto-generated handles to fill the node ID space for the root hash
>   table (single bucket). The 4096th auto-handle filter add triggers
>   the duplicate handle (fh 800::fff reused). Reachable at Level 2
>   (unshare -Urn, namespace-local CAP_NET_ADMIN).
> - For gen_new_htid: create 2047 u32 proto entries on the same block
>   to fill the tp_c handle pool, then create one more. The root table
>   gets handle 0 and aliases with other handle-0 root tables.
>
> Fixes: 7801db8aec95 ("net_sched: avoid generating same handle for u32 fil=
ters")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1 -> v2:
> - Commit message: removed incorrect "4095-knode cap" claim (knodes is a
>   liveness counter, not a limit; 4095 is per (table, bucket) via
>   ht->handle_idr/htid); reworded to "handle uniqueness within node ID
>   space".
> - Commit message: added IDR-desync paragraph (max handle never reserved
>   -> erridr removes other live knode's reservation -> reuse compounds).
> - Commit message: noted ENOSPC/ENOMEM both reachable (idr_get_free/
>   radix_tree_extend).
> - Fixes: e7614370d6f04 -> 7801db8aec95 (duplicate-handle bug predates
>   the IDR conversion; e761 only added the IDR-desync consequence).
> - Added NL_SET_ERR_MSG_MOD(extack, "Hash table node ID pool exhausted")
>   at both gen_new_kid() call sites; bare -ENOSPC -> "No space left on
>   device" was confusing.
> - Folded gen_new_htid() exhaustion check in u32_init() (Sashiko nipa
>   main-1-0): same silent in-band failure pattern =E2=80=94 gen_new_htid()
>   returns 0 when tp_c handle pool full, u32_init() published root table
>   with handle 0 without checking, causing cross-tcf_proto aliasing.
> - Renewed tdc test (v1 tdc failed in long-running sweep, prompting v2).
> ---
>  net/sched/cls_u32.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index c297d7dbcf91..1a72817bd449 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -370,6 +370,10 @@ static int u32_init(struct tcf_proto *tp)
>
>         refcount_set(&root_ht->refcnt, 1);
>         root_ht->handle =3D tp_c ? gen_new_htid(tp_c, root_ht) : id2handl=
e(0);
> +       if (root_ht->handle =3D=3D 0) {
> +               kfree(root_ht);
> +               return -ENOMEM;
> +       }
>         root_ht->prio =3D tp->prio;
>         root_ht->is_root =3D true;
>         idr_init(&root_ht->handle_idr);
> @@ -695,16 +699,19 @@ static int u32_delete(struct tcf_proto *tp, void *a=
rg, bool *last,
>         return ret;
>  }
>
> -static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid)
> +static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid, int *err)
>  {
>         u32 index =3D htid | 0x800;
>         u32 max =3D htid | 0xFFF;
>
> +       *err =3D 0;
> +
>         if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max, GFP_KERNEL)=
) {
>                 index =3D htid + 1;
> -               if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max,
> -                                GFP_KERNEL))
> -                       index =3D max;
> +               *err =3D idr_alloc_u32(&ht->handle_idr, NULL, &index, max=
,
> +                                    GFP_KERNEL);
> +               if (*err)
> +                       return 0;
>         }
>
>         return index;
> @@ -1079,7 +1086,11 @@ static int u32_change(struct net *net, struct sk_b=
uff *in_skb,
>                  * handle which is used to uniquely identify the match en=
try.
>                  */
>                 if (!TC_U32_NODE(handle)) {
> -                       handle =3D gen_new_kid(ht, htid);
> +                       handle =3D gen_new_kid(ht, htid, &err);
> +                       if (err) {
> +                               NL_SET_ERR_MSG_MOD(extack, "Hash table no=
de ID pool exhausted");
> +                               return err;
> +                       }
>                 } else {
>                         handle =3D htid | TC_U32_NODE(handle);
>                         err =3D idr_alloc_u32(&ht->handle_idr, NULL, &han=
dle,
> @@ -1091,7 +1102,11 @@ static int u32_change(struct net *net, struct sk_b=
uff *in_skb,
>                 /* The user did not give us a handle; lets just generate =
one
>                  * from the table's pool of nodeids.
>                  */
> -               handle =3D gen_new_kid(ht, htid);
> +               handle =3D gen_new_kid(ht, htid, &err);
> +               if (err) {
> +                       NL_SET_ERR_MSG_MOD(extack, "Hash table node ID po=
ol exhausted");
> +                       return err;
> +               }
>         }
>
>         if (tb[TCA_U32_SEL] =3D=3D NULL) {
> --
> 2.43.0
>
