Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BD30B51A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561307; cv=none; b=pdH8e3SJo8Rilo+7Rf4UvEkEceVh505FwAXuFKrlRFXwLol1+kALJAWboPsGayeAJ4NcFPRWxXjDsmZsGb35PRSsb1Cxykn9Ks0b526q4CleVIOwW3BihU+cy0FEAa1pkS0zkjpsCKXHPpzoYWVob1iu0tOQ6SQ4yVU1UOCEjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561307; c=relaxed/simple;
	bh=G8OjuKOeekAcSXBzwx+3UiNOCjpdWld4+mT32sCBXSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkeRFyiKIuuKGO8kvT42A2VH6CITcRiq2u4tanGICt7SLw93KH32XGXFnOx+n4fB9o1iCs5Cb/Jas8s/qC3PzxmfW2IEdcmQHscy8q6st0RUFZtBLTFtwXIbi7x3xkd2nsTm7oyOuBHueqf3etv74MODqnSAmafOzgUm67iuRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz+YbaEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz+YbaEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D483F1F00A3A;
	Mon, 20 Jul 2026 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561306;
	bh=tNBXiBdx/SK6bsbW5dSrOKiqfbQlUKB/Sl5AUlh7TF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bz+YbaElu627BVcmcTqG5yOM0t3Uz2UXO3Oj9Cx3+CB7nAUp40rDK281fmsUL5rFX
	 Q0F1B8IUeP+pYqzq+24TTWFZuJOWThWotmcE0B6VVa3DdUwsbs9m8oDk3Es8fPSXNB
	 XIPOmZGJbs3kt/FqJSN7CPAwrzAT1LDrG0HI454H/ENb0NJUFePeQVGutUDJoWO7iS
	 d6RSn+9PWtIXdkpC6l/IL2CnDiL2rtsy54ZMB/9Vner7r9VM1rnsXMAcrv2wZzE8JM
	 fmnRZqcBD2JskWE9D6+dMySu8et3iTe0NhAJwQAW7Btwrl0ucScK5+sJ26Dg1Gt2wM
	 7FWUpSTYCWF8w==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	yikai@z1k.dev,
	stable@vger.kernel.org
Subject: Re: [6.1.176 regression] damon_reclaim.enabled broken
Date: Mon, 20 Jul 2026 08:28:16 -0700
Message-ID: <20260720152817.83680-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720092840.238806-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 17:28:40 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi Yikai,
> 
> Thank you for reporting this issue :>

Thank you for the reporting, Yikai!

> 
> I just investigated the problem and found the root cause. It looks like
> a typo in damon_reclaim_timer_fn(), where '!=' was used instead of '=='
> (unlike damon_lru_sort), which caused the delayed work to return early
> and fail to enable during early boot.
> 
> Comparison
> ==========
> 
>     /* DAMON_RECLAIM */
>     static void damon_reclaim_timer_fn(struct work_struct *work)
>     {
>         bool now_enabled;
> 
>         now_enabled = enabled;
>         if (damon_reclaim_enabled() != now_enabled)
>             return;
>         damon_reclaim_turn(now_enabled);
>     }
> 
>     /* DAMON_LRU_SORT */
>     static void damon_lru_sort_timer_fn(struct work_struct *work)
>     {
>         bool now_enabled;
> 
>         now_enabled = enabled;
>         if (damon_lru_sort_enabled() == now_enabled)
>             return;
>         damon_lru_sort_turn(now_enabled);
>     }

Thank you for investigating this, Liew!

> 
> This appears to affect only version .176 and .177 (introduced by
> 2f54908fae211).

Correct.  Apparently this was due to a mistake in porting.

> 
> I will send out the fix patch as soon as possible!

I found you sent [1] it already.  Let's further discuss on the thread.

[1] https://lore.kernel.org/20260720094708.243937-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
