Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C8346E56;
	Thu, 25 Jun 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782421647; cv=none; b=a+CvBnPEydCF4Aiywy/BFCjg670YesVfIpxMSxUinf7oE0W8D77gYea/7veFck0ZffTlHrTc+nmNy+AuHfpCsIrMQ2iz3JQBbdK75Kbq3WinGSiFHSdW1IZ/nr0JzriT78HzHE52tIWU91REG+k/UK+kIWimwr4EQnn/K0SYLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782421647; c=relaxed/simple;
	bh=iW8j/hMTRdm3ei62TqTZ/oEHaBEmMC1qvSEVov4fR1I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DBBwO0qOi1p3+gR7RZ/1rILj7qGUXtz1n7hiyLU7JfqFYm084gbOq4QnpqwymOmrI4qrEbrNjFp+ZpUYfRJkqdaFsOQCmJIJGwPZKj69jEBirnAq3SQOh+af+fdx9q3EvDDZVT2DitTWNMU9/KcY44tPpHWboNniiVSkkoyVYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tNo9mlwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tNo9mlwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89AD1F000E9;
	Thu, 25 Jun 2026 21:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782421646;
	bh=XCf31iXVjV/xmKk4RzROAt3XMkVH30g6uJirV06m81Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=tNo9mlwvZrMW09CQHCsb1IqYR+uR1kIeFNoUrsmo9Zt2VKQXPUkk/Hn9oMr3EkDi9
	 kB1its+rg+gu3WKtHfTJjhW8G0dmcMuqT4p8sqcVYm+UrUDoQIhKjUrtyIFoVf6+1/
	 o4x58Mc4ANn9xd6n5H31c7cqP4+ToM4YN+XhTnqg=
Date: Thu, 25 Jun 2026 14:07:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: richard.weiyang@gmail.com, david@kernel.org, balbirs@nvidia.com,
 ljs@kernel.org, riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, ziy@nvidia.com, sj@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-Id: <20260625140725.15fdfe5a48b6d7f0d667c948@linux-foundation.org>
In-Reply-To: <20260625114235.40611-1-lance.yang@linux.dev>
References: <20260624085756.6598-1-lance.yang@linux.dev>
	<20260625114235.40611-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 19:42:35 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> >Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
> >
> >as well?
> 
> No need to resend. I think Andrew can add this when applying :)

I managed.

Thanks, I'll queue this as a hotfix.  Somewhat tentatively - it's
unclear whether we'll be seeing a v2?

