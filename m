Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716264;
	b=BtkQ1/hpUn3EdJ80K8rOLT+BmOTSLy34O3hySMeFZMunjrT2xBmt6cB1N4xwRAnb2MD3
	 A9RIO65oQZhuKC7GpWTisikmlYPqTYqU+mtkmw5glJE/n08LGNZ08ZBYJY0v0lmsr2xAp
	 7QKzqDvsDk2adE/RW31aJl3U7hTBLBhovyBAHGj3oJxfIQ2HEaH5S05X31iBA8cx8CUEu
	 t+zjPDEDNny6e/oDlMmZ7Sf1yzTx9oLgxIHgLcYVRZLXBAB71+oom8WWuURADZYGM4g3E
	 t1fP4hm/X76ZZCW+syHdD59E/RcZmKQnRiNVH3NvSDMDby08PsYcb8YJ2ieJOwg4k/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=LHkHgSTWm4PEAV1u0V+AYcuaS0pJzqhlqARjGallgdg=;
	b=5KqIBJwm1pjyCVVZLCE4eM9TcbgKf7jcdIMMj3+tNAasouJfOjF9AflwF5HmWxpbNd7X
	 B7RuJs8KOZGjPg0ZWxdNY8YdFfJdXpyrz0zn9MUOSgLxdCXN+iXnTialqwPtsGNQEVg2N
	 qD4C+JvUFnilrO++6tFNFYpXe1lhRFjedFpQET0qSH1Kp6YNOrbblCIE0uQW5AL/8HiQv
	 xp6fhPEoKZPeXTEPpLJR0FNcIR9OUFkd5zt3kIcCIxMToLPcoljTLjS/yXoulCMo8G3NG
	 y8PAVsKrCSuLHu+6ntJ503rYvitJHlXBNkUFedHL0rGGDn56nIv5jbg1UfZN8SmwiSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e7808rs4;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20634606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20634606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e7808rs4
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b1ce85287aso2175608c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716262; x=1794321062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHkHgSTWm4PEAV1u0V+AYcuaS0pJzqhlqARjGallgdg=;
        b=e7808rs4tVSou2aun50S4+VlSYTO0R6/b2NyErLTAX8IvZXOZRxNRa6n+EZtxNh5mV
         C+YfuxFAoY9E4LmCpswZmQh72S+rdlLnf9PEOOzqHP8zmRGP06rlzdxitRZZJYaxkwjn
         2moRf6sOhZ+/HeDmXqfkDjuL54J1XK/s4d+r5PRaoP3rC6j5gA1O7hJ8QvZxXFbgZ4iO
         hnRZ0EU06s0fpYYnwiLpkMo17fdmysqqNg+isAaWy3/e4PCc1vZo4M/TdHcvF042Dr4C
         QmjeLlawn7WvGtjF3ShK8yqiLAkdazD5OTOJJ6X/5ZjaygNDpAK1gCUvZg50QlxPzSJ5
         9SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716262; x=1794321062;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHkHgSTWm4PEAV1u0V+AYcuaS0pJzqhlqARjGallgdg=;
        b=K++219xw8FsGGTDIfFp5Ono0SBKNTVEhi24f8XUCZqPuQLeI2OOKaLcIN0rk9CpJ/h
         Xuo6Kxri7ugOM/oDWLNtuP0P3RwLblP9Pf3oVOAJ+j5buXxW4RAhYe+YPq90+L5pc4k9
         qoR9ktrqTPBsjwHSmnyJzxhGqdOUMI32Ij0Pz0eKgdpn+zzf33XkqnlnXFZG91mIrpza
         O6fFjjjAdE014EzxxcmdVTa2VN5FPRLApV/jW/W2tYsVquLOXdzy13a3/nVnHgp6JNuc
         5fqRe0/eLEaqU2GSO6iaOTvuV2Tz7iXd3RXsoKGxFiIvj3Ukly03YQ2rQpoNrkVxjcnT
         D1aw==
X-Forwarded-Encrypted: i=1; AKwUvBzDByYSr2/1lbekIcIb7e8yluFaAkVRrhZyQYZGaK0LJ/UlAq36NyfyOQpvBIHayOpPO5BI7hA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jwYBJlwEJxaEj0if5T0orSoGdivV6Nx7GWDSwoHiYkj6gRIvI
	BUVbdvtEOLyScAyL5+HAt8Igi/RME5n2s6qR846XhiN3G/QVKQQHcyDetdwmm61yizgutJMylv3
	BxsTybXc=
X-Gm-Gg: AYBFou1HZs5hHD7cYseImtp1fnPrDfJHrqoghku2jxeyFOPKP+cWb/0TJ3/VUQNShOd
	POaJNR1E7MMIMfrvpE3uVLH3EQsSzmWcXdVBmKV9zxzyQ+T/RdrnfAUiYAXrQpe1/vns24Ac7N2
	XcNxQn8TcNIUTAw4M2egJqdsQ9G36pnb1YRXPs7zfMqSzwbU2+B7xf0RTrTaHEVrRoPg7hdNdxF
	2CD/QjwEXxPtAwiCRz7Kc7pJs9aShc4JoArP4+9PpKVUqHUkYN8/qqxTmFQvKSaUBf4pm2hiSgD
	BQCMGB5Kol98JBoto6aR8PKFx3ruPiwJBHUre8kt8+f70GZyyJO+apdm4AZRegaw4Efav6YgZVp
	4gTwpg1zc3Ct3UZdsXLfN1xQ1rMW57jnt7hSQDpM/hNWW9kBbw2VA/yLXa2SDsrqaeLyeeTJGSi
	yjXnqfQSiAfGub1U6sAoYRnJu0t8/QFhXxCfYlKmWWTWV92cRXQpxR9bybunVCq3qAlbuKIji1v
	tWKL1cWfVdU72Qb+WTAsZPH74W2T9PQEPygjjYYJM/34fcZW3RnJtPi0vaUlPbEF1+L/57GDSzO
	QjfDBzQTh9CCUCVj88rkq8ujiWagDouQp2WM3YPy+Is5tcfpXtENoU7uZ3cj6O32FuPWFb7fDEt
	5uCB9C6XVqUyh
X-Received: by 2002:a05:701b:4542:10b0:1b2:42e3:e5d7 with SMTP id a92af1059eb24-1b242e3e6f4mr1359237c88.34.1793716262106;
        Tue, 03 Nov 2026 06:31:02 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
In-Reply-To: <20261029200110.1328103-1-ebiggers@kernel.org>
References: <20261029200110.1328103-1-ebiggers@kernel.org>
Subject: Re: [PATCH v2] blk-mq: end the request if getting a keyslot fails
Message-Id: <179371626131.3691261.14610016364741901960.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:01 -0700
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


On Thu, 29 Oct 2026 20:01:10 +0000, Eric Biggers wrote:
> When blk_crypto_rq_get_keyslot() fails, blk_mq_submit_bio() ends the bio
> by hand and frees the request. By then blk_mq_bio_to_request() has done
> the IO accounting, which blk_mq_free_request() doesn't undo, so the
> in_flight counter never drops and iostat shows a device that is 100%
> busy. If the bio went through zone write plugging the zone stays plugged
> as well, and every later write to it waits forever.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: end the request if getting a keyslot fails
      commit: e67cb6ed40e7f45912b63d7d575f18dfd2ebc98a

Best regards,
-- 
Jens Axboe



