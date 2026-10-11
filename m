Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474731716A
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791690602; cv=none; b=SrVmH/2/o8gKPdJ8WKfCxDu+nJoCcGt2m/tRC0B31SRVpPVSVD8a0XrPXgC0k8NaTlHtMDH82lYRylA83dcenr1qY3SipN/hKsbrbt0fNb/YhywSxq77kN4JJeXjkNbtXPnTWg378ovn6UpuatRNgjBqTQDY/n9VpPtsXRicAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791690602; c=relaxed/simple;
	bh=1DpN0+D5ufXyFyAfy3uJmze4fn5FpngK55D6QJU13m0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=tfAPAs1V2UZlpbxLdn/xsrpjG6IQOvCYjM5r02uXCtbq8mW0FY5xsrKWpYR/skE/3rPSXpWLdkZTqEckcDBmpgWKgJ02vYGd5GOdOvogHzbEoVUK8iWiuExYg/p809vOYDlS8kNF4W0KkVuKil5Mp0TryNyWqtwEDUhz/FVCNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqCnOtDD; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqCnOtDD"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33fb4680717so3367684eec.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791690599; x=1792295399; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FyjOs8U6Ak5u7Fn/oZM+fBDOPJMJH3TRgM8xKhmhhZ0=;
        b=jqCnOtDDd41ZdVtH5EgO4VmolRbB6ElsyY1gyO+uqnf2mj9hAwXglyb7C/nmFNqUQI
         NB6FYIHzZDzb+qyTzoZkB5G/qaF5abxbxRTaqbum/EOrrtdd1ayQsXKP6npWGbGD5g/M
         +BevaTG/SagDHO77Dct9vndImfm1ZW0/K1YkQPBQ5Uen2wOjojgXgSFLEdWXkfzRU6si
         EjEIMr7xlOE4gMybsEd4OFwS4XNrhu9rC4+44EJKmH/xHRgiRUAuvO5yEuYiriwYssqe
         FV1ZhVFF8msauHvJ4uCchSmLomF13ZFPGa2A7p0CtFcYRzwqXB1tHn8HhXJCAAmgQJBt
         1VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791690599; x=1792295399;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FyjOs8U6Ak5u7Fn/oZM+fBDOPJMJH3TRgM8xKhmhhZ0=;
        b=xzS/CryKfscIs8LBPZUohqDzRPafWmc5HvjZDz1U7xDpfq55lJHFfYnnin8AlUIuSp
         TwJ0JyROnlQCpIJvuvKFyzHBkxkHW7ngCrZujc20CJYySSMjlLJ2aKr22GCjoRAhAroQ
         rEahiQj+n3EnLmYl6lRQDTe9Gj0RFUswbq5C0KYpof77DMiM63q6ABXU3Ze0JctEgZF3
         rDwRGjddplIW18jTP+NlFtQQwIkaT4LNtjIpya8DFv8s71dpccAdFGk6NSVaJD+dh7Rc
         YLVwiaGotgzy1ufapYL4SdbINgsW3Vo06NJ4vu7lq0ovZpBhiXmHgUMCtf92PsMMPH+Y
         ZinQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLglPOw6kcuKbA/2ARMjuyp/I1B1dFwwV/sfaiOS7fCntIUEAcSh8MUkvSstPweSTkGp47oLs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+ITYJ/Ov5v9NlKVP/B4zhcT0jmbJ6Zr6GJ1lWt03vfqcPUYlB
	TW5OJrdoJDpCdJlmr8PkFuMoByMYDNF39uE8ML3R4VvCgTJ+XpO4UJIf6wyJfA==
X-Gm-Gg: AYBFou25b7e9pFlxgKxwGy4mtRnRyr25vsWFMTsiiVhPy4mQ3yh/pqVXasDi5bg1ZHD
	4INUGk01/9Zf4O/xMMx3XDLR0LpEOkFH5//RM94RAgo/Gdax4SlpDey6dQwGhtNElrcHlkXKNT7
	C/DTaVDvsSyPxM0FWELmc6Ajg64xN1bgnmMjSh484qpeqTl0E6SmEwpqHmCXKq97rW33OA6uLQn
	T+7BicufxTWUpRG5ek3ueThihzdSikxUrLxUdi771UhrXEnNwTDQdc0pOnCZQLQCiBBJzSUlEV7
	vgTUW8sFRbrm/N5svzQiLuQlXKQj7XkisNjEuIBGMl08gB5dR4P7mUZdUTW5ujdxghlhPb9aGz4
	l/EjMsKfgr6q9UQWfqZFClNblBLe+9KzOp7cZeg/TiQXhKK8HqzmRoXfQClOilUIRX8MwLnq1rN
	pJXHUs7Q5BD5cFcRQkQ25+679PsT9Ca2d+olht5MLj+DYpP2v3DnDmmUcu00uC3WiRw4lv
X-Received: by 2002:a05:7300:2442:b0:351:39db:42db with SMTP id 5a478bee46e88-3537dfe388fmr8395787eec.20.1791690598985;
        Sat, 10 Oct 2026 20:49:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358de54fe47sm7430579eec.31.2026.10.10.20.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 20:49:58 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, 
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
In-Reply-To: <20261009123035.157770-2-gautam@linux.ibm.com>
Date: Sun, 11 Oct 2026 08:47:35 +0530
Message-ID: <zewlq628.ritesh.list@gmail.com>
References: <20261009123035.157770-1-gautam@linux.ibm.com> <20261009123035.157770-2-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
> According to the documentation [1], the caller should provide their own
> locking to prevent concurrent modifications to the idr to prevent bugs.
>
> Wrap the call to __prealloc_nested() in	a spinlock to prevent concurrent
> modifications to idr.
>

This looks to be the leftover of previous implementation. IMO, the
commit msg needs fixing.

How about this?

Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
According to the documentation [1], the caller should provide their own
locking to prevent concurrent modifications to the idr to prevent bugs.

Now __prealloc_nested() calls idr_alloc() with GFP_KERNEL which can
sleep and mmu_lock is a spinlock. So idr_alloc() cannot be moved under
mmu_lock. In such cases the idr Documentation says:
    If you need to take a lock while allocating a new ID from the IDR,
    you may need to pass a restrictive set of GFP flags, which can lead
    to the IDR being unable to allocate memory.  To work around this,
    you can call idr_preload() before taking the lock, and then
    idr_preload_end() after the allocation.

Hence preload the idr memory with idr_preload() before taking mmu_lock,
which allows us to use idr_alloc(..., GFP_NOWAIT) under the spinlock.

This also allows to kill __prealloc_nested() and __add_nested(), as they
are not needed anymore with idr_preload().

[1]: lib/idr.c
<...>

> [1]: lib/idr.c
>
> Fixes: c0f00a18e2a8 ("KVM: PPC: Book3S HV Nested: Change nested guest lookup to use idr")
> Cc: stable@vger.kernel.org # 5.19+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Otherwise LGTM. Thanks for taking it ahead and validating this.

-ritesh
