Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853359;
	b=e9p/Ql52bSgtj/Lg5q6ovLhAyuNJvAGalO8F9FghLNEyUYi20CA6UCeSYDvzG/faWMHj
	 LuPmiAtG2FVIEFczDlFhb07z0i1wn5Uy5lavxBxK2Ok12gmjaHvjiX57gfuIA4CilpwBb
	 Vmb66nBBVz67a3f0UKGWhRR92ETMuQZginPusR69l1cAyb3irf98mqxb2//zK8txrxGZq
	 R+C102pFjO+6LezMUQAVHj5x630MpHzAZwNQ7Sxe+RibzBDxKZhEHm9BE7q8vlYE8C8dC
	 sUL4QXAlvG6q2t1ClV3OQoxbYYXwsu/AOy1eDGpbDDq40wz5aK0YAw7Zwnz14w1L60Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=MqhyZLQkkCy8/4ClTcekh7qpvqyyl6/PFl4tE1ESvso=;
	b=tMiDRg/oqZhQiP73xlqRHATfrVdr35JZWePlcZzt+uzSb/pOSwXfLOsR/feqVxhseie9
	 3x+Yi9oWslRAVk4Wq0MkcJCiKXxEO2t11RCdeF9011xGRJi5qffHo53KFXqjUoQ1uJQVq
	 /JhhQWK4f6YQfQAKo9RQSlFBGUO7gKjzyCa+xuJTsRxxmMGDyA6DqKOhhV9P90LVDHw05
	 L2UBCrUPmzZAyTN5gi8RhrvMMZGRn/x/WVc5byfT1+jIPRBGAhxgeZDf+6yZbViAgP3Zb
	 ZW+52OGhVPVRyAZN6eV4kTnonzuZL2zYaHraoJtwD2o9U93AfLBQ7blRLoTjIpXuFdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=I2P8n3HM;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44D606A88C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B44D606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=I2P8n3HM
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f2b8cf037so410014985a.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794853358; x=1795458158; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MqhyZLQkkCy8/4ClTcekh7qpvqyyl6/PFl4tE1ESvso=;
        b=I2P8n3HMzvp5OKzZYOywUkl/ozYHK/CE5fFhHOEnWVWSF5Hs9PV7EqrjZetfF/5b3n
         UNY0wMypHqtMSPepRPFkLZ5Q+5s94MSzWnT2fIz7EhrM8VBiiOjlUdMLUdBZRUghmRgx
         3BgqQOrjVqwxBoE88tyXgjoTG8xRjAdqhOkIhTUPThw3aPoo2K/nFb4v4lBsDH1Md6dN
         O32jBFBsWEmvw8yW8uDJQl6YzKgWF8vJrF5z456xn7mnX5GNbYB6QJQ9vOwT5nweIA2v
         BH6h4rocb+/H+baHciMu3epiiArYA7Khb8i8FT0J/LokU6MSt14VZp84+9pNlLLkBaNo
         /fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853358; x=1795458158;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqhyZLQkkCy8/4ClTcekh7qpvqyyl6/PFl4tE1ESvso=;
        b=NWPJa9pdWdhD1SEhmntboJvk2jK7PYv8bFJOw9P5iKuV54XrLd06aNV0iDvtFbYhLm
         HpiMkY0D+JjyBvt2BypnnmofVhCx2Rbvdsvs0PGVwTh79PPf20z08bhQvC+0GqfbPtYa
         hWCYTr8qSiJ5elPYWNW4ignU4q+r8soFDATXnlT20qT90sU7OgsuxzENUfxNn9bdP3q0
         64FnqR8N3miTHffaTytNPokZLJlGFxOeF4WI48gFYH7AL0pYa07gzehX2oLUqndz3+Z0
         uGMDFrIi3OYAIniNVqzggfvL3XKmMq29C4BvlzodzNw2jjRbtAhTTEDvYiIaDhw8grq3
         N2PA==
X-Forwarded-Encrypted: i=1; AL+hErGYuA+wbfAbOx4jzaiX5Oima/dWozFtBBfw7OScubGlknVu6IWYkmwnJM6w8Ghos0+UpAq42x0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2hCXibU+JgtLAcyzdsXzcCznfxpgJcqizqCswaR+8Hptg4RGI
	mYNcN7tqNrO6lqFWvKEmMXZu4OIQjHwoLJ4hgZSH6SoqRzU18hhIFYQ7J7VouG5nKTC6d1qRHma
	kNG7L
X-Gm-Gg: AYBFou0u4STsVQJ6+GBcurs9os+el/DNvtaij0o99/qK0kNh1Z+liVzdEpwGL/4G+ft
	e18YNbEuoNupoeFGhTz/svvPEUju5cOB3TOKbfvGPtETjI62g6wbr9HIUKq9S07CMZBdCsPK9AN
	qSZVf9v81u/p6NLryVCnEE/vT8W2kBBPgye+WGQ9LCoLYSUf0bVjnI+MnjrlcqOocGesWbrMwCm
	RaRyuLKsKZWqj4z70jEpuHIR3qdZXUqXMJNu65d9cfYh/TUCvk5x3g4Jwx4T9Or61T+O6U0xjN6
	XqH/Q8+4BaPwIZmmvsXluMsaMrWunZ1QQWwFRniipZtmesbBRp1jF7Frn0n+86WtNt04PBVhQvj
	kLbk2RlVgpKqCnB1mVHuUfpZqJlNKpwbxPNqexADJ4jTezeCO/Rc1GDEGHHlAVdoVDlNYz3us/y
	/q4dDta/ozA55z4KufWXOg80quSDfb/WGDau2wWKC++8Gcxk2tmsN/QdkQJ4N5xF9hDr56xkUQa
	a6ctFbgv8+2df77sL8wm7LKIKdDu237n0T0+krzTWRpN6NCdfQrQ+kb/4U4Ei67bSRd0MyuOkQO
	Xo0hxzHfR6O+E72ZbcNCaV3GyViR8IxykNsEH6NTPSPApWAiW5vo0IDI2qwblgckAk975nmY0sz
	H5EkU7g5sg4Vd/P/JP1LVicYIy3zN
X-Received: by 2002:a05:620a:4111:b0:93f:cbd:8e20 with SMTP id af79cd13be357-9494bbeb2cdmr1788283985a.73.1794853358208;
        Mon, 16 Nov 2026 10:22:38 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836f6dsm902791285a.22.2026.11.16.10.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:22:37 -0800 (PST)
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
Subject: Re: [PATCH 3/3] mm/huge_memory: only compare PFNs of huge entries
 on huge fault insert
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
Date: Mon, 16 Nov 2026 13:22:36 -0500
Message-Id: <179485335600.482102.464304486749600271.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-15 20:58 +0000, Lorenzo Stoakes (ARM) wrote:
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> insert_pmd() and insert_pud() have issues with this as they both assume
> that, if the page table entry being populated is not empty, it must a
> present huge entry.
> 
> This is problematic as if it is a write fault, it compares its PFN against
> the one being inserted, warning if they differ, on the assumption that the
> entry is a huge leaf.
> 
> Since the entry may be a page table, this is invalid and can result in
> spurious warnings.
> 
> Equally, the entry might be non-present. Nothing can install such an entry
> in the VMAs that reach this code today, but there is no reason to rely upon
> that.
> 
> Therefore only examine the PFN if the entry is both present and huge, and
> otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handled
> at the appropriate level.
> 
> This is what already happens for a read fault, for which the existing entry
> is not examined at all.
> 
> Target the commit which introduced the first driver which both mixes fault
> orders and passes the write flag for the fix (since this commit, both
> drm_gem_shmem and panthor are prey to this issue).
> 
> Reported-by: Eliav Farber <farbere@amazon.com>
> Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon.com/
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>


Tested with a similar test to patch 1, but used QEMU's virtio-gpu device
to generate the bad condition.

With just patch 1 applied we generate a bunch of warnings, while this
resolves those warnings.

Rethinking whether any of these should be squashed, and maybe not.
Really i guess patch 1 just mask's the bugs, and patches 2/3 fix them.

Either way, change looks straightforward to me.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

