Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE340D576
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490521; cv=none; b=i+FD16ExeaQBhwBqISaLDC0zMwuwxF55xq8Xacvo2yIsm2kQ+0BUyZKFUBlAL4yYJLiY2dWaA8Fva6uT9ed9B1iWqs+i+AYiRXiIrQHT/CTWztRuKBejS+zChdqHFsbpR5ML+i5DeJnnAJwh9fdAJXgOZqs78oMmYhzrxuhbxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490521; c=relaxed/simple;
	bh=vd1rrFS3ZXqUUBFl1oce2RMTbvj4t6Aslfiy2+IB7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQv80m8zBv1Esb5dak3BwtainA0Oa2WoMzQQZdtLKL9FzXn7CTclG+VQK0x0WMzU49o0rZhXy4MT1x1uPMH+vmSlE/Ozp8MueBGVCv4+irxpkWJnKpSmXdoMhTyjC+h08wq3nKSJfyWD5FJpd79SqzVSrVvCiUR4b1ZvGspAnxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1MN6TX2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1MN6TX2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC361F000E9;
	Mon, 15 Jun 2026 02:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781490519;
	bh=22uxKnjlXfTx27EwOpIacyXmofgdi4irrvDT9unK87I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1MN6TX2QK2V0THU4DK3WA7AIaql/aQk6vzsKoEEnrgZa8akWH+i+Pi+nI+D1K3OIC
	 D2o0JIIdkwVtFLK7uzmP1MAlXAEclQ8berVLopQNly/Sv/RcYLW3bX/OqXRva4LzI/
	 LBAIpUgsWE4VY1YDXXaUYqqMmPzkVeNIqksSz5pw=
Date: Mon, 15 Jun 2026 04:27:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Tautschnig <tautschn@amazon.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: fix heap OOB in buffer_from_user and
 buffer_to_user
Message-ID: <2026061535-hardened-presuming-96b2@gregkh>
References: <20260614195318.40397-1-tautschn@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260614195318.40397-1-tautschn@amazon.com>

On Sun, Jun 14, 2026 at 09:53:08PM +0200, Michael Tautschnig wrote:
> The SLAVE-path read/write helpers buffer_to_user() and
> buffer_from_user() copy 'count' bytes into/out of the fixed-size
> kern_buf (PCI_BUF_SIZE = 0x20000 = 128 KiB) without bounding
> count against size_buf.
> 
> The caller vme_user_write()/vme_user_read() only clamps count to
> the VME window size (image_size = vme_get_size(resource)), which
> VME_SET_SLAVE sets from user-supplied slave.size — validated
> against the VME address space (up to VME_A32_MAX = 4 GiB), NOT
> against PCI_BUF_SIZE.  When the window exceeds 128 KiB, a
> write()/read() copies past the kern_buf allocation.
> 
> Fix by clamping count against size_buf in both buffer_from_user()
> and buffer_to_user(), with an early return when *ppos >= size_buf.
> This mirrors the existing bounds check in resource_from_user() (the
> MASTER-path helper).
> 
> The bug was found by static analysis (CodeQL taint tracking + CBMC
> bounded model checking) and dynamically confirmed under KASAN with
> the vme_fake bridge:
> 
>   BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x2d/0x80
>   Write of size 262144 at addr ffff888004100000 by task trigger/68
>     _copy_from_user+0x2d/0x80
>     vme_user_write+0x13e/0x240 [vme_user]
>     vfs_write+0x1b8/0x7a0
>     ksys_write+0xb8/0x150
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Tautschnig <tautschn@amazon.com>
> ---
>  drivers/staging/vme_user/vme_user.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Nice, but why did you not use get_maintainers.pl to determine who to
send this to?  You cut out the staging list?


> 
> diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
> index 5829a4141..bacf6a7d6 100644
> --- a/drivers/staging/vme_user/vme_user.c
> +++ b/drivers/staging/vme_user/vme_user.c
> @@ -156,6 +156,15 @@ static ssize_t buffer_to_user(unsigned int minor, char __user *buf,
>  {
>  	void *image_ptr;
>  
> +	/* Clamp to the fixed kern_buf (size_buf): the VME window
> +	 * (image_size) may exceed PCI_BUF_SIZE, so *ppos + count can
> +	 * run past kern_buf otherwise.
> +	 */

Not a network driver, so you can use normal coding style for comments.

> +	if (*ppos >= image[minor].size_buf)
> +		return 0;

No error?

> +	if (count > image[minor].size_buf - *ppos)
> +		count = image[minor].size_buf - *ppos;

Why are you covering up for userspace errors, shouldn't this just fail?

> +
>  	image_ptr = image[minor].kern_buf + *ppos;
>  	if (copy_to_user(buf, image_ptr, (unsigned long)count))
>  		return -EFAULT;
> @@ -168,6 +177,15 @@ static ssize_t buffer_from_user(unsigned int minor, const char __user *buf,
>  {
>  	void *image_ptr;
>  
> +	/* Clamp to the fixed kern_buf (size_buf): the VME window
> +	 * (image_size) may exceed PCI_BUF_SIZE, so *ppos + count can
> +	 * run past kern_buf otherwise.
> +	 */
> +	if (*ppos >= image[minor].size_buf)
> +		return 0;

Again, why not return an error?

> +	if (count > image[minor].size_buf - *ppos)
> +		count = image[minor].size_buf - *ppos;

Same here, shouldn't this fail?

And no chance for this to wrap again, right?

thanks,

greg k-h
