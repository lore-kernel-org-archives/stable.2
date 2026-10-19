Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426614;
	b=GqlU8dokhqvsg0tUl8Wn2A+ybnj4bZmPH73mZ3opYdwSohfT+rHpsG1Bn6y70SS/qeoP
	 djdW2fnytkMAXy9v2ymSx2R6ouZx6ivbOUyIk8T4eGNe20fePObteAGwTpPYmb+e+geSW
	 q7N8mx8BQbsPVuHsVQQeQdXj+6S3dmPgxoP8VLeN8HIa9FhBGIXu5wABiVoag40VwINgC
	 4jI7EfFu0hVXt7HgZ78c2ENhLhDhdvUv+EcT6RWbuKeBsRR2XVerboiTQAsX5g1B6Av2Q
	 NJ/jFRaaxxRY42oWGndYSXL17Q/yibMoxVVANYqC6ZBMH7iWBnUGwXq+5Kcat2PAUnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tzy2/hZNZgxPkh/2CJVsFN5uf24dNj2kZ/M8pdTK09Y=;
	b=5tx7vgSt9zN4qNOWTAjJ1t2Vs9h5wNk7gtHWNardJsSXEXtHCnqL9SrHV7l95Gu1MZvM
	 TxfEpyL0mP9LWxvLq9QTyrUhlMzpZtbSQpZ1xElcR6cCXmam781hUXx5oXUPFm20I1O5E
	 EST5QSSH0O5IlZ7VyW5azvpZGvar7yZAt8GQuB1sqQaOmRxFQRc6jjZli1Qu9TSdZS4DW
	 qIehrwQBgaWfVODC+xKFIJ6PL/o2n3DNm3vOOntNep7icvvhBjk6V7fQFKENwxdkZPO/I
	 AaR0vWIcSdgbYAI0HxqdN98V5xYG/IWGPgGipXPs1i9ym/P0wXv5eXriWUr7tHYTfIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NqQsvs3v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7F606A31C
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1D7F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NqQsvs3v
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1ddc7c9beso10528215e9.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426612; cv=none;
        d=google.com; s=arc-20260327;
        b=HP6ML93mLHu/KPOjHKJhPmyRk1OhWlhCqUQMW6A21VB51wHUIu7vGBD6Ia3Ea/R+Gl
         8xdPlby2fjhMAf5lUHC+igc35QvDrSnXTD+fXffs8g4v5gnN4O4ZouwiwnvL9ZoSy6SM
         rSNBVxiCypOl8CzMMRJ/Oyeaq2DDkj0EGTVv5WyY3FWTYlZP3VeBic664q9DepGWQVZV
         635bewqAwF8y7I4zRqCODsu4agzw5TXsRTJ0tSIvfzS3+UuN5tMXUbfQZX8bRrYk+ie9
         Jt36eBYYAp2ilnnJGiWC37cfn39BnmT7fWNmoTyot2Oww2JBsbu2HnoleXoGQTa3Hywa
         h9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tzy2/hZNZgxPkh/2CJVsFN5uf24dNj2kZ/M8pdTK09Y=;
        fh=GwYgMPCaowB6cP3MUS0WiSHqFTCAIf6pe4QqMGGRztI=;
        b=caRYWATthqvXPWl0zAD8zFLSkJOIYfZqmUN8ieCyajy/gMDzh9+xTULKIRyTOH75Ba
         AtGLB9/f/mtESUzRM8ctq/MLXfWWScDQcBG+L2LxdFtVj5wM2+g3gZaPtxHeq9HM+sy1
         iQYraHakiCre7EG4OgCC1cUxGNv4Zl43Fri0TZknH7yLuwD9FysN46SFcJgDF9QXEzux
         5+JMSaZ14qJhN/vbRxNstq9g53Y5eaBoUDiyBNXQ1AxwdgWv5aHKovoqQJgi7Fb0WYKQ
         Z+PAk29FdEyIsAfDMrZYyJnGFjNwbUPBGZgDm13BIXCar/GEdy25+ls5KCJdHAGLC/NI
         C1NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792426612; x=1793031412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tzy2/hZNZgxPkh/2CJVsFN5uf24dNj2kZ/M8pdTK09Y=;
        b=NqQsvs3vML6MmqqfPRgsuOSQTNkEyef/wmJ4JznLZyk1JNB1aPOGbKGbF8HO70mbzI
         ZvWiXoM5A7Hyr3iiD4Cg991Fg7uhqcNf8UG3Ce0qtvIA6jQXwqWJxykk6XrILETG1q0p
         +jH18mOc2HhhJ6ivo4lTVVwvrqDqQF84mDlj+x4oYWhLPC4/ncEMZqat9/hAMcW+Sz3B
         e4F0Viz8er5TxZtaw8SNTrBQlItVFN/yWFL942RNPhzhyxSUKOKU7V75yJTwWMuoJEAr
         q1B6yl4LNGGom6YXvYOq6ibYLNef2aOVSemRDjb0BK0+KtkoVnHqgod7cG7UnOHp1T5i
         YKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426612; x=1793031412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzy2/hZNZgxPkh/2CJVsFN5uf24dNj2kZ/M8pdTK09Y=;
        b=yBqD9g2C7F4z1RH4tzRZgSXpzxDJRbxnW74i2Jozhru1AG2+uwki1tk30gsT9RrPtd
         1fzHRrtDcg+SsD/kjd+mIHLxULrRWxiFCUFKwefvdfH0f3HkE/3lOGJXz7lXWGgNd6w/
         gaH/yVnFOgqPeyEufTFy/vybX0y5vcT2bpzJI7ATQS+lFFuc+KjceeGycX1tggA/OvVi
         9deMFH5wm5ufe5lUoITvaI/2WYkmTqjutUudtgjwqhNK5Uaw1u+aJuKLzcAcf7rGqDYh
         rLj2mC35PflZ5Q+ttWwy3gGRMfymYTZi/uf+um1NoJtBcjbhUKO6EzAq2z/sQseAjYsB
         qgAQ==
X-Forwarded-Encrypted: i=1; AKwUvBytEzvIkZhjvMgqICWNphAan/JrRPVLEVseBFD61a1DpCXUUse+l56v26yIgI1ZzVW/ssKJgXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCwPfPyiIgW06MhKhQ+rwRfIRlSW2Ra+FBdtmNoWp3GZk1ORGX
	RS+pSsh0ILCs/XeGiflP2jAlm13eogxyYQCaYT3PXYjUXWFVMfwQ0MpiEpzUE3pf41/mdDzUb3w
	kFXA/Xrq78oxs+gP37lfOqqNUVyYSOz0=
X-Gm-Gg: AYBFou3pWP9NRA+Jc+8lsU+MogZP/MO/AtLsyhaOuIV4qrLJ1EQscoRv149xSXZnCDZ
	KSrMsE07mwM8cWi/+VM90ARRdrEuPtIdhoWBdT/BTvgwzI3EPUhBdy2MwiYKrpC8yxDRFWPXCvY
	QLMmKhsRHd0Qof3DTKxdq1g91qKqmhszHirnKgxzGPcoKD2g9HgbyJ4VTfjh+DPr/9dC+c6mMP5
	iUI8WuAFmhv+1C69UysyCEPELI4K5nxfZ13OVuoh09mCZeLOGGBpUxFfNCx3qhRFfTFNkx3PWzi
	JeEjEs0/+qMD0dTIjHRtC1qdxLoonoyuFQu0a5/FmmnLKhzzzhS+s45mB5gcyMzgfxM2lE2rmR1
	P0CBwKmqDJJp7iGjbs7hSkSYxKq5gt19ID7/R5Nwg4A+KUD2jZDSbtdIsJO/I/gDzWLmY3nbeeB
	2ofuLL7A==
X-Received: by 2002:a05:600c:3e85:b0:4a1:6991:36d7 with SMTP id
 5b1f17b1804b1-4a1d75e385fmr158858205e9.10.1792426611931; Mon, 19 Oct 2026
 09:16:51 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019160615.2348500-1-nphamcs@gmail.com>
In-Reply-To: <20261019160615.2348500-1-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 19 Oct 2026 09:16:40 -0700
X-Gm-Features: AclHuK-V3wuqh2II4jQy2GzXwFR6X_qUKiksPsMgYsjyzYDn2Cz39hAf5ULvwpw
Message-ID: <CAKEwX=O7i6ehqyLNCpp9bqoREmahXwGS4Ja8bCsKUzyAMu_QLg@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: revalidate populated clusters before scanning
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:06=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> swap_cluster_populate() can publish a cluster's table with the cluster
> lock dropped. A cached allocator can use and empty it before the
> populating allocator reacquires the lock. The resumed scan can then
> dereference a NULL table.
>
> For example, CPU1 can retain a cached cluster offset on an SSD with
> per-page discard disabled:
>
>     CPU0                          CPU1
>     ----                          ----
>     swap_cluster_populate()
>       swap_cluster_alloc_table() fails
>       spin_unlock(&ci->lock)
>       local_unlock(&percpu_swap_cluster.lock)
>       swap_cluster_alloc_table()
>         rcu_assign_pointer(ci->table, table)
>                                   swap_alloc_fast()
>                                   local_unlock(&percpu_swap_cluster.lock)
>                                   mem_cgroup_try_charge_swap() fails
>                                   swap_cache_del_folio()
>                                     __swap_cluster_free_entries()
>                                       free_cluster()
>                                         __free_cluster()
>                                           swap_cluster_free_table()
>                                             rcu_assign_pointer(..., NULL)
>       local_lock(&percpu_swap_cluster.lock)
>       spin_lock(&ci->lock)
>       return ci
>     alloc_swap_scan_cluster()
>       cluster_scan_range()
>         __swap_table_get()
>
> Reject an unusable cluster under its lock before scanning it. Relocate
> it only while its table is present.
>
> Fixes: cdd77f84d966 ("mm, swap: consolidate cluster allocation helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

I'm revisiting the lifecycle of clusters, because vswap introduced
dynamic (i.e run-time freeing) behavior to it. For the most part it
looks good (both physical and virtual side), but this look racy to me.
I don't see how it can be safe. Once you drop the lock, all bets are
off...

But at the same time, I have not been able to reproduce it (yet). Will
report here if I manage to.

(Side note: my vswap code is actually safe in this scenario. CPU0
allocates a new cluster entirely, and lock it before publishing it. So
even if the cluster index is cached in CPU1, this race cannot happen).
