Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911723;
	b=z2KCVVIjusQvpglYeLIfGoPZjATotdt1LgWVLvlUmQOW9ASbT78rG9KeFYCf9Jxm+OrW
	 zTwloBKQv8jMKiRTPfiRoLDuRVMTWhvruh7CAsuiOtnUTcNCuBXc7xO9OBXCZUYoy6QSX
	 /Y2T3CiBj7CzeQVLY1hL4TbR0qCjt7BbZVXC9vQ1u5beFpolQ7ZBUkTeWdQJwmI7XbIyz
	 aLSEzrEV1VEf3dfFxXNhqViXwNaml2PmL2sflhH0YSIkKB/Yztod+eYf5PlIdrbtol6vx
	 73hxLj7TR/KNdt1GrR3/TpofpIx12V4YApzVSRR51WozAXIxZxYoTLdPk+s1fpdwsZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911723;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IHGUzUmVk5oe5rUf0aoyRCacAxahSMOILQF7dcXB8Sc=;
	b=cu+hpc8yJ3j5pM94iKxmioUiTMDjdlrky7alVsWCIz9F/sEZRr5IoczzimB15VE/xjE6
	 9/x15WqiWtwC1Y6IoVEvIhq73WeOXo3lB+SCzjUZeG4WsTajeF0B1DqLP4D+oUPuIHCfm
	 96df4WHMop9N3vps4JEipn/S45RLIG38BDPd2TU7PePHY8L1HyF1o9yehHUSHrR2jboZD
	 8narVnVRMVgtoQ3Qm0PDmIYu7tV1TXzFteoxDFTnEdsuMkKARYjXGY0Z1qxGvkVQd1j0E
	 5X5N8AFm0TyRmkmA+rw5ei26ZhLpXaNhHnqithprsMuE7w6uNb2L6QVaNrRD2RXTp/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1lrPGZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDC606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1lrPGZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903001F000C8
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911722;
	bh=IHGUzUmVk5oe5rUf0aoyRCacAxahSMOILQF7dcXB8Sc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a1lrPGZltx+6LgllY7n+YDfYeHSA3UrljsIPJEnL3vb59HUx+Tdjo6qq12fOy0qRm
	 MdpJM/jJjcXgUEuQcquzspq0HSmFoOGARAI146Kin1drUQYRTIJnSL/osqIJQpf1HV
	 Ootc3EjbQZd+XwNpCl8StG1LEHPtnSyimhJCd4ea4/Gd+IshOvK1YJTrb77+CLuO0O
	 vQh/IKQc9VT1LfhiyLFBilO03YPNmyOnQevuMSaEUa1Ui9bc/f22ze5Nj6xe13Wi6L
	 gnC2mjfLQmfKeI4cU2kXtvTx3cbWsWqxNIY55DNRoe1QFYbrGTkPs2NKKMOLG6XuNY
	 Rdxaz/R1U6/7g==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5067a2411bso680185466b.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:35:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHO6TljPfjWVySN3BJqngRKW41BC6f6buFTdA2gJCA68fST9RUx5vI3XmipdqG4S6vH3yvMsOU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HuU25LARoo8n68qfrRHKC34SjJSVmeZh3upS4l/pugYs6Gsk7
	ITq+rcr4FsIVNm/mnR54CbwHkX3ngX9Kn9LgC77mpTydJgmQnGWUNcFRLO4k/P5LxfvdrkL16lm
	fOYy0Jo/ipzS3dj1d1tGoDKutZiBaHDc=
X-Received: by 2002:a17:907:3e05:b0:c50:475d:9804 with SMTP id
 a640c23a62f3a-c50963dd2b0mr1122566566b.13.1794911721220; Tue, 17 Nov 2026
 02:35:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117042341.4023597-1-hj351016@gmail.com>
In-Reply-To: <20261117042341.4023597-1-hj351016@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 17 Nov 2026 19:35:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd96-RaGbakDedW5eOgmV8JUhAF0_25qXLk2YimiT4wngw@mail.gmail.com>
X-Gm-Features: AclHuK_hFq9ocfYBKpY7Vyublut8aeIAWeKtr66oToFWJPZgIzp2Rcdnoj4Eya4
Message-ID: <CAKYAXd96-RaGbakDedW5eOgmV8JUhAF0_25qXLk2YimiT4wngw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: reject SMB2 read on a file opened without read access
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 1:23=E2=80=AFPM Hyunjung Ko <hj351016@gmail.com> wr=
ote:
>
> smb2_create_open_flags() maps a DesiredAccess that has FILE_EXECUTE but n=
o
> FILE_READ_DATA (e.g. FILE_EXECUTE | FILE_WRITE_DATA) to O_WRONLY, since
> FILE_READ_DESIRED_ACCESS_LE does not include FILE_EXECUTE_LE. The resulti=
ng
> file is opened without FMODE_READ, yet fp->daccess still carries
> FILE_EXECUTE_LE.
>
> ksmbd_vfs_read() only checks fp->daccess & (FILE_READ_DATA_LE |
> FILE_EXECUTE_LE), so such a handle passes the access check and reaches
> kernel_read(), which hits WARN_ON_ONCE(!(file->f_mode & FMODE_READ)) in
> __kernel_read(). A remote client can therefore trigger a kernel warning (=
and
> a crash under panic_on_warn) by opening a file for execute+write and issu=
ing
> a read.
>
> Reject the read when the underlying file was not opened for reading.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
Thanks for the patch. The same change has already been applied as
commit 2fd145f8865b ("ksmbd: refuse to read a handle that is not open
for reading").

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/f=
s/smb/server?id=3D2fd145f8865bb1a6c38a3dc68fa44290008789d8
