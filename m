Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574647CA9C
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244071; cv=pass; b=G3/gB/PZ1tZogPPOQlT30ACCHV7thihOVGt9RF/r0pgdXjnKWvMz3MxayVDSNkX9tkTNw5DGft4g41eoECZDA2o8kd6o4aDYRffl+1yan/50rxu/3akdIvBSxXF8gPGbGPsy0EF7+OugvWSjhZgGqEUcSvKset9C9C95O6lR8kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244071; c=relaxed/simple;
	bh=QGoE36Oi3i1r2LKhGapVr0FhKkU1kolz900HBp826AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shzPkSLdsUl9z3QoZez9x8yLzfEhqZGOQKree+FkWxHu2QFthF76lkWZEDuFhwqPTZ36MIsy9BU60mw9Tznly+YPp9vIXDbKgfFuOw+taNe+3Rf7tbdqlIhuNT+UC1zmDHUMgnxfblvj1vvvlN6NQpyjhCoGCsIgrjteWZlWG08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=kCkfchZ9; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="kCkfchZ9"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8518d5ddaabso7618b3a.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787244069; cv=none;
        d=google.com; s=arc-20260327;
        b=JbIcNyQhleQvmyxKxy1Tm+VdZJDxSZdnVEdUqXMsqs8pH1fkT8wyq6qvZo7DvPjuFA
         P1qdgn85sUl/G8GxqMN5AwiZxa99+FujglnNq0bdRXB6O+r5Ridk1Hq70UyGEVDUssJN
         q8Xy438PtSxKR0//f1bxAltKGW1fO+xBCdvzN/LGOCK893N/NQ605+tHuB9y9Ew+U+Gp
         VE1A5glKFtHT3IJWDCFcGUV1SsML4/Zw7rZ8KGkZ6w3X2Ptt0dPzm6/qIpFrcZ3wfszE
         9RqnUk2NLvArw06PqOMqSy4NZWHGkRS5F1nE4N9DJgEoFa4WHVq/Q5isA0eBoIJMgwRn
         mElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=POqqeduVarme1JDPk/PiGoV8uXno46R5fPI2JhAIBls=;
        fh=vY4k2QRGBSEonZ7rS1ch0QyWStTASJxhdMWp2KiV0mw=;
        b=RIEw1V/2Fin/pUvHmkbw8aGZJNGws2IwIjOlhstQk9Kha8BHl92yLhdDl5ygwpu9A7
         cpEPeWpnM4ABrekJiY64E2OE8o6aOVKiaZd36x/Ibcb7VTeb+FmJ/mMLcK/YoCgJBj4Q
         deBxT39AmcEHFVyIdQdnbrFfWW2oq2/x1DFdM4rimG0UU9w2DLgYJMzh9tGWuYCl2Y76
         Yqvdmvlp3oKemGff6Au+IViUcjrvqAXSMV/7Nhgt2AtPrBKWTwHpHLskiaz5gehzEmCN
         SVSlL7Y6I5GqjReoBb5b0h8Nw4i3vNNB3vjjjOZZvEiK9T7Qx5C6CeE75bJ39ilJr5Nh
         pgWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787244069; x=1787848869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=POqqeduVarme1JDPk/PiGoV8uXno46R5fPI2JhAIBls=;
        b=kCkfchZ906cUs8f9V3cMRe0AG0mBRKvGtokchfm2GrHL3c2/hKMXzIR77exWyu1bSN
         Z5D4ln5NF8vS5OFn5vwGn3gL4cnpX83qTecwqJCYlWbMok/TcxplE2SacYHSEbxxsqD4
         bEaiT57McD7gGO95yTHy37bL0H8xffDe/M6mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244069; x=1787848869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=POqqeduVarme1JDPk/PiGoV8uXno46R5fPI2JhAIBls=;
        b=hOdAFX0/hwh3Mfbpb/L/7ics1pyV3PyKoN9JVpBuPdrl7rVSDtsXfP8h85BRXcN2Ng
         ahAUdFpTKitownFnmpHmsCmqXs6s1XKaUI1tWobWLinII2BqzFy6F0uwAM0tsXrfsty0
         wN8l0if5K/JYuqeznWBRGRI3XP45jcl2pRbeJ1xZi2Jp8oMxQE3TFPwkcKjEA6S3VUYZ
         MD//A5pJaUfA9c38n2jCK2zWfiyXvGGPj6Db64BFzpiiLFtvtrbjsxrCrPn/T1yNDpHP
         /4g8GmMlgngTtCHLLoaC3FtEXwAaR2WmMcLXcceVnLGxPECgiBWMmGeDORfUkyYrQ4pk
         XhTw==
X-Forwarded-Encrypted: i=1; AHgh+RoLB20R76FeTfFoYi6RtO8JvKsOcYV3uJxSN0oU8IzMMv/GtVvkqAV4BwePbhFtjZK6bMqQEtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2debtCnvnOSyOYci0LMYTWDKek7Ib1UHSKHDqlXTr9EZyTO1
	kmAVtdwQw03anaaqID2hRJ6qw4oGU5hIJCBYMNxjsHfr8J5eNlHCWqSV31oR5LEHAcMXTFXSKqs
	8Qb4EyFHHEBZYQe8ke9U4jBr3NicIMtD1eu7gOxd1
X-Gm-Gg: AR+sD102v3aNsRgnqfHkVLpD9s/3x1LlNLC5yQa712HpsPHdUmDa53T24d+iyursjFk
	dazES5u583qYFVxyIHFgC2/Y0/6L79dydclLqZQNnu900qY16KRPj2CbN6Q+opJOHNryHcXefos
	QmbVaSI2sXlWZq+1wHnW4QOf5JiuX7Thh8wPwY20BajL8Y+9aIfrfrTjlLGq7y0f0ywHiO8tVOl
	scC7SedaMBniGwn9VcFmg+CRtkD+0/+IPxln+IBteFifxtvLIKVmfO8nIpDk8QqYXEDWIzmNfq9
	6yGhS/XY3NpbO6RjxB2b6rKBjrQyBOdMBmep8uyiEw==
X-Received: by 2002:a05:6a00:4103:b0:845:3d82:10fc with SMTP id
 d2e1a72fcca58-851d34fe328mr24544084b3a.0.1787244068712; Thu, 20 Aug 2026
 09:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095236.68390-1-jhs@mojatatu.com>
In-Reply-To: <20260820095236.68390-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 12:40:56 -0400
X-Gm-Features: AcwNN1VPI-xd-BX-vUgpsw_tMZF4mBxFPnqUd6pa8Liyc-baUCYx0j_tD9G3DWw
Message-ID: <CAM0EoMk8WU-D_gvw=McTe6eaQyFb-Mxyaf+x1DmiCbV-hLTHSw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: cls_u32: fix duplicate handle when
 node id pool exhausted
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:52=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> gen_new_kid() tries two idr_alloc_u32() allocations for auto-generated
> knode handles. If both fail (all node IDs in 0x001..0xFFF are already
> reserved), it silently returns max (htid | 0xFFF) instead of an error.
> u32_change() trusts that value and inserts a new knode with an
> already-live handle, breaking handle uniqueness and allowing the table
> to grow past the intended 4095-knode cap.
>
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED=3Dy, CONFIG_NET_CLS_U32=3Dy, CONFIG_NET_CLS_ACT=3Dy.
> - Create a clsact/ingress qdisc on a device (e.g. lo).
> - Add 4095 u32 filters with auto-generated handles to fill the
>   entire node ID space (0x001..0xFFF) for the root hash table:
>     yes 'filter add dev lo ingress protocol ip u32 match u8 0 0' \
>       | head -n 4095 | tc -batch -
> - Add a 4096th filter with an auto-generated handle. On the unfixed
>   kernel this succeeds (silently reuses handle 800::fff, creating a
>   duplicate). On the fixed kernel it fails with ENOSPC.
> - Reachable from an unprivileged user in a fresh user+net namespace
>   (unshare -Urn) with namespace-local CAP_NET_ADMIN.
>
> Fixes: e7614370d6f04 ("net_sched: use idr to allocate u32 filter handles"=
)
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/cls_u32.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index c297d7dbcf91..13ffad47cad4 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -695,16 +695,19 @@ static int u32_delete(struct tcf_proto *tp, void *a=
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
> @@ -1079,7 +1082,9 @@ static int u32_change(struct net *net, struct sk_bu=
ff *in_skb,
>                  * handle which is used to uniquely identify the match en=
try.
>                  */
>                 if (!TC_U32_NODE(handle)) {
> -                       handle =3D gen_new_kid(ht, htid);
> +                       handle =3D gen_new_kid(ht, htid, &err);
> +                       if (err)
> +                               return err;
>                 } else {
>                         handle =3D htid | TC_U32_NODE(handle);
>                         err =3D idr_alloc_u32(&ht->handle_idr, NULL, &han=
dle,
> @@ -1091,7 +1096,9 @@ static int u32_change(struct net *net, struct sk_bu=
ff *in_skb,
>                 /* The user did not give us a handle; lets just generate =
one
>                  * from the table's pool of nodeids.
>                  */
> -               handle =3D gen_new_kid(ht, htid);
> +               handle =3D gen_new_kid(ht, htid, &err);
> +               if (err)
> +                       return err;
>         }
>
>         if (tb[TCA_U32_SEL] =3D=3D NULL) {
> --
> 2.43.0

Some of our long running tests have failed because primarily of the
tdc test in this set. Will resend with a renewed tdc test.

--
pw-bot: cr
