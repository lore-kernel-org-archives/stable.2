Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090680;
	b=ZDC5j1Vp/jLFs3BdYvRNVVu+2T2lRS7apX6sjlNSJNeI7z2/y9ALhOntbEwshF+GYr3t
	 rQvHe6drUsbDeTIvxjLd/l0T8x0n/sQpCWP/5VvUWiMR0aB90ClojfwGXQhWppwNkcXnl
	 FUCYguEPOrVK1t70oJounNzmD40NfV3wWar1eDH+2bbUuHBCwkPkVtMc2bMAttxxSvP1H
	 JPxqoV7QMm724JWCDwOU4ewt/JPXfCQMS1I4FJMu4qDYaVkoYuexoJEzEeNC4NHpkrvnN
	 jIlp4aphOSwDJHMzb+X/gLo5q5J2ORd3XRid5rqqj/6l7H0PlsVyM/8cDlnpEZegd2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090680;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W+LEOaUQbUL+JHSbe+QhToSeMirP6JQp6AWWXj4VvXk=;
	b=w8TEt04A/YIiYmQas1YIqEWk2xAei7kkMI8sFqoWx5dUjSJGDwJ618LEGPWEDQpE4e7d
	 XEwpBrbrL3JaBFghP/ADDxSmi1n7cSypbWXXPa+6uSNA2qhdmFkFKOYqGT/Nz/qlgYWJs
	 P9Hx2DZezfKA2hxabdJcH9+ZP5bslP1NHTPpMgsYSJ+naOr7wmvWJmHrT71pJGYiX1Djz
	 b8i8j3faC2kjYUTwYwNVMJwkrWUUWaShx23Z3xjxLOYnTXKbNcPIUz8Ki3eJBbMEyJBZ6
	 7VnVc5QShlMYF7PFNED+0x91Qf9tMXcCIJycUX3699vf2H8PedfZdmY9lZPrI+x9Cwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ICCbTdoW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EC606A32E;
	Tue, 27 Oct 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ICCbTdoW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DD61F01825;
	Tue, 27 Oct 2026 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793090680;
	bh=W+LEOaUQbUL+JHSbe+QhToSeMirP6JQp6AWWXj4VvXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ICCbTdoW/j7vqJ21aKNf/Ed7op7mGrUCMSzQUb8CI9Wrhehz+xNzXORgvl1APqyYy
	 36Djhv9uRr8ibA5ZP/MXz9DGGy2YmD7yoOnrHShKNQ+NeGuxGeCDo7rr3bLeaLmD8S
	 Y6vaYvwfMvcfFhI6X25asa1qBukhNTx8j8CEt/wbHFjYyz6jqnGVxAbA5PciqivIvP
	 H1w3YA7zTBJBBFdxW3/ueobcnz6eECayjH8MEn59pysbYWJt7xD6EkLjBPY8Rz0cxN
	 yndkPIyJetYPEWfWxlUsoRHPsSpa3WU2QdMKXi2GMDbSeMhs4bt8OkMWTEjKTRKmBG
	 Cl5DzBeXFeqTA==
Date: Tue, 27 Oct 2026 08:44:23 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
Message-ID: <auBkQ-7IlOnZA4mm@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
 <179307206859.1171062.6841971971647864368.b4-reply@b4>
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
In-Reply-To: <179307206859.1171062.6841971971647864368.b4-reply@b4>

On Mon, Oct 26, 2026 at 08:34:28PM -0700, Gregory Price wrote:
> This one arguably should have at least a trivial selftest.

Generally, we don't include tests with fixes. So these things have to be a
follow up.

--
Cheers, Lorenzo
