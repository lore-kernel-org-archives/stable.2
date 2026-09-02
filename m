Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7414AF9D5
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388325; cv=none; b=iVquhHlyU9o3wesR0xnsO2GUQYJdPvVYoDD5neIDB0J8T76Z0KMZRxtY8rHcfd6qzeMpdck0LJYolC8kp9xJxs6ZH4vlCZDm1vw35OqIG6Cq+9/ppSUSW8j6LGyHBvYacVGrvlgYRg9OaEXcVmb35X6O5+5l+1etH9EzQy0rq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388325; c=relaxed/simple;
	bh=x8QTwaBEHlbhTlyYUzQ6IcB4eonbQnCoTFLiMiKbeBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhRHHt/8MNbWFKnfPMgP8tz/pY76ob9ZeTVX+bp5S2WmLKSWprXco4ZD1g4IkK937MMzLFY+/2zQB9lZrVLxSc78fQjUfeZWYLUUB8xY0fs7WzRnJgsvJWoh3Px5bR6eHKmp7v9PDiiA5ZOwrAEssItUUoXut6aR2t0aayuNfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrvpzSAS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrvpzSAS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d9db539a54so15349355ad.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788388316; x=1788993116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rfj489snHAgcjqYCzxpw7R2gTXTEyikU7ldTqChZJq0=;
        b=XrvpzSASKQ00rbxTOxlq96kjdY7zgt96Q7c1PvhhbROuBQx6uQ+3/MffvSgRBcmBpk
         q+am6QEGd7IpTAHInsorsr0JUq/XUQxmbZYo1lqLfd7OX3aUogCI2QWjQcSrgGaMowHP
         N3FLIyPbo2vX0/rm+17v18TaSFvSTndTHNYWFdMfd54tPg1zD3GjExtzGDMlKeQcLnZi
         O9Z8ui2fCAeZBPG2sOqMp4P0XlPT5o3G2RMfsgryqhU9rTvwxseP9gW+NMhwSUKKNcVr
         CyfmedUn9DvsgXGxDTFJ3pT9QG18taJBiWDDtYBH2e5pPuA/PIMTKR8BIikXd+9yXf5J
         U7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788388316; x=1788993116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rfj489snHAgcjqYCzxpw7R2gTXTEyikU7ldTqChZJq0=;
        b=UKho2bmcvLJmEtNIGiQBScCj3Vx/fUVEPLaOVaL+0vs3+LKIi03y7yBAfHa6eEnBjR
         BYks6m+eAdD/czs+wll/GCL7Hf4IE2asSC2rLqfB9eheHqM3QHBs8+ujuMKKPJZCb8Tk
         gpTJjHFsrYuBdEF5vHcToeH6LNMRh4GCNvIz+1pU8E3YfDBVNDTmtzSXS/bdG7T+BSGt
         TF5+A1JSevEcOPGcHfTzURC/2ICJ4Tv2s3G5OKF4myOcj6i9bWWjbheMeeJkUfqWufj7
         LujQlB7IV9+OgDOZc/pEXdyi3R7FbC7GbnVVfBUt6FOtJLNFuy2hcz+4+NfhNE0K2JNL
         RdzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZjh20nKsIpkj6ZV3N9hdR/qUKkvZj1s6RF7rbnMNlmO6Clg7D339Ypvretb/JxG02C7bioW4=@vger.kernel.org
X-Gm-Message-State: AFuF++mC7V4oIzi1k6lovnk5g+WN50gRwR25ZYgI+hfoSR7aVVEE6oQi
	kZd4yAiKHmtTu+8hi1f+0ijZsIuo9yA5JQsKd7A5ayM9d0THY5gYW7t3O5HnDw==
X-Gm-Gg: AYBFou3RBm+2MkAoZdW9BTqDiEG94I09X8sWLqp0/vkNM4JCsfRHlPY30G4y70/RE8C
	1Txm8BA60/2JRtO+FlKAHdAAqT4dATD7ImlSO2OjDWc4LYRfOjtBNFxqs/ZeF7OHOG5XZ+1OXkC
	TS0jn6ikdjk2Pei4U6VPCZzw9e9roNkF2TJ1t6j+Rp7R0eOkZXpoNuLrdjumhG2wx/ajpPbkwYX
	RbQH0COA3tTgUfoD38GrWxLX7KbBd1D2Qa3QTgJ89zMEJ1gQOn/v0W7kZSgSr1/pQkxijKdPsZx
	+JXNGFi5guUNeKlo+H8O1IQvx2fh0vZUG8Y7fM9Ylk+AlcCnuGLPEdwLiW1mGnMdKOYMGElQUjh
	1dduLk9vfm8dIUEUxEO4VbZ8Ygykn5fBIvZXbnOSBnlj3ABbuUedEY1Wdlr7EeT3nxFS3VtRS4g
	EEm+3jtWhfxgBFGf1ugu3nzMln+Nakt1Y/NDa2R3S4cAzdbs7hpH3ZlnGRdxoq0niS
X-Received: by 2002:a17:903:1a0d:b0:2d8:d4d3:da50 with SMTP id d9443c01a7336-2daec7a70a2mr111190875ad.20.1788388315442;
        Wed, 02 Sep 2026 15:31:55 -0700 (PDT)
Received: from celestia ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe0e24basm1215945ad.2.2026.09.02.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:31:55 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Thu,  3 Sep 2026 06:31:38 +0800
Message-ID: <20260902223203.14871-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902144804.88298-1-sj@kernel.org>
References: <20260902144804.88298-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 07:48:03 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 22:22:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Wed, 02 Sep 2026 07:10:00 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > When setting goal_tuner to 'temporal', if the goal is achieved,
> > > > quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> > > > will always return true, even if no regions have been tried to apply at
> > > > all.  This causes qt_exceeds to increase unexpectedly.
> > > 
> > > To me, this looks logically correct.  Could this cause any user issue?
> > 
> > Yes, I think this might cause unnecessary confusion for users,
> 
> If it is _might_ kind thing, please ask questions first, or add RFC tag at
> least.
> 
> > at least
> > it did for me.
> 
> If it confused you, definitely we need to fix it.  But if it is just confusing,
> let's try to clarify by adding documentation, rather than changing existing
> behaviors.

I agree that we should avoid unnecessary code changes if the issue is
merely a matter of confusion.

However, I believe a code change is necessary in this specific case,
rather than just adding documentation, for the following reasons:

First, this distorts the semantics of qt_exceeds.  It is a statistic
meant to track actual quota full/overflows.  Incrementing qt_exceeds
when the quota is completely unused (because the temporal goal is
already met) misleads users and could break user-space monitoring tools
or scripts that rely on this metric's accuracy.

Second, considering its original behavior when it was first introduced,
the recent changes [2] have inadvertently altered this behavior.

When qt_exceeds was first introduced [1], the conditional check was:

    if (quota->esz && quota->charged_sz >= quota->esz)
            s->stat.qt_exceeds++;

Later, to handle cases where 'remaining quota < min_region_sz',
damos_quota_is_full() was added [2].  When this function was added,
quota->esz was replaced with !damos_quota_is_set(quota).

    static bool damos_quota_is_full(struct damos_quota *quota,
            unsigned long min_region_sz)
    {
        if (!damos_quota_is_set(quota))
            return false;
        if (quota->charged_sz >= quota->esz)
            return true;
        /*
         * DAMOS action is applied per region, so <min_region_sz remaining
         * quota means the quota is effectively full.
         */
        return quota->esz - quota->charged_sz < min_region_sz;
    }

With the introduction of DAMOS_QUOTA_GOAL_TUNER_TEMPORAL [3], quota->
esz == 0 carries two meanings: "unlimited quota" and "should not
be applied".  This overlap causes the damos_quota_is_full() check to
return true incorrectly in the temporal goal scenario, leading to the
false positive in the statistic.

> 
> I feel like we also found similar case that people send patches to change some
> behaviors that confusing them, but not really problematic.  That sometimes
> waste unnecessary time for understanding the intention of the patch.  Please
> feel free to ask question first, if you found some confusing behaviors and
> don't know why it behaves in the way or if it is a real problem.

I will ask questions on the first in the future when I encounter
ambiguous behaviors, to ensure we are aligned on whether it's a real
problem before drafting a patch.

[1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
    (Fri Jan 14 14:10:202022 -0800)
[2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
    (Mon Apr 27 18:33:50 2026 -0700)
[3] af738a6a00c1f ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
    (Mon Mar 9 18:05:19 2026 -0700)

Best regards,
Rui Yan
