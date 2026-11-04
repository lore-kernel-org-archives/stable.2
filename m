Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804852;
	b=3abCenLj7aa4ZxwbHedL/xZ7RJms61gEIZQv7WinhosSE/+Kr7w1GhnMwGqewsfvr5JT
	 njyzF1jyTqYhuf1BHuPl+pp+ulCpIvcr7uR1OeXHceW9rVDF8KWdNq9lDDTgUXsvfRcGP
	 FXQvAqYa8uyxH6xYk8Pd0mSOdz98Kwnl2zq/P9opCGoyZmvAjXQLtYTIftOsIr/dAWfPn
	 rc+/gVO8NJLcOHZ535lwA5i/DhjI6gVYo4ECE8yy6iaZTvQjSjLRbS07N2EjSuZp8wTHX
	 Md5mOW6R4cGk5NEWLjGzZ0OijUqdr989ZS1Ee0IpS9WvhhRD3Yq9F69GQ+8JYa6cyRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=ltBTia0nii7it5tfNdPGKdQmAKjBDB1nyFVPhBm9VBA=;
	b=Rzu6MsVdDodfOLXYXHABCryUdAXhRgMzsTn7Kuje9/4Tqm+SMlpBGNU5dCfLgR/2kM9M
	 cJ58v/L/d9zLeOn9y933NNs+c53TLYchOuFh67CQAdKZmZT5WC2dmPWe5BT2ozlrUVb32
	 t1mcruLwZVb1YGVfL5cJ8IEYmqaOHW1lJyffCiek8XEVg4RzCVfwhIO7yl/Sy46wToXmH
	 nPNoiAXal2YOINdyfOnHSME93l41lqGfLDaN5ESmt5R0V3GjCeYaASf086p5EpwlC1dl1
	 QnvjeDiPzfirANJn+IuUhdhzyW06pkb5dE39x9AMcex2SD4RESGm0cCseUrNJjTCFcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F2gj1HK1;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3C606D80D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE3C606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F2gj1HK1
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b19e291cc6so715347eaf.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793804851; x=1794409651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ltBTia0nii7it5tfNdPGKdQmAKjBDB1nyFVPhBm9VBA=;
        b=F2gj1HK1x8jxM+X3krmaVUAILWIRI4eLTbUXmOS1jUGUIOlSyvjMIxN6vzSv1DYjhZ
         ODPlQp00iU/As5SYswYZQdwBd69qSRBRp2fYy33Q0jDCMPjs7pDX8eM4LOrFDHb5mm56
         ZOjxtZzPIXx04Grbh7OTG/vrnzE2A3+rgMbeH8vRHUMW4qINP4FIoe4fWLBvFSqwA46m
         Fels8C8DU7I6gFPmFEB5GjuC9kfHCgj+Fku2zGh2MLpTTEIyxWWYhxkEXBDQaQDJ2eaH
         nAhjAR3yVVaDyqM56z6tQ8o+w4ox4EBt6GK2i8kEbL9v3up1SiBebkTI0jfPDkXg1aYd
         NWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804851; x=1794409651;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ltBTia0nii7it5tfNdPGKdQmAKjBDB1nyFVPhBm9VBA=;
        b=U/Yf7NzJNGOcND2c8dPm7C1cbiU4SrqFTeUOoHUURMu67DYEiJOEY6FlBjvCP0QkEI
         M1TJLpSdfrC43XtCCWIL6MIghwW03Jd3QWD82SKnwSW5lwGzAbuKURhYqVqMOy4Hfv8C
         cPXL8eykNWoHpThaVSBKRsvkGFzQBYmZnKt/bzl70tQjhHYPC2nSjaGhoiUQgYLcxV3X
         RXB8pQJHgaNCF4oRQxZhwY0Me3rmcavH+jfgEDEporv2gsL0V1678PBPhBsKU+0kfsVp
         qCDVivIl7JC+3ae0VwtJLR0iVvQkwdb1HYKBRwhgr6JgFjOwzVX7pFPh7TuccUzooq2c
         rzbg==
X-Forwarded-Encrypted: i=1; AKwUvBwDh+Ql4r7LMZTr+g3yFZIabiN4p38gfyPhGpMbnRut2WQ3ZZ8opIRg34MtT8j5UdkE1RyHbUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z938dx9BDELov7mzJngNcHy/hBYskgLFGzuq4btLDjSWCFB9RO8
	RPJLbWSyYID6RMuZf0Ui8W+Hq8hxtxLATPnpRPjj5j44kCgCoUEWnCSv2sAxtalw3+Rtu4BehbR
	DjrFskX8=
X-Gm-Gg: AYBFou1zwyYWPQ5DKjqIH1+YSRLWbM9Ujco61tgAx7yS6JVR64mtcIO9n38cHI4hbGV
	X+GFTpL88QQxTFdWaQ4DRQshsDeHaTssFl+K7VyQ+Qcky1PWc28dSEnmu32esnQH7NQrwqRF6EY
	9SZwFk8FAOumg6OFNeEfrN9uVvJOjeh7r3VzFMjvP7pl19NjODpqJtaXAwk6n7nIBfBf/mAfqv+
	VuwbRci+lVL4ax9fIK2DTiK6WtuyIEqcJko5A55gFK6pYPgrFW8g99+uVQ/U+OY10eDOCmN/fAl
	8Q6b9Cm2tB2mdbl8EOCwNf0phAwFfvnFIcC49/mP5u+xk3UekJ12D1JezpHC7gqde8W5PJwaj4J
	xLdif/z8Jl2l1TD9Cioueyp4i4mon7pbhDOlyPLjN3qGK4sZGZfskLY3JJqV0qEqT3sMvK1TtY1
	7tQanZ7JMbt1rjuS/68aENnBET9Uh5TVN0Peb7lwqiG5GLXr6NVzNQSJE6gbSUyAIxidJR73f0i
	Ju+iFItgsgPL6iPCUsxc0+2XffZPIR2aOuJ7GQdSteOrAIphOW0Oh81gUB66KoGUmOj3Jh+jRpd
	yLfbKlc50qZSokTCc1EhHjvZIwwOd3LbT3mzNVBwcM5woQuM4rRZEFHP4YG80QiO9k8AKUjESqD
	rzpIKOAOPnQ==
X-Received: by 2002:a05:6820:560d:b0:70a:d839:2b39 with SMTP id 006d021491bc7-714f24d3fccmr5442543eaf.3.1793804850833;
        Wed, 04 Nov 2026 07:07:30 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c0cdb22dsm1886033eaf.0.2026.11.04.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:07:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Yitang Yang <yi1tang.yang@gmail.com>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260901142438.237586-1-yi1tang.yang@gmail.com>
References: <20260901142438.237586-1-yi1tang.yang@gmail.com>
Subject: Re: [PATCH] ublk: add missing DEL_DEV_ASYNC to unprivileged
 permission check
Message-Id: <179380484979.4021488.14146946134679521400.b4-ty@b4>
Date: Wed, 04 Nov 2026 08:07:29 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 01 Sep 2026 22:24:38 +0800, Yitang Yang wrote:
> ublk_ctrl_uring_cmd_permission() is missing the UBLK_CMD_DEL_DEV_ASYNC
> case, causing the command to always return -EINVAL for unprivileged
> ublk devices. Fix it by adding the missing case.

Applied, thanks!

[1/1] ublk: add missing DEL_DEV_ASYNC to unprivileged permission check
      commit: e6ac1da6a53c5f670bf09e60a2500d15be68d2fc

Best regards,
-- 
Jens Axboe



