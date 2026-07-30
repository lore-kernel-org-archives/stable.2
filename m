Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1FD3DA5C3
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450449; cv=none; b=gtBmZD18EnDpN0VSKtwZ/NDbn9XlvMF3YF/vfXnZ2Phdm58nI2C8azpOwCHBYbEtxGuRNOJXXta+bj9s237/LLkbnxw5XkfxROWnxQziNnTbqNVsXipT9dM4Dl2DBxI9HlmNYgIiK3JtPniJcVUAq8ptJF+D+j3cx6boZ7qGqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450449; c=relaxed/simple;
	bh=SYPu94rj6D4VpqXcFiyvTCXbBzDx+odXwtcIp/CbQ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWq3AsQ14OhLITP7X61h/1MTg55qKLz/5VmjolrwORpBqYTZSF/0NvbibaStRsqs1qt36ocWEEOF/wh4uXcYCVN+TEZZLcwvRJu/H9Uiu+1UsRU1RMiMuZUMQuRxY0+mRnhdZqsb//4yDekvxJu7zFKPr9dKHr8+DMT6YEsjc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPTSrs23; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPTSrs23"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66771ded50aso362606d50.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785450447; x=1786055247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYPu94rj6D4VpqXcFiyvTCXbBzDx+odXwtcIp/CbQ4Y=;
        b=QPTSrs23n+U2Ha/WCcEgsX/TBL0teAei0ZvY0qJUbBe3r4hh0XBn67SIBl2hCry2FA
         tpnpRfNZ5ta44df/ZtoDGLEwZxHqn9L1NeIrtDNxrtNCHv4fAjafDvXV0KGb0wm6s/Ct
         k951ZVJXfJFp8VYbjRu7UAysws9RkuwzLxuzjC6INHBDL29OufGBmX+a9F3UshiFaQaF
         rri6j16cOL3qGdBqKyQ3Vtuqx0F6cU/4QyoF8+x5o8ydIm3hHKFDimFGdheUHWZoLtPN
         i2yofsXPiYxJQPDPpb7IZ2YQB4PERmo3QBori6RU3H5x1q6np0b66I4gdABaBxJjep2q
         i95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450447; x=1786055247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SYPu94rj6D4VpqXcFiyvTCXbBzDx+odXwtcIp/CbQ4Y=;
        b=nRapinWmaFWmuLxYL5NNLfpmawYwIwLKce6ODTCA2qq/vTTGG7EzdHM21LTbSTMf8x
         9GnUJ/VXST0VxBAKlhgaXUxS2fhKBtnWkNEVB20gwDaGnLcUj8oGOhpvfXw8TVqQO8JU
         RNiNcBUjgfb0A7C0NHKkfHOlAYf3PVRcQ2M2rnW9ULqzUrtXLVytoqLMFlYtaeKP4lbL
         m3fhRTIPpepKN6WNFYP4ApQRaZgwBg3p+gAlb3lSYg+ALYkQy4EQayKUvhfEZn+megWM
         k4x8T07EgFFXchPotXsb1KbL5sYkMc0c+cyj3gIHJVqo5xUEF7EkMzbeHclSQw2CBptt
         CUfA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1AAn6CoU9V3MV21xJppcmZ6xoLlFsEvY5NKOd0fZl6A8it8uxW+lus8nD6rPM5kXhJ9NpZZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMY2EbBthTs+0o6BOfBCSdMJODO9lN3gC+mwq1jn3U7noGw5r
	RCIBf5yVRETZCEreoRA1VUOlelfOSS4WcjUpuXJNDOaSxfTmg0TPvgpT
X-Gm-Gg: AR+sD10W3PWSZ7W9H7kUABw2yhloInXqe4q41bEmIREdLyN2LB/xrViBo2V3cdsOaBS
	AXSgh0ld5TqASaLqQkC7pzrN/dKz97a8z1+JFdLprICK/7UnxtJj7FeN7jPgQN2iYMHH+DMnOdA
	rI6nYWrNjEdtf1oH5W0YjtsypYPRsDAd1jmC61oPk+TOmNyWrxYMZgCTzndqlUr2Mn75mAtaw/e
	1/A90ZpvRtm4gcOcWK2PZDftmVgw/alm3eD4lhzpyDDOOWlVwhPxi9uCk+G5HlISmGqnt/m5SAH
	0uBwFA1kM8YkZ4/P6/5obQ2i3YOQWHYHbyEHOMPcPf2hogixFbvb9GlrtP82Pa54jP8X18N/LF6
	d4NSpxdwSva/u3fOI8xvAiu9F5hb9CFBntGSBLlJ7yHMWqtZ+tk0O8HrggJmW+O1KEArwwNH0Lv
	w0YCcKnmKUSK8ygrzVqQU6VzuQphveRh1Kn3vjM0VP8Dau4ccWFxlDF1CjfD3MP9xQD3OouoqHB
	Ghv0jBRjmcrSQ9Azzkn0gQx+NnjQOfs0ek8frqQ/H9nOL0AwsJZgj1UaBI=
X-Received: by 2002:a05:690e:4506:20b0:667:a2e7:dd3b with SMTP id 956f58d0204a3-669411932a2mr219428d50.58.1785450446793;
        Thu, 30 Jul 2026 15:27:26 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain (76-204-101-112.lightspeed.tukrga.sbcglobal.net. [76.204.101.112])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c6e9bbcsm2182227d50.2.2026.07.30.15.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:27:26 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: hverkuil+cisco@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	kees@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH v2] media: v4l2-event: limit number of event subscriptions per file handle
Date: Thu, 30 Jul 2026 18:27:30 -0400
Message-ID: <20260730222730.119220-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e3a1f432-4638-4295-b55d-31e2d121f09f@kernel.org>
References: <e3a1f432-4638-4295-b55d-31e2d121f09f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sure, thanks for the review and proposing the cleaner patch!

Regards,
Cen
