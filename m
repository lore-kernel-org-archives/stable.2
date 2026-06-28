Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F13559F8
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782691171; cv=none; b=ItBhuz1676smyZ00Z5rMXO+33PwgSaKmJtejb9egJ222iTmuxj/pBUBokJvSfGGR+CTQ4vFErymrdeaoHJFBaAmay/fqLVbwVfg0YGiHHFg8RyMebdu0KrR93KaDXNNsT3PLxmWsISqDxxYYppwRY2dSlHfCnm9oJs/jYF6/a7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782691171; c=relaxed/simple;
	bh=+X29beL8jceJXITvoztr4tTvLSQMtz4F6zPcLg8gI+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPAYqZIwVvgfmO4GTzezuY7Ggjg9MSku7/vS+NkXVvXkkj+N2ZyXOn5CQjmQOhCS2d1Ix0pWNozvwbn0uaxHQKMyCeI0qdjEic9WzGpRXIUTq4IFQqsfe2xqrGn7/qjSJfdJCtHe0X/gtgPykK1GSXv4MQnzm/JcKDPsUHDt7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcO1G2Jd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcO1G2Jd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584811F00A3F
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 23:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782691170;
	bh=5BxjU6YMbsIbEPP8Up34hQGdUMRDmz7p9Kpyn6VnhUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bcO1G2Jd+lG0VgUiQ+Cl36/ls5d3pNzE91ggMhrNqCPHZzqr3SQUyN28g+AETzsmg
	 Jr2Kr/r/HaRJIrUOmti+Tt1dYBmkdtO1N+JILxbbIY1WAoBvm5Gzk+vGp4x9nyr3Dv
	 CAhJ6rHxqyN5orSy9mAEpeeVfaap5v4y7YywdJ7PYoCtafRqbc7RkyxublcmowbVDj
	 0LJk66hGIFqM1vZbUuQgEaWYVMF6ke4kwJQcW2ajn4B9/nG6fbYoIjbfTnfUFJRBvi
	 Er0D8pokbZrwsL3m4NLCWfjh2/yYHhq6VF/QMc8igANBhlyLAXibYXKvBxvoPAn+ao
	 ZMEoSaE3k+srw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-697bd41a4ecso3346959a12.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:59:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqux3/GMPm4OYnVnBcFFFJBUG6sZ4lPQmlNhfYpPecbgEAKh5NaAJz2qPeBYJ75YiV4mvQ0ZZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWQR2FBkPoTsZuNaY2lpWKiG53Lc99D9k2eEsmAkrBFNJZNhZ
	x3cINNFP4Z4V4hW+X7Q278m5oyb8yyskXROjRwESmqjRYaYsb5m9Q6eB0lKE8bqWZRMudGKNqZH
	5TtQjN4z8VxsNX5qlXqtvN57vDFPYLeA=
X-Received: by 2002:a17:907:cd0b:b0:c11:6550:d659 with SMTP id
 a640c23a62f3a-c1205f3be37mr836495766b.41.1782691166031; Sun, 28 Jun 2026
 16:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628074243.629589-1-chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260628074243.629589-1-chenxiaosong@chenxiaosong.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 29 Jun 2026 08:59:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9ijOdQJ+3oJsrLoup5Rg2Eq5WeCNb507dTETQRG8i5SA@mail.gmail.com>
X-Gm-Features: AVVi8Cf0sPCWy-XaLNfCMBa3oe_JB9NUEEeoK5uG11M5NseRdWKChykYk1P4A4E
Message-ID: <CAKYAXd9ijOdQJ+3oJsrLoup5Rg2Eq5WeCNb507dTETQRG8i5SA@mail.gmail.com>
Subject: Re: [PATCH] smb/server: do not require delete access for
 non-replacing links
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: smfrench@gmail.com, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	senozhatsky@chromium.org, dhowells@redhat.com, metze@samba.org, 
	linux-cifs@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 4:43=E2=80=AFPM ChenXiaoSong
<chenxiaosong@chenxiaosong.com> wrote:
>
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> Reproducer:
>
>   1. server: systemctl start ksmbd
>   2. client: mount -t cifs //${server_ip}/export /mnt
>   3. client: touch /mnt/file; ln /mnt/file /mnt/hardlink
>   4. client err log: ln: failed to create hard link 'hardlink' =3D> 'file=
': Permission denied
>   5. server err log: ksmbd: no right to delete : 0x80
>
> Fixes: 13f3942f2bf4 ("ksmbd: add per-handle permission check to FILE_LINK=
_INFORMATION")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Applied it to #ksmbd-for-next-next.
Thanks!
