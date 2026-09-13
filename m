Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FB3CF20E
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331359; cv=none; b=HQbeh4FjD8/zJJ7VvUWzNEJgdDeYu7PslYEz68pnlOQML0HwHuHIcuY94a5rVX/GeelqfKmkEeB3sHtIyHMZ7nLty+Y4vCIH5BsmtRQ5gSn0+LEDyiVlY3cns0/b/cTXaoAzMtJTIRxUG3JtCMHCFUG5zesQhBndQ/zKGXMsCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331359; c=relaxed/simple;
	bh=zzJJc0BvZyAD8faAxTr2KVe8l09VN4/GOFqySLP4k2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxEigzupFjARwYzORxgH1eZe6kZy15VIyKinfK0fH6g2MVADrwJha5saqLIDJxnu5UALlcijjNG/W9H+6Em95UXsSa8a0KIris2wxxnIwEMMYdZWljyDAXr6hDZ7h+r2MPVhQPWZqr3ldT6/vmTN10ohPPwkIfVZAFaDMvZUyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCIEuBK0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCIEuBK0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so4219375e9.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331356; x=1789936156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zzJJc0BvZyAD8faAxTr2KVe8l09VN4/GOFqySLP4k2k=;
        b=BCIEuBK0Ppc6U+TWgpPfU7oaSMn02tkg3cug0dPbidTDnxsuE1uryfT7ZPxR8hfgiU
         ftluy6J1PZvpvZUSqIn+zvp3JEfcT8FPJihTCDvpIG+GRVSgzAHe0pBE5pwrunt2NvQ3
         Lt+nGVtn0WRYVHAZ/4wFLkQQsxlduflFr5/3hxGz7ldvJBNMs1Lxv2/8u3yBlf6pZM10
         Ef9wH+K9rtz3qXyGZdvfYDvsMVu4xyAIlTw7bxaODRk8zjkbMRjxyywiefnO/YZDp4kZ
         EHT9ZLdgF8saDNA15KEfumlhkAZcW+XSruVUFPP6wOsvfU6+5smbAQekkMpllmAX3Q+Q
         6oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331356; x=1789936156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zzJJc0BvZyAD8faAxTr2KVe8l09VN4/GOFqySLP4k2k=;
        b=MBPX8112zv0VjotMMW/hp9Wt6D4SJ0zc/ZwwrAiG6EWC9Il9oPFSObmZ1EnLdg4pPB
         Ad+rbx0j5OqmUjHsRv7R1Y+gY3Vdir/tPfsXTSysvJq0FPxXezzu3DK+7omWyrm6JKkQ
         UTRUEktZyrL2U+sPZeY2K8HAmJ228r0nySLurhG/KtQB95DvMFkZ5EoLT33tMbZ2BzZz
         FwLDZsVRKgY2QPkR3gVq9FsCNFHM+jDXI2Q4c86Zb+fTQGAIEQ4pkmet1lfIpoTQYTix
         ufnmyEu0uk83Rom754hepl4tkmyGD5JD8fVNP0YuQCEUL2J7mGDLopMe0cZ/6t0ga08h
         yt/Q==
X-Forwarded-Encrypted: i=1; AKwUvByM76+PXLrIK0qtktEZ3e9C8dyOW0/eHJql7P6m8Yi0tRgjbgC2vXLPxMzmIlpw0pxdfXkNfsU=@vger.kernel.org
X-Gm-Message-State: AFuF++mtR8WZCWrrZVeMnhynWCazQZIPWvQ+cJ4Ih+/Mbm8387r33yp1
	v8bsy9MNOpGTnFIJIuyIY/uE8wS0ukv8xf5mupBleIWNrwdlKBz8YJvWujXnzA==
X-Gm-Gg: AYBFou3HZSctRLSCvNa/QLfpC5Jf96NmZP4Ycjs24ROXWlR8D3w6XeS3pxIthTjDduE
	1BxFrNSKDTLY9CrjuFESWaCf8o62UIr/7/e8baxm4E7Cejo3OV4Wq+0UdEbFvyu3tc48XU4V+ur
	wGIPHLhQgCNFq/M6k8CiTTRv/1cXCXpCFNx1St3lb6OL/ZEt94+BYo3rVAiZ4NqjM4bCMgGh1Hr
	FCZu9+dfV01nzOOdxUeZJpiEu+GYJkC+e65HUjlQuM7J5WAOor4eALILWSqz6Fe5hcW/aSrhLIp
	4+R6KFvK/G3O1XvJ642Z5pzAmhFOOrhReMiIQ2a8AyTIk/Sm0Nz2hxnYmj3gWJLAAiPeKVDWzi6
	RykxanVZ3nNy0OgLTz9iSmWQ4eY4jpGlc7eWo89Mk8PN21CWCfB4Ms9ctimmFVRU7xM8pG7mGIC
	g83Av7Xq87OF2DYE98h95L//en5hxGJ9fLfrwok9yL29nKFuhSobjhTaHEAWtv25F6D9gYDFauH
	gknHT3/rNqxoEp/nQdxF4F/00EnBBruFE949dl5RTG/c+zOOJZunMJiMLESsEGuZNupodEsljZz
	4NqYDKmvOKbA4+3U9xKAxjxveMMvlYS9TzTlI/QqKHKFRVhD+BXnr9pEmgINtw/S20oXjj2gwCX
	5Av8qajHi/fY=
X-Received: by 2002:a05:600c:1989:b0:49e:71cf:7088 with SMTP id 5b1f17b1804b1-49e76036362mr36886325e9.7.1789331356085;
        Sun, 13 Sep 2026 13:29:16 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6aac22bbsm124123255e9.0.2026.09.13.13.29.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 13:29:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.15 879/935] bluetooth/l2cap: sync sock recv cb and release
Date: Sun, 13 Sep 2026 22:29:07 +0200
Message-Id: <20260913202907.3100-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065546.976652519@linuxfoundation.org>
References: <20260912065526.833703348@linuxfoundation.org> <20260912065546.976652519@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless the applicable L2CAP hunks from upstream
commit f1a8f402f13f ("Bluetooth: L2CAP: Fix deadlock") can also be
included.

The connected receive path already holds chan->lock when it calls
l2cap_sock_recv_cb(), so the lock added here recursively acquires the same
mutex and blocks hci_rx_work.

I reproduced this on the exact 5.15.221-rc1 tip
0dce236725a538e8ddc0601eb0fb0bc43fc2c87b in QEMU with two linked virtual
BR/EDR controllers. One normal 64-byte basic-mode L2CAP SDU triggered
lockdep's recursive-lock deadlock report, left the hci0 receive worker
blocked in __mutex_lock(), and was not delivered to the receiver.

With the two applicable f1a8f402f13f hunks applied, the same test received
all 64 bytes, both endpoints completed, lockdep stayed silent and no worker
was blocked.

The tested adaptation removes the callback's channel hold and lock, and
adds channel locking within l2cap_conless_channel().

Thanks,
Karl
