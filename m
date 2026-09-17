Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242949D59F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673401; cv=none; b=oHulspmQcz8Uidz+M/hrYJQgn1gHNjAp1LpaZ9URBHZTV+m+6i8QyvK7zJRhnJ9x008rrHckOZm3I5VMWCgqCngt0UhMm4diknvzEvzpNmwdqLmHMrNbYN8qMc3ut4N8MGu7VptkNXa91pYTHjOU9bNZOPoKOpyX7ri3gJ5Gla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673401; c=relaxed/simple;
	bh=pGb3Vp3ZlWEKZyzEIIGwbv44vQfUSndTLfijg7KE4eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdEnebnZPJrXDKXBk0SmU9t8JDZbyXS/oGWdCrKn7QmrCUexK1/3LQftOfHLpGY54QVGmr7CssXLTQz84wC6tKBPIA3Y+S8mcud/AMI32Op3VHM1h1xW8gOnRkfUSKinmFmugBHnNMXdluvROX+O+Eylr7BP//6DZ8BLawQOZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Une9NNSK; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Une9NNSK"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-80a854e5b3cso630700a34.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673399; x=1790278199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SOpmSpu+1kSYFLkQThK4c6ymQH45Iak6v9IcQ+Qt0zg=;
        b=Une9NNSK+ZcdqGGjnf9j//FSY5QqvHJNeYQx+knGBpY5wdVxrRbIOkjTXPO04/gQ76
         tW7Q0ckubYcnZmtx1UPDWDD975VjF8Cxx51HpYcI+NIK7dxwSEsL3ecdzy+9oBzZRXkE
         H6R5yonyjr6GL88iRcvVb+/gxM8tNoMVpD8lclIMXhDiZCNfvfifHsBouD6wbPZOAGnN
         ma0sJNwTD/EEkgVnnCvNnw162g9WlzOr+pZGlg2C0elhEOlb9Kz5hMmK4+LqB3vbJcOt
         3TSlQUMQMM/zIEc1PJYM2Y/LW6J/u9/NypKQbL9GV2D5VdoD8RfXPFVkJSxIn5D5Qkv5
         AuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673399; x=1790278199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SOpmSpu+1kSYFLkQThK4c6ymQH45Iak6v9IcQ+Qt0zg=;
        b=iAhzhOKT0vYcaM1O7sh+Jeoqb8pB3Mj1euiDYcQBVjE7stVeXJ4VDc3GuAmzz680Br
         8GEVADobEz7BdqAFrGAyvWG/mQBBAJ4PmfAK1QcuT6fXPgAuSn/RavOijpFbaJ+pTNxv
         LdJamlvoPR3oZbJBSJyLXD5p1xTvWFwR4qcWXzmGqDGtR6RkpqHpkViODz3UflIAgaWZ
         3FcF9naTNsDkvppoc7e24DQPbRHlxAC5ZcWHWDlBar4XIxi+dkF8bB+tnnj0nEOvt/qw
         DVIAgZpg5OMw0QnztPZvd33ljNPj2jJZxcRyMVsTQ03uxwgIhKAxPwYWOxllmOl2y+Kl
         gwmg==
X-Forwarded-Encrypted: i=1; AKwUvBypu1o46lFssLAelarBOrlQpLhdLrVNyvR/yzLbQXpoxGWiSYW6aL80KdvkvEw5tHhLeS+liMs=@vger.kernel.org
X-Gm-Message-State: AFuF++lGq/g0kCrcktPRr3T9Qmb8LnsNMpXM/mW5Qux/Nw70FV3T4yX/
	Fs5gMvfHysAsBYAIzvftApuaJArxDWB9hLZ4YuT3BS356CXoltpHFKvv
X-Gm-Gg: AYBFou3Pquc/YQ6/xTiramUerIyBJBt66hiQ3p7fKgjoJWSucDRewRzizNcDo9auQTe
	GCwzFkrAJgTfENfEmqzSfVU7hwYEOrbkZ/CKup+hE3UvmNQouGThs78c/QyDqHQvthq6Uulhjbk
	1AIuJFE0QAwFrPVymmW177wsoPyvrsC1VZP/bxipvt6WJ42vz0bGlFE83t0Hdo2chS2dnz9+/Ln
	jP71dxYcxwQ6jtbasxRnhEMA02U31G6Aah61s9xCO5fGjQK2rDNmraEGolGAtSaAISZ9iCmkkYW
	BVqtbLHoCS8at98I3jJe6ei8w1EPWKbMFdLUDQsdspIXIYwXmRv1ysGT4WJkIqHIQuP25lRcGFE
	svZOwaWrtXZAohxFiIgsMAEdsizXoPB5uPDC7Pt3pHM+2WILw5l9DfwuTK8vpTvr/Ldg8TAsDLG
	YoJsZzEws5xnpTu6hN1SuMQP3XjBBdgnDn5n4Oaaqq0iVZvH1ecQc/xUI7z9sCQNPlGP10bWGG0
	tZAPuI/nWSrXXhyQPsSzUM5Hb8yVIz8GwZ6nwvf
X-Received: by 2002:a05:6830:43ac:b0:80c:d30f:974 with SMTP id 46e09a7af769-80de21d1f84mr119151a34.21.1789673398952;
        Thu, 17 Sep 2026 12:29:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c474d1f0asm3732953a34.24.2026.09.17.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:29:58 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ackerleytng@google.com,
	Alex Shi <alexs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Hongxiang Lou <louhongxiang@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	fvdl@google.com,
	jthoughton@google.com,
	rientjes@google.com,
	vannapurve@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Fix HugeTLB subpool used_hpages tracking
Date: Thu, 17 Sep 2026 12:29:56 -0700
Message-ID: <20260917192957.3466978-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Sep 2026 20:13:07 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 16 Sep 2026 16:39:00 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:
> 
> > HugeTLB subpools currently only track used pages (used_hpages) when a
> > maximum size limit (max_hpages) is configured on the mount.
> > 
> > ...
> > 
> > This series addresses three problem areas resulting from untracked usage
> > and asymmetric error handling:
> 
> These are rather serious-sounding problems.
> 
> I'm seeing Fixes: for 10-year-old patches, for one last year and one
> this year.  The fourth patch doesn't identify what to fix.
> 
> So if downstream people (-stable maintainers, others) follow our
> recommendations, some kernels will get two of these patches, other
> kernel versions will get three and some lucky kernels might get all
> four.  Are you confident that the patches can be split apart in this
> fashion and still produce a good result?  After all, we're sending
> downstream some patch combinations which we didn't test.
> 
> Also, can you speculate about why these things took so long to
> discover?

Hi Andrew,

I'll be brave and admit that I knew there were hugetlb accounting issues
for a while because I was seeing them at some ~rare~ frequency, but
I couldn't figure out exactly what was happening and didn't report it. 
In my defense this was before LLMs were doing a good job of finding
bugs in code ; -)

So I'm very grateful that Ackerley took the time to find what was
happening and sent the fixes. 

> Ho hum, complicated.  Let's at least slap a Fixes: on [4/4].  My
> trillion-dollar sidekick suggests a9e443086489 ("hugetlb: disable
> region_add file_region coalescing").

I just reviewed the 4th part, I'm not sure if there are any
userspace-visible changes for this. Maybe just an additional retry for
allocating from the global subpool? 

> Our other little friend is talking to us:
> 	https://sashiko.dev/#/patchset/20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com
> 
> I'd like to queue this up promptly because it fixes things.  But let's
> seek additional review input and argue with Sashiko before taking that
> step.

Agreed, I left my reviewed tag on 2 & 3 but it seems like Sashiko is
raising some concerns. Ackerley, any thoughts on those?

Thank you as always, Andrew!
Joshua
