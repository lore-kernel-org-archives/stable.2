Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136726;
	b=KKD0Iq5trZ1OUhvZRLBYrzhBT5knPE0ptlXZgSAzlhNFpqf0c2TVKNpLuagyMEJ2sqhF
	 Ico52somp+TKM7KiIk3pKIW5rfth/ohe6PF7oM19wBa5lPU4A/S/Vh/YrjcdXWFccDBQr
	 wPDfAFE1a8ma2V539hI/SX/R8thwIfZ2/jtHp3DKyGfb5LCNJTF7kAYR1oXLvHLP6bppI
	 KCguPXhk6HXdyuOkobjN/2loU1Q1rRQ03Y28lvrhx7QfQ3K81NT4S/eHFdCxYhMX0++GC
	 duV5paUwmJfWUXoaFbr6fPPaAaR4hUKfcI/RAtvif0T2LI3GXJEbloW8g8yCdRLCyjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136726;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S908WbS6sl8a+ccaT1hu8oFrTY/8mXQRTyc6SNjkEfE=;
	b=KD0LVmiu1VrJ5LlX/4Spxjwm1qi++3sgx5j6CDYXcKKuWuea/aa+roKLUGn0VzfU4wO2
	 x/Y2hmaXTSrps/YZKW9AXXSyO84qBbX1qULKmZGj66tAZsTpcztuTlB+LAbtj8VL6fsaf
	 tHi0cYQSHl8QqbcYt4xAvgp0LChGeD8+xxfaXKU1wgYPkGiDkRgHNDo70IJHY/DL/QxSU
	 0Dz7bKc6+B3bTV93d6Q8xlUXMx6K7oUPUmk8RuBTyuor8tBARmg7EZVVo5Jpil9u81Sqg
	 /34hqWgjXPi1g43IREbZjX/VvIwA7AOABexcHE48JdeAwn3twqCaOtg5rQTXzVmZnWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGI8e3OM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3835606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGI8e3OM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33DB1F031E3
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136725;
	bh=S908WbS6sl8a+ccaT1hu8oFrTY/8mXQRTyc6SNjkEfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EGI8e3OMSj8oudPsWvxnIieFF6gTtab2PYp1pWyo2hMoHwm9k9vSCCBUrRG6xC8MH
	 0KGkcd0cCIQIKtaEwW9h9u/ChT04cEjChqjY1CDO6ZnF5ZAGMZXsI/3+Hd+Q5LXBkS
	 tstKAH5wHNK3/OGFItDDgQcCGMMsJehCZKVi5x688GOJAnc5FMB9Yl2vm4YMrbJS8z
	 GH6396g8Z26BXcomQK7YLP1JeyvPWoPTLaXD4wMHyikZsuZfVkFw4ACyB8DThiSEpJ
	 8mEUpcgXD7tk/pPGlMJZHaXf0LVXktt2gvyJsjPwxg15Yv9qrjFy1MJTjCjDoHGfaX
	 kdeNE1WPuUlqw==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93ead211f14so34639385a.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxq7aoQlUOOGh4/9QSqukNZXrqiO418+tS8snXBgPeHreWh+uMjTdxRtkY9XddgP6p/ZVbx+PU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJI8nNatobRqLlUF2J6GZ6cvJQ6X8vaoc6CjgLPyiQmIOCNZamn
	cluSQojEsz+KfE+ep//sDrIlGuv/njoBnb2w5sN7Fts9C4Z268BtNj61BrOM+iv9Q+NUZgVZUuf
	hNMa0Vq4dK5L88ogM4kn4Q/qcHO6H45c=
X-Received: by 2002:a05:620a:6013:b0:93e:7156:f814 with SMTP id
 af79cd13be357-94408a65be4mr32182585a.11.1793136724949; Tue, 27 Oct 2026
 14:32:04 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Wed, 28 Oct 2026 05:31:53 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wPwBz8OB5opbuKsVh-ceKqyqi4d1aB8Emx4ChqDe4qzQ@mail.gmail.com>
X-Gm-Features: AclHuK_Qzkd3NBrrAvAlcTVmJZ8ovWd4rfeoh503KU3yWFCYVC_zuTNZmwxW4A4
Message-ID: <CAGsJ_4wPwBz8OB5opbuKsVh-ceKqyqi4d1aB8Emx4ChqDe4qzQ@mail.gmail.com>
Subject: Re: [PATCH 22/46] mm/gup: check for overflow when converting nr_pages
 to bytes in GUP-fast
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:24=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> The overflow check in gup_fast_fallback() only covers the addition to
> start. The preceding nr_pages << PAGE_SHIFT can already have truncated
> the length on 32bit.
>
> Users such as RapidIO's rio_dma_transfer() can derive such page counts
> from a 64-bit userspace length.
>
> Let's just check_shl_overflow() to reject any such overflow with
> -EOVERFLOW early.
>
> Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
