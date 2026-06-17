Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55B363C6F;
	Wed, 17 Jun 2026 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781720207; cv=none; b=TJh5Snj5xrkl99w/zSLN/8sndVApjplw1hiOtadPG0HlumOtW5bGK9JZCpsQrnnSNJaUq1RRwOBAEaERvn2d23IEK8tiwlJw/WN6QseDwctrch3JRbv1UGqnLd+yrQ2y6PgQqxmzhaPU/acxiuCfDWTswOyx+WDCUnPP14BCN84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781720207; c=relaxed/simple;
	bh=xbHMwvM6x2G3KatvY6TnhzSyOv9ROm2RTS6MG7iHj/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgGab2M93aGg7f8C75lQmk5YTGuXhPcisPqWhtSaMnREw5DMmlYvQvDpSuymsiAo5MtCnaII+XJuBaz9BwXDFuO86jkhlrn34TlETUuL25Vv3F9AScKe7WNAKEmG/f7shmj/ZDUXMVnbwG/q7xe6DWWTFAbPrxTdZMutoF+etig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1msFA/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1msFA/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0867F1F000E9;
	Wed, 17 Jun 2026 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781720205;
	bh=34T8fjVS2ijKeY073d7cPWfK3Eup8GlZsznBtOHwLAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k1msFA/7sWqjtak7jhvFWE52RHjJvxyaPLUVFiyCdcgtn/EOS7R3ztlAs5wt4PZuf
	 nldlzfXpwh6i33uufNBV07/pzvjDHT2tQG5GVWd5k4twbHnYbhMkHapJP/UfO5xHg6
	 /o7Q6iVlKAQhD6+0me4dvgaqprajFvit0hvB6F/OHvOoTRWQ3cq9+g/bWbED2WpTcB
	 R1d+1oNzdRyprLGeuVOlOfRn/wbKcl4sd8i6DzEEvhvmTUsTW591TMj/S4ei08Bt1l
	 j/swA4TBUewBZGsillQb1ERsNdzD38OQv8Q30e9RTfC15CrWGF2RJChQwlnouNyFLr
	 Gz5PyhzE0vCGg==
Message-ID: <89da8f81-9e6c-4923-be0e-7e29c7fdb68b@kernel.org>
Date: Wed, 17 Jun 2026 20:16:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] slab: recognize @GFP parameter as optional in
 kernel-doc
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20260617163125.2716279-1-rdunlap@infradead.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <20260617163125.2716279-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 18:31, Randy Dunlap wrote:
> Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
> the kernel-doc to indicate that it is optional. This avoids kernel-doc
> warnings:
> 
> WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' description in 'kmalloc_obj'
> WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' description in 'kmalloc_objs'
> WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' description in 'kmalloc_flex'
> 
> Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

Added to slab/for-next, thanks!

> ---
> v2: add default value for GFP flags to the description (Harry)
> 
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Harry Yoo <harry@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: stable@vger.kernel.org
> Cc: Kees Cook <kees@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> 
>  include/linux/slab.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20260615.orig/include/linux/slab.h
> +++ linux-next-20260615/include/linux/slab.h
> @@ -1094,7 +1094,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>  /**
>   * kmalloc_obj - Allocate a single instance of the given type
>   * @VAR_OR_TYPE: Variable or type to allocate.
> - * @GFP: GFP flags for the allocation.
> + * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
>   *
>   * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
>   * on failure.
> @@ -1106,7 +1106,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>   * kmalloc_objs - Allocate an array of the given type
>   * @VAR_OR_TYPE: Variable or type to allocate an array of.
>   * @COUNT: How many elements in the array.
> - * @GFP: GFP flags for the allocation.
> + * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
>   *
>   * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
>   * or NULL on failure.
> @@ -1119,7 +1119,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>   * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
>   * @FAM: The name of the flexible array member of the structure.
>   * @COUNT: How many flexible array member elements are desired.
> - * @GFP: GFP flags for the allocation.
> + * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
>   *
>   * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
>   * failure. If @FAM has been annotated with __counted_by(), the allocation

