Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFDA455177
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774736; cv=pass; b=aBnErrZIGc2+BWihI9+kyBVU3IiCdL0YSk4oQ11a22GIazdWHRi73Bpe2apkCcJfDBgkngbUkweGjw+B1Vj47N93Z+vfWVUDhdyrkQdTFz9ngyjN8zix/7wAP2+fSGUeMNFBHX8z5hlzpnfy1+Zqzh0x/sB+zcm6jpAYeZGg6tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774736; c=relaxed/simple;
	bh=3xW3efaKmi9Dz9Vb0WuWLDIqg0HD53iZMVu4vjA+zeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbs2hb+zwkRkyoQeLwV0KiDrU+qpEL2aJ9Y5ybZOoJ22Pvovo90Jp/IpYMjK9vgrdfi089KDUg+CD0PMv4aJeMgt1Rapt2TcA5PAx9DOspNQTGqG5Va4lVZWwI/0+9bjJpTjuIYBom431JvxJ15DPhFiet2S+0d43E/DrRDo2LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyLWaHpM; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyLWaHpM"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b159850b16so3286027e87.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788774726; cv=none;
        d=google.com; s=arc-20260327;
        b=k8leqBLlj/OlsxkkTBlVKXEnA8+9Hr7kHVQ9X9UObJadR0DWuFamx77QTXNb+36p3k
         ks70ShyvBqemixuLYg/113pCkuSNY5+nlyjdplax5z5XhSrdhvG2945KaRxaskpvELRm
         ZocU+o/2fdlEoD6mdwqlERTvDrmCNZ4Zm4DHY6NZUmicguzvpp/YHiSxFTthHK1La0Wd
         Nwwh4U4zAKIYIGkfsXZDt3lLDtee+j5WG96/n+oOD+o+KX8rm870bhW3NwaLbBDbajPT
         GcXS+tFOPPTk/BW6JjCz/FEGkKVsVewHD9eakSynoy+MgAqzZiYsnMJ7tpO7CpWuehaU
         pHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZBjOJo7EwsCWCLDF7JfKkzJJNA5g3AFjMG4w1eSnQA=;
        fh=DOdogTWykBlTXb326gdGhC8oDyzitsa9Uab0U4IEUng=;
        b=XMrQ6IkcYQUcafth685lWBYkRYR/lxuEcI0lLL9IgW1EJyXxiTcE3nvTEef/KKGcj/
         Y4fD1jxPiLvOY/1AU8+Q00la4YRNKAPCbZYZU8NC/2jzTUA9RelnFMXyXQBQ4LVDoNuU
         B8yJp1/Np8NruPvzFdcO5eDIW2fXjaJS9lro9pNPfXgWjtagoqweP8YkooRsUGYqxNdE
         xwPe9LvDR/6aLAlY/CtxUjFWMhPFWn0zZy4pW82Q/Y6udWtA1hRx1sBpQDfiTM5VPVyI
         pP2nofhmdzbNkkAc6S0uNDASCbH0ekdnbl5AgPsl58lUOlsN+zEBIaATatbqxzxofilU
         e4GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774726; x=1789379526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZBjOJo7EwsCWCLDF7JfKkzJJNA5g3AFjMG4w1eSnQA=;
        b=UyLWaHpMcHWWHqSYlClJrAQlDUoEbk7+3jpxdWxzosZLQcgl9JTkhdf/MIVIbvZtjf
         GdyEfx8u7jx5EimIHPjLQ4EWBHGRkmOvE1XIUVKVIs2TEb/AHneSkXTxhiuM9mpYhBA1
         Qc4M48I3QbPHL/9QbCdiBRp7UvBCgNYLak7JcZkKIihoJ47feMEc3x912XlUdgPRjdjD
         uWxA5I490r0qxQvCE5z/fd9CkrKS1vPdGiTHti6OPVfbxO59ckxd5xlUHfaOsjZ5nnZv
         khmtDbL8xmwSRjyQ7l2Kbv0psATO7C5NwVu6R2+hN5DgpWMNx4XGaLbCB3Rlb3AoJpNt
         E0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774726; x=1789379526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZBjOJo7EwsCWCLDF7JfKkzJJNA5g3AFjMG4w1eSnQA=;
        b=B36cMOYFKxjAgG7W516n1SpEOmkjblsF6X5kvNPf8ef9bbCu+SiJEF+ln2qg6d5kBr
         VD/lZoLL0/CQnqGhaddvyMGAuwY2GGlit5S7zifB8eUtG5FB2Z4sjHg0rdCOPuM4PS6F
         eU2mRpyk6TYbrkk2r4N+cvcBmcXHCribO7uZ8HJ7HH3spLdBk0+e2B4GwiDx7ha9ORrb
         54LP7ELH9RUszXZKoea6Hu/d57v8MTnA3RhfSMukFivOSvGA8V/lLvnxpOhxLAFPmnVm
         PG9kI/lrgUx8KTsDNVEIEfSrZ2AO4nn6r4DzutxQrPeSqBxhuY5vkQnxYiMr8eJBzOCB
         PgoA==
X-Forwarded-Encrypted: i=1; AKwUvBwabk7mvQxngpuhGxXVYosJ3XQUJgTrRqeZjWLojRj99GI10GQhzeOV1dp9pKfsxna9g295wmA=@vger.kernel.org
X-Gm-Message-State: AFuF++l8j2ygp/oxtSc4Sy/cjX64+qyDxzoKJJGJthib/XR++kV3EDku
	+X26kxvg4Zm2dZ6xexR/9c+szjVUUKqMVI/X/jH9+KMVlS9L+SUfkWnVXE+BCnjhaq9FmPVEofI
	GXBSX8NSCYf/vwV/5ITMe7ztm08czxx4=
X-Gm-Gg: AYBFou2iPsH2SL1l0Su4CrS9dozdysdaWZs8i3DzKhM9b2vTwzS0csaPwATj6YNYVBj
	UD+e8rSyEpbmKBtn4v7Uu309PiaBF7NVWdkNrKMra0yiHpLwWSMrPuHDhr/E7rWhTi2vzmfm5hL
	DcWdcdqOIKokCJCAZlHnOGyy/NHkMZvSwoSyU49eZTamgo0oKle84JBMvibeooqtiAaGVK7C+nh
	SYeutdmmSqLtjH8woDghDfSJX42cTuQVBqXTrxh+9CPuZMNxbcp954F7PHYS+kYTLVm05hN1Mgq
	rXP8hfVH4IIshth40KrH5E4inRfxQ29vjsEWHpqRG3Wr
X-Received: by 2002:a05:6512:3c97:b0:5b5:e2e3:4dd3 with SMTP id
 2adb3069b0e04-5b616f325f9mr5904093e87.20.1788774726258; Mon, 07 Sep 2026
 02:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907035726.37123-1-zenghongling@kylinos.cn>
In-Reply-To: <20260907035726.37123-1-zenghongling@kylinos.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 7 Sep 2026 18:51:54 +0900
X-Gm-Features: AcwNN1W35E_APW41_zojqmd7aUw8N6t-AJaJP8-EqtmOcwckOy784z6QuVWrJKM
Message-ID: <CANFS6ba6VqnDTXeUzBPDEKTzVK7kMHLk-sitncT-oGToVQ0J6A@mail.gmail.com>
Subject: Re: [PATCH] ntfs: use fatal_signal_pending() for fallocate
 interruption checks
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 9=EC=9B=94 7=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 12:57, H=
ongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> The fallocate implementation uses signal checks to let a long allocation
> loop abort early.  However, signal_pending() also returns true for
> TIF_NOTIFY_SIGNAL, which io_uring uses to deliver task_work completions
> to the submitting task.
>
> generic/616 is an io_uring fsx soak test that issues fsx-style
> read/write requests through io_uring and calls fallocate() directly in
> between.  A pending io_uring task_work notification can therefore make
> signal_pending() true inside ntfs_attr_fallocate() even though no real
> signal was delivered.
>
> That caused the previous signal-interruption patch to return -EINTR for
> an io_uring notification, which fsx treats as a fatal failure.  Switch
> both checks to fatal_signal_pending() so only fatal signals interrupt
> the allocation loop.  A real fatal signal still returns -EINTR, and any
> other error still takes precedence.
>
> Fixes: 4dc8f4ee2d46 ("ntfs: handle signal interruption in fallocate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


--
Thanks,
Hyunchul
