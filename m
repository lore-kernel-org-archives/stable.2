Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049847;
	b=DBp+mne+biulID7LHn8KA+JpZUiF90t1z2cDkVXeBHgKmikSh+BAqN6AMlfyGvwBqvS5
	 C2TUKSlPAVkuqT0WKm72Zbo/yagyURCxvpcPq0G3oBRApV93G9F1aszWJ9n6jXclQWu1b
	 EDgv2QDafE0gW8H1wEiT9VCae8QKYt4rlatLbr3mZsjrldddF7UxN9EiVHXlLggP5ktgS
	 N0d5eXF0/tGHDMdyzOLl1rbcnyV4al43ROwixfcKN8PUmAETdjbxC1P6fvM4X4+R0N42W
	 TgCCr9E1o9aE3VgDs6n4dsMSas/KOq7A7dik0B6S7IYgk2Rip3+eMOQ4MjWw6G5p6ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=5H3XFudOIVUpfowGZGMfKOHChQPyfvsUBh9VsbVmyjQ=;
	b=bqbK4tQx+o8QDvPOz2ae8LQAVJ/qXv/nO8UGic4FR/A6TqVfcoZkbWNOI1JCBuiav9l2
	 dUVn9iKzr/juGho1lf+tpdjfwmXwEjJamktaU5v715ywGBiNPzT8hjlVSPa0Pki/Ux1d5
	 RC0hKxNWzymmPILz5yT8btr9OP/3MtDufkT2Lt7uT1pkWAD5EDbkT0jUJHkiUiTEmA/zK
	 tutwTntaq5jQrex7iYc7kknkJWGWTTdc51XlTGXBJ96veJNn6pA9YeLSp18m9mdOBrvXD
	 Q3qd/mCqKOhr2adUMob2XQyRSgzLTYPP/19kLUp3lShejaIthZfVlRmdowvjEOAJshQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Y5bP7viH;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CF606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C6CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Y5bP7viH
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93cb9e9405fso163449085a.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793049846; x=1793654646; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5H3XFudOIVUpfowGZGMfKOHChQPyfvsUBh9VsbVmyjQ=;
        b=Y5bP7viHjKXlpjFXbRwohniuB0ZmS69xoZxwCocvKBVzzp+gPK+xkTX/shb9wVgqRm
         fTC4kHMENGNuFoUb9eERqKTqQEWkaV8oyl+WHPncnpV5SrrhlVemCOvPqByQD37gTMAm
         DiwngHdusodUnHz9V39ynTWouJV7GQKWEAmkfAlV+XVzFy9qbKxmp2tlm6qu5q+qMffL
         twX0F3oxzfouC78MrMma6fDM4bh8edkE64tq26GmEHW7pfCMfBsjpwJa84vw4nxq5y7J
         ZeB4JrEfeljl+i0PdZGID/N2XL02ItrOl6V1CgYMZq/ZDekdLF/INzIz66n9CjsYNKaR
         /c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049846; x=1793654646;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5H3XFudOIVUpfowGZGMfKOHChQPyfvsUBh9VsbVmyjQ=;
        b=1hzNtFtxSk8wa+6RxvDrHwnjktzRwvmvOgTr/fnxGDVkcHUU5xSu4EkDGeHpiWUfhP
         l7nuKMVWipYbZzpDP7PHTcvAtIgERtXcZ54cYojaIGzJScsIKd92Ea1AOhu7kO+UDArq
         DDVar0ZWhSta6cQ/y8JXRyJeeZU+XwS2pATv5JxNw5pQY2UmFxhqv7ezRr0uoasPgZx4
         G8BUSBIYLjZMR4KgUAyf/SPl5L3XA2QPTZYH5F20b8ulCY2yVIbM4zLACp6cPRlKZxd6
         kE2mht7phlwc2wfqKYzXXprT8CfBJig9ld7SAFvlTAZolRFpYKDnpj0Rukr+4s8pOI7U
         EGMw==
X-Forwarded-Encrypted: i=1; AKwUvBz4VbSBsHOLGQ2G+A2cVhD5FZNmqAMtyPhoHlV1Lrbuzrjw1BDXrIrUDlapj1nYFseEc4vZQGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIB+Y35q2823oxo4juexlZk/lLi7+WI0AAYyj0BtolsJUybZcTI
	02tp+kla58kGw5wtQ/301BnCCoknc1I2zzT90+PkSFYfazoqCy+rqiyAAtdnInclW4w=
X-Gm-Gg: AYBFou3Y1TiG+JclxwdBDHgbtt3tqs1REfPTowFW2eHawdDwm8dPI3D2U6/HeaSmBz1
	sltBC39aDknTt9cPg68hYlW67PcArPUw6bbXWquvh2MzlO2LkpDqmrtsB86v+i7oXpNu4rrvuCV
	huyaKuf5JwYtQPqOtopogtgGFkzwsbB9F+V5jCOzacYalp+4D0ABUKzUmwXgsr2YuCmAdnlB1Za
	Nlagy8zP0YU+S2MZIfkD2F13x9GKLlTPOuNMkSwk5XbQljsVlhIJg9wqTUJ+uofXYtfS3cyetbF
	IS/T/3DWB9sA38yStHsfr0DCh6hUJFrTxJDfJ81j4G1L+P63OzzVNviKsc6lDSlQYzqARL4EGmy
	Au2jvLzuuBs1PTz7/Rh1h+RU2S5vznXhj9oZpCbzFvDYA5eHg2yxdWc7GIBEos/Hw7mzqx90vSu
	kyXNtldFIQFkmADRukiZqaRb4wRq3kxF8s/5icTf7BbU8vl2P3uYylSx8FizUJV1DYUi8/rFFf8
	nNtK9227++Nl9rbv9EbCyux2jNAT5aZC1gCJIyDpv04EkKFo0DssP/AQxu2efZnCo57Hg3vJNlY
	nGg+GPeM1sFygIjbF0XbrBFXwGI=
X-Received: by 2002:a05:620a:2603:b0:93f:565f:e46 with SMTP id af79cd13be357-940ef97fb6emr1203588085a.52.1793049845808;
        Mon, 26 Oct 2026 14:24:05 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a78c06sm789620285a.35.2026.10.26.14.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:24:04 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/16] mm/shmem: various (urgent?) fixes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
In-Reply-To: <5d10eba8-11cb-4031-84e1-a394ca5b4cba@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <at-yaxmjeOXtA15M@gourry-fedora-PF4VCD3F>
 <5d10eba8-11cb-4031-84e1-a394ca5b4cba@kernel.org>
Date: Mon, 26 Oct 2026 17:24:02 -0400
Message-Id: <179304984259.319828.7383468637599462048.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-26 22:09 +0100, David Hildenbrand (Arm) wrote:
> On 10/26/26 21:08, Gregory Price wrote:
> > On Mon, Oct 26, 2026 at 10:40:33AM +0100, David Hildenbrand (Arm) wrote:
> > 
> > feel free to take or leave the selftests.
> 
> Thanks, no time to polish selftest ;)
> 

It's there to show the work more than to merge, but the long-term goal
here is to feed these tests into a larger session that does the polish.

Fixes: -> Tested-by: -> Analyze -> Proper Self-tests -> Upstream
                                   Or unit-tests :]

Usually these tests are not things we want to test for long term,
but they do help define the contracts we DO want to test.

~Gregory

-- 
~Gregory

