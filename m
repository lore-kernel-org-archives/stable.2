Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932186;
	b=HfmrukZTDoi8eqGICFUyhK9iWt5Vnkl+Wcb5lcsfmu+OnY/szx8CPLAVbYjs1mMLyj0q
	 1XlQjY3sEuHRtrJm1OEg1v/8dPeYZJWGCUwON3TbxEoRbHXysC/nQ95c46zXw8w6TQEdo
	 1sJhGm1r16o6iDjONCpReZ28Ya07VJnXJrmZiqopXWAca6/I/UBxi79Xk1+YEdEeAYmWu
	 6rz063CeWtaR8g1oPqremQH0yExtSEJmhWo4TXkgDv2xu+7i38qE1iURa6NDmW8TQHHYI
	 y89Iq5KngnbhcM1zrouATlIF3JFjuXxN8GDWUsdVPXB6dFxJO+rEedmSscJD563mP9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3epTVbKPJVG8iTt/z4MHuDPL8RwQKn3lHAOFYRFX2uc=;
	b=r4+HTOts7RXF2lrbvv44zuZxisaUUpKt+enjKR+fldGOGJ3eyxPDgQVUkcwybcdhG5uK
	 L8xj69yumUtP4AJIg+GNWnreqY6gTWiZpDuT2/CiN053aPwlV5IBffiPckIL3sSjON9YJ
	 GPFizYmkvmJ0N1ZVdajqHSRBOlFKIAzRuRbR6RN7rxRTzFkJCE37pRTvKvRfoqDxzYh7N
	 DVLHGaAMGK8xUgq00Nx6WmLjrwS8AHTf6wrXonngk0/9uYatUu34+RP1Q9LSdY1jJ6WMX
	 VcIdaYtLRR45a6ZDYJ6pb2IvNO+md4hgtNYRlyDFNE5oxlFVGG4WEJa8XM4zj1pBpUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UpSR2Myj;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919DD606A330
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 919DD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UpSR2Myj
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso6095343a12.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794932185; x=1795536985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3epTVbKPJVG8iTt/z4MHuDPL8RwQKn3lHAOFYRFX2uc=;
        b=UpSR2MyjHvrEaRxBPQUaVNwY5hXBUuG7pyxygzHG8O1OlkFcTtvImstuQRqRpLBA4r
         d8ujp2NOgvsfRkCgBHT99e6DvBL3yjoZG+IRzwPN1ecpq8Zu1gziqA/LJJbKmUU32L96
         +j5J/XDhamhmyebOPpBG6lvLVHypiH9s5zxH4yI6N81cQPeunv+Y+9WbmyCs01sxiCoX
         E93SVwIf7wxbx0XWpPk+aocZMK9ejnb/JEglkxAcxqwse1Z8hwdGohRj63Nd4/PwWHJk
         /kSuhuk8KNpLagBGeAGXgI3LSl3mMI3oB4+FQfhFlZpxkA8lCcHoxW090cLST8CcTcKZ
         OhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932185; x=1795536985;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3epTVbKPJVG8iTt/z4MHuDPL8RwQKn3lHAOFYRFX2uc=;
        b=yoKNyLnyXa4Z0A2VEPFzmgFKUdljwZpzji+l/rvEzYl5vLvzcVPordh9SeGM4EGcGQ
         COr2beJv22vjhlPwu90t0l3zD9RwpmHhc/Hf8G9egTWpmCi472+vPxVVl4ti+IvGbi4z
         wHiwm8YPonfgH94Cwp4QKmSlaJjOGSWCnRLtzRCJ2kMsfAf4hgEDAtWmIqKcTsKueaBq
         630Pat4PxxE/yDDKhyiCMtinzTlYOZGOslZWQEJU2ce3EbQOSkHjDl7OxiS1GTzos9VD
         BqlyMNofC3tVpfFgxS2XY4T9a6Qfl6xCXmXjfzzMmOfZahQbM7wJa+xuzfWdLraEv4RU
         mwbw==
X-Forwarded-Encrypted: i=1; AL+hErFNxsG2M5tEv8lIqY+Z1QMgybZmsfE5Qf3SrBysW0gYIp8ekYGqD13dV+v/Tgxeke6ew/dcy9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NWA1FTxMN85UlhPc3/GBKUUzV6s07XefhaDmok5UgKIEQyHmr
	ZdF+P/3rEVQtclJuQfDpX6Pgo1h0apOqTGsehzfYF53YQbJTfWlOkLqsxCTt7kM57cI=
X-Gm-Gg: AYBFou3VEnr0lwChx3K7FHYIkBBHs2ubNkAd1FTCnCTyKNA6F4gVwjKQI/x9HCnbT6g
	sGBfNYUksHqiRH5fFOY4kdMFPdhrw+IBrb0cpQkkFCmbWSAtssZvaV2vB6WgOimSD0y2fkMXzSu
	jeJLpCxqf81IJiAs14jCPGRO9Cejn7GRqsATNz4RNBwR/iA1htdLdkrTYgMfU+xWswL0+zNcyLs
	imQCd5sBMYcJG9OJ7HN6GEQone7bqOPAR5vdiD2qVpKDzfXE9fl2+3YKbUz28zd+4yWMjRaqqbm
	S4HIr2hpR5kqSljTuX8++j4i5vnCMP0FVwVEj+sWYO0KDeVMgxfJNBsHbdlBrAKjBCnPZKw0556
	25LH6B14W7zP3GsuesPFbXv5jA54kpBQrkheAtaCZsCjWM0EZFXXOmrJaeambqbpvpyU3uvoeZu
	lD5Lxtvqp61+eb3/NaXhQyl8H8tbROkh5r3pO9R9Jeyy37nOKAn8TPwRWqb6AP8zDcpsMpzm2gN
	EE5raHJXeiXsD7Nz1r/hNU4MZ0gB0XQI2vmNRfsAUo/A9HjwD+x2EQ9q+VxJe4nkFxf+idNS191
	+GM5aFx17kGM8ZyMruZ4U0u6tIjMIQ2PEuhNMIEhuaeoezc=
X-Received: by 2002:a17:907:dab:b0:c49:df8f:3c79 with SMTP id a640c23a62f3a-c50963b88f3mr1191532666b.34.1794932184976;
        Tue, 17 Nov 2026 08:16:24 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab33aasm857666b.52.2026.11.17.08.16.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 08:16:24 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	ihor.solodrai@linux.dev,
	tavip@google.com,
	maciej.fijalkowski@intel.com,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH v6 bpf 2/3] veth: use the frame mem type when running XDP on an xdp_frame
Date: Tue, 17 Nov 2026 16:16:20 +0000
Message-ID: <20261117161620.62739-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104121316.1155680-3-sst@poczta.fm>
References: <20261104121316.1155680-1-sst@poczta.fm> <20261104121316.1155680-3-sst@poczta.fm>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
