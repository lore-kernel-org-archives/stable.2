Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BD4FC33E
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739688; cv=none; b=bLKO4iF7Hkt5AY+kkAcnBI8FMAn0VTnZ0fNtK0gB+DapxoLKz14/MXFg2JAxlRKYLxdjZY2jt26SJSXfMlSEcP6ukuLrS4A1P5Bw7Gnc4c6uJcpDjaOjzXnjcELkZWWyBjBrwpR31cnDqYJK9kdwtOUtPyqhKWN9oxAdNhP92oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739688; c=relaxed/simple;
	bh=HBA4UGDBkv/vn1j9Qy2I4DNOs12GdkwlUY7HLsx5OjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orf4d+p5FBblmSa1DoNbeOHyk8r3vUeaALdkTlHKtDWze31gp39cwXU8X/3Jm6+XAMbmP/Lb7MNRfiXC/QT5hCo41lyQ35ASvy9XVkwAaXeDao6SKzBgENj9buXvqoEfprrHt6hqP/TDnuRiN/Mka4kTaOxS5hmOg6Xtec+ynLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=b1hWbXqF; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="b1hWbXqF"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067cso81282585a.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789739680; x=1790344480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JQrKgT91q1ivpfGUE5/zHrleZU+aU6ToiCAfQUtBMlw=;
        b=b1hWbXqFKhJCjVHlbXMLM+dvb0Zi1mGM2j3wYECD/ezK1ONNPo+wUzI9Z9Br4KearP
         ZlIonRo58CwfNBjl0XEmFd2K0926ZqQLsfDUaFSaWEqt3m15HKM7d6rxxfjxzbCnOAmV
         pDhfRgiTPa29pkaDkZN8kR3I6xdReqVGUaNNOCZwZPuK5oclmR0RDmGNZCa64QQW32Oy
         cWUrIkHi1EQ2J1OSNqSmhfUDmKdAqXC1VV+XqHg0lj9FF7bS0vW8k83OX/vEoYtf7yQo
         kccfXWvx4uqtt47JYpwVYk8FZDIW7NEYdvHAhwL8Q5TNKM9qJMjtpvwVoBCd4lFUMV1Y
         PFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739680; x=1790344480;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQrKgT91q1ivpfGUE5/zHrleZU+aU6ToiCAfQUtBMlw=;
        b=p4SykshkGJ1oOvR6KmrSebSA+u2FCwXfPdF1Co1HDSuRjkjquiMqcine+dbmnlwMry
         ZURZRBrYROl+v/xAo+tYbHHS7nIPO0IT+ep5LDTf4zC8H563Gaebn2wJK2Rl8pkp/wWY
         OAG0CeX5zqVd2JsnByd2D466zqlKgouS8mzHjueBkNGOUUPwOXjU9gbvGUrPBd6fqwVp
         6V8kFmFfla5l5/bH8wzqLOPFPW9Gx+0AvM/uOywmp0wrOy7yQxPQ6O64LpiHJigX9zx1
         Az91aTncqzYsdXNrI+csgSIgi/IV0apTEtdFlE+11YYeGAvaqcMyterIxoEMcUsoG2Yt
         X1Bw==
X-Forwarded-Encrypted: i=1; AKwUvBymy3DDV2E+O8P2J+ChBXxL7KBgonitBlpzeridlb3S8ZG6GunQfOeUlWE74jxf7tEGMHtFEVY=@vger.kernel.org
X-Gm-Message-State: AFuF++n9JK95ZvsGW1GU7kgpKB0wnrSGS6VDG+ewWinjU4PUA8zQcCI+
	mQ44xQc2i2KLZ0xW0AoFrh/0SsLqLJJkwZkmD5x7WeDRmB4ZRcwXdvivxA//q7TmcmY=
X-Gm-Gg: AYBFou0DkaDfGHRZDb0ig+5iuoNyAmdUjdtcqrQtXeu2mFzv4gRvoxRFCrenHUKJ0Mn
	nYkfefD3EwsYnqB35nXxanhnBw0hOXFN34QACz3d7ndl1IcujIKBuw3zRKh1Bt+Az9y3HrEeMjo
	egsVwv7Z6fa/fOdOiWfyjhHs8HIxdKH2etK5mn6+IW/32lTdLKFAvcD4oChRcOVfa2kjK6I1pdH
	hQJ1UgEgr9dr4sdZB7wKS8GEvgU5CIOYlalncsY2kQfI8nnCrmDt61JS6T0qPji87NRNBUDMs0w
	TREJO1B05UI2r9lAfEbaJP5HLRAHIoNQuALgV/VSIKW27sfoGFxPBtL81/JP5yP/vctwRZLYH9y
	E03jFbH+P7k1clNVmlGCE6Zj4qUdmXJSpUXLPUeUFYp0bfb4b3Q+z+P0pV2ATOISp1+1WZI7R0U
	CLpkWYRLTcWqrwMMI7bxVUnNjXhkb4lY9gLh++CbVYjK41tlHNDWKeg61tclsqBmSDnWrDwnnuM
	jCF+2u/2S2xNrGO47FnybLfDRMuRY5VGJ7tVehUe3tYi0zBWnv1xqc=
X-Received: by 2002:a05:620a:2806:b0:93b:d79f:d949 with SMTP id af79cd13be357-93bdca2c16bmr338384985a.62.1789739679965;
        Fri, 18 Sep 2026 06:54:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0ea6560sm145221785a.24.2026.09.18.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:54:39 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:54:37 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, 
	osalvador@suse.de, hannes@cmpxchg.org, raghavendra.kt@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: allow shared folios to be promoted to a fast
 tier
Message-ID: <aq1A90ltg9Qn6pWZ@gourry-fedora-PF4VCD3F>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-3-gourry@gourry.net>
 <41b46756-ed02-439c-ab72-e32a84fc7f17@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b46756-ed02-439c-ab72-e32a84fc7f17@kernel.org>

On Fri, Sep 18, 2026 at 02:53:40PM +0200, David Hildenbrand (Arm) wrote:
> On 9/11/26 02:18, Gregory Price wrote:
> > From: "Gregory Price (Meta)" <gourry@gourry.net>
> > 
> > NUMA balancing rejects shared copy-on-write folios and executable
> > file folios mapped by multiple processes to avoid placement bouncing.
> > These checks also block promotion from slow memory.
> 
> Right. How to we know the direction of promotion vs. demotion, though?
>

numa balancing never demotes.  It either:

1) moves between sockets (nodes w/ N_CPU) (NORMAL)
 or
2) moves from !top_tier to top_tier (TIERING)

Demotion is only enacted in reclaim / vmscan, and has no coupling with
numa balancing.

> > +	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio) &&
> > +	    !folio_use_access_time(folio))
> 
> 
> While I understand a "!node_is_toptier(node)" to say "this is a slow tier", I am
> clueless about the folio_use_access_time() check.
> 
> Confusing.
> 

agree, and agree with Zi's request to rename.  I can add that to the end
of the series as well if you like (avoid backport headaches).

~Gregory
