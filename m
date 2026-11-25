Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795634233;
	b=GSgDE9zunfCTgMaQAjccaZivX1ux8CSCN5BPFmdPQohaoiT0gklBuZNmxqSqXV0ri1oq
	 gE7c6/oeiGD7FHm3Yyfb6+CRGAZaOhwzS1XjLYwMRwkn5kbZHRF/yimI+LKgAY3kC8EPD
	 deQ8K3Ywxae1ZrLaCERPD0tYE9P8DWTtdYVw1i7qDXCfJy6wJJpvZ7MoDXdCRrByxzifC
	 7w/RGbGRjGSC5jPUrwVe3pE4qXHWZaV9A47L+zVxfyWBubqDcpB8lWNiKB6S6UYR1auly
	 KS++YsSVj9yMLhH2fmjxEnv/Z8VB65tDRflxDwRYBARrGPosESGDGIdMEQ5Sl5dOPcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634233;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=6zdB/rQeLDq3D894FluXdu2Y35sjCX21XfyveRyDSBA=;
	b=UlU/1SX7IkqRGFhbJNt8Lhv36a/T+ShSMN2dShedfMqiWGHum5gm5xWsX5xvCxRZJ9Qr
	 CLwtPRsBQX2QM7eEvxltub1V5yQe1c4jKzpFR0FYBQvkrndQGLMes5y0Ava99QrFRDL+h
	 TuUe0nMRght2k3anC34cLiiZIshxmLCn2aiAzcpCxlZHZpNfCkfa/SOzHDam6jmTdn12h
	 vf29pB0DSzJegz/R2i+TShJsDeQ4qInh1eXBQe6xXKmb37IfEMj1SsrIU81BbCS/AmJRa
	 7Kg/Gxd0UQ3e6YLIV+NWHkx/BEJ1uwcfjnin65qPeNW54G369xiZy8EkDYEJesDY3jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xdgf1B6I;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oSCRW3SU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D72606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D72606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xdgf1B6I;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oSCRW3SU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795634232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zdB/rQeLDq3D894FluXdu2Y35sjCX21XfyveRyDSBA=;
	b=Xdgf1B6I4CtrtGl9jGctkH1PMDe8+8zU79EOK87tEO717JiWiYB9MtP8k45YDpM6PEYPEd
	SrJTZqJDck9LgL3fFr0OkG+6fQLEhtOWcnbbAxDL9ZlamvHCUj3MTk8qxXHga16AdT2F6S
	A+8FxQu1bOjAHRqs/Bhho+ZccNoWeA4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-CV0NETqgMVmKKnI6sJkaag-1; Wed, 25 Nov 2026 19:17:10 +0000
X-MC-Unique: CV0NETqgMVmKKnI6sJkaag-1
X-Mimecast-MFC-AGG-ID: CV0NETqgMVmKKnI6sJkaag_1795634229
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5c31c624c20so1003735e87.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795634228; cv=none;
        d=google.com; s=arc-20260327;
        b=kDn28ANG3u3J8Mo1BdHVYl16RNEaFt1PnQLbCYbTvCkOx4zeho1VmPVJ7iZTX2WGju
         8SSJ0NDl69uK2MDTsc3RUiy9dwoWVaKqlQrVa2epAVQqcxZcUselRhSZH9uWvAxGLedL
         PdjAJ+svjoNVQAxNhwyMCipcZ9cMx/dpvSQlcDODHXVh4nDPP7lOQju6LshLRZOtwRFo
         /eG1VZX7sh0QCKOCQcgwdkCYjDWJ9/zWk2R+luwdLZTh3/YbW+qBlYIcK9OMPHlSyEtr
         HAg0Uke5O1bylTgXe+DZ7tEEMLAc123xYoqwtvxUKkgpzHLsNtAz4y4Y2Qx4GQO2a21g
         8C1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6zdB/rQeLDq3D894FluXdu2Y35sjCX21XfyveRyDSBA=;
        fh=Pi6SNO9t0473HuoNcj8cAjyQDW1/Qxjv1eNgji9lTHo=;
        b=Vvxwbfj0z4pEL+2uibJgEPhyXfN0Q+d0m4jh9tJWq1zDWun8QvOsuV3y6KoPe2/j5/
         mA+d7NqlPlFug2nWi8moeUghjLd+fhejzvr7CFkPeIhTCPnGWD2NLNyaZfpXnEwqUisB
         hj3bWEkZFqXYvhyu9eNsgsCA1qSDBlAumro2dP3AA1VCwlt6+dawDjAARjtfzJhb18xc
         qs2JDMAspOiXnAQQIe38oZFDuvplZIykxF0gVVI5pCrlmhGKz9d6u7UxwbS+5fxnOSrP
         axwcI03tvOcRmw7Eeqbogp0+yVZyELSclMA+YYHLC5ojHZ+Rc33olXYdRtspMI0DR9rO
         BAkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795634228; x=1796239028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6zdB/rQeLDq3D894FluXdu2Y35sjCX21XfyveRyDSBA=;
        b=oSCRW3SU+XVThO7Kye4978us7jRRSrpkMEnLAof0Eu/KIR8HsDbWGC7moFOGTMpYG2
         5L85JVEV23Sigp5s0SvgyyLSu3DwjfAuFnqNMfdDdKLaZybCo8kfv/csPdMZrByzH3Bz
         wwwcrhGiCjfjcS9NrOLTU/3D8tyQoZx6i9lwXkNjbKmFJu80ySpRuZ2nCaXQtqs8c9hd
         8qXz2CBulleqLTN9KLUBSEgu7Abd5ztlBoshdiJtgxv4uhzrH3teBU51e7c30NOTHY+x
         8m/aSQpt6zz9dnea3TKJokwOCB5eARNBPv+9pr8lrxptqzv5vnpUulKdjyzLH+htzO/7
         rGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634228; x=1796239028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zdB/rQeLDq3D894FluXdu2Y35sjCX21XfyveRyDSBA=;
        b=AqmlDptKJBqCmL8P/vZ0ic5rSbSNnjgu1DzkcjlYjDPnzV3qiAkPgIBApcTKliXy9+
         6SZDbN+tr9EM9Ff+JepU27FJFhzCzxtaEfT2ZOSUdazFd1mWfLq+8M7i+0A7XuhcSr6G
         w8oLvoMdWieIqQXJQ2udZVNQV/ha6cymLS1oP5VFt+73BI3FkXgSSro9LqvFqUCyll6z
         oILvB0Iq/ctWtG5PEffQNbN3kQXUPA7rSm/6wlZb2zazWIh7VYe2Ks4O4/CLpYVw2g2i
         OK7jyFb4rJ+hs4/5cL7F/UEMe86jYNp0sKY1jgl7UuYjAxXGJYn/zZiDgKUQ+Y5oheZI
         DRoQ==
X-Forwarded-Encrypted: i=1; AL+hErG0lpCyYRtxo9goGLYNWPNBuH6mAP48NAYDwA9aBqVqYZ57eS2BfXIzKXJpk2L0byBp5u9B8KQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pQgnW4xkYCg+06n6MP27fvB+kbPQ+hgIMtm1QSugCGzc4LnNC
	4FWsJ6v/IlIIT2xT4syjUs3TbCgwLWpgXB9MtDqM9W0QIPf+7P2YRT8PResDkzm0NYvRBbkusH+
	1uRwXeK4PpDDhppre5a9M2LOv9hBVBMw9csGRFJWwJO3WuJxrb7pQ0fBidFg2u1Z8UB/55pDtnk
	h3UdOZVvxhdL7Xg6Z5+lcrbYviuhIQLQw=
X-Gm-Gg: AZFdTZefT/jJw+s/Ax4RZqBgE8tL1SIUHjBvBPdLj8BwV4XtD7PXlRcArR+w7axDWov
	ip9NXiV62o+joaC4qcaRxNA3EadcStpWe1puq7cedKrVNVTQIP7isNbLemWDoxPcV9VDmWSBS5j
	LfpJ5OpV8vaXbPzYeuCDlwpKdJmphZ8w1/XR4czRlcLhldR6evFwekuXBirPnoXz798a4hYM6aC
	DY/nbkU6GaVba4CngrrH5q7qsRB1CvCkIczciaGc3ywyFQgMhwH189yOjNyu5ObS79ETFY9Cbk=
X-Received: by 2002:a05:6512:33ca:b0:5c1:57b6:5ffd with SMTP id 2adb3069b0e04-5c1bc552d9emr6331067e87.0.1795634228579;
        Wed, 25 Nov 2026 11:17:08 -0800 (PST)
X-Received: by 2002:a05:6512:33ca:b0:5c1:57b6:5ffd with SMTP id
 2adb3069b0e04-5c1bc552d9emr6331053e87.0.1795634228074; Wed, 25 Nov 2026
 11:17:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-bug-dm-thin-rcu-gp-v3-0-c80ecc475e1e@linux.dev> <20261119-bug-dm-thin-rcu-gp-v3-2-c80ecc475e1e@linux.dev>
In-Reply-To: <20261119-bug-dm-thin-rcu-gp-v3-2-c80ecc475e1e@linux.dev>
From: Ming Hung Tsai <mtsai@redhat.com>
Date: Thu, 26 Nov 2026 03:16:55 +0800
X-Gm-Features: Aa3M54pe6gUnH3xtgi3WUj1GWiGz9BVqRKh8waNkvHN9vH0Lj5E79L-u9RV6F0w
Message-ID: <CALjSBEtdn0PUx0WNsSDojK976JGg66ZqjEmUutuB-XwH1n=q4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dm thin: keep a thin on active_thins until its
 last reference is dropped
To: dm-devel@lists.linux.dev
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, linux-kernel@vger.kernel.org, 
	Qiliang Yuan <qiliang.yuan@linux.dev>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 7:12=E2=80=AFPM Qiliang Yuan <qiliang.yuan@linux.de=
v> wrote:
>
> get_first_thin() and get_next_thin() let the pool worker process the
> thins on pool->active_thins without holding rcu_read_lock() while it
> does: they take a reference on a thin under the lock, and
> get_next_thin() continues from that thin in a new read-side section.
> thin_dtr() takes the thin off the list, waits for a grace period and
> then for the references still held.
>
> Once thin_dtr() has removed a thin that the worker holds, nothing
> updates its list.next pointer any more. If the thin after it is removed
> and freed before the worker calls get_next_thin(), the walk continues
> from freed memory:
>
>   BUG: KASAN: slab-use-after-free in get_next_thin+0x8b/0x240 [dm_thin_po=
ol]
>   Write of size 4 at addr ff11000116371cc8 by task kworker/u128:0/13
>   Workqueue: dm-thin do_worker [dm_thin_pool]
>   Call Trace:
>    get_next_thin+0x8b/0x240 [dm_thin_pool]
>    process_deferred_bios+0x34/0x650 [dm_thin_pool]
>    do_worker+0x2b7/0x4f0 [dm_thin_pool]
>    process_one_work+0x8ce/0x1850
>    worker_thread+0x639/0x1190
>   Allocated by task 2290:
>    thin_ctr+0x130/0x1260 [dm_thin_pool]
>    dm_table_add_target+0x65f/0xf60 [dm_mod]
>    table_load+0x1c2/0x480 [dm_mod]
>   Freed by task 2391:
>    kfree+0x15d/0x550
>    thin_dtr+0x21c/0x2c0 [dm_thin_pool]
>    dm_table_destroy+0x13c/0x570 [dm_mod]
>    __dm_destroy+0x2eb/0x5d0 [dm_mod]
>    dev_remove+0x2f1/0x3c0 [dm_mod]
>
> Mark the thin as dying in thin_dtr() instead of removing it, and take it
> off the list only after the last reference is dropped, so that removing
> its neighbours keeps its list.next valid. Take references with
> refcount_inc_not_zero() and skip dying thins, so that thin_dtr() only
> waits for the references already taken, and have requeue_bios() and
> error_retry_list_with_code() skip dying thins as they skipped the thins
> already off the list.

The code looks correct to me. These notes are only for the record. The
two checks in thin_tryget() have different roles.

refcount_inc_not_zero() is what makes the patch correct. Once the
count reaches zero, no walker can take the thin again, so
list_del_rcu() is safe after wait_for_completion() returns.

The dying flag is only a hint. As Ben said, it is racy. It keeps the
old behavior of taking the thin off the list early, so thin_dtr()
mostly waits for the references already taken. For the ref-less
readers (requeue_bios() and error_retry_list_with_code()), the dying
check keeps most of them away, but their actual safety comes from the
synchronize_rcu() after list_del_rcu().

> With a test-only 3 s msleep() added to the worker after each thin it
> processes, thins 1 and 2 of a pool with three thins are suspended and
> then removed while the worker holds thin 1. Trials in which KASAN reports
> a slab-use-after-free in get_next_thin():
>
>                  before (trials)   after (trials)   change
>   KASAN report            3 of 3           0 of 5     -100%

Two thins are enough. Suspend both thins, let the worker sleep while
it holds thin 1, and then remove thin 1 and thin 2. When the worker
wakes up, get_next_thin() follows thin 1's stale list.next to the
freed thin 2:

    dmsetup suspend thin_1
    dmsetup suspend thin_2
    # make the worker sleep while it holds thin_1
    dmsetup remove thin_1 &    # thin_dtr() unlinks thin_1, then waits
    dmsetup remove thin_2      # thin_dtr() unlinks and frees thin_2

The suspend step is needed on kernels before v6.19. Before
be4addb1914f ("dm: Fix deadlock when reloading a multipath table"),
thin_postsuspend() always called noflush_work(), which queues a work
item on the ordered pool workqueue and waits for it. Removing an
active device runs the presuspend and postsuspend hooks, so the
removal waited until the worker returned. By then the worker had
dropped thin 1, so the bug did not trigger. A suspended device skips
the hooks on removal and goes straight to thin_dtr().

The walkers in pool_suspend_active_thins() and
pool_resume_active_thins() hit the same bug. To reproduce it there,
put the sleep in those walkers instead. It then runs in the dmsetup
process, not on the pool workqueue, so the suspend step is not needed.

> Fixes: 17181fb7a0c3 ("dm thin: fix a race in thin_dtr")
> Cc: stable@vger.kernel.org
> Reported-by: Benjamin Marzinski <bmarzins@redhat.com>
> Closes: https://lore.kernel.org/r/avz7qDWd2g-uubmL@redhat.com
> Co-developed-by: Benjamin Marzinski <bmarzins@redhat.com>
> Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>

