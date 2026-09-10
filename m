Received: from mail-qv2-f11.google.com (mail-qv2-f11.google.com [74.125.230.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09C3914F8
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051370; cv=pass; b=XV+mqj+KskOQJII/vM1d7Y6QL5ylVWMKHxT9XFs2VRpLsCgKOZAz2z1wvAcIQAfcUoJokM04RfJseAke/YBgg1GlABgqXBYb+iMl+YTIxLbVq/YvNrbOEhhk+VywlfnL3GjYm/MCAnccTtVeYj/CuchkSN5Qn1ON9HdJkois99g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051370; c=relaxed/simple;
	bh=A3NBwT3kopqU6rUQDfTU2NVJM1JpMiHHARAEukPCTcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNP4pFCYMkOTp/BFgml4ZEyOzZhlC4atfsB75qIzrwDjX5QBiZ0bFsEUtWWOniyg99IfkuxG0Lq8fIGjkzA6/4Zi4+btqBPVgx+JQOb2MRGcEvzOuH6pAhet1Ph0V7jwzlcICy6eyYbimdrYHYEADldKmr//mNAeBB/9Ueh/fFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxBUDI9n; arc=pass smtp.client-ip=74.125.230.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxBUDI9n"
Received: by mail-qv2-f11.google.com with SMTP id 6a1803df08f44-90cdfc57039so20948036d6.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789051367; cv=none;
        d=google.com; s=arc-20260327;
        b=RnelVJErdH6ktNOFAv7pHlYKns4mF5Qy8HuwjV+lOeyeX2M2iHzfQpQ8qRpPKNk8pC
         GD9BsKmWOLWYaffmkkrH97qBScKuyiQmJE72ur+kTDHIsctsmjI3543A2Qf8Cu4/1qMy
         8kmtjPSOzA9/YPEIB7VKrLLZP2Iz7xS5Ke6gKfGxWulPhHXt629edWHVs5+oOvdNx4D4
         scv2Vi7L5FapWGMI7gX9PP46CWcnKrT9fn+47evTW+b2TbylWc7mKhrcYxvJQixvatTK
         OGP2j4sO7kP6edNP+HIdNNLEF0by5KKFWcjxIw2GFlqfyYZJipqyPM+qlEZDAsDC3d8/
         xrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3NBwT3kopqU6rUQDfTU2NVJM1JpMiHHARAEukPCTcE=;
        fh=BIIjgmP/VLENg/iqJQMJrBAH3wplEysAgQecil1Yjik=;
        b=jtBi8MYyAxQagaBEvhqfV3RAkqpnWhOMPaaHn81rYxJCOOTwXrQFBYflD6ldSaB57a
         DaQR5HeLpELgLx/iOMM7xPE9xe3MjZG65YwkniDhnTcze6nxuHKaVoM0fcvy3VpYVJ87
         H7/9DcPsKlL9zjRcsAxNL9ceC0hcuQiCHM284vzNEuxvv3zZpXpMKCZkvtoXcxPdCnEj
         X/nNgV/EgYwJaTXkB2f0I0+74z9Qmb4cB2mWM4N0vFwYl2f/HFGuX1t8qQxnZluiNSfN
         D+NpRPAAQWOEk4bH5B44hkDpOXZ9K/Zb85MdF4jNg8lCtYPWCexBFZYTuaseuqx7x8JJ
         aJqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789051367; x=1789656167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3NBwT3kopqU6rUQDfTU2NVJM1JpMiHHARAEukPCTcE=;
        b=KxBUDI9n7UWsOjc5rlh9Gwf2PJ0D/+LSYmdyy/6oismbd/nrNNM11K/IDaDoT+tgJN
         jQkC2FE2up5sDZc9f07MYtbi3YLC3wZtGk+4//pjfjFoJejFAcmwZdTUUcgEim/+P7lk
         Xfme03uKsGP0a6rqH70uMnd3510615o1kOK8vUyNpUmJlumXGdfp+RQDkgkZY93Dvz8h
         wr0T7PYN1eO93/LHWAsWAnts6VSRJ8T1nlIpOjEm9WXVwg0YyQJaurFk5AIisfd+RtsL
         j7cUBwr4AIlutYdKHnXPf8KPsFiUPAVyfSD1jUxiHz+dF1itJ/v5bBIWb2bOymBIXdwp
         c/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051367; x=1789656167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3NBwT3kopqU6rUQDfTU2NVJM1JpMiHHARAEukPCTcE=;
        b=gcaRW5J+LFXA2ThQwFptKQQu0HGTP6Y/ttM95oNa50H2XN63Ht5T49/eIuMH/It5XH
         QBjGKLt59unGvzMeotvIEl/WP7bp/TlwZYQeZlhiHrhrqMxGQvasW65aC3PIOvDZ7SaW
         FSI6niQsp85RwePtMT/oNIBHLAx2FA66UuAfyfyeuTF/HWi2IS99ZyyaZpIe2aNFh17R
         Ltxt7cdnleD5d50kk9su0b1r05oooRdF0Oqr7DTQztith0+yKfHAHaajhxhN2xnUqt2A
         98oBpcniUgOub4iQS3G3jvazzd91fH8hh00e/OE15iowCpUJi5+N3SR2nq4TP/A8A0yV
         Ansg==
X-Forwarded-Encrypted: i=1; AKwUvBzCeOf67pf8f2f3nZGZ9/m5U2i0oxe8Zmq+xK7VdzAPYK59vgu01mc2fRw4zeRr4Fs5vvrdkLI=@vger.kernel.org
X-Gm-Message-State: AFuF++mjaqvCpEIcE6au2Uq6K9+6mjE4B5WiRn1m9mQLkV+X7RUqEdrM
	bLG70AOC3ym8kCdNkuw4iv7my5cJXLJwcama0OdmUoBL0a3HBhSiuOvR2lX4pBltmCNN3WFJSNl
	lNtLCv2ubOQzXskYBlbQ+r83MaFbswY8=
X-Gm-Gg: AYBFou3SWsbO6Kxt4etqy3gDCpyx3c4XNwJYpZT87mo40sfWQHTI7YMqGkbgTockfx0
	dcDHo9xgnpMMTXBm56Q2efiVXLuM/bmqJ9NAnrvAE266DBg0iDN4zvtddAOO4fouw2LkIZYLWTh
	0rJRomPhrEObrJp8xApr+Zrmq3pyL7cEZN67Gn+v9rsL0/DGeEFg7IXhEbFmuyun3kk0/3Dt5wR
	mRDvlJBJdNU78qkKAI6MnNOLcw0IqZkFhJx0GINnZSKp9xAEA8fFg25wXOHYP/LmWoEnvLbzcgB
	zdhoOeg5xIUUJR4ECOBsIVfAStUKsDR6TA8b1nQpdXff++wl88CsvIS+TiwkSDDGl2VWBlJH/fq
	Qe7u20IxCvhc+VcP90awGOq82qWZMWjqM15B/rJfb
X-Received: by 2002:a05:6214:5b0f:b0:910:7078:b4f with SMTP id
 6a1803df08f44-91070780df9mr133306426d6.25.1789051367346; Thu, 10 Sep 2026
 07:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607064053.195166-1-enelsonmoore@gmail.com> <ap6hIoGppETYr7ey@ryzen>
In-Reply-To: <ap6hIoGppETYr7ey@ryzen>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 10 Sep 2026 07:42:36 -0700
X-Gm-Features: AcwNN1Wk1zV5NERHaZeTyuW_3PUV8dF4eqEkqONhyMYLHRDUgO1Fa3RjXoXy7mk
Message-ID: <CADkSEUidf27u7U5mbB4FcDYZa5o6dWQnwf1LwT90Ud34MjfsWA@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_legacy: remove documentation for removed module parameters
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-doc@vger.kernel.org, stable@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Niklas,

On Mon, Sep 7, 2026 at 4:33=E2=80=AFAM Niklas Cassel <cassel@kernel.org> wr=
ote:
> This patch was sent to linux-doc@vger.kernel.org and linux-ide was not
> even added as CC, so I assume you want this to go via Jonathan's tree.

I don't think that was intentional - the script I wrote to integrate
get_maintainer.pl with git send-email had some bugs causing it to
exclude entries. I have since fixed them. Feel free to merge it via
the IDE tree.

Ethan
