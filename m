Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22B47140D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402335; cv=pass; b=PEfE0sPyG1/vChKd4vXG9gslm82PerWBGYU6WpPaWH+nsdcwGjtyAZyuTdDs75oELP7kT+dfNV+uqd05LwbWcDGJRlSz85L0DANIKSTYb2i4JpnGtuPvJAqQj3vmGSE09aIs+vYxqYB05B3Ye3LhvmcKPfW2M72cFEwAgzMIYd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402335; c=relaxed/simple;
	bh=ZIrwzndTIJn+zc3gui4wMdEbuLT5FkETFxZVrQW961I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBreda+fcKPPRYg1q7Rq8WzF8zCc78nYE9ep9iA+vSgDpzED9iUJmpgy2D28+wIkEUiSpf5ZiaYJ8ej80iEs4cMevUnNMCP2lkdULqII1V6txGu3KQjgUcELafYBr9ehB5qlXwmpxIYT3SK5lWc6CQjkPtmWlxwzBXT83onU/aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPxS2JBl; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPxS2JBl"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so31346816d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789402332; cv=none;
        d=google.com; s=arc-20260327;
        b=GByHbqM5dgFgJjeRbdux5JNJJx8khZ4pDL/DFgho6w0yebZy/8vNQJFexvPMhKEljL
         0pw3miuMYnAs2KxZ1P9rQm63JYildicObuzRNaxzov7UJvHfsDzqeaKm8k55mHg7bemy
         o9oqJ9oiRc1G/QpgjjYeOTVYVv9nJPO8VE8dzRyJO7s6pFxydXbqUY094ugE8tzBuIaB
         eHZVofQYfJbW84XF6CJwVyXc9wnI27CahkjftMOEP0mOE6DSQ0q1FqP1Nv/17w657KUl
         hlyeM7EKIWxYUYJ+1Rc4mX5qDWVvFKYpDJOgZT+puCvC6/D8WTHBtrmsJHrQhxZKczFO
         Kxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZIrwzndTIJn+zc3gui4wMdEbuLT5FkETFxZVrQW961I=;
        fh=M5p1OnnbvSMbWrWBDqadJga7wq2ECK3+8IUlOrG3JKo=;
        b=fhKqUsYcSz6gs7FLD8KuE38dneB9r0ml9HNKbPfmizt2M/t+qnqHQMgOZium7Ezzl4
         zl1VcIwPv3vUgL8ysCheMFQf6CP9A/7LHTy1Q7681iowS54h+jailE7eQqHiPh3H7dpO
         3IgkFIwPA52WMe3eG84Htxis7uFcnQDpWZzBjCmEjUQeCXl/ErJU0532S7LGvPCeDWOW
         NtV27WperIEM0lsLZnFRxptkYAmbIdXYhec5QAK35puwU1XS9t+bVaz+HKMPte8ZpDYX
         75mPNVP26staWBHNN1YGveF9OsLeWKWrPCBO0Rz8FxSWlQMSezyPVuI6qh8jSurVrFDn
         CjJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789402332; x=1790007132; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZIrwzndTIJn+zc3gui4wMdEbuLT5FkETFxZVrQW961I=;
        b=iPxS2JBlCWjKkwI6vuyC+p9d0cFDovSdjWkqcQV34zbE3g9Qfs1+kZC2wXrxn4qPpb
         rKZvPsICkvKF7gbP2B0iNQezKfzeEWT03p7YNUJEgksiYi4/mEP0lAJ1lag3N8GztxnE
         RureO3rxrhakhZb3pXE2RiAncPW60A4Fo/sC+CRaL0DPjcU+hZNvDmxhTYVXVykiNrrF
         YwKNrSUZ5lRm7dA2AT2TfTxos5QZ6R/nXB0ltE8FFAHyMHMDq1fKtbHVuMZye5hWP4tK
         S+QObWjW1fAl88bR/tJKhCXpOYZppcazqEikoOtnNvF5uZWw+V4auwALmLALL87RH3cg
         Cdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789402332; x=1790007132;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIrwzndTIJn+zc3gui4wMdEbuLT5FkETFxZVrQW961I=;
        b=tNXeVeuSWDWQKQ4xWt6LTrUZIIbpKJth7soCi9LQrakT34jPgWCQ9QkC1ri7oGj2AR
         oagSIkrDCb8XOkCe5DVHE1esKJsQRGRh2mWn1S20fyvKB5V6NhWdRaKlYc3suBf6Whas
         cCthAGuWNtTeyDEFJ2jouYMr9Z+RXzzup8QlANkT9er1S/PZ2Ts94Qd3Jq+GFSAjbMY/
         ajthzzotKn8OBPvyK+reabd/2zToDIDSBZDNHIlVjqmKtJNgALQhgUHeNvF0Dmbz9xvX
         Icgt0C4LwWwm1Aalpr+ZN+2byRrXJ1pe0akeJRlw0sY0gAbu4ksaG5c7YhEDn+RNDBFJ
         8VQQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8sjfTl+/6aMIsQYa6ISXeS4D7EybrVBobCwE8uAc2lJToCUBFd7jRryvfoqSQnP6J18v6R8s=@vger.kernel.org
X-Gm-Message-State: AFuF++kRTNHm7Gnyj9tuQLCD2vapTsozLWZPHlIpBeJvo941k7ddbgJ5
	czovx7IDkR7h5PmLeiJ5Pq9Jvx0KE0jsOaDjySrs9+73IUDTX0pq2UoYZwl7DVLWUdoG1+C+rZl
	8Gof36heN0uhcEtdH8UxKva1f/zjhVY5Fcm5wcRyC
X-Gm-Gg: AYBFou1vb0TBZ/MakFGTcImUyTisZudrBzlYVZQXiH7+OS7fPsTkh3tk5hETiPhAIJa
	QEOoI8FCTWslOp+4RVHTtnbfSI/dzzOJcw46WGCtTLtKqrgLUvs86/aIJoQJnvsYNIeTdrSMope
	wLvi7hpwj9n5zrUfHZsNfnbGtcagenqlkeifSaYvTbrXsEf8CgIkXLiW/LVGl5X8/3MIitXkdXQ
	udZCqZ+pGWqJErEOrQDEQgP/6IWKt6fXZ+NlsuT5UMqNTzwxTO8qxaiZo/u82clYkn8iBRl+Ngv
	CqVhNJaMpynkW//32puzZImv1LiQDOwHaF3B7oifgH7DRnYCVj1ZvU7w+ndGfLpV7CR7F7CLd72
	X7kvNxw9HJw==
X-Received: by 2002:a05:6214:4188:b0:910:3453:7d8d with SMTP id
 6a1803df08f44-9122e68cb26mr52724686d6.34.1789402330683; Mon, 14 Sep 2026
 09:12:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 09:12:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 09:12:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260911140816.3236725-1-joshua.hahnjy@gmail.com>
References: <20260911140816.3236725-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 09:12:09 -0700
X-Gm-Features: AcwNN1WUbkCX1sstQv0ZWJuvqOHMzCSyd9_UN_yhDwBAx0uKe7xefyFjGTdT2Vg
Message-ID: <CAEvNRgFme=qjw+T8NoKwLuhVLBGYeXGFaNM_jB9tR3WkgPLjHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Track used_hpages when
 getting/putting pages from subpool
To: Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Hongxiang Lou <louhongxiang@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, fvdl@google.com, jthoughton@google.com, 
	rientjes@google.com, vannapurve@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Wed, 09 Sep 2026 14:49:26 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:
>
>> From: Ackerley Tng <ackerleytng@google.com>
> Hi Ackerley,
>
> Thank you for working on this fix / simplification!
>
>> HugeTLB subpools currently only track used_hpages when the user
>> configures a size limit.
>>
>> This is buggy since when there are existing allocations from the
>> subpool that would have satisfied the minimum reservations,
>> hugepage_subpool_put_pages() will still restore a reservation to the
>> subpool. See below for an example of a false reservation.
>
> I'm not sure if I see the false reservation example, could I be
> missing something here : -)
>

My bad, I copypasted from the cover letter to this commit message. Will
fix in the next revision.

See more at [1].

[1] https://lore.kernel.org/all/CAEvNRgEwbUXj5cVQq4A-U=AMOzP3S1mjnrOC79Li71wf-E+dDw@mail.gmail.com/

>>
>> [...snip...]
>>
