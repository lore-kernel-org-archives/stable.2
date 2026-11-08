Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142826;
	b=sagF3OtVcvrFcozw3ZrjJe/4fJ/0skrxnrCYUN2fnG3vuPZg3JFZr0+HHQ9RKy2wtWgi
	 RLoxXQvsLPGDM515yAmQYsHYzIM2QrBVu6TghbYakYTdBBFqWNztsD9eXLKZanfCSgRNL
	 J9ttzmN9hAhrWGilHa2bSjKsmJ2b1G4+dRmFcIhezbhfOxbgFSjDvb9vwrmpFMOGxVh4F
	 gvqJc5zUKTXYOeR1Jm60m3+6rII/EgWAwFkoxTP54jhul9gf5A0KgciO+QJfKtPtQmzT6
	 K4KbOw/fxiUAnusSZfN/O7PR5FiyaHF9UXdk58uHPt6Xk26kyrHwIkukUbo4NHK04Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
	b=TIctUoRcm7q4E/W/yj3v3dCB1hewIspKyhp/rfZGeYwglYwQ/FAeDbXYD/rOjH5K/IsB
	 vCqCYMvaRjVvIRoaqJzwxN7uFZpuSC3oAnDTwIGXfUb8NKXIlWv90XBbsIQibDSqrZCbA
	 vzTDQdOv1UyV6Gdbi7S5N6U8Pq9wvR6Lx3JOyrgq8DxQpO9sQ2XaDG6ULEiKWJKR1fKy9
	 byZgciw9GUelxG8WJK928zzCTVhpKiAADGkM8d8U+aQiWGwShJS1WfrW/INpcAr28s84V
	 d++wk8C0+om3sUDYw1NXG4PBORYdJBQFSqcucCtkz5L3hFWesVEfUA5Dzv+HIJVh3Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NEt8TNJs;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A8606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B2A8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NEt8TNJs
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so64498a91.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142826; x=1794747626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
        b=NEt8TNJs6JP9BoXDg7rnJ+F20QyQc5NRQYgxlZU3sRUoaXEv/IVzqnWWf11uu2V+Ai
         lUtYTjuUCXGyyKbyNm/GqXcTa2jBPtl8Vwf3wxfZLFWQKYlo/8Xq2vAS3TN/UiM9khAo
         wnTZMpNN3nQcGWQ24x5ug24PXi8TuVLglrn6ZDn30jefoAQcOvkG9W3U7ZH1/JDfZZF2
         iFrkHMtTrYB8iluJ//NMdY3WnbHEevvP3uTLOByq34K+/TOrpSDQx3HJCFOgo7ZmJXeq
         I4EKrPmGBK3irLqcv4m9LsU/jvmqtbiHS3AIb/LbrMuZl4fwxhcHsoMSuZfF3VVvquzo
         umdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142826; x=1794747626;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
        b=WZ+oujyfB+LNwVbLKQitZnqybhoFbfdRg9P7TvC2c806iiQ3Bw9x7TwtLg4ve4geIx
         mp3b3q+MEg/ACRS7cRoYoAJ4D0HrFs9YzwSRERXQENGF6FpcNLWbySE5yS2ccHKDjK34
         MLqFCQoJdo0nANrwg5auc2DeuwBk6pAeDvgRbGYrZjq0QbIva7hrp1EH4myc58IV1Rrl
         3+u44yJbKTgjuaWOAWXJcLaNN96eAc8FdxGfGhSeSdZFr/AXZvN/o/LfXyIYxEv6khND
         A4fyIytE53HMCieAX2en62KFThsBuQ9HTEEocjnpuU3CKL5n/J0xcfiWRn6ojlzBrrPT
         tVYA==
X-Forwarded-Encrypted: i=1; AL+hErEVhE31lyTJDpdRKEc+b5Gg93ZayD6IRdRD10B+GzHjyAzCQ6knt6wwOgQZ46ckxKVRc9mJVgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z86gpcYZ0IpB8V6L/twidPZjyedO2EAE7KgYdnqAJ0kPYWYjDxj
	UFUc7OxT9Di54uocJIGrq87CPuB/r35h9mETpVWMVZmQx8ViMXhRQBR3
X-Gm-Gg: AYBFou12qXpS602V58alVnDjSpTXcAwPRkbYEOQgB5Oz02WHYoZYfQTCRHiCGSO0n2e
	bhqW9naUAGkuTgf5hMBmmC3OLnw2b8mjSa9AIv/73Ls1bqwJ2rSEJoOBlAr/84bLZQrvqg0hsuF
	TOODrwhSN0UGrscg4+SbJETcdpoJFHG32Osgpgc+cbshrttMUnNqy1I08+vDvJCVGUJPtOWT3Qt
	xrZS1AgJa9bcVlWh5RWS1IEycNc2zEL/CNUmoHDjKxqZiZkVzvQDLDJJfU40pOIKBIcBe9ylLx7
	KIQ1iWq3O8S0a8gXfJriAHQkj/ajtoN/MhA9nCgVli5RuOBvaFzi6B28wytqmAoWfrm93hRwAMN
	ciRv3eUDwc5zAQ7KaUELMK9VB0sVj/i5W4DWnvzWSyPfHUCI2KcE2Ay6Ku8pRewuwu406o72KKU
	khk2fsdWo31KZlIBwDXYsfJndc65BvQdGtDkDyh+jlTgyWP7/KC4YRKE8ZO3UrrBrHUJUlKiSnJ
	W/qeHr8BETxaH3Vkgie8xsFDYB8IUkhNcXToHgtOz8v00E4uosNDLPk5Xy++UCL81gSijs1eKpz
	LD0SnQc1oG1ViQ/YGARNGtmLReDRAFppmfPY
X-Received: by 2002:a17:90b:3c8f:b0:3a7:b260:9ccc with SMTP id 98e67ed59e1d1-3b12d5d4c16mr1111842a91.65.1794142825530;
        Sun, 08 Nov 2026 05:00:25 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127970954sm2986180a91.15.2026.11.08.05.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:00:24 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: Protect pkey method checks against type removal
Date: Sun,  8 Nov 2026 20:59:31 +0800
Message-ID: <20261108125932.77081-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au3fT5HMq7IF-M3e@kernel.org>
References: <auy1ANMSKTXZb8GE@kernel.org> <20261105193632.34363-1-0xbeac@gmail.com> <au3fT5HMq7IF-M3e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Fri, Nov 06, 2026 at 04:08:15PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 06, 2026 at 03:36:31AM +0800, Yuansheng Yang wrote:
> > Remove the key->type->asym_query check from keyctl_pkey_params_get(): it
> > runs without key->sem, so key_gc_keytype() can retype the key right after
> > it.  Instead, make keyctl_pkey_params_get_2(), keyctl_pkey_query(),
> > keyctl_pkey_e_d_s() and keyctl_pkey_verify() each take key->sem for
> > reading, check the key->type->asym_* method they are about to call, call
> > it and release key->sem.
[...]
>
> This is a transliteration of the source code changes. How this helps me
> to quickly understand them vs reading the source code changes and
> skipping this?

It doesn't. It just repeats the diff.

> I'd like to know what is that you are trying to do by doing those
> changes, which is the higher leve question. You should know this
> already. I see pretty much the same thing done for those sites so maybe
> that action is what you want to describe. Action taken, why that action
> won't cause any harm,  enumerate the coverage and address that it is the
> full coverage.

The goal is that an ->asym_*() method is only called while the key's
type cannot go away. The action is the same at every site: take key->sem
for reading, check the method, call it, drop key->sem. The GC needs
key->sem for writing to switch the key to key_type_dead, and
unregister_key_type() waits for the GC, so the type and its module stay
until the method returns.

Why it does no harm: the early checks stay, so the errors do not change
unless the type goes away at the same time. memdup_user() and
copy_to_user() stay outside key->sem. And key->sem is only taken for
reading, so only writers on that key wait for the operation, as they
already wait for ->read().

Coverage: nothing calls ->asym_query(), ->asym_eds_op() or
->asym_verify_signature() except keyctl_pkey_query(),
keyctl_pkey_params_get_2(), keyctl_pkey_e_d_s() and
keyctl_pkey_verify(), and all four get the change.

v5 describes it in that order.

> The above looks to me as if someone had literally prompted "translate
> this source code change to English". Neither much effort thinking  done.

That is close to what happened. I used LLM assistants (Codex and
Claude) to find this bug, while looking for other cases of the
KEYCTL_READ problem, and to draft the patch and its changelogs. I
should have said so from v1. The v5 changelog says so, and what they
were used for. I have gone through this description myself and can
answer for every line of it.

> > -	if (!params->key->type->asym_query)
> > -		return -EOPNOTSUPP;
> > -
>
> I'd drop this as technically it is not part of the bug fix and then you
> have pretty much symmetric action. Helps at least with the description.

Agreed. v5 keeps that check. For the same reason it also keeps the early
asym_eds_op and asym_verify_signature checks in keyctl_pkey_e_d_s() and
keyctl_pkey_verify(), so each of the four sites only gets the
down_read() / check / call / up_read() block.

Keeping them also fixes something I missed in v4: for a key type without
->asym_verify_signature, such as turris-signing-key, KEYCTL_PKEY_VERIFY
with a bad input pointer returned -EFAULT instead of -EOPNOTSUPP.

I'll send v5 right after this mail.

Thanks,
Yuansheng Yang
