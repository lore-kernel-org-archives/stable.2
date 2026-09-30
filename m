Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF137C90B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739193; cv=none; b=keb+GM1mTidB1nHTUwiZx2i5ls517oMiKYioP5ZLvVGJ7TsqWSF2C0Vy/wu5k0r2+wbk8VhCUEozdAMnfU7LPe9qA/lID3a0KWB506GY8rvzcge1JPcObt28vNFrTDG0VvCcpE/4d2+eJCn6uHWqNMoGhVzZdALwj9BFJgkRLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739193; c=relaxed/simple;
	bh=C5KTfbJItTTfLKyd2Nny7nU/poP0EOmgsN02i1wxWS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyKMxR8Zbxv3jvPzR9aYmjKwRZbpUQvQ2BHNuIlJWL9kKE4VJC+ZikgvFoJWpwGxnr1nlC6BNU/7uy9/kh/CIxjr/WDTa4P8dPnoEkUkmRav2hW+4UXjP2BtCxRZxqTBLDcvfImVhbPn/J5jhYHhhPoFN9bCmRaW0TXyqBuPerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzD1x6Ta; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzD1x6Ta"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c3304833so1873896a12.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790739188; x=1791343988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5KTfbJItTTfLKyd2Nny7nU/poP0EOmgsN02i1wxWS8=;
        b=FzD1x6TaMXW/7kul3dD6K4OyYO79+c+9YKdNc6Yv2Opneo9SkZdZFxISW/0qc6LZwC
         y7rRouKLj6gb8ZJfSN+X1CjBDiAyTxonoNQKwwpBkL6ksFQkmkvFJTmlxQbBz47N+3DG
         ntb+jRgTSQMcftm2JDQhTfou/QcICpmteWIg5ykAB69BI1sPzoF2+jgORt+OCjsxV8sg
         79+iTBRUOip1N62gu3Qy4WjPjuRIjMaOoCpm/VhOQg+ABirm3CWHGpssSrUHoiRzohFy
         c2t7eQ+xwbDaEeilCBiCVC8btpkOGXyH6NzOcpk0KZjqFFU/IvWfw+ID9CdHWuOL7+aH
         C33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790739188; x=1791343988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5KTfbJItTTfLKyd2Nny7nU/poP0EOmgsN02i1wxWS8=;
        b=zM6K6LRMy66qVh2y9/o4teYqJQU8Qw0xJig+O8Kj11AFvElfyMVAxYOMj58SAS4keI
         OoY+vj2725olxXv63hM+rDf0okxX7z+HCmDOST6Zd1bzrBjfb88hRbmb+m2jYa6KF6Em
         N0FK/UdaJ9mOHEbHfduRtthhfGwlcxC4/zuzvFQzUCPgpJErJxkTtBzl4o598Js+8GWw
         z3t0goFrmWmIeNmpxkMUJh+AK2WCDLN6Qlu7jiOg0Mssmu5Pnv590mFYiG5lM7gxSGOb
         joz8ld1KYks2YSh4fG+oX5qpU3BjdIPE4v/sHW5wQmoqlVJ6jhDowBpiBbfvUMczTp+5
         OtAw==
X-Forwarded-Encrypted: i=1; AKwUvBwRTe7+TCv628D05HBJLzZRP1goXaAGfor0hR4HjbcVxO7m7QoEwTikrALXEGM8vgz61+qKfzo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX4lXbqZjU4vzpzyGkpgKdiX+Iz2ZPHLyrXYiEe7sWNjfS8zHK
	PyT5CdYH1fpMz5NKirRAN6QRyIOjG7Tr4y5WwawtEDg8tgDieu0GZNyn
X-Gm-Gg: AYBFou2MEauZNmG+IHYTLocbo6FLe+VswV1XiHsDaSW2FYNriqdujgyS9sE9f2BtMl5
	5JOTCxFXswMZ9r93chyeDs/YbZCFSm5LZj5NlElQaVE0GD1Gx8WdfouSD8m4pOE065Co4iMZFZs
	yZIqVEfeInD7weI5V6XIwFRkj989h91gFUjvyBk2Oap1nTBmxXsGKghFfJGS3qDTdbBazbO08Km
	5/xFXmjZ0+J/IAIW6hwbTsx+HtA1PzJNnqrs6D8sVT99Ctrah5ZPVy8vMSnOPIh+5gW6n9XK4RK
	P/RkkF4s3DWkl5R5nl6/OSv1uiYv9ZquGByjXZWXjzjLb8t+nGzVinoeTqDqPg6KmTOJuwoZ4i2
	fI/kthwmUdJJ/Skzk9STYkyIib0ciEtfBbANT+uGoK7lId8lDsxgGhYmPypCVhQLzBSv90fCGDH
	mOFqvV/398Rj6t4upoSVqj4cl4+t69ynachDWdQyb0GNpuTKTdHMrcbDykkVGO+8oU/wNzQH/Wh
	VDEMh4/1fHktP2PG7ukncz2oF+UXpGYFfQAZny+wcwKsAiQ1EIRz8SZQYb+4aG2V1bsEHN8lnLG
X-Received: by 2002:a17:90a:d446:b0:39e:6a81:5a98 with SMTP id 98e67ed59e1d1-3a4d1b45841mr94775a91.44.1790739188069;
        Tue, 29 Sep 2026 20:33:08 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n11212025079.netvigator.com. [112.120.25.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca7810d6sm1184417a91.6.2026.09.29.20.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:33:07 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation
Date: Wed, 30 Sep 2026 11:33:00 +0800
Message-ID: <20260930033300.30295-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arw9CHc4mIOm5C6Q@kernel.org>
References: <cover.1790568982.git.xuyuqiabc@gmail.com> <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com> <arwssp0czGg9XKv7@kernel.org> <arw9CHc4mIOm5C6Q@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 30, 2026 at 01:34:48AM +0300, Jarkko Sakkinen wrote:
> No need to resend a new version but I'd need a link to the *report* to
> retain reported-by tag here.

https://bugtracker.nebusec.ai/f/675

This is the report. The page requires a sign-in or registration
before it opens.

Thanks,
Yuqi Xu
