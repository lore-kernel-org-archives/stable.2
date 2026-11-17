Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794942478;
	b=F1N/GGxBUGcSnK6dh3jDhR2JyaGKPX3DcfI8qNsoG0ZOsRpvqX8RLKY6Ksc4I4w8avNn
	 9Mi7i9f7AP/OswzjaTjnrv7n0HamCEf+iKr35nrPuFGJTB2ldFH1F1wUnTuKtXNKnCiBr
	 jlUzGlbcCYGwtb9UcJxI6rUJue78b6/9ydK0OOfhKQ9porpiJkiPfPGoC7olId+DYhBMc
	 DsJxLEbVXtH+pdkHIPd2ocozjlO1XYe1CmDx8XxcjBpiJJgpq7QX9vNnweGGKklYuGdWo
	 CdZiRAwZRajtkprLGm/m9pD9qZ8Ld1i7tHYf8yZT2kSUw90GTWxHwfHLqLKE7UilO4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=d4mLDd/uQdN7bY/YPYFedZvFpypXkiop92AccgpkyLI=;
	b=LvCf5oDpXEDSoq7ZIAUO+3jenV86ewYUIaPxA1jPCprk0Mo5YyEv2PGugaabdnkK84B2
	 G2Jeds6z2fDfJNOvbZ2BEo4hjLoVvdhS8Y+0RqG8tZIgcVjb+FSJY66yqw1QqAfmmHTtS
	 MPTwf/irHZ1d4moI1nupK/a24dTBnV67o6D4B1TxBghGcOEf4nkA7KxOd421Y12nwVdaI
	 HU8eQJmTKqd9Or2FneaolklgUteT7e2sU/TxgSMIw+yiEH0Lxye3A4w04WHNBK7B61LFM
	 kHomimjsJDbtDIvxSUK879FCSol+6dQ7WtM+gCAPGdZFzqkzm7zN1ClopSIN1JH3BSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWEDb1yh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E873606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 19:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E873606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWEDb1yh
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso244184a12.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:07:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794942476; cv=none;
        d=google.com; s=arc-20260327;
        b=rbWOmxu2Yft7PO0VuMrcEp9RqFLlcn5AqzNjP4ROVKEc4McyM1PmuzYm4oX9LPZ6H/
         ftFuC+Kd5/znFQ3GI0xH/TEu7l8/0eUF1Z59ugOGN7E10CBKScCAWFvNA6Jn/hZcq6UJ
         KCiOdlTko/dwsPV5aQJTcVs6wbkecbK1bDoAtiX0pPf11vb1quV/QNMahaHDrQBeKkvf
         KPRIBRMC7Lsa6PTku32EuyzCLWzHtFpvzS7xXdTRdOMx78aYpSkxREU4PhPl9D6v5Ukf
         aXJdjX+PKfKt5GP0/QctpHpYoC94yLBrKFL4vQVygNIjlRlswh7k7wz7VEo1JZDceqBv
         aYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d4mLDd/uQdN7bY/YPYFedZvFpypXkiop92AccgpkyLI=;
        fh=2ciEgnaKmEkuHKzhZCpIfibrrnU7OKrNl37Q9S/LdS4=;
        b=dYgU19jRka1HrFrvP3lbxPo4jOi6QaKBKIxdyKUYfWYgOMONEHC05zkPeORV5gPPz/
         hIio5Qgxz1MGp/YSHxKdnB7kdHMV8Yy+/Mam/sKg/vkxd/CILxwEJY9Ik165km6QsGgs
         m5LgchLhx1eWoRo/1y847Ma9T0z3aTGeK7bL0IShfIrWqNCB4mIRpH/TL94itDOKxL4J
         FCNqPGaaxaNBY5k/ob++AkuGU4To+mxSd+e59zKzoiECcNQ1Y1/HrVzkxq9LVLAP/1KC
         TYQKnVvx99WiEQR9ilNVY88FpE62rZMCzH12EhwABmi858G5RiaB6JuJ/Vv4z9yj6n1L
         0UnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794942476; x=1795547276; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4mLDd/uQdN7bY/YPYFedZvFpypXkiop92AccgpkyLI=;
        b=CWEDb1yhsbiFDT5/IZ7/+ZOPrREOd7QYymfn4mn6Q3O4M/XOPJQqPTJGnqB58RMoTK
         d51OjAwbUOQEm/An9tEkboKSQwfKtTb8W+xK6KBYiwTpDVtsT1Fn+G8BinE+hThL6m8s
         tLj33Jhkm01QTnfdykjmupghPb+SK9MpqJefbIjMr+4rGizgja6sZXviI8I3ITtFJzhw
         rL3zqAoAwzgrDWNi/SI5ETV2c0I4Z8dFBV/4wDWA3foDkVfxfPgNHHfYUqQgP3e1xJKf
         diZXa1wC79ggb6lRGQq65T2e2E0DuixcvtCunKoSzhLcGv4GlAB1MlHlX3Uao4m1tb0D
         2GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794942476; x=1795547276;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d4mLDd/uQdN7bY/YPYFedZvFpypXkiop92AccgpkyLI=;
        b=mBkas0ILS1ouEJxOwQbnvkKtGDY6SygMd/5X8V2PkQucjyg7/mV24l2liqMGCLtP6j
         KNHNADciakj8j983lKUMMGvjUqc21lexoS/9V28LBq5KKnnuae0zetCnmzcPCxO39tNv
         o2jjdPgp0VCa4zRL7ufOq/DqyPFe2jpic9Uqg/P3QA0xeE6YWW8WBQDkh07JKz++lQB0
         MMzLeGYqI48qWumybPUN5Rkinr1BbQ9t3EiPkFrKVhcC+Xg3TZnyK7dulrvi9ArOj5Z8
         LBQA6zo/clfOC0/+9YGvIIMD3c8jUuo5OYxJgsjiKO0SUh2WAyGndnM4R+EizbSzgbI7
         QB4A==
X-Forwarded-Encrypted: i=1; AL+hErHTMf28MllVJEa9XK3QbmBexZzuxtEyIdqA5PrOrztFPBQNAec2RNl2bk95l4vjkD3bXj9OAcA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f3BwqSzo4K6lyasEuktGAa2qg29RWHYROy3zQI4DJg161ODX9
	eo3qKWpRInp/oIy6N6iO5c5iaR0jX50iO/jr2pWucbx3G45GctCFlmwkoxTra+d+ZOBkJhM/Pfl
	RbwB9P7R/aLCVwouDaLnIKEKHdwP+A1YfBowUZnAt
X-Gm-Gg: AYBFou3I9BwKJUbQ3SYPXaMs82iNscfCLGlgo7g0P4YeTIpO7C8X1qWGYX61mLHnIeB
	hjEai0KeB1fRxdIK9I0h7/tvEU2qgyk7zo5PTd7WJujAKXtTdo5nUiKMurXui5zyPLM1iOXSM/1
	ghxT89HOBFbSGvTARlV2y5sM6D+Dd1YV9nUn7/urXTkkfnuLGCz1MPSEiHnf4nG+5cdtlqpvbw7
	6fJCGBbREsHedUEM06bZcGHtewaIBW7bBcltv4D89leJFr46XNosdwiBiw0SrYKnAW13JRiAI8q
	NU5qYq3UIJB9PNOxgTScwXaOOV/84nw3pP7vxBoO+VkAFBqh0h5R5VI2Pp1iDR0hBHgBaMK9moK
	CEkOBBJc78CJPQQ8v1i5sDrzBfnAXoQd0glp29OtNrnNVlgI/HJ7P5nspGwRXGOf2V1s=
X-Received: by 2002:a17:907:2d13:b0:c40:b477:dfa0 with SMTP id
 a640c23a62f3a-c510e1e90f1mr20057266b.18.1794942475932; Tue, 17 Nov 2026
 11:07:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-blk-plug-fix-v1-1-7fa2a6215b8d@mediatek.com>
In-Reply-To: <20261112-blk-plug-fix-v1-1-7fa2a6215b8d@mediatek.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 17 Nov 2026 11:07:44 -0800
X-Gm-Features: AclHuK8_K-iJgh8nbeVlichavK0zIZlG8B8U4MkOUyaGlS8RKuiq1rZzu30675Q
Message-ID: <CAB=BE-S68WquuwZ506RriJctggHCebbNnhX+EYMWjxZxMqRDMg@mail.gmail.com>
Subject: Re: [PATCH] block: fix PF_BLOCK_TS/current->plug ordering in blk_finish_plug()
To: Zi-Hao Huang <zi-hao.huang@mediatek.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Cc: +Chao Yu <chao@kernel.org>

> Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Zi-Hao Huang <zi-hao.huang@mediatek.com>

Note that Chao independently hit and posted a fix for the same panic a
few days later [1], placing barrier() at the end of __blk_flush_plug()
instead. Placing barrier() here in blk_finish_plug() looks slightly
cleaner since blk_finish_plug() is the only caller of __blk_flush_plug()
that clears current->plug.

One correction on the Fixes/stable tags (which Chao's patch got right):
06b23f92af87 checked `if (plug)` in blk_plug_invalidate_ts() and only ran
from sched_update_worker(), so this preemption race and NULL dereference
was introduced by
fad156c2af22 ("block: invalidate cached plug timestamp after task switch"),
similar to
691b052139c9 ("block: fix race in blk_time_get_ns() returning 0").

So the tags should be:

Fixes: fad156c2af22 ("block: invalidate cached plug timestamp after
task switch")
Cc: stable@vger.kernel.org

With the updated Fixes/stable tags:

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

- Sandeep.

[1] https://lore.kernel.org/all/20261116000723.934826-1-chao@kernel.org/
