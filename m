Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE093793D5;
	Thu, 20 Aug 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247969; cv=none; b=ZpWQ3kDOrJnHWIBiFMsaTEsIvSZ6VJ5jtxxnMI+JERXZL/tO3IW8enK/LHbtP/CHkN+/mmQBmckxuikMF570Fy3bl7kvk4hZ3WJn8pntotLhjxZmyb9wXylkolVmXym4XW0IsR2EpwPAaMczMOixehcDRGVWBJDz0BFxrZloW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247969; c=relaxed/simple;
	bh=7StsbE2/ANhF6+w5FACGz37Gtz8fJzWeWKX011Zkbjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5pGoozEUiGSg93gFrcPly8tGFBwuiAj6JmmE+6AyDVJxSvsX7we28QAeFsZDitTXJCAF3KwnMAavVjv3e5oPXRUxdBCU40CNZ1mvetifNf8GesEmMzJ2xGjl+SgxINN+MWcqJIusLKd5a2sxHiGnjuxqsW/grZmYiMA/Q0g8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDusI37K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDusI37K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6AF1F000E9;
	Thu, 20 Aug 2026 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787247968;
	bh=0XgKfHq8q+9b3BQqyUkNSYpRzbrHEntjbLaquzgN4/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FDusI37K7ZKzYHTu7fwMP6ctRszdP8fvj+Z/ZBeynS3L0syP4zypMgVYSGXreCq5R
	 J0M9QqqRiyDdze87ZSRqF8gMXDMtMZWt3UAJvPPNXyWKRKg06nTUija1GI5W+Gn+73
	 b8PyclxPt7sVOuqwlTF/cjV5MJxWXaX6uYjkWZp7mQsBFi3pmLx7m5RxujjmvElE+z
	 vq1vDCKybXJRzQGaHF74W1Pz1M7Vk++cRxRCd9Pwej4yGcVfcQ4FqrVtmwqV9NRyxw
	 NJVHcdHnCaLQiNc/tRKashoZK69a1kuT+QvHmlo6ThsctoC8sARWsxyRC2tl8AQv1Y
	 dO8S69AqsSayw==
Date: Thu, 20 Aug 2026 07:46:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: gregkh@linuxfoundation.org, chenridong@huawei.com,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] kernfs: recheck of->released after acquiring the active
 reference
Message-ID: <aoc9XplwfHGjQym4@slm.duckdns.org>
References: <20260820021810.163082-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820021810.163082-1-fanwu01@zju.edu.cn>

Hello,

On Thu, Aug 20, 2026 at 02:18:10AM +0000, Fan Wu wrote:
> @@ -73,12 +73,22 @@ static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
>  /* Get active reference to kernfs node for an open file */
>  static struct kernfs_open_file *kernfs_get_active_of(struct kernfs_open_file *of)
>  {
> -	/* Skip if file was already released */
> -	if (unlikely(of->released))
> +	if (!kernfs_get_active(of->kn))
>  		return NULL;
>  
> -	if (!kernfs_get_active(of->kn))
> +	/*
> +	 * @of->released is set under kernfs_open_file_mutex.  While the
> +	 * active reference is held, @kn can't be drained anymore and
> +	 * kernfs_fop_release() can't run, so re-reading @of->released
> +	 * here settles whether @of was released for good.
> +	 */
> +	mutex_lock(kernfs_open_file_mutex_ptr(of->kn));
> +	if (unlikely(of->released)) {
> +		mutex_unlock(kernfs_open_file_mutex_ptr(of->kn));
> +		kernfs_put_active(of->kn);
>  		return NULL;
> +	}
> +	mutex_unlock(kernfs_open_file_mutex_ptr(of->kn));

"lock -> test something -> unlock" pattern is usually unnecessary. What's
the mutex achieving doing? Doesn't kernfs_get_active() already have strong
enough memory barrier? If not, it'd be better to solve it by iterlocking
kernfs_get_active() and released clearing.

Thanks.

-- 
tejun
