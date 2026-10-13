Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335232B126
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850560; cv=pass; b=mxdp1kW7bizbYnCE5vUSlDfvL3Dqt0sZUwAA+T/fEiCDiKLihkUbRwlSbIg/oRJm8LFEHOtvRhOUU26vUDJtJY+lr3RMPFXKBTK2Lpn7SpgGDUYLyAD49VZNydaVtlWjuuvUGAHDXLupNFs/XiqGup+lmZsMxc4xUoDCXTS5r68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850560; c=relaxed/simple;
	bh=pHxN670nTvs1SKv0ysH9qz0K2rs/uzf0jySAKyVqBoQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U95k9gjaFwTmregkp7IGoJzOphEgnq9u7lVDbRhcuSSWBTDG4KRP3eXp5nZE8OPQBsmTAN+uE4kdnQ3ALWgQUODSyHrG+41/heLPMwmcC5OIg4BuRd6F479FU6voZTaAKnSMiIrijVd7CWn39oas45/JpJNoxkrPkrr4EAIWeYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=kLcxJ/Mv; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="kLcxJ/Mv"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a87e23860cso27068901fa.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 17:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791850554; cv=none;
        d=google.com; s=arc-20260327;
        b=bQHkMTbLiB08Gi40Oel+PpJdOtN5S5quJbfVyXphlt23wRFjpsNo8ydACwzrDzOjWC
         0G49KFGGpS/tk70Na7riVU0KwYg4f4umPYhUyPbILo97VX69stR+smAeWc/ccXjhQbnT
         iIluDVzlbO9by8UBwf7d7FPlrNgy/ieGPPE5zzr21De7TXjUnhG+DlD15Y8cBahNC6Mo
         uYTJ78C2eX9Dn0QjdRyLSZsES/vwf6uICEprsSl7OckcisSlc9/qRwiSsxj8USHu/0b1
         qF1ZsRzQkK8ppizHQVj6nEjI5hEhkKoMODQhsN3Rw4WNWAciAHPnvTIgqeGpdMqnvhvR
         VJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=pHxN670nTvs1SKv0ysH9qz0K2rs/uzf0jySAKyVqBoQ=;
        fh=p89Nuv4JFkzye63HO+MD+8OgXJc0J4vdmgGBT3ffqcM=;
        b=qlH0CuXbtjGXdPdOhMOpsQjIjQ2MG7dhZTGEwwjw9nOQZgVyYT55k54jLDvhMSNsCJ
         /kZ/7UfKjs/7KmnkuCTL/HPSKUHUe4MnQq32j7/qizci3AJ3cR9POCcokQYLHNRNSMaY
         j1fxXTPuC0d0wjZWlqcTN78pwNU4gan+M35eD/9Q+7j4sVKV/B2pIFLzQzr9l1AZkK4C
         RIPCMJ1lhVpkOqwsgv8ZwNvR3T+33SGSJ97U2FMsXhmFDhtkf0uQGrZDVmoUT7ZrWmJh
         sg9nLotk6OP6UAqwNsS66YMnuMpIpEt9pr93vdfck4mNc5Q/jGCo4AzahQEaLoCTkY1d
         d0GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1791850554; x=1792455354; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pHxN670nTvs1SKv0ysH9qz0K2rs/uzf0jySAKyVqBoQ=;
        b=kLcxJ/Mv4cqfhx696LTAHTGIRpIUqhvCwaTJdOlmnuUi9nsDnQAVcZ5QY25TZ86kYr
         3ofI3GHcibTrWYCPbCt5nv573UbeBqcqz/I2nfADiattlrMSXJWW16IOtP71I28GnVIp
         u0WDImTRN1zRaQ+ttAxsouq/CEcW9MWbQ5DCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791850554; x=1792455354;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pHxN670nTvs1SKv0ysH9qz0K2rs/uzf0jySAKyVqBoQ=;
        b=jGlJR67TH2Z9rbnDIrrMCGFw8sJXbD6e205Fr0Mh685NEs7Nl5ABim9KzqM3BDbftJ
         DNYFFMo5I45CBwRSaU4R3ZAASP0+RoTA19oQv/umF5BHC0a8ARRXmOZoUDQ+kpUP/dBc
         qbVanqgqp1DJltjpMVFdyuccqcn4t1rnr9QDAlAPgJruhIYLBWqTwmougpwi2ZBXUEj6
         +I84TGZwvqYRVIvA7iMUXN4BVCSTpYFE/w8Ir7iVQ944eJW8SQgUugogXsVbEJbzcvqi
         AZphHGJtle/wcEfH2+fYJVFXUCmbbktz8pPQYTxa1IqhDbQMjpYWIZlzfNRQtkR5m9wp
         0sNA==
X-Forwarded-Encrypted: i=1; AKwUvBwV+11oOUJ8lhKS0d/Dqrf5lbcNqbCNNp4hN5txjicBrYQqGUZkEqmvb7E1g7X5I8eJq/0LHPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHaPh+Oc37MFJKGSacFTJNOvN6H7i9EshbNHhwMp2EC6MghWop
	MnZpCXyRF2KgtkJRsW1bZTORQktG8bJV8c3o4ltSQUanCznwdySfGUHFpDE9H5yt/6yybaXgxhd
	d3NrI0ZBU71EEIJjZ1kD3C6ZCNKU2noXKwfAIB/RMhw==
X-Gm-Gg: AYBFou3TzBmMZJRj14DgSsm2ZxvvEZjXHDQgvRmiZ5M4dJ/PZ5qCISiP8PpQhXUkMqU
	zS3sJXv0CF94ZV9k+s+z9Ci9hu/2YGLK2qNl0Nl057+5iJvktgCWFl5gQXLjqnH+jcrZHKzbkYE
	KyK5ogz69fQheIHYUFjebzi/5QY2paiEUBBaZoD5vm2hC6Yvn9WXMuZbIxmv6cmHfuT7vVdavKx
	KSJmM/sRnqn+1E7ECIumRdmiGjpOGAthjC6UCs2XRoAlTy/lQi7ZnRUmFLBiukXvBDCZ4sTR2+d
	UE5K551bzGt9+BSZN87Xk7BcikdXKbYveDuD9KYG1QI1DPHqx6qDPhjEBqtS5JplUdcXR4CWLRl
	u+6rhOZ1snIiC8kieHqNv36UQQViOsv9D
X-Received: by 2002:a2e:be88:0:b0:3a6:62bb:906e with SMTP id
 38308e7fff4ca-3a9c2b34d90mr26665431fa.20.1791850554283; Mon, 12 Oct 2026
 17:15:54 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 12 Oct 2026 17:15:53 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 13 Oct 2026 02:15:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Tue, 13 Oct 2026 00:15:20 +0000
In-Reply-To: <1fc8c339df1944afa6186197337edda3@realtek.com>
References: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr>
 <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr> <1fc8c339df1944afa6186197337edda3@realtek.com>
From: =?UTF-8?B?4oCN6rmA7Jqw7ISdW+2VmeyDnV0o7KCE7J6Q7KCV67O064yA7ZWZIOyghOyekOqzte2VmeqzvA==?=
	=?UTF-8?B?KQ==?= <5mghybrid@khu.ac.kr>
Date: Mon, 12 Oct 2026 17:15:53 -0700
X-Gm-Features: AclHuK-y2NnSiDu1NX9MesgaAauRNR31ntVb3h9H4LXcDaqAPNJtZ-xqh-GtBjA
Message-ID: <CAH1Bc_yOhZ9oqreJOLKb5RDFEW=0Zid=h4xu9oTR51RDwj_bww@mail.gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ping-Ke,

> Cool. How did you dig that?

I was repeatedly power-cycling the AP to test recovery of a persistent
queue in my project. After fixing a separate NetworkManager issue,
some reconnect failures remained, so I started looking at the driver.

I was testing with four Raspberry Pis, and different units would hit
the same failure across runs. On a failing unit, RF_MODE was corrupted,
and restoring its initialized value brought reception back.

I narrowed it down to register corruption during scanning, then traced
the register access path. That led me to usb_buf sharing a cache line
with the mutex's waiter state, which can change while a USB transfer
is in progress.

With the buffer allocated separately, repeated scans no longer
corrupted the register values, and ping traffic kept receiving replies.

Wooseok
