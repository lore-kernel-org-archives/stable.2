Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FB414411
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089650; cv=none; b=jnKVnOseiFwbxglhbQp9QdlW9R+DFfS7IbC31W09+tdHDW8Q07StgcP6ri33+EY0SLkTw1OhbyYm5XyTxclW4FOZPXX8LPrMPC+69zAgQHpilWkNveGhjPFrD05X1jTEoMvFq5C2gc5vmU0x9jCetdTa5xGg3tzSPL48I2GGJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089650; c=relaxed/simple;
	bh=V5yzgDr21nxczhxKu9JiO+Rl3gBcr/Doa1CAdEco8JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIe61zPY5TCFcDKSC/20X23GcjXSGntP8f41FvJkPjhLQBm1aw0k8ed6kF0M5ayZoNYmlqcjzAotBEnx+rjt/jv2vGj2nTJAtQqQmbK6TxT7+oxaIKViE7jejbLVMS6VJerCx9U8XeQJbpMz0bEU1hWfE4VhQHaFJH+6CcCP3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8/gAHWA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/gAHWA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so51357335e9.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792089647; x=1792694447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGkil06XO3g5opDlFSJDhdb0jcGxqJIbAxYs8/6p9Sc=;
        b=H8/gAHWACQEjvRgEjxncrSbDKg4VlqGYblmErKuDKlNhvRo9hpgdWgTaiwVII8p1MJ
         eL3QeMoDhfx+9dWI+w+22RyBNyarsIYJ50VYJz/YST9jobv3phMU5xe5e5iPWYAUfRBi
         7Z/hqsvYzIqd/iNykCX+AGZA6m++f4tlN5oICtnTPb5Pb2xdQk/l5bzarKEIgAD2lyks
         dHPtVQXSBmTFKP4TeE9OpQuwrIsbP29QQ3AHNPXxPKGdiELL1fhV6oUZK24zUFTQr/4J
         STcsFZbJrP9N1J9YiKQI1Q5gDAmw8+g+hwpVIJJbHNU/cRQS9hjKhJCBakmFXFnGvaB9
         fJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792089647; x=1792694447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGkil06XO3g5opDlFSJDhdb0jcGxqJIbAxYs8/6p9Sc=;
        b=mUrbV6docSENQvlDKWbBUZIdDSrinlamc1BD4fN/wm8hrvZGd3TusDmO3FkXaGQDVw
         MlbEiBC2EupN+aG55K1BnStu7L+UrG0JTyC71LBYAAUTdfytcjJUFYnClL8xo7Uc+Zhr
         QuYTGcWwp09+xFhvWvypb5jFkfv+CSV6hvF3qaxiLGpGuAFQN3HEn63hfzGIJiEsMg52
         i6m+e30ZD/wzQNkIT5lOBPpRmIElDhJ7nPLK1cIgwnSyKUL517y/Z9oJistdifVj3CND
         UCs/JJRwjqVGA6crH8MBcOkrK1E6jNLiNcOak+DxCXonAN37L0/sbE9GZ/dgn2QUjZhg
         Posw==
X-Forwarded-Encrypted: i=1; AKwUvBySRn6wBGADZKfFZknz7b3WfoUQmuI7VM7Mkfaj5YKPCoFxDT3pvYUogDprVp/1rAJ4BDeuWwg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWfw7/fX1YvY0U0SfEFotb55GwWJ/UUq82+zHXXc/snM4pIdLc
	0+lzX5nBUl22fD0UF8M2JCZzp4gjZM+mZ/4JC3Y8nCfR5I7vPMYsoqtL
X-Gm-Gg: AYBFou3a6/VPNs1RijRSMvIExbKLWBHmK4pgaHvWIbhxT/qG2WLMptBkSrzR46MsvLt
	T6TetJ3AtZx0hVOIt539kyHQxTTb7Lt3nl0fGRSmkh9jWF7BtzlpR6lY52Z6nEcAJsZfVBEJ3Hk
	ATZphc3fTrHqNf9kJa9HF0AdijrqlAknLXcrsxxTUNJPILVSkMhhiLHmPzCG5Q8++73ngimaPYz
	A+cw2J3R/z3jfURQ305WqSGiofaEGd2MdFLkKTpZBSIa5dzPikLpeeY2WhpZwLiLPHbtztz/LKB
	IQWQx9ZQi8Q0nG1M5IUqwHHkRrooGBLy6pbqXtC2JIQsxX9nXezBkt6QOvm36W+52SclgA7PlP3
	pcKnBtPg1qXuainMTDbmf+hVPsEPCQmufx/OdVjmo2aYJJDix979ArH5kmqCXgAkhGNVAToypXZ
	SAA58+IWp4cvhXI3YMk3ko3vibxZ2c3BrZZDpHVIiRj8ym55+NJEiDGmp8+iUQKFtWxU4wrysyg
	cpS
X-Received: by 2002:a05:600c:4689:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a18e4a9b31mr429219275e9.12.1792089646475;
        Thu, 15 Oct 2026 11:40:46 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd67a080sm88337045e9.3.2026.10.15.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:40:45 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v2] wifi: ath9k: reject short WMI command responses
Date: Thu, 15 Oct 2026 20:40:44 +0200
Message-ID: <20261015184044.1321868-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814075837.20005-1-pengpeng@iscas.ac.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this change breaks ath9k_htc with the AR9271 firmware from linux-firmware
(ath9k_htc/htc_9271-1.4.0.fw, "FW Version: 1.4"). The firmware answers
most commands with an empty payload, while the driver passes a response
buffer for every command: cmd_rsp in WMI_CMD()/WMI_CMD_BUF(), the 4-byte
value of WMI_REG_WRITE_CMDID, the 4- or 12-byte buffer of
WMI_REG_RMW_CMDID. With the new check all of these calls return
-EMSGSIZE, and bringing the interface up fails (hostapd: "Could not set
interface wlan0 flags (UP): Message too long").

Seen on a Colibri VF50 (Vybrid, armv7) with an AR9271 USB adapter on
6.12.113, which carries this commit as 03ef61d05aa2. A log line in
ath9k_wmi_rsp_callback() for every rejected response shows, during boot
and interface up:

  WMI_ATH_INIT_CMDID          0 bytes, 1 expected
  WMI_START_RECV_CMDID        0 bytes, 1 expected
  WMI_FLUSH_RECV_CMDID        0 bytes, 1 expected
  WMI_SET_MODE_CMDID          0 bytes, 1 expected
  WMI_REG_WRITE_CMDID         0 bytes, 4 expected
  WMI_TARGET_IC_UPDATE_CMDID  0 bytes, 1 expected
  WMI_REG_RMW_CMDID           0 bytes, 12 or 4 expected

With the commit reverted on the same kernel, logging instead of rejecting,
the same commands keep answering with 0 bytes, and so do
WMI_DISABLE_INTR_CMDID, WMI_ENABLE_INTR_CMDID, WMI_DRAIN_TXQ_ALL_CMDID,
WMI_STOP_RECV_CMDID, WMI_NODE_CREATE/REMOVE_CMDID and
WMI_VAP_CREATE/REMOVE_CMDID. WMI_REG_READ_CMDID is the only command in
the log that returns data.

So an empty reply is how this firmware answers a command without a
result, and rejecting it takes the device down. I have not tried other
firmware versions. I can test a fix on this hardware.

#regzbot introduced: 93ce8ea70451

Thanks,
Mehmet
