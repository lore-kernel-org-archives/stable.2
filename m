Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459168;
	b=VUI90SekCXhhg1huKcIb7TJVJ8Gen4Wh9AOYabUAuulxLvcoweB4iVYr1VoxyNvslwU4
	 f/YsfOp/PosFEQbrp00/51SM+q1pKK3yWssiFggzZOq3X5Pld/A9g6emD8oYb6uJ7jsHZ
	 9lYh/1ngCGb65/3Mh0wEi+4h7GJX7lP5UijB85ns8yvRd2Fs9g83UVRopmQJSPPbaU6FW
	 z9GeYx9mkE8IfzO9hWLLXFQAswLKWYiVlTqxqlA+6B9Xg41SCxB9LHohYJ7Z4Zc/75ad7
	 dwp15wIVBVJBmeOPEy4MVztedB8N21hCfkyjzu/oo88fq7aEl1vTVi5ZSUukH0/4NzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OLCqWlTLv5zUj1BUTyM/Ud/mFd3BD01LgxIiWW/VVWs=;
	b=o0wtJGwWwhwnKp1TqRYm29/7Au8GE0NL5/pQ+FcUlJ4YbBss0dVML9JfzGeT8drVbJII
	 576dmVfZjopSmOVLtG/5b6od6XWenU/U6T9DQ4h3tT12nv96VbKMCuCwL42Eqwv6HkUcc
	 i1WszCP62aCHMjkW5nc4wn36GNAiOS2QJNT3EEDfIlMt2slmc1Z1F6CYkzfX2K/M8H+nS
	 9clLWK0oFwpj/uvpG47KqlcFyCtnKaEekcYfO8+bx3jSdCwvNbENvhf2iubYdPkoEjsoj
	 Cfd+UPxjrPfP3u4p8moKWI0hwXoj56ylup6DOjv98M43UJEYJR4GOQSG/9HW41apoMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cgYkWS91;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E1606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 278E1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cgYkWS91
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1aefd1bf74aso408413c88.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459167; x=1795063967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLCqWlTLv5zUj1BUTyM/Ud/mFd3BD01LgxIiWW/VVWs=;
        b=cgYkWS91Ht9ZcjTwpuDEo2DfmxVNaqoN9+94ev+m6sCB5GbCKRqt/Sid8ohUVtxNP9
         sjTVmiz0Ot+4k485OrG6OYVAOX/xnJ1tfB3DBfq3uRPHie+p+A3WxF25odHiZOUANGT9
         J6s6l8X05k2iHsXWGhjJD9VbiImPAT2ozJec4r4xulPvoDE88MQ6odjhWhh37p7e1gQL
         +6STwwAaMemdRYhxFqbmpZ1Xi35D9bWKDq3z1WRlUdUXu2+pFVCOZIuVLXIImdvqqEH+
         ikN9+Q9hRL5ztxidmI2VCBgue4Bs/EiUkuOn7x/jEVJ/kz5yrgoN3BAU3UWvpSUoDk9V
         n1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459167; x=1795063967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLCqWlTLv5zUj1BUTyM/Ud/mFd3BD01LgxIiWW/VVWs=;
        b=orfsUgqIQlmbusFkIlkB6iCKuo8KkUXt7+grD/Mfr/ZrIlvW2IjnjJs+qKE1WzZNLP
         bjVwu4gQEGY9xevwihK6Y9spooJauyFA8mU6feHkdc6KypKHsYDT14czDxV2L9qTNtae
         ufjpIHhJYPwX4K4k3C91t2vzYNLJGxrvbupCwFQMvAoPXmkdtqoUBBLL5vjz8+wsGT66
         6AWa7NVSsBifIgh7HC8L47pxp0yupvFOv7v2cpjidZ2J84kbI53kyXaBcTeXRPpZo0o9
         yG/1mbcgyd7I4gYndHxrmu/HizQHBLe+9atXBaNbg9zMgmnl4dYkMbp1pLONaw5qZyly
         5AFw==
X-Forwarded-Encrypted: i=1; AL+hErHJGKi3x2EEcRsY43poTpIXBdL9P6y++OCgaFY+Z7agp/cx9rQ1sP2BE0y/1yEwU5/tpkEc94k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6WkWMmi5U0mZq/AuPtIlEHYWc8a5eBA34CeNL9Ks2FnQK4UO0
	4NE2hfNmGCOZsFSSpPU0uoPWEoeCNMUZXDoHvvPhzp9Pyh2aJFMBwgeJ
X-Gm-Gg: AYBFou22oL8DZc5T71RzrvXemPHrh91jVRxqLuH+haA+gcH+5SJ/qFXwM7Ei3GEQ00N
	T9pKqFKiLhb/nInySnZhfco/dUtvzahwqT3WP3wLrScjoW+fAroLAwQus98O5GdiGV2PEdi21t7
	ymbFQLmGqixoYhZ5GDclfwLusJR5ipzyJNAKswGau5Vr+N+ii+koqcsx7Hd1aoJ/Gwj9Q/y5M0r
	Z2dhoLygoG/LlIQUzVkt+4UY5X6rDTW7V58np4SpFvkWrhiEWWI4/n+M1XwZ7PtZcuLUUHWQhRn
	QtmvHLVJr5bblNTZhV7JnIQ19qEIPU+q0twFyv+2B6Ow6cjvJpz2FT7YuI5AGWSB4Vq5EPdEwCz
	6GJh4W/AefZ+Ez9aqiGkqlITQ6jgbRfjT0BYKAxSyXC2fRjouQSQGvB/bW2aYlX91hY8aoMiQEJ
	sdyPy5eVqalXBT3n+1tQ0aPPwlQudgFDKu9MedcDkgdrvCx9R7i4SlV2Mqoqn/2IqGOkaC8uZGM
	Wzj2NXAXh3dxfW11pueGnXD7uiBI0QbRVUm82HlnZ18QZIf9qr2KavQXhpdjcl3uPEKYBBgOH91
	to/Emf138RACAwhxVzoo88ZtVRiV5fCyrIXGvmC8RThArWTEynmQEeUoR7IDGccTaa0iMyauQ/k
	2q8UdPOQh0unIFeFtsDlMsx/7R/JsQXPMNgGDc7vhPbVKrA==
X-Received: by 2002:a05:701b:2313:b0:1b3:a8ee:a0e5 with SMTP id a92af1059eb24-1b4f5e7503bmr1295818c88.2.1794459166892;
        Wed, 11 Nov 2026 20:52:46 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:5d51:6f:e2db:335d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b48a9c34c9sm5378660c88.4.2026.11.11.20.52.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:52:46 -0800 (PST)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Subject: Re: [PATCH] ksmbd: fix out-of-bounds read in expired-session LOCK check
Date: Thu, 12 Nov 2026 11:52:38 +0700
Message-ID: <20261112045238.4688-1-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <MESSAGE-ID>
References: <MESSAGE-ID>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On top of linux-next 20261105 with the four newer ksmbd-for-next commits
up to a4277e7b7682, under KASAN, with session expiry forced by a
test-only hook as in your notes. With well-formed requests on an expired
session, before and after the patch:

- an unlock succeeds and releases the range; another client can then
  lock it
- a new lock, and a request that unlocks one range and locks another,
  both return STATUS_NETWORK_SESSION_EXPIRED and change nothing
- a compound of an unlock and a lock returns STATUS_SUCCESS and
  STATUS_NETWORK_SESSION_EXPIRED
- READ is refused; CLOSE and LOGOFF succeed

These results are the same with and without the patch, with no KASAN
reports.
I did not test the malformed request itself.

One difference, for the better: a LOCK with a bad signature on an
expired session now goes through the signature check in
__process_request(), so it gets an unsigned STATUS_ACCESS_DENIED instead
of a STATUS_NETWORK_SESSION_EXPIRED signed with the session's key. Patch
5/8 of my v5 signing series fixes the same thing for the other commands;
the two patches do not overlap.

Tested-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
