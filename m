Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5ED4FC320
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780423; cv=none; b=FKQ94EfipYI9pUABqncXmCb5z+GW1FVGGOuiLVDWlMk+/4aN7+byQr73A8kH5/tFrd97jPW+zTNhKDzNWyyeiZ2OtUNthQCSnSMFx91Sm0qsaQDRShdc907BpNJNUZqCv97uQJMqm5sQhaJETFoYdHpQKVrhxQnz9hg3wVH7hL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780423; c=relaxed/simple;
	bh=N64Kife8Wv3pNPtxuDBHaxGts8CS4MjcJ/Qp1zUz/as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoPLYgpcwUGu6GQCTfuSCfI8aFK5VfHR3LVoGk3BaVA+BySynOHk426KZZbGYQ9V7Axb7eiUWLbxYTwexqWCbgLZ5t+pXx3IFHzoTqmYzlUhH0WGZ71wmRRgh8titkuKCQ/1cgr2KERfFlfYVzdC/6Y2foefeKRLpRrMATtGwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com; spf=pass smtp.mailfrom=wirenboard.com; dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.b=cnw20fyl; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.b="cnw20fyl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso56893295e9.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard.com; s=google; t=1790780408; x=1791385208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N64Kife8Wv3pNPtxuDBHaxGts8CS4MjcJ/Qp1zUz/as=;
        b=cnw20fylZxN3fkDmqJpKL1Sadx6qvd+dFGew6DRzafU5NV8tPL0wUWS5qyJxkUR+5n
         MNLbVhainxEDcktnmnDDBl/f//LsfE1tFPXKBFt9q2Y8qJAifG1IZj/5dI5hBdp87U2K
         npKwYm6WEQUR8V/piasdTm6NuMYsJ928+y10qEpGlbyhmNU+xalwDgM2DeXMPWgucBXb
         7sDzat16Te6so6sg1FIKSiilveuIZQg5/xfo9gI/0CLu7evUhZ33PtGtE11/MghLczxh
         p196bMsEmCpGWFKN5A1zFZCo/WlH27JSUE0yZc9oDEfJaBoMkcwLU2xWoGPTm6meh4Hq
         jFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780408; x=1791385208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N64Kife8Wv3pNPtxuDBHaxGts8CS4MjcJ/Qp1zUz/as=;
        b=bZzdhbUYEwEnCZmSqrpv3878SMPD8vh26TMCv9SKwOA1svj3q9mqHiYRekXjO1bZnM
         HaHhi1UbOOf56XfYzdHqlOemHbXZZimXEy18GJZqxG0FL5w8WhaupshdW+Eflut9KPiW
         Fs7KXGOyvHu/VqXQTj0W/h3NgwaTPJfk7k2aNcbxKDw8RawKVDr49vK9PJU+NUrmeH2s
         M41OO+Bhw3baXfcJUtyR4wwtCxz3/BhhmODlfhDpxaO2gfyf3NmUWulPVkQ+UGRd76T0
         Kfiyx8G3XVgk3f4kOw93kamOLWORPjzX3Z/FjCW993XaDa5LNe337wAPxK2LPPq5rXaQ
         1OMg==
X-Gm-Message-State: AFuF++mU98If3nlXjomAdvfQL9UI8Vj9M7qj3z8h91sPM09uHAH+pXVH
	QGD49m71cT7ztDmeXl1R5nJM9SPxQq0CNeYiGUzggUNJ8RpPAW20PUkagVtIhLC7FzJ6YB36iTN
	v+56P
X-Gm-Gg: AYBFou1B+JXN9g21QOcuPgt4ySSB29Wiw6IZbU93IAfjZiUqYNi6xBO+89zkxEzi7wB
	setbIMpYZJVPH9izGyqAUNrsSELcaAncAeekNJXriUoeanWzRKmjZYqfp7KJwlvZAtbcafBYKwy
	3jK6n92GNRuYM1hq6woEL7SXNTGnFCrTg9xzMBv9WKF000KljNYB0lNg37zdC0gwNVLfoeGp7dS
	qShuD8KoF+MeYbN3yrmwVl4EFR6weUXDL+K+NfBy2JgwqdKjXydrR0Jyy/3fsxeSsKI2pXJ+u7g
	rPmUuxWkCCGUN+GbIv+XQ3fMiHrkvyA8DFxPBoSOKGwH8GUupSqkcdu2/LjTKvJOUlLF6nlvMu/
	ArSCgqjfs0yDGeQRcpmFfor1ozCv5UCOm21cAXeq7uQfpeJ0JlgFeQzJC9FbEDeedyDlxRYIu6E
	uwm02yTpboQJT/SzvJTZTIc7QCiysjYLnnDpYLipBkDy2GB4lP7HSnjC3aaLLIFeRNvbGMHV183
	s5z5DHgxTAyVKqYYa2WAoUG+wi5s1qOKCy6Q+6ee2I=
X-Received: by 2002:a05:600d:6445:10b0:4a0:1b14:d00e with SMTP id 5b1f17b1804b1-4a01b14d069mr23598825e9.1.1790780407878;
        Wed, 30 Sep 2026 08:00:07 -0700 (PDT)
Received: from localhost.localdomain ([85.137.25.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b028b237esm4605274f8f.0.2026.09.30.08.00.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 08:00:07 -0700 (PDT)
From: Ilya Titov <ilya.titov@wirenboard.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	linusw@kernel.org
Subject: Re: [PATCH 5.10.y 3/3] pinctrl: sunxi: keep a shadow copy of the data register output latches
Date: Wed, 30 Sep 2026 18:00:04 +0300
Message-ID: <20260930150004.37497-2-ilya.titov@wirenboard.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930111931.1214201-3-sashal@kernel.org>
References: <20260930111931.1214201-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks good to me. Thanks a lot for doing the backports!
