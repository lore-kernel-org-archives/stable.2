Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087649;
	b=haM2wo+0hAXDH/+sMQkClTjsrArJ9mSHfhLRj4AQakAd8K/5FGtAZKxsT+R83F1I+vJ1
	 3WrVgPEO590F7D962n45cN4iEAFP06euWfPLa7RV3o7+PmW+eUbowRybMidNdLJ81cVxW
	 AJXeD55WmTViDFCW77W2C/6KRHG185aeCUsByynOfbY19mYpeXZyz7XA+7MPLoxAZXehd
	 KXZWfSs1ADTiRdELQgsyXKHHjahyNTlg0rmb+XPPahxNV4qeYQ1IJq69CO7NpQo4groKX
	 1IOM9pchNUWBcY2EZT1tB03CbigsHdeuyiDyfIZjP5w4SVKBpOUFYrh7KUe/KD5AYtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087649;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0oDGQwRIzZ1kh/O3TNYwsXtJd0AFwQ/AC6ViOWCRFEU=;
	b=1EbgO61LVXM0CgsIddMN3OHVPtuyDyYPg/GL0hkiIrAvU9qoHP/ht2TgtuaBfpVd4INX
	 0o+yHYdOPRGbiwjNvQq+H7aRl6yVCoc0Qj00iAx5nPk/MbkyjphUOwRx5d3XTO5asE0+x
	 9G/6LvnzXwuJ4rrdov6oYUIZsb74Vi3ISiXA2r2do9f9515izDlfcpjCNoO+n48nmvHIP
	 Qo6vMrkCJEUjldMUDhhN7SeVbS/0c+F2h4k1sMAwlGr72AMEYVusShyTauo8G7kLfiy3y
	 ViHEEH5dfTFmhBu/5PJIPHL1i+Cll5zN9a1gK1HOD5dwdk6cw3cfuDA73KihdKZXu/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JAyc/+x9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DC606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAyc/+x9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA6B1F000CB
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087649;
	bh=0oDGQwRIzZ1kh/O3TNYwsXtJd0AFwQ/AC6ViOWCRFEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JAyc/+x9fhaY++SPy1B5qiWWMZ17V5JOJCCuHc4FiXy07YwpUNHjdIGU9jSvnU9LH
	 3mMjOyIkFeKAtKcltA7Yd2HrpMK3rrhrZNEPWGOxFz2Vc0+6PqCOQ4wN7z1RF5KMlZ
	 +bFFM0NNOGmRk055kx6GUBRbuPnm6OpFHmUhlCppwmzqiZjWb8DxhNi7l8glO12yZQ
	 183nvg/MedDglLLHQTSSE1SfYgvlfhc4pHBFhDT8l1y7tK1u4gmW3KeLWdiiUkg1/H
	 Ak5WT5q8xFO1p/Z8kR+J93f0wUJpkujBKkTUZuV6Csijz3Sn561J99YqUe/M7YuES/
	 T/UGxn5wkVMEQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c247f6687dcso321525566b.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFOG5uqeuevGzLnlbUeWTZepYFgl1nuLkJhnbyH03qRmfjkkDsvU98v9gtK6HyDUw8yZAJ81rA=@vger.kernel.org
X-Gm-Message-State: APuU4Z971eCOd1M4qGNgQNwdybY/krtSrPgzienk7jDA+MaSAfI4S1tY
	OUVYG9GUpvhSta6d6tcDIpzu38r1SyOldgOUMDxIMCFfh8jdgLQqfkbwfjDHIdI8cfNDlz2BEDL
	0A2z/pD2G12VGjACpxcqDfRvF9A5Qdco=
X-Received: by 2002:a17:907:2d24:b0:c42:4750:8d33 with SMTP id
 a640c23a62f3a-c510e3a5becmr546933666b.28.1795087647858; Thu, 19 Nov 2026
 03:27:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119065107.115679-1-icb@fastmail.org>
In-Reply-To: <20261119065107.115679-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Nov 2026 20:27:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_NMZokM_wEENdc9XU5Lat0BRE4zQQwhz=07kfOao0R_Q@mail.gmail.com>
X-Gm-Features: AclHuK-ovNV8R_ey0_bL4KpoanjusJe8xpgZrWVAg7tcKtx7oUwEJK6mXpxPH1Y
Message-ID: <CAKYAXd_NMZokM_wEENdc9XU5Lat0BRE4zQQwhz=07kfOao0R_Q@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: fail SET_INFO when the security descriptor
 cannot be stored
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 3:51=E2=80=AFPM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> SET_INFO reports success even when ksmbd cannot store the new security
> descriptor. The old descriptor has already been removed, so the file
> falls back to POSIX permissions. Deny ACEs in the new descriptor are
> lost. This can happen when the descriptor exceeds the filesystem's
> xattr capacity.
>
> Return the storage error to the client. Report -E2BIG as
> STATUS_DISK_FULL, like -ENOSPC and -EFBIG, and report -ENOMEM as
> STATUS_INSUFFICIENT_RESOURCES. Both errors previously fell through to
> STATUS_INVALID_INFO_CLASS. These mappings apply to all SET_INFO
> classes.
>
> Preserve success for filesystems that do not support the xattr. Also
> preserve the best-effort store for CREATE, where the file has already
> been created.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
