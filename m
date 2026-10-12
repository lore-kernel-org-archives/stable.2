Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4AA4534BB
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794564; cv=none; b=Jaj8ayDeSV+dQKOv180KNqGEjl3qFDJ6idveMk/6G6YVgfakUmzdmgIoQ+Icdd+8V6B7058u6wtwJeQZJaA2k7hURGyPM7NOebR5TIQ0YEQB8P3vAM52eVOwEQWmeNjm9Ad1T1blXR8uZmqgcthr4dkt91UvGqz7Ep/NTIBsF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794564; c=relaxed/simple;
	bh=AaxiIHkgLD4ulKUYLI2V7jffRjIqGmFrLAV4aTnpvCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEQlqUk2pR51z/viALd96hvnusx07772ZfrAls7Q3GBC4vOSk+DpuwkRxIRh1hLQPi7CW7oH/+Rp6UjsL0AHSTadh0mIWm+C46uePkFK9ONYBae+pZvOSdRcBCjNWkZEgSn3SQ6+JRwgGMReeL4nK5JCCn7d4/buUfztS9to5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=XxPrzklF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="XxPrzklF"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a8adb68d8bso1086567a91.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791794561; x=1792399361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMj0ZDjWQZhfS34YQOf6RUS2CPztBt6uEwu8EUdNqqU=;
        b=XxPrzklFgCfxJ0icsOck0/YeI3vC5a/MjtrVKqB25Ylm2MaobbQFurVvlEtZI50Det
         2IbOcwlL+p8/FMdhmlHJpU6kiufdk9dkI/q93PhkOu2Cp3Y5I5dANkcwfmBek0ofRdty
         zjV69LDvJZWf/oPBqRfx2xmCBLSUmOYSSUKnnhtbVJy2r9EIySoXpmfopr7P70qNYA7J
         pk6LzZI05XLCvIOAB36v7reh0dfN6LewH6vDkYLF2QEqbIY+/Ns83xQaKak9zCjXXBe7
         2xIU4U1hnjC2j7IkRCO3yS/4AfXP3vMQ0kKKuDJE79lYJK3V+DZaeHdp4KTuqxBy+TOg
         tB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791794561; x=1792399361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pMj0ZDjWQZhfS34YQOf6RUS2CPztBt6uEwu8EUdNqqU=;
        b=OfXqKF/VIbCRLtvegEOXWNFimL/ss5NYAri9py0AyI2L0+Uxjt1dHR4vaGK7AN6hWe
         kkzQNNgmcn7ZIYZeayv5NaCD1ul43/vWeWusprjLtUrxzggq+CTctJY+AgiMUIpqetdl
         UAq5+0KKN/Fpnt2+KhD6cR2A5kIWtQXf0wkABn64eL8lLy+Ub5qvEJb6xEnZzjk619CJ
         lUENV5uijuds6Vi3QKhX8sf0mrUL8AB2ptERkVmuG8OQmePW/t4WLT0ARL9D02tRMQD3
         UM/oJe7kNcNIy8Rg0F7+acGxEs3RnrzbTqyu60po6Wt4mQ/dDGl0uPf9ONkbtiiYc3pq
         AKIA==
X-Forwarded-Encrypted: i=1; AKwUvBzY4AnA5aZSCvXtJj/TNfLpFPZtG4U0AEancuMgLn54/agP313LtH/jevVkjY0sRshhxXRxsh8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJViDA78pCelUJJZfdrwn4hsgFPlonpquZB+BRvOKozwj5qlsjn
	QWMW49IB0ZKKs9KvjNMUBQV52zMLiM8JldUdmyrCJQr7K9AkIYU5W6zJ3Ff8OVwJ6Og=
X-Gm-Gg: AYBFou0HGKTLEk/6mmrs6LqKuPQvl0s9um8P89Ydzw4EfaG2ciSJ0rWr/qtpK2fE72S
	gTEeJVh+RBCgCgGp9/mjw8d5Uo7AKgvWWvIhQ6ev847wLTTbKaCsBaLkWhpRWZv6idCws3xRxLo
	N2WYmVXWJXQDy6DapQT2wZ3a2ihA20IQNpl0ZA4rRM9acbzf3CS800W3SOvKjKIsvXn32IbDYOA
	WXg4RKU/pm6rhvBZmZJWtnywUf3vKL8eQuXLzUMaO0Wks5WS7dd5M7cm87O7QauEVSAz/Vpyk0J
	YP/6QCoZO63PzZN/Ak3YsTI2j0uLYy/dD1EpY/fwVFakk+sYmHai9jhqj5j4FAbwEyM5I+5veat
	6ETQHz4/ogW9PueWZ74AGdB0qSit7J//M03dM9rcS0QCbYL7BL0KRgQMQ62ozDw7lVqkM1TewOg
	Qx4poI7pOr1lFzLR6QWWMDj3WjS18Cc0RJO+WaSjcrvpMOO1MnkAMVnEaFaI4u0XbzPu6b7RdgW
	n8K9w==
X-Received: by 2002:a17:90b:5886:b0:3ab:be66:ddc8 with SMTP id 98e67ed59e1d1-3abbe66dfdfmr3137834a91.14.1791794561283;
        Mon, 12 Oct 2026 01:42:41 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ca0033sm15363658a91.2.2026.10.12.01.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:42:40 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net v3 1/5] eth: fbnic: only act on Rx completions naming a posted buffer
Date: Mon, 12 Oct 2026 17:42:21 +0900
Message-ID: <20261012084221.2285031-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <40b3432d-b597-423f-9279-ab4aa1157f44@gmail.com>
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr> <25ce85c9821fba5d94932b36b9c9afb9a2fbd12a.1791775409.git.yhlee@isslab.korea.ac.kr> <40b3432d-b597-423f-9279-ab4aa1157f44@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for looking at these, and for the detailed reasoning.

You're right that the buffer IDs, offsets and lengths are values the
driver itself programs and the device echoes back, and that a healthy
device honours the headroom and placement the driver configures.  The
series treated the device as untrusted, which is not the model fbnic
uses; a completion that disagrees with what software posted points at a
software/hardware state bug these checks would hide rather than fix.
I'll drop patches 1-3.

For patch 4 I missed that Daniel already fixed the same reference leak in
1c85ea5df86b ("eth: fbnic: put back netmem reference when
xdp_buff_add_frag() fails"); please drop it as well.

Sorry for the noise.
