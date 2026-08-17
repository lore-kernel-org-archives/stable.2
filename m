Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18DD41D111;
	Mon, 17 Aug 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983896; cv=none; b=FnZ3sbW4Spd19H2ZeSsuRg9Ss4HsMIBE7iVRgtLvi8XdS8/TWTXeN2D4RkTuT04F4hTrg9T9S87s6uvB244md8GbfHWR+xWvgp4c34DiJdhJ4a6xJQSZ7k8wYcPJNFAJ9zrpvq5RXaFTBxcStE1e7WGOuAD+tEdUDrlvmlm6UPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983896; c=relaxed/simple;
	bh=4cmHE4rc/iExtMHG6ducb6RazvtPIobkfRuroHL664c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eueuj6PXqCfug5PVME3xFdU8GBiFn3bmbrNz3rK4RuFJUwUeBX1k5Rcc+5StVthCCpWxavBp/WW9Kagaskj+hM9Fh5u7IB4zrZ7oLljTUnKsUgAG55hslhkIouiKnGyfBTqWen6VkGKOqQm64wrMz/XBrfkjh0FeuaSbxPvzf4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJVzTsn8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJVzTsn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5831F000E9;
	Mon, 17 Aug 2026 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786983895;
	bh=c5CU30hf+MXBRHB8OXc7DblMS9Myra57RuQWaqX120Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PJVzTsn8qnM3BwB9BgTg/LvNeYXnPQsvVcU4MYqNHmq5qkQ/tReJgUdUVK8iKBhp3
	 BB2ZgNzWfwWT2Ah3uFVhvN4MXQw12bRYLVnmEdxiwds4bVH/Hkgmn9bmAMWsEHepNs
	 7hZ6ZCHYhd9ZhXd4V3CYlTk0QpLlEtLYNfw+EEiIgOIXTRFy/wXgoYyjyazHF0dvfy
	 3sh8QjuJ9obb5Cx5Hrb2neGzGKSQeVrEQfedVClEs848shDPB3jOXRceOQMlkOTg+U
	 XIOq8EvqmpRZI5HQ4M6JrItRfJ9Hhp4LBw7rrZI26T/QBkueevkdYjHiEF56DBH/7R
	 H6J0ZFZMvFFvw==
Date: Mon, 17 Aug 2026 17:24:36 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <aoM1kq6fWvCFXobj@lucifer>
References: <20260815051924.194810-1-vernon2gm@gmail.com>
 <20260815051924.194810-2-vernon2gm@gmail.com>
 <aoMs79VDCnYvA9S7@lucifer>
 <cf1d271c-f002-427a-a843-00a1fbc59251@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1d271c-f002-427a-a843-00a1fbc59251@kernel.org>

On Mon, Aug 17, 2026 at 06:19:16PM +0200, David Hildenbrand (Arm) wrote:
>
> > I mean maybe better to just reduce this to something like:
> >
> > 	/* folio is NULL unless exited early. */
> > 	trace_mm_khugepaged_scan_file(mm,
> > 			(!folio || xa_is_value(folio)) ? -1 : folio_pfn(folio),
> > 			file, present, swap, result);
> >
> > As the least invasive way of fixing the trace + limiting the contageon?
>
> I raised that using a folio after dropping relevant refs+locks is in general an
> anti-pattern (IOW wrong if folios can just get split afterwards and are suddenly
> no longer folios).
>
> I'd like us to avoid that where possible (and suspect Willy will thank us later ;) )
>
> Isn't there some minimal way to just calculate the pfn once we obtain a folio? I
> was assuming that there should be an easier way to do that.

See my reply-to-self. My initial reply was wrong because parisc + mips do
actually do classic sparsemem (sigh).

I suggest what you're saying here basically.

(Moving folio_put()'s for the break cases out of the loop is nasty)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
