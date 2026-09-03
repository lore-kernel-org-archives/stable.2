Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC644A6CD8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439457; cv=none; b=J2r1W7N0xU+rWwebtvVsXkvzr+TLoEgbnIKq7MtWKNM6K7U9oPy0kGtOsqPYRqr+/XyWlnuId2lJqVtP7/+kPhmjA0KSVMCEzBdrhhSvEkc5JQAB0Q4nsF6aWqoTsGNsBLeM0VWo9bMngbKBsj/q2vrLvGUcoPT+Uwh7ZMt2+Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439457; c=relaxed/simple;
	bh=qWCj6/FKwNR+w9ys8WEEcPnqWL6QEM9dEnsZ80xAZrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGPqDyM7F9qFT8wWKXGVxk0Un4ErkzMcVMJlNUFrv+PTGhw0V9R8AC+PF8ebvgQUqLcAzXqfT7J8+1vM65eNTiVuj7c7f8AFcaFr7fv65cA8fTtTp0kekElhlJ8fqIR5Vx0sXenFXoZhyXt6tBxpCokvcazfLwz3U0toOOeiOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVRPz2BX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVRPz2BX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso1842328a91.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788439454; x=1789044254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1JpLmeHcDYci9TjzZaOlT2Qs79rEF11KvKmH8LlIEc=;
        b=MVRPz2BXovBl7Q85HaOdXQlr5P6K6uZGmelqh+3ezVrBt/KW6Eoa6SFDscpivcchDn
         fGr3113No163CY0ijQWB4kDeZ/qxnInktr+aojMyq48zcLV7VE8usOH8PRCBrfDumcGA
         vo9H4PdDzblpdQcLLNFMLAftFQbSdgWNskLv0vJFJIFH7dJdfZw4BR1YUIaw4ek1u5J4
         HaqrwIAmrea12UbDsVUGhlya2Ah8D+za3S9pD2cYYUSI5+SQT6NNhoIyJh3LKBnZ1tRa
         HMRiQTiuD6Zj44KLiwsqdZ+WeMMNVOejiPsQe4mI/DBrkejAXKltLujcp20MFWSfz0aR
         44cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439454; x=1789044254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v1JpLmeHcDYci9TjzZaOlT2Qs79rEF11KvKmH8LlIEc=;
        b=eIZoMmO9x+SxEaUzQ337DU2jbWBxw5zmLdk07Ngc6hIfRRcrWMq/QrtNcJjBqB1n1U
         A8iNmjnv9zi8+TEt3sB2pdtftLlH8t9VbWIUSFcF32vUJuy7755GXR/7ugTdyGSo1foo
         0tZ87PzqTqS3yH4+jymRFS/kwnZmyqeNas6A09/SAtvySnTo8FLOxR6kyem/JerEB6Ws
         RpSEAQKS03BU98Bm7AFrDzzJd1Ovhw8heoaRhdMUSYO+XvwLbeMSSBOoPSQI7z8mo0EQ
         0LLURX9T3MKonJNukJ5KwDu2gTV66Xtbg/7gF8U8ZZPgIbyzL5T1ExP+a9MhdgM9py87
         4hxw==
X-Forwarded-Encrypted: i=1; AKwUvBzQhRuzkmETK1Sw2QEpN6Fl0roVaWpdm0MFc5iwhj0pTijE2XowjIKfCaZQOdGbkiH6oRMuBCI=@vger.kernel.org
X-Gm-Message-State: AFuF++kGiyIa2mBgC5K+DYNPJRNr6dw3U8sWCjl09g4qz0sT48SJfXCg
	UBiz4uF45fFs+7jzl+V5tMZ7nhZ5FJYzh4TxGwgPZ/4EtJUs0LpVji7M
X-Gm-Gg: AYBFou2gY9CnDahzgCYZsdotugQSNmgr7ivVlgHGELKxpCv+8MAmBawFc6hzVWOgn5i
	EcX/myGqsZvnDDIQGPxMrl0UvOhU2ekt9eq5k4rL6qsLSqmXXvyWtYciLgSTlsWbBGvhlsvZDeX
	oTI0/gse73d08zNKbEdBzdMGyJTXndBSUOK+x3Ip6L6B51e7n9FW9i6vYJm9BiVJ9UpSnvCA7d1
	gL8vOaeDEan1hJmz234CRIHRKLHGSbNXubv1w9GC6mmwsK/LkzMO9Qf7BWGHxR0LiMDDMjDWBEn
	iuqH/ciZKIQimbJwi2hEcG5gNbq01iYL6M2xLmPcKyfsyq37SE5b7HOeCKCOuLMMV+aqt2EU7+L
	sSnMV1bNam5p6CKADHtW/OYqRzHx+juQM5YFn0IesIoSQi/idMmHdiRYphPqo09+8tp8uD4OItt
	mbY5/F51ttCsO/ACgkX1gnFh/DiIztMqtOqhb/T/KtQHU/nxl5QNimZqzHyHHiDMocR4TyEMLGZ
	BM9qLs0evdccMt3
X-Received: by 2002:a17:90b:264e:b0:398:dcf6:d40e with SMTP id 98e67ed59e1d1-39aee0c16cdmr19784168a91.17.1788439454461;
        Thu, 03 Sep 2026 05:44:14 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc060sm6268339a91.3.2026.09.03.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:44:14 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Thu,  3 Sep 2026 20:41:48 +0800
Message-ID: <20260903124422.5340-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903003351.91088-1-sj@kernel.org>
References: <20260903003351.91088-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 17:33:50 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu,  3 Sep 2026 06:31:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Wed, 02 Sep 2026 07:48:03 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Wed,  2 Sep 2026 22:22:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > On Wed, 02 Sep 2026 07:10:00 -0700 SJ Park <sj@kernel.org> wrote:
> > > > 
> > > > > On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > > 
> > > > > > When setting goal_tuner to 'temporal', if the goal is achieved,
> > > > > > quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> > > > > > will always return true, even if no regions have been tried to apply at
> > > > > > all.  This causes qt_exceeds to increase unexpectedly.
> > > > > 
> > > > > To me, this looks logically correct.  Could this cause any user issue?
> > > > 
> > > > Yes, I think this might cause unnecessary confusion for users,
> > > 
> > > If it is _might_ kind thing, please ask questions first, or add RFC tag at
> > > least.
> > > 
> > > > at least
> > > > it did for me.
> > > 
> > > If it confused you, definitely we need to fix it.  But if it is just confusing,
> > > let's try to clarify by adding documentation, rather than changing existing
> > > behaviors.
> > 
> > I agree that we should avoid unnecessary code changes if the issue is
> > merely a matter of confusion.
> > 
> > However, I believe a code change is necessary in this specific case,
> > rather than just adding documentation, for the following reasons:
> > 
> > First, this distorts the semantics of qt_exceeds.  It is a statistic
> > meant to track actual quota full/overflows.  Incrementing qt_exceeds
> > when the quota is completely unused (because the temporal goal is
> > already met) misleads users and could break user-space monitoring tools
> > or scripts that rely on this metric's accuracy.
> 
> As I mentioned in the previous comment, this doesn't look wrong to me.  I
> understand some people could think differently.  That's why I think this is a
> matter of clarification, not a bug to fix.
> 
> > 
> > Second, considering its original behavior when it was first introduced,
> > the recent changes [2] have inadvertently altered this behavior.
> > 
> > When qt_exceeds was first introduced [1], the conditional check was:
> > 
> >     if (quota->esz && quota->charged_sz >= quota->esz)
> >             s->stat.qt_exceeds++;
> > 
> > Later, to handle cases where 'remaining quota < min_region_sz',
> > damos_quota_is_full() was added [2].  When this function was added,
> > quota->esz was replaced with !damos_quota_is_set(quota).
> 
> I don't find what's wrong with this.
> 
> > 
> >     static bool damos_quota_is_full(struct damos_quota *quota,
> >             unsigned long min_region_sz)
> >     {
> >         if (!damos_quota_is_set(quota))
> >             return false;
> >         if (quota->charged_sz >= quota->esz)
> >             return true;
> >         /*
> >          * DAMOS action is applied per region, so <min_region_sz remaining
> >          * quota means the quota is effectively full.
> >          */
> >         return quota->esz - quota->charged_sz < min_region_sz;
> >     }
> > 
> > With the introduction of DAMOS_QUOTA_GOAL_TUNER_TEMPORAL [3], quota->
> > esz == 0 carries two meanings: "unlimited quota" and "should not
> > be applied".
> 
> I don't find how you think this way.
> 
> > This overlap causes the damos_quota_is_full() check to
> > return true incorrectly in the temporal goal scenario, leading to the
> > false positive in the statistic.
> 
> That still sounds like just a matter of different interpretations.  Let me know
> if I'm missing something.

Thank you for keeping this discussion going!

First, I would like to clarify my intention to avoid any
misunderstanding.  My actual goal is to fix the semantic of the
qt_exceeds statistic, rather than necessarily changing the underlying
logic of damos_quota_is_full().

Currently, there is an issue with how qt_exceeds is incremented.  When
the quota is set very small, qt_exceeds increases frequently.  This
produces a statistical trend that looks almost identical to the
continuous increments caused by the Temporal Goal being achieved.

The original intent of introducing qt_exceeds is to let users easily
notice if the quota is too small.

Commit Messages [1]:

    mm/damon/schemes: account how many times quota limit has exceeded

    If the time/space quotas of a given DAMON-based operation scheme is too
    small, the scheme could show unexpectedly slow progress.  However, there
    is no good way to notice the case in runtime.  This commit extends the
    DAMOS stat to provide how many times the quota limits exceeded so that
    the users can easily notice the case and tune the scheme.

However, under the current behavior, users are forced to manually ignore
or filter out the qt_exceeds increments that occur after the Temporal
Goal is achieved.  This adds an unnecessary burden to the users and
contradicts the core goal of making it "easy" for them to tune the
scheme.

If we agree that this adds unnecessary burden, perhaps we could explore
a minimal fix at the point where qt_exceeds is incremented, to skip the
count when the Temporal Goal is already achieved, without touching
damos_quota_is_full().

Please let me know if I'm misunderstanding anything or missing some
context!

[...]

> > [1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
> >     (Fri Jan 14 14:10:202022 -0800)
> > [2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
> >     (Mon Apr 27 18:33:50 2026 -0700)
> > [3] af738a6a00c1f ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
> >     (Mon Mar 9 18:05:19 2026 -0700)

Best regards,
Rui Yan
