Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C34BD119
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284315; cv=none; b=jnZQredBCeqaCAugSNnEG2A8ZU0OTzvbPw6cVOMBrV4kFagKWii5xHiAPC4Jl+llkDR93fwBtgyRVYX+nfvvBuSf82hRgm8ThqtBj0o/H+UsE/CCHIJXs+IFszPdeKN4AHPMm8sC6uAuR67zIMSagi/9swgQGL0HMK+n2QDK8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284315; c=relaxed/simple;
	bh=w8TV2FMwsNJ4NwI4g+tBQXy4aYGJ6lAIGTiwpJ98/64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXVuwugBe3tRF9ysBO6ZeRasFojPJOV3NbnD6MfJGWGW0myfVPxyrjj7Qw58odIVfvF3cRWA6rNLJwTl5o2rH4dk60SypR7F2SXpWSXOvkO64aw1k+yjUJBnIvYpyXvI28VPYLuaDEui/O36BBykqF5u1kOrXh3QoNfSPKotU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW9LLJcv; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW9LLJcv"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e051fso200835eec.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790284313; x=1790889113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8TV2FMwsNJ4NwI4g+tBQXy4aYGJ6lAIGTiwpJ98/64=;
        b=OW9LLJcvJFBBEDgwlyNSd/52UFJJC0M34+EWz02F6qRmm9/opNoJG9HolDTX/E3sQm
         Sk7hop/eRRe02UY6bilMCxKxQiPvsBM3QSqPkVXFKB+goNsEshHRj4qXIj0ekIkr82oF
         xFK9MGLCpUBVPCgTKBhsPn8UuIQhyTtXjVGRGG5mJkfMCH4MZTxBMp1XFeRCs7ywmIf0
         LXp31MF9ruwePvR9JaGL151Dayg05gXzrGwgqrJRTXO5kKlmtRimgKXOPLmSopbV1VRq
         XzEamgz1k+4acgK61uQ3ED0xVYxGN6SKgUnmFwWAxkrQZ0jYePN8LVYsr8lidcEZBKur
         5rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284313; x=1790889113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8TV2FMwsNJ4NwI4g+tBQXy4aYGJ6lAIGTiwpJ98/64=;
        b=FsRJieWO9vJTQJmEpR+zycsaaBHHRFedeSe4KVFFHR43RORu+u2jarW67jzh3SmKRJ
         jtXUCn7D2e1QYDzxqlYaJvOSe+mQJyziBUndFUktLazB7vsLIcwWRZwXsNENCJOZoOy5
         BWP+MlfmUTAWr2oBTbhvt1O0vTyZks+z/0r4L06VF44vLlurKIATan7ECRKE8TYonLjX
         uhzHP9a8oXLmIRAAprNbW+ccZOaxTWB6csT6fbfLFpmjMj9QxTsmcOKnrbJDnr05PFMV
         bBMZnDVTxd6UUloFs3gRUSBvwZzYFGKOyTqG7toj3035lt0f62K6eg8jCZMpMfNPgal2
         R/5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxIArmgs//6JTLFNhYQ70Lh7rVnb/2lKL/YlLFp7Ws2VYx3unXZS8Ww4+nvq9czMtmkOQ4FKF0=@vger.kernel.org
X-Gm-Message-State: AFuF++nzTRi6VN5zlulHGJXDfuiEban79xRxdcKm2IECIu96npQPMOab
	4lv+QRSC6NPLfgGE0tFpjgZ2tKIlNiU28JorIFX6gyxfov0UysGmaEq6
X-Gm-Gg: AYBFou1fhJN5VqslBr1dG6Ejzrvure3fFbkjokkjHvCRQYA+W6g9MfuJnncYpCT3mot
	zM9hoyo5aOvyNwmP7GxiG60wafTlbceMQ1XCWZLwqLbjZBo7O3q6nzRqld0asHsCaN3g06VRS7B
	FwIY0wu6a7hLOpaj4ajdMVXOk35G9B47RqCBkuVxBZnn4vteU7em0WwQCtyvMRUTR6p3ZVWEgjO
	aPHXQ9RyGNeY8ebPJ0WSPWbkJ4hs5sdL8o8P/LiLQC4tXuae4jMSuKPARtvZoCE2/K0EnVxJ0oS
	pwwRq15NO207SzLHUc2MDHHhcjUD+pY9PvSf2zxx7OPsqy6xmUJQMl78XtQXdXa5I+OyJGpuyhu
	AlPZge/033nEf0tgf88/bti0IEiwww41JoU7n32CjIBqEofd29AOa7pwlPyn5aw+34iAVu4h0kw
	LeXGs6sr9ToH90RZ+CjVDtwxzw3i9bD5Zhz+DKNyTmIaggpi7RQ98gJ9hzcnnhpnBqVTFCYjyki
	EFSKjU+gvlfB/o=
X-Received: by 2002:a05:693c:829b:10b0:33b:e21e:4a3a with SMTP id 5a478bee46e88-3400439b178mr3764277eec.40.1790284313380;
        Thu, 24 Sep 2026 14:11:53 -0700 (PDT)
Received: from alessandro-rzn2024 ([2804:ebc:9128:3400:2680:233c:7520:a2b6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144e4a6b9sm999537eec.18.2026.09.24.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:11:52 -0700 (PDT)
From: Alessandro Menezes <alessandroasm@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH] Revert "media: siano: Convert to use sysfs_emit_at() API"
Date: Thu, 24 Sep 2026 17:11:44 -0400
Message-ID: <20260924211146.2921657-1-alessandroasm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830172330.3395671-1-alessandroasm@gmail.com>
References: <20260830172330.3395671-1-alessandroasm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hans, Mauro,

Gentle ping on this one. Sasha noted on the stable side that it looks
right but needs to land in mainline first, so it's waiting on media.
Patchwork still has it as New:
https://patchwork.linuxtv.org/project/linux-media/patch/20260830172330.3395671-1-alessandroasm@gmail.com/

Happy to respin if you'd prefer a different shape.

Thanks,
Alessandro
