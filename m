Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=96.67.55.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138644;
	b=GkYf9MsFGRcswpcflzQV040fFm22FyrI4z0lrbr30ajaq12jHlivXATBmX7NpuWx9iJ3
	 /ycMgeSIaVE9XfIF0p1aK6nirNxsQPzZyf4XfC5f5L8DXtiY90v5Z+EUhX0QoONsHiUak
	 as1Skn8XCMSGX4JLZRseK0e40tvshRzkW/KlwFWeNVoZMt+CzniVcCU2ZeXMoEdWZDWS8
	 x5eqf1dKohUtIpnhoQATDGtE9CB3ER6+MLs3F4RDS9ksi1uujgCZDnE1A7Wcbd64l7sWk
	 V1CIcCoXxfDNa7BB2FNv74TjLwM1rl0sTWrg/KLYsfG6XwF1IhHFcholZFV+ZE3yP4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138644;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ra19lD8Crx8QohBcrsGmDVBKOcqDjMmSrSzcQ18M9zg=;
	b=jHAtlaP10eEgUx3K720MkNkyiTgXqmmKGAC96KG6rWZP5/EH++EZtpmMa/7wqTHDe2SD
	 81mLXOWEqfjGnp+clXbdvm50/0/KPliwOxO2MWiz25o0gAdhqcig5gZOx5vwv3ikiH1cd
	 hiArzipB36EGfT7TFqaM4+qH1X6zJaxsKjh0/bqsXpkAsgxq7X36942fvr+UQzJMFNrQB
	 ZFHGfH7EYlXnJrtbwTVYDVF4QjT2QIO5uPLF5o/gBV7y/61cSXK8A7c0iJ6QXRdC8SOf9
	 XdLhiwa0cuMFQQRpA3/NcvyFqJt/niqNZpMKS3psakz5Zp47BWR313+R//tU2TmE8Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=surriel.com;
	spf=pass smtp.mailfrom=surriel.com;
	dkim=pass header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=djmhDBOu;
	arc=none smtp.remote-ip=96.67.55.147
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9A606A31A;
	Tue, 27 Oct 2026 22:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=djmhDBOu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=Ra19lD8Crx8QohBcrsGmDVBKOcqDjMmSrSzcQ18M9zg=; b=djmhDB
	OubPpTf9NhqXyoYINRrSPKiGvPUJ4NX+Hk8yVeI2HGGWmUlWyeHrj6vg4Y7v33xaIi+4+aZoIHNus
	B5oUcCzCkFPc8N75CXJuNLV2ZeZvoMRWNlVLb1DVwfC7EqGYeYZjZaEYORE7EFoXy8jhyyNxaXuE0
	dK6YKElLoKxfXNY7Rr3S8e01wCPNO30tunYNiVc9JNgy9uS6vf15q5Lpbh654jnbBz+pziF9n3lV5
	RZJlwgzoO5f8pMWJDeUnJEXZNkAxXRkAxsnJ0FK8Q+WfHVWuH0NvM0bQ7h0qOqgG+Z9KwHNwDSCxv
	uCk6byi3jwKieKYfnOkXolBr5qSQ==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xLpFA-0000000010l-1L8i;
	Tue, 27 Oct 2026 22:02:08 +0000
Message-ID: <8131011db0b4753a1e3b02ac70abe1b1cded6faa.camel@surriel.com>
Subject: Re: [PATCH 07/46] mm/filemap: don't lose a folio lock wakeup to a
 signal
From: Rik van Riel <riel@surriel.com>
To: Pedro Falcato <pfalcato@suse.de>, "David Hildenbrand (Arm)"
	 <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner	
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng	
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo
 Stoakes	 <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, Barry Song
 <baohua@kernel.org>,  Axel Rasmussen <axelrasmussen@google.com>, Yuanchu
 Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,  Baoquan He
 <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam
 R. Howlett"	 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport	 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko	 <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Peter
 Zijlstra	 <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh
 Dickins	 <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav	 <pratyush@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Lance Yang <lance.yang@linux.dev>, Harry Yoo	 <harry@kernel.org>, Alistair
 Popple <apopple@nvidia.com>, Nico Pache	 <nico.pache@linux.dev>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain	 <dev.jain@arm.com>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau	 <kas@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, John Hubbard	 <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Will Deacon <will@kernel.org>,  "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Oscar Salvador
 <osalvador@suse.de>,  Minchan Kim <minchan@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,  Chengming Zhou
 <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>,  Nhat Pham <nphamcs@gmail.com>, Youngjun Park
 <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Ying Huang	
 <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, 	linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-cxl@vger.kernel.org, Josef Bacik
 <josef@toxicpanda.com>, 	stable@vger.kernel.org
Date: Tue, 27 Oct 2026 18:02:08 -0400
In-Reply-To: <auDM5mvsb5ilIdsg@pedro-suse.lan>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
	 <20261027-fixes_core-v1-7-6f74bec9a5bb@kernel.org>
	 <auDM5mvsb5ilIdsg@pedro-suse.lan>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-27 at 16:10 +0000, Pedro Falcato wrote:
> On Tue, Oct 27, 2026 at 12:17:27AM +0100, David Hildenbrand (Arm)
> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > An exclusive waiter in folio_wait_bit_common() can leave the wait
> > loop
> > because of a fatal signal, then be woken by folio_unlock() before
> > finish_wait(). If the waker did not hand over the lock, the waiter
> > returns
> > -EINTR without trying to acquire it.
> >=20
> > folio_wake_bit() stops after waking the first exclusive waiter, so
> > this
> > loses the wakeup and can leave other waiters asleep indefinitely on
> > an
> > unlocked folio.
> >=20
> > After finish_wait(), let a waiter woken without a lock handoff try
> > once
> > more to acquire the lock. If successful, return success so the
> > caller's
> > eventual unlock wakes the next waiter. Otherwise, the current lock
> > owner
> > will do so.
>=20
> Has this been reproduced? I feel like this would've been found out by
> now?
>=20
I have seen stuck waiters, on a fleet of millions
of systems, but I have never tracked one down when
the root cause was transitory, and no longer
visible after things got stuck.

There's no way to tell whether or not this was
the root cause, though the symptoms match.


--=20
All Rights Reversed.
