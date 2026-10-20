Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792519102;
	b=aoeDGORCRLI5GG9Uf0OWVpADb2yEDbL/biFTKF4qZiU6cvssckB3Xhc5CQmfKKaei9Kb
	 IoLBWmFxkNTMxZ/u3iSXtXarpDkaLFdfHRku5OKFBpc4QOj3TAujclSh3CtGaF/EXwWN2
	 OnMtAOfoXybQgx5YboUcK5ifXokfjfATuXND+3LDAItuVuhIqyjSNslsfDDZdVWTZVDfd
	 5X9uihX7IDoOxWKRY5cPQywBvEoe+kKWMEeZEd7Di+Wv/vA9MooNCBCHu6gjeZ6GE3C4K
	 zpO3PaAwDyC8/E7sORbT2OpzNA7a/qTTNMBYph4GV71Eh/HS+qfnS5TgCfmP6R4m2ZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TYpDQsgGRr37nBGO2U3Z6QjUyN0Co5SvOmgYxqHioD0=;
	b=bgGqwOAqduyq7b6xTp2vv+x2BTCXpDC0piCt64b0LlYd1rTjAsQ/rMmpbGgMEmjmZW5y
	 W4cbrfLdHhikn9jOszTQjLtWv5md1BzsEXWdkBbCnBXHeUcfAFk822LeNY/Cm9ZBXsb0t
	 /85YS0eFc+Pj/k2E3MyXLySHrc5LMI/ysrbV+502qSh1giRlQOtUkTmmMAz1mNf1k7M4C
	 5Vaka+3CG9hZyBpCML5jXo1Ff8Rn9qHnKnkqNkBJCpKfoG4S+l00zNzaK5GV/uDS2WLsZ
	 lfuJsYpCqc9j8WhlTpSltqLrME66MONNAxCa26Z+zYMngkL9A0LZ1d5MGSBODfgfRrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D1+rhQvL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF05D606A31D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF05D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D1+rhQvL
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso5085937a12.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519100; cv=none;
        d=google.com; s=arc-20260327;
        b=h8RQcCZpU0EsU/LTQagJrKNSbLpWus3ypfuvEgf0Cq4D5K9zjSYMbCB+qRRr7cjU5L
         YnSJA3YRO9nLyPfhgqVSlElPXAqv5U+Byy4ZQ2uZJfkplrzD6kHDw5eGdu4lvwvkaSlW
         YU0NYvXL+YpiwJGYBtNjyHKJ18StFUEZj7wyMM9+Pi+1WVgIDYP1WfM0bKqpYbWq74YR
         JfeErm6M7AYVioO43mEEMl5SoMc2pxjwdi29vej30Gn6GyZ1H7TryjobubtSjMuEIhYH
         4V/sI0CBPjmTgE6CvXQNLI09QNm/hzeSWVb/5HpgNMZnLzTNGFkxUBTGFsIZKX2arqJR
         dTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TYpDQsgGRr37nBGO2U3Z6QjUyN0Co5SvOmgYxqHioD0=;
        fh=s1vufJig6WY57qr7eHhKGogpTU80LP1guv9KKCygCew=;
        b=RREHGNjQH9GsZ/FT+ySI53V9i5+WyVqVcpir9VA4+oELlRCBwQqrDGNxBIaBsj22OD
         YKZH8e93g+Tgow+LhHiFUT4Gy0RxqIiVl38qmSzNfmTSq0+UOG7Yb+cJg+SvoKc393S8
         cXEUma+spIamk3kpXtvy0SyguSJd9tShFCLGPhndxNBCSu9XhMxIsMzw1St1S8x3yq5P
         0AURw8c0kWNccbwJFDgTb43oooPGCBMaxOCE6eNzR2cRbl9oFQK3zkqaQ+l9gQw5qBVs
         ptMIb+dbbo3f7X7nfa0dLXOb0t3WQ7evUNjzr8WhT3DlsCrhVvlkh0kVlZifkHsWIZGI
         WynA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519100; x=1793123900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TYpDQsgGRr37nBGO2U3Z6QjUyN0Co5SvOmgYxqHioD0=;
        b=D1+rhQvLQo3rv6jagYZKuv8hthSD63xxHUM4d3XEiQ9942SpXeB7IfjMrlrmOiLOwk
         lHxXTtdHR3HTAYX7ZvZWeffr0RYVsD3iUMGGfD+wLCrtofANjrX2h5ygIInDBB3s9Y4L
         jxBGMBg329131QpiRHa0UmWmIRAAeYSpNLJKQkVmn5hsfA/10JAxjSZZWA0goSX594Iy
         GR+eRzeFgaRMg+hbCssxqj68YRLM9nEpKLzSon3Weua8dt3z2IWfDwoGtCaVJXzSLPSG
         podB082glfcChC/1HJbxh49XihI+1rTZcYTrvRV+kteAPHDfPfajciTTLLH+YinRCxAp
         1qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519100; x=1793123900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYpDQsgGRr37nBGO2U3Z6QjUyN0Co5SvOmgYxqHioD0=;
        b=Koe2c3JfriPUswdIvo0lByaQD76WoRT2EU7b+pz6NypsEzAYB0G7EUbQeJDJqtrWoC
         rNjYOmDe8Q2excSnqkHWYJWhL0cf90i3iunq0QfsG00NJHvwlbqH1DgzSTxGOcjKSkaA
         P3MyNpD39c490hl6Qh5tQJnC37Xw0D7PA55DULA4A0lV5EJWjm9WYA7mLSK1ENDgJqU2
         6yv4O4ZhKciHeUbrKCo6rJPffOxUzwpOiu3sjhFh+b/dmjdklt+MMp0cw84oDBieDBd3
         zJjINugt3ZDCrLrKg+Sodu8wmkNsCqpmnLAGRRwmxNWrQY5vWv/+Nq/ut3XKfXRN+wsN
         tt0A==
X-Forwarded-Encrypted: i=1; AKwUvBwz+Z/PxUgOgwRHgExaKNKHVzldojOOXqRMBY4Xz3H1JMIsuGwShLvBiNo3G3F9LlZDk2Npb9c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5n6MSSCJ7qHqOnWVMNmjzqvGse2o6UpKyNyfhhidJ/NIug0HT
	8mLh7OxBnW2UWErr6yo4WZf+fiw16Wm0wsHrSNYhdzdqwPiCBzr/Vh9Psfk2fOdLXvahr+ARJdG
	0uE8IIQNUKXh3Jw3qOVD9iFdsuj0/wXY=
X-Gm-Gg: AYBFou2JlBDU0oPWsiehhpiAUvstGeDVYBTzMgFna4lZq9ZzKEwHssmiwzqmYhOSFHm
	3lp4QCeVCpNMcJZwh/YmGoDOGvYe7P5megjyUvT3eZz3btu9GjLpvK4FVB9ilNF/gyF6pk+Ci+7
	OtOZuqgToD2kXLVHnJbOll5SLFe4qXFoT/hdEZi6umjiN8oCOwyXmSk+rALjfJdzEMeMeRc6Yjj
	qjjrV9koGTzW9rSlww9UxCYXU63SfPhKXZJ5Zf7xDVkyIhihiHC2YoykSxqJT+QYbEJS8rQToT2
	UNC7lmWNSyNEdLxzX+oeWMOXnuzM73uwEe0Dl42L0P+if6twokebmgbI2uqpvnQdfKzfdy/UZza
	X0CY+MyVpIn5W
X-Received: by 2002:a17:907:6d12:b0:c31:8984:7fad with SMTP id
 a640c23a62f3a-c419d067e77mr853092766b.15.1792519100063; Tue, 20 Oct 2026
 10:58:20 -0700 (PDT)
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
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 21 Oct 2026 01:57:43 +0800
X-Gm-Features: AclHuK81ig-p6n-cemVImrMFEtjvoTG0vQVQgOGs9ux1VBr9C6W8ghDtjcxeOK4
Message-ID: <CAMgjq7AEg6XEUJPaM3mMBQAeS_KiDv8_za4w-R2WaZ=ZGenvuw@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: revalidate populated clusters before scanning
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 1:41=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
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

Nice catch!

I think the real problem is that it turns out calling
swap_cluster_alloc_table() without holding ci lock is bad idea... I
think this patch still leaves some other call site too?

We may instead add a "bool locked" to swap_cluster_alloc_table, and
let it lock the ci first before it does any assign (not the alloc) if
the allocation context is not locked. That is, keep the
sleep-allocated tables private until swap_cluster_populate()
reacquires local/global/ci, then install them under ci->lock,
something like pre-cdd77f84d966, always assign it atomically.

That should also cover the problem reported by Kemeng a few weeks
earlier too, and prevent further misuse. My Bad on that change :P
