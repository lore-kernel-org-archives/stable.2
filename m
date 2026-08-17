Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57242F71D;
	Mon, 17 Aug 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972816; cv=none; b=haRwBwPEvG0FsZakmq4iFE3K9UPRzYmH1kBGEkPUMmIj1I6dPZuSxcZJwBhZNJMorZKyIkNhhDTXXcYVS1rSDvnLZMhD/6prHg5njjl4pClvTmgSnb/fPB4Eau3i8RXxnCmiZY6/Vf8A11UiDKgkUzuLjXRUvz3UwwRw9OERpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972816; c=relaxed/simple;
	bh=5J0aElatsTMATU02pM3r1lSNjPw1O/AVchL4Gs2ZVM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoPZ4UuzZ8v2Cdcqmei6M5JOPo39atN2mjlcmdn/GYorZZaKvvVN37iXmWLdcAX5IkoJdB6qcuzT38EtsEf4AEhFRnZ1b+fMA/BvfN+X5lg6HWZW3XYbUt2EJmVYxPusVhjH8BWvGFNXdcEd8WYtUvMcMKwRdF/5tU4CfMTC2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kuCQ1JZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kuCQ1JZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DF31F000E9;
	Mon, 17 Aug 2026 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786972815;
	bh=8hk4LPxMT6BidWuN4YnPZxq9eLeUPYrTqRr6533IxAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kuCQ1JZl5pTp3ynu6ULGfo9e2FQIg0R93Qch+RyjZI5/m4NP+K4T4ky3S7kZhtyNv
	 pIj2qV2Z5XpQant1PFS1VN53cQTbcyZss+I8BfZAhdedzB/NV5oayYD7DD3DalMEUB
	 hy9l3ZP5RgyVLaUXk0doaMWjF3m3tsBfEyCfGa48=
Date: Mon, 17 Aug 2026 15:15:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: christophe.jaillet@wanadoo.fr, felipe.balbi@linux.intel.com,
	kees@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: f_mass_storage: fix null pointer
 dereference in fsg_common_set_num_buffers()
Message-ID: <2026081724-bath-grime-c071@gregkh>
References: <2026081701-glitzy-hush-b284@gregkh>
 <20260817130208.17219-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817130208.17219-1-jeffinphilip14@gmail.com>

On Mon, Aug 17, 2026 at 06:32:08PM +0530, Jeffin Philip wrote:
> On Mon, 17 Aug 2026 13:10:27 +0200, Greg KH wrote:
> >But that is probably a bad idea, right?  Shouldn't we fix that error
> >first?
> 
> Thanks for the review. Don't quite understand what I need to fix here
> (respectfully), should we harden the buffhds null check to include 
> ZERO_SIZE_PTRs too, something like this should suffice?:
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 640d3bcb7bf0..98643d53cc7a 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2747,11 +2747,11 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
>  	struct fsg_buffhd *bh, *buffhds;
>  	int i;
>   
>  	buffhds = kzalloc_objs(*buffhds, n);
> -	if (!buffhds)
> +	if (ZERO_OR_NULL_PTR(buffhds))

That doesn't look right, think about what your previous commit said it
was doing and why I thought that was a bad idea.

Was it created by a LLM?

thanks,

greg k-h
