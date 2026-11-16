Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830990;
	b=BMguBias6aEaVX0IAHCAMLbE0Jb72tMiaHM5hs6ZGgFGQgH4wfrvcAf/BwPVHVG0cDHk
	 xFWfUXxXAbdG/D4mZi0GwEGBjgG5r7PCvVSTNI1UFX25fCc1kf2KR3wzvpJmq1b7k7slb
	 7sPGDJo4x3HgaGOypHrMdhhj56rK4hB+LctVio1jBP9W7jDb6blRAW1top69c8SeiCGNp
	 9hAfdyzJcq26MyuntG5XjaH1Y7f0+hOesxsyykb1fEwNkrMNYcS0m49k00c1gbgkLnNHr
	 rdwFZuBmhpd82g9PoF5Z+NLSIrAFNOPEFhnl8/IDDzfX0m/XcqRrCXipc8udyCrARLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830990;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BMCz1hNWwH41FhMM7fMNO8ay6owivrEG/PE6EWZMGGo=;
	b=We7PgqW0Dv/p+kPiVtgWS23vJSxcRuI28Mw6p1Ruo0gG5yQNIhXlX+FmTzvJWoTl/B6g
	 oFJOBUtkxc7n48wl0ARwx7W5pNDgYZZ0wDMiNAOrzjSe5tETK6uT5RQxb1KSbls3WmtrX
	 ggDmH1rPdIEYGAcQj4NV5vfl5FfHPp8Ulizwsh0+l/K0lyc8Y81Zc3oNKh0woW9fs+jK5
	 1QVzYT8bgWVfZShJJxNrXmJuJFbCXbo3F7K95NEreFuSJOeMYHzOPYAM05jhHWL6wT1so
	 FKo0UglKL1CJOKlLhIIsHRTE7MtfciUmfF7vOBu/szRSS5g8XPMuQMgZul5HZiGFRhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=4Vws9uFw;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA9606A333;
	Mon, 16 Nov 2026 12:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBAA9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=4Vws9uFw
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5C4C614C2D6;
	Mon, 16 Nov 2026 13:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1794830984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BMCz1hNWwH41FhMM7fMNO8ay6owivrEG/PE6EWZMGGo=;
	b=4Vws9uFw3n5iV3nPEeYK7LfZ7GnOQG/ncYoUaNTyng3FqwKqHrCrTRyCp+Rva8gTkM7QOD
	tcd2zTtgJIXIcU1uNzgqpASxm3u3w9QzKNXnOZ4/2VdShLsqzIysH5lmNPiw9wW4jBWs0a
	rfBFFrx8t7/vHaYGxy9aO/jSiDn0PKQjFU9uRQArCXMyJB97rxQfqTCz1jJlrKMxnPOdqi
	wpK6jWnw8PTn7YmuLWbaM4t3HFQ6CHi7AQwpeqK8x4KvTjNgyWnbLbIo8f1iPccmobE3C7
	5wFFcVcH300B5NMYTGZvTrSWuIvptf1+6si5BzzbdqkeaN/DOB69v72IJyRUCw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d552fbde;
	Mon, 16 Nov 2026 12:09:38 +0000 (UTC)
Date: Mon, 16 Nov 2026 21:09:23 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Alan Maguire <almagui@kernel.org>
Cc: stable@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	ihor.solodrai@linux.dev, daniel@iogearbox.net, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, emil@etsalapatis.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 5.10-6.18] libbpf: fix cross-endian build with newer
 libbpf
Message-ID: <avryc0j9LwdUUGl7@codewreck.org>
References: <20261115200505.1494710-2-asmadeus@codewreck.org>
 <7a931778-2a99-4b33-8d1e-97f9b061fb02@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a931778-2a99-4b33-8d1e-97f9b061fb02@kernel.org>

Alan Maguire wrote on Mon, Nov 16, 2026 at 08:51:24AM +0000:
> >  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
> >  		btf->swapped_endian = true;
> > -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
> > +		if (bswap_32(hdr->hdr_len) < sizeof(struct btf_header)) {
> 
> Thanks for the fix! A small suggestion; what about matching the upstream test instead; i.e.
> 
> 		if (bswap_32(hdr->hdr_len) < offsetofend(struct btf_header, str_len)) {
> 
> That approach is a bit more portable as the str_len field was the last field in the
> original BTF header, and it will work regardless of the size of struct btf_header.

Thanks for the look!

I wouldn't expect the struct to change in stable trees and favored a
minimal patch; my opinion being that if someone does take the time to
backport layout section handling or another btf_header extension in old
trees then they can also fix the check properly...

I actually prepared a v2 with this, but then noticed the raw_size check
also ought to be updated if you want to handle struct btf_header changes:
---
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f141395c074..0ab11be8ebc5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -229,14 +229,14 @@ static int btf_parse_hdr(struct btf *btf)
 	struct btf_header *hdr = btf->hdr;
 	__u32 meta_left;
 
-	if (btf->raw_size < sizeof(struct btf_header)) {
+	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
 		pr_debug("BTF header not found\n");
 		return -EINVAL;
 	}
 
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
 		btf->swapped_endian = true;
-		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
+		if (bswap_32(hdr->hdr_len) < offsetofend(struct btf_header, str_len)) {
 			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
 				bswap_32(hdr->hdr_len));
 			return -ENOTSUP;
---
and at this point this isn't just a cross-endian fix anymore but
something that looks more like future-proofing, and with my other
downstream stable kernel maintainer hat (yay embedded systems full of
vendor patches...), I'm not too fond of these and would rather keep this
minimal as it's not like it would reduce further merge conflicts either.

But if you think it's better I can send a v2 with either the above or
just the bswap_32 check updated, I've checked it builds on 5.10 and
6.18 so have no fundamental problem with either version.

Cheers,
-- 
Dominique Martinet | Asmadeus
