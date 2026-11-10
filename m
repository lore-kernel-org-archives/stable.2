Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333998;
	b=M3YNNNYstYz7k9xf+C/XPPOHM8BZwAwI58NpVXv1avjCg9uGl5aQ/lq7z0m3r8llQVMw
	 x/00iKqXz8Q8hbKbAnt0DS6zCvDyCLSWWak/94I0cs1vEvltWOcjHz9fBvr9qlC/y6yiZ
	 CtrUMkJHUjqgWYYuzCtxhr33eeAnc6gC3oWYsBC3KKLuyPk5G77P5O0V+rH/peVcKVewD
	 PgPUPDptQt1C0HUMqcSbC96ZNZYQtEEOHhyWNaeFKgYjy4n9J+IWM6gDNCF2P+BiAnGx/
	 9478rBUicUH0mzbCyvXMsqw9F8PMojTxtlT1YkxnqMtd4hZIQRZeldu23obel74X0BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=GzOxYTq7EHxh8VUxt5+RHjpcCv/SzSEIP5xLxXIbEDA=;
	b=GjNrxLO0FNGvuqqo3NQgaYGIyfYO/2NXxBb2WpL0v+KwLItxNV8LGW6yprjV+T/xeaTj
	 hWNzdzMxkQLLBpojXq13xuLaIdRr5f8ZVPo5pMfguxMAzRxBFjnRM3npfmkaYgpD9zDGR
	 xW9LOLwB6ksxv8A/N3UvayZ2twzjf2ecFwL+UsMhqADMT0g9VIHy0igrPMg4qYgnSQs1m
	 P4K1RjhPMNtGlZFMfZHoo20RxB7djeJjmSzBvAexcHnAqwUG4uXd56tXboq3t1kJptkEP
	 rzo9E1jxWkNzSeQCPP5+BTe5qPw1mG9ZjzzeLwMPHGzHd5utIIpRUGBuQtv560JZj/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20261015.g header.b=a0rPiWb6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23D606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A23D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20261015.g header.b=a0rPiWb6
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c411e139259so119519966b.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794333996; cv=none;
        d=google.com; s=arc-20260327;
        b=GUfnmDzhasJvXIP1tIm2kCcOYc9zPa/dlXJ+h6Z3LAaLjYi4Hx+u0hE3N3Kwx5vB0C
         79rF/lb0NyRccNEhTQ7zUWmjoMjzR4UPGTP6aryEjx9BH3PbnwObRwu06daKDeKGWy7I
         Nryik7Dd0ek8241DcVC3t0MDMiINvldAURKIio46EvV5BImM4EDTKDXdpisdi+i2UdpF
         KrCKJms3RmvLPSVnGD+H3EeutI2lu0ESaoRDr0jFmDbOm8topH3wSkx5VzLlkwDJCoYY
         t6e2o8LYgJ3mfxYYrKOR+kO0jB6Bg9+8Gqobl5JbVKrTZ5gx8XSEXrBpt9fxTXtuYyxs
         Vi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GzOxYTq7EHxh8VUxt5+RHjpcCv/SzSEIP5xLxXIbEDA=;
        fh=X6FHuVfMqtAPhqN+6h3kiZzSBIe+d3R2BtR1SBZGbYE=;
        b=RydcmyLMPlB97/wAo4slPECUVBJf4MS93ieXFx/hJhdsuMc/XpczReLKyq6iZ9EZ8D
         rG0iQLCPhedAmQiJ8RVcflKmnqT9VYzTiVKiGbdzfbYLHOGnX5NGdZKh+oARnt/rCt8U
         e9omFStk8SZtU5ZIdw/9gG7p4whL7tAFpdOMwh0SqRMfRqrCnlIIxTw+z1T81wGP5enG
         82Aysht2QS202bvJ0AQCrCxRF/Cb6KtEkC3V42f4xPfnMjKtTVHp4dkYzqOYFqjX6j1s
         1dwxuc0EBtCA/0xRf59z+r5NfBiLFmFZN9eA13gmJ+JLzfvhgbz0KvsN5WjL4fmZfqNO
         CZmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zx2c4.com; s=20261015.g; t=1794333996; x=1794938796; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzOxYTq7EHxh8VUxt5+RHjpcCv/SzSEIP5xLxXIbEDA=;
        b=a0rPiWb66uhhooRgzJb6oHoMppMYrookK7xJNcUPFqJzEdVi2grND7+FILrWsx3Tss
         DzH9+GbDDHk/x+Xs0CZnsU7ZqKbULUo8QQktzl0lJMGks0WReik5niHTV3KMUB2O3Sfy
         D0TBp9ZRWvTT4L/KdmoJXszwet4OBZFoF6w215gtaA+OvCgSms2uFRyFsjFUC8eraVVb
         rl+FoCcvVkWgCk7kWPlg+fID0tE9x9FZYeRYue2e/R6S5y8NmHODTwia47wNVYIR9JYM
         kKlylL8qVRUwEftxMj692gnTfUkAZbmXB8EFnYbgH9UbFsILIBp4ueE0excjSF9wT7Jz
         lPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333996; x=1794938796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GzOxYTq7EHxh8VUxt5+RHjpcCv/SzSEIP5xLxXIbEDA=;
        b=xNHG2apn4H4kRgiZh6linocoQNp1P55LKn5TMwyBD1qVNKA6wrxu2eP4U2+SJ4iJyP
         Cze0VXL7lsw9gh37rWBCUrV8Ogmk8sYA7VAwdYOp+yCCX0r13S7Xd7y2yr6SfU6JonAR
         j8RPURY7j6c+k8WTUlNYAItI6p7vDBYLS15EEQuy6kozlcHdTr5VqNO7zBEaJCTrEgjH
         6Pu+KVrkqQBd7cwWVUng8XlioxGSkMQ5EO8H5DHkfdxRWp6N9KLPDsMK6+HxwoD0vJRF
         D7k141KPXoBCGq7Ps5LgC5G3/M/mskzGtavZjk9DHUTH6m8IR2RPi70oTERAj1wLrP7G
         Zt0w==
X-Forwarded-Encrypted: i=1; AL+hErHjBJ+OmgvMkp9r8MGe/Wfp80aU2LSPvzTPI+qLXzZuAHbqJ69z2a8SP51Be7o+ljLJBpzVo7k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fS6qYYvPT6u1+BDKs/LBh4FZHeAF0+9cWYVoRv50wm1H+rrgr
	dvpobdfOxJHA28SprsFbCVhgqhz/QDKb4HyIfcJc0Kg+rKcyw/r8IzW/otHSnryhoEp+6I8f1Ta
	ra7RilWhfC95ka2iIHy4F6cNKOHzNIMCiTwZxGPTpsWYYcS8qpxVNd3iUqZk=
X-Gm-Gg: AYBFou1atBDySRxWxHf5pYH0r8o6XqZ0rIy3BjnmYwmTTectyxf1Gf7y2WmJ5Rsdmc1
	nIhS2W5BQ7nE53j86rusPPfkx3G45kq22kLDP39k/YL2tvV+plyGHeAOX2mdO13r0g7hsxiHi48
	LZ08s9duBeNDHzsEeEwOjJITQV2rNNRgBql9lKsh/L41Z2rF/dbIvtfegxFF9FL+2JZLQe8l9pN
	kVPpowdg/+tj6+xYhUqaWbrCyVZCTEqPb/gVVcivZVKBHqYEhn/P7xXtXoTw6pj9w/RrzHAQOwd
	mCOozFyWIBvpVW+9zfXu1Sen7HJOh0hGs/RCRkcakZ9l1ooFtFg71vYPo0fOuTZFEIhPQLbKoXd
	tNKYUe7KtYWcTfwCzE9ImozczCSV6SAadCtWkZYHSxdjsTPuzSIi7Y715IrCAfre8uw0FipS82I
	l8BN9YKD1pzku7nFBtRj0hCLNxkVtIwDLYM56FDp9TepIhej5pycHyYlzjjE8DD1N+MBfdzqjse
	2lF
X-Received: by 2002:a17:906:1248:b0:c50:4a70:b7f5 with SMTP id
 a640c23a62f3a-c504a70c977mr195279766b.17.1794333995965; Tue, 10 Nov 2026
 10:06:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105141006.95083-1-alex@badcode.im> <20261105141006.95083-2-alex@badcode.im>
 <avNM9dfdW1uULJUf@zx2c4.com> <a979d36bb97608275f9f8884764afd41@badcode.im>
In-Reply-To: <a979d36bb97608275f9f8884764afd41@badcode.im>
From: "Jason A. Donenfeld" <jason@zx2c4.com>
Date: Tue, 10 Nov 2026 19:06:25 +0100
X-Gm-Features: AclHuK-z5kRyS093UsqlUbVg9AjVDqYIwR1bFV-l3asgu02YzQT6xz0LvKo0raw
Message-ID: <CAHmME9pMKKw-1dQRG5OEYrGA4K0GGFbpvN3Go8ZuVKLuaNMA1A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] wireguard: account peer and allowedips
 allocations to memcg
To: alex@badcode.im
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Okay, I guess I was just looking for some judgement discussion, not
more output from the LLM. I'll look into this myself on the slow track
for a little bit.
