Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF3384CDA
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791047721; cv=none; b=A95Fa1QFzCrGGbrpWGDEJYzgbm1Q7xcqwLge+kypH8lp+FPauv6/3vHew+Or2pGSFvUJeQoY3ypwHtoixo/R5CQlM3qhiMPg0/EHnnRW1msIA00FXtzAQXVXyWcwcs8OLPLVsh1cQn5JCBzkxo66pcwSC3rFvjDObBLMIu0DisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791047721; c=relaxed/simple;
	bh=AXUMRRZoPMPFxEpSNvNWVsESjh1oYmMGz3UfImx+sQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr2NtPojpP1UZDDDV/RcdH0QFQdDWr1ljpt9r5riXMeAtgYgluWa6dCU/BGDSSMnGyiYR/ePdNyoltNvEMmTwMFY88ef3jfwZHdJEjKm99j1wTRp5xS+o84SbMAlKt1z9Ph75LloZfO7Z+I+JPj2I0oxUV55l/FLwjmLoAXgEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWFRMzj3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWFRMzj3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a49623b865so220224a91.0
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791047720; x=1791652520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uKKIWNoUfZgNMr9RhsbAI6Qq26Nyd/284yBj3K33Njw=;
        b=pWFRMzj3DWEAhma5JXm6sQzQQ55z2JF/fAqT0Bh8deSMembyo08yQGZq3pGIyKLP4D
         TyWK+yGPTTKEuziYPxiV0GkZuB9stn5JX5dOJmqmDZChoUi8RL6bw8NPZwaN9lwwtiCA
         04NnuoHKe4PcG6AaruHzCIm10/1pArUZXEr3zynZI+kfBtnhYVL+d9nwyACyWgpZNK33
         bQLmCuhxaQa5UNyttrrCdrtCKRPr/+790TYOxZtqQHE9oI5wgViLOKePMuytK0Yh7T8a
         ShnE3VOg0Yfsmty728vnPkI6EUlxhPf/GK4kvPYNsd2UUbAe4WaV/OdEc0XWu5bzsGJh
         rM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791047720; x=1791652520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uKKIWNoUfZgNMr9RhsbAI6Qq26Nyd/284yBj3K33Njw=;
        b=w2kxshcl2suq/Ph7SJURJ86hhVtZ3DSpvoVUS2Rqxcid8EHSwLQElCj8Y05EkCqNWT
         7YtvOIxbbqpR2tUhbPnjY5QTPbWHZsuS0MotVRbjSHFOQSY/iiLOBKJT8Dh0CoP7QC2m
         8sxmuGpFY4BM9YQUEnMqdtUuGp+x0Z6OoEm+QoSSpiVe0FAto/hfJz4tQ+Fn3E80A8gW
         3nOCUoq64b0Bl4FUTSYD5JNO8VO/Y21QWxqNplCSK2fYZRvtKQ3xA9id5N6feATIbbaR
         O+wOtw9XwZ0WXimUjw6Gw69yNtr1hMQuWLktz7fX+rleu1yUq2Jk6veVDTaQgizGi3fR
         OAYw==
X-Forwarded-Encrypted: i=1; AKwUvByJnOHAQGDZrk27X6BnUNLXgNg7rM4buh208BUdDUL1IH8yd/WmRUpTaOaujmwBZiZ2gpfChy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL70FF+fHxvMt/yDiy7h5JSaE4qDTLLWP1mMhZDGzSR3kez+aBi
	qzpDqiU4DkvE1JOloLwrxhtQsZ29K9L5Q2wh5RHQX+10QtRizSSoueH4yH3SuqtAzW4=
X-Gm-Gg: AYBFou3N4BuoRihuEyhrHs+0RwfxoSC4PlW6r0wIG8uYMjarEPP/73L2euN7ie8ePsO
	acsHe27PECbB9Ky3x3V5iGRyYxkwY0FiTvWJlhZtSjUPp61WxJGW/oyr2+LDUHIHbp/978Xg/cV
	oNF0LuxRDPdZrhW63L0QthqGyUZ5x3Wi/8fisSiRLIIKXZUz9PQ3kyfiYS3jgkRbGEJAQZV0ur4
	7lgmz5LoKMa2kpch26qC22yeWXth31TUVREGLlaAqPwcCpvr8ryJD9udSqVvh7DGUT75qZxeSuy
	4G9UlOxbwwPkwXeg/xnq/E0+efvnJSuDvnjLX3jYq5Tq9lHsdowatatr+7vqHeinN56y/Ah+Lvu
	RulVDYT4xxxjD+qbVDQPr5O+AmCS0AebBsL+7jduq/1CVbMrcyHh6KbPKFbIPH/1Q15+kqSpQ2r
	lnQKl6fJ7k6GSaGihjsdZFhbcr6PAnstt8vIDumbfb2mq0ZNnoCHU7f+KT8kRNMH66NZibvh7iY
	BkQcZK9M1XRTEe5jKlTaIzn830TRFone3RvNdA5uGWyUISsmveY
X-Received: by 2002:a17:90b:3ec1:b0:39e:6a81:f34b with SMTP id 98e67ed59e1d1-3a7873dc91amr2356347a91.37.1791047719604;
        Sat, 03 Oct 2026 10:15:19 -0700 (PDT)
Received: from casta ([2401:d800:1f1:cd06:9f1f:eeb6:21ad:cee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d4a5150sm3587419a91.1.2026.10.03.10.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:15:18 -0700 (PDT)
From: Nguyen Duy Nhat Anh <neganhat@gmail.com>
To: adrianox@gmail.com
Cc: code@tyhicks.com,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
Subject: Re: ecryptfs: validate auth tok payload size
Date: Sun,  4 Oct 2026 00:13:52 +0700
Message-ID: <20261003171352.10244-1-neganhat@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001213915.1326602-1-adrianox@gmail.com>
References: <20261001213915.1326602-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Adriano,

I noticed this patch touches the exact same lines as a bug fix I submitted 
earlier for ecryptfs (the ecryptfs_get_key_payload_data fix):
https://lore.kernel.org/all/20260917044558.41677-1-neganhat@gmail.com/T/

Since your patch expands on this area, could you please add my 
Co-developed-by or Reported-by tag to this series?

Thanks,
Anh
