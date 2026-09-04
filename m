Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE433E314A;
	Fri,  4 Sep 2026 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511022; cv=none; b=ciVi8RzRJemLrluW8MmL5MbhAFuOG/yEe1zuqLsWmvYlRWxR9V925jyRbjKN0eLw2188wQ7u/BfNt0gx9Q5yD+VS/ZZMc9pqYu9thDzeD/wNOJT9qlJmwakf3Y6j/gjPZ/vhBXbNlUDw/HCfhskfXF6yCEA9MsHNfnSOYg23S1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511022; c=relaxed/simple;
	bh=hVsTuuHZj3uYJRFvqPx94L4ibbQVOh8tjyL95Gbupb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBTRciNVHvQ9+eZqIYcQ2QBXYiPCba/hu5U2ycgJRnPbhPaBFTW/XqbZopZWupmt4GBf8gLgSsGoOsSn3qdPXl9xYtpuDGdOrVJiudMoArJ2RnqQXXI1Xn/WygTWVV5wDKNFK1r7jfhQbpb6GCygPUV9LUIbXPDkQ+idJeXaLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnUJh5Hg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnUJh5Hg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DA01F00A3D;
	Fri,  4 Sep 2026 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788511021;
	bh=zBrk2QprdqP3/r0sv7TlgCkEXn7X9IEhwGJqmb+FJVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fnUJh5HgixD5Y0yV/Z4vTzdcNrWWRVpj3EiJK3bknSiRTwyD23FLk5NYQmtdyCK+9
	 afjJUtW1f5r7fUh3q9LnYAVFJ+3Bve/SzmMPdsBi6LgRDM2yaJLUqtZauRG4d7tOGP
	 ueeb7mxRqm0fAyFR59AbKGVxF0mTv7TnsDEuS978yOkbS7S/okPYVUTLAv1ZgNqzPy
	 5QGhXV1pQXilLh/cd/Zw61Bb2LPQq3Hm4HmhPECEmcGyGpP7WMjNoKLR/vYqVjsZfn
	 P46U6mfXRZYQdYIdKjYLJ7kxeDCXjfEB2Sm5CbbYDTCcW4+ad0/f3ycbKzKuSa2oSm
	 +HEbOAkTvO4Aw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x2PPv-00000006kwc-0Ky9;
	Fri, 04 Sep 2026 10:36:59 +0200
Date: Fri, 4 Sep 2026 10:36:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Adriano Cordova <adrianox@gmail.com>
Cc: elder@kernel.org, gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com,
	Yang Zi <2959243019@qq.com>
Subject: Re: [PATCH v2] greybus: operation: fix out-of-bounds write in
 message allocation
Message-ID: <apqDK5dHYGaJRwx1@hovoldconsulting.com>
References: <20260902145916.63052-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902145916.63052-1-adrianox@gmail.com>

On Wed, Sep 02, 2026 at 10:59:16AM -0400, Adriano Cordova wrote:
> The incoming message size from the device header (header.size) is
> trusted without checking that it is at least the size of the message
> header itself, but a value smaller than sizeof(struct gb_operation_msg_hdr)
> underflows request_size in gb_operation_create_incoming(), wraps around
> in gb_operation_message_alloc(), and results in a tiny buffer that is
> then written past its end in gb_operation_message_init().

Is it really? I was under the impression the only issue here was the
potential zero-size-pointer deref.

> Reject undersized messages before parsing the message header.
> 
> Fixes: 87d208feb74f ("greybus: embed message buffer into message structure")
> Reported-by: syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=2fd6aefc361af86911d5
> Cc: stable@vger.kernel.org
> Assisted-by: opencode:deepseek v4 pro
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> v2: point the Fixes tag at the proper commit (87d208feb74f), and add an
>     Assisted-by tag.

Either way, Yang has already sent a fix for this as I mentioned before
(and which is now ready to be merged):

	https://lore.kernel.org/lkml/tencent_617A1B9F1DCD78A45A65AB7AFD8AAD84460A@qq.com/

Johan
