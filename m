Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936B57D224
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201367; cv=none; b=EgzVwRnvvL5It3ZaD4Z5lAR+dQTgom/1yCt5ActCwTwvRD+rLGz17OVYEyBfFXtpIcm5edy8LVZwQmcBGf/JCdFvWtTs8BROMLOKDjExjZyRijWu0KkRsuUqVC0Gfw+gyWOSyYiwkvNyZefB48LL/Fe9NmlSKne1ZsbykvoUudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201367; c=relaxed/simple;
	bh=b0TAtr57yWE+QSO16pjO+nrOxPN+Pz6dGmFJGAl5jPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGBQp+QyUq72qPxXYqzk3Hq67RCXoBhIu9OZlCS6mO/DvPM7ZQioWbiEZwZXweyEVF72mj0VJEXxPDJE1q4lGci+SdF9WJuTZhMrWN3F/bFrxlibyPGgJY4oHf1lU7gM1cFerZ0lRjUZSVhh1u4AQdS1qcnObkUkmy4kyXtGmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9QTMXJt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9QTMXJt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so8730355e9.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201363; x=1790806163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0vfvvH4VnMd4dK0iJViHA204XuBKefpDpGV2LA9qE58=;
        b=h9QTMXJt529P+ivT8K/Igvt4pVV+HjCL8HpXctF5Xppnzu6yZUzU87JlYfLnAjmPKp
         4ENpM7djj5W8zteOLNX6DzL2Sf8rHdI6HM1m8kLLCm/4902HLvNV9Os3uzsqZcSoVgW8
         UCP/kt0+sDBJHU7ic5ULupFxXI4S9FntJo1S18I+jpd8qUst0xwfDa0H9XE9EwtegU83
         n1avfsM3xkNVK83Tm4wSltvsu6se1od/aBsWsaLOrBmCZHaDuu88eBnKBBptXKkL6zg5
         oMntgPNUTUKgGqZnChWdL5fNPa1WE0iDhg+s+CmidVUwuXgbB739GCHDY7HrlVoVxeIS
         rakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201363; x=1790806163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0vfvvH4VnMd4dK0iJViHA204XuBKefpDpGV2LA9qE58=;
        b=BWmascEwJcVY0Vbgjn1eyduCnblt3d4nSIt0cKAhVQG3wI3AYTlig9+u3w2EteBhVY
         LKTJNgSsneb1z0vH76u5iq7G+nRUjr4x38uA4Lnev0GGzml1PCfLNkS7hapPbIG/omj2
         HWE4na0utqSsE1+y6gsSKYrewshsqowqOiHRZOdyHSzJUJ+aZk0n5nsiZmef0cl/aJ7y
         1EdLKov5v3Oq2wHvEHml1gS8j997cnGE6XcyDgNbJOYxLIUDaJpbSwMVqR5r7xVU4MJg
         stZeWsjh/BaQ1sSuqyZe2yiEVwiS2t0jw8Uv5mFLKR9HcS+guz7TVaoq1X8XfoCVTIga
         JI4A==
X-Forwarded-Encrypted: i=1; AKwUvBwUtmafCKm6gNGXtSs2Ea/rB6KSYotu4CB/Cen7c5e+CJunI3upiaLNxfkU9wjJjnARpwLPQhY=@vger.kernel.org
X-Gm-Message-State: AFuF++n/JeuO7SYRH0zij72OZF051SNkcdXXgIfIJaDklsBggAfErxF9
	UossTGZoj4PrZc9Xxu2NSn2PsqxYURxUFw5ex4M2KqmIl6QPcj7ehEie
X-Gm-Gg: AYBFou3w7pAVy5JQs7Ogg51V9bRAaxcXjWva9MZhv0Y9qhSJXclbYkk67qR5xR2vY6D
	Iv92P0Wy6qsMlu5GIRIf9oStLuovaaj1ro2Hzul0w85anSUOzXR5o7DBzfqnAE4JJnfd05BTXtB
	pRhtqhj4ix9g8Z5JYv0JnOAxR7e5iXFKHJdb3ddr6OgJDGTUaUMDrvsjRMJFN7gN7cRe3Zb86JF
	r6zGKtPsXUB35tgnNsUvqRX2m7uaR7H7AQW8sS0GntDYdYaZ/Dyc/xywi+KkoEZXxELP8CaRCnQ
	298bObLdf62TzS6mAF2CE/fvJoKTHJZ+v+i3d7KU4D2b1cVzOa3pkM4tcUpuI2Eb60wyPkIdRaQ
	Os/E/pYTUl5edkj3s6Rx5UUctdk9D0KeCEDGE2vg0lLn67bj2v4a7yftN6cqPcDGGREWFaPBzbV
	wkXPrd5FQV1m8DtSbve3ZRDnoAcwrmZQ1iGZ2apwLoVTbQkgJsQy6eAhNZqNYcE5n12QcrQbqZy
	bPSXOkMwqMsp6OR8roXfbdwOY8as8CgEY/AGtJd/5FjqWJHbLkIRqVI5ceX/JgB9viwg+9BcNlu
	KS5aP1XnDi03FKzVovpILghZcI6sKxmpYYHc8zj3Tr9x/6HBa4Ni9YlG/aAbcA0utUYlvXO47Ph
	Vk26lOkiOIslm
X-Received: by 2002:a05:600c:138f:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49fe66d2700mr8501195e9.8.1790201363197;
        Wed, 23 Sep 2026 15:09:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4a2-9601-c082-2dcb-3f3b-92b8.310.pool.telefonica.de. [2a02:3100:a4a2:9601:c082:2dcb:3f3b:92b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf3541aesm57899075e9.0.2026.09.23.15.09.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 15:09:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	Jinmeng Zhou <zhoujinmeng@bytedance.com>,
	Alex Shi <alexs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Hongxiang Lou <louhongxiang@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
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
Date: Thu, 24 Sep 2026 00:09:12 +0200
Message-Id: <20260923220912.46905-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org>
References: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com> <20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Sep 2026 20:13:07 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> So if downstream people (-stable maintainers, others) follow our
> recommendations, some kernels will get two of these patches, other
> kernel versions will get three and some lucky kernels might get all
> four.  Are you confident that the patches can be split apart in this
> fashion and still produce a good result?

Two things I noticed while testing this series on v7.3-rc3 (x86_64
QEMU, one CPU):

1. It overlaps with two fixes already queued in mm.git, so I've added
   their authors to Cc:

   - 3/4 rewrites the same out_subpool_put: block as Zhao Li's
     "mm/hugetlb: fix max-only subpool accounting on
     alloc_hugetlb_folio failure" (mm-hotfixes-unstable), and has the
     same Fixes: tag.
   - 2/4 rewrites the same out_put_pages: block as Jinmeng Zhou's
     "mm/hugetlb: fix subpool minimum reservation rollback"
     (mm-unstable).

   3/4 doesn't apply to mm-hotfixes-unstable, and 2/4-4/4 don't apply
   to mm-unstable. If I read them right, the queued fixes only handle
   mounts with size=, while 2/4 and 3/4 also cover min_size mounts, so
   they would probably replace them.

2. On splitting: 1/4 applies cleanly on top of both queued fixes, but
   in my tests it made min_size-only mounts worse on its own. As far
   as I can tell, that's because it starts tracking used_hpages on
   those mounts, while the two error paths only release it after 2/4
   and 3/4.

   HugePages_Rsvd, expected value in parentheses. Q = the two queued
   fixes, wrap = 18446744073709551615:

                                   rc3   +Q  +1/4  +Q+1/4  +1/4..4/4
   min_size=4M only:
     SIGBUS faults [1], no files (2)  2    2     0      0      2
   min_size=8M only:
     failed mmap [2], umounted (0)    0    0     3      3      0
   size=8M,min_size=4M:
     SIGBUS faults [1], no files (2)  0    0     0      0      2
   size=10M,min_size=8M:
     failed mmap [2], umounted (0)  wrap   0  wrap      0      0

   With 1/4 alone, the min_size-only mount loses its reservation, and
   in the failed-mmap case three huge pages stay reserved after umount,
   presumably because the subpool is never freed.

So it looks to me like 1/4 shouldn't go anywhere without 2/4 and 3/4.
I haven't tested older stable trees. With all four patches applied,
all the cases above give the expected values, and so does the
partial-truncate case from the 1/4 changelog (Rsvd drops to 0 after
the truncate instead of staying at 1).

I'm happy to rerun these tests on a rebased v4.

[1] https://lore.kernel.org/r/20260923065714.20781-1-kmehltretter@gmail.com/
[2] the scenario from Jinmeng's changelog:
    https://lore.kernel.org/20260907132055.26696-1-zhoujinmeng@bytedance.com

Thanks,
Karl
