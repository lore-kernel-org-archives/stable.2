Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507100;
	b=pCBW2MvPJjJKEoeBub3RPOd6ffQ1iUOjlZhwtNvg5xRbWj6ORv+cMV0ZMIqgY36vwFlV
	 gUkxnTl38fJIaO1pEhD03EUXlDKVVuh5+ah/z4ADB1m5Zo0vA+qzeJFH50KOrXZOhbjPP
	 M0vaXNdXMY+cVn5EeitQ3ufEYF6XXtWldg5KnKcANG+lQIeex9HkrFPTcwM1xToeXMV6s
	 EjhB4RT8X+LeqNp6sCL/Zkve5vX06aftCe/dWHDMU94XTxBybWtmQzviGsvg80dqwxciO
	 bJRu1XRt8Y0/hhqjZP7FKsLBzXvana6EdehbNWUFNr0ILwJf8I0BvS93qVEKitaGGsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=vbhDJD4+BQC4thd2CH24LWDde1jZ/0BhOjMBI9uZ0t8=;
	b=4lVxqnrDvH4MtNgDbTcb0dEG64qkRJ0LWN7XE1H1ehM+Pp/XkDUDoqM2GhejwMKJM9IE
	 oI9xNa1q2hYyJGSw0+cGA6hcB5tH6ZnUCKhGaZWQ3mZLgxVDsGfkglE97/WS/0R9HBTuJ
	 0jAfsXhSzQE5biOhtVAuo+L0kVJL7ulJjYmKlDvwyyme3DDG3tKPZdgFCTkeNRhhBD6Na
	 SoLx7dwaQjeODRddFAYtEq37hXxe6fnYmmf0LpT8JkTyIvocs/raBA3Qu1qXpE7yV3Cjf
	 lPDcd2v9WbB/gAl7m6iPTBmouflPfk0gNMkyPHH3kDsmd0T9CvgQkXaplSRZRL1/QHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=M+YUKf86;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F7606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 422F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=M+YUKf86
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93cc1ab5f6cso3535485a.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794507099; x=1795111899; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vbhDJD4+BQC4thd2CH24LWDde1jZ/0BhOjMBI9uZ0t8=;
        b=M+YUKf86JBPSifV9KHZNo/IxkhlariouSze/wFvYmxecLP4M+6xAZUhrMz8gE2MYHO
         lYJ49kyJas62Vgxh4zG1raIwc9fO2zqjj7bJz+BNADsw6yR4eLA38ko27KzlYs3Vpy0y
         UeDHfXAx7Tugez+dsbekHeJIex+zCllOcxf0v070kEeCohrpccAuYuwq4oubwcUfhVGb
         m4ExPq/MTUzCs9adjOmKOJpRMD+Z4DgmQXD6QdMV8OyBgqBXTYzOV7QiruZECqK/4xt7
         BoXXHg6uHdXiLuxrua+v0stzvXViN1wB/1q/3QErXiw5TKlV38h9pHDcTC+3HnbBwoxo
         Z7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507099; x=1795111899;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbhDJD4+BQC4thd2CH24LWDde1jZ/0BhOjMBI9uZ0t8=;
        b=mSLCJRWScXz0xDNMUbgWcLv/yUPDWjlKPiM7pGAaalxxw7TocpEgtk21gL/8Nybo/S
         4Dl1bGvGvAepQRFyZk+GuJtxuuoRB/ogeszM1GW7D5fd3ey5OD1sV+yHxpHFS7CwnuSp
         21O7mJUlQPwaQYkQVfpW9KnLLTOnq2xAvbbHkvYjGRXUXyyylSA69jCii1zshMghyAuU
         7qzeEmYiCsS+aqnZuII2w2HR9AKWirtAf2y4yD99mMUuzMFW3KW6AU7JI/XGrX7mbT0z
         hJkZEY6o4tQD/gDQ+KJ2hONgTslOzA0Dhzub03L8x4lcYZXRCtJzXLEbztydkK9roTay
         yggQ==
X-Forwarded-Encrypted: i=1; AL+hErF2bkMpJkUFLD9mBzFznzo+RSS+Tr+ITw04+yeMqyUXl/e1vxrExaEbNFPEnmBI0uadQ8j5pbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7iNfuMBFYjztB1iapAUqyfcUqptJJ4G5viNHc8d6HSAcdGOI0
	NMHtq3/qMvSh1AavsLgEP4ECC9/A8wJe6JdjExJIMSvRNX2M9cXd3nhPwsXCjd+XpV0=
X-Gm-Gg: AYBFou3SOfmVQO4nXrZnDkQ9LuLnp7axSKR2Z2lNT0u1eOb4VZ61yEBfZRroWbbbl0H
	duehsTaw+dB1eVVGt1K50rHOOIe6CGJawGVWrG5Tf0BIUj3ahJWwGjgozjsrbhUHAQISpLHxd03
	NIG8Ru8ss2HkRCbYS/MMNuFvZ6Ln8FgIk4qFwV2yWVsOFcXrsxwG+DDT4qPlh/uz1GJbSlbFbZc
	QBWbX2pyylqLKJg9eDBgxkoKq/70ZjDVld+Xqe9iL3TUTEStWlA6HGuqmKl13lsYbpqE2aUmIVj
	3EJ6B9XpLd0K2I5iqP95iks/l7nc3u4Z53KgovGRvBix4I5MrIi3wzLEuqNPOXCQzoKuUid9eMO
	290E3+hmji2LydMsNQvW47iqDGf2E//BmfEaXDwEK5Znf8JcrIJ4HUUYNYDwvwepCAp7TpE/HaM
	KMEeklueMuvxYvPHWWOwsmjyvtc/HsK3/vTfcN+ry+WNyMCJQWEAXZXkb+7HKrgaz8L4cIa6LI+
	tc9cQa2kGwVo9y0Xv3vEWnHrgEW+6o6rJ1+yAKMujTzOXh0L4FWaRVRCNeExdXsQGv4pycmT+IA
	Rni41dSGyaEEqsp/46pyP5M85ckdmrE7nkkamITkW9qV77kp35r8Tqf9FM8gxT50dlOmvqyohX4
	kmAK8BLY=
X-Received: by 2002:a05:620a:410e:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-9494bcaf24cmr27719385a.81.1794507098958;
        Thu, 12 Nov 2026 10:11:38 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7845fasm776538885a.18.2026.11.12.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:11:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/13] mm/migrate_device: fix use-after-free of the
 anon rmap
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-9-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-9-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 13:11:36 -0500
Message-Id: <179450709690.482102.6960491372735414259.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> A munmap() of anonymous memory can result in a use-after-free of the
> anonymous rmap if a concurrent device memory migration occurs and the
> migration runs without the mmap_lock held.
> 
> This can occur for a long-term pin of device-coherent memory, or a driver
> evicting its device memory by PFN.
> 
> Consider:
> 
>     eviction                        munmap()
>     ========                        ========
>     migrate_device_range()
>       migrate_device_unmap()
>         try_to_migrate()
>                                     zap the migration entry
>                                     unlink_anon_vmas()
>                                       last VMA: free the anon_vma
>     migrate_device_finalize()
>       remove_migration_ptes()
>         /* locks and walks the freed anon_vma */
> 
> If munmap() runs before try_to_migrate() instead, the folio is no longer
> mapped and gets no migration entry. The walk still runs, and follows the
> stale folio->mapping to the freed anon_vma.
> 
> Resolve this by pinning the anon rmap of each folio which possesses one in
> migrate_device_range(), migrate_device_pfns() and
> migrate_device_coherent_folio() before its PTEs are replaced, and
> unpinning it once the walk is done.
> 
> A folio which is no longer mapped cannot be pinned and has no migration
> entries to remove, so skip it rather than migrating it.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: e778406b40db ("mm/migrate_device.c: add migrate_device_range()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Was able to reproduce/observe a slab-UAF in rmap_walk_anon with KASAN
enabled, and that this patch resolves it.

Can't say i understand the change well enough to R-by, but I can say
this resolves a clear bug.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

