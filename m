Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2627B340;
	Fri, 18 Sep 2026 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703617; cv=none; b=KDo/Lzoqm2cTqzTya7Ii+KTCUS66TyF6uAKEH71jp0igZbbPZW5IJ6unPNbARzR17qhw2DffxYC21SyVfm7gHx90Zdzia5RE2ajl2oV9eXBO4ZGBAoqJ1hd5gF2ZPJiNje7iOjTj3Y9+eJoIFMZ7OHFqXfn+kuoxPd/0mBeAFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703617; c=relaxed/simple;
	bh=MbQDpK3U340+Kg33aXXDXgthI8PtnTnfsxxy+PLvzEs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cqO0lep3O3sxyGDjfwFhEXIuE7Iw2u3j2xXYVHmbi8Tcd8e5HsXZateCvhwdgmdum1BHn8NnSuezU04oCfKdRM0uILg+p+dUO8eQEnXwaFaalBWtIyO2eWn+L6T9COQPofx6DSnn9kitwqR6vnH0dLuoHMjj9COCLrT2+SK2PQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=faMWUe+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="faMWUe+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D4C1F000FF;
	Fri, 18 Sep 2026 03:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789703616;
	bh=NyjeJYQAoIT6JPqi52GByedAXFRsvGfuaaVIMzoH39U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=faMWUe+E92wqRxtkbgaWMXRYwf6KR2EqEIoqeW2C5x8Tk7PKPPibffuWfOOMaOnRJ
	 mpr69blAKOn6oTolFU0h1fttVhImQOrJ+9OHLp6NW6w63EYu7M7joHbQ+8dYkv9PAo
	 J6YjQQJYozXesL/9g+YQJEr51aieL7Rd2UoPU2X8=
Date: Thu, 17 Sep 2026 20:53:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>,
 Alex Shi <alexs@kernel.org>, David Hildenbrand <david@kernel.org>,
 Dongliang Mu <dzm91@hust.edu.cn>, Hongxiang Lou <louhongxiang@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, "Liam R. Howlett"
 <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin
 <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, Nhat Pham
 <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu
 <peterx@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Shuah
 Khan <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>,
 Usama Arif <usama.arif@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Wupeng Ma <mawupeng1@huawei.com>, Yanteng Si <si.yanteng@linux.dev>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, fvdl@google.com,
 jthoughton@google.com, rientjes@google.com, vannapurve@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Fix HugeTLB subpool used_hpages tracking
Message-Id: <20260917205334.9ac84d529c686983ef420567@linux-foundation.org>
In-Reply-To: <CAEvNRgExZM4ixMfrF_FMw2CTn6JqRX8s=cy0_-x5ypLxvQQuMQ@mail.gmail.com>
References: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
	<20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org>
	<CAEvNRgExZM4ixMfrF_FMw2CTn6JqRX8s=cy0_-x5ypLxvQQuMQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 20:05:33 -0700 Ackerley Tng <ackerleytng@google.com> wrote:

> > Ho hum, complicated.  Let's at least slap a Fixes: on [4/4].  My
> > trillion-dollar sidekick suggests a9e443086489 ("hugetlb: disable
> > region_add file_region coalescing").
> >
> 
> Your trillion-dollar sidekick got the right patch but the wrong hash :)
> 
> Fixes: 0db9d74ed884 ("hugetlb: disable region_add file_region coalescing")

Well, I only feed it $100/mo.

> I'll also reply to the last patch with the above. If there are no
> further revisions required, could you please add the above tag in for
> me?

Shall try to remember to to that.  Whack me if you see the
"added-to-mm" email and I forgot.

> > Our other little friend is talking to us:
> > 	https://sashiko.dev/#/patchset/20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com
> >
> > I'd like to queue this up promptly because it fixes things.  But let's
> > seek additional review input and argue with Sashiko before taking that
> > step.
> 
> I'll copy Sashiko's comments onto this patch series in replies. :)

Great, thanks.
