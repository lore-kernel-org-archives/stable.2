Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB503B2FFB
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389846; cv=none; b=rRdtI9wg09WqXoF1iO0yGJ/Zbjkj5fM2V/E1QYwhTIJ2E2SMPOZXxil6s+h2Xp7u/40SEBLvDi4XbbExBqL4bWwop6rifx1QxkmPefr4S/Vt7ZDBoX6I0PibKyHCeJxNaCUnAsvLXoljN6nYts/tyBnTnNZIH1j7NebnyFxQdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389846; c=relaxed/simple;
	bh=xClNSbQk28O4IEWLfHQwoE/rQvvZVXRjJvoSD6+zhd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNXtd56o8Nx/ZnU3uMeaw7KQAM5epUqTnZUGJbmsNC9g9jGv1qOk9WtUN97jmvbIIzY5gd5PxW9lO+4mHXJG2lLM5Y+diQzqXqhw51y0+HKAgTaRF0We/Dk2jdRqMDPZPgD7mPFGF0gGApHwmhE9tBMdh3XmtgiJ9s6xt3vBweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENhyUama; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENhyUama"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so13471925e9.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791389843; x=1791994643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=96ubfTEIebV0IP8hANMUHHzo8Lc8lFj1Gn1AjeLyV8U=;
        b=ENhyUamadzdJZ/jySvAFRuspLl+X9aARs8SEzWB70yIm32UCt9FqnltO0gDPJeFz5q
         9d2QVXdDO7wqsnmxPNc/UzZzecYhSKwMpbiEXOSjmNV8i+WPLmNh9vQbXMx72QAM+ySd
         ypAmLM7sf4I+SWdQ/aOeMB8yW9AAVueSUPJjkWSVzOpEXED0tChJ5+ZORY9m8y0Ycq/F
         YyP2YeRp9ujhfNYi3EhX0LNybQikICG5KOO6w3VFp1OCS1IUXUV43UtPAhuJY0Y5TJ7w
         MeXeoYpXiRwOQXSiVQj2BxLYdj4tcqzs++vDXFbXZnqApIX3p+pncew6CXxeAsTMxo80
         4hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791389843; x=1791994643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96ubfTEIebV0IP8hANMUHHzo8Lc8lFj1Gn1AjeLyV8U=;
        b=SLGAAofCql39jRUoIBq8fHnO2SztRy9IA5dmOMUB5GgDp+Yx9RL4qmbNQa1IdVpuUn
         2+YHgp3iSl/OKKzOtODVzOqtK3JZmA2OMsIMwM7eLBAL3NIYyuKprP0G4CN3jZ2MG6Yh
         LMZyrz+vg3ScDpcAN/8HESA+/ieUSPc/DPfSJHWKdgCMQsPleX+sifhuNz25zGCemJ/u
         6whfeOs1Z94/mslpEexnQwdH2zWOlITxiLc9Odx6AO3S7eiEWR65Mmih3FG8CdJPxMZL
         w453aoADmUFGLx/Y2cnRHwd4IHckPvJ+XFSYocQtyphC72XK86AzYJquhjXaNlJ3Bsgi
         icbA==
X-Forwarded-Encrypted: i=1; AKwUvByYk5z6tJCDsFndkfJ90rUMVwgNqogpMfNQi0MBDsOQKxFXHPulRRT1yZOsn7SEyK2z0RZbgHk=@vger.kernel.org
X-Gm-Message-State: AFuF++nftg6TNrvNHSfl8mh8yDKyxuhkOTzMJzYQBHjk8rzZxG2pl9RV
	H0UD3HHCA4JtGnlYFih9RxGUb2PdwbAKuBQkKjV+AVz1GvHfZevQhDC/s26q
X-Gm-Gg: AYBFou15fz6Hrk2LGN9eBWAx0/fh80EIeyI56uWd9xaZrp/V5ka1Zsyh21Pl1L6zv/N
	vIWfGywq9HFbTKNHmd1MwqckBzlvGeQCLcE0yvHPGCNYRyDWZMVKg0PMt/PwCpt25d9Etl+vEMQ
	dfx6RFt75D2APSdg++SliBXgkDdJw1tHDLKs/wKp3FuWztVtE0BjaXnDD3C/9M1yByMbW+7na2/
	E+ilGADnMW2bW6ftiFWjS0T/eFbvvgWannLMSDp6UV3By1BfK/r6McTSgGi4L7tA1JFxwhat8vD
	7zzn9liuqpzG3BU5mRGvLFondaDltT1qpOoF0mt66jVyCKKQIKvUbRvdM0pCS88uD+e3m1rsGna
	gRBQIRCPGankKzVHIPuG7i7A1Nai5krBuwt9Zl8dJ/FsRyVSUgRq5LdFi0k+FYy3D2eRyE5S8l/
	7cq8uKqqMDlncqHzNCPr7AHlLhYDHpTCooYWUcbzs=
X-Received: by 2002:a05:600c:3f12:b0:4a1:698d:3042 with SMTP id 5b1f17b1804b1-4a1803113d3mr44267585e9.6.1791389843053;
        Wed, 07 Oct 2026 09:17:23 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843aac98sm2685295e9.9.2026.10.07.09.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:17:22 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Po-Hao Huang <phhuang@realtek.com>,
	Chin-Yen Lee <timlee@realtek.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless v2 0/2] wifi: rtw89: fix IE length passed to cfg80211_find_ie()
Date: Wed,  7 Oct 2026 16:17:19 +0000
Message-ID: <20261007161721.261452-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Two callers of cfg80211_find_ie() in rtw89 pass skb->len as the IE
data length, but since ies points past the management frame header
and fixed fields, the correct length is skb->len minus the header
offset. This causes cfg80211_find_ie() to potentially read past the
IE data boundary.

Changes since v1:
  - Straightened the cfg80211_find_ie() call in wow.c to a single line
  - Removed unnecessary blank line in wow.c
  Both per Ping-Ke Shih review feedback.

Tristan Madani (2):
  wifi: rtw89: fix IE length passed to cfg80211_find_ie() in 6 GHz probe
  wifi: rtw89: fix IE length passed to cfg80211_find_ie() in WoW AKM

 drivers/net/wireless/realtek/rtw89/core.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/wow.c  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

--
2.47.3
