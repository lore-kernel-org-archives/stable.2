Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBFF4183A7;
	Fri,  5 Jun 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651008; cv=none; b=CFBjtzaWvv/h3jpud4Zyp27LssAObmrFGUUJX4QvbDq4w3094ICylRS0tMmkarNq0SBg9HecTNijYLumc+Di2lmqVLOgeVVYjocm50F9e/isiOds1AEok1yOpdwhyMnKhF9vQhkKJ3EKQv/NVQQwkkRfCf0onSklPX/KcBftibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651008; c=relaxed/simple;
	bh=AkgUWGZkUVsVf7+t/8M3b6jpxqCom0DmtzVegaSQkXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oy38V/8p3sw6ZbmSACBU/lK2CxsYKyH5IJ7fzzpYQJWtMcvaYXXodL8FxDl4F+WUQcrY+RUIK1Zoo6/hBqL++yMbejfZd1VxWAUw6xMSWm6z1wLdWymgNHWKe66ymN3wMF3i3h8uMmwzTv0sCzs3kL3kqHx4yC+oTGebToeP2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Oo3fYQnL; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Oo3fYQnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780650997; x=1780910197;
	bh=/xY5EtVoI/QL1ZLgCsbM6h32E0Qy+9GKKtlzGcWJLAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Oo3fYQnLEkd5QO4BE6HYXsxGF2gjwgBMJH/MsLhV+1GDoKwWsRXE+hgqYIPam7m7e
	 Y2LyJV9RNzBO/Ii5cWZa0dZxa8KfZY5IcvA+ayeYP2CaGcAahdaZVgwQHaNi6/MXWk
	 LBR4Drn9kvalGgg41JDU+dlTDt+FJiQoOCgVznlRxLTJLUuGIVpctOKKevsLBtwR7v
	 LIt5ETyT5qNGAlpCd4VpStAHf2Tr7BZp1A1OcrlkL43uyGvu9uoQuxM+MusQkpBttO
	 G28ZQUVKLzouTMvxzTydXMa4PcJl06qr+fppD3SaNoyV1zOvZagc1XW9ig9lfnT0O6
	 bbTSs5Avg1uJQ==
X-Pm-Submission-Id: 4gWwmL44rLz1DF7D
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Gary Guo <gary@garyguo.net>
Cc: Yuan Tan <ytan089@ucr.edu>,
	ojeda@kernel.org,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org,
	zhiyunq@cs.ucr.edu,
	ardalan@uci.edu,
	pgovind2@uci.edu,
	dzueck@uci.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: firmware: return empty slice for zero-size firmware
Date: Fri,  5 Jun 2026 12:16:31 +0300
Message-ID: <20260605091632.313084-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DJ0YRJ6MHAU7.WVR4P2MQ4HIX@garyguo.net>
References: <20260605041134.38290-1-ytan089@ucr.edu> <20260605071104.135675-1-work@onurozkan.dev> <DJ0YRJ6MHAU7.WVR4P2MQ4HIX@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 05 Jun 2026 09:13:55 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Fri Jun 5, 2026 at 8:10 AM BST, Onur =C3=96zkan wrote:=0D
> > On Thu, 04 Jun 2026 21:11:34 -0700=0D
> > Yuan Tan <ytan089@ucr.edu> wrote:=0D
> >=0D
> >> Firmware::data() builds a Rust slice with core::slice::from_raw_parts(=
).=0D
> >> Unlike many C APIs, from_raw_parts() requires its pointer argument to =
be=0D
> >> non-NULL even when the length is zero.=0D
> >> =0D
> >> The firmware loader can represent an empty firmware image with size =
=3D=3D 0=0D
> >=0D
> >=0D
> > I haven't checked in detail yet but "empty firmware image with size =3D=
=3D 0"=0D
> > sounds like an invalid image. Can such an image actually make it all th=
e way=0D
> > to Firmware::data()? I would be surprised if the loader accepted it.=0D
> =0D
> `kernel_read_file` will return EINVAL if file is of zero size. But I thin=
k the=0D
> decompression path might produce this? The zstd code just does a=0D
> =0D
>     out_buf =3D vzalloc(out_size);=0D
> =0D
> which will trigger a WARN but still return NULL.=0D
=0D
On NULL, it immediately fails with ENOMEM:=0D
=0D
	out_buf =3D vzalloc(out_size);=0D
	if (!out_buf)=0D
		return -ENOMEM;=0D
=0D
Thanks,=0D
Onur=0D
=0D
> =0D
> That said, I doubt any valid firmware will be just a compressed empty fil=
e.=0D
> =0D
> Best,=0D
> Gary=0D
