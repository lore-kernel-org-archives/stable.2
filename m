Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287091;
	b=QQKbCwZdkmdMH8Kbu3D32rKs0MDvhl66pndNidZ+WwBoJZyZmnlGpnazk4v+m+YeTlwH
	 m+jfxqSvqCD4ACS47GTkAwlwwpVDgkES1OJngcwXvDmmLpvSDNbpL23BnfMiR/+WydCYq
	 CBveCKZR9mhD+pVLuhLFNS825b+h2qfGa2ylPKak9Yad+Vs1CU6/HdmyX8Bi+TUip/nXZ
	 xZnFnl/E66rPpoY0zjA+NzxCPNcyZEL0vEGZ7Aw6iGnOZEhm/jsmGg1mG0KGH9r7dlPP8
	 M74ER7/jB9hu7nOt3OSjIQcZPZ0HezvckOaX5DUO8wvll2f6fdMKgujVga79thwwdUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XKclWe9kzl34mf7ikCBlpHKdvGAXpEly40KTRKr1ZNY=;
	b=CgLETmmF1+eqG+IRduqAzdwh0KecJx2HEgz4P+skIyYhg63BwZ/4B1aBVuvm16nEhrMl
	 zv+rU7PafjI8Ley6/HoC83UbkhM8F3Br/PgbEBdie6XpR3xG/qhXMAXWXB2IXLQkurgmQ
	 IHmGSkk/FsnmHt0yK6qy9d0jgVuCvJzdmYEXEOswVUBCQ1kLvJWcB6d0DSoyTei7O1wr4
	 jNNC2PWeyvZFaugyYG+GH10iakIIXKum/ialqWXArQFoMt8ie/aWZ6/kmj/geQCZr5fuZ
	 NjB+VWeJOARjuXs0gazIlO/yXnyCDlehJ0WLbD1c6um3NoXYT4z3yjMvQjv6vZkW9tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lkHYRBLy;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E146606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E146606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lkHYRBLy
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a215e64962so24339065e9.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793287090; x=1793891890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XKclWe9kzl34mf7ikCBlpHKdvGAXpEly40KTRKr1ZNY=;
        b=lkHYRBLy5VLy9lkQOcJ3o9qdIPz574Rme6P63ZH03Ucpos0khXntA7NZejBhJZX79p
         tv+/DlEor90Vx6TmKdPFWRQavGmI+kWGcRMLu12S7rAWJrrVooTEi9wbmyeeaIrB8Ar5
         K6WDEWHUor7AlFuZ2JFi7fCfTGjrochFSL7XZYTtz70J+DxtLHnNTrylhyH+PLbhShyI
         2yUzyM903mFa9I1fRobJG0bJwYPxx0KNP0tslpoJlx3yINr08LeQuCrPBiLzej1j8twf
         +iAraxXQ+RrJpZgI9tvry9uEGvyxTqDdfnAEoKAjYMsP/cFGH60OM6KdBUNSEs7lTYaL
         h2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287090; x=1793891890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKclWe9kzl34mf7ikCBlpHKdvGAXpEly40KTRKr1ZNY=;
        b=V0XHSGRp8aGchqkHXPWyzahmALfg7biXV2HghkwVyiV9YyHdbJuqQDPGZJUkT23Tx1
         JJHu3uJL/rwgO2wExXC4WzHK/xcYjbDX0spzAKP+kNIFmUCUycFGRVFYIc1jO2m63L+D
         Ossa8+vUPvo5wU2jZmrrXJa3YfwX86/Ii/V8SpEkuxXggceB7DgkZ6JuVkt5QqXsdYa0
         Iy+V/yFRSikbyRtwaWHV8Py4sXZi8aCaxe0oXP8h+XkDHUmfY02LZTsggKtuAJLAcI1f
         9yepXqysUbpxilCcy39kHCeUkz5gO388wj5D6QTXbJp+uA1KYEvFn7CInayebTh5m76I
         lk3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzuuQkUrMtFWELLBTkBTiGgwnrqk9bxsU5S0ySr3zOqxa2R9rlwEAmgINRW9NxZK+Lr5ySxb24=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4U5wY/Ji392BFQJsjL5snoXHikhSE8QybFKHrLWoinNPqnFK8
	XxmoWT7+p5I5L0ukoS6ZgdpORM5UOwsztaesXtNvcr5F7eUzmSWJuuXI
X-Gm-Gg: AYBFou09IrPlXCbeKmy1rwRk8pOWfGXUKBsrHCz9X5cb/ilQW2kVxK2zCFeJTl2oyqS
	3D0YOFixEvjngd9sdvufLpBtf5bsSHHjVGGV+sgqCPP8B2hk4ynq8w1Ywo+i6Mj6q6I+lX6tLUO
	jihVaR9UyruFrEaC/CWvp7ZYiU8/ukBsOn4/G3NdfIWCxYMHtnHSzkFxkYCnJBmdDYEXrqpdxW5
	w7I9wud27N2P+O+iIAqQYT0ZBti2ei1ezsp9nedTwqPZBe8hXtbJpb7RleQCxeTrEwHakmk13lu
	BdMgfyocCxb1gCNid9VWDYOPkzZU2DRPb6KsY4m0zJ5y6hYmV99QGzHhrrnx20EnLpNTesL3AHo
	TmvQHVpetx+ZQUm9rv9fiemKOTgJAkN4XieIBW/+2xEdbVye//xgLXO8E8lbWkP8Hsi6xc1Pyyc
	F8sCCyswxRZk9zEdIvmjVrtOwZrbzNXB3EHM7AWNDltCzHbdYCsbyDV+OROEbT3PERR0e8O69m5
	MJfybtJJrjoZHIyNPsOYH5g0s1PiG4OAoKUz/l9OxSTCVBmwQZ9MKD673YBfKJUlbUJz0Ua5HhC
	ckAuRtUdTNgoGWoIQXCzcfPeWLo5UusSCN2xPvIZOWS/RYHIMxDEJfSH4xKcI0w+OrOG4j5xph3
	2Eo0ncjWyXMO3qX/Dp5ADVzmScOpHNd1lGYB9nwwfJuaP2J4ZQKpt+2PsCMzincdtq6g=
X-Received: by 2002:a05:600c:4f89:b0:4a1:c6fd:4db0 with SMTP id 5b1f17b1804b1-4a966c41836mr142852995e9.19.1793287089736;
        Thu, 29 Oct 2026 08:18:09 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94f05e4e4sm87571055e9.3.2026.10.29.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:18:09 -0700 (PDT)
Date: Thu, 29 Oct 2026 18:18:05 +0300
From: Dan Carpenter <error27@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/sysfs-kunit: fix leaked pid reference
 in add_targets test
Message-ID: <auNjrR4FyTf4WbgI@stanley.mountain>
References: <20261029075609.35661-1-xiaoleiwangxiaolei@gmail.com>
 <20261029141040.148392-1-sj@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261029141040.148392-1-sj@kernel.org>

On Thu, Oct 29, 2026 at 07:10:40AM -0700, SJ Park wrote:
> Hello Xiaolei,
> 
> On Thu, 29 Oct 2026 15:56:09 +0800 Xiaolei Wang <xiaoleiwangxiaolei@gmail.com> wrote:
> 
> > From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
> > 
> > damon_sysfs_test_add_targets() creates its monitoring context with
> > damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
> > DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
> > context, and damon_sysfs_add_targets() therefore calls
> > damon_set_target_pid() for each target it adds.  That function grabs a
> > reference to the target's struct pid via find_get_pid().
> > 
> > The test then tears the context down with damon_destroy_ctx(), which
> > releases such a reference from ctx->ops.cleanup_target().  For the vaddr
> > operations set that callback is damon_va_cleanup_target(), and it is the
> > only place where the reference is put.  The test never selects an
> > operations set, though, so cleanup_target is NULL and both references --
> > one for each of the two damon_sysfs_add_targets() calls -- are leaked on
> > every run of the test.  Running the test with CONFIG_DEBUG_KMEMLEAK
> > enabled reports the leaked struct pid objects as unreferenced.
> > 
> > Fix this by selecting the vaddr operations set for the context before
> > adding the targets, mirroring what the sysfs interface does.
> > damon_select_ops() fails if the vaddr operations set is not registered,
> > in which case the test cannot exercise the pid handling and skips
> > itself.
> 
> Makes sense.  Thank you for finding and fixing this.
> 
> > 
> > Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
> 
> The impact is leak.  I think we should add Cc: stable@.

I wouldn't bother Cc stable for unit tests.  It's not something
which affects production or real life at all.

I used to be a be more involved in testing and the rule was that you
pulled the tests from the latest kernel and ran them against the stable
kernels.  It feels like that can't make a lot of sense for unit testing
so maybe for unit testing we didn't do that.  I can't remember...

regards,
dan carpenter

