Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6B39C637;
	Sat, 26 Sep 2026 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456021; cv=none; b=WX6vGpjE5+fEXyT7rZtRxtZ6ksN89AgmElP3uELcKmR2Li08MgPXBNXa1s+mVj5f4K0H4lPplt9cgIsVnNWSGuwGWXwi5sAhix7gPlqNxfzeTM9wqeL038cu8DGe2MQk1Wc8KuXKhtR4hsyzR5OqY7GTHsqNOSuhlXj1vhM0Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456021; c=relaxed/simple;
	bh=Cn2HKOQh5ZanOqocDe6jFMaqvf7FRcohDV4j8jcPSj0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TxEclr4+eX78afwgP/nB7S4ckrKC6831sQ0SsB6IdOaLYuicjZbDunJyntRQ9yuZ/YmvIANRGE5FUm/jN+O9h8kn5fRGXLYAazF0LTw/a/1MvZd0oA/xrOEO41XV7/d2WDTf9wGT3kpP3wVypPbZ2geTgqsnJ2PQQgXxWuOfEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2b7/uQsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2b7/uQsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7491F000FF;
	Sat, 26 Sep 2026 20:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790456019;
	bh=jOHXpoVJktgoXiNd2lBMhvoj+QPbhugd1lhqrechpaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=2b7/uQsBtfmamje2ZnA3Wz7qnXy4GegG7TJLMryITbr2jniyr3apS0NNjFW75J07q
	 GStWjGo6dTHbYXha6YZoTAFFT5buZ6kv/jh4gPom/y4LHo5MKWaWVMgpYFAMpMs1T9
	 kAzbzmtBhJTzTDz6bB5oXPPS9NOH/3VAoMSzPI1s=
Date: Sat, 26 Sep 2026 13:53:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Brian Geffon <bgeffon@google.com>, Minchan Kim
 <minchan@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
Message-Id: <20260926135338.7d7ea1d29a89351c964e5897@linux-foundation.org>
In-Reply-To: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 15:13:09 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
> operations that keep the original VMA in place.
> 
> Historically this has led to a lot of bugs where non-obvious interactions
> occur between existing mremap() operations and the original VMA.
> 
> ...
> 
> Both issues can be fixed by treating the source range as distinct from the
> destination range, which is the definition of what MREMAP_DONTUNMAP does so
> is appropriate.

Can we please have some review of these two cc:stable hotfixes?

Thanks.
