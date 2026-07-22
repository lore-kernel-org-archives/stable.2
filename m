Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268F2236EE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678468; cv=pass; b=kNdQtbwyUkC6L7y2NlbD2Zj+qHvDM39/CUgevKB0KXAwuBUx/2Kcgpb0UY6mRJoeOFU1KuS+tBXcxhohUfuBhB52Ui49rz/XF25y5FVuIEL27e3FOADSKSippkdjm3422sUleEKELsjQSuTU1JXtXDFObU8Z70wgzFB87K7wEqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678468; c=relaxed/simple;
	bh=zPlV3ytA9mYq182TVv8ShHtMlUg4BGn040Ng/0SYAO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSzWRUZME/rBUFimntqSpnSCPIApGTEMbzscUGjUq4MgjR6TKvItNOeG97ODilhqoWW2njScWk8LClJE+uQIDI4M30mH3bY4S6Map1/TOwJXyqFdKbYyVzgF9uGUplJOsFsNy85ZH/RVU3XXr3+QgUzawxJXOFZ/9MHmEWSlo9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBsuswPm; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBsuswPm"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c1372f84dso82506841cf.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784678463; cv=none;
        d=google.com; s=arc-20260327;
        b=oI6CuXXZff4wGaPBBCKyhsRjF866AH+AESe+YB0CrKx8y4Kvj7WleSm2CUfsRYUc9t
         XHip/Gqpu1UDh/4AVM/m8uPNah7EMsJsALZjQblUFmfY+ndRHD+wiLDji8vT6zOhEuAk
         JBZjjSEjQgIrNDhBnEpk8b9BsIXS6KTUQ5wpTtlI0xnWINotLlwooP1y9KrKah8FT5Ep
         O5ga/1M9HM+1a0z7KGZKxjsR0IUvDsXtMA1aUEtWXm9VpxU/r9+tFpLIspIHkoilyNKc
         SB9CDMygTWcvg/aZUiNBPJDl4h8bHIc5pVQrTn1UMw1khHOFUhSBzGQNv89tgclbuhuM
         VUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AlnEHI8kT91AydctQLRHbmFtJAyusQQDosMCUEGHLXI=;
        fh=xkcMkns0LSAZOZWy8yfIUQHxHNSjdFmY4zzbWYsxvkc=;
        b=E7RisCkBD2+oTV81eO2JIthLjTA3M1fTqhKRqcI/mRKG/AfLHDAjWcad3LkCRdhvSP
         kyNzAhSVwSGGv6xErCg0xgf0mE3pLSG0jLozlnYnPDN+FPGAC/6+2HIdDhwWDmYxs9Z6
         zH0FDqArTtKyPEMnBVJL9Y6TAXk78a9piTfJ0R8Ub9nmo0MFkVEgQIH9vYaWsiXcZin2
         TCYiZc3AC99Nw44ePmGoXZds20/YNvApu8IsU8BiVNRkXQrM15w0gyZHE2wY1mpSqI6S
         ePgNeQoAoW3joXPZW0pjb+7fKKdcrQfywLlS0v6GhN2mKt7UOcS7fdQx4bTyTR8JZTBG
         q3SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784678463; x=1785283263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AlnEHI8kT91AydctQLRHbmFtJAyusQQDosMCUEGHLXI=;
        b=eBsuswPm+a2QFmNq59I/Fi/2NnNcQ2SR12pF84ijjQXuVIz5rZiE78NDaqXtYP1p3x
         TdnVcQRpPrvm79xQOPyg2jnqM5DV1vnT7usJtwx5qYhFN0McFP9+RaegbUbrchAk3UK1
         Qct2A1vQi59crFaFTfz1VvdPEyj1Ap9I5PVR7LVyFqrQIyK/1lvJY9ojGMlphOLBz9WW
         pGyEaGc3Gh5a+Qz4To9//MZerbL6STKsNxt3VVBG/Cz3/vG6dV3COWkQdh05PnfFvbgq
         5KrnD3aQ9vpm45z4tGITpAwJQqu+q4r4gRIBuPQe1J4mJE34Dxi1aDcr45DZ5tmAgkFP
         WvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784678463; x=1785283263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AlnEHI8kT91AydctQLRHbmFtJAyusQQDosMCUEGHLXI=;
        b=pYnxj+iQRBqIgzlTzjTxxpkAB9q9i8v8c6QSJRtojPf5rfgztoEKyKWQv+mo+bNOGy
         /vWus2+NxbxBiPQ9fwqq0xM1S9rFH4Y5bMKcezdVyuHPnV2805klWKgBSQGYwkc3CU3x
         4OyjWPPbXN9rR23Ea2dtVSRdZJHjMKZrzDi0J1Vvvugq+7j9ree7DXWmCzGQrWAn1pcj
         Hw+KBZiBc4qzrrnrVB6jmBKq+2zX2G8DDfTPaxYZ+KVRVLFLq8YM2nu5dRrZ7RF5LHfN
         C/Y/r7zXGgf0OYY5LxG+jNho9g2o79QhiyOv2eFMy8+pc50Mr/1gU6uWAJGXmrw9B5we
         nCpQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqxcXitPYQAeLlA3wuSX2io1ErhT+vA/zVC+OB6HGRuZGSrmhh+LuEKJy+Dtt9POSVrFMilGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZhwh2QwndDEU/70ui2Pv89t0vohrgNEgAykQ8sa1kGckOcpn
	0zYu/Dyn5HwsyMhn0t2+E7WMgoN9tdNAJv4zsnpvWqg8kAz9lEITzjaSOOKF8Ib+Ml20DF/I/vx
	cu476XJ0jjHTqVzDup9SqvmwzIoYuInna5jgTbjp8
X-Gm-Gg: AR+sD1205PUQ2Jb0jVU4ursnSai/3fT0B5y/w+MorCMjOOfPTuiWUjdT8gTTkZD5NUu
	bUr80HPmGwSS0S8zBpDiBJKj5EZ+EmN/ZoPShtg4YKPdL4JQ/yV0tKD/poZ2kvuZucgCPkjSNXU
	2Y4RGlNXxryPOHlFTVcc7KZgDMLbm/pmwcJqVBiDoQjFeZS9c0WkR3WxO8MsmCpzpDVMcW4DJWb
	jzHc3PEHa2UQUHHZpjlXAOnNE9EAeqbPbLjL96Puvd2eGARAEUT3ZtDnfZkMOlznpNVNleZr2u/
	5OMehhqEdJCNdH6MrjwUFsib/WcpA2QpWMZmkfIoSo7T5cpgD7iKz6PrwNVDP+k3sdWlia5X
X-Received: by 2002:a05:622a:1b9e:b0:51c:b900:513f with SMTP id
 d75a77b69052e-5213aa6d821mr199345281cf.10.1784678462197; Tue, 21 Jul 2026
 17:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP48HfvFnArD5hDW8gCAWrp4Hz8Pbh7m3A8F6DiPtLYq45WOBg@mail.gmail.com>
 <CAM0EoMntb24oXpBW-pAYVX1WYTNnTU9eJLe-cvoiD-GGdW-Rkw@mail.gmail.com>
 <CANn89iK63bSCL3MPBQKiYEwYfioNYkvTBYVL8cavM2THQbPyhA@mail.gmail.com>
 <CANn89i+6K3TrAx0Jq_6Z+OtLBt6DhV6_dNjU5U6m6epucPzVVg@mail.gmail.com>
 <CANn89iLFBPHjjOZg5p7b=-vA++17oBLCJtGi8aJXnfJ3j67J1g@mail.gmail.com>
 <20260715114114.446841-1-qwe.aldo@gmail.com> <CAM0EoM=gikondXD5GAun3p8S_fjmUgBucD0dJriUQhJ5U48E=A@mail.gmail.com>
In-Reply-To: <CAM0EoM=gikondXD5GAun3p8S_fjmUgBucD0dJriUQhJ5U48E=A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 02:00:50 +0200
X-Gm-Features: AUfX_mxYti_u9g3TaEGTEw3d3yXuJoEdcw2O7vlKVcWTjrg4Z9P97FYbNcOSxd0
Message-ID: <CANn89iJoE1ES0P+dbsPczCwV4bkXTZGQ0YtvrHDiHgzkWtkoQg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: serialize qdisc_rtab_list against
 concurrent get/put
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:47=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Jul 15, 2026 at 7:41=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gma=
il.com> wrote:
> >
> > qdisc_get_rtab() and qdisc_put_rtab() mutate the process-global singly
> > linked list qdisc_rtab_list and a plain non-atomic 'int refcnt' with no
> > lock. This was only safe because every caller historically held the RTN=
L
> > mutex, which serialized all rate-table lookups, inserts and frees.
> >
> > That invariant no longer holds. cls_flower sets
> > TCF_PROTO_OPS_DOIT_UNLOCKED, so tc_new_tfilter() keeps rtnl_held =3D=3D=
 false
> > for it and sets TCA_ACT_FLAGS_NO_RTNL. That flag propagates through
> > tcf_exts_validate_ex() -> tcf_action_init() -> tcf_action_init_1() ->
> > tcf_police_init(), which calls qdisc_get_rtab()/qdisc_put_rtab() with t=
he
> > RTNL mutex NOT held. Two RTM_NEWTFILTER requests on different CPUs, eac=
h
> > adding a flower filter with a police action carrying the same rate, the=
n
> > race on qdisc_rtab_list and on the non-atomic refcnt, leading to a
> > use-after-free / double-free of the kmalloc-2k struct qdisc_rate_table.
> > qdisc_rtab_list is a single global (not per-netns), so the corrupted
> > object is shared system-wide.
> >
> >   BUG: KASAN: slab-use-after-free in qdisc_put_rtab+0x12f/0x160
> >    qdisc_put_rtab+0x12f/0x160
> >    tcf_police_init+0xda9/0x1590
> >    tcf_action_init_1+0x460/0x6b0
> >    tcf_action_init+0x439/0xa40
> >    tcf_exts_validate_ex+0x42d/0x550
> >    fl_change+0xddd/0x7da0
> >    tc_new_tfilter+0xaa7/0x2420
> >    rtnetlink_rcv_msg+0x95e/0xe90
> >   which belongs to the cache kmalloc-2k of size 2048
> >
> > Protect qdisc_rtab_list and the refcount with a dedicated spinlock. The
> > (sleeping, GFP_KERNEL) allocation in qdisc_get_rtab() is performed befo=
re
> > taking the lock; if a concurrent inserter added an identical table in t=
he
> > meantime the freshly allocated one is freed under the lock, so no
> > duplicate is leaked. qdisc_put_rtab() now decrements the refcount and
> > unlinks under the same lock.
> >
> > Fixes: 470502de5bdb ("net: sched: unlock rules update API")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>
> The fix looks reasonable to me. I also tested the poc
>  So:
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Same here, thanks!

Reviewed-by: Eric Dumazet <edumazet@google.com>
