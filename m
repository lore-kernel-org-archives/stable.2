Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BBE443C01
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155952; cv=none; b=TXAkpa8NF/PwdVnVrs5P1HaMo2UHkFDHvwHFIVceWg9zIZ2S0ZjJmJ+fc8hJjwHe72+14UvAkD1ZmTZYasJAFnQYIQfe+eF6vyWigFoPoKdkmgIFBW5M97Iac8UgrVU5PMqqhi+hV1vlauoWr91mrXE9y7yw+kDu2PcSce5XTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155952; c=relaxed/simple;
	bh=mLsDrnBov7GJKjAMhMPtP3Raa+ILVtEoSsML2Qr0iwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ50ddYliZ3pTBdPaKVXnOv/swY2OPDnCUXlIlT9Ab/qw0/83iLc1yDoAe7sNtcU6m/ULkmtUX0bauXvILsyZ6NR/CdqleQCtsP3xByvs/DjlHwnZ/oPp7d8Qe++Fz7hta74TKCoxPbcknMI5d+c/CESWu8Hy3FXKsqT7BE34n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K86yTmvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K86yTmvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F9D1F00893;
	Wed, 23 Sep 2026 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790155951;
	bh=Idcu2s9vIAMTCtxMWlJwg9fNiWEVvBggt2XbsxTN/JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K86yTmvlsPTpcjqDYcGBYLeA2+V5DQw1p9gUQBeh1SkYhBpdE+spvQ94FugArQz8S
	 t0Iyq1eaKwLucTsxtNzkOp7JjS+uQgZtxZP9Kw6YFBnZiA9/WKI2cZzKMOMv2j2ASh
	 o/NNDhgsErEUXAnW+38JD0L87bXSPJI1254GuE9Y=
Date: Wed, 23 Sep 2026 11:30:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wenwu Hou <hwenwur@gmail.com>
Cc: sashal@kernel.org, stable@vger.kernel.org, xiang@kernel.org,
	chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
	dhavale@google.com, lihongbo22@huawei.com, guochunhai@vivo.com,
	yinxin.x@bytedance.com, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH stable] erofs: fix large folio race in
 erofs_fscache_req_complete
Message-ID: <2026092320-process-federal-6533@gregkh>
References: <20260923084823.496741-1-hwenwur@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923084823.496741-1-hwenwur@gmail.com>

On Wed, Sep 23, 2026 at 04:48:23PM +0800, Wenwu Hou wrote:
> This patch is for stable only. Commit c37460cd9b2fc ("erofs: remove fscache
> backend entirely") upstream removed this code.

We need an ack/review from the maintainers of this code.  And if it's
removed in newer kernels, why not do the same thing here too?

thanks,

greg k-h
