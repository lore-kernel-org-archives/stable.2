Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3E4A0F0C
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264252; cv=none; b=LCidg1Ff5o1OmZmhhqw2XLLR/BqPg8kbTuqOmExlLkPW9TpWK+mf8h5wuTlTBwlxW3C9bk4TB11+rKXkuYheNnyE1QyYDK/o2tGn1dVHShfQIB7+gg7yk3/QpfnlmVmotLfuhphWKGGZcYa5kO97itfYWKc5Ep8UAiCGjiSqux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264252; c=relaxed/simple;
	bh=ilTbEA4nqL0Pb5hvq4SxgWQ+Afmf5ZrPd409M0+tb1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXQMgZL0wy60oOBIywq7QkkiBLiaSi7GN4Q2Z6ERtuKUCDPhtjxih64SQ094mQRf+c90PMqWE0MxCvisQGdquBYTtbSZv/Eup7E6O5AAePrR+z0sDmLg8oas0XRTv7l5hUxuL8AP9OoC6SRFmuYDsC51zQSGReJTB7QduIYlsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=si0dVDe+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="si0dVDe+"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93be6d3f424so77472285a.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790264250; x=1790869050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=36sy3YZJoi15KsekhCcXhYJyq8gSbQAoHXpfkXanlH8=;
        b=si0dVDe+6BJhARSTer7TPdJrRFPywAO1dcNsCuvmc/3f1ptzz19E86zhkI7VbXlUAE
         sbgsIZ1EZ61uECB0g8KaUH2FXLs0zCubsh5H5g6irNo2D3CtJEoWn433/wCgGqfmps8D
         r4cY/l3wHLC63HO7Dlyn7RrVd6zngZlzk77ehUi+Kj32hO1TfPwF1c5QFg9vpH8UUSrD
         75UtNVAnSGAqYlmrdxvw1u+83FCfcA16HOCYGqeFiHdZS/e+kNlNkNRScuPBn9zPYmra
         xutqf3b3omj6JAskiXVCfYfOUVj9n9Yz9Y2SlKulTcrUjRSd2+b7y5nhWtOeykzQuAnh
         c9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264250; x=1790869050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36sy3YZJoi15KsekhCcXhYJyq8gSbQAoHXpfkXanlH8=;
        b=kDSW0uQ9UdY0DqR3GR0dPe4GM7hWf5lhxWbRprIDKS5KrQ8Va6hZyqrkC0HtAITAui
         /Aoh9zb0JAGZdNQ9wm6HLdsfXm0NgXTP46QHxgZ0JILvE7vRYNSvBx1qIrDDxjiwc0/2
         Bt0r2kLvFmw/OR2AZT2EVuYPPMkbxRcbEPCcldqlJDsIhx0aeoYhcCPRPh+seZ1PIC48
         M7de6b6k4To5XyjkDSfzuUPTo4Ox3HZ7ueuxlx1nRSnebF1pNiFgLmP0hxaYxLQ526dt
         V9yGmrOCn2Iv/7hkOByw2ql0poW/GPCD8xT9l+HLICczU3IqILGRfpjGTPg5iCSxl5dc
         Hv5g==
X-Forwarded-Encrypted: i=1; AKwUvBx6hDb8pWnhkj/wLw+t0uMIz11Ld1BhvJU4XJn53GZZ0WkXN5avPLV2MnjFviGdN18a7z0O200=@vger.kernel.org
X-Gm-Message-State: AFuF++kQsVyUpDVpc8gw0EOP4gxF5wajWcVg9lfdJke1TID/M0TlfILk
	eoRD8JuDNkesrN+uKbZ6tjFaf7+XQs9za0uKomcTPE+Yr0qt+hMSKb9f9PLKvFYLvlM=
X-Gm-Gg: AYBFou3mJqB7OZnbs96PGUHFUtWUx3ULcHcoNsEevhrzbiiXnC1cE/tfiEqNONYkRo3
	+S11WxcicnDN1UkbN2ohxOpPN/+8zTp7p6eJl8kBc8+D5q11khctaWTRlb7aJeidBfA6hrIWkAn
	Uwrq5GFpbwAhqHhoyPROfEnouahdgxoBM9fE4vW1WEbUPbY2I4+7Se4VqUkSkA6OvVY/3lTnGPs
	2OllYBShbZH+4KYII0RTA3HIeeiodujMr3k0K0EjFxnFsglP58/28Mm+BFk/FXFRBVp8Cm/vgvS
	wcZhsfLxtpRqjFCGhfBwN3PjUgv7FzXGqsR0DW4C13Lzx0DMfgZ4dWDGNx8A1UYEqHcf0UjI0nU
	/Bnge3bDMqS9lnv/jkdl5GdAH7nN+Td3StsDWXhjOXGuq0kbDcdilApXioJ5ldQ2R4tnC2lIKyB
	obHI+Mu61cqRkcTabcbYN+0SonyCWaKsCiM9OT1xZk5/dCzh1Ug2MIyiTh/cy8D1UmhWux8nfLB
	0ctLKiFl2TZ6lTfWlCoY2R11qKWyCqXISpeOL/rROK5gK7L6EAY+pg=
X-Received: by 2002:a05:620a:461e:b0:939:319f:d6e3 with SMTP id af79cd13be357-93c3661afe0mr289242585a.5.1790264249896;
        Thu, 24 Sep 2026 08:37:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c29e070dbsm392841285a.14.2026.09.24.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:37:29 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:37:26 -0400
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
	hannes@cmpxchg.org, shy828301@gmail.com, raghavendra.kt@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/7] mm: allow shared folios to be promoted to a fast
 tier
Message-ID: <arVDeAId7Hb-2RvD@gourry-fedora-PF4VCD3F>
References: <20260922182928.2199090-1-gourry@gourry.net>
 <20260922182928.2199090-3-gourry@gourry.net>
 <f0cd5c54-deca-42e7-bc85-1838dfa917f3@kernel.org>
 <arUtcPIw_FaUSPv4@gourry-fedora-PF4VCD3F>
 <e7f48cc6-be21-4ab1-91a0-df0e3a6ec0b5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f48cc6-be21-4ab1-91a0-df0e3a6ec0b5@kernel.org>

On Thu, Sep 24, 2026 at 05:32:22PM +0200, David Hildenbrand (Arm) wrote:
> On 9/24/26 16:07, Gregory Price wrote:
> > On Thu, Sep 24, 2026 at 01:59:15PM +0200, David Hildenbrand (Arm) wrote:
> >> I wonder if a better name would just make the comment above (about memory
> >> tiering) implicit and make more sense of the sysctl_numa_balancing_mode &
> >> NUMA_BALANCING_MEMORY_TIERING) check.
> >>
> >> 	folio_promotable()
> >>
> >> 	folio_is_promotable()
> >>
> >> 	folio_numa_promotable()
> >>
> >> etc.
> >>
> >> because that seems to be what we really test with both things combined.
> >>
> > 
> > maybe:  folio_numab_promotable() ?
> 
> Works for me if "numab" means numa balancing :)
>

Sounds good, i'll let this rest for a bit before spinning a v4. I think
the rest is pretty solid, but there's one other sashiko thing i need to
think about whether it's real or not.

~Gregory
