Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610F7DA66
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431470; cv=none; b=if4SvNE7gQdhauUkl2sPSg3tI1T0I0YkGvhbBiiLmbIzehiLAYrawdd3v0BRHR2B6vF2QaqIGv5tScUJ+amhNwHPNYuZjdWlFF+RT30MLJp0kljf4XLnP0Tb5CgXRVALy3YEZCdb8IxSHUhXsL4JzjaYnqYQqXKzCMCjSkkUhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431470; c=relaxed/simple;
	bh=7oHzNDjQwBTrxSh0/2XmZfHLhvLvLS12Vo9uoLTUqOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/ceOJrhvJAYrqBwvlkTKgjc9w6CEjJnK5gGiXGaKRfn1BdsMPKHEM6EzANC4ATMQgvqlp1Ag6TA/7+/xe3B6SbVe+Q1cMHvMfhzO8E5OdQxJkhWtME0iAMcKCfTPgEU/DYaeIr9D+ET3gRteEs8zfxEsM3gDEkS0ht0FHKJqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kJ0Pk7m+; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJ0Pk7m+"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso5253382a12.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789431467; x=1790036267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fSVVYlw+xnmQhzMBOcvIbDbXL6WijAmubWvEw4BRZOc=;
        b=kJ0Pk7m+OxF99z27CoJyWOiEKtEYfc0mFO1yLjtDIwxD6BBsgJ+c4AJUWTSu9cXWJG
         Pb9RFmM6Bab9LiBDJ3pIWA+j8C1q7UaqgC/ka0doQEs1GnA77cbRyqSS9J7FsTImrQs/
         h4Thsz46whyB7wYgpgEoUwXWtZHSRK/LHVKhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789431467; x=1790036267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSVVYlw+xnmQhzMBOcvIbDbXL6WijAmubWvEw4BRZOc=;
        b=kA5nNfsEdq+n48jpzj45SThVv82iHG46LkNHu2A/i4oruOPwhGpUO4CLDZF/EytWRJ
         2qB4M7KOC9W1azYaDemtLKb1wdetjtxKaEYc03K5htFGVVt+IreXKQCrJWFIOLOnTDAa
         FzfJVtjEc5gSTzGXneEmum7d+NzcFBq9J11n9uQyuUQ/wj1/WoRIjR2WCmc03ke5k6ds
         LO/q2XHEK2FeN3pwGJNZ4yXMHlFcV+yzgtoscoAUGh31yYGbnGBN9HXC0ml5cv9AiUQH
         PhgoYL50rxH+wBBnLbSWphtahtYq2VnK1kZt9PALMHoVLnJPq+KcCgDx4kVyEiLbK8Gy
         Vbwg==
X-Forwarded-Encrypted: i=1; AKwUvBz7DKkxsOgVtAtEtY/pqU8s+NTM9RoXWlH+/nrL99SJ4DK+lZSnx7x8JeNyHm4tP36QUW73OGg=@vger.kernel.org
X-Gm-Message-State: AFuF++kJJNHA87dVeZYr1BGOrc1YFsg7pcDYzBjp/wRr11x4FAwCgI6y
	oz55oE+NFcnHTmtMNEPcYSmp6Jw0ssLZlxreK1OTAFEe/OXU+M+vTO+CSPHBcHR0whlcY66NSgB
	SrSO4dw==
X-Gm-Gg: AYBFou1gxLqXYNVWXBCQ6ZM648DliMRlxNifSNaJCuUoPiMpzpHOH7rAWmR8fpZT+OR
	lhc9O2xAfqAd5Pix4U2CCuh05B0UVpezTGQX8IS3JigkNQ/b1nxlpH5gzFEKDRllqgh5VBoyHJa
	lImcziOcU/x0I6aUc8aKC+UBJoNi2tqRyk90ImSp+iM9AyifraTmk7A/aGNh/9mzCDgNqJEL4Sv
	/8/F94Qj0Q3sZAJ8c+gS0rTNr3Eiy36ZwtNx0Mr0VSQ92DrQVq4caZXN06yctUuir+Rg0GFQ2co
	UlX75GVAmBNdi2VJkOX5jl0Y/W7/L5OO7RhfkDKn8rlCV66kMldUS6mnfShSZXo9Tc3owm3qFdm
	57P1oj5PL6nGZoyb+Ra71WEGwJJLr/wFn1UddAK/t+eSWRU53GWLIgpNcPUtHZ/T0peY/lMpBL2
	+WvzL6/0Y0ILXRjylqIoYP4OR3jPX8W3oR3xvIGbgFx5/HDIOiu0jwe5qAjVGY3aj6WAsVd6Dz5
	OAjrO/xjzbgdED58vNU/l7UMvFtBqd6UInqBA==
X-Received: by 2002:a05:6402:46cc:b0:6a9:b3b0:6cf3 with SMTP id 4fb4d7f45d1cf-6a9f63dfcffmr2599199a12.34.1789431466903;
        Mon, 14 Sep 2026 17:17:46 -0700 (PDT)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com. [74.125.225.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b59644f2sm4470934a12.29.2026.09.14.17.17.44
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 17:17:45 -0700 (PDT)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843172bff4so1270875f8f.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwIKXGZWPMUGDu1umebfN1hsd/weeJ6c6PUNoBgA++dc2Bi9OqsFnY2rmvZnTzNRbBBRVkJ7Uk=@vger.kernel.org
X-Received: by 2002:a5d:6f09:0:b0:485:ac96:7273 with SMTP id
 ffacd0b85a97d-48702aae62bmr6377643f8f.10.1789431464064; Mon, 14 Sep 2026
 17:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914180344.15485-1-fangxy@xiaopeng.com>
In-Reply-To: <20260914180344.15485-1-fangxy@xiaopeng.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Sep 2026 17:17:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1-gNZ8yTsC+D8inePWv=A+9H09hWJojQf5NRpcNvK+Q@mail.gmail.com>
X-Gm-Features: AcwNN1UDclOTfyQ0nueNq6l7CP6C6qRUFPzUdlWRrChZOd77wqGX1Xz-KPSTk3o
Message-ID: <CAD=FV=V1-gNZ8yTsC+D8inePWv=A+9H09hWJojQf5NRpcNvK+Q@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix buffer overflow in the 'm' packet handler
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: jason.wessel@windriver.com, danielt@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 14, 2026 at 11:04=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> =
wrote:
>
> gdb_cmd_memread() passes the length of the 'm' packet straight to
> kgdb_mem2hex(), which hex-encodes the reply into
> remcom_out_buffer[BUFMAX] without checking that the reply fits. A
> client on the KGDB I/O console can ask for a read of any size, and
> the hex encoding runs off the end of the buffer. kgdb_mem2hex() takes
> that length as an int count, so 2^31 truncates to a negative value
> and copy_from_kernel_nofault() is handed buf + count as its
> destination.
>
> On x86 BUFMAX is 1024, so a read of 512 bytes overruns by the single
> byte that terminates the hex string:
>
>   BUG: KASAN: global-out-of-bounds in kgdb_mem2hex+0x1dd/0x230
>   Write of size 1 at addr ffffffff87651780 by task sh/1
>   ...
>   The buggy address belongs to the variable:
>    remcom_out_buffer+0x400/0x420
>
> Bounds check the length before the hex encoding:
>
>                 if (length > (BUFMAX - 1) / 2) {
>                         error_packet(remcom_out_buffer, -EINVAL);
>                         return;
>                 }
>
> gdbstub_msg_write() already bounds the count it hex-encodes
> against BUFMAX. Reads over the limit never returned valid data,
> so an error reply loses nothing.
>
> Fixes: dc7d55270521 ("kgdb: core")
> Cc: stable@vger.kernel.org
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>

Looks like a good fix to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


> The scanner is a taint-style review of the packet handlers in
> kernel/debug/gdbstub.c. write_mem_msg() ('M' and 'X' packets) trusts
> the same length field and looks like the same class of problem; I can
> send that separately if there is interest.

Yeah, my AI also says 'M' and 'X' packets likely have the same bug. It
also claims qRcmd packet may have similar issues. Sending a patch to
fix would be great.

-Doug
