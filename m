Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837050;
	b=nrfelF1daRRvi8cpF8kqVoishikjtgBqwM+qEWdU++6WwkpW3rEq/OVhgcIw7kCgPSGa
	 TlQAmDIlvNGaP6TlIlmcchEp30kNtt0njIsL4K4MPpxDiQjme3r0vIuWPjm2AV0/FPqAz
	 wSYwUO8OyqFaq/Z7biPi1lonx3t5MScQQZ1sHxJ6M2vwx/hs5Re1lqTgLBNaaNpKw3Z3/
	 TRNCMsXmLkXO6/dpcjanOjZB/FGyTgdE5MzF9rED9TMedL1HSTtHd3EzxpNrp8NutLtJR
	 YRLOCqTE/yTOFGYMpjlfAnzKpBuisgyJ9KT72yogZnceLQPiaIK27vEKT7bE1x9jJww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OfHQHM3R+bJudBxYYvhr0hB1WtSESOcSRLIVPlqiZOs=;
	b=4sdyihrR6C8xX48P4LRKTR3dfpUsUTB1xvOxTnvw13SfUgdiSyQdwQG0sOHLVhhyPc1Q
	 K2LCNFXCJvdlzROJmNDkH62yHfjxL1mHNl2Gr24KGnPq0neCkOknrurs5LkqOoTOzEmT3
	 p1Vsyqsh0edjtXJcDjWV6ppTdZDi1wNfYWqUpdgOWdnFKjVR1IHcEHLkYQDp6mn7OrN1N
	 0sdv9NDYzNm/mmKzdqY5HK1hDF2k9Q4ZxrgeKcI37Blh+E2zLy7DeDUgtthszZeQDO67G
	 Wa7HcrrYgkU2JgN2CuPPyKJ7QZ5VYB0dX7BSPKQjzT+36XZ6hEe/3ZSWnVjkQjYc/dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBF+4URO;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B660A6F57
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 853B660A6F57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBF+4URO
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b467581b98so29609495e9.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794837049; x=1795441849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfHQHM3R+bJudBxYYvhr0hB1WtSESOcSRLIVPlqiZOs=;
        b=SBF+4UROMOUEWTue8WdlvuLI4sdVC24pYGuePfawZCeckwbe10Zs25hmSgoLcmjmWV
         fsf1P3RG5a9gydngTRd/PZ1fa5sYiUVR6SIAhHxjVJdlrQCwFMLyg9MPZLuNJLK7iIMD
         DeWTz3Nu/SegJ4Ar66nKt2JFG6+Jbmyackm5qcLK9om7fJXT21X53YYMcIGCjbaGZNKs
         xIpf1GbjjBGeaPDOQFrVQEgLWg/ke85kDJSjMKhR08cQKmLxXSKLAS5O6Fkk/3K2dLS4
         EmnMwWCpW6KloDHc6S8mtURRIBSjxSg8BjH4U7H2kRug9y4y+/5M3ogdTs5ckW0oHZKm
         voeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794837049; x=1795441849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfHQHM3R+bJudBxYYvhr0hB1WtSESOcSRLIVPlqiZOs=;
        b=hi8Cmn92RzvofVxvyl7opOabnLgEExbPLmjuoJzSQhDE507qD8CwdRmSw0AT2VSYdZ
         dYa2hzxyn96PdNpEXLAtbSfhZmu2aY52pXQe+V5gwmUz41UKtaBEUoghPyBnEZFN/Jdy
         V8HWladpy9BOH8zLRGFw9kqkrHGBmS0dx2kC7ibtUP56PztjXAXXK9cr3bBNWSBnCmT/
         0z4l0qQFptYzYE+JPOQqS+sE3PdPB0b2R4/cu94oozC+7E0rqhRFVkpfcDZFA2GPjwpy
         Nrics11Ouik9I55Y1aT8UPnybhULXRUU5oI4G8kpjl2kOAa69yA4QlmV1s5pfOGMecHs
         PDWQ==
X-Forwarded-Encrypted: i=1; AL+hErGm7bqlyqLUqRloSJjTS/nIhDks9w0aJAkJoJoWY++IVTQ1755ILyW7Gym8pxdFZ+v00p9Rb2E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+HR6OcTLVov4Ve6APmhpDaj6s3PpvJVyu5tm9qJOT6dQ7/tLI
	RnKt2/YjS/FaWGzhb5MbDaEYRapx5vdfX0AzycsBiclZGI1ZbiLauPW8
X-Gm-Gg: AYBFou38FJV7A47fxPSi3xkni6KKYmxE+db+YYR1U04u5OR2esaxsaN42kx8m2055fE
	OeQkWlm03O98oSxaT+mewlA49AxnlVku5+Z2ZH1NE7lkVRnljt435u3gxLaSlA6TeYoVpfTvlYz
	h7lB25iYFiEr4WnyRWy1VP2BSD923jSyanvnRZJfABrZd0gxjVqauf2mI1TU2VPHeMHWRXe/pCm
	tt8b37pW0bGVysJk8UJxMksSJc3QvvwEyQhAo7fEjma9FZ53Uk/PL7LdFvRKK0Pt9IQvfoJNiSw
	++tWcS2TZ/bBNPwH4z2yHgMUoNsLApABFTc/VvHJX2p68cWrAcN6iFLIrW5RPvEiJ2YGAtBit39
	4RxfwAsZFK+rl/y/+28X1yR8RrLHhg/iUgeOXkqT3Bek3SkqT39hzGvsl9zX1BHYEYZ/YJXS75m
	8GfY3taHWL4sV1Mxei6GVG9lCbxMkw6Nw8v5NbR1smHhKTE4JLrxzKfgZ1am//GV6IhXatp3T1z
	iqBP5jU5jSfng1M886ps+UKFyy1TNj2tu0YXZHqCx78Cb6OQSOkp6z34Y0KMsF8dUGVYhevbFLb
	8uCA8H1S7SVTsra0PFKUHInaclS5bJXBRpLyMUlC8ruHgBB5q7pcdfR6
X-Received: by 2002:a05:600c:1d0e:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4bb55abaef4mr221596805e9.24.1794837048913;
        Mon, 16 Nov 2026 05:50:48 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb6fb45a32sm69904235e9.1.2026.11.16.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:50:48 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] i2c: imx: do not acknowledge the last byte of a block read of one byte
Date: Mon, 16 Nov 2026 14:50:47 +0100
Message-ID: <20261116135047.1379330-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116124430.1358948-1-mehmet.fide@gmail.com>
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

Sashiko is right: with PEC this NACKs the data byte. v2 will test
i2c_imx->msg->len == 2 instead.

Mehmet
