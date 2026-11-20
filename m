Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214849;
	b=XdQaemDhJl0UT0l29dCBYCm9oy9BzwUDkOTXmz2PEhXMl4Pv3D0yIi1GaRg9QAMT1m77
	 VG1J2sOuwN9/AKrpRmKy1SZkidIQbPiqxaXpwaQ7aAWs0tYliw2MqHnkfNOjFri+QMc05
	 dFfD0ZvmvWZqQkFIxWSTTO2n8SBDlM+aTtzkvOAV41Dq/NB6aR4WmcHqUxyx6v8eWcUdj
	 Z9LloAU3LyRfpgJ55Ipm8ZW5O1z9fRe8H6wxcq4//Pc2YxnD2dqsx8mqcOOlsiaCTiEgB
	 VaAwMG0ZwbSOXiOALc7xcwg1qAK6Nj6WAJWyKA5dezY5wKEVxyzCZLGn+INg8dj2taA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=hDktAyyJAPG9jc8GPRxfEzIEA8i6qmjQXTURV29xE6Y=;
	b=cQG92qRRtAjUWNrpcTA4fXQP7vx8N0hQ+4I9ammB4zHsVIwtuGgaFtDq9NBgIllyonhF
	 rLanw+R3nNSjTrWgRw2I50k3osgf/YSn2Zb0CyXV7jR/1pfMFzEcorpTpq9LBHxi39KIq
	 Fqel0he38RmtPJkmTNHgTswanSqHPkAlWyLQUQMEzP53V3fJXYvFD5rFQONSO5mnbmHtp
	 uvW7m+MvYUucih/7Df6kb/i8GMj1ewlt6OotKoVihHlZ9aUgThO5Wx4Vn1lEjv1j098Wh
	 sfQmfLwmobTBN8lmOxiOTbOT0XZTfEjFIwHFSgeyMSOlv89J1Va4CpQLHRte2yfyz7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqI6DP+3;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05EF606A691
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05EF606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqI6DP+3
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a9be758734so901532f8f.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795214847; x=1795819647; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hDktAyyJAPG9jc8GPRxfEzIEA8i6qmjQXTURV29xE6Y=;
        b=YqI6DP+3PWKjWwhrVSanSRfoeCtUGdxyLFN0q3WF6JcLPvi/aGITEW1BCBWNIWYDe6
         Hn+L+vBVQ4WjLXv2V4SsPm0qUF1cmmGYAyMip3yyHdLdRPVpTI4m3DcZpfEn+JsTCBTp
         +u7nZpbaKaSU/FkE3IvPShMxjhhBKeDiBhminR/33hzO0JsMRF9Rk3ajRpvRrH+vq6y5
         t/C/0WPgnuT9Rj7IYbKwNughO9V31PjasVWfo2npVPrnCTaOHO7C8QQj1KQYKZyFAOEl
         BqN4IWnY1uYgltPdSKMfzbab+vJZca6gVuoaVApUxSxIP79izKHooXtSL2bRMMI5jrWE
         f7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214847; x=1795819647;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDktAyyJAPG9jc8GPRxfEzIEA8i6qmjQXTURV29xE6Y=;
        b=VwurZuptd6JuxtHjmNa+o9SeQ4GXEAUP1Y2iYidMBOX4AZPkoZ5C72uMT6hUOBrg3p
         TUkRyqOnjMt75s92pw/C0nNZs51jY/KaPyXBfqMTJ98gj+Raazbs3J74B06lpWSadDn4
         YKqiNxtxqKy2ZsJuDvMhYKCnALW5TN/4P0XskfrovkuWLLFXWdjkLfnU71h1ZAK87YFD
         QBCVPItPpPeQ6sW1LzgbviVj13FybzLCfAsO9mnlVK/vR8K1XpwauPM4KCGfiBGPtImA
         KGcOw0ijaWv5CPKJlCE2lukX0umdOa5YFYMrT/lRqIvbp8QIAMQdbTUPkfxu7deciKV8
         pW1A==
X-Forwarded-Encrypted: i=1; AL+hErGljW71UcO8bFugmVZ/HhWByFqHv2O1fH2Znr61l9Kp3p59LwoH8HTy+HqjILf6q8NjcEP70dg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Jb8gtKfaLcY8JdDYMJF6xtPHI87L1j/Vagu9Q4a3z1CG0SRpp
	DpJR7044cjw34HlJqEXX4865UIlBgK2ZpXJRKWeCOEAjG8HO41M5Ak4=
X-Gm-Gg: AZFdTZfDo+RQXlQZVj21B3LrVwpaIfjEwkoHf7E15h7uxvBdSVQ5YCEL1NVeTEhfYay
	b4qPR1IgaPo129f0ig//DHVWhd3ZyeOk2Ldroc2zXFGJlF5TuXsgpJD3h1F/U6esiz2+M1U+4po
	N+V1N3SwLb6LvmzNx9uSDXwQDt5y3bQHNqzt0UB3MkTpYNWXkRHdH/bQh19nIfZtNKcomstWA4Z
	BR1ezJyzV1+H8GYVXcLIMeL8cy/GbqKJKeL4PSwNzyyPFoClfrrcIcr7r42aLsdAghjpn0/LN3G
	oPLgK//ZWHgVwS9CzXrDixiFyWPlF1AEpdUfJyzERIlgaODCaEXQPAybJMqd1rc4Q5Y6OHtK8yd
	/lGM4+ySepn3RrfyjiohudnduK98ISh6kkQoga2B3jrJL5yAmVaKUNh886+t56OQZ3Eik+bXuv7
	6YVXxxiF8eocmVkclfC5VTAPTyfE3M2HlLpQUDbmTvdjzsCTiTzP09/dVMRpMFXqqOcAwDdgBWY
	6mUwGJg3pNu1O8k1neSE0EDLisXPw/wvR0H3SCuEnGb8hAtWHXMSXMCK17+k+FmJxC1WlL/LWUO
	JsbmJ6PY
X-Received: by 2002:a05:6000:4a0b:b0:4a7:4efc:11d0 with SMTP id ffacd0b85a97d-4abaf740155mr9169550f8f.12.1795214846879;
        Fri, 20 Nov 2026 14:47:26 -0800 (PST)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3882sm8148705f8f.49.2026.11.20.14.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:47:26 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 media] media: v4l2-mem2mem: cancel job_work in v4l2_m2m_release
Date: Fri, 20 Nov 2026 22:47:25 -0000
Message-ID: <179521484597.972404.10406015135695575425@talencesecurity.com>
In-Reply-To: <a931e754-ab4e-42d8-8555-9a432fe42a1e@kernel.org>
References: <a931e754-ab4e-42d8-8555-9a432fe42a1e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Hans,

tristan@talencesecurity.com is my correct address -- it is in From and
Signed-off-by.  tristmd@gmail.com is just the SMTP relay that
git-send-email routes through; it leaks into the envelope sender but is
not my identity.

Thanks,
Tristan
