Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AC47A0DE
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290390; cv=pass; b=QYWA3t6AU2ZEDidUWRKflmYGn4TpN+qhaJsxWRdTUFJdh9v+ru5PxHd3NcVi6ZtffR7j8e8+yVApHkgPIJYjHShCgmxIhfxQEDfaaWxb0fysiBuoxpxoqMPmuAv7KfRudIduh3Bgdd8BLKA9tDpOhUm3PyOSsB2vgI5MBNUMff8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290390; c=relaxed/simple;
	bh=OeXCShUDRg/EoGX0bQe5nZls3cDjB6iKzioYj+6G7Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgTyxiStb0hn2QwHSo3WD54d8+7GHhae4kP8aCOIe4XK+MHkVbAq3TyJuaviFTYjGHwJ7AITugtW4pLd2knoUKn/R6R4KwFzosDxBHoxzHE+tJPGzXF7YnmX/L+xjTD/5wUMbh7V7Q77Uf/+TWo1PAkKxztjueZlcgRzrRezcuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE/L64JM; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE/L64JM"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-785d603efdeso134621137.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788290388; cv=none;
        d=google.com; s=arc-20260327;
        b=Ia+5HrKiSmonZIeYCrORlKbg05O5usTv5aaRPSwSWqkFo5Kp35fk0SE0XqkR3TbDUR
         oaEwoaZewRtUxVaRemzQlU8tGQv1L78vEQVAZk2xBPyqBhgc7EuDBw7gvAPGx33Mvt8Q
         e4F+qXu29P6ndPWm/a8XSqEtlwv22S+gUTyHcDKsinU5dsG3WtxNDDklj8KZcvboCqBb
         hNPL0BtVztcvfhT+aXXX7AtQpmhu8Nz9Lay3rU4cDOVobsZdOE3YxzQ7z7uwrzi5xpT6
         yz1/QCosWbmLzrCstKDQF1GHHS5r5zCaE5bi5LvLZET7y2oz/XxEoeVvkvRX2TEF5qa3
         JM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OeXCShUDRg/EoGX0bQe5nZls3cDjB6iKzioYj+6G7Po=;
        fh=wz2UDphH8VHlcTNtyd5AAbrsg2WBY1Hlk1Z/WmViKzc=;
        b=ZvOrcnLkask0J3hRHYgL/0q+xbNulXWe+9qHlsnji69XFYtltJ2pOwSwTyKcxlFYbv
         hdBqwBNueoHBUdwbfk3vPNWdgiKq4mNmdacuGifV2FP6bJa6wO13rnc4HDImvWRjG8Yc
         EiADUGqXNj/LbVp0UJ3QMValN7QtLylQL2XZtyMJ5U/4FO5QXdkRPO/hDA7gIRpXXC0D
         Nis16Lagiqw6NEaFDkK7uV+XqiuvCilaxZRuO0/q0xg3ObCkSKTO0cmlOXiFVNTdO1eI
         40tWpaO8UMhVdSZdMQWcXV42lfsosPBZE99/AE4u1HUpQNNfIAAe4TJQC9adlmYwEQSN
         cEvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788290388; x=1788895188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OeXCShUDRg/EoGX0bQe5nZls3cDjB6iKzioYj+6G7Po=;
        b=KE/L64JMYW8qdYveadiAStk5did2TxAzFacqIinZC1vJbJ/Om66sG/K+SaFRkbVNXL
         NX6M249DtIJjag6rfArHwpA5TXgdF3AmQFac1WCjiz9iSDLo0Nh2I0+B34WNvMLnKQL/
         HlhX0EvCdAliYYp2Ykbbw1Nf7li9m1wyan07sFk7p7YMv8Dxu/JL+YBMgDnWxiybBS4Q
         m3feFQuDRnCFxXPLKL2PDUNXbEOsV2dQm1K3U+CvHED5vPDdnkvWyswQvdRWYFHtRI62
         LssFY43Qbqdbxq/VMlTRK9PiehJuRzidzUuBA6v9WRNpJIELzIG/ik68XAKR4MQw6PfZ
         hDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290388; x=1788895188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OeXCShUDRg/EoGX0bQe5nZls3cDjB6iKzioYj+6G7Po=;
        b=CSiZ7nm68CDG82PNXnVmXG8YHzPUk4Ldsnk4ud1QPoS4S+zD5YA51thzh7BOS+Od/Y
         MWIQK2LxD98H7UrwoM8lQHt+7RKPm6tixQjIINwZ1Bil1UeA3/90uNnj4wQ8SUsWQj2W
         4rhnk3pvjJqM1IWqolpFZZ7gsTNMZS8cbYC+dhVib5CYl0nO/7JehoYJFSyJaBPidxfX
         MiVXL4SW2vlLkVaDkRwjgd1tbYL1hZqhvmVdXOOetDZXZ9EQ0MO6SrU/xZ0N4IYSrQKa
         5tnCaOAzFMtYhFwMDcRhouFsHEolJSIwBZ5vTC06oYOIqHHHdqm8LA7TqQi2yhF6EyVf
         P+kQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgkjlMgPFTZrqSeugu9ubduYWCqRGy6ekN33iRsCMSEjnE28L2+aAP8vJ1zCGcYtUetNSz+LY=@vger.kernel.org
X-Gm-Message-State: AFuF++kKGAob8pTFUQAD706I8E2Q9rywG3KgkegPNG4C05vNeZr7CUHD
	ZrAGopH4bjU8KlZlUtR9kvU2um6yEtAoABRoz15wo3572LoPYkHfn+eSKhy38l3fDuP/Ma2jmob
	57m6SGGRpc1j9TPAeOGmYtonl0CeFgRXpdBwWy3c=
X-Gm-Gg: AYBFou2MGEXdMUJHr7dpFUk5vMUTmuCA5BaR0kjCc5kPxnGEG/I+JNxwPVphVte+t3Q
	4ny5emoescpGJHmjmBzp0RfsFFOUeuMm73U3d0fKxHjLoE0f6xOod3K6A6QwuT8/Wbcd7nht1DS
	Wg8WUmxTynWQIMC0i5H7P1yeJmpUxd3WEB3rOeY3fmGajOQ38YNOBVTHQyZiwqbIqKm/Wt38rWP
	5qI96QUnW/bTJYZONcMI6vDOdwk5DIxGYANGTGlhN4/ZPEOov8U9JfFggfPIboj96HH24uRPQiG
	H6k5H2WvqcRPGQUBpHW4ndD28ju7Sjrg3MRaLk3PqXNdYeKSntbnRxauNKZ+0uyLyBPIhDG1Fhd
	B5jNe2VjtM+Q=
X-Received: by 2002:a05:6102:8090:b0:784:b9ec:910b with SMTP id
 ada2fe7eead31-78a1c856b5amr85437137.12.1788290387764; Tue, 01 Sep 2026
 12:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827175703.1549-1-orgads@gmail.com> <2026090139-shout-unscrew-0197@gregkh>
In-Reply-To: <2026090139-shout-unscrew-0197@gregkh>
From: Orgad Shaneh <orgads@gmail.com>
Date: Tue, 1 Sep 2026 22:19:35 +0300
X-Gm-Features: AcwNN1XyWSUHocmPj2MzGIz9O3V7vm4LgQI7ayfr9wFZoCCSHoE-NA8v0K5-Wdk
Message-ID: <CAGHpTBKDBsecVq3Tww7qSo+h9=MVxe-AFAMkUbowK8MbEpu1xg@mail.gmail.com>
Subject: Re: [PATCH 1/3] usb: octeon-hcd: fix the FIFO-flush timeout computation
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 5:48=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> Should this series have an Assisted-by: tag?

Yes - my oversight, v2 will carry it on all three patches:

Assisted-by: Claude:claude-opus-5

I used Claude Code for the analysis, patches and commit texts. My
Signed-off-by stays as the DCO certification; I ran and reviewed it all on
hardware.

> How did you find and test it?

I'm updating the kernel on our Octeon boards from ancient 2.6 to 7.2, so I
walked into it. Bringing USB back up on an AudioCodes M800 (CN5020p1.1-300,
board type CN3010_EVB_HS5), modprobing octeon-hcd killed the board: watchdo=
g
reset, nothing printed. Serial capture caught a soft lockup in __delay() un=
der
cvmx_wait_tx_rx(), where the missing parens on octeon_get_clock_rate are ri=
ght
there in the deadline; git blame lands on 3e195a80e096, and the cast hides =
it
from the compiler.

The flush never finished on my board because the driver got the DTS default
12MHz crystal instead of the board's 24MHz external reference, so the PHY n=
ever
came up and the USBC registers read all-ones. That is a board/arch problem =
I'm
handling separately, but it made a reliable reproducer: with the clock wron=
g,
probe never returns and the board dies; with 1/3 it times out after 100us a=
nd
returns an error; with 2/3 it bails earlier at GHWCFG3 and says why. With t=
he
clock right, the root hub and on-board 4-port hub enumerate at high speed a=
nd
run without errors, so the timeout doesn't fire on healthy hardware - same
setup 3/3 was measured on (8200 -> 4 USB interrupts/s idle). Builds clean,
checkpatch is happy.

Untested: any part other than CN5020, and the HFNUM wrap path in 3/3 beyond
reasoning plus long idle runs with a hub attached.

- Orgad
