Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DB24501D
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331640; cv=none; b=rJIjPxwMPDFTM9HNjVi4noefJ5fsSlgmpcJWKVQg38AwUo3308WmO/Gc4018+Iu37nmcnI2FoMaPxePJ44bmGGF5DYdQCgIpOs+oSVA1/LLjZudwnRi/8yZRJI7LpPkrniGrppEM9E8qL9Mq9OWKCNvzyo28DwqSuQItDWfDKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331640; c=relaxed/simple;
	bh=ZImNFxIOMPZzklYZUNsRSmel6jjVlfotzjbWSm0W0co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kaa8wTvTVStQPHvPnFBvnj66eVvtB/RPPZ0HMof32Re4WLlpp8Prz5A5tWUCpuRRr+34CA+utG26zEc8RelUw4EVjucX2rJUeUFJl3k/JtCZnV9+YOn6AX4Zpk5QRJm5ybFf/l6er8jvyAJ7VW/jXZlyadwXaelBmQKJGMOWTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMs0Qwc7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMs0Qwc7"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-486fa798933so741770f8f.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331637; x=1789936437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZImNFxIOMPZzklYZUNsRSmel6jjVlfotzjbWSm0W0co=;
        b=cMs0Qwc7Ktpdnxj+oak0YLCH9QZz1Mqj6+pUqgfSzrtcdrbhet71ay+2FpRCzyNZ2p
         cVbCDEYEx4RpzLhY3BE2I6+BuDgTR9bqnezlEs645N7JQEsNaZV11RQaZyKsKCrAjWcC
         Z3lXxua6CyiLczDiN8Q86duaNXei9935RpsJey+GuEQtSCeZUMr88x7sOBKflx43BFxn
         SjdKHQm+i56CJvsNtmJuToVzUk29WWCLwPxtvFSsmJ4BzfsK1TImTE/xtwl7dwBaXpmd
         TNbeTD5rSkkKYIJU95M0t8hU6NVGfNUL5t4raWrr2NI2v1NZN1tOrkhzSfGFxLsSkyx8
         kSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331637; x=1789936437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZImNFxIOMPZzklYZUNsRSmel6jjVlfotzjbWSm0W0co=;
        b=PL3HyitynRDOsu95i3yrDdk/YuoOg2auHlhnyG7m3eP9S+ppzESyG+T5rI3SJ9GMMQ
         T4J8T6HqCk3jL/niT69oYcWB3Z0nq9QrcAbPv2kEJrjOZT5khL/xQNjdVpXr972AQ2TK
         EPLMdXjm7nrv4tFsFUcKI5AVtd9jAvhNqkM2YPPsDTK/qGRlHhRJMcf+riv/Dwr0Dz90
         N6iOGvr3C2I+IKkmoCfbkaAiQjdSiIyQSjghdFYe6PSm4QwABwizjMdKeN2UHCZ2YHLA
         butBzUNGFntWtkNpEQ2WOyrmKquDDPDghW6mBitFBhXERw01a6KPY9H60DfDHqVnVpa+
         53gg==
X-Forwarded-Encrypted: i=1; AKwUvBylaGDAWDDrNjT2XmqBTMTUdole6wTzElnEwf3Q2aMHL/3zhHjEluElkyaAwIET+xVsrp4tRD4=@vger.kernel.org
X-Gm-Message-State: AFuF++mP4w37t/fw8Ygc84+WFsnLZ8l1u0EESRERcnws/rL5n+Cp1rPo
	dVzZlZ/L2AfvDFH/WnnnpUqGeKkSj4Z3lnrCc4S7nidSZIBnSadDIrdE
X-Gm-Gg: AYBFou1GMh5a4RH37eiHg6gS7y9h+H/csmCyJUGueKUdgaAeKFMhlhy4d7LSKjiZ8Ao
	MeSu2bXWKxzs/HBbbng5Sa0iIVy7MzTIAdYb4d9FQ1tYLGVEEw0oO1NTx0QzUb43/ZFuw3khuCJ
	SFsoNBxi70Lb8nR1JiIHn3CjW1rsPYdn2TLE4IXSTpg3EDmsqIDqaPaPD9Mb1GOHAnzFgU5G7tQ
	1HQPbVVWmea6vygP7FKy2Qge5RW0i7oipXP6Crnyb43KexxxXFIyq8vsnx+rp5MTwlmTJXJr4Un
	IIMGp4hjawMREWjMYK8DjV5dFMufplAmrOIQ5T1eWWSEQQnIhKkdsbTdpCWlBbLtPUUCGMVia35
	AiyUBv/ESWEx7SNnRbhf4E8kjFL7LYfc6tkaCHcmEKQnvdZSyuKeeIfesAnjyvSiURLyQeyXYGg
	8pFlrl/O9QFCx7lSlghz60YD2V5/3FDh5HTWyEx6eLCJQFpHP+DdtYjeCioXwqdgz73XAXz3kJr
	fCWJvOWYxGWnbpRt0vWJ1hwyzVBeVb1ufmrltzrj/aMN1iAJ1TeWQn3pJHiFE5994+bLkV6drOg
	CH+L0yBvYxdXupJ1q03n7sGF71k+8s9OhHpZzB+i+QfEHZ7SA7VUuky3g9tWozZI6JyDASWOMLM
	OxP0QW+jiY9Sy
X-Received: by 2002:a05:6000:2211:b0:486:fa3b:7830 with SMTP id ffacd0b85a97d-486fa3b7866mr6070871f8f.15.1789331637349;
        Sun, 13 Sep 2026 13:33:57 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e74esm21719486f8f.25.2026.09.13.13.33.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 13:33:56 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.10 749/798] bluetooth/l2cap: sync sock recv cb and release
Date: Sun, 13 Sep 2026 22:33:53 +0200
Message-Id: <20260913203353.3295-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065534.238252948@linuxfoundation.org>
References: <20260912065516.948645775@linuxfoundation.org> <20260912065534.238252948@linuxfoundation.org>
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

I reproduced this on the exact 5.10.270-rc1 tip
f69aa74a82509ee94a2aac2822b4189496f267a8 in QEMU with two linked virtual
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
