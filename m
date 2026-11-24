Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483448;
	b=U0Azn0m3S8FOjAPyFWUP1LNKdYCLz5N486ZM6oQHOYTGRFTrisUhZsrThQSH2KkW8iHS
	 qkgHz8g5tkAVxHkxzYWLjkyKx8wXHcFfYZ1XAxVxNMC/P0YgM/mthsZerGGhTsTTwlZMj
	 AtMcQmnq5xFHnianZLQ5jxfGrZOrRgIvPD14gampTZozxsTFcl4A/JHD1DsB8maFSoAaf
	 LnL7cM1Rde3auVMaptrdydsW/kHwOVVRSQncYAF6iX9SxQ+NsMdqqFbI1oHeu7mn0JhJl
	 tlrYLDItppxInAUuujSb0tytA26pIMGLyIGnSR8oYNxEqxl5U0xXZiIE0pherifDdIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483448;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=W0t5pbVANwul/1wsHrhSmkJyfXGa5C6Z5SFFtj9nFfM=;
	b=gFxx7NI8nH4mKM2/68iL3i6d0bD465LvxAfmi9wkCGMz5dKisRoIwHRIcfo/aLmaM0fK
	 33Dq63HkIhJZszZjV3vPV9ghftQbvk+ZAT1HoJPHzalX4kXTRhMw2iHC4hJLo9xLjj8hB
	 piU75xpYd7V/drteQBzDXtyNDXyuCjhM12khN3YqkMMizsNrmayNDt4ykZAjO7cZ9P4P1
	 0LuawYbV+aWaOmFh8fUQedh7nmTccEjz4eQWOiyI2WvEugtm89ujKzwcqcXP+wEgwt592
	 FSd+hUFCQhAQk46MAdlKj7E7khIufRrnJPG/6Uln6567I22SLcoRMWY4VgQzQeTkevg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xJodKaL2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2ED606A31E;
	Tue, 24 Nov 2026 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xJodKaL2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0701F000C6;
	Tue, 24 Nov 2026 01:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795483447;
	bh=W0t5pbVANwul/1wsHrhSmkJyfXGa5C6Z5SFFtj9nFfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=xJodKaL26ux++MU142EpkwBQYMd759R+F9d5x54S+kLJs3LTewJu5uOO3wmhHmdoq
	 BYBnrGFpOVVJ9Q+RIWl/boIROE6WFw+rCefsVgUWRqT7973fKssc5MhE/ChU6I9IQt
	 cyLqxTJh91A/PzSRxKBDsCEEsiRX4PaBacoEjBXY=
Date: Mon, 23 Nov 2026 17:24:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kaleshsingh@google.com
Cc: kernel-team@android.com, android-mm@google.com, Kees Cook
 <kees@kernel.org>, stable@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry
 Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-mm@kvack.org,
 linux-sparse@vger.kernel.org
Subject: Re: [PATCH] mm: swap: make swap_header badpages a flexible array
Message-Id: <20261123172406.a89eea9c1b5124d5389ce0c6@linux-foundation.org>
In-Reply-To: <20261120061750.2973004-1-kaleshsingh@google.com>
References: <20261120061750.2973004-1-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 06:17:49 +0000 kaleshsingh@google.com wrote:

> From: Kalesh Singh <kaleshsingh@google.com>
> 
> The swap header declares its list of bad pages as a one-element array,
> even though the list can fill the rest of the header page. Since the
> kernel is built with -fstrict-flex-arrays=3, the compiler takes that
> size literally, so with UBSAN bounds checking, swapon() of a swap area
> with two or more bad pages reports an out-of-bounds access:
> 
>   UBSAN: array-index-out-of-bounds in mm/swapfile.c:3674:26
>   index 1 is out of range for type '__u32[1]' (aka 'unsigned int[1]')
> 
> Kernels that trap on UBSAN reports and panic on oops, such as Android
> GKI kernels, crash instead.
> 
> Declare the list as a flexible array. The layout of the swap header
> does not change.

OK.

I worry about these flex_array conversions because there's a trap.

The conversion is safe only if nobody copies swap_header.info using
assignment or memcpy(..., sizeof(info)).  Both would have previously
copied badpages[0], but would omit it after this change because
sizeof(info) shrinks by four bytes.

I couldn't find any such copy operations (didn't expect to) so we're
good.

However it is a trap.  Having a static checker warn about this would be
helpful.  And afaict no checkers we presently have will pick up on this.

(cc sparse peeps)

Can sparse warn when a struct containing a flexible array is copied by
assignment or by memcpy(..., sizeof(struct))?  Both will copy only the
fixed fields, which may silently omit flexibly-allocated array elements.

> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -129,7 +129,7 @@ union swap_header {
>  		unsigned char	sws_uuid[16];
>  		unsigned char	sws_volume[16];
>  		__u32		padding[117];
> -		__u32		badpages[1];
> +		__u32		badpages[];
>  	} info;
>  };

Thanks, tossed onto the mm-unstable pile.
