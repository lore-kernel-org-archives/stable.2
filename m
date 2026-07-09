Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4931ED83
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595095; cv=none; b=AIDKRWknjYIcNyo1HdReXfDr6pmZbcapYAX+V9a/i6/D5MTe9nRvEx7VQtwDXtBOkek/rDqbMI/5ay8F75BZ9K8CqmFdA86DA8gfg3924Fa/TIWDdVl5MyGiDmu28Hzr93k1uLJseqcw6uJrBeCaRl47+DqsHHQfeGLJj7vDRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595095; c=relaxed/simple;
	bh=JTDecRpwrYAS6GptqK6+EPctzrsq8DcXNhTT/K+21yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L70y7XPdz/IRjxtBKvIx4ZkYiBJYll061GijN/oqI87QREv+xeehZRz7h6CpO1o9DiZ9GiwB5UpbW4GVNiKEb+VSR7GZlDQYI6ryOBP03xRrdjF2SxpiduHD57xPDyYTlZ0zE5LD/YMjOZxQMD0v2Mkm0IXnh+93CMRrbbPbQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+uxAvFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+uxAvFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F021F000E9;
	Thu,  9 Jul 2026 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783595094;
	bh=5ylhwXeOPpfc7u6cPcoTXBBg2b7DLONZ3BXF8VdjG8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E+uxAvFaQu7j9nNdYj/hF4EUVZGbahCKCwNK3Zo157OIrKUDCyh4B+uS6ooy3hqXa
	 cZN7fbhbubKP16jsGA7qLTRIu3hUR/9XriOpCtTt/YnrvLMeRDW+cKaljfGd7+qape
	 H7OQcxDM+LVt3BxMPd2TufXtl+peb19mTqcZNdLg=
Date: Thu, 9 Jul 2026 13:04:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jiucheng.xu@amlogic.com
Cc: stable@vger.kernel.org, jianxin.pan@amlogic.com, tuan.zhang@amlogic.com,
	JY <JY.Ho@mediatek.com>, Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
Message-ID: <2026070937-unveiling-atlantic-b798@gregkh>
References: <20260709-origin-5-15-y-v1-1-5ac64636d2e8@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-origin-5-15-y-v1-1-5ac64636d2e8@amlogic.com>

On Thu, Jul 09, 2026 at 05:35:40PM +0800, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> commit edf7e9040fc52c922db947f9c6c36f07377c52ea upstream.
> 
> As JY reported in bugzilla [1],

What kernel(s) is this for?

thanks,

greg k-h
