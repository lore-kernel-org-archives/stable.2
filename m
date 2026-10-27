Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793066155;
	b=AWzYR7XXNFNgY745o/D8ryBFpM8xNtGn8pyRI1uv/oiqFhCjaE/LzsN2eb/OW3AtzOt9
	 NGgNdRpUGqpeD+4rMUm0Fc0vEp+NTpcWPoA0IwiJPydLrL9YHXpe22i3Vzh50wkhGufYa
	 gIr/n/kZYEd3H5q/kzUlNQ1g/gfqCykdyrRUNU88x+AeqvEqSyqJIjVtxa3hHxfxzD5Ul
	 cEUkhK8hLbtR+6xa2h9yUKfbPFhPgadQxlbyI+wtS5z4LVvN324W8Mdj9OspkwXz+4Osy
	 mfn8yscQdU5wm0Tsu/FTArCKBDY1f+Zals9R9GuPh78spvfPXSbrNmMmyCEAzk3IZqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=77IqWML7StqAN7sMwZCAci7s/VthwcJWiWQS34Pgze8=;
	b=2njtwjxJd3lFjGAOTmYFE3hwQo28VHQ3TZEikkFc+FQj16RG5D+SLhUlGdIFXfK46CPq
	 DebTs6Vg3ro0WNLa9O3qTQqn7C5mqOZWUjBxtSvsWAM75/hsxQvon87wWyC7gh3N6k99x
	 w8rk67P0O7vxQ5FRwOURrr0t6Vi4gtmBxpaf7tNanAwpYdtqc7vnR+5L1QWsir/VQ5uJo
	 rE1fuvnrDdJufMrDvwY4IqO5gJWrKfBUh9Roeevkvbh6g4JLqJwHpNCR5S2KRiWlVemDW
	 ccdZ/u+zpb2LolTsiGFciENTo+Oj6zCt/NsQcRgolwuyyWJwm6b7CoSm/xbxRNoiObA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LHa8hS7F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB1606A329
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53DB1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LHa8hS7F
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15943c9c005so4741278c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793066154; cv=none;
        d=google.com; s=arc-20260327;
        b=M3gwy3bsvVrXnCYaXdISKCrtGCuR4AgcmmFC5hW+NhTlZbh1o2uzyMTenqy6FLZR9U
         HQhSR2Sd3FsA258JuBau+a5APavC3G5sVXOtGLJGJ+epaJ9MJ+GuFoH7mejvVVpg8L46
         T101oyOisoyYQRgv97dQpnySnQrKHphYLCmnqN/hVVui9C8MMHP6+OuxgTq1/Q5Xglga
         zF6BPVq0LpTuT0anJLeVGEcOkjDPDVkA8yzsNOojpt70ktKwEMMx0Q5HiF0oBhpmtBqr
         ZH9iCrpcGF4ZCRyAUr7CaLBl2SwtZr/sbfgG4t6b0+tUgT18A0vk0nvUMHe+Kx0kEaWK
         QSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=77IqWML7StqAN7sMwZCAci7s/VthwcJWiWQS34Pgze8=;
        fh=WtJF8GPFzTjc+qCL7jpeE/sXuj+No4Yqcdqq3gUTxKQ=;
        b=NKhkhqZxCg3XLuUQ9MTPnC5wvW19Jf3k3OlW1mL5xmi9cmoWjqMGJ8MR+OzDvwATUj
         tt0ivfm/qO9l8qOmAeVzMqraJS/Dpp7jqdFCd1MOOCiPSQKHsat0Qg/x5zFCXnuy5eKE
         BVNZfi36JjrMRpJ5DwiGS1+bpoPt3bOj6ocAi0/gD7nVYuSFU/DjcByNZzBibKcTfz5K
         wixRZxxYB4H1+k2L5SiJH/pmJRlWv+IMPOlPvSMQQzMTMnfNXh6g1VyZ/CdZkytcRDWU
         aY7/Mdrj3SHppFIvngBQJOiPBkTpg4GvLwkTV9DyDe8mohIXKUInalqo1TDdJX/XYuqA
         Brmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793066154; x=1793670954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=77IqWML7StqAN7sMwZCAci7s/VthwcJWiWQS34Pgze8=;
        b=LHa8hS7FhhNkU98u/grVMm/uTgCw+bqUALtUlA45BnFz2iaxpAUe2FXAc4yqfZl3nr
         b1ZXwnLTKqlCB1mDSCtvDFhY6FsCnsgLEC9xV5hM+sC8Zz1ziP+MzIa2pW06xyH7UccQ
         QBTH92EGxG2SlB4kqXtLSS8SGmdw6gDQJ9t2XJDfFEqToxad3pCcesXYCnNV8dvw1Ci9
         TcFtUJzn/qLjIsBNrE9qQI/Sc7058K/jIafCOdPnr8dsIDq1Qblkt+Vnhk2tkj+0ZiS5
         NBII3QDgsGK9W5zIGFzaKEMVfbTHqAKEqkoTdKLCxHy8iOjkvgUet3Ec6THZJmFoMRLC
         /lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793066154; x=1793670954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77IqWML7StqAN7sMwZCAci7s/VthwcJWiWQS34Pgze8=;
        b=N6htRz4H0v0y+pGtQJ3aAtJAFDZGNSry3X3QZ+vXBx3VqxUbytJcI5EZ08rcBkfwVB
         ZFf4E8flW3Z529J+BCKIulU6mdp9ZtTjkC0VlsIwuQcgxZVCoYUz1LJOtVOkG0gCmyt1
         SrVvYDg83QT386Y2UdQJuWssllkQFz+xcQIMinelnSyso/lKDK9w2K92R4bXaExbhTBB
         rNBpMc5drE/spRLP0Gtq9cKK8wDwH5dfRetGC6D0vmLpL56W5JrJbh+YGniNQ8yS6+ft
         +822D4IIR4YNwozBngL+lo/FTwjPyA62dG7aM6zAIAOKasYtzKeoWJsfJpZIAhWX5XOE
         wgEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgo02GOSNwObr/Ib4Aa+wCaSLOwJQuG/yWukHeXE6dGzJ+x3hJLN8UYjvExiudopm/htXghis=@vger.kernel.org
X-Gm-Message-State: AFq9FYLe8BFxh1yguhU8HUH7M8H1KDvmvib92rMc0ijlPW8P/Cq7ygY0
	H4tKfnDiPZAyW0i60Y9CDO9uRr/TnEDt+TZlJ3RszjqMHfhZpbs/wtAAp8ytgWiC5KhGRX/jFAx
	GbLQuYCvySgEBYH4e5npSJYokZsHCXmlwERaPHGHH
X-Gm-Gg: AYBFou3lPhsYQQI7sN/rhJxwincykp2t5QIIPXAr8QzNboS2khCz/ZcNjuXeaLJDOXj
	02A58z+3WfkN/VG/Ut3lKH4pSo+uWpJ6v8L9KJuQs1OhDgJJQjRclAXATbEe7548b8UdcxSqFM4
	SnZJQe17FOS3v3ZRXVM+Lk3XK6MxR00wy8ZVM3Fy0W6kbQrw1pxvjGXN1s5VVRNbE7Sf5c5KonE
	tqNmR8ResqUaLJxjc8VyztOsUnoIIxUZ8q70ZMEZALMyu8/Oadz2VHCcQHgsVdcCsMwBk+TBpYH
	z9Hiow7ijR4g3/6m+F7o0yJFzhpkdva0jVLNP7Ivp2hsMD+nlga03o1khmrAERIbS8coiDtXrj+
	U2v+x+94n8b6Q0UFMfjK6z5pKl20wGBAbQlrUGK9FZ5He0yL4jJySZg1FQr32YWZfQdfj5Gkllt
	fMZZYaRHeUFvKoonbePzAmZ+CwcfxHeW7by0rKyTlpK4THIM5aWDLBGRkhrcQfaaoXBZ67xg==
X-Received: by 2002:a05:7022:ea44:b0:195:e4b9:d326 with SMTP id
 a92af1059eb24-1a1e405e0a0mr4384122c88.12.1793066153483; Mon, 26 Oct 2026
 18:55:53 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1685aeee-c65d-4a8f-9bfe-607e13e114a9@auth.ink>
 <2026-10-25-1-daily-reply-0005-af-unix-oob-skb-5-15-hold@kernel.org>
 <4ADFAF9F-7A76-4897-9374-914E5A384D8F@auth.ink> <A37FE39D-BD84-4FBE-A160-1ACE5AA98D39@auth.ink>
In-Reply-To: <A37FE39D-BD84-4FBE-A160-1ACE5AA98D39@auth.ink>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 26 Oct 2026 18:55:41 -0700
X-Gm-Features: AclHuK-9HmZC7VLxMmZYPyS43psLFDw64xQBE6-kn3D2u22OKCSPaUihqacBVnk
Message-ID: <CAAVpQUBA89A5qjL85pavgcYCpQ9jWFiiQXs9eBbHT+zAX1nC4Q@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
To: Tamir Awad <tamir@auth.ink>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, lee@kernel.org, 
	netdev@vger.kernel.org, Rodrigo Zaiden <rodrigo.zaiden@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 4:55=E2=80=AFPM Tamir Awad <tamir@auth.ink> wrote:
>
> Hi Sasha,
>
> My previous reply was rejected by the netdev mailing list due to HTML for=
matting, so I'm resending this in plain text.
>
> I've added Kuniyuki's updated address (kuniyu@google.com) to CC, as deliv=
ery to his previous Amazon address failed.
>
> Kuniyuki, could you please review the 5.15.y patch and provide an ACK if =
appropriate?
>
> Patch: https://lists.openwall.net/netdev/2026/10/23/274

The patch seems corrupted.

Could you send v2 ?

Side note, given 5.15.y will reach EOL this December, I'm wondering
if the patch might not make it to the last release ... ??


>
> Thanks,
> Tamir Awad
