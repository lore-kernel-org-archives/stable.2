Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793411225;
	b=YZSjo1xEZpYnCA7tciR1GH65kmAH+RxITG+/8ldjNnqDDGOaZGC1gJ4IgUcg1c5fHUlI
	 xwOxExIfXhcGwvnGccBv+fGpIkg6vCxZY2ew035J+RLZO6XCWfqGMN2Vp55TXUQkBi7ij
	 0sh02Apy5SHhVMpCgWMqTE9msoVioZZVoXfh9TZTAYq5oItDFYln5GNuGp3A9WmmqS4ny
	 D91wXiqOaqrILcS3a5TMi0MdmgTs1et8ttv0Y8a4OQtBhSPNbw6sxGmUka0XXWWJnlOvH
	 CBsk4Cdr78OKjW0njT2TlBKnx4a5HsliAGG/8MzBFRITlXGI2tqZ3Ic8tHGr8X7AzBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793411225;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=AYlirVancYMmRVjJDVShp6lZsb2527J0ak94H6cSizE=;
	b=LAfmVYjS7JRbvl8u/xrTHGlxHyq/nxYMmUD+e3fYphKGBgv3Sqf+YSFzlVsivo3DJFjs
	 xWEWaKNadguAJQVPt1ImFYXu4eEC8D+zWhKnc/nJt/zTxeS7GeFp2yw0s3ky9vwhvXlzw
	 QK/bzzmGCO77R+xW0Ci14pSjnWcoEYkEa6MBm0PY89ugJxKzU+y/DoavUfiZ08ICCo6qg
	 28mlKPMk4XMk8vle/8hQSfRHDkFE90OfN3fBj1IBBwj8EPfetSZzAbPI5J6a6vOfwKhVM
	 WOmXWzBIufxfThN1R7Ipkca6ggOH6q6aGAqHSzKxvoS39OSu0glgf7eyvC4+SI5ytbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="oaR/9Pk5";
	arc=none smtp.remote-ip=91.218.175.185
Received: from mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86C606A31F
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 01:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F86C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oaR/9Pk5
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AYlirVancYMmRVjJDVShp6lZsb2527J0ak94H6cSizE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793411222; v=1; x=1794016022;
 b=oaR/9Pk5kopXuDFGOADw5cPDH8Yeq4Tq0PC9zZCmeYWgtIkIP6nFWBr2T/b6HDaxKTldYK6D
 pVJb4K3qheNdEpfyyusTssNM+tD5QtLEKbpFp43OuHwws/sYB0BiZnXS/dFPK6KM90iEL4u0PCV
 iCIGRF/sxnsFXhzxYHJah06Y=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 6df660725638d07e;
	Sat, 31 Oct 2026 01:47:01 +0000
X-Mizu-Trace-ID: 6df660725638d07e
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <febf6aeb-82dd-4a98-9a33-0ef321792285@linux.dev>
Date: Sat, 31 Oct 2026 09:46:37 +0800
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 SJ Park <sj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>,
 Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>,
 Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>,
 Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>,
 Xu Xin <xu.xin@linux.dev>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
References: <20261030002004.154595-1-sj@kernel.org>
 <6d679adb-a866-4a76-b9ea-3b8c64171fae@kernel.org>
 <febf6aeb-82dd-4a98-9a33-0ef321792285@linux.dev>
To: Ridong Chen <ridong.chen@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 31, 2026, at 09:41, Ridong Chen <ridong.chen@linux.dev> wrote:
>=20
>=20
>=20
> On 10/30/2026 6:21 PM, David Hildenbrand (Arm) wrote:
>> On 10/30/26 01:20, SJ Park wrote:
>>> 'get_maintainer.pl --nogit --nogit-fallback' suggests adding below =
recipients.
>>> But I can show there are already quite a number of recipients, so =
I'm just
>>> noting here.
>>>=20
>>> - Brian Geffon <bgeffon@google.com>
>>> - Oleksandr Natalenko <oleksandr@natalenko.name>
>>> - Steven Barrett <steven@liquorix.net>
>>> - Yu Zhao <yuzhao@google.com>
>> The CC list was so long that I limited it to people that area either =
a reviewer
>> or a maintainer of code.
>> MGLRU not having any real maintainer is a big problem; because that =
maintainer
>> would know whom to CC.
> Agreed. FWIW, I think Barry Song and Kairui Song would be good =
candidates
> for the maintainer role.

+1

It would be great if they could take this over.

Thanks,
Muchun

>=20
> Both of them have been contributing to MGLRU consistently and
> substantially. Barry is currently working on improving aging and =
fixing
> the swappiness-related issues, and Kairui is driving the MGLRU-FG
> optimization work.
>=20
> They have also been active in reviewing MGLRU patches, and their =
review
> comments are usually to the point and helpful. They have been looking
> after this code well, so I think they would be a good fit as
> maintainers.
>=20
> --=20
> Best regards
> Ridong
>=20

