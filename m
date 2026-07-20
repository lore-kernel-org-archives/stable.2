Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F401CD2C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784522149; cv=none; b=uou3k6big2Eqlibj7f2re0yxWj+nxzf6Vb6eAPGa0qn3iW4eEp7VucmkdkRPTAQ2mdVYWouIi6hBzQV/Y9NZttdK2HQ5z8zqJzgCGyER5SVFEAgSg8bW1ECpWD8Sda3yyjch4omAqIM71heQKIqOnfrJncs8LfJftxJ1jp+ZhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784522149; c=relaxed/simple;
	bh=BXVQ4sPuBVkEzNaRP3g2fl9gM9PDXqBht0OqTZ3O7Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBuAW0Sx2Nt75A85QnIycQP0myL4/vTs+hcZQdXX7U9Ra5CjecVs8fnVhGh4LHIlsYq4J7C/ESCsY9JGrXHJDDXVktFchAIi7eCK1X7Xv8BxWWDvJSgw3Ruh9zFT6LPi+tNpDzejzrH9rW5rtNqdoCUR+yIkSgqJn/47zkJsMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/sAL+Zu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/sAL+Zu"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f236418so4804443b3a.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 21:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784522148; x=1785126948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mdWX6Ff2gVM1G5blx3T+Y3zQJjFhvHV4u/q40zy5x+8=;
        b=C/sAL+Zu/T1KyfyQzEQiMioqUeg03d7Lm1/1pgKgNqYQPIP5Ix86cdMgKSP2ny6PgZ
         b+fMAABdvS3yj6S21ILLfQcAaBE59In01VLsAuq40FAPCoiFIT7E195b6duUIhkmDnLR
         i4UvtnbGAlT44ax0RgEZP7JnK6KMDWUhE62i63CP11L6Z9Hzaz3o5zwHEnGgKnBIq5zg
         P44PLRbitLdFiduhPqVL/50qs2VUyS1k9lISnMlflAUnpvtaXtYdeZrHkkYqgBMxidCt
         NAsW9Zt9t7QdyOV2hY/lyro6EKYisDoD177I+xj+J1o7MHnhVq661SUCdWRw6V8ECSMW
         01Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784522148; x=1785126948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdWX6Ff2gVM1G5blx3T+Y3zQJjFhvHV4u/q40zy5x+8=;
        b=tAOGGdBtzK1LoYtu8DN/VIhvR0sn/1yksXrcEDrGTRzmh79oSP61jRi17Ml7l5QqDo
         yuD53sMn1Mg1FpU38tm9gHjCqaooKZnkchuq5MMvmpmXpSjnSRUanuWFXJzBY/y66LG0
         S/8uK47SOEY4i+srg4uqTfyn9VGg6xUdpTXVURincJmIyBRnksQIBlIGHWnV795hw5BL
         kT2T1aReerqaCrKYnfSFZEJ9Pw9l+AELaXvwRZJklAMCLpVkLvT35PilDwuf5ep485zt
         09XHAWfduFb244P6Ch3sN+DQqVAvZ+pUe4Vaiz2r6Jog9ldJSZlyowznLvJYbiH+Cl25
         0IQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpzuv8MPO+4k1GPdQLikE2V/mhUk5/0NXnZ5Y7zEFVPxyedPtTjMvi8qnopNt8EyCNhr/vgGAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLI7FensDu8TdGrmC1i6wXJG6wEpiipl+cxxbJX+R66oq6+GMH
	bhFJhshuOhwnfdV5APvQaQP4TvP8os2VScP26aubZf64Jk3YRcK8pVm3
X-Gm-Gg: AfdE7cnUaVxnoMFOjtOWOczUiA0Fzxmp2Cj+cSbtNDfC6lGRUUF4ZDMNss9zMgBIFx3
	7ssW11QMQlAqWezrtnR2/fuqtHmwzD3nA4+Jhm1Z9ZqdEtE6J0icKaqp+9/wPFj1KLTuHO0jowE
	RNvofO8ZGnCJmy5hOdTui1bflYedH/5au49XBUPW/WGsT/DxG+HnvpL1sUeTdSdirGdeL6XQibc
	+KBsX3yzIHLjc73f5z1yEfeoG7tOigAWzdVDvQYIHOacV6+719trXKlNmqZdglorXCfEX2CxEYx
	HY6jxuaU8qFXEkqV8LCxe+o/pi/Niwgumcgrrd/EYkyFeeVm+I4TJepkC7VmGz5TiGMMyv1Ogc6
	+Y5fyBewbD7B5baAQ+6f9JApNZAQXhyLb8CoJD/O7vgARtdod4FXt2yD39iAElirHafug1DlBJA
	4g5m+bqz/JGpjtGxf2MdKMsZ/an0KvhKetn9401SMeF2+EKWs=
X-Received: by 2002:a05:6a00:3e29:b0:848:7fea:93aa with SMTP id d2e1a72fcca58-84c292a0ec9mr11937266b3a.21.1784522147429;
        Sun, 19 Jul 2026 21:35:47 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcaa0bsm4970874b3a.20.2026.07.19.21.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 21:35:46 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:35:40 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Kiryl Shutsemau <kirill@shutemov.name>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Hao Zhang <zhanghao1@kylinos.cn>, 
	Hao Zhang <hao_zhang_kdev@163.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, stable@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v3] mm/huge_memory: unlock i_mmap_rwsem before releasing
 after-split folios
Message-ID: <al2b9eCBD3Rip7vk@KASONG-MC4>
References: <20260716095424.471052-1-kirill@shutemov.name>
 <20260717195851.609269e143b4b9eb857f2a6a@linux-foundation.org>
 <al2XTQLWB12sJQG5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al2XTQLWB12sJQG5@casper.infradead.org>

On Mon, Jul 20, 2026 at 04:34:37AM +0800, Matthew Wilcox wrote:
> On Fri, Jul 17, 2026 at 07:58:51PM -0700, Andrew Morton wrote:
> > (why is mapping_set_update() a) a macro and b) undocumented?)
> 
> commit 62e72d2cf702
> 
>     So make madvise(..., MADV_COLLAPSE) also call xas_set_lru() to pass the
>     list_lru which we may want to insert xa_node into later.  And move
>     mapping_set_update to mm/internal.h, and turn into a macro to avoid
>     including extra headers in mm/internal.h.
> 
> Take it up with Kairui.  And whoever it was added that patch to
> linux-mm.

Right, I initially wanted to make it a inline helper, since this function
were a macro and later become a static helper, so it should be super cheap
in the hot path. That requires to include extra headers in internal.h
and that looked a bit more uglier and every internel.h user will have
extra header dependency. Moving it to pagemap.h also looked confusing
along size other mapping_set_* helper, they are completely different
things, and this help should stay in mm/.

So I just partially restored how it was before b64e74e95aa6, It was
never documented though.

We can make it a function for sure, open to suggestions on this.
