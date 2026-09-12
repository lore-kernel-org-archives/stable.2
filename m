Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8436167B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228213; cv=none; b=ABQfx66Cz4UrgIxaS5ZgpPVPDaNfbYiyKsVgmBpwRTwP6yOYtJC20q3WeZ478REQ8/L8QJFNb2bUqNsXPv3PwmE6ToCLB/uUnGoPQ+Yq11CtPXGtMJsdRXHuWvTYRECdvLo4Qtqz6l8s9+iRtdUudpeNj6nUFwOAkDVvHBvbc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228213; c=relaxed/simple;
	bh=Lfsv9Jwo/NzR90UQ1GpGURPwlmgOG/eX7X5dgvB+LHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EME0KHpMESyPDoHRiwoZZHQwyt4xPj9snPCVosUe79rlU0at9bRzPPIPCQ91IvCNMGHkeB9+4ODWnW0mNpy1W6ju1Dtj9PDrjcblZpqZgNK0JLy1aXYh9SEora6hnKmig6y6alRGmbD8EtZbcVL+4mKmCb0OMG8LRuih2uyGK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBhnj4rS; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBhnj4rS"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7355e411so2219855e9.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789228211; x=1789833011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1u4A7LzZi2E3L85+KAE+JWL0cNDqMgSzTA0AyhQoIvU=;
        b=YBhnj4rSZx8eJ8tbO+qf2Gjx1IRm9opByLD7WsAgHorAAuN4uFkszYN8QMISQZ8gy3
         zF05sZQCcfIZcc0IphwM+mXSRslD6/DnnV3IJDiYPDXRjKRZmPpF7sk0BkEnZ06bWpO4
         2miMsuqVFw2Rh9seOQIFqKZv07lpdBzzKj2k0YX+r0Q5cDvCFoWS4Un9BaDE4ddKdBP4
         Ls0IdnUpQFQFeOXLK9xsWrWv6zFrEIePu4odjZcbCTqVZHnIilBDpGVrin0cOyLbpsWJ
         Ehr78G3bHyShsLDyVQASBSbXz2WzTpwgymMKp35Lg7Rd3r+cinbEiw43TkU1bwalPC9L
         DMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789228211; x=1789833011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1u4A7LzZi2E3L85+KAE+JWL0cNDqMgSzTA0AyhQoIvU=;
        b=IJWAuihAQTr4toC6J22IzsBruqhP4Q1IJXzaA7M+KjenmC9DmyW09d1VMRi9wMv7N0
         t+cdjBBjK2HCPMkaAo6FuPUq61/EROOQgqBul+LugHuy8QLFCDR6MxaSKOlMSQ//McG0
         ZkdneXnb3UkDjfqd8sITV2U/LiToP1mrQ8WCqIhwRACpss/h6KY5+bZ+OpnQ9bnEJiGB
         M4KrD18sgbb1sew2T444gPapcx6qBNmsz1S3ke5GLA/q/NqW1biuBB/7YUZHY+mPHNfl
         YW+UEILY3Ig6sFWjbOMCP5E8oe2ATF+hqRb/6Ouk8HNNmY7g5SxBgFhjfvOI5kWlqKe6
         VmmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzl4KGmRjskZHlqDEtJi0yjvN9lkuig0HR5jTiXuimalyYWeCfabvTkU736ilzEh6ix7BGkGvM=@vger.kernel.org
X-Gm-Message-State: AFuF++lcnjjRIeVx3Ah7OsbijtZbL5s5yUWfhScdEy6gSYKLiu3l5W1G
	flL6ZuJYkFFK5Iuw/mQKt7jpBoTjgCttCb7OAaeORNMToXYkM0T77H1v
X-Gm-Gg: AYBFou05ObUf/inUd4RrsQ0x7u72OgnfMqERhHT1RnwswJNr4NdrC1TzvGtBQ+IAwgo
	73SslU8bEWFfbF1J4ypg+ioB0FLP9f7iQVuuhvv9LA2dw54eI0Q5+B61owmrWoFGK7a3riJDBr2
	lWpbjWJBaNWqyqlPWPhNLvOZBNih7BdPj/tTWoEYnagC0VY6X9zAbZ24IjtgjP0d1hbTcSVOzgm
	SRlVVz5Y1zf08Rpdk/B+hV0GeVVPDN5aCOI15AQVsUVwfnew+bmEjXiqcz4QJrHAx/qR8OimlPJ
	PJyvPtCPfQjt3DG++eWSwl8fTrXYpyoyVgZxV/E/1Psoa4v3EEqZ5EqApi9Nd7CRXwdTPJaHvFY
	jrmXqbxEd6CpOdO9dUIt5nyQHSNy9RImdtkLCcdxLQtrgtUyCRSrN2JZayGH04v20yDaEVb8f+5
	i2cB8zyn1PV+D8asiiJfB2v9ecgwW39JbKqOCIQ369JBi4uH45BLz4fthBNVAVR0bLvygF7ckLP
	wflnNvGcGfN82gAoaVIkU6VhudzGjX0MbHDNbrBjOQz06i6+yNfR5KYmZnurcwY/eyoLmV9aQKe
	pqtindlQhmDkV3bfdCjzrFNNzWF9vvqqnhcleJFFndY+KByin4rwWEPzp8vXTM4rxTylqRVlnnP
	BNg==
X-Received: by 2002:a05:600c:c178:b0:49c:f512:2361 with SMTP id 5b1f17b1804b1-49e61a15c31mr205481115e9.14.1789228210445;
        Sat, 12 Sep 2026 08:50:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fd3bsm13682386f8f.19.2026.09.12.08.50.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 08:50:10 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: patches@lists.linux.dev,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
	"Russell King" <rmk+kernel@armlinux.org.uk>,
	"Sasha Levin" <sashal@kernel.org>
Subject: Re: [PATCH 7.2 1107/1815] ARM: 9483/1: select HAVE_POSIX_CPU_TIMERS_TASK_WORK
Date: Sat, 12 Sep 2026 17:50:03 +0200
Message-Id: <20260912155003.96209-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <d6e2ea6a-0297-41ec-bdbd-ae06b5e2f952@app.fastmail.com>
References: <20260912065648.999753832@linuxfoundation.org> <20260912065715.005565892@linuxfoundation.org> <d6e2ea6a-0297-41ec-bdbd-ae06b5e2f952@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Sep 12, 2026, at 12:50, Arnd Bergmann wrote:
> Are you backporting the RT enablement as well? That may need additional
> patches, while without RT support, this patch is not needed.

RT on arm32 is already in 7.2. It went in with 7.1:

  c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")   v7.1-rc1

So a 7.2 kernel can be built with PREEMPT_RT as it is, and nothing else
needs to come along with this patch.

I have tested this rc1 series on arm32 with PREEMPT_RT in QEMU and RT
works correctly. cyclictest, signaltest, pi_stress and the posix_timers
selftest all pass.

One thing worth knowing: the symbol this selects is not RT only. Non-RT
arm kernels also get CPU timer expiry moved out of the timer interrupt
into task context. That is how x86, arm64, riscv, loongarch and s390 have
worked for years, arm was just the last one without it.

Karl
