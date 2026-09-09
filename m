Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48235C6B1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934939; cv=pass; b=Omzxwdu+K5yKQ9ngWa4UIRFnP4S+QminvqEi1xgSWSjoGQxMa9XiHzXXWj2Afdz+lnjffCvLkJizE2+vD1eGQxAfbEeIUmiRMJ/QiOeEhUY1zDghLMrxWymCLHne7+EanPn9h30MbBE4UxKw3B9pJGwCEH4gZs/zwL54HSQ/Qsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934939; c=relaxed/simple;
	bh=ZUMAL4Md/OW/2i7TX6skK5sRb7fbFz1d/4ElfK5ssWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDZbaiT9HtbOI6oMe6GKoSpy92V/hem08cMki2zpH1MXouZ6X8wIAYdNOh+b5EBdhd5fl7bkV4YKwfoj3ApTOuqEoDbsaxLUYu8Lt3PNhFBcNJC4AuH96d+K2a4fHPY4mUCWoefp0cKvIxkuhB8A6FAgQiLC6msglk5V50FlX0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ql0FwmNg; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ql0FwmNg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2db18e5cb56so52970315ad.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 23:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788934937; cv=none;
        d=google.com; s=arc-20260327;
        b=nGtduvKAF1vJpZ5+1VHFRo4HkEb9qWvC37gTQ8eVh5IkDtGSxpYJ9OKV0Kbr++g6va
         H6Hjj2vAkEF85yjQ5wbZKyeRdS2ppTt4IacLIkNYVT8dd7wKwrGWh+hU9w41Uf+0z09m
         iffP0FxySH5pYhzYk3DJsFxcdw+PhoA0FZ3RXUSc84T5ze6/+/HI0cxrx56+yFeaJ4u3
         Qq0ZBfcDWvsooTQtBKOx/9rmn7ViGJfpK65REjCu4AZ8BUzt+7Jv0FNJHKVIwwI/CPIP
         oe6nvtk3pYwvTy/E0C57yAy9T2md+8RdOBl/0ANASf5RGRpjrZZfIYmkrCEyfkzot4pY
         BAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VWM6CeHEk1aJXSMMdnevLIa5hIVREi7SkJQJU6C6uoA=;
        fh=uGHp36ZE0RIth2inL63SkPKA/Az5UphKkm0FcEWbjfo=;
        b=P3tIsBt5PJ2lonm9QfnkWEB5rIWMnrxxt3rgjRVuLYIoSdooBb3SH1aw2DRLKgds67
         snQ/hH0HxSkrKlRuQuPOfRTodtn0iL04SsddMR5IQKZSlp51ApKEx8durhtH2ETpYN4a
         0js0iCw1ENQPr2dnOovhJXvPEnT0ppGTOgaCg/DxeEMPtBAxLyNdkVs91hveoXnTJMYU
         yhayvT8+58DAwQlXvcyd1GGtIAwoj4wpu53aL5tentZtO5cUPkSS0WCBQuJvzARBC9n7
         wIYOcwbPn+3VTxt0riXA+bQyLUQRoHhLT4/fDUlCW2/muOjx9aUf+bMHfQGUZFI+eJrt
         j89w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788934937; x=1789539737; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWM6CeHEk1aJXSMMdnevLIa5hIVREi7SkJQJU6C6uoA=;
        b=ql0FwmNgoGsS6mrohJjP4yNIQW5HMfiy6B1gImcGcd+aIII2jfSaO+P1VZmGm7Q4w+
         C8qOQoMqviiO7gJswGseYyNA0Bdg+5yyJP+NSMKo3r4Vs0RwQG7YYiryRmm3sLHXPOli
         wKMbUYiYdrldUwJhWeUdObJZYZorC2A/mrDOvA4r7/UOAku4U/CdrCwJDClt5RDg748m
         7PJ1iHJKDg1xgzOhkZ5aXcfcRYpv2Y8LIBccXebKARO/+uUnOXmdZNc9b1/NGv93k1cJ
         2wy1y3wvAFq4DSfkwcZuD7dn6XDIdtyheOAHtm7S+moO0qdO1DSIUYzig3Wp45kVgfyo
         mqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788934937; x=1789539737;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VWM6CeHEk1aJXSMMdnevLIa5hIVREi7SkJQJU6C6uoA=;
        b=fdwQwxSooOVRlGCHTTInyvzRBpl2Fnc4SMSpccICV4z+yrnUSnGQ1aDBpkUINccowE
         BKHe0dcNLqGVPtQ3T4hSmSkNe8Tb6rrvW+HctqNH++c3RXeuRDNlMTAynjdWPOMx2kxE
         U5VK/CuDSe7mv++TqOsQnytISVrqD6o8+dbrDS9HYbhmV7swULhsAI8rZU75YoVEj7kx
         G72zXo6No6f0CIepdBtTKre0xupgHbSHrJXvlfU0DNwWTX0Wny8qQanoM0khixT3Hkjm
         CFk1hemWH1KsMiNSGDv9j+Pbm9eo8wq25twVJs9b3qtaDTynhsbu+3bR/gk8dI+gq4Ep
         IOLg==
X-Forwarded-Encrypted: i=1; AKwUvBxnknvqsa/dBUSaEQM2e9J9Ldyfmhm334ZKUvB+ONDkWaPGiMK33OqZOWwPdZ+aJpWxzIMPEqE=@vger.kernel.org
X-Gm-Message-State: AFuF++n/QTQE/+NHuzeKq83qXFNtA93IQ0zgXaf5NkR23cAV8LDLBdaI
	7n1beHrc23CHzKkC1reGlDbtFTGVJ+JLPkqtIb9Y2reoiARZzOE7poSZZn3Sd+eBMTYRJmowaay
	zdZMLK0xxdDCObxVcRNN1A+2cJlITlOQ=
X-Gm-Gg: AYBFou3taPKdp+x6nTRz0cQ4CceOBqLzNgaLH0U9+1DgBigccNmXsi7+F0tU7cdOuFR
	k3NT1wuwoYzkDXRQ4ZWxh/Oe/8dHcsQPOa/BrvPcRwFhg7JCAVo39evMPyRuV3Exrz6sOugA4xK
	xazutoCQ+CYE1nVtZzrWsfiLgS+MHsSSnLfbHANTq70z+j2fjAu5s+PBySgi180SsEj1tZZZYGI
	l4SWrrmsfzJCpKZIPSHJ++Ys67DZa+KWYZgVLJzaIbU9HeLqjdMkFcJv9JuSIHpvQtCWtjTDAW9
	I0XLPEnLljS0Y1tnQ3hUudfDhDpDUoKMGw0TtNZ9kgzMelzaNBqpRhvaYqjfkW/MFD9UemZpp13
	jowHbMahk/Jn+ZrZdIF+UIwyQ++g7J99aspVyDyn4OIoof6Qb+1MouWgsJ/Fm57h0hEo=
X-Received: by 2002:a17:903:4687:b0:2db:733c:fd1f with SMTP id
 d9443c01a7336-2db733d01b1mr147964695ad.8.1788934936683; Tue, 08 Sep 2026
 23:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc> <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
In-Reply-To: <20260909-fec-ptp-pps-event-uaf-v3-2-bead12c29a16@cherr.cc>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 9 Sep 2026 13:22:03 +0700
X-Gm-Features: AcwNN1UJle0sVjQuUbKVCU6-l0sg65xDQ67_7YzJFG8LlrYIbdhc6pOpj-B036Y
Message-ID: <CAABR9nGshJE96aCZVriQeMd+7Zjua5n+EKpUTN=953sowUL0Tg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
To: Shengzhuo Wei <me@cherr.cc>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Simon Horman <horms@kernel.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +
> +       if (fep->pps_irq >= 0) {
> +               free_irq(fep->pps_irq, ndev);
> +               fep->pps_irq = -1;
> +       }
> +

I think fep->pps_irq > 0 would be more appropriate here,
since the IRQ returned by platform_get_irq_byname_optional() or
platform_get_irq_optional() cannot be 0.
