Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335503;
	b=wLJnpOvlgB5CcmaBfskTJGXcN99voGlPqUWNjd3wEZIykTv2tV5BUWJaaoEcdWbIUuA2
	 g0Srx0tI4LeZhrrkgVL+gS31RcJKH6AC9odFdRrk4t1OsbF8FshntRx5NmaFuPN3g3L7j
	 hyGMuMa/QRCMGyBH6uDxlzdFwH/lmWrJPLTaqZUcKAxeJhzSFeChJ3ciZm/0Dwp0iRuax
	 to7NxDP91Fhwhhhg4w+13rsa8MQA2EddEn3Gzamk8ZXTU8CjHRO1aXIDzGI6HtrQbE+xL
	 Xcz3yQBYUEgFCB6JWfYfYt6AFW1JkGaGZsxCvCGxlf9bj9Dy3PnD5XZO9rbgSmweJKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gbmSihoOxS8+qs59nCpK+zlfjMhPtRlMpwSw2IB+/W0=;
	b=VBoR+4obUO5zWA0jCp0vycEO08G2RI3yA+9Xw0R1KzXgK2XVfrfKRNNWoUvG9U1+s4U2
	 bgWRX4kOzEf+zCXd+QWwesLrwuG8b9SgfeupP8EW8l5dQ2BnVFL+/fPkerh9WMX26hizZ
	 LkSCyTZzQIHwU1W1Nq6ywJX5rllKTEL4xk1vuhuppwbKELmCSIKkq5nNE28jyf0p6mc+c
	 Mvv9fr1y9dix289Lrqqsf6c+PvFhUAJY1Vfq1B4HQRfOZJ2fYQ0j84SQNrOITS6fVA4y8
	 +xl2AubuciPRFB6TZg3qS63ppP7sCOlmgARspjdDUFwKbGtYR+FlInT/kPs3S1/uyNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=PrOoXgqs;
	arc=none smtp.remote-ip=209.85.221.227
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A6E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=PrOoXgqs
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so1514401e0c.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794335502; x=1794940302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbmSihoOxS8+qs59nCpK+zlfjMhPtRlMpwSw2IB+/W0=;
        b=PrOoXgqsL16lXToUusS+qZtwaT9GFgP+vViq0F3mVZQFv7CrWmDImxCxt+zXsZ0qx+
         YiXhWN5SgHr5fm0c3l5BzC2qjJWycSrk0a9F3qZnWt7N/oUBOQe1Kai1gCdebQusUB5u
         9Tw/nFtjMwmCNxZGNRAc3O2a8FUFc59A9v7l8dSqdjPMyVpMVoO0OTtB/C+CeWUS9Liz
         7z+EgoDRaldwa2csFNLGRxndgakbHAf+SMqwtnIVHybiA1tH/IyrKghBsptuIod2i4oa
         cBV0GFIe35W/t0tQnJKwNBo8e+hN+Xhxw6CQggTTZxM/rbNamOaPhkIZoJ1nXUHoyftr
         CjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335502; x=1794940302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gbmSihoOxS8+qs59nCpK+zlfjMhPtRlMpwSw2IB+/W0=;
        b=W8+a77Gi7EWOW+FY4XE2GUJ+301IaXEwgRBeLESsVLWMMmkHHH+XiSpMHa/r9OabMg
         Qfcu2SFqonIMqYc9TYHPRV32spoevJ3Tfiis9KzV+5XUK9Cut8l8nJw+cS2EYf6nsIf7
         kHR9P6xEu0TMKj285aGN1m3EfViW2S5fSMaAgbJd3UE7hzxr5FMWBx8ZaSNMN9Y6bGcQ
         dfBwWAPePFdhDJeAICf8S5g3Im2T27mElc3aTB/VbHUhc2AzWKzr1QCZUahQWudNuRnh
         rOT9j4wdOOgbKRBZ2MYgboK5HxvlQmiObzDx4fUEzqX0IphQz7DRT93gYMeb78ePnbzZ
         0Kzg==
X-Forwarded-Encrypted: i=1; AL+hErG2X/L50fmmfPXyHhQbbJKYuiS+2ArBaJgIjnniiv2/a7x2rG6mEgYaRiTpiALDtLT54eC8qko=@vger.kernel.org
X-Gm-Message-State: APuU4Z95dmgFUXncjt1HzbKQy+hcjqMTbCiTCzY5P61BEndXneiWTNEW
	APjMqhUpa7tvte+87dLKFevAICkywnTqBT+vAEmNslrmJP05+tSKIDshqYIpKB4nAyRWMzP5dlL
	Y7vm7DMYlsZD6xeOu0HVNJFBcMBeKL/2cNjWS
X-Gm-Gg: AYBFou3KNbOjA3StAmYKhQDH3wZ7Xz4dKplF/aRAEGCLG8kQFC5G0i2GbKjH2F+GyF4
	9Vn1vZKJAiQ1l1KF1GbADowADSRRJ/scgAZTi15xCs2oKD1H61qABlSejTOD6ZKIuFYYN4Y4oTD
	MW/Je28IJjW5OQKoeM1w3o8fkyj2wEGHViwOUyJNkCPOdxavZRHiNb4fXy2jMmzaAiceG3nKw/0
	Uz9wg7+tQktffx++q7sGQ1hLePhSe4MJ1+n+p2Zw1ZE6X+gm/B8IwAOPFe2BbKxxRMnsu12qrh5
	YmDFc/nfRitxeUnUG+mo5H+2OG5FEb1xrFcUjJHTVtvJQgUXdHSTckmeRZ0ORJ8QSfNm+D+cXVA
	KAtXqkkuYHkk7tzG+F7YkifJP49O1zhO1WDcJcrs=
X-Received: by 2002:a05:6122:1313:b0:5ea:e197:93d9 with SMTP id 71dfb90a1353d-5ee0d1b1687mr1626172e0c.19.1794335501776;
        Tue, 10 Nov 2026 10:31:41 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99c203e7280sm176166241.16.2026.11.10.10.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:31:41 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 108DB34039E;
	Tue, 10 Nov 2026 10:31:40 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: cel@kernel.org
Cc: Rakesh.Bhargava@netapp.com,
	anna@kernel.org,
	ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	linux-nfs@vger.kernel.org,
	mora@netapp.com,
	slingappa@everpuredata.com,
	stable@vger.kernel.org,
	tmenninger@everpuredata.com,
	tom@talpey.com,
	trondmy@kernel.org
Subject: Re: [PATCH v5] xprtrdma: serialize unmap_sync with xprt_disconnect
Date: Tue, 10 Nov 2026 18:31:39 +0000
Message-ID: <20261110183139.1742129-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dce03323-90e7-400f-8deb-63010d928460@slotpi15m67>
References: <dce03323-90e7-400f-8deb-63010d928460@slotpi15m67>
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

Thanks for the feedback. I have incorporated the suggestions in v6 at:

    https://lore.kernel.org/all/20261110182727.1739245-1-tmenninger@everpuredata.com/
