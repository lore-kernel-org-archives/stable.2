Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12238CFE7
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335265; cv=none; b=AoQtKCYqjNxZ9vyL1ZzeDj+NY4M3W58RWCyDX53uEILeVM+ih+hNW++oaiRGmjzmTMineeLjga28Z6HGmG8G91lEfWppAfRHE9wl1hBUkfUeyAX6HyY4DpWy604YpmaWyUwaKh0DitQUigSX4BqIx32cLEMn9Ld/67HbhI88jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335265; c=relaxed/simple;
	bh=SVzMcetM1Ujko8uhq5KDuC5TeNGrM/6zHHBVgzQIpxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5a3uNBY8wVJLk0KaZBg7mD02TKu1bD0lgpCtCN+fgQFXVihcd2Xgt/eYGi9LwPdXDP7sZe60Waa+zwm7GSN9yUdnlyMGDQbRdRG9H+qCTf5+ht5Az6aQ4Rda+XMlTbJwYDi41OejuIPdbPmCnoWon+Uwe1jpCyZ5akzoRc0iM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5/nJfa7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5/nJfa7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49e6deb520eso17356395e9.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789335260; x=1789940060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVzMcetM1Ujko8uhq5KDuC5TeNGrM/6zHHBVgzQIpxg=;
        b=O5/nJfa7GVjqPFdv1Lh7cmWQOaWYBO2s9xjpMT9RYw0Tz41Lk14avy6ZkWzaUmjo1y
         obSr1esQvuzX/k5COxIvuXcIY5tf7M+RC9SATDgBpaijCRhAYXp5n39cGpKnCyosgpdJ
         kttKKHNj9XmRLY5/Go2GWwVetFGLy2ialip4TXuVVXheJ2zNkfXaamZtxE3XKZ/d2TNK
         WcwO2uRBg8/SfV9V1QDm279w6Wj9Ean1eV7gFNUz1uWvgsli8RBCCLoZzxXEAaVbB1gj
         OblM/lxAW3zRFdGshsKBHNs8h0NWo5OCS/CUDYDYxGB8IE0p+RzqoSAlpqodA+O8BrPT
         ZDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335260; x=1789940060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVzMcetM1Ujko8uhq5KDuC5TeNGrM/6zHHBVgzQIpxg=;
        b=a7QagetURvIM/TE8n4xettYPa8nUqtDrJ6tKAdEupuyRSJu/Z4Xs8smTOvrL9iZiPk
         lXGR2FE96I2g2pJ+MPL0+2EG1w3yyh3WbI9zKh/CRtRFN2ljrZ29DKJuJLyidO1rXuma
         sdOff/P/GyUJcLtRE9/K1K3/CoqC9zapFBgy13a7uxvrp4Pr6l/njk4/BAoVwjWcDr2S
         SP2G8tT6Xo9HKEhX0A5CVC6B07moedDs1dMvHpqAHsc8ymPHMMTMgrmbLzueGs2JgIAJ
         bUx7YSof82W7Mdro+lsTSNYTKJuYx1gBLLGpgJeGI6TO0G9wYDgHrnJ+hrixLBEoHRKl
         ljsg==
X-Forwarded-Encrypted: i=1; AKwUvBwf5TisZTkZ1UOOaxFPCb65Co+y4OBB+3axG/FHf8RAg9L2l7/CzmTLYPIhqTTN4YFYBipl7+M=@vger.kernel.org
X-Gm-Message-State: AFuF++lNpHls8T28bSPCvr5fhg9FE/JDzeCYa/Nz6uXvRk1eQWcxOn/G
	ZT6eGQSf2gnm8Eit4zTbP9g7hZXq41jV6pZCrjnYoo9LmLW6gAzrk881
X-Gm-Gg: AYBFou0uFzHw3625Uyoa1eqo16Pg5CYPyqSceOFPd7qo3HKl+YaON7gGUs/dLzGDyo9
	g+o75mrzA4DCZxwNtV+qzjEjgbu292qLHW+JnnGEij0YqqWigJ/rDQzwHWnJh2fECyOU/N82dqa
	XC6ffbO1/S+109lLWGQl1S+V/VZ13PiWISjfDk5p54oLAbFylgIaULGzCb17ZZDzsCYseJPX3x8
	pbo+7kT/DuNSgnOlS2IovUU/2fn9+iTtxlbTPYTZOBzJY5RESFMCnF74apCyRIGeUsrHArBHn14
	YNuMwAzkl1cgfXXOKrUc8vIawerbacnn6Y7nuBNBox3wOL9Eaci2D3aQGGyeZh0+b6zxZC3Nvt3
	slRveMC/GkwBwZPdM5C9pVdBSCcuouzYMuJzaQWN6oArTVDw3f4XwZdGqoM8Y6L5GF3mzXGYaQ4
	FrR33njoW3NEwqBdk4vIE9W/NMMNdL0NNKUGgTO1rhc9KB43h+UvhWLkDf95K7Awhx1Q6q4iB5e
	uHe/juAQWQjyvNJ3HPbdsmU2Kh5k4uh8vaQ2pdWgGoTSy4EJbgzXeaQ/ALK/eOdKc9vUU4z7J6p
	Vcd3ezy5oRYLtHFHCTEoYGIwR3Aymxakm4AhWgI/Y2IHDpmqNccWYt6L7nP89GfR3u0zkiDmtX1
	HW9aV2s/oEeAZ
X-Received: by 2002:a05:600c:1392:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49e799a8b98mr3099465e9.30.1789335260395;
        Sun, 13 Sep 2026 14:34:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e62cffaa0sm103932975e9.0.2026.09.13.14.34.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 14:34:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Ritesh Harjani <riteshh@linux.ibm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 712/798] tracing: Have TRACE_DEFINE_ENUM affect trace event types as well
Date: Sun, 13 Sep 2026 23:34:14 +0200
Message-Id: <20260913213414.5425-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065533.404747135@linuxfoundation.org>
References: <20260912065516.948645775@linuxfoundation.org> <20260912065533.404747135@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless an adapted 5.10 backport of upstream commit
795301d3c289 ("tracing: Have type enum modifications copy the strings")
can also be included.

This backport passes a pointer into the const field->type string to
eval_replace(), which writes the numeric enum value through that pointer.

I reproduced this on the exact 5.10.270-rc1 tip
f69aa74a82509ee94a2aac2822b4189496f267a8 in s390x QEMU. During normal
trace initialization, the built-in ext4_fc_stats event caused a
write-protection fault in eval_replace() before userspace started, followed
by an Oops and panic.

With an adapted 795301d3c289 applied, the same kernel booted without an
Oops and the live ext4 event format contained the expected numeric array
bound, fc_ineligible_rc[11].

Thanks,
Karl
