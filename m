Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC382C21D9
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320522; cv=none; b=QnB+3uZRhP7uSkm9Rd6+lXfWXAsyfRIVWbRLhmRgQ0+hX6236CMlF97OK5XVci9lzARLm5VykzYFj42z39doh+dKPtrIGyWcrRwV+k6QvyDaFD3MMr59ISqGj0nUuztAOaUpnfWblWEZvfygyQOfG4uvXHxyotmN2AJsrrvjnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320522; c=relaxed/simple;
	bh=On+rz/ZmuKojokNXfYqOBOt08u5f6BSrCmw1MqxDuAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCW2bBZ5lLW7kl2pC7+RasoPxyRoAP95dvwdAyunNr6gHRuJcHVRql5M4iHbj+utSWLqCyOJWRmnrZIdxFZEnH4YT1jgJmbrh/AcNOV6Xf5ZWMySUSkciqFhVTuGOISb95Gm72wpyYs4JklOiP+i0Qz4MUOIDe4XsKjC71MHb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu+bJkXT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu+bJkXT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso9357865e9.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789320519; x=1789925319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=On+rz/ZmuKojokNXfYqOBOt08u5f6BSrCmw1MqxDuAg=;
        b=Lu+bJkXTF+qZsgFMuxbW0oiZ8hZpRtigVTc3pqaI0hyMf0AvfHc3zGWGfJsYMG5zMh
         jBnQ47sMFI51HB3XcURUAf8pvZI/Xc6qCTIy5xXUguA8J52vGSydKYPRtbnk5oK4Qam3
         cKVvuTWF9aw3ICkT9wv2s3C4A0f9vT0Lzz0wvRyy23eq+OHXf2ePZjqBZ4pkXTpJJVtm
         CWqRQVrEFDe2fiTJj0VvUsV46+WLAE0FSqs7ugus0RYiaRbm4kGoE639zw5MARX+3Azi
         Y3E/MWyxijyr7EbR9/Sa2IvQ9X2j7E4NrIZVahMyAM07fC5E6pbDxchq2CYsU4wmgFGm
         NM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789320519; x=1789925319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=On+rz/ZmuKojokNXfYqOBOt08u5f6BSrCmw1MqxDuAg=;
        b=irEZ/IyU520KK7anro82s1BMjktWGsfGBUWdq069Wkd43fX7S0D4f7cfvcM1OT0xDU
         eTvJGsRs60C2UpDJwdXEFC3VGfpIvcy0JG3Xr7W6JHRX3w0UnlkLd7OwtP2ZSITLt/J5
         IUD+brNyhyqUz2KZeC+f5eW3h61KjMuBxBAV+X4hDUDf79YJFCCTAe9lGzO3b1ZLWGX3
         lBylU5nUVUuZBpPwksabpMVx8HQORxkG4m424jEQGoqETHpUwXM7Tp13DpnmoneKUulG
         l4yxW5oSVYWCDbCXUoTXyD2psxscW1+xx6XFs68nR9o/pB1RLNkaIlgCtRoBUJf+UVA7
         /R9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzNusBnJI4umm5nYbtNCiZ5BF/VNH0io7i54/sm6TwsGJBpDv5pXkVTktN5nKg2TWge41Ht90w=@vger.kernel.org
X-Gm-Message-State: AFuF++kF+flhvetYhlu4rQ6oyjokYwnHVO3l8QafwlwfUuNzgvUZkrV/
	6GPZ+1xhRg0V6XEWOYiz02r9fMWVerSn5Cm0G3qsd8MjvvRqFN6feArO
X-Gm-Gg: AYBFou0im53DSqe/56JdYybGEbyiLglvv8NvUpOXiavhH07MdGMPP5JYqPadi/4g9XY
	Jzh/xv2WNBPY4onh9iX0aM4lXughffURE6deXOE3fIGwl1/gm4HLwB9AFE71cS2poqn6YpJZwRV
	Cde5WHPYba3EPhM3Fb1I/G8K/jalBPepYA2FOaxnTEAm1k72FDGoE9DrqE2rEudvEypr88WQbQI
	HVkzoIukbZrSCoCe1uLtzs+keK0h9mcwpGGSxsT/S79JAdumQd1jcvGv+NE4I0xuRQCiwdHt1OG
	dNns+7lodSVun4IZ2uL6aKsruU6MEGpJ0+ZavjKpmxJbP9aHNyjMvwUzKGeEtPo7RMVtbxk7MBT
	IIFoh6irLyxK68oJQi97DUkHwxDWD/ylO1A8f1pZBBBGVfXav4XYkMsAfVeQR84jVaJl9eVL1hi
	PUAkgDPc4IP+0EbqOAB5JusmE/noxVYh68hbmcRiGcSCsmxQSkysRXqLUnuW3BOnuVx9N2pdOND
	8VXAV9T/CUQpxq6IJ7QQEcOPvJ3kB52qz5guuTRhPMxEm4WmjRrHIRHIxOICDkj7PBG+UmV28JD
	ebD5IMzHHFeIluWS0IMs6/6iOzjFDQ/OJCHzY9Ay70bo/BpmpCS9ayrXYQW7v7PAv+berhhrbcc
	Y8HDV+ujLaGoI+zujAY8=
X-Received: by 2002:a05:600c:4693:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49e619bec89mr306254245e9.6.1789320518714;
        Sun, 13 Sep 2026 10:28:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm366987695e9.15.2026.09.13.10.28.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 10:28:38 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 888/935] net_sched: act_skbmod: use RCU in tcf_skbmod_dump()
Date: Sun, 13 Sep 2026 19:28:36 +0200
Message-Id: <20260913172836.1738-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065547.180810648@linuxfoundation.org>
References: <20260912065526.833703348@linuxfoundation.org> <20260912065547.180810648@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless a 5.15 backport of upstream commit
3016024d7514 ("net_sched: add back BH safety to tcf_lock") can also be
included.

This patch replaces spin_lock_bh() with spin_lock() in
tcf_skbmod_init(). A rate estimator can take the same lock from timer
softirq context, so the timer can interrupt action replacement while it
holds the lock and deadlock on it.

I reproduced this on 5.15.221-rc1 in QEMU with lockdep: after the estimator
timer ran, replacing an indexed skbmod action reported inconsistent softirq
locking on tcfa_lock between est_timer() and tcf_skbmod_init().

With only the skbmod hunk from 3016024d7514 applied, restoring
spin_lock_bh()/spin_unlock_bh(), the same test produced no lockdep
warning.

Thanks,
Karl
