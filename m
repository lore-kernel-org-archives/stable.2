Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2022A4E1;
	Thu, 17 Sep 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614791; cv=none; b=qPjjxj917IAmkoj9rQH8HHLxiMHEc04vX8Uum9I4ajsydJaH6OIfCG066RvGcbAVLo9+8CFQxjSwO+8QquQr1Aa4TaHAwbMNexkT9de4KpAOWeg6KbRoqul9S36JmyqYEYd+fH4ABNKX4QW/h22zRw9Cq8SY436j8d+jAn5WQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614791; c=relaxed/simple;
	bh=FeKcoJ3loGn8FJEmciBgvprU0VZac3yRZ7pwrvMBqgQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uMeT7O7ugOrLiE6L7x5THDYmBYcJi3vYa1ZTxlSusNb2MLBf9CWzgihsLif9yeEQeHp5l9RkcFMBsD5BVBHfJyg/mskAOpxxwEBznvJjmjZDhnjZOvOge9DBLz1gWjS27QOL6acPAZ5mixMv2FksYn7gT7jcxBz8M2TT93Ay2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hBiJNpgS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hBiJNpgS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585591F000FF;
	Thu, 17 Sep 2026 03:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789614789;
	bh=4+BlsAYVIvUfCkO04DyxIYq5YEbiYoDvPQdBOWVcg8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hBiJNpgSIbLu448u25HbOQo5bMiPEncJqYfjeZJAyyhF3R2RWKukQ0My/1W9qgG3R
	 q3ZcrXWQhRwuXALKX0cvM2ivn55BXK0d66EDShx8vS4aXs2nPxIzsrdzkPWUeXzqDh
	 N54rEOf2/SDOY4l38oMMQhB+BQjSTR5m7Mz1loYY=
Date: Wed, 16 Sep 2026 20:13:07 -0700
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
 Wupeng Ma <mawupeng1@huawei.com>, Yanteng Si <si.yanteng@linux.dev>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, fvdl@google.com,
 jthoughton@google.com, rientjes@google.com, vannapurve@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Fix HugeTLB subpool used_hpages tracking
Message-Id: <20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org>
In-Reply-To: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
References: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:39:00 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

> HugeTLB subpools currently only track used pages (used_hpages) when a
> maximum size limit (max_hpages) is configured on the mount.
> 
> ...
> 
> This series addresses three problem areas resulting from untracked usage
> and asymmetric error handling:

These are rather serious-sounding problems.

I'm seeing Fixes: for 10-year-old patches, for one last year and one
this year.  The fourth patch doesn't identify what to fix.

So if downstream people (-stable maintainers, others) follow our
recommendations, some kernels will get two of these patches, other
kernel versions will get three and some lucky kernels might get all
four.  Are you confident that the patches can be split apart in this
fashion and still produce a good result?  After all, we're sending
downstream some patch combinations which we didn't test.

Also, can you speculate about why these things took so long to
discover?

Ho hum, complicated.  Let's at least slap a Fixes: on [4/4].  My
trillion-dollar sidekick suggests a9e443086489 ("hugetlb: disable
region_add file_region coalescing").

Our other little friend is talking to us:
	https://sashiko.dev/#/patchset/20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com

I'd like to queue this up promptly because it fixes things.  But let's
seek additional review input and argue with Sashiko before taking that
step.

