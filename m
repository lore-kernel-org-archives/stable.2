Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066754;
	b=ch/zXz6zHDuNfT9SvNf3aEk+mE8xTqHLZ7cIuQiIgSo/LAh1z5afGxZz+Y1+UmafjHbG
	 AqurWXmgZ7Z0EUVvc/GrDZCaPp0bZ+rTsOGffVvv1ewOl3UHoZObad4dqWN0YQpAVRVuT
	 agoelQPCDjeYu6kgRpY5FHMinIvzI+CEI4PiYtYY//DpOPYb/3PJM3Vp1lBLIiE0uOvH9
	 cBtMpCm8tC29PjJ+/lrqUuOLR/eGwkFO7b/Zk9qkEsa1vUGcyb67Nn8i+7YzUw87gex1n
	 vj6fBBvNmDVf7sNR5JLsHqJhorE7+9mUwq4gCoiYIxyY9rZ0IsZGdt9p+bWUQ4np5CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yuOm98ddy3CrTpXMOnjEupRAHFolxTG7obkIbDJArDc=;
	b=dgfGcYdlhrVMDmbock9WkLv2TgVJ4zbumKf/xQ/R9OFPhBfquPBvpvSE4hHpJ7Qc61Xm
	 QpGCU/UqcZ0Bu9olizgCDwMU1I9JlH5JbrzfFvPAcKngS2SKmcpJWkduK+7RlKlB2aBr8
	 54w+v02bzRIviWHH6fFZO8RPpYgK+q8E3gEqHc4s/xhxkqDl+3Ob1d/hj1xuGDOBEMokA
	 2Jb1H1LMf55Z4gZBTjMC7sm3ETkImKLiM/AJA2lW/sQd6ziKIre40mfw9ET9+BqiEqtyd
	 MLFMUYwL/cYTnssaY5qUl2TWJz4hGEyPbTbQHjF4k7ZT3p9MPYnV5NtEq+QbDBpmUKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PudG8zIv;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642C606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9642C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PudG8zIv
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so14071735e9.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794066753; x=1794671553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yuOm98ddy3CrTpXMOnjEupRAHFolxTG7obkIbDJArDc=;
        b=PudG8zIv4x/GlPwRCQPXkKYUKOMUE92KqaWx7BF4nUAAKigRhIYuBkGVabXdSH4NoC
         ZuCFOhdzAgT7iuD25esyOKQ8oYD0j7fBo/eLXy9CrO4O6lOK0AZ0MiE6+H9pt6hx0PRF
         gzBLWSOkdObawigK1ABirnEOwVuJTD5jpj3jDq8cLtMk5BvlBldKck/++GJpXB9lAXkj
         uF+qi2NZmsWJR7HynkodJWmnDF8QbtUkzRBuD2hJPR2Lf7gn8BwwHESLcULyCzM1En4M
         YGcy01ZHlwrlszHaa+leTHO/Lpnkn4Pknxw45n+qyBwxW8NZ7Mj1fZ1dVR/5UKFt97/X
         5N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794066753; x=1794671553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yuOm98ddy3CrTpXMOnjEupRAHFolxTG7obkIbDJArDc=;
        b=GYK+Rw58xrZfG6+eM0iDer9MNQI0d4HpltGeXl2pohk2hFo2AXJIhh79jbnUO/SKyC
         5AkuN4zJreMoUpcfXva5cYF1hcAPnjlpr3PR5KDYvqcECZ8zqYyFcrgO8bCfYTOS2v44
         wVzpC0ohzeFDGF618bQI5YVZw1x3M/I4Q4ZTbbCQ0heFgDQo+7tFwfFEaejxVe83be0f
         o46mqi7PiSpkZwDA7IEiglCx4AvT3Jx/d/iNSblNdYnkOaydot7t0y2OZ8RSb0ERhZqa
         hy9L6UnvnTCoYl1qONLVr4yEoyL2mDI3M0gs/bGnM7FmUwDpRWHIq+f8wBEP1aF7zaFD
         by3A==
X-Forwarded-Encrypted: i=1; AKwUvByQizfKJ9M3XBLFtDCMySSs8VUYrD3XCKUKIxJWgtrj7kKpnfvmi9tE9+p9RO6tzSlfWGx06RE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oNheVAi1VwgkLuZy8cCQUFHF8e6DcgUe6DwVlbbIOUshbmM7r
	5h8ths24CRwrE1UK9O7C+mjRjAmWANJ5zvtFMd/B9CC2gmVqHxMxVCvC
X-Gm-Gg: AYBFou0GMZlvIwEA2l0cqd/T65GlWVyWkAaBUV349CCyFR88cZeHu95uEafxLK5OOUB
	MzsQYfy76czRMq97A3eDQQb2Vvbt/X5WByvS5XFn6NNhGZ9qOftwz1Skw4ybx8AX8q/ztpHAgJN
	B8U+FIkCcUAq17Gj4Vbu3cIf616Fz2IQb+qk8iiSJJnhG6kgtb3YUKR+5KUAUF9vDHTytt7zSEz
	KQdTNIJp2TCvA2CwKvbNLQJER7VGlIV87OcSUYGI043j0pcciFYlgbFS81nv8yW7ivmJQHDCbPR
	8/wVUtJne7uoGMOkAKrAf4lQq7qMAhyKFiTu8cahYpCIVwY/ZK25OI4bEu0TGo9myf+SbQfyNYs
	vH3FuFi5FYifvusoUq6yZHuUorYF8LL+/JKJq8FvCtG3dA3Ih/V8SqpUJw8XxSGaj732aSi7CTm
	X8OQowbOrEmWBxrqBSYVDiWNVLCrpZmS4ITNY7RyBKRqUzvuwmWiD0l5iXwRKKPCitHOgX0wkCO
	8zg/INk08T0ft8CaZ777olibHAJhDN+ZHmJ/e2dtsyejdBmvX5J8mAzf58absVGOdvFslo/cwZg
	MLuliRtBNE2ofzW/ZriW7F8o+5rJiwh2cjFSYvnMDoUcfxiKdujWw6VO7/0gEB33zU17Q3mTxaU
	By8ZqkB3HV5EKEJzDsbY=
X-Received: by 2002:a05:600d:82e3:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4b6dff87583mr116421135e9.29.1794066752809;
        Sat, 07 Nov 2026 07:52:32 -0800 (PST)
Received: from localhost.localdomain (bba-217-164-30-115.alshamil.net.ae. [217.164.30.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7d2ad9b95sm86011515e9.0.2026.11.07.07.52.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 07:52:32 -0800 (PST)
From: Ximing Zhang <xzhangjr@gmail.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ximing Zhang <xzhangjr@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] hwmon: (coretemp) Return -ENODATA for invalid temperature readings" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 19:52:29 +0400
Message-ID: <20261107155229.30955-1-xzhangjr@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107053626-failed-6.6-f63aaa529cbc@kernel.org>
References: <20261107053626-failed-6.6-f63aaa529cbc@kernel.org>
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

Hi Ricardo,

I'm considering preparing a 6.6.y backport of this fix, including checking
its prerequisites and coverage in newer stable trees. Are you already
working on these backports?

Thanks,
Ximing
