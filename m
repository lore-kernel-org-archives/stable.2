Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216559;
	b=dtHI6AffJBrcJzVF/0ZLwqSZ4udNm46aRKXuomZ+oXukbYHsrfTO5XiSWmEjl4U8d0RM
	 IF2duNuDn/y3lP1k4M3Lu4AxQER6dYdM6+nPmrCnbZAj8nr4dyquo32JtZzKF2M+To/IU
	 oZkMLnYSKEBt6zrk1DfD3WAfMkKjJcUjds80X0I41hoK161ebn5DvGl2rq9hdn0CXEJhF
	 Q3JItLrSajNLZVJA7dZq+eBQDJ9td41al1d5AqgbLdO/XRTQZBFGtiFUa232kZnAsc9L6
	 sDtlQR6IHBhFT8yuzciiAiKmTODQft0A8nkHk1RM3fyrJEFknDuNDWN0HtXDm2vIeag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=d7BZyHIMsJtWrxLZeoDDEoIBAHc9N16pagqYxUqhowc=;
	b=Ebn87FIsB/rREs6aoIx9jjbJ9vgG4vS92XboJszvKbgMYr8khNAcxtvMrPLAzikclm3X
	 F0Fo4vf+9+0KkbxI9sF5jH8LJUkY+6UsCWdhctnF+WPw+0C6IhHKpM0KYdyHHZrd/nEtg
	 HRfvwvox2GijbVbs/Ol8VeqHFmncdPovjUxZqeWmUElwXjyEW22ojVcwRmy8GUZlM3P4d
	 rkoTYf8esXp78xN2kaoAbPeqUgxwYkpkJ77maj4zkZPGd66Y2OFxgGP3QbjczBPvKm3wd
	 w02yt0zqa/XgZeDmCmaETTBc5OhiWUP6EUWqlu1t8iva6ammPhtwH15kpJh1PId23aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="A6F/rvmF";
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631C606A33D
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0631C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=A6F/rvmF
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso291235a91.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794216558; x=1794821358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d7BZyHIMsJtWrxLZeoDDEoIBAHc9N16pagqYxUqhowc=;
        b=A6F/rvmFCscwy9hvqb92wFE7j7rRjA4N0MNiAVJDmLcTJLmL24+QrO5ICZBqzcB3us
         k3L8WDVdXS1XOzRycHGZDpPo+hwpp6IubbWaV1zIA3u11GDaNRSJb8JqXcEyDnQ7KJwN
         97laAyvhnQdBfIxOqEkU1cs7rV9ybOYiSVy0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216558; x=1794821358;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d7BZyHIMsJtWrxLZeoDDEoIBAHc9N16pagqYxUqhowc=;
        b=bGyyZ80t4fgNfW0ZJY7kvhbikemSG9KiVuVZ2XtvsPTOCfsJMgTq4u50cgvQO98aj9
         uE4/fiUp9J4KPiF9QUSOcK/7k2/MyYdQCEray3Rho4F+m6jaOiTVhbxnePMDvg25Zt8u
         ZQTdYoFzhK0esI/z78HiWRZbT+b6J7+AneuK5qCqYtlMnS8Ha4gbweTyjWPEP1KjJs/s
         5OJfv4RbFXkA7RUCQZ9V4Tk+nSWz3dT21pGaulttwOOiS4JoqUHnjjKeO5et2dVmILkf
         KpBt7v0cqppxsN61AKuenBMVVCF5rRgnxfVeiV95pOlCpz65QCxyGatK1ZYrLiTcpH5M
         fQCg==
X-Gm-Message-State: APuU4Z9uJxXS/D3q/FwAMQkFae1J+2QEoNG1N554lao1dMgUZpi3X9x0
	XQPOlS+N69F8YGCBw5aa14f2jgAVaoAnC4KUisVpn2wJFPfhOLHRCSGxMspJUIQnsmWPp+Yb1M/
	saYfJEvJ1
X-Gm-Gg: AYBFou2tdD84Vkn72Z/VH41iZv+omzLeHONYerkdhRgJu/QQa3TwoNYwNIyD1AEaPEw
	xxginFfvpwl6C+vbKc+ao25ieOlT7Q/aZ8RZTj8IiErZ4JESnkcqpvUz7rqJMrYUZl0/OUIvBkF
	31I5D3qf2Fij06Z4C95Sh+pgfNdXVsAf2JBaBAuq8Ju1TzcKt7dtPIey6ow6CNBjN37WQmn/jKo
	MYtU1EjiPvKBi8fRntfFel32VYdQW/hoFyPW3wW4jv2neLoQ6gj+oGW6Drzx2yPNP9lKy27A+JT
	+ibJMhJjNHBkmdzWBTVDctEZ0gbf2VvC+XMpHxM0a+FKUHUzCesSlRs/bG7FMqbSVCrvgKtrvVM
	w8Ld7ihLioDyW2kH9moPqtoUOfGkXdEudwxiSfY1TaSCEcgDOG/Etw5xAc7xJ9kxUcwRoiIgZwn
	AhTRKb7S1wWGw3fZO6HT8QzD26GdTjN4P7BVYuLJ0/ivLf5VXefC8QyCOTX1Qh+sAuEYODIvD51
	pa58g31ixJUbKI4anyDEvErhjOxGotq+TNNEUnAcXdUpMHrXck2nwdFb0cXkMe2uwG/WPbhJOll
	3VgQrp5Jz0HSLqZ4Y29TC5Z6lMJToBOm7+RTIqFwWddF03WsQb5XkuYUprWcp8Km
X-Received: by 2002:a17:90b:3886:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3b12d400306mr3557192a91.41.1794216558301;
        Mon, 09 Nov 2026 01:29:18 -0800 (PST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com. [74.125.82.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058d2faesm10632572a91.14.2026.11.09.01.29.17
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:29:17 -0800 (PST)
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae18eb9b69so633097c88.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:29:17 -0800 (PST)
X-Received: by 2002:a05:7022:29b:b0:149:1feb:6da4 with SMTP id
 a92af1059eb24-1b39feef206mr5568118c88.32.1794216556213; Mon, 09 Nov 2026
 01:29:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107050357-failed-7.3-65444446f0c5@kernel.org> <20261109092321.2282542-1-ribalda@chromium.org>
In-Reply-To: <20261109092321.2282542-1-ribalda@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Nov 2026 10:29:02 +0100
X-Gmail-Original-Message-ID: <CANiDSCs3xq1aFbK73pOB8XNBKeke-XPs=J8JAm=PS8+__ceT5g@mail.gmail.com>
X-Gm-Features: AclHuK9OoJa55OKsLFqv6JBOgw0Bx9w8IgpAhVm4HWM5d59hEI4OkRTvHIyqWvs
Message-ID: <CANiDSCs3xq1aFbK73pOB8XNBKeke-XPs=J8JAm=PS8+__ceT5g@mail.gmail.com>
Subject: Re: [PATCH 7.3.y] media: uvcvideo: Force UVC version for Avermedia GC515
To: stable@vger.kernel.org
Cc: Edwin Gatier <edwin.gatier@protonmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, Hans Verkuil <hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please ignore this email. The correct one is the one is
20261109092707.2326885-1-ribalda@chromium.org.

Thanks!
