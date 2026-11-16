Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819089;
	b=F8xyxHtRy/53uhi23mtI4fJ04CHw+DepU1f7HAEs+ma//9Pstd8AnFwD8eCL1NXyYzJZ
	 Om3Sap3Z78VBiWYMEyk/fDKpxtLI3+U6sXINzcx9rojoFM/eWpWAF892TQ2kvVNesfJVF
	 8e6jEwiRihcAxjit3v1URmj1yHufBu13o1MP6tLv4XZX6rVwHtqDx2zU121qWaFYIVzq5
	 rd/wZ+04Ub6hXVsBP8iAefn2VOm0m8Fz/drx4Wt/mklRQiXhjDciHu+OIjykgmjF3HPlj
	 7P9I5MnooOcn3d4T+3SlwJKOBh6+JmUWpoY7GaDa8LMHhjd8YKv8hed8D17Ml9BQAvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819089;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ACLCxlZdo4jn/v9m2NaMncu0yD18ZRXzPUQulAzS5AQ=;
	b=2eEbkQXh8/QWqvqyr2FydzJlbIR/dq3/iSLBB+tnaTMnFjw6Fe6pfMX4NbXtl9EtvXL+
	 +zmzlIinyGZ7rHhtHbJMOk0SeNl/1zI1Sm2DHcjt+ZVxzTUKBB2zUtpiUHKU57+tc/X++
	 Bi67Ju5eFfyAy59CMCTIeeV3eqDZf40RqoVmVxQD+pEcim0VdJDi5SxNseTkJoaf/6klk
	 9UrJhWpK0WpMkFHbOgWZRUQ9xiN4UE/0jZNFuluA+URW5qf2ViZnWf6/GZkWJBCyyHiZT
	 m1TlcJnxIl3FUkYI00LA0ILJ03cfAuPe5MKq2BxN7KbKrBefC1e0d484FqXDbpMiK1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VclwZr8Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE872606A323;
	Mon, 16 Nov 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VclwZr8Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAC21F000C4;
	Mon, 16 Nov 2026 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794819089;
	bh=ACLCxlZdo4jn/v9m2NaMncu0yD18ZRXzPUQulAzS5AQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VclwZr8ZCOVme+6P3kh47MSJXBrC1P3aNMCglm4oFUxakXYsi9+u/qBUpeZJDsbCP
	 yOq7oEA3QQiU7pMtc5yu5PpwPgupENN2+ogi9WC4bmSbhWxYO+h3I9oRe2KeWMjBT7
	 xZygWzoxUsPW+FNYjpTphNa3fCbrQabkm3cOOCgcrF7opYPdKHfIzhzKEbOLa8sy85
	 hpHMbZcFIHim+j6TGIIJCF/C06xYoHTnrMc+umxLSgpA62Lye3LvFEcUrCpfb5bLdM
	 uV7SggCskfRR+kgZMYoDBngq3fXQNB29DqCdIoH/T8WKoD1MHwdXmvwYfPzUi72opZ
	 b/9DZ3eJVr80Q==
Message-ID: <7a931778-2a99-4b33-8d1e-97f9b061fb02@kernel.org>
Date: Mon, 16 Nov 2026 08:51:24 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10-6.18] libbpf: fix cross-endian build with newer
 libbpf
To: Dominique Martinet <asmadeus@codewreck.org>, stable@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, eddyz87@gmail.com
Cc: ast@kernel.org, ihor.solodrai@linux.dev, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20261115200505.1494710-2-asmadeus@codewreck.org>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261115200505.1494710-2-asmadeus@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 8:05 PM, Dominique Martinet wrote:
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
> case, but the patch is too intrusive to backport, just fix the header
> length comparison.
> 
> Link: https://github.com/NixOS/nixpkgs/pull/570639
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> Hey,
> 
> we've got a cross build failure report for ppc64 in nixpkgs (link in
> commit message), that turned out as described above.
> (build broke for all kernels before 7.1)
> 
> In this case I believe it's easier to just fix the check than backport
> the full layout section handling support, is that ok?
> I've confirmed the build succeeds with this, I assume the reporter will
> eventually also boot check but from my understanding of the code this
> should be fine.
> 
> Feel free to throw this away if there's a better way, just let me know
> if I can help.
> 
> Thanks
> 
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9f141395c074..ae344cf58e85 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -236,7 +236,7 @@ static int btf_parse_hdr(struct btf *btf)
>  
>  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
>  		btf->swapped_endian = true;
> -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
> +		if (bswap_32(hdr->hdr_len) < sizeof(struct btf_header)) {

Thanks for the fix! A small suggestion; what about matching the upstream test instead; i.e.

		if (bswap_32(hdr->hdr_len) < offsetofend(struct btf_header, str_len)) {

That approach is a bit more portable as the str_len field was the last field in the
original BTF header, and it will work regardless of the size of struct btf_header.

>  			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
>  				bswap_32(hdr->hdr_len));
>  			return -ENOTSUP;

