Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474491;
	b=CB+HSXudkwMBf0FF1F6CorJ0Hz/ZbKSWPOJYtGgcnUV2qT9C3bNbi7vrf8Hk1gY+yVKS
	 XlLEjYCnCXR/QkhQ3uVHpnX6arMsVI5kep8/u04Uo3S1hHBvbLXkwLJlTkk/fVD+lueZK
	 eytWfndB0yTwr1uwqxZT0x/kCS67Lp02BDIeAJB7PSGwpuREjE0sFxDcU3Zgmp0+uLQv+
	 8DVZq5vNUacldpAtYcbDkHPQfEXIkcVjTO15FpJUed9t076gXR2jaV1LDQbD1Tqu05zIl
	 F92BEQxPCG8fUgbceK9f9NPPoTyUJEKCVzPiQQez7YSXhHlv4rXY12HIH39BjDdVfyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aQfHHrXMXLY2j/M6I94/T8E0vvM8q6x0cxn+YnCDD4k=;
	b=J1MsVtsMhqeWQiTSVGUwqyx5sJMmXV0AAeq1qn5K3gj0VrH11SB8z72BnvnwTltAE16E
	 MoBYJto1SpeerdoFdyXEM3QWBbB0S476nht40ZP8f+KDLPPK2r+BSTF4nX9OzISvjG/hl
	 rsuJZMW4v1W5CFbe8hSdpYEVMGIl7CmplN+My/IzzHTf8e0lo3YNIMLFf40j1k0FD3C4Q
	 UfD1KKYZvORFIHqi9/Q/2EbftzCEqrx5s7M+ViIB6OtNavsD9G5CxAlbqy7fK/4shiVmL
	 P+4jTWyN2eVaHXwJ3c1z/mlZo2ZUqhnyNWt3thg7w/WBjp1I21BRicUwwqEKXLeqXEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fs5p+QqU;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F7606A31E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A27F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fs5p+QqU
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1661211a91.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792474490; x=1793079290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQfHHrXMXLY2j/M6I94/T8E0vvM8q6x0cxn+YnCDD4k=;
        b=Fs5p+QqUCKPcdPkITuqn2vGo9SkU7aHtyOKb5qh0D2/mN6+uLCmUXq+UbtxKt+kpT8
         /y/IRsdvzo7lZneeJbbqB80oks+9KC4Tt3+RfSEL/5jCNS5zJJ882fDri/zAEP4c6V4b
         18U5Hx12o6dO5vfmMnuijVlFHKfI3XiFsJ+yqmEM5bonPPOW1YU7l5t/TD8MN3pH95Vq
         /pguadP4d5v/I/pQKKuuwevLO/et+ZlVlDR90StAShUGfSfscvpcPoKVzIpZcq8B8Wp5
         pbfHenTBqUpwDJPqE6OM3QWreyjDqqQAustBE69mnwZYGvGG1KhQVMqD9zt7uJAftN1x
         qo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792474490; x=1793079290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQfHHrXMXLY2j/M6I94/T8E0vvM8q6x0cxn+YnCDD4k=;
        b=LqpvB6IOxmN20AYNbQbRNnq+nAR2FyQgZqrjdvKlP7X8gh/VPH9nQgju0QnqYlEM+N
         6/rZ3ZRnGRNwkI8CxJgUB61U3jQ06hec+41THLmQi23dj4oceR+1ZHWKDfAqqkAX6Dz8
         mOqDsTcpv59iK38vOMam0Z7XRbuTjh4wjw6arD6sCA1ti/QUlJYxdSIy/6amC8rTCUvg
         4GJiJUMSq7K1sKJ6xPPJvsJPqOm+O7uOW/ZcXz/XNVRuHL44hQME/QpOIeNPpQqrAaW7
         iDk58vkF1QupSs441DEVkksW3VYhfMeyEzHaR/lwujd29gpuU3vGITsIBCqK+Zfd39Um
         M9Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwliHhmbBGgpoF/p/U5I+bNlpzBoSXybib4ONoCYrTELSiYVd8DQ6seSnuiVidV3WK3n12E7qo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4vOkLj4lEk7AyUAYYG/c/S/Qxol+gIVGtz8Tsj1RBd4rDS+DR
	pKzdqqAnM0VuIo+KUM+vbS8NlB5vz4iL7+zltC+zJp0YzTc6W+mDQFQT
X-Gm-Gg: AYBFou3rPlSiHCveFb3vSZpywQatdiplWNjdDHdfIsF/iY9Bf9iBJej3RtIiODD/4iB
	K1s8p8i5qqXC5S1re9Yo2iP51VW/ldxSvtSbo7jS2dhMBiqIf9puWqGhjl8tfPQCwFIeJh2GSv6
	KHOaPwnxuMyYJGiC4t403Lsz9nRUfcdBOjYc2d93LXin4wDZgDjBi9HGhsIavXHB6lplZnJWVF9
	GD1b6qnZjpHwpkH7oMwNQIuJ/QfPXJxkhnJMA3SGP2QW9rK7uPofTxv/rxBCqRrKsoo/h9nil9Q
	t5pX+7l7JrGXNDtmUJhzXIeWp2EhmRNvCRN3HLMC2sSIdkkJkjNBfycPiAeM/4Rc4tOe4zm1/C6
	Ce4eR4WPRbkT5ZPCKcoud/PIi7sfUGeXzlGeaSouymFytoDFXa4u986ANFbRKUMGjeYM3CXEgLd
	qN1iU8GkY/eyoSuG4nujpEiHlAzLgIkNMAdo1piScQEIQFQokJ7jmGT+3Zqrk7xK1kMw==
X-Received: by 2002:a17:90b:582f:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3acee98d90emr8576204a91.8.1792474489983;
        Mon, 19 Oct 2026 22:34:49 -0700 (PDT)
Received: from hachimi ([101.5.175.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60102ebdsm2216041a91.1.2026.10.19.22.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 22:34:49 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: tzimmermann@suse.de
Cc: airlied@gmail.com,
	decui@microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longli@microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	regressions@lists.linux.dev,
	simona@ffwll.ch,
	ssengar@linux.microsoft.com,
	stable@vger.kernel.org,
	xlfylawarthur@gmail.com
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Tue, 20 Oct 2026 13:34:09 +0800
Message-ID: <20261020053433.9419-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>
References: <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>
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

On Mon, 19 Oct 2026 18:03:55 +0200, Thomas Zimmermann wrote:
> The problem is that module parameters are impossible to remove in 
> practice. Once in place, someone always depends on it. They also 
> increase the number of states to test.  Avoiding them is usually a good 
> idea. Especially as workarounds for bug or regressions.

Understood. Since Hamza is working on an implementation of cursor plane,
I think this patch can be dropped for now.
