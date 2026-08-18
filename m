Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915F44236B
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076537; cv=pass; b=Tr4cZ2NJyW6SQPP4v8viw95ytZRmuliqfFoUJP3eU09dXn1KSP7yAcZegdeoMtIs+0iCJFzg9DYzkpA/YxXplbSS56txRCUovQU5kWsJrRIeSPOxUdYzOGxigQq5Lc17Og3eVBoPgFLxCX3jtNnZbo13yeWPTlm2aRKE+2s2cH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076537; c=relaxed/simple;
	bh=SEUySfRaQtbQd7ONSCax+h6nByvImRHhLqI63bO+18Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNUiOOucIt5V7tNXTeR7bATMU1z2lk713lEvcrj/Y3EKerKIp2DbmsphsIX3oLeVA9YznL7zWRwELieBcn8EEJ+DbtzA1/KrueDVcQLNINiPHHdYFdafuLN0tlVk8RJblqRtmuXdr3nXsDQ0wuLrJjVkOijLcuES/JamTznidGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkdlVUgl; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkdlVUgl"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836eac5682bso1373767b3.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787076535; cv=none;
        d=google.com; s=arc-20260327;
        b=RSuIlMIuBBUWCFIv39LBlWIjX/jfodH1OWutJGo31ThqeBFEceD1ycIbKF3RsTLZeh
         O0KLp3BpCeZ4EbEeGOfyJxT65niYzrNzNMmXkiIfb0FTLGrb6szW1EvKHFX6bMZZxg3I
         OpJ8w+wQw7pI2CI6I+81p4gZyTSC1mjmp/BfHk0KafZxT6sgVLTjraRRhkeenMQmMQsQ
         pxrTDqvY088zlRJ9ZeyxEeqesjpjYNQ8P6r3h84NjNz+Q2IyLmsTmH662z6YF5A1nuva
         SDcsF07zrOlZEXOTZzb/gp1sqFQGzMEZE3AtcSdt9RsW411Z2dNUMtggLc8SgBqOSecr
         lYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2uqoXLdriDwngiEdIujJPR1d7VzbepHTpyozA2PyKQQ=;
        fh=k7K4tCcBoLlS6S2i2CnlbvyhVwifLeGBQ1h93tC0us8=;
        b=Lu3m3MTi4hFGwDyxqBHwcmQs0MfFN7uEmYsEr2D3ejxatCZR0yhb+cjL4wzU+Xh81S
         RskPWlS9kf9Dn4/zvzz9Tc9JyPbvJ3YETX7Aps99FBufcjZ/FYK4hBy4EU+0QXH6qam2
         6VSIuJLV9nIL96HowFHtZaO4DhNuRQ5r3deCmS0N4C9NDFnSmS/xY6MJsoqDhVYF0HOA
         v6HNhCBE3hzz0B9Ir1GBBUDSjvEJK/tk/JBm4DYQeTHX2U7mhDehaQaIAjA6ydmU5I6X
         DW6c7ke0S70L3vvIR8de1V/TnMB4kSAK6xp0bvXIQKRxNol94SuawAr8dlW7tTemd0kY
         kn9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787076535; x=1787681335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2uqoXLdriDwngiEdIujJPR1d7VzbepHTpyozA2PyKQQ=;
        b=pkdlVUgl4tMtPE1utRsDlQCsi4ea7D36l+QK23WFlzYvzttqzevGnWmm6qOJsqYixm
         aqxsU2jxeDgeaH7pdmzzlg3i4UYh8bd7yTGx3/cR9Z6y8Dz0iHamrE+6j0VmFCdffPrl
         g5LVCKJeughLKb9bpSbnlBHG+9E/2JSUp4lYSoZSHlAxCAS0FjSnUwDoKz8Y0Rac9vLM
         ml/wmLJZCHpbp3ZuDzR3iu/ecdiTXgi22L6SVRpYCjp1tBh4W/f6tRePEe0nnUuViiMO
         +Qf5uG/gL5tjkTGOOT86Qoj05rA/VaAJb6BJ0U5g5qSiAkHXkOnaNC3NvhX2zwhh7wVb
         cG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076535; x=1787681335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2uqoXLdriDwngiEdIujJPR1d7VzbepHTpyozA2PyKQQ=;
        b=tVF5zVCOw86HgX0zZrRW23GHRM3eDE0w8aiaNwqbZ3w7wWa41MupuPPTXXkiFpCTSO
         bQUyHzyQC5+HU2ZSqbF8JHrMESixu24j62NwyWPHCu5I23yEi5xI1kFXJofU/mA7qHP3
         4YJhk1le3WPPrCtfqVXNc9aFRl9Srz0ix8LwSavrA7TW8sAs3w2DTM9wBFsNQ1pK3Wv6
         kH5jxtigGZlqb/T+AYR6+B0Y0UwcDg7ucyAFZEEvVKF+5RyEPzGLezQc71chLBDMcmxS
         tyM35Co4ZjJEq8gIRL5cOhsrB/NqC6qKMYLoDKvxMdYA5lYz1AzDgqdFVgsev1O05jct
         Pv0w==
X-Forwarded-Encrypted: i=1; AHgh+Rp+7Vcihq4dEAw5D5OaOTBw+qHDSpI0TNeNw2tj6Iw/X5AjbhLsgw53Kzys9W1HCI0a8RSQrS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHiU21f8mkTqADTrsEbmuqAukBkltraPpv+5ZOqDs/Ag8Bww6
	+g83yguWuwmF0bvCfX4APLJcztIx6cOcGp0Ubzu8pli++b6zrUiR7ws5NZ8g3pNcPFRJcjQvQXl
	/w7lfPKzIWeMlw7r3UBg/n9bfIDkFUT4=
X-Gm-Gg: AR+sD13ipPsjBsLNrvBtKMvLB8NQ2IM36pB+yRj6W5APbbch03QXqSgIOsnKf9wW9uS
	HoHB/QmUBo1fdXdox6Bt/H7zb+G5s6KIKhp7gKNy3hzeHMNK/g6iflrzUx1ZxqIpl82X9Md79A5
	icM4lMTfSueW2k6z9YBUhZzpmDoIUXcR7/ArR/MdOa+kXjKMmBkrMcutKpTOfwFsAervmz0ppxe
	t1ytmDdsvrJhpJCfh3NDjvzXtP56DNzcD+Nz0wOp/yE942eOW+ZKapfESwX/MiQeaYN0u+n/lcS
	OkvF2w5uJK9M40kzJAGkC5QqirBYaPhf6I+aRLIFij0FaLQ5W0btyGFUSLfbP7Qz2UFRWYxDfMI
	0vwu0mPkTm04NpDNoDZIP1bzrGWYIYjg=
X-Received: by 2002:a05:690c:e649:10b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-8449448428bmr482527b3.12.1787076535103; Tue, 18 Aug 2026
 11:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1E12CBD7417A4019FF058EFD19B1DB930006@qq.com>
In-Reply-To: <tencent_1E12CBD7417A4019FF058EFD19B1DB930006@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Aug 2026 14:08:43 -0400
X-Gm-Features: AcwNN1UH_RpM9ZVjCPTTexQXLT4sspTvFco6Bzj2nGl1dnd4gH3a2pfhfNV5OR4
Message-ID: <CABBYNZL1_fTkwdhjK0aKqg44c0MneOAOWThQQDPudFUe0m_htA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: ISO: fix use-after-free of listener socket
 in iso_conn_ready
To: Hang Nan <2122295973@qq.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hang,

On Tue, Aug 18, 2026 at 7:33=E2=80=AFAM Hang Nan <2122295973@qq.com> wrote:
>
> iso_conn_ready() looks up the BIS listener socket with iso_get_sock(),
> which takes a reference, and then, without re-checking its state,
> creates a child socket from it:
>
>     parent =3D iso_get_sock(hdev, ...);
>     if (!parent)
>         return;
>
>     lock_sock(parent);
>     sk =3D iso_sock_alloc(sock_net(parent), NULL, BTPROTO_ISO, ...);
>     ...
>     iso_chan_add(conn, sk, parent);
>     ...
>     release_sock(parent);
>     sock_put(parent);
>
> If the listener socket is closed concurrently, between iso_get_sock()
> and lock_sock(), the reference taken by iso_get_sock() may be the last
> one: the close path drops the link-list reference, and once
> iso_conn_ready() drops its own reference at the end of the function the
> socket is freed.  The child socket, however, is already linked to the
> freed parent, and a later disconnect of the child runs iso_chan_del()
> -> bt_accept_unlink(), which dereferences the dangling parent pointer
> into the freed accept queue (a use-after-free).  The same dangling
> pointer is also dereferenced through parent->***() in
> iso_chan_del().
>
> Fix it the same way the connected (non-BIS) path was fixed in commit
> 0d255e63fcf3 ("Bluetooth: ISO: hold sk properly in iso_conn_ready"):
> after taking the socket lock, re-check that the parent is still a
> listening, alive socket, and bail out otherwise.
>
> Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hang Nan <2122295973@qq.com>
> ---
> Changes in v3:
> - Move the changelog below the "---" separator so it is not part
>   of the commit message
> - Shorten the comment in iso_conn_ready()
>
> Changes in v2:
> - Fix GitLint B3: replace hard tabs with spaces in the commit
>   message code snippet (no functional change)
>
>  net/bluetooth/iso.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index aa2ce78f56a2..069fc87a4e18 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2277,6 +2277,14 @@ static void iso_conn_ready(struct iso_conn *conn)
>
>                 lock_sock(parent);
>
> +               /* The listener may have been closed concurrently. */
> +               if (parent->sk_state !=3D BT_LISTEN ||
> +                   (parent, SOCK_ZAPPED)) {
> +                       release_sock_flagsock(parent);
> +                       sock_put(parent);
> +                       return;
> +               }

Looks like there is a typo and this should have been release_sock
rather than release_sock_flagsock (or there is a new function called
that introduced via some other tree?)

>                 sk =3D iso_sock_alloc(sock_net(parent), NULL,
>                                     BTPROTO_ISO, GFP_ATOMIC, 0);
>                 if (!sk) {
>


--=20
Luiz Augusto von Dentz
