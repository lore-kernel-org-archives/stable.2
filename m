Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425452;
	b=ibOktm10uyRrMKRXiwfH5CLHlKW2qfQjwNLEejy2BzquDbzw60LQ+ZCz+nHPBkW4ayuz
	 H5f+btjEDkqlCyL+/AJ7TMEafRoeqCBSujPCCaYrmL+IaGbphZFoh0t779ZqdRmVNa6Z3
	 Zk+p4XnjjG4zGRbs40B/iFTYtUSHduVcemDNjU9DtpHylmz06p9uUSsvjye8db8ll0Xs8
	 bGynUmbCJeO5qx16yPqg+fZVtovil5q8kzkbKfy8JFSHZsSyaJfJKZFDw2NnY74vTRLDg
	 e8ISqxBGk8LOL77S8lVmzeMuPhd9N7GU6+CUaVlcDE6Rn9nlq0vrvYqHPgWsINxrZlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425452;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zo5UI9hZIeOxlpwJeSrtbBHTLqLuJCLcw0oCrYMAP/Q=;
	b=iAsc0wOZ06YCLUiCDRLviQPrIOOfpGfrqmp4NftxKUdRsAWrr+YM7D1P/VMVrGNZQHyY
	 q+omjATvT/Jl1jjduh0oMNgYiF7Ree5HCM1ABrrNavU+d43z2NJBZDeeupchV6LmzUtVa
	 dy1dQNKMq1SV2JgN7aHsIGRzp8mta7QuMxXZgYR+Omhrcl/4z7ovJp7ACprMSwO3Nt7le
	 bbemk2PMye9M+OCYIpuW7DsPnvgDGgVcACJOiPIHF0PcspXi88EGWhSG+gWxX03gKG/F+
	 Wv+eNct4bd0z5FcXFrz5TaegH54q17+fE1K8zF8Y1ywWhvS+5OG7WmssFNmf9OPmyKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b4ruwrMY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66091606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b4ruwrMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392FB1F00A08;
	Wed, 11 Nov 2026 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425452;
	bh=zo5UI9hZIeOxlpwJeSrtbBHTLqLuJCLcw0oCrYMAP/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b4ruwrMYtlS1zJIGm6IogVTN3GZoU1bw8A9H9t0VXLtSOdRH5GIKGoRYyljEKUw+/
	 SG+H/XmDobXyyRyJPIs1qMQBWHE9czbzjWdHeuIll36JCqC/pf+SjY0cWWMXiPz3S9
	 m3/4Cj+IjwE4RSAPlB0RhYwwKobjf8JV31kEu7plqziUlWBncfLxH5fv9qa5m0lyKh
	 7JRB+hChgEeLTC+3IrcyFlaRvO8FEE5CUXVpQNKLMRqWW2Pr4TUgAcc1hnDxhaS+jK
	 iFFU2uWPuV9t+kb7AMHgjGX/+YZkYYJm2DDUQq2+x2wpYrS5svzp07q7us1Uk8uMHd
	 JK/24r9x0KrEw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id AB9F41980047;
	Wed, 11 Nov 2026 14:30:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 14:30:47 -0500
X-ME-Sender: <xms:YML0avxQD665O9t1dOvEy_Pxn46EG6tbREK5G8GJxGZfToS-P_E96A>
    <xme:YML0auLI4IXUOOkzv4D8YNfzHgc6iyiOeUALj4E_vez_S7kQDHH5FiZDzY5x1nkSQ
    U_t87QDYdoRXHCu0bbBh9aIEyfkBjQvf3hq-ZPSvgx2vZTEf5kmZhwF>
X-ME-Received: <xmr:YML0ak3ycEJWZ42qb5nc47unXvlIQ1E2mffU1-LR5bQMjjrYNlMGrPHwn4Y>
X-ME-Proxy-Cause: dmFkZTFg5mDn7G1jsxtJADJ5cuZf2Omafa/3hQOhBIIimTDafnO5A24NJOlsqczvUj1SEs
    klbDFZa+cCJm+hNR5NlTtmFKeH16BjQ/ZxuKgXmvAvddkkJHCf4bAKhqrKCRIBAvA6Tc2y
    MAgurUAn0Ed38s3Jo4oTLdfx0+Uk0ey3+EK9sO/AuYl+Tqpb2jiu/k6zbVx08ECTcsFIev
    gGlrZCAYO+PEDo7Hr4y8X6VfZYUHqPPZCdOzMI+4T1F8Ak4yqSjPQhNtOvIzum4W6w4HgL
    pgD6LrrmuoxneLsUL9/IOgiboNNN1/jsaLXgUv1tvI/NokEY0SdNO13wgeLnX0R8cwrCE3
    8ehWPlH6fkdPishwD569Pod8+ltBECxeUJy8OPUjEiYWjNy+7Hfyh6uTZFZ88Tvkj8SMA+
    42NlQI6vi5L4LH3ctQoSboEOjgfLEPqpV0Dr7UXLEwvJluDcASfBTGZgbVuKqS1IBGMJq+
    af4uNR8qUNzw2wjsxhfOtj6oE7jwa9EYfRiocIwsTNRCr239Hzkr7sKdRokFLmb2WJ4yIh
    ZSiYW2UFfMMhZcH5Oa7HuJdFq4YU9JG/xU3LrFPD516cliTB5DQu1cXYv3Mc/fBpDg9RhM
    1aC1d0yqB4lnWjEIGpBELNP2UNsUbFNyTqu9DLQbN7Hf/CeIBSHGezzY5VxQ
X-ME-Proxy: <xmx:YML0aiA7eKm0J3ecc2HVJFcpHzQFh93AOUTveT7lUEnWMcd8kZ7thg>
    <xmx:YML0agRUnpPsSFdFFRoziPzyCDbyt7q0m55EeuYcBcaYNQtB_Y6ZaA>
    <xmx:YML0alVKBOCzq20d-Ry4IgqgXV3vGWOwSpTvYTxBnGIvbXry41I-Kg>
    <xmx:YML0agEbAxt22YRy2B3-CKdMA1V4gsug3S8mlWpvJeL8XPG4TA2iNg>
    <xmx:YML0auoFfbVJP5a-7819JT5NJRy1483hK0PwMYuYYAAy6lHRcUvwL1hK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 14:30:38 -0500 (EST)
Date: Wed, 11 Nov 2026 19:30:38 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 04/13] mm/migrate_device: allocate THP deferred split
 heads
Message-ID: <avTB6h61nXfvCXUS@thinkstation>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>

On Wed, Nov 11, 2026 at 06:13:18PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A THP that device migration maps into an empty PMD can end up on the wrong
> deferred split list when it is later queued for a deferred split.
> 
> This occurs if the memcg has no heads yet (resulting in a warning if
> CONFIG_DEBUG_VM is set), where deferred_split_folio() will then queue the
> folio on the parent's list.
> 
> Once a later THP fault in the same memcg allocates the heads,
> __folio_unqueue_deferred_split() and the split path resolve folio_memcg()
> to the memcg's own, now existing, list and take its lock.  They then
> list_del_init() a folio that is linked on the parent's list, racing with
> anything holding the parent's lock, and both lists' nr_items counts go
> wrong.
> 
> Resolve the issue by calling folio_memcg_alloc_deferred() after the charge
> in migrate_vma_insert_huge_pmd_page() and falling back like a failed charge
> if that fails, as __do_huge_pmd_anonymous_page() does.
> 
> This was originally discovered by code inspection.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: tweak commit message, remove unnecessary comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm-new already has this: "mm/migrate_device: allocate deferred split
sublists for new huge folios", same Fixes: tag.

Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
