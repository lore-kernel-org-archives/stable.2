Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569877;
	b=qmr/P1/ZKd3svlJuDZELG6piX2W3My1rVLa9+XM2puHzt8BgqckchBIrb7F7tqRT3hD5
	 HekV5NmCJB3BlOyPAhOEyjoUMoRUnYrPlYfLt1xo5JqI/C77jL4VZ0/+rUUtMphzGZEdD
	 meYUI3J7/TUE9IAp4Q4fHfvmlR3zzCg0f/JAAPVCPhUxh1gDf+biBoYtYJsSzQ035/AAb
	 sW+iDl0+D+DXlhtVbeYQFVuVgwVbYO1/bDIRA/Z/pYFWcZvF1kdpaBDEpb0FiODDAq8tN
	 vo8Mo7k+icDUA1+sVi7+7B3qJJO7i6+zsTJdGHL8zLMx/mRveUw3zjI4RPdQaiI4V7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vbvTT2zH16U4nvYl2r2md/wzDh4cRShpLVLIl3HVESY=;
	b=fxiCrinGsFYiMTuR6AjPjEpHUA0KcgKgoxLiF9/De7DOt49YOxS4wd7uP+FVqQghc0D+
	 a3KAMRrdoR73+NZpBWtqBT8pXB7fTcE82k37azyh3BXkCGMfoSStYjkclazo9XBlsKAQA
	 xm5sd8fAx2U5dffj4HK/lGvz2h2Tik868jVn6UODUt17x8ttj5ZuvNzd+OML36W/JknMK
	 DpKetPJGZu5Kqe3rbAIbTlOXBUdewQpUTZasGjJkZ2mCFNDUx0My9Hd3SsL6D9zsDoihL
	 GbJCoDrUOIOV8M700Uu5Ug/xSKlIHWKFZtwkGor4Id5aROLhitML/iNbxzYnYMvp/vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJgYhnd4;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DA606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 21:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 632DA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJgYhnd4
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so25618595e9.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793569875; x=1794174675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbvTT2zH16U4nvYl2r2md/wzDh4cRShpLVLIl3HVESY=;
        b=PJgYhnd4br5i71vpvxNrvjZ2zRZ6iaoaSIXouE3kG24s8k7x/nL3nTItvJ6U8EaJfU
         t7kCEhZH6lFSIu1MJxHFXBJ/3fHYORB2HSQTG635KoWGZmu31HPRRsRbtWgZBkMqhcXY
         m8yIl0NSLMrO9tlhF7M3PbzHgRyvwC5uO5CEeOPN64mgSm/PsQCiOiyzr50bDh+kjpyR
         QuGgVF2W1jZrJ+2UM15ZV2Rbr0qCCJ3BNB0mZ2Hn0rybnlwuc2mEqqmyRCbVwgFa6L+Q
         IhWgmGsyEjuSlvdKpZf0A82cAnUyqGVprDldf6b8gu7CAdB2fyuh+xlrKODCFqY3yA5b
         5ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793569875; x=1794174675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbvTT2zH16U4nvYl2r2md/wzDh4cRShpLVLIl3HVESY=;
        b=Y1RFeouQhmw7MrOM2vb8IKk+jhcAIXixV2HTd6Uy93PUQRc5TGbl/njfSEe7/wRQ6d
         fDofm3zs8IK6QHoodOtzFR2TGR9wJAZF3JU/zzfuJmHXdrUKboS5dunkrAI2kNQCaWNa
         zk416x+E9je54+/ZGUbksYWvVuBBLTQUqPskdsqUytIhiiw2sV9Vj9rS9CtTmiukJm42
         BmkxeFsl5U+zLCWTg7KJy6FOD55HUyqDzcvOH1+ASZZgLMsQDLGRGGSDais2az1y22Xd
         rs/x0w8wi0S3Bn8MmG2462WVv5N7eYxeAUcyyxComm0gNhMEj9C2fk1aQUes9N5UpCl4
         miwg==
X-Forwarded-Encrypted: i=1; AKwUvBxFrjO5nCJmK8AtuLY4FywvG2xN+IZVw9BcvlZKQpkVqKnqFD28b8khH+wVilmnLaBXGQ/Xlqw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxtwFs//SgkAKMwZ5SpRaZb38vOBtLR6LaK5GhRJuLO9uQMYW/
	t5cNcsUDb5FOWxLq/hTGfdA68ZbN6H4OB9wp3FsNJ7Y6iOZDb1qHmA8=
X-Gm-Gg: AYBFou03LkNQykKUcz0kTYUrGoCvpoGDolFPyV0CX407hQQ/8uH/77+X1VzRCK5Hjoi
	z54skAmdE9dH8K6OeOSWdcljhn3Gg30ThAGOpC+dB/NBr0IhHfTGrMXlqTFR45/UnD/KCYFUasJ
	q7ELP5EhWd1SQqXfdRMDQKznUxrTzWtvnRRXmk/TKngFjJTWa3TmWAP89rnBPKwuAbpAm9CJim6
	B1vc8E2QQmDENwkjJpRU5gmClhXvLI640Vz92G8JOuz6X7YGmYxwfVpKJRBNbcpfR/dbRn/QCpF
	oXsLPKH0buI17RyZRWK3KXHVqGqcYO6NEJ6r+6XZ4dUXvnUgkHtLyr4puNTAsDJBlhgE9qUjxvu
	XFrjiL4fu8P0HI/O6F0aeW9rumxhEZyBsQvN2JKOZpmtzUrSvMa6ce1PqjBCCaId+7e4iQDP1PJ
	khtGUFTPmirM/g3peNoHyorCqEB+D0/6R+3grZQCfOH8h/MQUtmec1nixfyD/Rzn7u5UdrNeYBU
	FxcHoLUTJ0kNR58DHsg/yz5rEn4ZzgJqBF0RZPictNqR+YVYH+VczFsp0y77nCPGqUNuovA5A==
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr196538715e9.12.1793569874581;
        Sun, 01 Nov 2026 13:51:14 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad5ff8sm157249425e9.4.2026.11.01.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 13:51:12 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 0/2] wifi: mwifiex: firmware response validation fixes (WMM + sta_list)
Date: Sun,  1 Nov 2026 21:51:10 +0000
Message-ID: <20261101215112.3199197-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

Two input validation fixes for the mwifiex driver:

  1/2: The WMM status response handler uses the firmware-provided
       queue_index to index a 4-entry array without bounds checking.
       Values >= IEEE80211_NUM_ACS cause an out-of-bounds access.

  2/2: The AP station list response handler iterates over sta_info
       entries using firmware-provided sta_count without verifying
       the response buffer is large enough.

Tristan Madani (2):
  wifi: mwifiex: validate WMM queue_index in firmware response
  wifi: mwifiex: validate sta_count in AP sta_list response

 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 14 +++++++++++---
 drivers/net/wireless/marvell/mwifiex/wmm.c         |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.47.3
