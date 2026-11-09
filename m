Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211899;
	b=LW5B+rim4ZV97axf1OQZ0rBK5AK1qJZLMNvXRPDHgI3wRTbCt3CsDhOu0w2cmxI6ZHmN
	 DlCCaOsfAg4WqLO89p605ZChXqC7/yezC76FGbGh7z/m5ucPzTQ7gQDIDTn8tKVNEnt//
	 6//6HvAzfQApgXd6p2cKsvZ2HsF4FtYYm9is8XMNRXIyXPx0o2tQbny0gAyZXBkqdiDSq
	 5UpnxtQqPSShxbMuqbzck8yg3Dpz8wmoQeJQVNK4yBsaRknDB6aHqWAt61g9BG77zxW8p
	 B2StFkLM2t/dY/M6MHz2qZ+w0mcQbnhnz0seQjA/wvq0npysDAPYf4yfUdHcEhFpYxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mKhvsObZrPPQtj6ZJlFblKsUPwWm8d6ZB8vx+wF7BDc=;
	b=eb03vOMJonC1Yoq4hsHR0Le7xO5K2kRbuYQ/VxGcFKsNgp1iPfqBQxs14C0INJYsEjkd
	 wQwI/WspWbSF9x7TOITwSVojVbWpNm/c7hpmweTnqQ1pqGM1uRJcjepIlRdYIi3xEVNWr
	 43dcl+jCUCL45pvegwrXZWcISEkYPZAKYr7+LPBJ6iuAHPEOCc2sP4b8/w+XvlCfNFzxe
	 ZskbhsLHT40bniptHC7D4EtU/FMBIRMeEO13HzaenxU7tKo/CeRZOD93CJSHYDboRbSYC
	 Eu9vFVmGcKRuB4asXUIPHsJnD1WuYEjUt6wtqj5Sgxk/tNRdU5GmjUBYYEVdNFo/axQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6fCsRA0;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5732606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5732606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6fCsRA0
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3acec6677so639387c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 00:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211898; x=1794816698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mKhvsObZrPPQtj6ZJlFblKsUPwWm8d6ZB8vx+wF7BDc=;
        b=V6fCsRA0dFS4v9KdWGpEZHQGeDkNgijAvP/htZHms/bgPnMY3z6Ha/VGR+qRiB/tZT
         yeUl+8vboUTroog8qizr4aT5JoSzsb1A9B+hx5IlTjyhSrO1fINSwSsAEOdJzBALMIoW
         IF5gpSB6p+cw1lbtglErG6nL2UspWIuSsX54ttj0B088MtYFVgkKUcNBULAIXFB7HvzR
         WbfqX/V5w9Zb21QDeVu8I3dMvjovmxN1fr8oThYR84B73vwdw8Lik/euRdH2gvc1Uln4
         n5WuThlOsRoGWuuqVn7sq1OQUn5Ex24bBrl/OXDYOzWV+XRyWaq5P0gEPmNTsjIjPKCl
         RzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211898; x=1794816698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKhvsObZrPPQtj6ZJlFblKsUPwWm8d6ZB8vx+wF7BDc=;
        b=rXuQYPyt+eZ9XSUc109JDG5TsHVlybsMIIMnhQ8Ib5Dxz2qQ3Pb3gegFmjeYb01VD3
         /HX6wNH7m80bJvpFZe3vMgyGhwjecpwv9jPkNu96YSNVZBBDSFSbKba4QchhzB2sCy7D
         n3kPIF7Hrg7BKhJvWQC23g8XlfGkkxOVZeR8J9h8tZ7bKsZUxH9DekHOoTrW0YgysryA
         lwjDBl2Alk4HaBwvYkSwPkejH+yS6KqdbVwvA7vpCCqiJLLfVUoo1n1xudN/gINMdeBX
         8i5cd/tXJj6Us2QIpi61YhDBYIHsgvBzVDQPdlfsRAJ0+ccmc4GCv6FBlcQavsKgD7sC
         EGAA==
X-Forwarded-Encrypted: i=1; AL+hErHpYB+zV5c5px1+jEDBhQHN2oEvcyduMgd5B2p4FiTXYCGoKJaSbaK+8ySet5824J/JhnP4mQk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rCIbuuVMYTOimWVGuzFfWkGWC29m9gAsWFilQTNpF191vbEEn
	CFJQN1li/KtrBfkhHZEZl73oJRRvwQliPn0OwhtK1/IPg69Kl+bcUMz+KqD34A==
X-Gm-Gg: AYBFou0zTs7AEoNpfGlDur4aIvbzOSo3Iv3kp1yIQm2pw4q1SXvVVLXZc3orAYnra0Y
	ZJ68c/xGJXvHHZaFrAigprxf2+hZvEhcVxu5z2lKqDmxTWVGNZq3CXVDBZrEfUO56rClS7/u0tq
	us6avfiN+4jNzxIWHPDDokrcoyzASBdodVnpPGySroW+QjyS5VyoiNPKDj017qeApLx3zS1yuSS
	Ao7MoKc9I4O8+SsaAZsQCOrQMhjVOBZ4gLxYDtMyQSBoIy0Yy4BuHnHjSuRVzuBI6+pRKmJzZOE
	iUsHWFqX/VNpEVWbPINUdAwApDQU6+DoJazD21xuC9tlf2JNcRyGLFbrDxJvYlzKDiv/kDrCJN6
	DDKuUfejKoHTfIULHtX2V3fhYt3ogIciGr6YtyfLMza302Jt29LWGsk1F92LZcsL6jJ2Bg6OJqO
	DkMQw3RdJDGhePfpHD9v4eXAksHkKsCpm2B+6RCE5DrTQnHwiScuUr19QqiznSs/r/snneMTMl7
	quYDZBvaJx9QV+LwaqFvWk3IUo2IlU4/H+C822TkglIz2IkKBmeWIghr2NaN1K5m/I1SV96m1R1
	68AOf2uOrYdMdC804YwPlk++p/HaoLHdClCOxCWGz2W0Cwutt3Pk1uJkyhuVrpX8ybCx
X-Received: by 2002:a05:7301:da0a:b0:36a:1434:c691 with SMTP id 5a478bee46e88-37256bed190mr5906511eec.14.1794211897671;
        Mon, 09 Nov 2026 00:11:37 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265618e11sm10757848eec.7.2026.11.09.00.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:11:36 -0800 (PST)
Date: Mon, 9 Nov 2026 00:11:34 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: tegra-kbc - check the pin numbers from the
 device tree
Message-ID: <avGAIkcHMhfvn-0B@google.com>
References: <20261103084135.426629-7-zhugl3@xiaopeng.com>
 <20261105021303.4206-1-zhugl3@xiaopeng.com>
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
Content-Disposition: inline
In-Reply-To: <20261105021303.4206-1-zhugl3@xiaopeng.com>

On Thu, Nov 05, 2026 at 10:13:03AM +0800, Guanglei Zhu wrote:
> The row and column pin lists are read straight from the device tree
> and used to index the pin configuration array:
> 
> 	for (i = 0; i < num_rows; i++) {
> 		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
> 		kbc->pin_cfg[rows_cfg[i]].num = i;
> 	}
> 
> The helper only limits how many entries it reads, not what they
> contain. Not all Tegra variants have KBC_MAX_GPIO pins - Tegra114,
> for example, has 11 rows + 8 columns = 19 - and the setup loop only
> initializes pin_cfg[] up to kbc->num_rows_and_columns, so a device
> tree that names a pin the variant does not have makes the row and
> column stores write over pin_cfg entries that were never touched,
> and the later check_pin_cfg() walk reads that stale data back as
> valid configuration.
> 
> Reject pin numbers the variant does not have.
> 
> Fixes: 88390243a993 ("Input: tegra-kbc - add support for rows/columns configuration from dt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you (but dropped stable).

-- 
Dmitry
