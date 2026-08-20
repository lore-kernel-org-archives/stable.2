Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683023B62B
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234427; cv=none; b=OfK0LPX9Hk7jG8VIqniIbOsM/sSUThvm5nWLgoSxZapR0DNCajkXFKQ4MLrJQNsFifhbfxU8utMx6if0lYeLQ8oKK10XM1LZepZ/S7eS0d5cm1tCzkxbnk6+xd0I8YngXG6lTmvEonqSMgjgGOy2KwGua5Gp8CafAPZYm25All4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234427; c=relaxed/simple;
	bh=F0v9fCTO2/obCxZE57LIWEIyGq5HPEH2jJjPNO5Lqgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg6/4acrgQbA+DvOb1OplwxXeZhzVnILZtAq+WAlHr+rPDxuJLx7SowUViL6y+XbTwXWk/udEEHNGH8u/U4DdZCLSr1laLchZfWxgkaj9VHHeZCO0u0kXIOMWeorDNvyUNaJmvZS+6RCgQXOIWAVg2FDWnFLfA9YyGjSX3ZoN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OoBgYH5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OoBgYH5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0731F00A3D;
	Thu, 20 Aug 2026 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787234425;
	bh=yyiEzea1vaPxXq3g6oeXTlFmeAYUTixVJe1lmGUnTxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OoBgYH5NjxPez2uCR85+Ypnev97Pk4mINxyQxEu/X+ih3hYYgREJaueOFxZyPZY2s
	 3Hi9+2kzsfhSg7ov8vRDgxrNIbSu01Fxi5IUvQhY0h73PFzf9qiXp2R1Wg281e4UTQ
	 76Uf6k8PIPjUG0PwTEqzmpzJeKEFfP1vu3lvN8UQ=
Date: Thu, 20 Aug 2026 15:49:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hyokyung Kim <pulpannie@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 6.1.y] virtio_net: clamp rss_indir_table_size to
 VIRTIO_NET_RSS_MAX_TABLE_LEN
Message-ID: <2026082033-driven-tumbling-f69d@gregkh>
References: <stable-reply-item007-virtio-rss-20260630181642@kernel.org>
 <20260703105256.3884798-1-pulpannie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703105256.3884798-1-pulpannie@gmail.com>

On Fri, Jul 03, 2026 at 07:52:56PM +0900, Hyokyung Kim wrote:
> virtnet_probe() reads rss_max_indirection_table_length from the device
> config space into vi->rss_indir_table_size and later uses it as the
> number of entries to write into the fixed-size 128-entry indirection
> table in struct virtio_net_ctrl_rss (in virtnet_init_default_rss(), and
> again in virtnet_set_rxfh()/virtnet_get_rxfh()), without validating it
> against VIRTIO_NET_RSS_MAX_TABLE_LEN. A malicious or buggy device can
> report a length larger than 128 and overflow the array, corrupting
> adjacent slab memory. This is reachable at probe time, before the
> interface is brought up.
> 
> This was fixed upstream by commit 86a48a00efdf ("virtio_net: Support
> dynamic rss indirection table size"), which reworks the driver to
> allocate the indirection table dynamically. However that change is too
> large to backport to stable. Instead, clamp the device-advertised length
> to VIRTIO_NET_RSS_MAX_TABLE_LEN: this solves the overflow with minimal
> changes.

Why is it "too large"?  Again, we want to keep as close as possible to
upstream as diverging will cause bugs and maintenance problems over
time.

thanks,

greg k-h
