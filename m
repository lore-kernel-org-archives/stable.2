Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9153BBA1D;
	Sun,  2 Aug 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682291; cv=none; b=VmUOD3BUNoJpD03kEB8xSlVNf5OXCK2jXU2HqE1V93iMKQmbDt8UiKEYOgOd8u4LNUB/Wf3qKiKOzYzlhu9yHNZhQKn6QIr4dJPTVqL5ccQFFJmlZDnTAMi3ys6l2LWvW5YCoN/ysUZ88+wQ4/gLBWmJeZrMxyj2tmPDx2UU15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682291; c=relaxed/simple;
	bh=duBOXC/XHVmcb3qVMrIECM0ImCToqBvbzc/TTZBVEkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBVQ9GQzawcjDZJl/uEntJquTofRXR680sn8K+cGhDoSQQVbUbGjU4fUhV4hzewb17ioSP6giXZ72j6Ny7L6kT1je4SVXCB3ophrrYGfRetC7ia8CaI+4U4XojK5VFAR/VB1CR074BIY1LQA+KJkebj3Zl43sy8J0TgBKcl/uQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=eQJY7dzO; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="eQJY7dzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1785682283; x=1785941483;
	bh=efomfhmpRhT0LBa1wq/DR2bDSkQvnvlrQVUGpeana9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eQJY7dzOKKsjFCCObSHPdBfB0G7RLxZnQ4SoR93cashMShqVnWVl256Ij/yPOs9Fh
	 hE+m2L9Iv4tusZTd0Kd5+eqQ3oPAaB8F+Pa9104eU7Wp+QJR0BDs0PxcTxZg7ShDC4
	 26ZhfliCGocvLAomkHM6A0GNlRBo5xwqW6q/xgH1quYC0HXoavwYlygYaQbLmiYNo1
	 4SAEejypMTRn+3/h11At6YJOVFfi1M1eqo0U5Wzsx9M6HKrqXt3o7QsL/wZG+X++rh
	 YInyUbQ4PhV2WHXXD7i86TZdDfMfbZR3e41n3brXFoaNiVAmCApjfg4oDPmp4evzFW
	 B81Hb+BGNQdlg==
X-Pm-Submission-Id: 4hCjRq4Xz4z1DF5G
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: Younes Akhouayri via B4 Relay <devnull+git.younes.io@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
Date: Sun,  2 Aug 2026 17:51:17 +0300
Message-ID: <20260802145118.236139-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260802135442.140218-1-work@onurozkan.dev>
References: <20260730-fix-dma-coherent-eof-v2-1-8aff21054afa@younes.io> <20260802135442.140218-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 02 Aug 2026 16:54:40 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> On Thu, 30 Jul 2026 18:34:38 +0200=0D
> Younes Akhouayri via B4 Relay <devnull+git.younes.io@kernel.org> wrote:=0D
> =0D
> > From: Younes Akhouayri <git@younes.io>=0D
> > =0D
> > Coherent<T>::write_to_slice() calculates a zero-byte copy when the file=
=0D
> > offset is beyond the allocation, but still calls=0D
> > UserSliceWriter::write_dma(). The latter rejects offsets beyond the=0D
> > allocation even when the copy length is zero, so a debugfs read past EO=
F=0D
> > returns -ERANGE.=0D
> > =0D
> > Return before calling write_dma() when the offset is at or beyond the=0D
> > allocation, matching simple_read_from_buffer() EOF semantics.=0D
> > =0D
> > Fixes: 016818513936 ("rust: dma: implement BinaryWriter for Coherent<[u=
8]>")=0D
> > Cc: stable@vger.kernel.org=0D
> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Libra=
ry/topic/.E2.9C.94.20Possible.20past-EOF.20bug.20in.20Coherent.3CT.3E.3A.3A=
write_to_slice/near/611677095=0D
> > Signed-off-by: Younes Akhouayri <git@younes.io>=0D
> > ---=0D
> > Changes in v2:=0D
> > - Use ordinary subtraction after the explicit EOF check, which makes=0D
> >   underflow impossible.=0D
> > - Link to v1: https://patch.msgid.link/20260720-fix-dma-coherent-eof-v1=
-1-d92685db8da6@younes.io=0D
> > ---=0D
> >  rust/kernel/dma.rs | 6 +++++-=0D
> >  1 file changed, 5 insertions(+), 1 deletion(-)=0D
> > =0D
> > diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs=0D
> > index 200def84fb69..556424b88fb9 100644=0D
> > --- a/rust/kernel/dma.rs=0D
> > +++ b/rust/kernel/dma.rs=0D
> > @@ -1005,7 +1005,11 @@ fn write_to_slice(=0D
> >              return Ok(0);=0D
> >          };=0D
> >  =0D
> > -        let count =3D self.size().saturating_sub(offset_val).min(write=
r.len());=0D
> =0D
> Nit: I would probably just check if `count` is zero next to this line.=0D
=0D
I just noticed there is already been quite a bit of discussion about this t=
opic=0D
so you can ignore my comment since it was just a "nit" anyway. I don't thin=
k=0D
there's much difference either way, so there's probably no need to reignite=
 the=0D
discussion.=0D
=0D
Thanks for the fix.=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> =0D
> > +        if offset_val >=3D self.size() {=0D
> > +            return Ok(0);=0D
> > +        }=0D
> > +=0D
> > +        let count =3D (self.size() - offset_val).min(writer.len());=0D
> >  =0D
> >          writer.write_dma(self, offset_val, count)?;=0D
> >  =0D
> > =0D
> > ---=0D
> > base-commit: 667d0fb32149f023b8b34a1f6f3d384556eafb5a=0D
> > change-id: 20260720-fix-dma-coherent-eof-d0d08c91e013=0D
> > =0D
> > Best regards,=0D
> > --  =0D
> > Younes Akhouayri <git@younes.io>=0D
> > =0D
> > =0D
