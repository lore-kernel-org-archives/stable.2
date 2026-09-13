Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC4367F3A
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327403; cv=none; b=ojxaGBSTmShRuEm5Rm9uiMi6at3qWN/HFPIvWWPpgI39shzGvGiA/XuZ6L7hXc49w+F3+e0l5++DaRfR+J3X4kUwJN6wXE5xoxdy/glvQtKsA9j3j5He+0MtHxDKYcHaUojVbKjleQT43bmCAAKOqiuWrsLfRql2ETOea61omIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327403; c=relaxed/simple;
	bh=cet9b/ZrUPSX83m87GOSBf1y+OWYLoqD1gBEkjB4pSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imGSfG1C96Jul4Bk8kpIRjY8thD+50tD3L4OKg69V/aMgZTNi3w1Fvf9qMXeY+ifGAsPCDQGdptdQ8pfVYHz3bgv8/KisHCu4N8DecoG3Xbe+31L0n0VeQLBqo99soNNZkzWw59tij7TYsyA6i8ZSTPxpgwqmjvQhRagg8PT7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2XAZVFd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2XAZVFd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2610291f8f.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789327400; x=1789932200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cet9b/ZrUPSX83m87GOSBf1y+OWYLoqD1gBEkjB4pSo=;
        b=O2XAZVFdCGb51k5XZ5ubQpuMTykdEsZa9jXssczSV9F9CJ0gUY0YAKQuu0ZXRr3LmF
         FNwuxrEmQoYLe38v3Cx6hWVALcv4kJk7ecewzrh4yn4+9AuAK1YpFnPGXSGhHoNlGqm+
         nuxoBOmCwto+0Y2mHaQ1Ar+tqlbbg5o9BUVL9n6RZxzdqUXxsroykkYoC8Q2c3b2rxsh
         1hh77FmIOuCH9z6rhbgkeeXchO5rTOvaER7RIhSz1u3V82X6nnAOiRiWWAl6FHKDuS8b
         iRExHclCqHlixP5ypl/9eNvbSTY6MjDHF0K+/52Z17E8OBONHUr5xy5fkT8T1zOaWvO/
         BX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327400; x=1789932200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cet9b/ZrUPSX83m87GOSBf1y+OWYLoqD1gBEkjB4pSo=;
        b=b6w3KKkzNlZUZqKHPIDG+02919l4YTkL78p79VodEeVj/48LhAhr2WH6IELwxqMua1
         854o0JVVAJfQtpi6K5k6aItpoBjNYo0U5eC7mUXaLNhSa1CW3FnVcwIoaDzI4tQ2eh0G
         Tm7OWKH3m8vL7OW/yBHWEQR9ZQAJ/5ipzIEuedXYlhRVaSQynCibEHBPFJNjfY82BRZw
         QvfLxjR8w3jPELpJz2ZVPfGMlK7C+UgMYb7QLPxe4VNp8HYUopIvVLm1Q9T2h1svrIse
         fI+BijjuO+0PIiaUB47jKWHwYGgg4N7/a/xK5kftkA2QON0QHZfViwcf3qWnQzIuwEcA
         mmXA==
X-Forwarded-Encrypted: i=1; AKwUvBwlsGEbdHGjDzAadUlmknT0iXqvQBVFI59DFePwTEZ3oEcPpF81jgEaSD7oYF9b1+rOgnwPsYg=@vger.kernel.org
X-Gm-Message-State: AFuF++maePzTjnPClPY3ipgJyx3gP/225FWfy+ESZr5JnjKYiLaSIF6X
	g76wx0gU4Go52gL5z0mN5vH40lyz6Q8oVCGov3nIiS9jmAmCRJsT7vw6Iem/Qa0R
X-Gm-Gg: AYBFou0ouW0n5bwmyf00NS7xh8qBVb7HE0KMfYE2CffDh6X99aGc3XP5mZyKszGM0Rd
	FV8A8bGSdyGdA7aK+XCBXZapAo9rEBf0HPAgk59hUeKBQhs7N6FfgFWZ3zR8mJE9Af0D4dJF4nW
	k5p+GtC26RtFoxHI+2pdC/Z1/aS6H6sG3Txbgu/9enrAxbWlwri5PI2kJ96hYQ32CEuAtYkR2N8
	tMU8PycwPQjhce7B5Flf3gbfdXKI0o4CSywBpoGeTITNl5xxnzRHFxbJLhb/mgyxQV1bgHZbZwS
	dYZNO0vvSJZ9UtihUTqI8QBzxfUCh8Ew1MDnBfJ9tOu9YwhehVHR8o0ITWiuMix3WR5+XsLbnPr
	KrlvaVUgX10k7i6NRyd4Hi7B4/u7D6iqdHVFJyOhvf/0IKhUPmlW3feorx0uF4Y+vSP79DQbTDw
	NH17LAHUjyT3H0I5r0yt1dl5qaX30n5zaOVpXqdUFsNjYsQV9M/F/6oplYDzymCAeYFxdlFztCZ
	2gHP2imatZ8QvOH/nNep1D0CCJNL9ekRyS7SgjYexFKnLGPt9TLy0WeGVdhCZtf0w0ovXr5Vf8w
	kPIkDjOJU4EW/l9DriXP8Xmo/1JoZ5t+gtfEbn4d1ju/ONRjHPUPHi+2Sl/rdYEaRheoQop3vgQ
	p5A==
X-Received: by 2002:a05:600c:3104:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49e6197f6f6mr151860895e9.3.1789327400198;
        Sun, 13 Sep 2026 12:23:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b7332asm336899905e9.0.2026.09.13.12.23.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 12:23:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 0572/1376] bpf: Sync tail_call_reachable with callee state on entry
Date: Sun, 13 Sep 2026 21:23:12 +0200
Message-Id: <20260913192312.2402-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065620.278405277@linuxfoundation.org>
References: <20260912065607.535295758@linuxfoundation.org> <20260912065620.278405277@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless a 6.12 backport of upstream commit
54c27ea6dadb ("bpf: Fix tail_call_reachable leak") can also be included.

This patch resets tail_call_reachable on callee entry, but 6.12 lacks the
parent-state restoration it relies on. Returning from a clean callee can
leave the root state incorrect and make the x86 JIT omit required tail-call
counter handling.

I reproduced this on 6.12.110-rc1 in QEMU: the unmodified kernel hit a NULL
dereference in generated JIT code at ffffffffa0000114 with CR2=0.

With the applicable 54c27ea6dadb hunk applied, the same bounded test
completed normally and stopped at 34 program entries: the initial invocation
plus the 33 permitted tail calls.

Thanks,
Karl
