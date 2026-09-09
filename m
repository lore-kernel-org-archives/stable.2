Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385F4A68B9;
	Wed,  9 Sep 2026 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994217; cv=none; b=ipvWlE4bxRblRzOT91d4tbHjHWBVDcDIPrR3RrevQu2DBU53Ud5hKODVMdsvsByoPKAkHun4p1R44+t/LJExVusRQwGDZ0QWlWuRU2oCJliN1+MUD1Jfy6LrtW2XZwVzSqAZm2RN0DLLLMiFt8WD/Dd9dIua406SToKMqHcPklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994217; c=relaxed/simple;
	bh=wPjl+daJP4hWYK4D6HuAOKj5/XvCcVuuv0+4D9GzJ4Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cBqbAMqnVrI4qePw2SYRRYyDqRiJHJZsC0BfDaoaUwWgMH3X2ntU2AELgg/7RuQrb1uHHdL2FSYXhUPMccFN5sjI93sKdv6FJ6zSE48IwrKBG3f8To8WWcM46DToHt4rC5YR1C6Od3Rq9vLggDL6m5/yON5E9P9gCmC7PD1g+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U+PeqIpW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U+PeqIpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B7B1F000FF;
	Wed,  9 Sep 2026 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788994205;
	bh=uakFVAIIg+dbHdGGvnXSLW6H1vVCapIuu4+L13nJJjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U+PeqIpWC5DBh7q130lXHtII8ntvQj6lTQyojE9Aa4ICHDsKDcddEAQ9+1CLiYlQc
	 x7+ZxQ1yV/yDo+LuIT+OC5chsw2pvOUEhzMvkqoEDtuzInX/VCiD9d2qRnqjPiAo10
	 TfAJHc5TmbunSfpK8c7oUec5KvYaPajoE1nEE1Sw=
Date: Wed, 9 Sep 2026 15:50:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: ackerleytng@google.com
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
 Wupeng Ma <mawupeng1@huawei.com>, Yanteng Si <si.yanteng@linux.dev>,
 fvdl@google.com, jthoughton@google.com, rientjes@google.com,
 vannapurve@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Fix HugeTLB subpool used_hpages tracking
Message-Id: <20260909155003.e6c2f4fe3c0bbee3b34578fd@linux-foundation.org>
In-Reply-To: <20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com>
References: <20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Sep 2026 14:49:25 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

> HugeTLB subpools currently only track used_hpages when the user configures
> a size limit.
> 
> This is buggy since when there are existing allocations from the subpool
> that would have satisfied the minimum reservations,
> hugepage_subpool_put_pages() will still restore a reservation to the
> subpool. See below for an example of a false reservation.

That sounds annoying, although isn't clear how this affects end-users.

> In addition, the subpool is considered free prematurely, is freed, and this
> ends up causing a use-after-free.

That sounds alarming.

Do you think it's best for us to submit [1-3] for -stable backporting?

Is it feasible to come up with a set of small little fixes to get
-stable out of trouble and then to prepare broader updates for our
ongoing mainline development?

If it's "shut up Andrew you're always saying that" then OK, I can take
that :)



