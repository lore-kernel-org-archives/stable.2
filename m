Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716632;
	b=n8bmppH2jKcyyTa8XbcB09vpT12EmFexM6w5E8z82O6e/XMw8OzimDwAlaRudDk7sypO
	 ypJLKzl4sK5HoU+yeSx8xDxi2HM3Sep0PpgF63UIKyb97UEAW0/INJ3PRw5ZCdcyYnK/T
	 PrPM65vQo4VPNqdoTc7VgGs2XXzekWm8+P7Gp4/IQVPwrN7cIMAcdos8z21kGeT0Lu1tl
	 H57TlD3tmiD8ywYzpALUS1HxSxZ3krVJF5g0br5JdRseNK+csyjXeyqoNzmP514Xb5yZT
	 to8r1HKH1kUN7pHhrU8I52euiPCBDHIbGxB4epC0e6bspz5NQfwzcoVhi1ULojJ8eZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1gBGEBA/kCwvv6nk9Cr2bAVirfmjgnvI1gsCajKX6m0=;
	b=3GJ1SNZs+Bpmhhfhm2s+Rd6Dpihb+dZMPjFjEiiVqvVXzJN8fqgTPmj8bmc9J+Km7Q+o
	 Nzq1aWu3KHhXjctoM5GZDAkGAnT0nKcTelEGXITcCB+b1HPGCLsdc/kUjrfrBED6hzgpY
	 3iGmH5QKmipsLn5wN2aJSSsgz1wYLkN1rkYx3+P4TfI+lDiQuEzJuRok3ItODTZLRFTmQ
	 eDgTIx7x6T5fYgfkaIdH+lKsjmDOIR+gXk/zxToh6xM0gzp4QkqO2Wbt4JdiCk8iEuAzn
	 HiNaUO4Xm4RsycAc66OQxn7dEpqQj0DObIz10BdObI206yMK4fRghwMrWSyVssYMw+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrp2S7rC;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4F606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 04:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56D4F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrp2S7rC
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso2974532a91.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 20:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794716632; x=1795321432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gBGEBA/kCwvv6nk9Cr2bAVirfmjgnvI1gsCajKX6m0=;
        b=hrp2S7rCpc3NtC+9tEUSX2iT1GBBANgngGjdkJvbFsoSD4a24/oae1w8tizQ0VWLVd
         7tSthvH7ce2wr1TIGSob9YvRd+xsl7o9eWfOeElAdFDcJE0Z9xmcS8X56Nq7s1lOblVH
         FeX4aA6J2pIsDgdx9FvBLk4zVYEUVIlFPx73bA9DBJ4yflep0HPhHAdl/+gK6sa/mArT
         Sew0Ob33/iw3xtpndyrDmEvnTrKVkg5XiKHO8Yfu25XRQ4/JFG7jHPGemrzGU4cvKJhZ
         zAUhsiaPyiwjGTXnaQzylAw7sdhVNRFdOIyTJ6C6NBYycAmNh9csYvqXW3awfBG2ptOK
         G3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794716632; x=1795321432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gBGEBA/kCwvv6nk9Cr2bAVirfmjgnvI1gsCajKX6m0=;
        b=DS+9QYpIt0aGVjL+cbLczEMCqZTX2V7X0b2u1qOjf0Dc8+XbjQB/dKsYQHCTv1Setx
         7yCjCmaIgJ8muq9RC8AiYSYkuIyQ9o2JHLJXOKULJ17j53zdxVeDEnXGB+HTEq70Igml
         SCLvKejets16HHVXZXG1jA7Z+lRYAX1JpEXAW13iaUxenwbssQNtFJkM7QWZfP5uYTPB
         5c0tr/tMKOasJNT0K6PFCY2WGnpbq+ANcAy0wZ/iOeWsZvGOO8w/eUF9OzI+OyWevlww
         7dDtJ/S+Y4vYJmx62SggMlulXkF3lwQ91Ug1wk/he6lKMH/VsTWaTKYlweVv6TGhNNtN
         8Xag==
X-Forwarded-Encrypted: i=1; AL+hErGQ8SwEeZaqkEn+xr6Wmm26svFH1TlYCANmzisHZV8x2WQ1e86aIIs95DySplKs2QcM/mti2gk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zAIoSFGEc72G08k319DXVbEWck/bY4bcYXksM8jvsmAjVnTwF
	pqg0IY/JodLVewg+X958g1eMq74nH31NPaJ34Y3JCNMP72GozXJxlQHt
X-Gm-Gg: AYBFou38dnhYS3v61MlH/wNYTw/npzBfwn0N6cTeCL69Kz7jkhD/djs+Tk0Wg+s7iav
	JvfYhUbNPZmS9hc1Wb1PeuFG9/04yMqk1F+sws/vuPWDg6U6kGu79T8wXRwaKqZ/wwzieV51s+5
	uYq4EU0HFPJsZ8zzz9uM3F/pWU3q98LtRAperF/l/Ymdq/Ig6lGt8NWCB5iE2nQRIrF5H089fDd
	7rwdqsVPbcupcI3W6M42sAwOJsCmYfjVzGgxtD9aoh2pa0lJEJ5GAGUUTznr1/yHmTnF8oPMbHE
	pbG2kjYL3Uxc3DrrsNK3VgrZaOnp44JUOV8stdbFkdC1tFbltmXeBvhb45CO4g6l1MhoQ8NCh8F
	Ft+b5Vb9WuOchxzNXZNZnc3x8rG7u8u02vGDPqRSVPaEbVZtYDAFX2PnPmxq4SKfLIZxCs+3gf8
	8J72oBdfDuOwC1A8EmQR3JaESkCZJsRzLwGheuqmKSmQcVz+B3QVe4/aSeYCw3xi9Z1m5SxTaA7
	jWMxC3XP/HfY35paEqi54xlgl2cEVoXeXULV/VjjvEr7uEH733ITUv4muI7/x8Da4cTZZOjgwEu
	KSWx/d48J08T0nTehZWcdC38b4d2+1Bj2dqS0Iux2UPAzGbn7OEJufACZcScp/PvfG6Xq1und+E
	aailufRV2CUOR+WsVce3vGzJsVEKHteDmr0wNsLnvQlWmhj7FGfS22rsC+SnE59cPy9elxaUcfL
	9uAg==
X-Received: by 2002:a17:90a:c88b:b0:3a6:e901:e79b with SMTP id 98e67ed59e1d1-3b1b0b665e4mr7165716a91.15.1794716631680;
        Sat, 14 Nov 2026 20:23:51 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae8be5adsm10972872a91.0.2026.11.14.20.23.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 20:23:51 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: fix use-after-free in current_trigger_store() on concurrent writers
Date: Sun, 15 Nov 2026 14:23:43 +1000
Message-ID: <20261115042343.87716-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114235118.4414bd1f@jic23-hlaptop>
References: <20261109095728.59024-1-yuz08559@gmail.com> <20261114235118.4414bd1f@jic23-hlaptop>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 14 Nov 2026 23:51:18 +0000, Jonathan Cameron wrote:
> Probably goes back a long way but please check and reply to this
> thread with a suitable tag.

It goes back to the original trigger code: the mlock drop before
reading oldtrig and putting it is already there in

Fixes: 1637db44413e ("Staging: IIO: Trigger support added to core.")

Thanks,
Yu
