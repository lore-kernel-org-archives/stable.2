Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655551;
	b=I51PI6/EDk0VbtfqFEK8gIhhxXwcOEKviKXTjkYKfF1wce4gTwdan5/agv8fDmvH+61f
	 B0Kfqr5SpIo5m6nGlKoyTzsd9lTpIlxi2dnvzdRN3sfloQj+N2PL3ecngZ9gspNLoZfIo
	 OYNjYJb3lTkw3HOOArshUWHt9JbZ7JuFHQFQgPEQusjKDTyrOrYugtqLT3cZPWOLRJsMP
	 ekI/jK+YJ6vtAoDpSDd27ox+1N9Gc8lnAwBFFqcKv6tK7y7nLciYLaw+mYmDITxd+i1T6
	 sw4jAzbbf/LLk7Hnr/8THWPf+Jib85yRe8jS74NFbTNI6eVZBO1flRGy/TXeX2LbYrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YbMVc5P0tRqN8v0ioLIphiBpTqOVDwdaBT3lngdtRCc=;
	b=CmqJPqR40V/mJp8oO3OuihetsqHlBx9DS7e0cVU9/xP+Qb4Abal1pw1IDHtgNc7FA6qd
	 Sfzc7sqykCzTNwK+VMpLxV+J5BN9saacCoZKCJXYvL8B723oZhOH4u6q0SZyGN1+tNuPi
	 1epQF+/eacCiQfNfBn12iCNGtA4Jec/JzfGEXC/HfY+++ZAAxyD2h96IoPJ4dnYmnbupt
	 X6tr9bI/WoW5mnj5UvR6kGilYhG9QW9uVa7x597gG2oDdLUxbvVhrLv98KmoSYgFlvYyJ
	 G0qQfagD+70l9JAZP5JG1kGPGnrXz6Wq5v8BqP1nz+/zDn29COEAC2cRHGxGm+sdtjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ewPmq7Yh;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9F606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E9F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ewPmq7Yh
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-372bdb942dbso1998352eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794655549; x=1795260349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YbMVc5P0tRqN8v0ioLIphiBpTqOVDwdaBT3lngdtRCc=;
        b=ewPmq7Yhcjfu9vTvSkbroSm5qRgQMtxC6fGTEPdh0bkglUhtjTf+XHzHUhhlRF9Y2W
         eoAmu+LX/PBi3rov2JlDMkkY2UMKq+0PR4aR/qkTewuqz0jouuObsSuOydr/0hQZizQG
         hpPNIhiK9YfeaKwpi4DK4EZj9uj73yuebsBX0MW769mUw+OoQS2y8m7MCUpnlfPYqsBV
         msWWwPah+ejLcAcLS5zM53sfDlOXNn49ewL9vOdjG/EvW8A4Qf+0JwJwqH9oL6NbSIbj
         CmrKBOONCryJGDHPiF7cUD6ubHVEEU3BEZ56cC8Q1af5sjwFX2ryYXp3flDN3FyjRB/U
         BrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655549; x=1795260349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YbMVc5P0tRqN8v0ioLIphiBpTqOVDwdaBT3lngdtRCc=;
        b=z/KFE2dnlc4+Zt7G6ZSXLtio73nFW/b7fXxlJltTZepkW0k1DwBkSzZUZbw+n7uwRv
         wF3oxi6Y3f+T956+DMm93ydnfLHrfyhFhGWivbJdQPwVXQDj7GxnbJrsCPVUgHpOmsyY
         BaWwknDN54A7qNxW/PMQT32oegDbB24ypi6sK+lKt76rYG8STRqQi1eJ+mf/Wz8MDCem
         ls51CIwT4YRG4oo9I5ScQEQreI3MQeT97TsY1s3w+rK5ZCY4QufQreK6oj/fYxJjUCKu
         1h72lCOBCoPE45TunzqopX/xCjuXIBTP3nNIsvYEkQaS2eCTiY6ISr7plQwRgTWPPfec
         Yiyw==
X-Forwarded-Encrypted: i=1; AL+hErG0vzNeVGIXtpFjcfPyPKyj+He4eCDfEkX5XpChozaKUxIse5ZCDfh00O5sPFesl7100sjnILA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CZRMcdsQYbOI/LPWkBJWsLTG74Oy9eW5dBbDY4GiBpJcA0Bdl
	Lvk5le3ydARWxRLmUKc/c0xvGvlUpXyjUFnr3a0/J3aPF8zZHvNqe9cSLgbB8QnBDtQ=
X-Gm-Gg: AYBFou1vdHlzi2+1cMTxy5iYOK4JGQKqvMBCaSmIIe810MJULQW4wwCYwpaviFmAEqy
	Ej1mg22+9Ra7LK6sOIyBFtv0fgl7xoQUFdYP1CVyIoW1OzwFnnzzYhKP7UihMAmX22sqwjmFNP+
	xm/oGlt3cy+nQKN8+73S//uap0DvGIyqZRkmnC5eqLcCMFN3k3KXLElZHovBn7g10OTzqEEPA3i
	lLdzanskU7gLQIQGYGpcsD27ZpNyNfDMRkByNTncjwsrQ0m3ElOXCimLqey+iT9wEhluxxIBsrj
	sjMBXsVQJmf9CVlNKAaabKQnOAnyYGmOJXASWqGrefRiiTjT1ltSuXZR1C8E4WBktrCjrPA5JuW
	drhTf9+JbEnuEg/88djGzoUiItA1szBY8aCyh8uZ4K6NdYVeLYqNo1dZ4wepWvJ4p2+JhUxqdMd
	mL8KUR55iQ/4TmnkcB4gCR15P+sO/uwW++8MUDtGGbK9kQ0VNSxb+8jFSX7nDrFs/Q1d5oagkJe
	AGHYhFdCGEBQzW4QzeLDRq0674c0uJNIYpHkxBkLLsQUx4WF/2/PORuvJsVDKCJDzZYViKDHx42
	hhPvo/NEBPaS0LobHX1oKVMZ2ZLKriILoe1369gaoXf0ZTWR5XbuP8loA87TeOQZ2V7hpVXLCXJ
	T1Q58yQ==
X-Received: by 2002:a05:7301:90b:b0:34d:755b:d60b with SMTP id 5a478bee46e88-37968b8a031mr4631308eec.34.1794655549376;
        Sat, 14 Nov 2026 03:25:49 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:9d36:3b30:f4a3:7b5f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm16190627eec.5.2026.11.14.03.25.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 03:25:48 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Jose A . Perez de Azpillaga" <azpijr@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/3] mm/hugetlb_vmemmap: Fix HVO races and deadlock
Date: Sat, 14 Nov 2026 19:25:20 +0800
Message-ID: <20261114112523.75208-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three HVO issues reported by Sashiko.

The first patch serializes HWPoison updates and removal against HVO
remapping so raw_hwp_page state cannot be lost or freed while a
replacement vmemmap head page is being installed. The second patch uses
an HVO-private rwsem to prevent deferred PMD splits from racing with PTE
remapping before the TLB flush. The last patch switches the vmemmap walk
to the lockless walker so a PMD split allocation cannot recurse into
init_mm.mmap_lock through reclaim.

v3:
- Serialize unpoison_memory() against HVO head remapping.
- Update the first patch subject and description for the unpoison race.
- Collect Reviewed-by tags from Jiaqi Yan and
  Jose A. Perez de Azpillaga.
- Rebase onto mm/mm-new.

v2: https://lore.kernel.org/20261111093747.50048-1-songmuchun@bytedance.com/
- Add the HWPoison serialization fix reported by Sashiko.
- Use an HVO-private rwsem for deferred PMD split serialization.
- Add the lockless page-table walk fix for the PMD split deadlock.

v1: https://lore.kernel.org/20261110112456.62827-1-songmuchun@bytedance.com/

Muchun Song (3):
  mm/hugetlb_vmemmap: fix HWPoison state races during optimization
  mm/hugetlb_vmemmap: fix PMD split TLB flush race
  mm/hugetlb_vmemmap: fix deadlock during PMD split

 mm/hugetlb_vmemmap.c | 28 +++++++++++++++++++++++-----
 mm/hugetlb_vmemmap.h | 24 ++++++++++++++++++++++++
 mm/memory-failure.c  |  3 +++
 3 files changed, 50 insertions(+), 5 deletions(-)


base-commit: 6ec534d64f85e949a5d58070678dcd7711875a7c
-- 
2.54.0

