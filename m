Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D895372B5A
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788822019; cv=none; b=a/WIcrDvmSEFOFLl7MHKQ3Mw4xsqsy+rHvNKdrQc8hBvACnP/KUnhqrSmsIzxRee1V69uuiQHaw+cGRCRAEwajdPOwMJ/ZGzd6BQTmDtLq9O7tjbdhrmjg+U0/sK5NnLO7S+pYKXLfTjdmd8HeIV0uTe0aN9fmW3nydaP3UBXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788822019; c=relaxed/simple;
	bh=LAl4kP0EIKlfl5zzSSLqvsqH7L5V5krRf2vXXXOvupk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIvxRx++nxKA/h1g0NHlBTojwooHfQXAts3N7MZpkjo8cklXFOu4GXCkMEOyS/1v/4NOdjC3V2jAaz6b+zFKtlzaHZ8wg5V6w1NKhlcVKBt94lNWzCGsLewtOuSdMAqj7ps7w9V3PXEoIgkxTEOgsScitlAzDiFSueTxxaIVm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5GWmLZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5GWmLZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64FC1F00A3A
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788822017;
	bh=xWL6hggeuM5eeHa9vvklWW/Gt5aWnBuf5JmY/Tusxyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T5GWmLZ4oHi/Kg/BPltLAoP1yFSJMtvtAQMyt6fR5iOcD9ErKrfqYDBFA28psDETq
	 /roUOdPs6pSOIfJB1MgWQuofjOv4+HJ4F+o3uu+KRZ9hfBvQlVqBm0hBCOHDCsBNgj
	 N4AbNG7LwPyNqE30IX/UYApZihSH3od3mzeo/VCtpz2aI9hE0229D3HQIlcZ+0M3LI
	 Fo0at7USs/jxx/xqVL1Rchf2LVdEuG4SN51AH1YBxlzg0mDVlLkCuKL6j938MQmGik
	 1m1ZLUnLUZ/7omdeJv/oqD5i0WqEIlqfpvx3Anqso/DtN/Y4kk41ofaaFKJO9xNipn
	 49mNx67hjGvBw==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591bb13so367026a12.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 16:00:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByi+Z6nzlKQbnUpQHYUlWMVtGL7MOQhLKOetr6sN8ZgOaaIhjkGrTfBF1E6BjdtrkqcYOj3Bec=@vger.kernel.org
X-Gm-Message-State: AFuF++n8i25dDPfRoE38V7wzErbL+rCYyWOu1csZBFnBB7mZM3Hv2l5R
	j9UrXkZUKIvtxdkfFLMe1qX9pbDwYzlyNeDDWqKX+uvTsk5oJFSiQUmhK9TyrDHsFTi6CJceYwN
	R1tEzl5Mho9LRxN+tEpofCOQ346aJtuI=
X-Received: by 2002:a17:906:f597:b0:c26:3377:752b with SMTP id
 a640c23a62f3a-c29042b7343mr148355566b.3.1788822016616; Mon, 07 Sep 2026
 16:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906200517.725015-1-pc@manguebit.org> <20260906200517.725015-4-pc@manguebit.org>
In-Reply-To: <20260906200517.725015-4-pc@manguebit.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 8 Sep 2026 08:00:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8VZxLKDt8r-tg7DWEXWV=kOqKot=PSafoYcWpOv-cR=g@mail.gmail.com>
X-Gm-Features: AcwNN1U545zolvnjOPnYuXOAZy_ZzNwywL3O497r_OFSvmYawzMuk1ocV4hvfcI
Message-ID: <CAKYAXd8VZxLKDt8r-tg7DWEXWV=kOqKot=PSafoYcWpOv-cR=g@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()
To: Paulo Alcantara <pc@manguebit.org>
Cc: linux-cifs@vger.kernel.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 5:05=E2=80=AFAM Paulo Alcantara <pc@manguebit.org> w=
rote:
>
> cifs_posix_to_fattr() ignores the return value of posix_info_parse().
> When a malformed POSIX directory entry is encountered (e.g. invalid
> SID lengths from an untrusted server), posix_info_parse() returns -1
> without populating the 'parsed' struct.  The uninitialized stack
> memory in parsed.owner and parsed.group is then passed to
> sid_to_id(), which processes the garbage bytes and passes them to
> request_key() to construct a SID string, potentially leaking kernel
> stack contents to the userspace idmap daemon.
>
> Fix this by checking the return value and skipping the SID-to-id
> mapping when parsing fails.  The remaining fattr fields (timestamps,
> mode, etc.) are populated directly from the 'info' pointer so they
> are unaffected.
>
> Closes: https://sashiko.dev/#/patchset/20260906172005.627163-1-pc%40mangu=
ebit.org
> Closes: https://sashiko.dev/#/patchset/20260906181540.647469-1-pc%40mangu=
ebit.org
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: stable@vger.kernel.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
