Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D931716D;
	Thu, 25 Jun 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399179; cv=none; b=tk9PVOBc3BQRWOFT6b0CP/cGf2UrcNn8L/uAa7AKEuTZlRrr/XYtXdAMMdEoPXGkBGbIFjZhNmEnJtETmgH0+HDzUPDPdUZdSF9Hb0KhbOnf+BtlM8TKBDQbBt9erLaKfzB2zp9Ts8Kesw3q6XYnYkpLIH28VUm+qc9uLgfWD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399179; c=relaxed/simple;
	bh=20MUo8eaeVSqPU1qEd78hjP4lpOcs+X0kOSNQv2AnHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaKkCw/2/xhCmBYDXJ4o1AMo6nslYuSOGGZmxW9McVT8VahaMh4HsdpXymDs7uA93SU7+nKYYCpDXKNar5eQNE0QSigbgPKvaLuIJ0+1+dfG0Ba1NVkdm7qFrSZ8z/C+AIIVKVQ+UN2aHWmzRGM9PFuKy9zsE+1mvaF9m9gZK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjE7+K1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjE7+K1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3951F00A3A;
	Thu, 25 Jun 2026 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782399178;
	bh=7y4lmHCjm26T3HpVZ0fSNx9nDdJxZoHYLU4ZSc+rGHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wjE7+K1cABR8msNzsyw0UruERqdlhlYEQ2gYAPSC5MrX5+F6s+FdH8sHmXIppmBf2
	 76LQqoqkK3Mn6K2RR9u6qi5WlvDvNK77K1Jehz61SllFfiXHEfRz6lz50YmTy1MRjB
	 /J9qRd95xs2oBOsHWGc99LNFKsvYxQyxNWbUFTMc=
Date: Thu, 25 Jun 2026 15:51:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: kees@kernel.org, oneukum@suse.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: misc: uss720: fix refcount leak in
 submit_async_request()
Message-ID: <2026062530-capsule-citable-1d57@gregkh>
References: <20260611132952.83931-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611132952.83931-1-vulab@iscas.ac.cn>

On Thu, Jun 11, 2026 at 09:29:52PM +0800, WenTao Liang wrote:
> When submit_async_request()'s call to usb_submit_urb() fails, the
> error path directly calls destroy_async() on the request structure
> instead of kref_put(). This bypasses the reference counting mechanism
> because the kref is initialized to 1 and the preceding kref_get()
> increments it to 2. The callback function async_complete() will never
> run in this case, so the reference acquired by kref_get() is leaked,
> and the structure is freed while still holding two references.
> 
> Fix by replacing destroy_async() with kref_put() in the failure
> branch, properly releasing the extra reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: adaa3c6342b2 ("USB: uss720 fixup refcount position")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/misc/uss720.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
> index b7d3c44b970e..e1eba3cbef0a 100644
> --- a/drivers/usb/misc/uss720.c
> +++ b/drivers/usb/misc/uss720.c
> @@ -168,7 +168,7 @@ static struct uss720_async_request *submit_async_request(struct parport_uss720_p
>  	ret = usb_submit_urb(rq->urb, mem_flags);
>  	if (!ret)
>  		return rq;
> -	destroy_async(&rq->ref_count);
> +	kref_put(&rq->ref_count, destroy_async);

As
https://sashiko.dev/#/patchset/20260611132952.83931-1-vulab@iscas.ac.cn
shows, this creates a new bug :(

