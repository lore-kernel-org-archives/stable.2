Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCF1F8AC5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576182; cv=pass; b=IKKDIvaWQD4pohWFujvy0jdgsYEJthq5FJubXloJbDdNKTxdp8XeKy8EhXmt6yHLDvfZBEEd16XIfP9u3qSwa7rTqIvvMGx+rUpSILEDrFGDau+BIQmXuSjwTvwPT+TrJfai2q7gr9rlOFzVBkj5EePkHiGtJupgLVr6hQMp9Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576182; c=relaxed/simple;
	bh=wPGDp0xFzvJIn9srBnrowViOeb26nkD/ROvqHN414vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=KHFeBhwM9/zlxX3uJ1nDbXwBnuOPYLZYUcU0TfUgBavnz3/UyaN8sE+X5EQ+LaxL6kvpj2Y5ahEpe7AXx+a5ei2VyF19ciMsYZnPvu6P0aZm3tn3bP1JirdUO8fJR42pTAOraR+ytVQEobaZQZ/mcaBUqbbaoFiMznLXUM6uKEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=GM7yECk7; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="GM7yECk7"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8520161fdb9so3122626b3a.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787576180; cv=none;
        d=google.com; s=arc-20260327;
        b=NiWWECg0QrgwXcYLuy81c/DiJmhlfZTfWRJOHnlYboh6IRXKxmsOMr/AJTY8bOr3P7
         QjG7m7uYgRNGE5UM6UVcLnp+/wTNSijNgc+rULZb8ofTgkLXT7x+6EgNYzMTU6lPQWpD
         GzdyJbSgdx/v3uz2wXnKu1n5rY+fx+N6POlCCIZ65q6u8TkwqAU2VGkxkIDweLtWAB/I
         yFcMqZwyicmOMNfsPhhh3+AS5kiixHYi14gh6ygQpFrFqYkiiIJJH38KMZyMlhBQM8rs
         boEzWH7ZH12DVmXg85xrH4E/R656PXj53iiKU4ok0Pjlq4vY3sF4jH3J5DmT7B27HhqZ
         pQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E22WXkxi4T6k+10OkcZNfzgX2vvPSESVJ7KOY7BZeeQ=;
        fh=7eVAh1C7rB/Z7vcV6gXyXJUfHAYJA3Bdef59+YuqxAw=;
        b=phjNbDlulXItTtxupCc72JS34d6j20jZBaLQFi0R9loF9Tp0KiWVsJ8+A1BGcwPrm7
         s6rp/18ilnTguyrTicYsyojI3cQZsoI0yr/+UTlMku/pHsl2HMbzbnfmgZxJxW4QULAy
         N+EF+pmaC6roQhH9heka8/tZwKW9tPjzRs2RRLt7XV/buqAqYkd57VcNKPSr/Kgi5mTs
         jyN9CeCmEza3Rl5Hy9OYC9fjUiltDRmvbA+hQOrEAUa+YY4VcBT+Jl3GvJZNazPq2aNr
         1lk/CoCKd+46BrsfrmUEIg1dLZWyL8gkMu3IW7s4SVmtNJfrwfa2vAiIsKAB+V50AKXl
         p4IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787576180; x=1788180980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E22WXkxi4T6k+10OkcZNfzgX2vvPSESVJ7KOY7BZeeQ=;
        b=GM7yECk7SBIl7D7IRfAQ7TJN+KwMSS93mfU/N/878bI4pYBW0dE3lZzukneOKvQE5+
         5VB4mTVdRcLy5sm/z1aWB4MgSmeNcVbIRnUVPmS515SIYJ4Cae+9xRtJHj9GUrVXcCOA
         AGL4HRyJqVs3hrFGBT3G1JGt7HjGSWUpaRUjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576180; x=1788180980;
        h=content-transfer-encoding:content-type:cc:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E22WXkxi4T6k+10OkcZNfzgX2vvPSESVJ7KOY7BZeeQ=;
        b=ILEN7ZSVDOsQIH5iGx8XdU1Efz+JepvUx8OAA8WnQBHtIvGzzu0ti1TVtZaoZWA4sw
         rHOm5yA+Wv0x3QeMco5ewkvU0TBqNQjToRl+fP9I9j2d8HBOtqJi2X6wsw6nWdCGQSTQ
         4dczvd+tpOe7yCe+TYC+W++Vzi6V4wt9MtljQ5nrW+BULbz6fXQ4MZLFlh2kReYmPIMg
         10qrg6zf8aHKMpAV6S0ENNF/HnrW1w1zZLJs4cCKZwXEIUosdHRhTiZRz0X126P3rf3f
         Zifo6JWVObSQbnahMIjdYmVMRoZ6eXlbvJGTWCgg1MJHTuGK0UowFUqP9NYV0h+fs184
         fJBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIStCsX/T/9AUBEOaLZVnknYC83kEwrdPMN6lh0POJXQsNr7PkyaX4FmB+l7hh5kh6ovMKSMk=@vger.kernel.org
X-Gm-Message-State: AFuF++lw9bw1JyHKvfZDNILLuUPcgwXQSToGc2RXgVHyjf6NSefZrehM
	UAmciXWmTwr1448cQJDjd2KlWIcfiBxlJ1ebZ/sPWYEw9+qlP/PaXPUYdjzc+iPtNi8e83TsLj8
	6G25+S2dF160efajWtNkMdV/0Jb++3bVrv8biEtIf
X-Gm-Gg: AR+sD12m8KxsfTWChGuQMk01H2ggKSp30VigZi5PE/HTOY/GVPsMuJXQ2wG7BuRBlgv
	sg1bM28R0EQJwnw5V6+EnyACUCGrsh4LAwYnBGfZmIq1ScreDdqdfoNIAYP6gl0t5k3NgQfBJrn
	7rGhGnrav1q3ziu7iZ75R+neOZW3qxdIsxF/35qtdtIDq2cbIfUGGsHlcGQf0xH+cFQLWlIQwo1
	sn/16isoJeW1/sD3AF1Qum5nUTTg69oZHIKg9zfPPu0j427mBP8SISA/UxhfDfGe798VeeNaKx7
	YZvTnUAFFq6exf7xEZ+RIqGdkJ0PRdfnnktxv3K0iI1H0AlIu5LKUA==
X-Received: by 2002:a05:6a00:348b:b0:848:4424:2b8e with SMTP id
 d2e1a72fcca58-851f9a8fb96mt50666596b3a.3.1787576180311; Mon, 24 Aug 2026
 05:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821210440.102177-1-jhs@mojatatu.com>
In-Reply-To: <20260821210440.102177-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 24 Aug 2026 08:56:08 -0400
X-Gm-Features: AcwNN1UnrC5wuh0520YAt6-M3kOJmMBYENG9YcQX3co_bBNvcD_1VD7bsnD1B-M
Message-ID: <CAM0EoMnhcqsM=0yqT_auZUpETZsAFZBb=JArT2oWPT_kMe9riQ@mail.gmail.com>
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

Sashiko is right that using /tmp/u32_batch.txt may pose a security
threat. Better add it now as opposed to followup.
I will send a v3 and also add the minor change that was suggested by
sashiko for the extack messages.
The rest of the sashiko suggestions are followups.

pw-bot: cr

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
