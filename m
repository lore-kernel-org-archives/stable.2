Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB823C276D
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327577; cv=none; b=sjYQT5Dw+XrHUBrbyrDvxOB4bVNHs1wUTDAornCSRmgMgKZGpWvZaefvExQWsjHQZ7L4y7UV53s5HsjKH7V7ZtlWTA1/AFj9ILfT9/T42tIH5cHc1UGP3L9/wpU+5eWQFyTVE0CLBBAJCgXZpb+2ZV601cyxJQuLX80QGvt6vAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327577; c=relaxed/simple;
	bh=jrspKrSHaAFQmRBzEI+lMfU9C6MRcN7DzFgzkR2aG3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfQf9UJZa2ghCn8f+tI1PkYkTYu1y3sjiK4sQy2TYEM195RUKwcwP8BJ0bPehcYl6G755H1Z4fSefUmeTH+ABYilwOca4V5VJbBFfbAzGadln/bLo/t6VXS91RI3PVKHqsGnc+jA2MPZTO3tyAGGXoswaKFg6oHbPt5G9jnN7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOBDYAOt; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOBDYAOt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so5482515e9.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789327574; x=1789932374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrspKrSHaAFQmRBzEI+lMfU9C6MRcN7DzFgzkR2aG3Q=;
        b=mOBDYAOtUs0vRTEZ2bSFR9LzdLC9d1h3olaH0e74Hlno/7EvYsHVDdoVbmtB4xTARn
         EArneG40x25P0WmBuAsNYhHi3mO7A76dpYUyCW9YS0JJ27c6vLXEai/kx7ibeonjmIo/
         W7Xv0/vd6xuG06TPTalWpIpY+RMoXQV0vESpL0nhF9MTWWIrLo6Y++aAuy74OkjMj06J
         OGAopmhHMji3QA20dX/9HJUPb4oxVSeB73N3GWngd0FPeIfilf92uWr/a0EuiFBeK/P2
         3gZ8HL+5ojZmLfgHIty4XTSFSRYBjI6Fot5XJMqS3kUbQQGdvG/rNP1RdL+A1Iyy7pfu
         N11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327574; x=1789932374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrspKrSHaAFQmRBzEI+lMfU9C6MRcN7DzFgzkR2aG3Q=;
        b=TTXCBiHorRXjM/4aaT2fv7HYBww59Pkt252y07PikZ4vvgyO7LSO1skC+6J7B7JXbY
         E8iYqL/QrOzaC+pB8TzGftYmUswDbuDBRNPiPnIzmj1psuzoeriZubzOvvcOnqSXgg3M
         1pAO4E5w1/vTmF3N2p94kS9ObifyHC1KMPeM0TsbNv/Uq7mRS4LgfPOY+l8e64kkEnBp
         u0PNijD2Q2yk2M7WEUGMrFVYHcvtENCznShL8OqSNoLqOZKsM8mi0dabIaXMP+ti6Noo
         qPgEAMkHrlAgpT6JeOZqaQXNT7NFXh2pAk5EtEXgDgl1iVt7vo6J1DWGOOqnn4iP/i2g
         rKyg==
X-Forwarded-Encrypted: i=1; AKwUvBzWfIzGcqdYagHwxVZwnWIHNfJ/zInw6OOxuURHtlAVfEaD3aPqXkY2ZJIVQTytiMZkRRd9LBM=@vger.kernel.org
X-Gm-Message-State: AFuF++nvE+s2Dztv7HmTHvkEJ1GoFl/qbuc0Sl93xQVjtj2pCFgRlE13
	u/XTASyJBFoRDTXl0EQmcUjyupnocGUK+VZz3v94HA2/HyWKZUU3MvFT
X-Gm-Gg: AYBFou3ANezJetBiYaHgHDWLTkLNUQGeY6UiF2CBJzWvwr1Yrfnie9m6u3FaV51NbU/
	6q118VIRZ4LU7Aw+HEKT+cWOp8G/9WbAPK/iqbiP7z34xxbPFoxOo2SncD7dHARU22opCx2xz34
	OOziiYgL6GqpOnr8cANmQr/89iXupliZMlpCvvyktL+knGBL6of25Osvq6pzzCW746DMiIsxTNQ
	QtF4gba5M1clH/4+5uZGs9UkNjP8UvTATmeVUk3nY0/G+Zltu9Rw7L5JYz58dHYw8ktVnk8PQbN
	U/YQI8RXgubTf/znHyEbWhemy20+IFzO30lwtQMem9MceAPGbQoAw/Sjiv1pvQ2sNRLtwWHxStJ
	LonpnYXuWUoMvQVxPITXNdvYTZcCeT5WH6R4j91yYPnmbAWJB7HxR2N4OSDQFqu7kHAK4xfQP6B
	tWum6IX0gstcJQGy+VT1wSgS25+A+kuZFrWCKxv+PmbYKq49rLxHucYWpuj2+eQ985p7Q7cEC9e
	czEQdlewcCbiN2esLXbu/VsiL8T+tvyUo+gswGuPKunEyptspIcKiW3Ze58u/S4xacYkSCuo6yk
	iPlw5dRoejRk7vqe+6XVmdd1IC9Mkk63QYbcM5rey+eSjx3QccPe+ssjxtwLfS4u3PP8Ow7zjzC
	atw==
X-Received: by 2002:a05:600c:474c:b0:49c:fa21:e74a with SMTP id 5b1f17b1804b1-49e619e4e91mr144757715e9.32.1789327573903;
        Sun, 13 Sep 2026 12:26:13 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb36e4a6sm22435162f8f.37.2026.09.13.12.26.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 12:26:13 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1360/1424] net_sched: act_skbmod: use RCU in tcf_skbmod_dump()
Date: Sun, 13 Sep 2026 21:26:09 +0200
Message-Id: <20260913192609.2581-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065637.721099003@linuxfoundation.org>
References: <20260912065607.279695368@linuxfoundation.org> <20260912065637.721099003@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless a 6.6 backport of upstream commit
3016024d7514 ("net_sched: add back BH safety to tcf_lock") can also be
included.

This patch replaces spin_lock_bh() with spin_lock() in
tcf_skbmod_init(). A rate estimator can take the same lock from timer
softirq context, so the timer can interrupt action replacement while it
holds the lock and deadlock on it.

I reproduced this on 6.6.157-rc1 in QEMU with lockdep: after the estimator
timer ran, replacing an indexed skbmod action reported inconsistent softirq
locking on tcfa_lock between est_timer() and tcf_skbmod_init().

With only the skbmod hunk from 3016024d7514 applied, restoring
spin_lock_bh()/spin_unlock_bh(), the same test produced no lockdep
warning.

Thanks,
Karl
