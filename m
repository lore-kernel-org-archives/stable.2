Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388D5372E6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906786; cv=none; b=cXnIv00JnLQO19tji/tUznUeMbYwtjw1WqRRP9pU7Py08UOBuWAKk8/dwSypImcFnVjsQD/bjHKvh1L1sITLbqkeccSI1xeI3YPPP5tNYC79njB1HUc8CgPxiZx85/qirnhk9zdDAt0+XY/ItYTH02AVSJyzR3TG69cjGiT53fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906786; c=relaxed/simple;
	bh=qOMnAQshZi5I2yY9rgOyo/tDqeNoazX7meSK44gFpfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5AP9g/FYoMFwesRhs2YCBn6Z2vOzcx9B0RcqgrdcB30hHLqX1NS05UvDC49ipu3sAG/qgcnPGDq4L40ItXJ7o8vMrk4wU3BwEVPmQgxZwJ5cPPfJqIixzQ42DFJHb4n+7+OYLJsVqENCQaiLZ63MQbsW5sncsz1iTkMt35y+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=apNgJkD0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="apNgJkD0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1915864a91.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791906784; x=1792511584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlJ72bvKXAZMaGRlcugIP3h82wTWg8aaVMxMBFjQrAs=;
        b=apNgJkD00Rwd/fWzRGdzIRiHFuDx00OqweM/VVm/BXrJDhuZaV8HFF4EUfhKtyFKdy
         jywTjAm9BbhrSq/0/uqw4lFGe+fV8f/3BZtCWPvT6IcZRgANll+LBqhstBQx2BZ1D7c8
         b7Jr+7B9I5rxYTwckyMYkc47hbf/p955tL2wSKP2LTs2753wn1n0ONKCnM4HmFaVRwFX
         UiI+McEUQZt2lpUItFO9oYLCw8eLyqwMDjihSr8xKM6YaKs6Zo6QFjkSFdComOYV7dyM
         RnyA9sji5aMS8/7TG1cgMGRQDY5kRiwPcbvfUHqEkiY11J8McPGww3DYFh8PV1xr5ob1
         Zz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906784; x=1792511584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlJ72bvKXAZMaGRlcugIP3h82wTWg8aaVMxMBFjQrAs=;
        b=spG3HtNmAkQegmItdbCgmLxRAL8sHfwne/WJavIREd47Xzu0Lzt8p2groNvZAxVMB8
         uTBMwow18w6fHuTKMKrysY7BjO1kkGgzg5KTJ5v5UEhpe/ItBZqher8sk2FA0pY0YTG/
         163M1NaInDgFPUb5kpfsBSLCsSKngGsrMLdlzPIbCfEncoLWYY5zJ4070cEW/wb1kb/2
         doJQVK0vXBHyLprHIpqpX1MQ9Dalt4Hqe7Lran+XqXsSlkuU9oZyKYVCPW0QlJuBMH8u
         Y0EraBhOnDzb4zKSQ49je+yj609KZBIn5gAuqddFjxegq9BafOW2hwQE6duumvz+Pqlr
         hKuA==
X-Forwarded-Encrypted: i=1; AKwUvBxzfOLYsXLO6dgvlmkQ3QKs4To9ZgNt5NihalK7NFhWSEcWQKSoxXZDIhozxK8nTlvpK57ieEY=@vger.kernel.org
X-Gm-Message-State: AFq9FYITl9w538riEvOimfm6/D2kksM2IoFnHpCQVWn3cpdsp92HAMFr
	EB7vjghJRDjcfYfHiJZkUALSz/JhcS4+9ly4L3q+aPf8QucpBc3JN0ourvCEoP0z6tQ=
X-Gm-Gg: AYBFou0Ic61m2lfAwFUnAjy/0Rq6VjssRPQBKOUdFhqH3B5hvA4xPKdiQXrYba5rUvE
	xgmSQupsYbJ7MKw9u6xofhbhWRLGCJFXwDC4Tru0cudkwlFERZje2STIxJfyDbEcNtvrZGurSWB
	ehIuZ5aqqdFdg6uRdEgu8gp0yU7JOdbpUMNK2MjcYmpW4D8GIeX+wzSy2KebP7COaNrGVzG2h9v
	8K3he6QdDXJbp/J5tH4TPiHA5HizCV+k0r+yjc1d1aWWt0Gwnz4GSYJW3HOoCWs9+SBUVnGml9y
	XIhXwYFu89fHMZhN1NE62vtG3YXEep4rZ71H88tyElRPo0RV1Nzdlzqnso4GX8hQTGdhwYhljKB
	EwKqPn3ObTT8t5KCoY/XG+f2TOwuScEATDFl2XckWnIqOk+Y4WM+OV6s6/mRdQTBoWrX33+EcGG
	00mZPPHVuYz4v3hVzDNBOgkbF3siK9X3Pg6gY0hL5WUHtQBk9IR3qaD4vcW5nvzMnbt9IaZwrSx
	G4txcW1WfzjLS4tQ3az
X-Received: by 2002:a17:90b:2ccb:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3ab3afcdc6emr11228102a91.52.1791906784181;
        Tue, 13 Oct 2026 08:53:04 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f27d491sm165944a91.12.2026.10.13.08.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:53:02 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	gliuxen@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v4] nvme: bound FDP config log reads to the received buffer
Date: Wed, 14 Oct 2026 00:52:36 +0900
Message-ID: <20261013155236.3188723-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013142003.GA14422@lst.de>
References: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr> <20261013142003.GA14422@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, all.  No objection to trimming the KASAN trace down to a few
frames in the commit log if a shorter one reads better -- please feel
free to cut it down.
