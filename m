Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425454;
	b=zUHibClwj9KmSTJCwrWRVgaLXqAxBkL2uOzbEARAf3AJVSMoCI1LwJT7pjfbjXFBKuxI
	 oa3Tk8Pcrh4H04CBXylpg2JKYfXfm7RUQTZh74WrRbvmKL1MP08bkhz8VQcZ2KvxGXMDE
	 evKnxrUAmNgHcaVlc8wvUEZOw8lWOMMuYB+CAkVbIdr7aLm3u95saHz0qX3sqKNR59Mk4
	 0m4crbkdubBRybPmfpv/u3s4ZT2PNeaO5BNuMY5ixQ+Yyoi5w41rIIqsdvvuwCH+gpyBq
	 xVBKxJEG0clJL3/NkZ5t+RUlnuVeyPJWTCpBV7p8rVq1jhk1kLnDcJ7ZIKJZfYo8mbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425454;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ElwxQXV69V07ZeUKRJboa14Xz3/tNiSouYX2pJvwG1o=;
	b=mEb+gPmrQRQcf91qATTr0oxnn1EXJCeIdAcbwGBJPJN8iM4TChFcAR+nHdqN2UW590v6
	 QfnIJoeaFcZZgO47Q7v+GPD/lBx3wLj3sZOCZ4hu6EDFA6dHbDkC3nUzWZFoDkHVsN7r3
	 AhRGH9ySUEwxpG9OffQH/zaqHRYkYrQrpRgkpXxTVX1QZD6JneB9vx2V9qDSxqDlgw1IO
	 0lDXBvWBrROH4pFW4esuO4YFqhAb74i0xg/8fJnLLrfAaI08TO5VboyUGm5g8iiWRUkUP
	 11ui9HHoS67FJNwoywxCGhLVMrYb9qFq+xNEkIjipjNjWehXrBw9ung4uihyxY6BtdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=ACN0oEy6;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B6606A683;
	Mon, 23 Nov 2026 09:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 043B6606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=ACN0oEy6
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5428414C2D6;
	Mon, 23 Nov 2026 10:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795425450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ElwxQXV69V07ZeUKRJboa14Xz3/tNiSouYX2pJvwG1o=;
	b=ACN0oEy6kHGPAYj2kayjdpp8gj2GkTrOA2AQUxOKeYmnUDHRWs3uwXKy66n0kBBJefQyQp
	9R7DKC6G7wIoRmoIeJFDyge8zKBeMK720UAllN5+OkdOxSBpIQnKXRLgGbgUSuZ/Du/amo
	soMoHx8vWj/hewpIjtJaaptWHP+jhFq+28hQp3AuCecA+qqhgmlcZhF+RKQl8fcCu8ILEX
	EdBxAb3tGw6FeVU4hfhSHVIiwj1ypB4tDIkxszYYYquBvo+ozhn6RqJ3fJe4QMNpdoLmwM
	5kCmeRdg7U78F8t4S+22AOqx9iy3BG1FL7QFq6wWLKackQ41xeevc3HtYD6Smg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5b02b061;
	Mon, 23 Nov 2026 09:17:23 +0000 (UTC)
Date: Mon, 23 Nov 2026 18:17:08 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	ihor.solodrai@linux.dev, daniel@iogearbox.net, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, emil@etsalapatis.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Alan Maguire <almagui@kernel.org>
Subject: Re: [PATCH 5.10-6.18 v2] libbpf: fix cross-endian build with newer
 libbpf
Message-ID: <awQElOwB_C7UzMXF@codewreck.org>
References: <20261116233301.1531563-1-asmadeus@codewreck.org>
 <2026112357-corncob-exclude-7266@gregkh>
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
In-Reply-To: <2026112357-corncob-exclude-7266@gregkh>

Greg KH wrote on Mon, Nov 23, 2026 at 08:01:33AM +0100:
> On Tue, Nov 17, 2026 at 08:33:01AM +0900, Dominique Martinet wrote:
> > commit 087f3964f4b3 ("libbpf: Support layout section handling in BTF")
> > added extra data to the BTF header.
> > 
> > This extra data is ignored in the native case, but when building with
> > different endianness the bswap code in old libbpf would check for strict
> > size equality, leading to build failures such as this when BTF data is
> > generated with a newer version of libbpf (through pahole)
> >     BTFIDS  vmlinux.unstripped
> >   libbpf: Can't load BTF with non-native endianness due to unsupported header length 32
> >   FAILED: load BTF from vmlinux.unstripped: Operation not supported
> >   make[2]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> > 
> > Newer libbpf versions also properly ignore trailing data in the bswap
> > case, but the patch is too intrusive to backport, so take the header 
> > length comparison fix from it instead.
> 
> Why not always just use the libbpf version from newer kernels?

I'm a simple user as far as this part of the tree goes, but the build
system uses two libbpf versions:
- indirectly, whatever was used to build pahole to generate BTF
debuginfos
- directly, what is in the build tree to generate BTFIDs from the above
BTF debuginfos (tools/bpf/resolve_btfids)

This build failure happens if pahole uses a newer libbpf version, that
the libbpf version in the kernel isn't able to parse because of a too
strict check in the cross-endian case.

Technically resolve_btfids could probably be built with the system
libbpf instead of the one in the kernel tree but then we'd need to
backport potential build failures instead if the libbpf API changes, I'm
not sure it'd be less work in the long run.


> And why not backport the full series, one-off are almost always more
> work over time.

Happy to send a revert of the above patch + full series backport if
that's what you/libbpf maintainers prefer...
In this case the current code already supports newer libbpf versions and
the bug was only in a corner case with cross-endian handling (e.g. I'm
not expecting further fixes to be needed in that area), so it seemed
simpler to just backport that part of the patch instead of backporting a
"feature patch", but I'm not fussy.

I'd argue that the cross-endian fix should have been a separate commit
instead of being part of a new feature commit in the first place, but
hindsight 20/20 and it probably wasn't obvious that it'd cause build
failures at the time...

Anyway, I stand by my opinion that minimal patch sounds better to me,
but just say the word and I can look at backporting the full layout
section handling code instead. Not sure I'd be able to get prereqs right
for very old kernels but 5.10/5.15 are gone next month anyway...

Thanks,
-- 
Dominique
