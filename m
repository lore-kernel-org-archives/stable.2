Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C863B776D
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785678900; cv=none; b=I3rd+09rjbmp/dKC7ZrXQEj/UoT43XvxqRm6AZI559Q8/KZLy5R8AOy7x7bqoMynDRcKW+kopzcsCtCO3J2vPbwnN9MSJFZuTiGt4GWiCvekM17MBD+L4GpwaIWNzx4czKj+rD3h4kn9weP4O2fcrzuLCXCCBLQ/mDOWD+QmzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785678900; c=relaxed/simple;
	bh=IOB/WfmqhRmkwDDdH0EXSEYltS2um3BGIGOdI7r3EaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOKwNjZ019voKK3DrlolgTIwP/sbhicDLMtudF5nA/Vbtvru0suJoPtfYgZbjNg0HP9E/3HiH5L50XQssDqpTS8+z+Pc+4aWYowhI+WKaOGYlf6HCIutpfr8hi6kM/2yRq9gfqPAdluMt2xKNQjausQGLK1R/AfbVolWsSr0tT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=nUozsqO/; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="nUozsqO/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1785678893; x=1785938093;
	bh=jswMA/xWAM4IlmqJdBTjszdMEWLqZ6QbpQBjgHnbAAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nUozsqO/DdWzjwNVYHVPT6NaRuVstVrAg+AqSVlhpQcmH86ovFSrPnGSZgrARnlJl
	 pT0vwkuFsfxqZPDf03y46WjnfCt9FHyoA7obSTgcw1TcjGsZTbI7Ui4qJBvzskmk4G
	 7wtWfwybxarOCinmrD5/dxCQbdiEyD/nWWkm7dyHzYRfs7BWEOTdKsE2y84VpqTgnz
	 r2lsue2BSBBZhP6JpaZgSQINIfJ6UH4rK6/Q9e3ie3FMoD/0Xb7+ZKhBvCOU1bdhos
	 Y/9JL/7U1TtLiHLBfy3W09D0B9EhO/iyk2EgBxIBOSvmCmRV6RSzcUzOZQ/+y4f5YB
	 PyesL3lbnBsKA==
X-Pm-Submission-Id: 4hChBW20q5z1DDrb
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Younes Akhouayri via B4 Relay <devnull+git.younes.io@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Younes Akhouayri <git@younes.io>
Subject: Re: [PATCH v2] rust: dma: return zero for Coherent reads past EOF
Date: Sun,  2 Aug 2026 16:54:40 +0300
Message-ID: <20260802135442.140218-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260730-fix-dma-coherent-eof-v2-1-8aff21054afa@younes.io>
References: <20260730-fix-dma-coherent-eof-v2-1-8aff21054afa@younes.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jul 2026 18:34:38 +0200=0D
Younes Akhouayri via B4 Relay <devnull+git.younes.io@kernel.org> wrote:=0D
=0D
> From: Younes Akhouayri <git@younes.io>=0D
> =0D
> Coherent<T>::write_to_slice() calculates a zero-byte copy when the file=0D
> offset is beyond the allocation, but still calls=0D
> UserSliceWriter::write_dma(). The latter rejects offsets beyond the=0D
> allocation even when the copy length is zero, so a debugfs read past EOF=
=0D
> returns -ERANGE.=0D
> =0D
> Return before calling write_dma() when the offset is at or beyond the=0D
> allocation, matching simple_read_from_buffer() EOF semantics.=0D
> =0D
> Fixes: 016818513936 ("rust: dma: implement BinaryWriter for Coherent<[u8]=
>")=0D
> Cc: stable@vger.kernel.org=0D
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library=
/topic/.E2.9C.94.20Possible.20past-EOF.20bug.20in.20Coherent.3CT.3E.3A.3Awr=
ite_to_slice/near/611677095=0D
> Signed-off-by: Younes Akhouayri <git@younes.io>=0D
> ---=0D
> Changes in v2:=0D
> - Use ordinary subtraction after the explicit EOF check, which makes=0D
>   underflow impossible.=0D
> - Link to v1: https://patch.msgid.link/20260720-fix-dma-coherent-eof-v1-1=
-d92685db8da6@younes.io=0D
> ---=0D
>  rust/kernel/dma.rs | 6 +++++-=0D
>  1 file changed, 5 insertions(+), 1 deletion(-)=0D
> =0D
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs=0D
> index 200def84fb69..556424b88fb9 100644=0D
> --- a/rust/kernel/dma.rs=0D
> +++ b/rust/kernel/dma.rs=0D
> @@ -1005,7 +1005,11 @@ fn write_to_slice(=0D
>              return Ok(0);=0D
>          };=0D
>  =0D
> -        let count =3D self.size().saturating_sub(offset_val).min(writer.=
len());=0D
=0D
Nit: I would probably just check if `count` is zero next to this line.=0D
=0D
> +        if offset_val >=3D self.size() {=0D
> +            return Ok(0);=0D
> +        }=0D
> +=0D
> +        let count =3D (self.size() - offset_val).min(writer.len());=0D
>  =0D
>          writer.write_dma(self, offset_val, count)?;=0D
>  =0D
> =0D
> ---=0D
> base-commit: 667d0fb32149f023b8b34a1f6f3d384556eafb5a=0D
> change-id: 20260720-fix-dma-coherent-eof-d0d08c91e013=0D
> =0D
> Best regards,=0D
> --  =0D
> Younes Akhouayri <git@younes.io>=0D
> =0D
> =0D
