Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209D3D9DB3
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516327; cv=none; b=px70Y+mxE1BYW4eBFT5t9hhOsIfoCFkAwXKUCkb/CCRbXGknbVyDmsw6VwS/JChJ+Dx1O9MtKjbOSJvl+QMlZk6WQZi4wqJkEkvOIKFtnlCYA7DQvmLxeo+fxsXPXPXlDAY6KizUj3PE4slTi40eaDv0Rc/SkJmyTPM5UU0gUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516327; c=relaxed/simple;
	bh=5W9S4pgDg4/wNgsNm7pUUV0vbqnLkdd/LqkUgfe2UH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjaAayvBtKN7GA1Zur8jZxpLpWthPM8GwaYXm9AJKlQ4+1hOu9Xjm0p5oBr+Pw8ZwVZ6H2PprR42s2DTFU434Rt8F01+LsAGKLuGCg5FZI+eceYfwZxJScFNAhUhporcHYQawt2BIFIcl9vhx+fV0rxPdOt7yeKYA+86b1iIZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cMw1C28+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cMw1C28+"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccedaf0b54so22018626d6.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781516323; x=1782121123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oamN5hjWi+TCb5PPsVj9eSoiuDSUof3U7OYNH2/rvIc=;
        b=cMw1C28+9tJYOQ7hVT3DvNUY4YjCbCe2Ok9i4q/E05Sur6rmTz9O2dcb3COWbmXt/i
         a0vynKs0BbsB90oTaKZ8uvD1N8mde9+hkviXYyugr7IApL7yiNOadkidIRZoZ2Cm39uB
         5JLaETSbJ+soFLeS1g9CNT6yAX4/6tbO/oskVDeWFOC6J6KEux9/yF3aNbSaXwF86rkh
         r8Xt49c87Hl1BEuRmhVsYwEs+kyN7FG3lnGUzTqqW73HeMKb9h5E91yzGvCw+OhwiCeo
         1eo9t3zZC0Fd7dPA0Q8ARRYLPxbNitfRNOcr3ao143B8K2T+mqJpeGr5cOoH0w2Wc13s
         w/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516323; x=1782121123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oamN5hjWi+TCb5PPsVj9eSoiuDSUof3U7OYNH2/rvIc=;
        b=gYQHVtMaJyZ2BsOdKdocLO2XenRwHoOQXeeIiAj5r3vASYQHJs3AOUUiVkw8xluqEL
         SD9TNdbj0HvfKzDhwZkime4Pj/WnIJf2zyMllXlN5P0xX1mdHAw/cHsEltYpu+rySF5w
         G0MO4lXKckUPp245ohStMhdXG/vi7NVcD9w+vZ1/oEHZaHDzOnRK+/h3wYvM7l2hgcbr
         /9xnpblXzYWAFrCirgqcrygDugfcAT8Nl7XMnU1zBQc41Ci0rWtfMlxJDkaHvXQAYBGr
         w7Hakg3qTOJq21tFPPxvxV0qaDZkopYhcvl5/1DRCdhSv34jnaddjTJsea50GaDZrDMn
         lAEA==
X-Forwarded-Encrypted: i=1; AFNElJ8DcqOl8fkuxO8ksha2BB6F6jGA4NvI9psu95qNEWv/h2SJYd6BT35DiW8TQirp8IPxvkjG/28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6G2SWX2cvyLZJvvFd91NPwgFTOGx+RX01whNOGMLDlxn7z8IA
	pMOyu/E6LbMNM/qrX2mxjmYPW6PESFnBx7n5Z6b4OiJaLr2gUh4wzxYjJPWX3qQGDBc=
X-Gm-Gg: Acq92OEFy8DYqW20CPhvnwhaNn5Z6OR3tfyB7bIqPJ7E6MLoIdfl96X+TYqwWF2T3MF
	T4NT7fNc7r8+BxxG55zPIfImdV3c+SiJvYhqKhJQEgexzoWCEit61cHPmvFM70IG6FjiAqO4rlJ
	DZdboSoutVEnLsB/Mrfujni5iTRmp2i7BwjQPgMHSS3W0iAfnOBjSOcQGEyY1vsozVP6p4IyPFb
	KgfByDMD8aNLyfua1wBhICK+YhOh8ARhJbbrEZ8xAlWsmGmiMPVi8qsNyldR6tPJh9UZLHcdqOw
	17C0BeUaRlejnPK+1IY944SP/OZGnltR2C/pm+Nc1TmISXzagHXBiDCU8UeYYT9qL9dtYdyKz1d
	Wzj0kOmvll9zvqFSh3Pif2S0sFqVR8j4iaQUsEvxCeOjo9MkHYuJxSQ84wlhrBH4HIIMZWEY1Gz
	NhtQzydrKiI/Tswu4hGqYWVzYSbliyrpC3Z/SvsLZd3UpVkB8IUEaoc5QK+tlh3kHRxuvAhP65Z
	ZYwqnaz/k/U2O8=
X-Received: by 2002:a05:6214:5907:b0:8cb:e63e:2a45 with SMTP id 6a1803df08f44-8d32c4eb32emr217014056d6.18.1781516323361;
        Mon, 15 Jun 2026 02:38:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (158-94-182-130.mclarenap.oninferno.net. [158.94.182.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301c237e8sm108166456d6.17.2026.06.15.02.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:38:42 -0700 (PDT)
Date: Mon, 15 Jun 2026 05:38:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Farhad Alemi <falemi@asu.edu>,
	Yury Norov <ynorov@nvidia.com>,
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
Message-ID: <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
 <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
 <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>

On Mon, Jun 15, 2026 at 10:08:51AM +0200, David Hildenbrand (Arm) wrote:
> On 6/14/26 15:25, Farhad Alemi wrote:
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -2649,7 +2649,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
> > 
> >  		migrate = is_memory_migrate(cs);
> > 
> > -		mpol_rebind_mm(mm, &cs->mems_allowed);
> > +		mpol_rebind_mm(mm, &cs->effective_mems);
> 
> God this is confusing.
>

All interactions between mempolicy and cpuset are horrible and
confusing.  Much like Lorenzo's anon_vma work, I have to keep
notes on how this whole thing doesn't just spew SIGBUS constantly.

The short answer is: mempolicy is advisory and cpuset is strictly
followed - in a dispute cpuset wins... except for file backed memory,
then everyon loses and nothing is consistent.

> Naturally I wonder: Why are we not using "task->mems_allowed" (maybe cs vs. tsk
> was the original bug?), which is effectively just newmems?
>

Short answer: task->mems_allowed is protected by the task lock and we
don't hold the task lock for a foreign task (not-current) over mm
operations.

Long answer: Reasons and "Stop looking at the spaghetti, it's going to
break"

~Gregory
