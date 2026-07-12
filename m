Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967F343890
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872181; cv=pass; b=mZ9cmnNM86biGC/7Waf5vmjo/K6PkUpSmAgaQXWIWFaYkzsPK9phtjTglpBMSXsozbCqup8NuZgPZb4srlkWVUw3oOg9zjOPS5jqmPgv6+kTeVC+gYvJKnoBh/dbzTU0y7zhDwTTKp8aBFbYuIqtcAyFq60pXGHQgKIg+059jLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872181; c=relaxed/simple;
	bh=NV2pzC7VYZUgEjsdZ1i1bIgl/fP0YBsfxQ2Ky/GbfuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu8JgIgIGux6/C7BT6EpA70JUbYqiNate7mQaFVkme4OPXRuYs7IENbbS18TJUghtnjBNJoZGd6qDZMkRszb05wCILYW5DxKLzGWtNMMXu66tnNp7RwL0/1dEPS2S03ITeffe64TQRZBqsEUnb6zSE98zvZpNq6MOWMQlREQgm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agttTwXk; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agttTwXk"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so17002196d6.3
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 09:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783872177; cv=none;
        d=google.com; s=arc-20260327;
        b=XTy7LiGKB00+u5ZqtQHxJjjz+9MRKV7FH7gi/6hVjx319Qm5k1sN7X4AyUmviyTzfx
         hhja1yBvEICWfKi/r4QFZrkJsrxvzLLazA1rfgrPZrYbX9bJQ1TQlox3e6V3EIVLgsEu
         3bI+1hhe9iMhEdYiqt9r2/m15NR+MuNZobtGcEdaEU+aTgD9pJAK2rJoOmDZh3ZHUI05
         mYluP/83AQHZm2IIvb5X1eUZEyFCT1o/GcSZq07M9YQfC4OzYZffR57xphRCMt8z6AXu
         XSyzquvmC5s8LUHG8oRgpiV+F4Ei4Os1tXMnq/LtfLNR6QUN7roshBFtSRxqzil8BaNT
         fOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tr/vLvyJLyQATf1/0yNI+vtyxOEwCi4r/Ln8QC3scXw=;
        fh=AaFGW8D/fDoQg6GxEuCvdJZn0kfSKXKI5lZfRCyuxD4=;
        b=LOrHpgkZUo2VSSzKGo7dm90KF24j1xgIb3M90YGtOfnC7rxA5sRNfnC2NqyaHU1M8f
         +eWDvSagUX/rKXje2YO8leth262SDgd2vZjOFge9vbZlNs3RTIeK6Ndazz0z54qguH9I
         OszkHa1j2UqBJLzCmNF5tp7do+GSIpFg54BRTCgZDp2yrf3R3k/4e68QqN2OrAtyhrnk
         q/FS7Fsgw+AFTsquuzcBXYjBFT00AYbz08gY1uA6hdh/8s+f5p1h/bMrza17tqbzi2Gp
         evmvKxxe1nNsKJThpWuV1yIxPTfCKl8mQACkOfg9fDkQdWVe19rgCTtROdlMGKuE5oW8
         xIpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783872177; x=1784476977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tr/vLvyJLyQATf1/0yNI+vtyxOEwCi4r/Ln8QC3scXw=;
        b=agttTwXk+CHWnQKEX6BVK0gbbZkeJxlXcywn04KcO8meHz47gEHyuFfyizieKdRdJB
         53ZbSaVGdkU16tIylTDm2adgigbEjpkRaoGNAhyyHKv4YVb3DSMeuJZXps6iaj1fXydL
         176B5ZipaGUTfE22NNkZpco5+TUe0YKI+6sCwRV24BNIpp3jA/qGZv2ST270AYDiVAA5
         XuMifUqMCF+lhwQamTmIfG6oRiLmnniFsog4tSDXTOv24izVUZI9Siq5FGl6Mfsu4DZa
         6o7o+SxbhVYPsBG2+kcJgzcv61Yfm0uvZcvg7iEKfgC/VVpgtKFEO0C2W+ln1KBAFeQm
         e9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872177; x=1784476977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tr/vLvyJLyQATf1/0yNI+vtyxOEwCi4r/Ln8QC3scXw=;
        b=sxBwb6kiML7q1uPQyKycsMOgS8jPYj+aWDBzWISdyR4lidzpe41aAPIUE+QiWMu7hz
         jk9OLZRRuQAm0ILY0rGqml/P7m4MkapipzsuXXS+6XUhkfJtCoioUxvQRUb8eYk4RviN
         LAej19cZmHmXwJlsbN9i8BTjFZDP43ukixm9WotaoF2wYZG98BNJn0Dd4wl1NNozeHEo
         JFaOv0OgqBhmcoxutt6M9ES72l63KAX9KpufG11gSBcW3E1+Dx/k8plqHWOrxnJpT9Pu
         5O+KmVMtHKvArH3WKeVSJEmTHmyJ8aQ2cnyAxRYm5Ee8M44mkoXl4bISb5aMF4C6w8Ug
         91QQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp18k8gisFyd0Nbs7Zyrf1LaP/noWH0azuJgqOoGWEMAhw+usD2bp0eHg0phrWuHqWBXHF4yeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1Di0MbBxfZIsjvDwQtzW3yn8yejGlxODHrXsuN0BtvCTFBmA
	qieQ/wyfRx+8ETlSJRV7MIMvu8pd73HkLRPrnliF78UDP6cBqh0etXuXJLAJKW+3wqHx5ilecxx
	D2btPsqt8iASaJxFuVSkWWBEeSAfz+2c=
X-Gm-Gg: AfdE7cn6ug2hWSr5R0sSc4B/Cge3ui2BFnV5FKpVwncRVaLa3F34Iy3oasXbI1I1c0i
	PRu/UfLXE0393aVnudr/wkViP01Qcm9XTBRYSJn/tWewvYO/e1gk1EP5C7WOvDbzcc8l1H/GMzF
	J5L7dSyYKnYt0Dez3lar+6PLTK2IL0vRBgwedi0t4qYTRochNjXKi6CylEPC20rYkxw+LHRG60i
	Mv9NIEPrxKJfGLCZasOWJ7zcIYz5v3pRSK9YQQeY6X1mZy2j4wf8SBl+nSCfNX14CfvGv394I+G
	3IbUAV5Hs8x1m05JHV94zI1ow48bdXWomxd10hut7kJjHAd5uW9zxEd+gcwzqENGRPGpWpDlkSL
	yWvWfyLowlTW2hrgpZodqtYu40uY+9xdQ1oJGTNs7RY6RbO3i2F+dLYCjH58parl1DHvP2+gdbw
	swnVm9qRo3KWY=
X-Received: by 2002:ad4:5764:0:b0:8ee:871e:f2e0 with SMTP id
 6a1803df08f44-903ffc6a7e0mr71122216d6.27.1783872177202; Sun, 12 Jul 2026
 09:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712025402.1804211-1-FredTheDude@proton.me>
In-Reply-To: <20260712025402.1804211-1-FredTheDude@proton.me>
From: Steve French <smfrench@gmail.com>
Date: Sun, 12 Jul 2026 11:02:45 -0500
X-Gm-Features: AUfX_mzobQXfLo_VGS-zoz-RhoQokIm1L5z1GziczB8gCLVn9ev0yz2U2TLZTFQ
Message-ID: <CAH2r5muSdTqXznPiv4iZbVBbWvGP6+TW5V76k8yCpef1biS68g@mail.gmail.com>
Subject: Re: [PATCH] smb: client: use kvzalloc() for megabyte buffer in simple fallocate
To: Fredric Cover <fredric.cover.lkernel@gmail.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Sat, Jul 11, 2026 at 9:55=E2=80=AFPM Fredric Cover
<fredric.cover.lkernel@gmail.com> wrote:
>
> From: Fredric Cover <fredric.cover.lkernel@gmail.com>
>
> Currently in smb3_simple_fallocate_range(), a 1 MB buffer is allocated
> using kzalloc(). Under heavy memory fragmentation, a contiguous 1 MB bloc=
k
> of physical memory (an order-8 allocation) may not be available,
> causing the allocation to fail.
>
> This failure was observed during xfstests generic/013 on a 4GB RAM
> test machine running fsstress:
>
> fsstress: page allocation failure: order:8,
> mode:0x40dc0(GFP_KERNEL|__GFP_ZERO|__GFP_COMP),
> nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x5d/0x80
>  warn_alloc+0x163/0x190
>  __alloc_pages_slowpath.constprop.0+0x71b/0x12f0
>  __alloc_frozen_pages_noprof+0x2f6/0x340
>  alloc_pages_mpol+0xb6/0x170
>  ___kmalloc_large_node+0xb3/0xd0
>  __kmalloc_large_noprof+0x1e/0xc0
>  smb3_simple_falloc.isra.0+0x62b/0x960
>  cifs_fallocate+0xed/0x180
>  vfs_fallocate+0x165/0x3c0
>  __x64_sys_fallocate+0x48/0xa0
>  do_syscall_64+0xe1/0x640
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  </TASK>
>
> Node 0 Normal: 3375*4kB ... 7*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4=
096kB
>
> Since this scratch buffer does not require physically contiguous memory,
> switch the allocation to kvzalloc(). This retains the performance
> benefits of kmalloc() under normal conditions, while gracefully falling
> back to virtually contiguous memory when physical allocation fails.
>
> Fixes: 966a3cb7c7db ("cifs: improve fallocate emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
> Tested-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
> ---
>  fs/smb/client/smb2ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index d4875f9532b4..55b53bb9e3fd 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -3595,7 +3595,7 @@ static int smb3_simple_fallocate_range(unsigned int=
 xid,
>         if (rc)
>                 goto out;
>
> -       buf =3D kzalloc(1024 * 1024, GFP_KERNEL);
> +       buf =3D kvzalloc(1024 * 1024, GFP_KERNEL);
>         if (buf =3D=3D NULL) {
>                 rc =3D -ENOMEM;
>                 goto out;
> @@ -3652,7 +3652,7 @@ static int smb3_simple_fallocate_range(unsigned int=
 xid,
>
>   out:
>         kfree(out_data);
> -       kfree(buf);
> +       kvfree(buf);
>         return rc;
>  }
>
> --
> 2.53.0
>
>


--=20
Thanks,

Steve
