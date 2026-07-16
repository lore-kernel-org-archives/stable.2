Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84522D7A9;
	Thu, 16 Jul 2026 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784178569; cv=none; b=I6sLKphVCdFxF1vGLmNHtdnBlMHUdPXMe1VS7eGujULn3gvIFo6ENsdiz7w2rlONV0oMZPu95Q3EJhnoDHwICNvY5OgMMjX6gCAReadcQgowVeNjMIqiDmql+KZFYOCE9R+zWKaJRmGCQAmdX6vYaV4XjM/OUiNFKmuAj6YVHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784178569; c=relaxed/simple;
	bh=UVi9/qnRBsei43fVrNeV7JjR6ud4/oBKKuOuEjwo2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2erP4Cu4h+Xxm4VU0AwIejHfB7O6TVRnekgQ9Yy7ih6Q58iSTMC8ca22hoIAgtCQ7UzYEX2nWDoSzSZlF/IX/J8J8H9+UzqSWn7dLU6Dpvrv4smLB3ySov8t30JzSuEt0zhaH1yqRX2qcib1iuA8JXFRPscLVlJ7GULi06Id/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HdGKqCtB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HdGKqCtB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CF61F000E9;
	Thu, 16 Jul 2026 05:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784178565;
	bh=oSyIYEAqvn2M+Qvv72YuCT/ZO9DuTMNqxqflcszvWKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HdGKqCtBQAEm40XRW0vHqTKZ+R+IAVLWdpjjBsNakcN0XkNaCPVdD+0T/6o4fuJkw
	 x9M5+EHriZn5daXB2wx3Ax8/71mQkdWS929g+bswVb9rKmIQvUKkYo4K8zqnHxBobj
	 Is40770+ctz9Sd+DwQqkIEq7m5fxMmn4OhsWLiAQ=
Date: Thu, 16 Jul 2026 07:09:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: oxsignal <awo@kakao.com>
Cc: stable@vger.kernel.org, mattbobrowski@google.com, daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: Re: [STABLE REQUEST] bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation
 if BPF LSM is uninitialized
Message-ID: <2026071659-patchwork-handclap-6162@gregkh>
References: <20260716024535.1ogY5_ZgTdmwA4CzyWx1Hw@awo.kakao.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716024535.1ogY5_ZgTdmwA4CzyWx1Hw@awo.kakao.com>

On Thu, Jul 16, 2026 at 02:45:35AM +0900, oxsignal wrote:
> Hi,
> 
> I am the original reporter of this bug. Please backport upstream commit
> 
> a6f0643e4f63cfaa0d5d4a69de4f132eac4b8fe4
> ("bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is
> uninitialized")
> 
> to all affected supported stable trees (5.10.y and newer).

It does not apply to 6.18.y or older, please provide a working backport
if you wish to see it in those trees.

thanks,

greg k-hj
