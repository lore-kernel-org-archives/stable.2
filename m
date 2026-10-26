Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053917;
	b=s+I4KBuKFYFIe8HIItyOMK7yMctTFK3hsndOoS3/Qa0rWKcqQx3b5Ey9bASVoOypnQKm
	 veyPlxIgIzBkakDEApZx3cyh+4v136s3AjkPhSWM54lcKpKcIaH9D+A14LqlfZhecQ5tR
	 2HBOt0zGf2YHzJeAwJdWz2Lyg/tei1NzayuGve0jvfKhBcZdU0ibOWXkqEbX5qz8kY0fX
	 7h6+Tb1UDNgKfnhZDqsMzZy7ZNeilptgaZABVd0Su2rCIjP7II7n+04ittpgTVAM7b9/L
	 Fka28Hifx48zawtAiuByWBWS9Y94xKG55Ax0v9dByY4lbOq0SPqIYstW/PifQXVKFdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i66KXUTXEbPZ+43dRja9tAwpUa6R3X+N03pd/C5xTMU=;
	b=Mvd0vxEz7SyWnkTtPi1R4CrIDB2czyXASh2HQWy+mFvoskVsV3tOEETQ3yMfA5HKEIm5
	 eZI6vtd5ILJZpKODZfqHR2nXw3/Kh4MvtrWo1E3a3O6azfCptqItsGzh2wjMHf1rBFIcV
	 4nRM1g0RFo/cLrtDEZ834ATcQ01Opqgm4WmrEhN+zCmSyHuPyzdg08M0YmIERD8vYo18Z
	 AC6j7mhO12+ipkP2K4xi1VOr0mhqFZUvjIYDYGK56Fj/eUvVEM2GOz5YazA6dM+0ZwaG/
	 xbzwhbDlfVvZLF5Xn/aBasjNoraJjqxSLMaQeTs+Pe3FIvQoMORYGXWJxtV1c+HK3Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d0xMsaaB;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010A606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2010A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d0xMsaaB
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso17329325e9.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793053915; x=1793658715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i66KXUTXEbPZ+43dRja9tAwpUa6R3X+N03pd/C5xTMU=;
        b=d0xMsaaB4WGjhMGrkqJN3tX6vRJtYGRSPRYoGoe7IZO7UV4g1DmJdKOBC8MC0hTe9b
         M3dc8+Z6enUQtR4ba2NqVaQYFK+jToBuneUNHPAWzRyjufMRUUn7X8OAuPFaMViZacY5
         tGEeiCjn4N/mOuI8HmFE8f6psJFG15ukXejnByOU+7as89+1MJyIkdg8wVNmO/fkqaC+
         wMbr55l9WYeD5beBpoGhc+H5K6r22JrkwutGP69iz2rfdCfDuSors96/KLnr6vzWKuE2
         0dhNi2/o8cgV2Lyzyv5DWV3FwPeiIPdjANz9T/0C6n8lR2IHxr/u4l3wn57uy2rUtA5y
         9m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793053915; x=1793658715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i66KXUTXEbPZ+43dRja9tAwpUa6R3X+N03pd/C5xTMU=;
        b=g9tTo5YHSbbzIHzvIGs7zNaUAqLMo8DdqnF3y1Lmvbp7nWHlH3k8gzVi4bKzD27jEL
         /n7T54eegQAgk/z+sTU2dBboBsUe7nL3fEU1YyRjMBKFU1cpzG9XOeqyBZklal3LadKR
         6fNfIi9amvzAxcSkHg4t9VtTDh74DkwFa1SbWnSeNg0EDWpid0MzJPiAW55noeqdR/KH
         jzaoaqePn+aWDCBv5T51b+z0/PxDPMyv9jgCr6CIXsqV27sI9JQNi/xCw4pWFaorRe4C
         5gBM45YJHlfgdkgO+HULZKkfUEiy2+q4DcawbEJGlJqItKToLS0YqseLyCwX0GqZBBeM
         UHvg==
X-Forwarded-Encrypted: i=1; AKwUvBzqoufHThQTgzQYfvYindHZx0audwGnL1aaBDOrA3jROYCxhmFdkr6rK87uR4kf17f2P6JSVZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMwAJja5cboVb1xgYhqwhbO0hnYFAfVCR6okd7kMdEpR56EezJ
	6jQGNLAIfDljqX1bjwNCIMakOY2LrezXQukRBQv2cHrwI6BPpzWlhWg9FGMN
X-Gm-Gg: AYBFou0eJE6y01Lpqzz16QysWcRxi5EV9+Td9guN0/aO0hkMtt34KJXpcdiRUnWr78F
	oaMOK4w0w43yo4lBpiraUezjnnevKw1vAoRdHXpHJ0ZlgA98EhAxwra+djyiWzGHyLSn9TOJNTl
	oe8ZzJayBJjpJgzSFhRXeKiGqUIzIvGtmQBTlQN8p4yAdJvhds9DofQgLSCjf7NwMHgyG8xl9W2
	fJ5WF7EcXHAtN8kUHuk6xUDL/A5vkNFfHXsptZWejuMXZYR8RV+KwGVnzgh+NqlDuJcyUDghOnJ
	2FgN4+whRHjMdGQOVFoymBe4Xbf/HSUux74a7HDH4jq1Bq0HcX7ySkim2Vijwq9zCczywfspXxp
	AQh41n6ACJnFwUTDUXO8LE2FtWCgbKSg/n8jtkW7qYe2OVbMWGVc2IgIOpGPEguFBHhehPGMdJO
	w0s3glvcuPbqQI3jGyKYbW8ekqRLSrEsRAs6keS6xj46aX62zgdzlHS3BNFQtMcQhEES7dHV9Gg
	NYp5ai/C74CzuXTdFsgVBc8AFxjc+q9F7zlpA==
X-Received: by 2002:a05:600c:a00c:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4a35acd56d8mr145273565e9.24.1793053915397;
        Mon, 26 Oct 2026 15:31:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ae28sm229743655e9.2.2026.10.26.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:31:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ivo van Doorn <ivdoorn@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v2 wireless 0/3] wifi: replace open-coded IE searches with cfg80211_find_ie()
Date: Mon, 26 Oct 2026 22:31:52 +0000
Message-ID: <20261026223153.2087218-1-tristan@talencesecurity.com>
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

Three wireless drivers (carl9170, rt2x00, p54) each hand-roll their own
TIM IE search function.  Replace them with cfg80211_find_ie(), which
already provides a correct and well-tested IE search.

Changes in v2:
  - Replace the entire open-coded functions with cfg80211_find_ie()
    instead of only tightening the loop condition, per Johannes Berg.
  - Add pre-subtraction length guards in p54 to prevent unsigned
    underflow on truncated beacon frames.

Tristan Madani (3):
  wifi: carl9170: replace open-coded IE search with cfg80211_find_ie()
  wifi: rt2x00: replace open-coded IE search with cfg80211_find_ie()
  wifi: p54: replace open-coded IE search with cfg80211_find_ie()

 drivers/net/wireless/ath/carl9170/rx.c        | 27 ++++-------------
 drivers/net/wireless/intersil/p54/lmac.h      |  3 --
 drivers/net/wireless/intersil/p54/main.c      | 30 +++++--------------
 drivers/net/wireless/intersil/p54/txrx.c      | 12 ++++++--
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    | 30 +++++--------------
 5 files changed, 29 insertions(+), 73 deletions(-)

-- 
2.47.3

