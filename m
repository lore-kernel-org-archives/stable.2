Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557118;
	b=h5c6270jsVbil5/o2QczbbR6+JwjRoEfXRf+PrgOt175h7ZnnG8w0SKAoMEMsWCUi6PB
	 bF/n8ult8qubm7pNssxc8OxoO7WtDuAQ7M/vA7Te8jaOfGCEamD0gvJ+4TiBZNK4HbOoa
	 0pH7eGi29brGjGnO/3Ec7tbyrMeqxhztfuNanODuvc9wB0ZUUFPk+ASYAU6PFZjHWHxpn
	 F8fMwoz/lJscsnal/+o0fmr5ydY11DoIQZeQAbuKtNbv5oEIjuva2IdtaMYsg2nwv/fwL
	 LxCfXl0Yv9HObdL5N3m8T3/u5Mmm6m2W2I7OVYveGiNH6mEnZpG6h8/rePK/90wm/uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m0dxOe8vy7ZKObR4eQwVjJK4jXbzDOG/YuLGrV68Qbw=;
	b=Ds7N4Zs7NHD39tA53nLl2eSl0QHUOwKbiH5MkOkEFhoURPpQb/DTgMJ3gRL/lkHzGAxP
	 hHfUD9KIk4fhSC61GOeWeb8H47R03FghgF0tjhoecAqBE7P16neVxYWAqdyVw25gyVA3I
	 XWjZk63fi4bfy3OWO/xChp8FrDaSdjCYX7lHM7nsQX3IcJ1jBk9PzT9DgIQ7bgMHBRh4H
	 Q3XeRZumaUOobFDIR/OqTxcHlpHfD9sz/Fy62xstXWTwG2dIYlchiJ1ah66OzgZbvDDyr
	 C5BRU78WK1bMrLrMZcwKTYt+OKzyOmygq2PlKSDKc35Ev4BPcoQPI6ZQz3ykrJ0n8xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=VUqZ9o90;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD8606A33C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4FD8606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=VUqZ9o90
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so7247358c88.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795557117; x=1796161917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0dxOe8vy7ZKObR4eQwVjJK4jXbzDOG/YuLGrV68Qbw=;
        b=VUqZ9o903UUlmH2Uc9V7IBWLGor29J4VpABq6UTfY+1D+zvs6MPS7A+RYLAPeKl+yH
         My2/2gMmoj+di3Ys9ySOVLsKTSS859jStTnMV6HUMYoRPvTRnk8UsjwpRVXoMdktfZ9g
         qBPSPsa6wOK98OSR64DbsGVZ6P+AI0VqIHIPQr+GW6MI5znMZBsDcMwqLfdN9rhnqB8p
         d5FbPIXKtjFO01PwguzMp3EbCSXFAK3mvmPv1w4kvBt6gS2GycrfGRs8TlUlu1qFazkB
         /obj40l2WLLiwLUrDAQtE/MYbOVRWTiVbyJE56kHaKBgMV3jzYpBtNWh6RhUTdt+G+RX
         li7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795557117; x=1796161917;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0dxOe8vy7ZKObR4eQwVjJK4jXbzDOG/YuLGrV68Qbw=;
        b=YRp5+k5Wl5BYAYeq3gEcWpN/70iUJQ9Lh2ebzji9rtkRo7H31sFv0M+Ibfo5hiqh+K
         aOzPPgdGtCx0RYjOV0/pIGrSiOMJi8lyLiJrWVnNDQ/vBaV/4Blw1g6wbdyNs1cSgYGg
         +3MBwEZiTgamxLmnGixD40FF+4wnnq+GDL7FDLa6v3jmhiJAZHip+JxKvNmSp66T4xBS
         4aZW2qiwL/Lmy+/KzoIoIZb8KblhuLsO9k9xFzNTxsOgXkfRKYJYO4tODwSk2h1xdhd8
         BOByG1Mg0jMNCoi6RHPZfgXTH9cH+ahWkKkIYPCeMzGqIwegpC7PNgJOWaduW3IKjpb9
         whEQ==
X-Gm-Message-State: APuU4Z9qOrVS2f1QGMLw4FFCxpuBqEQ1g8rB9U3KoeeG3M+H9A8Ngp1c
	9ETkHsKv2erC11XM5P9uWZ0bqAX/qfkSWUMVa4d2f9LbsrBNJ987pxg/9D7/OlUFfJbB4KyFWzm
	pM+vr
X-Gm-Gg: AZFdTZcEuP7U7U+p4eXN7U1lEYaWpFkMbdBVgOGF3kkboVYOOqMFpR5VL4t0w5ofEsW
	bHXJBhpAiHueBssVZTLxi2aqiKJkgwZuAj170rtVygK5NqZydAlZukeSHbJWVdfaI6MDL4eaA6M
	ILZLb5lS7yFPNRwxlQ4dMdq3h3Kk8A7/qBJYhiz52IaGIDYTzTzopwwtpqfZOY828Gg2AaKf3VA
	PKt2QVXXJJ5I3EAf/OOMBOiH7CGMaCzw6MCxJxtt+eXZE7vyyPftgfMoXQtlYMeGmzbhnKDnqwy
	3QFIJ/1kY31VxEC20Ml1L5DBaLfw76ijZXPFl9SO20MeqhQlbQWP5nimfQTSxSKtJxYrMIFEMOq
	lBM8U8tzLLzuWKQNwZpFnTadlrL6pXHuhorHASZ2IefxVOnezhietTFtjzHYNNsNgaRjr627Pmy
	9zbF5PxvIkihdKXUwVJr8/w6K19ImR7adXgMLSkf4+1m/+6Upm2AlZnOH1+13PFOC48mQRnkpSf
	zcBV0NHOaSgdpartuiIj/jPoyW2XM6Hh97Qf4veVVXJ/Aykm5WLeUfvmQSuZGajWSlX9/kE9FrW
	L4dtoENFS2vvLC9OuvryWbDvkNFwyZNDHEh7nJdxwI/bLQwh4bcGJ6+bV6NpBeft8yvQKvMqhe4
	j1aF+RCfq6s5eBBzTzSKwwcvt4sEZq1yEWrdbhtQYhb6fjvU=
X-Received: by 2002:a05:7023:b18:b0:168:3243:c937 with SMTP id a92af1059eb24-1b5568bcb9amr19336582c88.16.1795557116769;
        Tue, 24 Nov 2026 13:51:56 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm41362637c88.6.2026.11.24.13.51.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 13:51:56 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: damien.riegel@silabs.com,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org,
	johan@kernel.org,
	linux-staging@lists.linux.dev
Subject: [6.18.y] Please pick greybus raw write-after-disconnect fix
Date: Tue, 24 Nov 2026 16:51:37 -0500
Message-ID: <20261124215137.40304-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Please pick commit 84265cbd96b97058ef67e3f8be3933667a000835 ("greybus: raw:
fix use-after-free if write is called after disconnect") for 6.18.y. It
fixes CVE-2026-53024.

An open raw character device can outlive its Greybus connection. In 6.18.y,
raw_write() can still pass the destroyed connection to gb_operation_sync()
after disconnect. The fix serializes writes with disconnect and returns
-ENODEV for writes issued after disconnect.

The fix is in 6.1.191, 6.6.160, 6.12.114 and 7.0.10, and in mainline since
7.1. 6.18.y received only its companion, upstream commit 983cc2c7efbc
("greybus: raw: fix use-after-free on cdev close"), in 6.18.57; this fix
needs that commit for context and did not apply to 6.18.56. It applies
unchanged since 6.18.57, including on 6.18.65.

Compiled drivers/staging/greybus/raw.o on 6.18.64 from a cumulative x86_64
tree using allmodconfig. No kernel boot or runtime test was performed.

An LLM was used to check applicability and stable-queue history and to
draft this request; I reviewed the result.

Thanks,
Artem Dinaburg
