Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875233CC7EB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650746; cv=none; b=n9Hv6RE6JWwOJlI4pPlQqVy4rvRU1ffnldoWdp6rVbiPLW5XVOiVlELMLE/wMlAz9DYNC6luNdTgOJsFv7y74SV4G60zL95KZKSgRBwwibnTw6/6NebDBjFX7cGU/Ih9HbTQn2CZsv62LUDRA5wwrxW4cICqr3SNELZnRXudLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650746; c=relaxed/simple;
	bh=HJyTeXVijHdk4eWMa4QoVfAxeX/wDGbJNl64bB2L/eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhHOpLsyMV3KrXQLgq/wQx6nM8N7GEAptcSdrJ/8sVIg4jrUTqPj33D95l7BJK2Bix708WTy59UUhqM0ebFpmq7fCk0ZHQFiekCSojFRZUSHdh8X4/7Xrs6ECBRKtSFTkBdyv0kaZWxqD0nAn8DRd7nSBKh0qERJc/zBlKbxdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=adxscrNS; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="adxscrNS"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b4f2d90c4so122744eec.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 19:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790650742; x=1791255542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UFhWeC8nK54inRKs6I+y3KfLb6ie98THlXPGgVHMi+o=;
        b=adxscrNS0SZFlILvax0Rwzos3fkSpLC8i/kEVM/kXJ3D8ZD86ZQFb5k4bzeUy9/p+n
         jYDJLv+MggeJLPyBausWyooZaHjoTMxZDB5SImSzcvHM4tBwWHbwlvIQsds/7YekO0oy
         m/fqWezeDh0pOKZKNT7Fbet6NtOnAF2C5H72T6PUlci5PRGujDDrdZqucVDCFrB7OcyJ
         kCNxM9Uz42fVnW4K0ge6LNoYuP1NGuduAxO0fZ0SEJ5UqdWp0QMxbVIgo3cEikKmKI38
         D0oYEi59FtEsbAUYOJokjBY4/XKRYhwcbaNAASh1RCxSU8tuP8hmWzH+y8k9sTXlA1TA
         YotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790650742; x=1791255542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFhWeC8nK54inRKs6I+y3KfLb6ie98THlXPGgVHMi+o=;
        b=EH2OqjBjXfobrS4HnYd2BXwMGOzIk79WgkeUYIaET0KKmUYVnWkYa/v57aJsfyQtx0
         iHzI9zJH0O++RsH/vsrduJlnp7cGBnxT5RhrULsgncuz0UfbV6d27wySt2S1rkXWvne8
         7nSd/f2EOgVXQffN6X2p80U52Bt13F+K6nUAjHdG1IzRSj5GV4U3ZKP/Q9HoS8eBrpnx
         O8jGpl+02pQcMveD5/OoeDwSoAiN8KmMi5FadGAJ20qmQZGPqdhPbj20SY7xYL83nB48
         FZsek90AwKm4pH1NxLLbEtTTAIr50gr4PVr2qEIUkz2hGA1LORCKQiEq+P7M6BfxeZPJ
         nM4w==
X-Gm-Message-State: AFuF++ngK4QEf8/YJ5gEE6VM0+80XPwhSKO8s5wAlvhHEuA0tAiPlK1p
	ZvkuORg1Cm6DmVwvXyLy5mlqhuxDqc8kO8eWXUv0Di4sFcadHgqnx6gJM8EuYA9XWG9v0leuOyI
	LRJKXKME=
X-Gm-Gg: AYBFou0oQpDX87lXskyXhnnItTCiG2j546Wgj03SCy5nmzkPIbn6sTuT92DKiIO04Di
	n+T2speYXWnBA+PEuZ3+kivGlSCR4zhL3mdLwI6F72CpiXpZltxm29WzztBPCNE5YU/58lJSqye
	NObfQKSKJAVDe82ltglSOeMvET84SQSlqaf74qnC5E9u8vhDh/wN6prnH7jRGjYVJk5ANRSM7y6
	g1Z4qGtC/NQzO3GQIx2NpZUK1IuYiMqFfe8BmZVNPJuIa2GgOXKrwXcomUieNrCjt24daBCj7J3
	UYgoqfXynqWEwaF8ibPcRrvAt3+TIELe17VSH1RYsSU/BcpGyOXUdRP0P17hoyWa42zDWqagrH+
	pcicKQLJ3B+1LRiTFbww6g5VrKwiD6RtBDELvdFNGzvM/KFQA+UF73XThSUXPRVoFeynhPk/D83
	6ryPgZeWpHhzxNWSw50pbDb2Utc7UPo8fDKgkARZ3C8/6wEzqIQPqZ7XWRDjL28LYrv3a+vCPWE
	ed+GkjMiYvQNtrIq8ntFacDqnTfH3XSTvro2BdR1eua0arHvTxZj6giHkW2SiYB8wk15eeAVp7A
	L7oFS6g=
X-Received: by 2002:a05:7301:1f15:b0:33e:6bd8:8f1a with SMTP id 5a478bee46e88-3426cfdf68cmr15624231eec.0.1790650741745;
        Mon, 28 Sep 2026 19:59:01 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34571658054sm13111683eec.8.2026.09.28.19.59.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 19:59:01 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_jjohnson@quicinc.com
Subject: [PATCH 6.6.y 0/2] wifi: ath12k: backport CVE-2024-40979 fixes
Date: Mon, 28 Sep 2026 22:58:52 -0400
Message-ID: <20260929025856.85683-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and wifi ath12k maintainers,

These patches are a backport for CVE-2024-40979 on 6.6.y.
The second patch depends on the first, so I kept the upstream ordering
instead of folding either change into the other.

Both patches are already present in 6.12.y, 6.18.y, and 7.2.y. Could you
please queue this series for 6.6.y?

AI assistance: An LLM helped identify, adapt, and validate these backports;
I reviewed the resulting code and validation evidence.

Thanks,
Artem

Series:
  1. wifi: ath12k: fix kernel crash during resume
  2. wifi: ath12k: check M3 buffer size as well whey trying to reuse it
