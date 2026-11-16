Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845577;
	b=b3HiWL5+/hMoJedS9KZ1kEIc10vwrIG1phonCE1dXtCT3dnSCks7VEvvd7VJe96thX3m
	 gQv1fDeGR/iDL6x6fSINCq2pvJKuOpyAhqiygtuLqf6oAPs2sXZ6THuVSZK4FIP2e2f1X
	 eI5uhlUhgrLN2+0f0GPRCGWYcE3zSMYyLzFfOWUHfdaqRZHFPJ1PzW1E0eFEkhD8FAPzr
	 vNKaFIaJWwr13gRp6pxQrRbxfcNA2HGfPoirUhcjlTtYaHcdzZcoNVE6K6cZN+KhJ5qtW
	 h1sl72vyhlZ15MCHqT3vLj5nJvnqHElf+gmY5k8vkE/Ofhr+q7OHWonA/r1J4rl13Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845577;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=suChl27OKGiuh5BcLjNNgw2bXq7Ch2WUZFox//HhYTA=;
	b=YJ2bVk0CkEkOXnQDO/B8doO0qHVakghS4WPyQPX9CanGnplRGUOmItTBykkIBWj5iDn/
	 2aumCyRnOMkKs84faI6wdYALMbdjJICXOtezBZO72LAFo3weaWJVM1hvCHHL19gtTIXLl
	 gRRuB+nbCe4usGyvc+clEvk8b8TnsA0bn8B4Sx+Q2SZNz+GENI6KXaF4XsXztrqa1vQnI
	 QOIJmOC1K1T/8x08KFZxHPzlD4uHqVeqfWmTUX+0aYMi8fQDfpqpZNfZ+QNpZOmdBBVkA
	 pQszgFNAaMD1SfkS/+0xM1EAH373uf2HiTCBdMnvT3lkMPYNmi23Arpy35/Ie96qI+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OpAx/1s/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A1606A31C;
	Mon, 16 Nov 2026 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpAx/1s/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4081F000C4;
	Mon, 16 Nov 2026 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845577;
	bh=suChl27OKGiuh5BcLjNNgw2bXq7Ch2WUZFox//HhYTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OpAx/1s/5wH4OM5JjSJGcjlp72bx0oD0NP2bWzV3i4BQtEzUvm44I5J079IDTutdt
	 VAPdJQwqGcTqS8HyH6noAbfd7uXjEAShxv+UTL28yFHmeigvPsBc0yzUimPEhQDeNl
	 O9tyumg5tfADCHAvkrFJJPKhkgTharSkNN+h7JJmWaJuEJ4/29117IlP9dQk5uphUL
	 2Y6EuHkgatgou8xh7JKUdxFIc6uvmgcBQjeYiNnPuVG7j/uU84gb7tZw5AGTxOfSPm
	 alfdJFNPegx7rUgVRGWVwCsdj6leHMeWVTa7HAauFVqO+di6XoeVXXKNEJvG/SfGoe
	 Q6gByuRAe4KyQ==
Message-ID: <a1bb39d8-8a97-4b34-87f9-9d2639f27b88@kernel.org>
Date: Mon, 16 Nov 2026 16:12:51 +0000
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
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: stable@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 ihor.solodrai@linux.dev, daniel@iogearbox.net, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
References: <20261115200505.1494710-2-asmadeus@codewreck.org>
 <7a931778-2a99-4b33-8d1e-97f9b061fb02@kernel.org>
 <avryc0j9LwdUUGl7@codewreck.org>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <avryc0j9LwdUUGl7@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 12:09 PM, Dominique Martinet wrote:
> Alan Maguire wrote on Mon, Nov 16, 2026 at 08:51:24AM +0000:
>>>  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
>>>  		btf->swapped_endian = true;
>>> -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
>>> +		if (bswap_32(hdr->hdr_len) < sizeof(struct btf_header)) {
>>
>> Thanks for the fix! A small suggestion; what about matching the upstream test instead; i.e.
>>
>> 		if (bswap_32(hdr->hdr_len) < offsetofend(struct btf_header, str_len)) {
>>
>> That approach is a bit more portable as the str_len field was the last field in the
>> original BTF header, and it will work regardless of the size of struct btf_header.
> 
> Thanks for the look!
> 
> I wouldn't expect the struct to change in stable trees and favored a
> minimal patch; my opinion being that if someone does take the time to
> backport layout section handling or another btf_header extension in old
> trees then they can also fix the check properly...
> 
> I actually prepared a v2 with this, but then noticed the raw_size check
> also ought to be updated if you want to handle struct btf_header changes:
> ---
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
> ---
> and at this point this isn't just a cross-endian fix anymore but
> something that looks more like future-proofing, and with my other
> downstream stable kernel maintainer hat (yay embedded systems full of
> vendor patches...), I'm not too fond of these and would rather keep this
> minimal as it's not like it would reduce further merge conflicts either.
> 
> But if you think it's better I can send a v2 with either the above or
> just the bswap_32 check updated, I've checked it builds on 5.10 and
> 6.18 so have no fundamental problem with either version.
> 

The only risk with relying on struct btf_header size is if the libbpf
is compiled against system headers which for some reason have a newer 
"struct btf"; that shouldn't happen, and these days the standalone libbpf 
mirror carries its own uAPI headers, but just in case someone somewhere
is doing something unusual in building libbpf it might be best
to use the v2 approach. So for v2

Acked-by: Alan Maguire <almagui@kernel.org>

Thanks again! 
> Cheers,

