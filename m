Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AC33263A
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617498; cv=none; b=mHZHnb4HsaJhp6UtGsOA7gArl7o04wYggIQyQ9BB6Nr33jpPbavhneIGlbuYQybNH0bx8nP2jO1UjRFWi096T1mCpHZFhe6+bkBYrbpZkKerLTgFGQ+L/k6TR8yHALegmul61MF/RWrOwcwFo6NAUHekDVHw4x2RJzPIknRagSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617498; c=relaxed/simple;
	bh=2FuiWMyjXh68tYMurmD9NRNYivd+DBtBW0Gd/vXz02s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqceBgkDL5n70XHp3ens9i8zFdAg9wCDHyVlkMYsdv+A1iGFkK8zTQKNSyhq3iR4SF3HSGkTZHba9lWtuP1soOsgtNI1QW3gnphlo4+TE4/2IgOdg0urJAVisYFYV5o0EqKp2+K39PZc/qK1FB39geDcNevQfHkC/jeV5eScvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=a3a5F13U; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="a3a5F13U"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ce9e56f68cso38290206d6.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781617496; x=1782222296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FuiWMyjXh68tYMurmD9NRNYivd+DBtBW0Gd/vXz02s=;
        b=a3a5F13U7QwjSojqxK6WJWsr4KMcn/68BL5eZED9kbZd8ouwwg8XXmV8kHQjnOkO2e
         1P1v+UqqXmwqJZ8mmp59WDtd3vgQ8+zEZqM8z/ST8jyv1FWh5a3XIfa9fEA9v95WB+QQ
         kgx4YRhm5ahRvbo0m3umIfLtC3WvYkLN+L1dMCDxqLtXNVqmjyZG9Ej2goFxVDGHHgov
         0L/rLIKobc+QB6TlUal3/sB9G2TnlKQNQ4JcT3d/Y68zviH8uSQpCgfum3oj1Bacp/71
         +jnxAJPKVsw2UZLQS8rIL77dY37VR0nkVrDPZDxf/ddEDgnnoePsAq2MMWc07WHXDf98
         ZWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617496; x=1782222296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FuiWMyjXh68tYMurmD9NRNYivd+DBtBW0Gd/vXz02s=;
        b=dqRO6Kxv4nvPlN1IzPpreFMKGEIzW+RlNUB0BB9VAL8V1D+YGAQMrcYsssSRDMby5N
         A28ZZy/Vkkk3yeoUWMQUjwMNVD83D5WzQU7EdJnPCBI1tmMbpAd04mS5mx4fvGV/nAT1
         gZw8kgI8oVYrA06TZXInnrFHRpmSiBeAldROelX1NqmInpW/SoKV6a4VUBgLn5+PCwkQ
         4w2YNyfgB2NerYzIsrCnHdRwl3tXoyFUYFqFRGD4XrgUGAmOA6ItY2rBXjj2yWLliodq
         RZmEBU+tGA0qM3C8ciM46YGKBFNLIbvhwtZglFqV4MVR63jAIsN21Kepv9ISxpxwRIWr
         hJWA==
X-Forwarded-Encrypted: i=1; AFNElJ9pNWvtoTIe0y5p7C+qOiNAvV3xfYLZAQjrtS3Mr5Pg/452kaRPkXrwigJy3QXKtdyCxA3GyaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywCimnFhl42Fex6WaiHmgUqjEknqcRCWEUeAS0jXn9B8n8Oxcc
	gnyMVF6Iv+vQECs4hWPTVasYphUi0zltJGU0cew7Y7k5ZBrDLRzo2RudO7Gxb0101f4=
X-Gm-Gg: Acq92OFvyQZuDrUQihHBey8LHmfHp/BmvWh+LzXFnvy0SfM1owkuIYkpqjBAQXCq3Qs
	ii5hwye5+ihX1cFZSMQT5Rjdu0y8IftQdhb8uJaX/lRlUxNdDmatM7StAealIGcwX2+gXEQ/uen
	dwGhOdafo/pXjC6ZKaxpDNIs9SI88KlLp25Gq76/r9NoDuOBKkd2Tg8O+QoEzVZOfgY6785f5RR
	lbWHO27au0dNo4KRld0xoo3iZD5KjVE2WJIYJlzRpHkGR1QFfopyFvXVJNfa/Da7n+XSqZr0G3V
	4EJY9RC+2GDxTc5unD81xiGC+F6GauuygthrXvAROIenJ0u86Qw5uoLHDqU1Vh3uMIeo7bdOtvC
	307+WduMYgrWDfjWbuwXp/6gEaUyE+CDPCPRGR2AjvGe8Y23zQJKV6bvGmzITtmuMpWFDpDs94o
	5JLSy6+5B8MUaGaYZATOY7
X-Received: by 2002:ad4:5d6f:0:b0:8cb:e63e:2a45 with SMTP id 6a1803df08f44-8da1f0168f7mr50299196d6.18.1781617496409;
        Tue, 16 Jun 2026 06:44:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:437e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f4ff2206sm32423616d6.37.2026.06.16.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:44:55 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:44:53 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Waiman Long <longman@redhat.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Farhad Alemi <falemi@asu.edu>, Yury Norov <ynorov@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
Message-ID: <ajFTVaMBeu-ViGIC@gourry-fedora-PF4VCD3F>
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
 <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
 <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
 <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
 <70f486ce-5ef6-4d72-8cc3-7086f4eea930@redhat.com>
 <c1495b1b-9dee-4cd5-ac8e-eeb7a2d968ed@redhat.com>
 <51eafe6c-6622-479b-b391-6d3ff9350e75@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51eafe6c-6622-479b-b391-6d3ff9350e75@kernel.org>

On Tue, Jun 16, 2026 at 08:59:07AM +0200, David Hildenbrand (Arm) wrote:
> On 6/16/26 05:43, Waiman Long wrote:
> > On 6/15/26 10:26 PM, Waiman Long wrote:
> >>
> >>
> >> The reason why I am suggesting to use cs->effective_mems to keep the old
> >> cgroup v1 behavior. If the consensus is to use the output of
> >> guarantee_online_mems() for mpol_rebind_mm(), I will not be against that but
> >> it will be a slight change in user-visible behavior.

I'm not grok'ing what is user-visible here.

The two values should effectively be equivalent because we're
using this value to constrain mpol's during a hotplug event.

If the values differed, you would be saying there's a race condition
that could affect correctness of the rebind (which can't happen,
because this whole thing is done under the hotplug lock btw).

Can you help me understand?

~Gregory
