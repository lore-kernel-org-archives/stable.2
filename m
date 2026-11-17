Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903581;
	b=hAH/o/zqbjT4TNUKaOb32n5iMNnCQD+ZkS+npp2vgKn2ubGEHs26Xjb/xCqYmH5UJ827
	 Oq4rJajhfTZ+4nitLQkzQcPrZ/nnY6vcASBgtRICrsLIz3nAeRkwahkSAw8CJtNAiR23C
	 vyQIWajNJ6Go/fLYeQgl6yo9EZi7De/15h9WMBSis2JkpQfgD2ha4aktVlcIVl2aL1JJ7
	 mzl5NjrztpSNaa3QW3n0IZzLQP3Ycs1tAM6DHe1tqfVrxuEOHxqqgzaiDjYUuA21+iZik
	 GmfyAW8upXqmIvgC5KdxS3e6XASGT8UOofhmcZCjLaZLoX32h2Mr+kx/l/a+hqLtRgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903581;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b806pDB31XGVA1bdN7bIHXoO7J1pfmwmL6Kf7lrj/xY=;
	b=dOeQyqxjluw3U17V6GL5WNfrxhE3z/BZYuocAzF/OCfxNVDnJ/eJ0qzCHAJgc3EUTnZx
	 ZnpJ26qtamqnotISeavIbe9YzKc8Dib4y5E/TeLeJRF+8vfSSBATN7ewQdVdPCZTXO0nE
	 BNk5chhSzZmVrJUQ8GZRg1y07Z016OQvFwiHjd+N82Bdy0etumr1p8lBw1ZLAYSUNKhbr
	 jI/vRxwcG3VjNUF0RAR2XhfFzhpjnkSW19KcCEK14YA1iRvTnEcewJqNId8oqGv9/45eb
	 +IB6ol/tm5FE7DMjk7JngVx+CfO6J7H2wizzW76O9XRKC/wNqP1ZX/sG+Py9hniRTHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mRsGwRy9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18D606A31C;
	Tue, 17 Nov 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mRsGwRy9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6832E1F000C4;
	Tue, 17 Nov 2026 08:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794903581;
	bh=b806pDB31XGVA1bdN7bIHXoO7J1pfmwmL6Kf7lrj/xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mRsGwRy9PklCwgplWSqIkA6tsjDzHx/QWeNiztzg1UAGkN5rUzFXzOVZCh5OoFfcs
	 hSjSrWzXMHmCK7D4SYEgcBdr1bbOmoAWVvsZzBusxbI7+48NnMYS2xqttBSMWFIC1L
	 iEWtNLWE29RQTYiqB8g0v1Eq8Ym6RTl9wR4wpw9I=
Date: Tue, 17 Nov 2026 09:19:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: stable@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	ihor.solodrai@linux.dev, daniel@iogearbox.net, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, emil@etsalapatis.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Alan Maguire <almagui@kernel.org>
Subject: Re: [PATCH 5.10-6.18 v2] libbpf: fix cross-endian build with newer
 libbpf
Message-ID: <2026111724-popsicle-pumice-96ec@gregkh>
References: <20261116233301.1531563-1-asmadeus@codewreck.org>
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
In-Reply-To: <20261116233301.1531563-1-asmadeus@codewreck.org>

On Tue, Nov 17, 2026 at 08:33:01AM +0900, Dominique Martinet wrote:
> commit 087f3964f4b3 ("libbpf: Support layout section handling in BTF")
> added extra data to the BTF header.
> 
> This extra data is ignored in the native case, but when building with
> different endianness the bswap code in old libbpf would check for strict
> size equality, leading to build failures such as this when BTF data is
> generated with a newer version of libbpf (through pahole)
>     BTFIDS  vmlinux.unstripped
>   libbpf: Can't load BTF with non-native endianness due to unsupported header length 32
>   FAILED: load BTF from vmlinux.unstripped: Operation not supported
>   make[2]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> 
> Newer libbpf versions also properly ignore trailing data in the bswap
> case, but the patch is too intrusive to backport, so take the header 
> length comparison fix from it instead.
> 
> Link: https://github.com/NixOS/nixpkgs/pull/570639
> Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
> Acked-by: Alan Maguire <almagui@kernel.org>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> v1 -> v2:
> - link to v1: https://lore.kernel.org/r/20261115200505.1494710-2-asmadeus@codewreck.org
> - use offsetofend() instead of sizeof() to match the support layout
> section handling patch as suggested by Alan
> I checked this builds on 5.10 (non-cross-endian build) and 6.18 (ppc64
> cross build)
> - add Fixes tag as suggested by sashiko
> 
>  tools/lib/bpf/btf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9f141395c074..0ab11be8ebc5 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -229,14 +229,14 @@ static int btf_parse_hdr(struct btf *btf)
>  	struct btf_header *hdr = btf->hdr;
>  	__u32 meta_left;
>  
> -	if (btf->raw_size < sizeof(struct btf_header)) {
> +	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
>  		pr_debug("BTF header not found\n");
>  		return -EINVAL;
>  	}
>  
>  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
>  		btf->swapped_endian = true;
> -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
> +		if (bswap_32(hdr->hdr_len) < offsetofend(struct btf_header, str_len)) {
>  			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
>  				bswap_32(hdr->hdr_len));
>  			return -ENOTSUP;
> -- 
> 2.56.1
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
