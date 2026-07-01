Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1E2D5408
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924394; cv=none; b=B4sZknB+yu5jCwaZQk3tR6DDIAT7AVB8pmS7uLpOXQtqARZ89Q+gG4p+hSBiKcJMMb3CYaCRA0xtr96OLG2ztro2xZMWJohDv0YT+7u4Rny9iYfs+r333EvgBRSnnc9dHct02g/TDZpdvFduJzU1EbKqnlIxJQn24Kxfq5jPsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924394; c=relaxed/simple;
	bh=3ZkG23Ahcwd+RsFfsoFpsMvSdVlXU9LOciY+aV8yYQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU3YlI7TtzxdlGZE8S23+jSZwGJMGBEVOM41AODUzHKygNNTE9IFJO+57L9nkyCArEpjrg3Aii/uIuaFdSPSIIEulPwGuzP46Zd1xrJhNRZRAIvPuboetWkjPThueg5nfxnzFleWC51RH4pykNhZBq/L+qRYa5nJyKT5g9eGmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx7VG+rX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx7VG+rX"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso878678e87.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782924390; x=1783529190; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cdd9rY5oP30RnQMgnsEDsM9Bt8UvFzdvGQmBfn+/Lf4=;
        b=dx7VG+rXjxPMYDZDFUTBFvuNxyXBzahMlDFKuJX5BDkdWqguLLJ5MfYmNXs7wpVxKC
         AWvQ6n+bgT1Ks429Ky73JXg4LrBaOm+CJAvAcJw8s2MqDem0Oslkv3duD8BILwgfMeTs
         cOMqiHjx/sKoO7SSwOGqV2ehONIKmhfJcZFnYlcWMk7jyBQjf0Lu+KYzixX5W1ONbEmc
         0mKcsk49laV1vMG1OYomqcWLJ5tuMi+7Az/rgL+GqfNXuIbq0lTmnHhI47SPtCxHsx6U
         i1qawXpD3jc3oeP0lv5yZc0yj2GCjUP+YVD+INICIwstElCYMqeUSMhdSrVD5ITnnXZ9
         fiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924390; x=1783529190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdd9rY5oP30RnQMgnsEDsM9Bt8UvFzdvGQmBfn+/Lf4=;
        b=dzK0JoLZNW0yP1ZYM5FAgSKs/Fh7CqPGv5eeIMg6PLe80OS6bggLMipOEGP5fd4a1D
         aenWfEa2JWuebJENbvGMeEoC8tztBsVAzqkSqh5fFxJiB3F109uprr5Ru8U62i5Q78bg
         RtQjn7M+hopQ7Joxs52+uoB8lzWgAI9MglnORE435my/kUAsavUfW+k5Zidw3Dhx602+
         uty0z33+p0blxK33UIxTUBxH5V8VGAr2jI0Iktf8FS6N67rZ4q6oBQqIpRqdAtE6VzNg
         MztZxMA0/HGeyzZ7DOG5GlnZAhYbiCr/jzdF7Gam7JAHeCpNU1TcFMpvrA9srZTo4rlP
         L+dw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5VIGm4ebziI16dNBroGt0+5wT/ViR37SbgeCq4JAOdMQdY1TkSmOEEgkoA8fMSu3beCPydqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7JueSRcAlDVI5KgvFKxYn3LIBodIDZGlzwvgxtHL+2xChK8V
	QToiB4Mo4fyphmSuXiAdsyc31/6SPdZvh6L9xNg+k3oz14o13PFaRToY
X-Gm-Gg: AfdE7clwrcjrPD2TcTk97T9vq3OEwiwiu/we7NExvf8ciOgciqDGirzoIIFoS8PhwcS
	3ajv8XBng2UpFAXjvitx8SPAAmclpoj12O37MIf1fMw8nZoMwKD1bfMt1umjFsITj9pZiREvLyV
	tiHiJxVV2xBA+DUDnu3VgY0tT62cvqWwLpFDB5TvXP5+FXkfJ7DEBSI3kARia5yGmXdcdOLgv58
	5tfCq3VobftWQczd1hd8Wv9QAOxf1LsGGKX66eA+zhue/7Z5n/9BRKyqxVhkmAx2kSuyL6mcslj
	Q30L0W4P90YSrGOyKldyt8zyvtaX93+SewBC0bEUmtZaR892DY3GHTNj5c1QPxe6yLxG+fcHwek
	mwyZemfBWzXl+ll6d0kHTukXUpWu+1qH2huLKDSJUE7IiecUA0hqD887HsR1mwEYvQbagv9L9Nz
	TWZ6Xb3sRrNCvaJp+C4525gl7LYTE4mhqwNs1jNA==
X-Received: by 2002:a05:6512:22d8:b0:5ae:c099:a92 with SMTP id 2adb3069b0e04-5aec68b7ea8mr494950e87.42.1782924389903;
        Wed, 01 Jul 2026 09:46:29 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec894e5afsm140232e87.0.2026.07.01.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:46:29 -0700 (PDT)
Date: Wed, 1 Jul 2026 18:46:27 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: david@kernel.org, richard.weiyang@gmail.com, akpm@linux-foundation.org, 
	ljs@kernel.org, riel@surriel.com, liam@infradead.org, vbabka@kernel.org, 
	harry@kernel.org, jannh@google.com, balbirs@nvidia.com, sj@kernel.org, 
	ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [Patch mm-hotfixes v5] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <akVDNLGaCfr-PF8K@soda.int.kasm.eu>
References: <d4e4180e-dcdf-40e6-b5a2-2ac55f4aecc4@kernel.org>
 <20260701163356.22936-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701163356.22936-1-lance.yang@linux.dev>

On 2026-07-02 00:33:56 +0800, Lance Yang wrote:
> 
> On Wed, Jul 01, 2026 at 05:36:33PM +0200, David Hildenbrand (Arm) wrote:
> >On 7/1/26 16:33, Klara Modin wrote:
> >> Hi,
> 
> Hi,
> 
> [...]
> >> 
> >> This results in a build bug for my Raspberry Pi 1:
> 
> Thanks for reporting this!
> 
> >>  In file included from <command-line>:
> >>  In function ‘check_pmd’,
> >>      inlined from ‘page_vma_mapped_walk’ at /home/klara/git/linux/trees/bisect/mm/page_vma_mapped.c:256:10:
> >>  /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:702:45: error: call to ‘__compiletime_assert_433’ declared with attribute error: BUILD_BUG failed
> >>    702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >>        |                                             ^
> >>  /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:683:25: note: in definition of macro ‘__compiletime_assert’
> >>    683 |                         prefix ## suffix();                             \
> >>        |                         ^~~~~~
> >>  /home/klara/git/linux/trees/bisect/include/linux/compiler_types.h:702:9: note: in expansion of macro ‘_compiletime_assert’
> >>    702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >>        |         ^~~~~~~~~~~~~~~~~~~
> >>  /home/klara/git/linux/trees/bisect/include/linux/build_bug.h:40:37: note: in expansion of macro ‘compiletime_assert’
> >>     40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >>        |                                     ^~~~~~~~~~~~~~~~~~
> >>  /home/klara/git/linux/trees/bisect/include/linux/build_bug.h:60:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
> >>     60 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >>        |                     ^~~~~~~~~~~~~~~~
> >>  /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:113:28: note: in expansion of macro ‘BUILD_BUG’
> >>    113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> >>        |                            ^~~~~~~~~
> >>  /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:117:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
> >>    117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> >>        |                          ^~~~~~~~~~~~~~~
> >>  /home/klara/git/linux/trees/bisect/include/linux/huge_mm.h:118:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
> >>    118 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> >>        |                          ^~~~~~~~~~~~~~~
> >>  /home/klara/git/linux/trees/bisect/mm/page_vma_mapped.c:142:20: note: in expansion of macro ‘HPAGE_PMD_NR’
> >>    142 |         if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
> >>        |                    ^~~~~~~~~~~~
> >> 
> >> bisect log:
> >> 
> >>  # bad: [be5c93fa674f0fc3c8f359c2143abce6bbb422e6] Add linux-next specific files for 20260630
> >>  git bisect start 'HEAD'
> >>  # status: waiting for 'good' commit(s), 'bad' commit known
> >>  # good: [dc59e4fea9d83f03bad6bddf3fa2e52491777482] Linux 7.2-rc1
> >>  git bisect good dc59e4fea9d83f03bad6bddf3fa2e52491777482
> >>  # bad: [6148219e90732fd06f5d7a498bda974e6a43ab4b] Merge branch 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
> >>  git bisect bad 6148219e90732fd06f5d7a498bda974e6a43ab4b
> >>  # bad: [e0326ebe10191447ab8fa2e904080df7b743765e] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
> >>  git bisect bad e0326ebe10191447ab8fa2e904080df7b743765e
> >>  # bad: [fbc9c5ac47cef5a2b04aef30c8e990b32dcf2548] Merge branch 'hwmon' of https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> >>  git bisect bad fbc9c5ac47cef5a2b04aef30c8e990b32dcf2548
> >>  # bad: [e488171f6f6df6fc899a355079665fdb3c50b0e3] Merge branch 'for-linus' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> >>  git bisect bad e488171f6f6df6fc899a355079665fdb3c50b0e3
> >>  # bad: [60db0fcb8fc9d80ac0b63041c632b41a311a45f1] Merge branch 'fs-current' of linux-next
> >>  git bisect bad 60db0fcb8fc9d80ac0b63041c632b41a311a45f1
> >>  # good: [51021d260d682aa17b3533848a99160ab83e0c93] Merge branch 'vfs.fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> >>  git bisect good 51021d260d682aa17b3533848a99160ab83e0c93
> >>  # good: [ded56474db6552260786a65898322464b72c7540] mm: a second pagecache maintainer
> >>  git bisect good ded56474db6552260786a65898322464b72c7540
> >>  # good: [6c893b948351d42cfc3761cc746ab5b3d03ee7f3] Merge branch 'misc-7.2' into next-fixes
> >>  git bisect good 6c893b948351d42cfc3761cc746ab5b3d03ee7f3
> >>  # good: [bfcc55a14179495b0c41408908fd7b9d7785c694] lib: test_hmm: use device devt for coherent device range selection
> >>  git bisect good bfcc55a14179495b0c41408908fd7b9d7785c694
> >>  # good: [a27318567c92ba5482906d047e71a7aa4fd01889] Merge branch 'fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
> >>  git bisect good a27318567c92ba5482906d047e71a7aa4fd01889
> >>  # bad: [6887a39652cdfd4cfd3b0962662c9cbc26ce5252] mm/page_vma_mapped: fix device-private PMD handling
> >>  git bisect bad 6887a39652cdfd4cfd3b0962662c9cbc26ce5252
> >>  # good: [2cc6bd0efc264b9ac760c2bc74dff4f521a680a1] MAINTAINERS: s/SeongJae/SJ/
> >>  git bisect good 2cc6bd0efc264b9ac760c2bc74dff4f521a680a1
> >>  # first 'bad' commit: [6887a39652cdfd4cfd3b0962662c9cbc26ce5252] mm/page_vma_mapped: fix device-private PMD handling
> >> 
> >>>
> >>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> >>> Cc: <stable@vger.kernel.org>
> >>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >>> Suggested-by: David Hildenbrand <david@kernel.org>
> >>> Cc: David Hildenbrand <david@kernel.org>
> >>> Cc: Balbir Singh <balbirs@nvidia.com>
> >>> Cc: SeongJae Park <sj@kernel.org>
> >>> Cc: Zi Yan <ziy@nvidia.com>
> >>> Cc: Lorenzo Stoakes <ljs@kernel.org>
> >>> Cc: Lance Yang <lance.yang@linux.dev>
> >>>
> >>> ---
> >>> v5:
> >>>   * put device-private pmd handling along with the other two cases
> >>>   * remove thp_migration_supported()
> >>> v4: https://lore.kernel.org/all/20260624065353.1622-1-richard.weiyang@gmail.com/T/#u
> >>>   * refine subject and commit log based on Lorenzo's suggestion
> >>>   * put pmd device-private entry handling in its own if branch,
> >>>     suggested by Lorenzo
> >>>
> >>> v3:
> >>>   * remove cleanup part, only fix the issue for device-private entry
> >>>   * refine user effect description based on Lorenzo's suggestion
> >>>
> >>> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
> >>>   * specify the possible error case of current code and user visible effect
> >>>   * besides fix, cleanup the pmd entry handling based on David's suggestion
> >>>
> >>> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
> >>> ---
> >>>  mm/page_vma_mapped.c | 30 ++++++++++++++++--------------
> >>>  1 file changed, 16 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >>> index 2ccbabfb2cc1..2d6c58488e3a 100644
> >>> --- a/mm/page_vma_mapped.c
> >>> +++ b/mm/page_vma_mapped.c
> >>> @@ -243,21 +243,30 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >>>  		 */
> >>>  		pmde = pmdp_get_lockless(pvmw->pmd);
> >>>  
> >>> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
> >>> +		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
> >>> +		    pmd_is_device_private_entry(pmde)) {
> >>>  			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> >>>  			pmde = *pvmw->pmd;
> >>> -			if (!pmd_present(pmde)) {
> >>> +			if (pmd_is_migration_entry(pmde)) {
> >>>  				softleaf_t entry;
> >>>  
> >>> -				if (!thp_migration_supported() ||
> >>> -				    !(pvmw->flags & PVMW_MIGRATION))
> >>> +				if (!(pvmw->flags & PVMW_MIGRATION))
> >>>  					return not_found(pvmw);
> >>>  				entry = softleaf_from_pmd(pmde);
> >>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> >>> +					return not_found(pvmw);
> >>> +				return true;
> >>> +			} else if (pmd_is_device_private_entry(pmde)) {
> >>> +				softleaf_t entry;
> >>>  
> >> 
> >>> -				if (!softleaf_is_migration(entry) ||
> >>> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
> >> 
> >> My only guess here would be that the compiler evaluates
> >> !softleaf_is_migration(entry) to always be true and optimises away the
> >> !check_pmd(softleaf_to_pfn(entry), pvmw) which is why this worked
> >> before?
> >
> >Weird, we enter this path only with
> >
> >pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
> >pmd_is_device_private_entry(pmde)
> >
> >If any one of these would compile for !CONFIG_TRANSPARENT_HUGEPAGE that would be
> >odd.
> >
> >pmd_is_device_private_entry() is hard-coded to false unless
> >CONFIG_ARCH_ENABLE_THP_MIGRATION. Which is only selected with
> >ARCH_ENABLE_THP_MIGRATION.
> >
> >pmd_trans_huge() as well.
> >
> >Maybe it's struggling with pmd_is_migration_entry() on some (older) compilers?
> >(not innlining stuff and not properly optimizing it out).

It's a GCC 16 cross-compiler for armv6 so I wouldn't call it old :)

> >
> >The whole conditional must be optimized out.
> 
> Right. Kinda weird if compiler didn't fold
> 
> pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
> pmd_is_device_private_entry(pmde)
> 
> away here ...
> 
> >We could check for IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) right at the start
> >to make it easier for the compiler:
> 
> +1, explicit THP guard should do the trick :)
> 
> >if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) &&
> >    (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
> >     pmd_is_device_private_entry(pmde))) {
> >
> >
> 
> Klara, could you try with this change and see if it fixes the build?
> 
> Thanks, Lance

This does indeed make it build.

Thanks,
Klara Modin
