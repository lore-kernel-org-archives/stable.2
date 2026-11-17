Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794926018;
	b=ruIRbY9OBbDxNiwtdZQGtsTqGCt/S9+fBSh/V4p0aklbYiM138aWXgK4qyzW0THXDBAc
	 7cIAHeDciEDmCS4+4F4yyqxzz7srVlmHbpeSKhDLMnzhPoIIWL3SUvC+N82JpBhTk2Yo1
	 VdrrF6x7HzP+PgTDQyrWN+LVcuDZtykzY3ptlpewcciBq8XiReRtjDQvAex2fkbYvk5LY
	 0aYiQD2YUcr1CRoyopNl1wuG6Bz/ffwKiVkpn9VxZY6wNMuvr26VfOaVPCPK72FUN1i5s
	 OiaYVVVv1edYM9bLf4hw/gvUgxo7XqIxevpzuABM6JxQObhOPE1E5dPo/tNadq6N5gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qYqqunDmmSSST3DA/CdKBNtQiNEx8lMxFK8nZ1VqJzo=;
	b=VtrTY3QcSIWmnfKcW9kmB8SahJnKBiM4NhBLWsFod83U/k6uJcqlktUDb0A5aOHqFl6M
	 1BQYS0EeAcys+QeD52e67USXAsz8XsJnCDJODXmiqoOGJv8Q7d2cnd9C0W/oNgc/4fXbH
	 JFMCDRMad4OAyiVG4xS+laDH3zV1dmHAGMCM/v9/YiuFzYn3TApFLytXbY1FiZN8d0EN7
	 QDjB07aSaOKtMIZe/YdHK+V1yFMMiI3FEMwfrL2yhY5YwKIHaMyujjHAe7xpuoSwTxX5c
	 Okc3VwfbbD/AV8O0RqorrlY0L2oRbILsdbrLjCMCG1C4Ts8hl7eBWPL+qmpte8aIorg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mNVNXfi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F8606A331
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827F8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mNVNXfi
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so622339a12.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794926016; cv=none;
        d=google.com; s=arc-20260327;
        b=gC9Z5mN4cKRiNqWeRgrpXMFXbjvL2Lywm9aMWTJLLj0SPHS0wE9earJ3w+L2+Gkg8Y
         u+NdWnhWF2Tjhxx+0nfPHcQ2zavjPfz9P9SJuEOS2bPcCH36jkDfrImVsjsaXxjbZi9W
         AITY6Py+xp/+qoUgmbWjiTSXrV9vgj+7TINbMxe5piOJvd9Z4qYG7NiLC1GmuuycC4EX
         xa3oxdskgqwRTOh1ehReKBGLsSznS9qPxGJnZ3W6nKDK92lWbj1x4/EFT1ruzYU3UyUE
         wF+WYG0vvmU9g5zSRB4fLx+B9/zaedGc0indbPqLY5t/ZsB2tPLQ3DQCWsC+Kn3yq22s
         VkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qYqqunDmmSSST3DA/CdKBNtQiNEx8lMxFK8nZ1VqJzo=;
        fh=0+Mgoyy3ME/mBeBBpdh+QoHC1apdNb7VyVnEKuS838g=;
        b=JJqVuXonR2Sebgb3dd+CudxOK7Yx4ttG44FjI4B8UYmcjmMEGk5tR2onl6dUFu0lyv
         cx96DnWJZgW0RXA35qww4Olgw24RrrsLHr9RQoVk04mjixrdZX44kvyjNUP5WqqGhU3q
         a4dTKHHfuaHQjhe1h50SQd5wqXJFEfBG6wDJN0Wbb5h5YAEppD4SVuXmU6Dj+xaYLfuk
         mtBl4TyNCiUnFKufn8EJqc5I5U5ko+IrmYGvSX5HphngWcWmUf2mzm/7ovI33TT24+yz
         YLssWkAen957nt4xKR+3hMbEZLMMdXurp1ZgsiMkiQ2i133zz+56zuibRaHQJNNLT6sC
         D61Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794926016; x=1795530816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qYqqunDmmSSST3DA/CdKBNtQiNEx8lMxFK8nZ1VqJzo=;
        b=0mNVNXfiQQ9XqB1g8J5uwr05zLt8Zy9JB1kORj6uu9v/Enc/dwdj2h+ayrhTSnTLAM
         mzSIM7IlSWTsQWSwG1nSKV+JX+YoMc50pW67PftdsGvCL2im4XdFKBZivszLqUn5ifMb
         iH3f2/7XZjvbWh1tovAcbMkickWuKZqmp0xyfK5/w6rP9fyMSHqn+X+uzyrboAH+kzxD
         Dvt+ZOisKHzi55lVGVTz8HWUpjQrVbOcU0sq5d7HwzKIGDihFUI2iwA5JEJ4wMzXO/BL
         2xs/lUipTtlGQNL9Gm4g6O+r0pYP7bLhEUwD/qTqeTMVCjDHNKwne3jD4ItWcO+ziZ4A
         DDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794926016; x=1795530816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYqqunDmmSSST3DA/CdKBNtQiNEx8lMxFK8nZ1VqJzo=;
        b=jIy28I4Dv3q/Nx01lMtqt3vrmvMyPEw8dIp4kXzv7WnHjcYM/RLj+LAtITNbDujJKm
         ciHgm5d6wTKGmt+rfknRkaQ+GdDmZpgc6rC+Xn70mdOjhw2wSNSuV0loHplnSiKG8OBA
         /2b7amZuom/9SOdzbuJUZOre22YyuMcXMlTlOYfqtI4rrqGMdwYqcMKKGiYCui9Jq3NR
         Tm0SWvC5lwOlubPx4m2vbIHZXRr8lQrTAv6LHRhrIL9HlbmX6XXdTJyxzCNsv7fzyX7u
         0DmlFtruU6mZ9rXDF+EijquF29K06GvQpfmWz7DXRqv1FfPedQgRjbvMHo1+zrW6Pf8g
         nHSw==
X-Forwarded-Encrypted: i=1; AL+hErGiVEHHYfrYNXP5KFlZUcCx8dD64qJv+JuHIX6aaWiwvg0nN0QYwiwmjLmaH437cO6Gg0FeqkY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kTNulDjogcDxXCGz2ibpj5zjr9HSSE1rf2eXYdhtS3ZSSat7X
	gSlWxmB6sCAARP0odFQdQQs4gSMxtmbFu3iDR6znBKiXIPvHHeITjgT59IoPuhVstr1frzJTY40
	VPXTnVsJVBYN1g7eaXuYkJEDstjaQ7X4=
X-Gm-Gg: AYBFou1ukcsgdWYDI5kba2rBYuQs6Ytk+dE3YdaqvyaRs5AYtxMb4PbVWJWpSIaDQhb
	6z506bM5Chqv0RqxG9FDoXxtJzVxbvO0R9TXbRUqSP7cjxRIbSyGdpL8qyFCkNn/j4szxFU/aFw
	yUFl23xCIjoWn/9q1F5wVkmJQHb8Ih/+Ek8USjtkH1pVGgiFpdUH6Nj2SKq1AY/86Q3iXZNwlgK
	zvq6np+ms2eSdgLP6SSjWT152MQBp4IMCcq+ENvqmoa6pJpHfbFkKa071BDZuzjZAvj1DnSSc9y
	qhT19TqOfAVW5J0Cme7QmPwYP0QRM4qMyFgwL5jtidku8xuBpspoghJvQ7s57sqFboUSgFu2tSh
	5rJ2NMpaDa4zgrgLv5TliNohGy7RLo3Dc9c6qd83+tzJ/i5HcsOyt+Buz/0hJ3/S6XcDkSQ==
X-Received: by 2002:a05:6402:c51d:20b0:6b7:749:4bff with SMTP id
 4fb4d7f45d1cf-6b7c0bc3facmr7573789a12.26.1794926015815; Tue, 17 Nov 2026
 06:33:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com> <20261117135146.3174252-4-graypanda.inzag@gmail.com>
In-Reply-To: <20261117135146.3174252-4-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Nov 2026 15:33:22 +0100
X-Gm-Features: AclHuK-oqTtDNy1F_dD-TE8gCQJwenfN41foadOCG31m2aii0fr_9cwaA2IqUTU
Message-ID: <CAOQ4uxjO-eQPk3OS0iCTRqyFgFSRtVMFywCiPdgWGHkmRBuAUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fanotify: copy full qstr length for copied event names
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:52=E2=80=AFPM Junyoung Jang <graypanda.inzag@gmai=
l.com> wrote:
>
> fanotify_alloc_name_event() reserves name->len + 1 bytes for each
> copied name in a kvmalloc() event.  fanotify_info_copy_name() and
> fanotify_info_copy_name2() use strscpy(), which stops at an embedded NUL
> and leaves the remaining name bytes uninitialized.  With the original
> length stored in info->name_len or info->name2_len,
> copy_fid_info_to_user() copies name_len + 1 bytes to userspace, leaking
> uninitialized kernel heap memory.
>
> Use memcpy() for the full qstr length and write the terminator
> separately, consistent with __d_alloc() and d_path().
>
> Fixes: 929943b38daf ("fanotify: add support for FAN_REPORT_NAME")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v2:
> - Use memcpy() for both copied names, as suggested by Amir Goldstein.
> - Write each terminator explicitly without reading past the source qstr.
>
> FUSE fanotify mark setup on a zero-fsid mount returned -ENODEV; the
> normal-name FAN_REPORT_DFID_NAME and FAN_RENAME paths were tested on tmpf=
s.
>
>  fs/notify/fanotify/fanotify.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index c25cf5c1fc70..2d6b5c2c6f25 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -221,18 +221,26 @@ static inline void fanotify_info_set_file_fh(struct=
 fanotify_info *info,
>  static inline void fanotify_info_copy_name(struct fanotify_info *info,
>                                            const struct qstr *name)
>  {
> +       char *dst;
> +
>         if (WARN_ON_ONCE(info->name2_len > 0))
>                 return;
>
>         info->name_len =3D name->len;
> -       strscpy(fanotify_info_name(info), name->name, name->len + 1);
> +       dst =3D fanotify_info_name(info);
> +       memcpy(dst, name->name, name->len);
> +       dst[name->len] =3D '\0';
>  }
>
>  static inline void fanotify_info_copy_name2(struct fanotify_info *info,
>                                             const struct qstr *name)
>  {
> +       char *dst;
> +
>         info->name2_len =3D name->len;
> -       strscpy(fanotify_info_name2(info), name->name, name->len + 1);
> +       dst =3D fanotify_info_name2(info);
> +       memcpy(dst, name->name, name->len);
> +       dst[name->len] =3D '\0';
>  }
>
>  /*
