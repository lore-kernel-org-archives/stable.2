Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8C3C10AD;
	Mon, 17 Aug 2026 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965128; cv=none; b=cubKLStyKcXvXP84QCI+Jh+Txh01qqykRASpjY5AS+gEaqNPdtwq7Ahif1GL6YMJrTjok1ngcHhoc4yUUOZNvyC+PBuNKqJEDdjYfzS+X8Jj1C7lazLIOCSeb4SBy0pq02ZrlWC71fgoS8jTctQhAEQGczTqIUdeZ3o/pFrYY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965128; c=relaxed/simple;
	bh=XSxPgIWo3tHvz18MiuQDSUibOw2az/R+LCrRD9sBPhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTqm8dxbnwXUk8kEKlYEOMrqFuSVjgVLcLbxoZVFmFuOcepa5g7IAZvf2T5d08ztuJCEkMOjtO5zHnf6qUvw9io/m33m+2OMhPC7RgIDbV7oyHQHD8OsHw03JbMufru39rlvVVoV1EQm9rBjAoaip5W1+QMxBJ4Nt8ZtEnQY5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Opa0KQby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Opa0KQby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63E71F000E9;
	Mon, 17 Aug 2026 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786965126;
	bh=LvvAJVdM9Gzv6TJt6FfOuXjRw4JTta/Kh5BKTRi8/zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Opa0KQbyfbWwSlBvAXErxPikBR7WqOHRVHcPEfFHo6nAxP1YBmmEi2DspArAFyD0i
	 Nv70xjX0RW6g18kQS/Mp/lF9da2rkhmSAJrCNDStwc8bYQ4+NTTApY1kVuNZ6X5mtl
	 r9OuAnFBYXyiDZzNzNA+PuBTT6sLEPCJ29J+JpGs=
Date: Mon, 17 Aug 2026 13:10:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: felipe.balbi@linux.intel.com, christophe.jaillet@wanadoo.fr,
	kees@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: fix null pointer
 dereference in fsg_common_set_num_buffers()
Message-ID: <2026081701-glitzy-hush-b284@gregkh>
References: <20260817110839.8201-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817110839.8201-1-jeffinphilip14@gmail.com>

On Mon, Aug 17, 2026 at 04:38:39PM +0530, Jeffin Philip wrote:
> In fsg_common_set_num_buffers(), n can be 0 as conversion to u8
> using kstrtou8() in fsg_opts_num_buffers_store() can return
> values from _0_ to 255. When passing 0 as "n" value to kzalloc_objs,
> it can return a ZERO_SIZE_PTR, which passes the null check for
> buffhds.

But that is probably a bad idea, right?  Shouldn't we fix that error
first?

thanks,

greg k-h
