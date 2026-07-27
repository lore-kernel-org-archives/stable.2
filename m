Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BC411F91
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157320; cv=pass; b=uP11s60axXyGrF99jIb5ufGrBDJ6nBGSHaNhXUxWfPRmnjKc3xWECG0bv+S9udgtILeA9f3vVoneTqg/U4bIm0yJXQTj8mgg6IIJtiJ/oC+Hi0Syqt6yAuljC+iK79sYsH4BYzdUT0GBjhDXM2N1YXpIuODN4VdXZ+9LdBwwJnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157320; c=relaxed/simple;
	bh=PLFZoqvgdzDcNNG1pDtgeYUBZaBLdlJw8WFRBEazlAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiYC5489PWcNea7Ze5GcbPnJZJTuKAWDri7ovuYb+Fjv/rZw7/KAiXUy1DbgxvTVDa5hQdGGe/1eBnwFjliCB/43GIzR59SSOnKfqs3Y8i5zoPYW9w2YEGkf8hcK2RZAKCVJpEi4F45lsq/s9xAe09aGGJtbl9DDBYxnvpERR78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=GMV+muYD; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="GMV+muYD"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1785618b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 06:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785157316; cv=none;
        d=google.com; s=arc-20260327;
        b=nBnnRyIAs1nVRIcbYSrstDpXrlhV8a9+LD0dRWDpgg95yF8eC3irpL38kcI6uiFY62
         fZrBEqX5R+GN/L0d2hJG7sDI96OIZK3feV+NwQLPy4CEQd2IJGRHyvAgxJFFuBBOF5n+
         o6jom9OY03OaH4QRkmknpVJvzY4UZ6eKQjoLxvtv6BIn8zc+3SeRFdwVj7IPePqMO+a1
         mvQEdRMVwhUPzzED1l8YOCy8geY4B/lL1xviR4W2/SOBjjsF7TUhKbBu9bjKIuCJTxnh
         2MKceoje50BlcEBhAb9jT/qtx1Mr5UrfMqxgjbXCK7bPZjHdzMZPtd4A/ag0sPK+pHqf
         FnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=smH9T+3r/D6zvCFLRvYovQFwi0Ua6Y/TcKGepfjNgBk=;
        fh=IxP1SBuPeB+iwGJ0MN4KdX3Cw+ztiyI222UgdCMDwzY=;
        b=Ed8RuaBP6IbNRn8MFKdoE4tJs8D91pa1d2lp7L5/mmjzbmWn9WAHavCBj9wlBAJCaa
         rUmIYbjNJ31RaHDI1d52n2d1i6FgN0cEb00ZVtzCYN7KyrXThAjj2rRDy+ODu/X59TpN
         pf/obOhpbi0DlwqWaY9dNnphkdw/pWsyRcG0lkIv0C4k/sZduuaEpOT6VYQndk0hO8QD
         gLLRUonOsvF/7k9JVZXWtdc6OLZb7lJIiXuLJjOGUodY2sq99nlrrx92gQF8ORcf/CvR
         i5oFhbh5brFaR9OCelVBXU4c/dWThL/Hiwex9OVDmSPv5HZgkq/SzftFveCVf/VHOtfz
         77Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785157316; x=1785762116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=smH9T+3r/D6zvCFLRvYovQFwi0Ua6Y/TcKGepfjNgBk=;
        b=GMV+muYDBMbNI0Gwzbc33nYg1NtPCL+gI/gHCOTLHOlCaJxbhhDgCM2UXs7Tq/Qphk
         LL2204NmQqPAbG3LDRWsGvRh5T2Zh14yaXkCziYsivGB6VK2NtKH+7Gef/ih5O6BpKJC
         /TGP+gGBSmfdc5Nwww/IgRAQIueuTtmRrYcww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157316; x=1785762116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smH9T+3r/D6zvCFLRvYovQFwi0Ua6Y/TcKGepfjNgBk=;
        b=qptNP09g3isqhS0a41QTvnCbVZPjaBGHXpCxEag6YiIktT6Jut7FguCEnn6Ox9hFmH
         Boqf2YDUxTmEzecCv47E/QMhTgT3XZwVX9qrBO72Syy8Xap5PkU6/WKxbi3Bsa0GsNrR
         h7F5yCt/hAX5ZYzYDWps6vTMAxgz8EUrtRULcR6RSEYtpWt9fOnOp2EMNdu7l7e76S9y
         Rer+wyXsTENe+OcqsPfRUXRlLRCpeRQcF/VPWsZubD9P0PggbKUhjq9Gei0XPqbTJuKA
         9D9amfjC7BQ80j5aAd0PjUO7y7J2QZs9TcYXAAeNApxBIFX/BbjtFUtzNRqc+53kxQWR
         W+tA==
X-Forwarded-Encrypted: i=1; AHgh+RpvXopfPs7vRL6MV877dMAZ8rGgEo19ZZT5wL9PZeFL4njeMG48ap9H8m31Atj+Kq3johxAh4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Mbipm67TaSUqsdwxh0em/sBf7ckgbebSTU9dSDsvt6j4fAvs
	Sz5rjUGMJ5jlzCyAqXFOWJ7vW7K8VcbcikjlYVYZrO+khQfU1LJ6MAqwNc1aAc8pegzUnBTwhRF
	7mKMlxxjVD0Q08X4Z3ktHWwGsyApr0HsOnAgr9S2u
X-Gm-Gg: AR+sD13H/4ia/qgp05pwJX3YJh+bBfMdriDCfwJt1SoJsSmQGZE9xo8En9XmjK8i+4I
	nS+wqegwNEd2gyGruh3MIBWZaQcz50viRskrxfq9O+LnahaPhqQ//Ws7DUnoPxy3ar5jeBmEfGO
	tnNHtu77NTUvEbUfme0rcKpfWZWHEBIYmPFW23Sq4T/KZKFa/ULdOqtPV4pA/cwkt7sAkoNLXnL
	HmaUjh8J1YPZKjslW7gS8B9cpdysAy9oQXqkRXJxBOz8FFdmiSbb+ZiMYc=
X-Received: by 2002:a05:6a00:2887:b0:842:706e:ad43 with SMTP id
 d2e1a72fcca58-84e5947c024mr6724427b3a.33.1785157315837; Mon, 27 Jul 2026
 06:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724192441.892133-1-jhs@mojatatu.com>
In-Reply-To: <20260724192441.892133-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 27 Jul 2026 09:01:44 -0400
X-Gm-Features: AUfX_mxfzq2dbrHNj67t1xp5fvmHu_cTfE0Iz5ZZrBXT0pv_1Bb8hyYa3CWw-eI
Message-ID: <CAM0EoM=ufG6DcZC=zbKRc8BH0Reni2kXGL=sxc=Xqr6FtD1tQw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: cls_route: fix fastmap
 use-after-free and preserve netns teardown ordering
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, 
	santosh.kalluri129@gmail.com, victor@mojatatu.com, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The route4 classifier maintains a 16-slot fastmap cache that stores raw
> struct route4_filter pointers indexed by (id, iif). The reader
> (route4_classify) populates this cache via route4_set_fastmap() for every
> classified packet that hits a filter. The writer (route4_delete,
> route4_change) clears the cache via route4_reset_fastmap() before
> RCU-deferred kfree of the filter.
>
> This creates a UAF race:
>  1. Reader walks the RCU-protected bucket chain, finds filter f
>  2. Writer unlinks f, calls route4_reset_fastmap(), then tcf_queue_work()
>  3. Reader calls route4_set_fastmap() and writes f into the cache
>     *after* the writer's reset, caching a pointer about to be freed
>  4. After the RCU grace period, kfree(f) executes
>  5. Next classified packet on the same (id, iif) tuple hits the stale
>     fastmap entry and reads f->res from freed memory
>
> Reproduced with an mdelay(100) accelerator in route4_set_fastmap() and a
> concurrent add/delete stress test (provided by both zdi and Santosh).
> Both triggered KASAN slab-use-after-free reports in the route4 fastmap
> paths.
>
> Fix:
> Move the fastmap flush to the writer side under RTNL, ordered after
> synchronize_rcu(). This ensures stale fastmap entries written by
> in-flight readers are visible (readers have finished) and no new readers
> can find the unlinked filter, so the subsequent route4_reset_fastmap(head=
)
> flushes them safely while head is valid under RTNL.
>
> In route4_destroy() the synchronous __route4_delete_filter() fallback is
> retained for the case where tcf_exts_get_net() returns false (netns is
> being torn down in cleanup_net()). The trailing synchronize_rcu() before
> kfree_rcu(head) drains any in-flight readers first, so the synchronous
> free is safe. Removing the fallback and unconditionally deferring via
> route4_queue_work() would race with tc_action_net_exit(): cleanup_net()
> does not flush the tc_filter_wq workqueue, so the deferred work could run
> after the action idrinfo has been freed, causing a use-after-free on
> idrinfo->lock in __tcf_action_put().
>

Well... AI reads commits and comments and correlates to code ;->
Both Sashiko's (legitimately) dont like this commit log's accuracy.

> Note: This fix will slow down deletes and filter add/replace, since
> synchronize_rcu() is called under RTNL in route4_delete() and
> route4_change(). An alternative fix would have been to introduce refcnt
> to the head struct but that is a much bigger patch. We justify this as
> a reasonable fix.
>

[..]
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index bd6f945bd388..c7d0164c1e9f 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -307,6 +307,19 @@ static void route4_destroy(struct tcf_proto *tp, boo=
l rtnl_held,
>                         kfree_rcu(b, rcu);
>                 }
>         }
> +
> +       /* All filters are unlinked; no new reader can find them on the
> +        * chain.  Wait for in-flight readers that may still hold a filte=
r
> +        * pointer and have published it into the fastmap after we unlink=
ed.
> +        * Then flush the stale entries while head is still valid under
> +        * RTNL, matching the route4_delete() pattern.  This also protect=
s
> +        * the synchronous __route4_delete_filter() path above: when the
> +        * netns is dying, tcf_exts_get_net() returns false and the filte=
r
> +        * is freed directly, but only after all readers have drained.
> +        */

And the above related comment.

sashiko-claude is over-reaching with some manufactured UAF and
performance comment (Which i address in the commit log).

Let me know if i should send v3 making the commit and comment more
accurate as well as re-emphasize the performance issue.
(with hope next review sashiko wont bring it up).
We can ignore the UAF claim made.

cheers,
jamal
