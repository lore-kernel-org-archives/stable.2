Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793523151;
	b=wVZJBfKx5aKx+Oc/fKFjMO1spGkPUwM1ULNR+RcWsAI7GtsDk9eX7BdP464O7WOSzP9L
	 oGU6r+5I9dkW+3l+/FPAc3MTZY9HN1ABJL38cQ1dRwCxlZcf9RdzjJciQk/AtizKFGNyd
	 RDawZxgZ9WYQnis8+SANZVzER19LxqxKx+er04Mn3NYDZOsecxwC4QN6OmFRoB54HvLRx
	 jovfRtePuOZdMNmkKUw0HbCgO56GiaUS9kQR3x2Cg67JeQWbooj3nx/mIfiav1JgmImOG
	 uEFOjE70FrFVs8t7AjwaMO9zJHw8ZJ3PjHjhSeu05lpBM55m8ED9Zq+AHg3x8B3kMZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793523151;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/sz+0vnC4+5RTFAXS0JKLy80J3yhuDkLqCPBEfCzcc4=;
	b=Qoffv3J2ObjaRbinVVEFpMK114XKG0sN0+9rGacyXPIO99+Yu8hRiui0J85zko/vOL/5
	 iEJluGhGwSKw6Gz6XvsmIWgxo0xsUd9UTQmOuWlmtLeI6gEnaBn5m+Q2xknDYRgD7/XN8
	 phSHpd//QZdUwiy+wVZZsXNsD84t4AVwA6rvZlKVnR8Gpz9oJi3yM3MPRYVn6HEzvG0KO
	 GHwBRlAsQjoPNagZdANZG6QshKLU313UeAipljCGK3iFpPjKP7tOHR0ujzvyyDsPbMbQA
	 4Lr4VEz2C0NGIX76w68SLzXN/dcQsFUxodd/jAD9Hg38UZaaLbJDTrkTFZ7uZYZZo+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LeBlWQcp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F75606A32D;
	Sun,  1 Nov 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LeBlWQcp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB6C1F000C1;
	Sun,  1 Nov 2026 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793523149;
	bh=/sz+0vnC4+5RTFAXS0JKLy80J3yhuDkLqCPBEfCzcc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LeBlWQcp+pFagfSEjKhAgrQb8EFutNQ5G8HvL0vRQDI95UfoEGpy677ipSk5eu6SA
	 3jpuVCcYjYsEqDz1k1kO+YDI91KUA8fZTu2p2B9Gku2l0mmFePjG8Gt0IvxMric69L
	 t7QvDXEGwV9Ryr1DmT+yqzVjPWhB7ubn+DCxFWdM=
Date: Sun, 1 Nov 2026 09:52:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Hongren Zheng <i@zenithal.me>,
	Sung Byeongchan <tjdqudcks0424@naver.com>
Subject: Re: [PATCH v2] usb: usbfs: clamp actual_length to
 transfer_buffer_length
Message-ID: <2026110138-kettle-daredevil-ceb5@gregkh>
References: <20261101070651.1846947-1-teel4res@gmail.com>
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
In-Reply-To: <20261101070651.1846947-1-teel4res@gmail.com>

On Sun, Nov 01, 2026 at 12:06:51AM -0700, Cheng Yongkang wrote:
> usbfs uses urb->actual_length from the host controller driver without
> checking it against the buffer it allocated. For a completed
> non-isochronous IN URB, processcompl() and processcompl_compat() copy
> that many bytes to userspace and report the same value, and
> async_completed() passes it to snoop_urb_data() when usbfs_snoop is
> enabled.
> 
> With USB/IP, the value comes from the remote peer. If the peer returns
> actual_length=88 for a 24-byte control-IN transfer, usbip_recv_xbuff()
> rejects the length, but VHCI still gives back the URB with -EPROTO and
> actual_length=88. usbfs copies data from failed URBs too, since they
> can carry valid partial data, so reaping the URB reads past the buffer:
> 
>   BUG: KASAN: slab-out-of-bounds in _copy_to_user
>    copy_urb_data_to_user
> 
> With usbfs_snoop enabled, hex_dump_to_buffer() reads past the buffer
> earlier, when the URB completes.

Why not fix this properly in usbip so that all drivers don't have to do
this type of check as well?  That's where the "bug" is, if any.

thanks,

greg k-h
