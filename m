Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F84FDE58
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793670; cv=none; b=gg66kL8uYAoHMOjU3ycJKXvbwTCk2tKy6HqRGilctj1iRWn17+vRP2YIfXdOfcTSsT3cGZgR0JMlZu9CN6FZqVmURiVPZ58qkvIhv6dESys2vtCnIL4onRYj71xZjcxGaBJLbp2+s6frAMQJhK6VUMo03Ea3pTvA4RpUBYm2bnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793670; c=relaxed/simple;
	bh=JScLvDY1v4ZXDmdRrVKEysuuyxpgWjgoIm5gZeod+cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4GZJXe/fwWCImEnHhxapOO4/fS9CepsPQfpIsjaH39smYF+srWmVWIaywjyIGJWZ0SrOYy3gJvaZuYfHMqhRhJsjXY5VEP1ay/TuKlFCPEUV3CE0D7FVnjHijvNlBwlS4IYPJwVGndZIRh+DbDFkzvxawaa1RBiArQFQJLxYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9OhDCXA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9OhDCXA"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2531f453eeso493967966b.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788793667; x=1789398467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtaQqVSlZuFX18DeVPVqwMKwClza0Yn6Bnu05r8m2bg=;
        b=B9OhDCXAurNMkPXOw05CEdk2J6KNAWmlimpDn6VWpyokBfT/RNo4OBIW5XU0PQhmaP
         WbeHfDPrW4w42+5/RjnXMKAx+mJZQotxLC6zer9bDVmHNOOV7NMrKtcjNcSljx1JYMMT
         y2LCaLTZFmRQEwYyW54mJyYeKZ5ke8cqm08mhyCdXqh0kC0rWSpWzyXhUQ92+rtzDlXy
         PGUssRQR4Vz9BbEmCi6aGLepYeYm/Y10hYEpsTqiJ/x0g9omzXJ6KgAlkpwEeeozk3pv
         XLUiCNxG+tse14Ls+wU3Y+9UBXLAx57bZ6fhnD6ejK/OmTvz9FaDuZS1mWauray9et/z
         ++Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793667; x=1789398467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PtaQqVSlZuFX18DeVPVqwMKwClza0Yn6Bnu05r8m2bg=;
        b=KP6lWhaqV4i5/vBxFn4Yn01QQrC61qCdA8THAQ3YLenFSwjiT29QlDZL5eCxUoj9Rm
         FodOF+LvdO6sPnTpt4aRn4qXGmLOGYoOUcdwt1nX6hNap4HucWJBT8a95t/5MeahhQOB
         eGukF61XLoBRiwGzQeEIzSCMLgeQgItwkXE2iM/DdAKALspMdkMel7RYoXBIjKYGtbW1
         qRNL7v0os7y3q4oVS6FkKYCRotQfwOaGH1q7GX/s3mMX7rTtQxwkGzYkGPAtsenad24y
         BtSxBhAURsNHY74KXCa9DciYBwHsOeuCP/VN8CKZbPJ/0xPf7yfVnOjpz26P/aURRVr2
         0J9g==
X-Forwarded-Encrypted: i=1; AKwUvBwh4znBAZdaftHaJOVns1L2z7WjYTb959YPOw9a27n7DKiCbqBLT0R5ggO4lCHpR+k32A8aIus=@vger.kernel.org
X-Gm-Message-State: AFuF++kE+tLDLT09rFZ14ous8lMsECVrn/KweOMW+pQdOOGThqK2wRrN
	+L7t5yl7tLzAodWO6KkDeId94gv/qVp24ZHOBP9bDNx2/8RqgmdMJAvf
X-Gm-Gg: AYBFou1u04uzRTaUDVaRqO3mCFU1MfRIMoTWuw63EY8NSUJy5qDjnlU6AiM2YbO4nA9
	qjRLsaD2pqEK5LXp/CMWzDg/a+RQw5J8W7UduSvrBTnS5ODG3g2GKtaZ/gY/gD3sGm1Zc1UI+iv
	FHRW8dEdAlT1zWylUlkq/tAkhKtpDEPkwB/kommz8kOQZeR5QF/TChTMTdougcvyF01UPttN5Do
	BIyMECd+cAUYhvKNav3KXGLOhqzced19R3gIxHBTsR3iNIGWKC0u9FhXI8Z+YuNYnUYg6sbZ17T
	SbF7MOsAwbwqvIj55yqrdUY5dvCP67ODzWHvpl1bZCcXol893GjfWjEod6yNpQ1mBT8FYrGZpVi
	JR/MEjIyApTd+RmY6zBZBXfnbdXJk6TPMfGsrQMkwkqx61EO7wiedQ+DqxDl1XOUIaBQSUKR4Yo
	lwos5XguxB6P+CoiINTVEeEIq9fOnNiVILeybLzE5tYy2DiM/3bOfeY0pSAEAzUODVwJnpyPs=
X-Received: by 2002:a17:907:94c7:b0:c15:e8c8:340 with SMTP id a640c23a62f3a-c260cb54a27mr1562947866b.23.1788793666838;
        Mon, 07 Sep 2026 08:07:46 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5773c5sm478376566b.40.2026.09.07.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:07:45 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: sashal@kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alexevgmart@gmail.com,
	karolherbst@gmail.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	nouveau@lists.freedesktop.org,
	ppaalanen@gmail.com,
	rostedt@goodmis.org,
	tglx@linutronix.de
Subject: [PATCH v2 5.10 0/2] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Mon,  7 Sep 2026 18:07:24 +0300
Message-ID: <20260907150726.168416-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903-daily-reply-0001-re-mmiotrace-null-check-5.10@kernel.org>
References: <20260903-daily-reply-0001-re-mmiotrace-null-check-5.10@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport fix for CVE-2026-80689.

Masami Hiramatsu (Google) (1):
  tracing/mmiotrace: Add NULL check for mmio_trace_array in logging
    functions

Steven Rostedt (1):
  tracing/mmiotrace: Remove reference to unused per CPU data pointer

 kernel/trace/trace_mmiotrace.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.43.0

