Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C15539789
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906830; cv=none; b=gIZ9VA3GDD5xqBpFHetO/8eWDabvyjsx8ejzQXO0b4K6asPszoC0gUf+iE5bWrL6OajnJdQLUPJ1b1Tpv5sTCeRWM/3PX81EaHCTpc6F8mHTM41MtIfUB6j8wz3HPkrkKhhRcDkYe70wnRhDTkAHKGSrvNq3uMqWPYnqsoYOFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906830; c=relaxed/simple;
	bh=tM02Joz9t7HVO00dryrG+Vb1mg0Gn1AtgSVS/LJ4eHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUzSQ97R1NwptUzNff5f4TsgczUnJJs6o5C9UnEEXP3qGX54oCeQ46fQdkxC6aQug1itNwwslHFjcI3ENeZ0wC/lMhEy+FRs9pQOLaBwRYc9ICx4UrHXOMerk5NtPRCML2dz6DewCy+uEESemRTr90ojuHGXaQCP4AA0eVMUcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Lq9R+323; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Lq9R+323"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e7006bbf77so567855ad.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791906829; x=1792511629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weVoMVk7+8IBm1YGLO6BLCJKDE8BQGTsOSBOllMfeck=;
        b=Lq9R+323j5eKecJoQEJWiZPopyykoaX6Tan5QKfJ02sNDheYGP6tI6plf6NlTbGcyi
         9zfOpI9Ew4Kb8t98Uk5FWL/aNZNGKYDBCMBfCj1nxQUIcHNhlfwOgmocGYeSSGbeJTHH
         iVwl5R5O6a66R19Y3fea9rNqAZaTKSp+L99gremNTH9llyVkQB5uVQGFpcshfL6QX2xQ
         eyGqSRq2DIL+bm89H2eR4NZOfJFOLLAPQlTaYAsGlMNIvMXmCDQGQafwa1Hem980HVF4
         NyCOCEjdDVeqZ+09eZgFrw75XKQw1clBst84csqx4lyuPbRSwagehd7edde7tBXmmufa
         dYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906829; x=1792511629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=weVoMVk7+8IBm1YGLO6BLCJKDE8BQGTsOSBOllMfeck=;
        b=v789Oq2oV+mbHoUHs14UkRMhjdshLPsbcY7C1NY7ruU8iWsWXERA0dPY/Midgk5all
         06uZl+OKN2obfxZRHYayWh+auyjT2ovhKviuWevDNpG95ILX4lPe9/ylUocB+ALi+snc
         BG8sOG5SAauK+2IsQ7cShNfJ/j9G2C7Zwm6ipvBtJR/QSXb9jfihGU/79Bwuucib1npg
         UW0ax5RQRasufiN80IWLTO589sJX9Mdsw25YDG8cqDl2DNlEEnjHt1Xa40daM99PHRgk
         GOGlij1qclkZjNA0BfO5inabjzZSBYf2yEFGJ3fn+Wnu1x6hQ7/eYn3Rsvcw6FzbskkL
         BAqA==
X-Forwarded-Encrypted: i=1; AKwUvBxcHnQIN3BkAgPEfrQ1hNGrEwTArbgsstzwqD9R1J4GGmR/gxUjVFl7f6xtKPcMi6edwITvio8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfQ29wjSr5jtKG+0oLSv04KdC+gciHaZBCz8rg0HNFYidPvZ2Z
	Y1+5+ICg4rzveMyRha7pc9NjdSrWDwC1nwDlSOAhRpIR1arkUnF0u4mzgty5NbXVsew=
X-Gm-Gg: AYBFou3fVNtJCF6r7JiwyA30MQDQmlSD68GCAWtYEq4zs2xz7Xfz+IL+NJ/KZbamzUz
	4RXNHgze6p6UH0Ru6cGlWodtIc7dx9L12zodln09bsQ5HNBW8aahajn44kc4Vun4DpsOUpMkfqQ
	M1FPskDq4jwu77ADF4AgdjIUd/VcQYJ89tOkezJdGNLqDVazQIr8hQHoDkdSSaBYgg1fSgU+T3G
	uX3U9kjgJDCR5SI+x0VuSAYCFgxvswBMKaazho+b/xjv1RuZmGn8h6DwcLPos/wZJXLKT2twbkB
	0eHBqNp6UMtMbV86voaTajqm1E4RBLN6HSrmbukiDEgZphD6EYI9dsvg/eqH+3U91sVWgOXpSuc
	FzmkiRMfikVVmr0rpCLuYUMmZTvvqGYeglx5LloSlIg7MeTTQPpGV96r9YxFbAJ54lTIl1VWTPW
	rauTqtq/hE0CSK1W6IyzYa+y2IBO82HJZGKgQB2STEX/DrGZXW7nvPjsjkmMmTc4/iLQRuxP6Hf
	lYrhLOPiVyLYG0gwT0L2s/15KBWAg4=
X-Received: by 2002:a17:902:d583:b0:2e8:3f72:4c2c with SMTP id d9443c01a7336-2e842f1519amr122389725ad.62.1791906828923;
        Tue, 13 Oct 2026 08:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b5fd2sm59793355ad.50.2026.10.13.08.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:53:47 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH] nvmet-fc: bound the FCP command data length before allocating buffers
Date: Wed, 14 Oct 2026 00:53:07 +0900
Message-ID: <20261013155308.3188757-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013141904.GA14323@lst.de>
References: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr> <20261013141904.GA14323@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Agreed.  v2 adds a ->get_mdts callback that advertises the 16 MiB ceiling
so a compliant host keeps its transfers under it, and keeps the
allocation-time bound as enforcement for one that does not:
https://lore.kernel.org/linux-nvme/20261013153316.3178656-1-yhlee@isslab.korea.ac.kr/
