Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195340;
	b=oUXeIbSn5J/nHtbps2mY14eTOrZZTjOkdMNejKH72pUXTsLnXm5pXq8QgsxulH0FMKsQ
	 qN6MJcD5wmN0nvVrHJws9ycDGoOiPZQxqLWdW9BIIy0GvT4mM51TGz5ldq5LtdtL6Xsl6
	 EjpgQ7+8jo6d/9O9rEnIWbkdjYJKyiYP+SJXbK+nMlztV4s8+Qk//mq3HG1D9Th0ibfDM
	 1rfXmfUQ/VhdzLYaf8Vo4jWBVQS27tj+PtrEjEyvwtB7zrL8bQeumOC35AldjEhYVmVU2
	 HdIezgo0zYMddIKg06ib3xDgSi2ouxYQCubKL0i+Yg8ehJoqZZWNdnIQCTjfzLkDntA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1YuJ53WOk7jrtj0trQZSUgggEA4iaV0qdnW5q4z5Yxk=;
	b=PSKH+NvNGPoCW7k6aPwHLowChx8LdJ6TZb84LXi04VmK00IiZjlkD99q0tZuXywWC1jJ
	 Ye9Frc8fzOTeX/p/gtW9DGPaf7yyLou2VlKHnIddXbgisdyq/cNILHzP0yvo6AHeP4swP
	 HMcEoUf0GmOgqrWSOgvCJ69tgxbwVnTe2Traz0gbrODWmR18sh8Q4iSFY7cAfBU3f098X
	 VE15hIV70ku48Gq/JQmgqVJM7eRycTKCU1/ROGKUbW063WP9KPEL38Yse8nWst3JRY8LC
	 5BedvoVxn14K+EOCbglTjxzaVuZo5quFWav6zZz2E/TskFwvNJblNb7B9QkKSDuZU0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apmeTwME;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915E606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1915E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apmeTwME
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6ddef424972so804708eaf.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793195339; x=1793800139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1YuJ53WOk7jrtj0trQZSUgggEA4iaV0qdnW5q4z5Yxk=;
        b=apmeTwMEm7Er4RiiqptHiz26E8hD/INQ3q5n5r9r9rcJQ24FsKAzrfsc6yRE8hcFGV
         g7pUEMwhgEqcgWHsgW4LhmiDEPnRRuEIcz04lWjkq/1zxTucRWdRiPvtcrfdIDEJT9Uo
         UhdzOhTsphug2En4UvmxPYdE4i3WR72Dyt23Pb01/5fxRdxU7SrhSRjMHpzP8JONhr7u
         WXNLqAB/YC7hxIPgiSDjDb4vZvIp5Wzpw+Cx/P/HLmb1/wbVFFT8tCQJCYxOEP21WlHH
         6jghq5Q9o+r/ZqWSJILVxnG7GlU+T/WIS9MnM5ImdRY7Y7km3vr+hy5qjD3MzbFYe8iN
         GwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195339; x=1793800139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YuJ53WOk7jrtj0trQZSUgggEA4iaV0qdnW5q4z5Yxk=;
        b=oyIushZ26dh+zuU7K/j0qArF8MYRS+Nu4uQcDcUw6FZeVWZgHPlslkWcnAe4vYujqI
         tAo8jk7Yaf7eWQuG3S2qBNT+eWInR1KMoOrv5g2HuKI3iHx0xFx+BDBWdlgKcaelzCX9
         kWWUw0sToUnegJRu41UycTsW1rtaT1ATn9UQChdbGU0S4fJEf3GBksM++OwGZti8FYWe
         NuuhhtTcGtu8UbIu4MCtkqo797YQZOMeZSnoSs7erhEfdgVoKoEKAxi5EKJpcVpMp5HD
         phw6erjlDdJR3hc2CVE+m6itgfPH/2s0DwhmPeuIvBz4t0+cb1tV96WG4T7BC+bT7N64
         iOrg==
X-Forwarded-Encrypted: i=1; AKwUvBxpKMoOqqPIKGrvI1DcSpaOwPPEwLyySlrp1X5uraINSC8/0wSG6vy+I4R5pa0pqhP13x5IkTs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv4GMiZRYmU9nrGvn2KHyZvkct2ARMiIEpnNc2dnyMIEI9XAmp
	pGFKtG2RY/iTppQfORTEx+vL3kxT14RwpBCJkQBQ9wFhRHLbEEnvHKqO
X-Gm-Gg: AYBFou1LxWZhRfp54C4Zsy9fCU87ir31K/CSXEqZYITctNTDmAVWHu7C4XHEzG4+xJs
	NmlNf7MMXE/ob8wFMRlh6KYWyY8fIBw01BGcEhmOGypGl5rqj1a97F6ief1fjAb41H68p7o1p+b
	nTc0Ar0T7HBjpNnPDsXo2TMQS9dgPyPX5IqjrB69WLrAnhxkN/PspMLrdJWBPOuSd7WQewY7Vr+
	whePb8wZ48Op6Dxkf6izVlCEA9uTryLSN05MSkM0pac9Kh5BH0bxUpVYi6Q3uCLnwrkG6038IRv
	DhsaGpVKS1ozMwGB/LtNs1p48DIOYmq/q/nhinuD4ogEjXQ4WR4kpr62pKAOYR0TwJyeWeUcD8N
	aEPsNdBmh/EVzJo96Go/4br0EHpwDU35jDt6zWwSzfR4n65kpLUQQGO0mN34dHS33BCrtgQRNCT
	EI5b7Q/fu+t5NGiGly5PDfuzjrKo+PIN9TCZqNfy9aJnRXTmFMBy4yBmYuxsZcVwGUzLxMefo44
	K21pA/7+Kq1wtD403HlhjSqefWK05WoUgsKoQORCLPufER7gm6CgfV4xeP1c0RsvJKMkU8o3Rf/
	jtF/HEGgLMBDZ6esr1+1lfJL2b1JInTr/BFERewG/uwWfGuraOIk+Mziuf7olzAPGIbAC2M=
X-Received: by 2002:a05:6820:450f:b0:6fc:373a:176a with SMTP id 006d021491bc7-713efb16571mr1090755eaf.77.1793195338875;
        Wed, 28 Oct 2026 06:48:58 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142d124f03sm1409758eaf.13.2026.10.28.06.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:48:58 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Danish Khateeb <danishkhateeb03@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Andrew Davis <afd@ti.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] leds: tca6507: Fix use-after-free on unbind
Date: Wed, 28 Oct 2026 08:48:57 -0500
Message-ID: <20261028134857.36086-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179213356828.2581328.5085333261240588869@kernel.org>
References: <20261015144033.56519-1-danishkhateeb03@gmail.com> <179213356828.2581328.5085333261240588869@kernel.org>
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

On Wed, 28 Oct 2026, Lee Jones wrote:
> Please review, explain or fix the Sashiko review(s).

Sashiko is right that the "LED off" write queued on unbind gets
cancelled, but that predates 1b5c2fa7081c: remove() used to call
led_classdev_unregister() and then cancel_work_sync(), the same order
this patch restores. Since 1b5c2fa7081c that write only ran on freed
memory. If you'd like the LEDs turned off on unbind, I can send a
separate patch that flushes the work instead of cancelling it.

Thanks,
Danish
