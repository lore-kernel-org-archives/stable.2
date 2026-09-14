Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79992486425
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401415; cv=pass; b=bjI10v+SkbllJy/76TMcV/kSk4sD8Hks9KtXIByjC01TOJlzxnBdxsM+MjZ+v/BoKBsOiBL9729RPA6aiOnSA3kxU3ke3tWRXTr9fjQtqkaFfuw60pdf9hQSfPDl548QSPpKu9Fy8h6YQDJydXfHaapM9Bnbbm2h+HNHmmPN0rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401415; c=relaxed/simple;
	bh=LfklUHIPWaWmrp2t1aYWGciesvwPpwkoe+iBPGV/Vsc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa00/tfBcyS2g9AWYliOGuT6z5TT0d9HA25dkqL2Q7pYQh0E1jTumu4xH+h/vd75eq2i0LKnjylDsl03lkDyvw12y5KDEbJbX6+n8GW3yhiWeRGOr7tTw5GISzjnrAzBhq9Wn0CRXXf1KgRqEi0X+Mz+RwXklhICFRhxioZUGCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORPK6RDL; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORPK6RDL"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97ea365dd5cso2525808241.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789401412; cv=none;
        d=google.com; s=arc-20260327;
        b=tD0ZWwdkjnECRGWjI4N7fwOo0L7ZODxM7QVglcY7hLTs6eybdBTeEHJ05HBs+SPvUd
         rF491DnI16CIT3qvnYWo9Mafdp16F0Hp6FI3vlg/Kv9IB1oD8Q/UeOKjNfsKkJ/3DVuM
         ISh19mIT9V3VYo7AB4ULiLbIX6acsE0VYpc+bMllbxcutJuaj0ivYjCtO9NMxewcbHel
         MnrUCBopWw5RU64a4Wqi5YHNbFlkUgBnqZLbOhnZW+UD9ScjhYiglWrsoWY2Q5mxN0fx
         qvauDjr6F2qdErcbZunWmhKUgu/EZ+finVhm/oGg1QZ7kDTTcQLVzLWNY6fvWKLIE35T
         3q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LfklUHIPWaWmrp2t1aYWGciesvwPpwkoe+iBPGV/Vsc=;
        fh=wMPHxCvkbkQoeoJ3rylAUeo+xKlGZR/2RLrMV9aH7cI=;
        b=X/sY2cTQml5uCWwqWyx7f+lUJktS45lDcexTYLK8f9tnXrec5n1FLKl5zeB5ZVkjQE
         OKC2QUm3dgiNHvGYhnjlW56YUHlZaVg0FGOVgVKhZEOJRt3h0ePiK/oZmjN0jCE6sSfU
         4SI97Nn4yCv4+S2Xs3NOmANQqH7uP78f8WdjMiMtr5hNdRfyKfBLuAHQhn2SxR0Qady4
         KfSMs/ykBRauST36xs7rb7SzT4bBvoCFPZY0JZSAAyMbIR2vWj3XIPZ0mhj3BbkQrlXx
         a9fB1hVBtolV/HUarjrevUgW+hLk1NbiyrOlguiBs0Zh8ce1MmPxb9DBK+l/rRjH8Myi
         xdkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789401412; x=1790006212; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfklUHIPWaWmrp2t1aYWGciesvwPpwkoe+iBPGV/Vsc=;
        b=ORPK6RDL2qaDKA5qkerGeElEfbx9YwRujFEaZhCL0VNvY0AzCbv8fnSYrPg3qMOsb5
         aoDMPQ7OfsXtp71hbc1oEdjmS1QYAoZnI1EljL14obvc/xZxs2FGnBJT637uQ7q+ILmd
         cK1WrYxcS9kTBNsC3PnkzJJnQVfzZW/a1lwiJElk/oqbu4Homlg6pPaXmtxi5hVPzGE6
         f2iTowXyeVt1aCqoweYNjrxT1d/x2d6c6LFuCqaOpSVTRuuemI9IjS4ilIPv9KQsstJH
         /mMlGL0g39MaZrpSLmVmMiGjsqzWEQv7sbestBxHK/aIge9FaIHlETemJZLgZqIwKRo2
         8ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401412; x=1790006212;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfklUHIPWaWmrp2t1aYWGciesvwPpwkoe+iBPGV/Vsc=;
        b=UVQeDl7ZnFeVLBQQrYee5dRKV9/BWVjhjHYnaE/5wG0NrmjYcGwXFcWY2BpFwg7X0j
         Fe7F++6c6czubEAs1TgKo/5p7bN8YEjR395i7/Bt4uHrs3FvEebsVoRamREX6jvadhLa
         YSKEM7+xFj95l3ICPbnHTwTGs51enE9IOlZv2RcZtj5zqhAE3r1Z8ua8yUySPUBcrSbz
         V7olp/IGs8cXwAek6ukGpGkaFzNUjsjSE+2d7OkozYYrb00nVyaHgh9WWWcCwrn6Eplj
         AS5PK2AByxkA5WSZ4aEggii7yaV5ThoNkMwbSKTskYiHO/YyrA9ltjjbIowcRZJ4wuFX
         J0+g==
X-Forwarded-Encrypted: i=1; AKwUvByKEatwgcLCcx3Pog96RCkSZG0466iZcH2I7flJA+IHJsWpBY87wl9qmy+/djfSg/RnvLWMGgc=@vger.kernel.org
X-Gm-Message-State: AFuF++ljT7oUCXNQTOWtvdvCEs6IPZvibB0D4RF7ePXcpDuTj5crrd9X
	WyioqQbNscUaO98FeQaHxa6eN9z2jf2QjAuSAkUNg9EGmZKV7GxJZw82jUSXVbqaNf0rtqjV6dH
	+F4qeBakaePgy1eOIkFo57PzIdMn0fxTWQZebZhhh
X-Gm-Gg: AYBFou31+fPpCbAqGfRmL6d2Uq1F8PrJ14tRwPc9UNCxGiB7xTfifiSkWRjI1BBy9UG
	YfUkT9dej8wVGAFdzTt6Y1hlzAHRbiayIq1s9Dct3qT1rgwcGuui/EXrPItiEKfsvT4tEG+rOy7
	aUWhNEdL55A5+bGmLiQsSZxHT/NVLNaWpL3+EktVF/qb5OUIoeVpPwMc8DWS2s8lbNuIUrk1QSp
	/hHnlzyU0J+uYqJnA8t2uJA01yZN8/pNdhEgQ7OSW1lAFwmP0FJnaHky9hFlN+cWRXU9p/vBOkg
	1mrUoym8gIe7bTkjti09m3grwRRVtIa7BjVMB/gquVVPpg7UzvwtdHAepcyqt39kr2Lj5Y0ebwV
	tjIYMZLdfpw==
X-Received: by 2002:a05:6122:4b8c:b0:5c6:64ac:d6f3 with SMTP id
 71dfb90a1353d-5c981d3a2b4mr3488872e0c.3.1789401389359; Mon, 14 Sep 2026
 08:56:29 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 08:56:28 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 08:56:28 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260909155003.e6c2f4fe3c0bbee3b34578fd@linux-foundation.org>
References: <20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com>
 <20260909155003.e6c2f4fe3c0bbee3b34578fd@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 08:56:28 -0700
X-Gm-Features: AcwNN1VbtSw2suRdJEPwwVSKB7yg54T9kxDFDisYSP9Jtt5N7Dkjunh5FrFt35g
Message-ID: <CAEvNRgEwbUXj5cVQq4A-U=AMOzP3S1mjnrOC79Li71wf-E+dDw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix HugeTLB subpool used_hpages tracking
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, Alex Shi <alexs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hongxiang Lou <louhongxiang@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
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

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 09 Sep 2026 14:49:25 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:
>
>> HugeTLB subpools currently only track used_hpages when the user configures
>> a size limit.
>>
>> This is buggy since when there are existing allocations from the subpool
>> that would have satisfied the minimum reservations,
>> hugepage_subpool_put_pages() will still restore a reservation to the
>> subpool. See below for an example of a false reservation.

"false reservation" should have read "false reservation
restoration". Will fix in the next revision.

>
> That sounds annoying, although isn't clear how this affects end-users.
>

I'll also add this to next revision:

hugepage_subpool_put_pages() falsely absorbing reservations (aka
reservations being falsely restored to the subpool) means
hugepage_subpool_put_pages() will return 0, and h->resv_huge_pages won't
be decremented. The page(s) still being reserved in h->resv_huge_pages
means fewer HugeTLB page(s) for use in the entire host.

>> In addition, the subpool is considered free prematurely, is freed, and this
>> ends up causing a use-after-free.
>
> That sounds alarming.
>
> Do you think it's best for us to submit [1-3] for -stable backporting?
>
> Is it feasible to come up with a set of small little fixes to get
> -stable out of trouble and then to prepare broader updates for our
> ongoing mainline development?

Please see [1]. I don't think it'll be easy to come up with a complete
set of small fixes to fix all the issues that are fixed here.

>
> If it's "shut up Andrew you're always saying that" then OK, I can take
> that :)

[1] https://lore.kernel.org/all/CAEvNRgHbzY30n1hz2vv7BiBMMhci+NEv_ubP1LjQNmBuu6Kjgw@mail.gmail.com/
