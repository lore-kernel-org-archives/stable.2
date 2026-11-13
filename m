Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567920;
	b=QwBMaJ78eTowd346hEGZqcTuzSe7mAUvB44JgebF/z9cWteLwI08myETNj40EjSI26M7
	 uCMOVp927bQDojuVn8kqtOdZa0JpZVv/7HTkdYMhdQhm3tiVUDJD7OYqwibYIWVzWCjhW
	 NGloRG1HV6hSfv2UkgCYpzqRhHzjkMYc5rmhsa0JjHqkYCSSFVKe4DKDsKO6nu7piWHMj
	 ONhlyPoW0ya7lKGxNOGh2FO8rDBB0VnzxWGwpPjTf5PWY/o7lT3yJLvOWbKhM2UiWPtyY
	 yVJ5vWQZgGhvFSYLAahtOIHOv6mPuH8jEBUlO0imuaUVZF5QpO8wYdZL9YCoFpeF9cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QftI3K44ZZiobTwr/u+4ZTOlGFkxNtcO4iEVZ0vgnek=;
	b=c0QWx1II6Isv5fppbX8hM5cK7C8NTZ4DJeKxZ3wFaN2SijIn7CmxkRtjnp2ibO0Vei7I
	 /CfZoCvCW8/zJLgK+2xvcF1QwwVrRw2dgAkX1gW9F679pMhQtSGfYKvgnCaVtUxvpB5lK
	 Oer68l4u0joLyoHD7peeGA/Z81WLMSnd8EI1dDK6Pdu+whvLLwkaojegowbCqo/sZ5zUu
	 OB7hZ2oM0FMOHfUsOIv2rEkCWYmjoJxGXlRVfFwXeYGSi9WN+YyMV6wCApuNx0vwP2RTF
	 3vCjw93gYl324ADn0h111afAVQ0gVP3QbddtPFpklb3k/RNdYfmcG4avAEmVfgkwnOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2OthWkM;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77E606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F77E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2OthWkM
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so8068345e9.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567918; x=1795172718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QftI3K44ZZiobTwr/u+4ZTOlGFkxNtcO4iEVZ0vgnek=;
        b=A2OthWkMGm0zsNyY35xrHT76UqK6yWeQ07k30O5+g0WUzIeRFNJnwKJFwe35vdk6ys
         S90fiAwfr06xGkl5DyCyQNIe9Hc3nQGEUzV0L2VHa/BisCyvWruEdn+kR5fs4jxBE9nw
         diyiyKH3d/3y8vz14vzsOwxj61a2tpSo5kO1dcbcxOA19SalILeuktA6zzlC/srIsA92
         cd/vKip27+mkdz0CClhTTHy+w+opMEOcOvYTiaLB0/MPuKHKHhgToU4cUTeh+qccsO2/
         c9VWqsSt1twsHNCavS31smcL9BgN7YH4LBlJP79RBf23eXug6pfS7V6wMyJAkoVHfr5B
         A/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567918; x=1795172718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QftI3K44ZZiobTwr/u+4ZTOlGFkxNtcO4iEVZ0vgnek=;
        b=DHfVj6i1OypQ9uXGG1tolTLaMJ4nZrVBwyVY55ZpTEyI4jdmYP9wFDSptVaqOtBSBs
         BPjuEnLJhqz0HlDNk0phk+RgZSDZc24pfz5hN09Jzr6Y6e2Eme8elwVPO1MUBVusOTEm
         1+oaHU8BQ6qXuv+B95EmOMs819fsBGSnMs1TzuwcQbzPeB8+F9NGcR8r7D9A0u5NvrrQ
         OVwkJrVGd9JMbwABX2vwPpfEuiC/cEeD2ZD2nsXu6fbpfsv8Vl//Us/4WRN1l+QVGYVh
         xa9Dh/ZT5n3BK13zuX/LQjL2cOVnktPSm3V4XYGFYUWykYRN3+D1FMz7NQlIE41nChoH
         d8Ng==
X-Forwarded-Encrypted: i=1; AL+hErFMklgd030N7JeBnKqQt6sAI+PN06WwxrqR5FJkrFgZMy0IL4flWBfNN20lrB7p4X1+1wnVYsI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p1zE5zauJsrBhwZcYaDpoeUPgNJVSYFoPdsVqtlJiDNsL0UCK
	zeFlofEnCGscK8NlxjNukTMji2GFLFbZnSG5HaAoB3XlyWyYEACgIgwY
X-Gm-Gg: AYBFou0kqbZZIHxKmn7si8qH48ylrtsE0e97/yAwYyd2jTRENT7agSldMG/HZ8pYsHF
	N9pxxn0k3/n9jVAANb3lnyg9ClokscgroHQZ4M/axonQbc8BE3x32rx8UItthJQQM3KZUjgYARY
	sq04tysRUrq7GvFdgt9mEIlbYT8Y8HdXg4BaMwUEoRI1PGu0IGUm90sd5WIHbZnYXTaQKDYkmC+
	G2+gh/CoKaPkpCch014w39sEiBlYNd5+uV23lmTApNdDLh3nxKKLfn8pFCeBXfg9O0dTcYLKY4z
	fZyuB0ySKfs6w7BWDt/NypjiFziBwDm6dOi66t/wFDuLcTCuRT3hBSwnfJENqkY6r9/A5x3GGnQ
	qrfkAMXhs6CcrX3Bw1sujp1LNqCIuqpo7PS031Crs0mWf09tHDonKn4HCs3xQMRN0IpFS8+z8aK
	Oz3588nA3kj2NYipbGmgP9HXri7DB7UXqmsumCNYq5qOPGvZToYmb0tNeelsiT7GlCEbgaOftCj
	o4W52FPt+bpxQXZZgZarfzcZ4CHsd/xMc/SF3VrSVL96CwJYUDtcK3kag35aDzEFYSaqeAuDc6J
	Lfjhqd0efuLDya2GTPeXQF+rDgQiqkgTWV8=
X-Received: by 2002:a05:600c:3b16:b0:4a2:1960:6fa with SMTP id 5b1f17b1804b1-4bb55a6116bmr46200125e9.4.1794567918385;
        Fri, 13 Nov 2026 03:05:18 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e4a2asm4788105f8f.39.2026.11.13.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:05:17 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: imx: return -ENXIO at once when a DMA write is not acknowledged
Date: Fri, 13 Nov 2026 12:05:16 +0100
Message-ID: <20261113110517.1142293-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113073250.1037215-3-mehmet.fide@gmail.com>
References: 
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

Please do not apply this patch as it is. Sashiko is right on both
points: the new -ENXIO path leaves the DMA buffer mapped, as the timeout
path does today, and a NACK of the last byte the DMA writes can be
missed. v2 fixes both. Patch 1/2 is not affected.

The block_data remark on patch 1/2 is a separate bug; I have sent a
patch for it on its own.
