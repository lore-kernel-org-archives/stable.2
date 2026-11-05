Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889942;
	b=hGbYrPM+HmVuRZyOunlkJpDS+d5MObzpbK6BqPxgq4F+VGrh8NcM4NZAjJVyr/0fmgmB
	 eTDgZsyGgj6+Bzd+IAHY1SivJlq2HTo9wnthHoKtQgIhb6E9toh5eGnzuanmurV5ER/gs
	 YhUQUmFOkPs+B0qt673a/0ujXbv9ghXsNKtezSJZrd9cTPnyept+2sJQDojis76NuuINJ
	 fcwuMVvfzEEtKSf5ZQjQHlS6Kq7MkHiGX/qybx/cu+Nn359i8pSuKKs5tw8Lko6gY7nN5
	 qPkm78v7SRFbGqDXIn86GNFoH5v+TPpx0kZb9K1kdi/+F1caYUUMUFJoHgLvmW7kevw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889942;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GXf8t6+kR4HdU5+vFSNIxt3JNXiYtbmrhcPp2vi87yk=;
	b=5a+cK9KzuLOZEt4XqdhF7oyv6yCs1iGtNff9TxUcEwNA84PZ8JHaFVygoQDk6LmnK4Dm
	 /ApNVMaVqcEK8W1LOAyT8TS8QjUrUym4HchlyQalIUbtOfld9SAAAAVQqqXtK0bPSRiVn
	 4iZ6C/gNF1+fLo8yR1FPGN2YkUganSZ2Fqlvyo3fQY0BlY7ngeZIkbsMKXFjcYYubNpOy
	 HchzZ0AK6WztBi+FuNv4MrHZLfwh0l8PWYdZ19qyZrGvcQOLhKZLY5/wZ3cIXWy6oPNCE
	 0yDYX9FjCkSaB8hhpoWBQjsriNDbsPAptHk/yCBAZpAQ97qwEVb7oMPltOHU317u88w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gN0fJVGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32D606A31B;
	Thu,  5 Nov 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gN0fJVGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F401F000C1;
	Thu,  5 Nov 2026 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889941;
	bh=GXf8t6+kR4HdU5+vFSNIxt3JNXiYtbmrhcPp2vi87yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gN0fJVGrutjDiaCK/OwIN5FP3P1bXDzDLpx2L2NnnxLb12q0eiEJrr/qJ1a8n9H0P
	 +0QArjydJvzix9vyXR1mpdzVi5V8CXR40jVi1vhGiMHFmOXtrxgtqUH0aU8Z9o1Fil
	 V8cqAKiY4YtE0S2hcIvsO1vV2XIvUHIywLAQ00Um199J8PAR++EwvyXguTNvRw9sSd
	 E+gmzCc6KdNTd4u6mab6FrJElG38RUn5Z1J7p8DbaSKcDtbA4Qa2ZzcRRXM9fDfv1B
	 BP1ONSzVTPckWUArA6GYUl71jjqEmXscJl5AroUfu7120tY6N8/k5b3akMHzQpzanV
	 LRtyIcHRovM9Q==
Date: Thu, 5 Nov 2026 14:45:37 +0000
From: Simon Horman <horms@kernel.org>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] openvswitch: advance by the real header length in
 get_ipv6_ext_hdrs()
Message-ID: <20261105144537.GV865646@horms.kernel.org>
References: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>
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
In-Reply-To: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>

On Mon, Nov 02, 2026 at 01:45:35AM +0000, Joas Antonio dos Santos wrote:
> get_ipv6_ext_hdrs() walks the IPv6 extension header chain to fill
> key->ipv6.exthdrs, but advances to the next header with ipv6_optlen()
> whatever the current header is.  That is only right for Hop-by-Hop,
> Destination Options and Routing headers:
> 
>  - an Authentication Header is ((hdrlen + 2) << 2) bytes long
>    (ipv6_authlen()), so with hdrlen = 4 the walk skips 40 bytes instead
>    of 24 and reads the next "header" from the ICV and payload;
> 
>  - a Fragment header is always 8 bytes, and the byte read as hdrlen is
>    its Reserved field, which the sender controls and receivers ignore,
>    so a non-zero value makes the walk skip up to 2048 bytes and miss
>    the headers that follow;
> 
>  - in a non-first fragment nothing after the Fragment header is a
>    header at all, it is the middle of the fragmentable part, yet the
>    walk keeps parsing it as an extension header chain.
> 
> In all cases the OFPIEH12_* bits stored in key->ipv6.exthdrs depend on
> bytes chosen by the sender rather than on the headers that are actually
> present: payload bytes that look like another AH or a Hop-by-Hop header
> add OFPIEH12_UNREP/OFPIEH12_UNSEQ, and real headers after a Fragment
> header can go unreported.  Flows that match on OVS_KEY_ATTR_IPV6_EXTHDRS
> then classify such packets wrongly.  There is no memory safety issue,
> skb_header_pointer() bounds every read.
> 
> Advance by sizeof(struct frag_hdr) for Fragment headers and by
> ipv6_authlen() for AH, and stop at the Fragment header if its offset is
> non-zero, as ipv6_find_hdr() does.
> 
> Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
> Link: https://lore.kernel.org/all/178905555085.219967.6617611783437228045@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> ---
> Changes in v2:
> - Stop the walk at a non-first fragment, nothing after its Fragment
>   header is a header (Ilya).
> - Drop the Assisted-by tag (Ilya).

Reviewed-by: Simon Horman <horms@kernel.org>

