Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801419;
	b=4ZbkgiAO+Zzyg8F39s3WAuZl9bIIFeD4Ua3s5wOYENZunoORKyjNfQTVOW+1/7IEQlRf
	 PrYp0diV6ndEaqYUye3YMCSVDGW4oZIvaVayP4++LjnId78QPmliJtOhKreaV1dP1DllV
	 5UpPx6JknEXThCgIweVuM5Squ7QHZUjkklfaKwijsQTE+vy2lR4IeGpNfk+hujpJzRsPi
	 uKcA6mBZEHHUspIkgrM5OSoc0WIPpxjstKOjEqqCt+zH96UsqPXRjBjhg6sqCDD42XR3D
	 GdNIcv2VQHWV4fx5HlSFek+rxHfSlf9tt7V7UrKUImO0injgKgyYi+JUWA0XqpQ6lRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801419;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dh12uzsrER00H9vGSCK0JLMj09eT5W4ici5fSw9EpLM=;
	b=Xr6gCbKtdh6YZldbnDUo5k1bQuW3sIXchurSp6tyHUocGXD/bF9aY1L/J6hoPCJloio7
	 tLyGiGXaJ0INvsvhNi+YFeCkQy341oyHWvLOLMo4eghMCrlSAEap22U4S+Fjm7ja92tD8
	 JLQijZ5VH9mYIZhj211XpcnoM3pgxGrDg8f3bFTYQZ09+FQKvC4HDcevqs+kv++C762Dd
	 gh3Ak1wm1ZsuYcfrA22Yvwj7IuhDATOi1Qgnnm5Q9Kju/Udw/qMEqxVWqgSZ/VqI315Q8
	 bRJtu4jwIrRxZ9KpSru8DHECnZQxGIEziVpX8pynyznAMnj/3YN7VHiaSgCfPLod9Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nqkfAV0Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA240606A33A;
	Wed,  4 Nov 2026 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nqkfAV0Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556691F000C1;
	Wed,  4 Nov 2026 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801418;
	bh=dh12uzsrER00H9vGSCK0JLMj09eT5W4ici5fSw9EpLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nqkfAV0YKqYczzU50N6FfRKDfLGiKQiJeav0sfvUK20eLt2aQvw9mxX73AgGQw3ar
	 Uxldvc4tYZnU5HYGi8+MqKoQiYQsQM+Jdj/LSSN0DIpnLcprgoB0cQmPJBzGYgRitd
	 Z94I/DZPuaDy9ORdk6k1KTGaU+jzTp9HNErMgRv4=
Date: Wed, 4 Nov 2026 15:10:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Feng Ning <feng@innora.ai>
Cc: linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
	luka.gejak@linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH v7] staging: rtl8723bs: fix heap buffer overflow in
 cfg80211_rtw_add_key()
Message-ID: <2026110400-majestic-reason-751a@gregkh>
References: <20260413113224.5201-1-feng@innora.ai>
 <2026042626-tabloid-suitor-33c5@gregkh>
 <20260427111738.33069-1-feng@innora.ai>
 <2026050417-monkhood-backless-4c3e@gregkh>
 <20260504154823.52057-1-feng@innora.ai>
 <2026050458-numbness-haven-1ae4@gregkh>
 <20261104220347.ccc09fa4-1-feng@innora.ai>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104220347.ccc09fa4-1-feng@innora.ai>

On Wed, Nov 04, 2026 at 02:04:29PM +0000, Feng Ning wrote:
> The cfg80211 framework allows userspace to specify a key sequence
> counter (NL80211_KEY_SEQ) of up to 16 bytes via NL80211_CMD_NEW_KEY
> netlink messages, but ieee_param.crypt.seq is a fixed 8-byte buffer.
> When cfg80211_rtw_add_key() copies the sequence counter via memcpy()
> without checking seq_len, a heap buffer overflow of up to 8 bytes
> occurs, overwriting bytes following seq within the same ieee_param
> structure (key_len and the trailing key[] flexible array).
> 
> Reject sequence counters longer than the destination buffer with
> -EINVAL instead of copying them, as discussed during review of v6.
> 
> This is sent as an RFC because it still lacks a Tested-by from real
> hardware.  A userspace trigger program for the overflow (libnl-based,
> NL80211_CMD_NEW_KEY with a 16-byte NL80211_ATTR_KEY_SEQ) follows in
> a reply to this thread; anyone with an rtl8723bs device who can run
> it against this patch would help unblock the fix.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Feng Ning <feng@innora.ai>
> ---
> Changes v6 -> v7:
>   - Replace silent min_t() truncation with an explicit -EINVAL when
>     seq_len exceeds sizeof(param->u.crypt.seq), per review feedback
>     (Greg KH, Sashiko automated review)
>   - Use the existing addkey_end cleanup path so param is freed on
>     the new error return
>   - Sent as RFC: code is complete but awaits a Tested-by from real
>     rtl8723bs hardware
> 
> Changes v5 -> v6:
>   - Restore the changelog that was lost in v5 (per Greg KH feedback)
>   - Add Cc: stable@vger.kernel.org (user-reachable heap overflow)
>   - No code changes from v5
> 
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 +++++++-

Please rebase this on the latest tree and see what happens :)
