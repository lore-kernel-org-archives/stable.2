Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3824B47D924
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279034; cv=none; b=n3k1YLirGhrR8r0adNMutsDfpuGh8UNFaeOqsMvfVulb95ieyCAcokGN/K/m43bdCWsZ9vAKOptd55lvE5PPZxNQpqoeLGjloFiFUIAuB0IRpKFGJ/p7KJM45foyqdSpdG4soJHSQUR84JiSRosIBICFkD9D1JP8hpcIqlpsApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279034; c=relaxed/simple;
	bh=kB+wRcwLg9jpN6jhg7tmxn+hiV+nveguI8b9GP8r5oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do9mq6LODfCXlvJuOg51e8Mw14OAInCZhaorAOvn+V1RovPGbtMIA9c/NBT8nvnEsTaJFp9QOAhm2cC218rzDCBn/38v0GGCT1853AqOd+vkeZ+yDZ3ygyaG+Q43yKiu5cdObFU2LLN2dfue+ciEiV8jod0XuJ5Qb41hNSnPzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2upDrJC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2upDrJC"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cdffe8e3eso185296d6.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788279032; x=1788883832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qd8FjjdakEvlndPpogmSOky/bdaCcagMgEJZOrnyBdY=;
        b=l2upDrJC/GwSxGdiavmH/jNLDexiu0A7sUvAv1R5e217OjectCukxLJCjaltAkpJO0
         4EI2kmBDoaN7IsrBuwnezJYNkV82eiYtoHFE36aH7xrPUaApYKxpwGxwtyymUfvBRLWs
         5pnNsPB+iHJk0VNvAWl9IVfPA0UVJLuslvzsLbp0tPxOiOFxtiuIBiQpQy8Jrs6LhWCB
         K9bYNeg7I6Ag96UHOxn2NhT1AMpuXVZzWR3DyI1zZgrnU6qxaJaFza6w3t+QxxQIwm9J
         BF6KJhEb6DLhfGqLEGm7fJF0KfmXM0V+4I78ECqJBAMV83L9eAMWQBKUBvs2XVpNCdLN
         49hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788279032; x=1788883832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qd8FjjdakEvlndPpogmSOky/bdaCcagMgEJZOrnyBdY=;
        b=smGEz6Y3Yp8h1EYYqrAkNKHpWtxD3x/4a4GbKFEVc89SpCNdiYzM7PtnoQ6pBtE5Ma
         sx26lClXwZU8kreOgaqoaJzNw6g3WB2Hx0lg4S+7WDrYRMWOihR+/9EvOitgaS5S775x
         uO8n/xTyTpACq+AOTHDN4z1PyC4CWDgMkGV4xRnC5l+lU8/NUtY2q7FLljgON7m0NGeI
         0JRTgVZZa6Pc990kyuEiYaSI6MqID6KbWwWFjoglg98uq5wtIvgg9HUsT58vst91q3tY
         XOgeWhzu5Kbx8YYZBpnwOQ8ylHOksFyLqQxnIA3Yn3iU9yaiWE/gefC7qMiucQ0nRX0w
         zdzA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/c1UEdmtF6RBOpFTb+/CryeXZHke401PcmTX5UDLxmYjxOKXRnTirofiVYzWEqb//9MHHaP4=@vger.kernel.org
X-Gm-Message-State: AFuF++la6Llu+WtkYS5+xVhjRHjWcf/rEvcz/JEpLlhgRfnF1sNX1Sjy
	4xMXEZ1hPZdLUkGmwOhMT9aURowzgEVAy58fQOaFeVeCEe4qvc7V/J+Z
X-Gm-Gg: AYBFou3ReNIMIuPE9LEhkyY8jYcDw27Q7s4d8U9JMS1xrl6buWrhl5mO6s50laKXivQ
	FqxE3J+Snh/y+9xJIHZjj8oLO3av8d0zkS5i8PQAqtLZknlqxHElJkpjzZABm27jCRLTUCzG3kI
	oTfwIycqntFnT0xl/7qtISV0OqpvVXTaIdW9VoQNpN9yJHaFDaU4volWoNhSbRWiLbq0wZFv3RT
	H048uzVUw3zynwZdc9KZY771qfgcI6I1mn6IBMvAk7E0G2I4FYewVekbysNDE+tKQkveUxmtXcz
	BZMvrXnuO71XjcVpaXXZmbTjQx+QRmvAZjJ8X4L12oIFXBEsLMxVtJwCb1wJ1PlMDL3AS0DC2kX
	sKPAhGwrL9enhqkSgkO9vXGGbau47vioFeq2gqsaI9LN9XH4+d+/qlZq5ogmnY2Ywi/qJV8aDOi
	mRLyEdvpP7V6D6dJVjCMr9l+/5ip6J4aBQzl19Rb5apvyfAS1ZgPsT+7nHOMHJHtGRQ5C4nK9e7
	3Wd1x2jF7eCocarzk110bq7UGzOQalG38w=
X-Received: by 2002:a05:6214:2425:b0:90e:95c1:47d3 with SMTP id 6a1803df08f44-90e95c14964mr82027126d6.8.1788279031820;
        Tue, 01 Sep 2026 09:10:31 -0700 (PDT)
Received: from Valhalla.lan (50-36-57-116.bng01.ssvl.sc.frontiernet.net. [50.36.57.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90d98d54cfasm92683046d6.40.2026.09.01.09.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:10:31 -0700 (PDT)
From: Hans Buchheim <hbuchheim@gmail.com>
To: Eason Lai <eason.lai@mediatek.com>,
	linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-mediatek@lists.infradead.org,
	kun.wu@mediatek.com,
	deren.wu@mediatek.com,
	Sean Wang <sean.wang@mediatek.com>,
	quan.zhou@mediatek.com,
	Ryder Lee <ryder.lee@mediatek.com>,
	leon.yen@mediatek.com,
	litien.chang@mediatek.com,
	jb.tsai@mediatek.com,
	Devin Wittmayer <lucid_duck@justthetip.ca>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] wifi: mt76: fix memory leak in USB TX path
Date: Tue,  1 Sep 2026 12:10:15 -0400
Message-ID: <20260901161015.607195-1-hbuchheim@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827083526.1621600-3-eason.lai@mediatek.com>
References: <20260827083526.1621600-3-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I tested this series on another mt7921u USB device and confirmed that it fixes the zero-length WNM-frame skb/socket-charge leak.

Hardware and software:

  x86_64
  Netgear USB 0846:9065, mt7921u
  Linux 7.1.9-arch1-2
  wpa_supplicant 2.12
  NetworkManager 1.58.1
  firmware HW/SW 0x8a108a10, WM build 20260224110949

I applied both v4 changes without semantic modification to the exact Linux 7.1.9 source and built the mt76 module set against matching Arch headers.

The reproducer used a nonblocking AF_PACKET/SOCK_DGRAM ETH_P_IP socket to send zero-byte payloads to the associated AP and sampled SIOCOUTQ after each send. This produces the same packet shape as wpa_supplicant's synthetic WNM keep-alive without using the supplicant's socket.

With the stock modules, eight sends returned success and SIOCOUTQ increased monotonically by 960 bytes per frame:

  960, 1920, 2880, 3840, 4800, 5760, 6720, 7680

With v4 applied, 500 identical frames paced 10 ms apart completed with SIOCOUTQ=0 on all 500 samples. Both the immediate and settled final values were zero. An additional unpaced burst created a temporary backlog that drained completely to zero in 1.35 seconds.

The link remained healthy after the test: 0% gateway and Internet packet loss, and no mt76 pending-TX timeout, firmware reset, warning, or error in the kernel log.

The reproducer and this report were prepared with assistance from OpenAI Codex using GPT-5.6 Sol at x-high reasoning effort. I reviewed the procedure and results and ran the tests on the hardware described above.

Tested-by: Hans Buchheim <hbuchheim@gmail.com>
