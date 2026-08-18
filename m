Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B103A7F41
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080309; cv=none; b=OMBfKJk8QnofRoG7B95IKVzK3ldL4RO94f7Hf56HKCMVjyvJCVq+fQyeSOZ45b1REzLgytRtHVW/qMHdu7DY9ehhat2/ROQgyN13ILGdq9f9ry+MxnNWMFHbOJD4AOge1HmNhXecosK14sBcEQT0OIUHtXc1qrJ7hJyzxwtDfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080309; c=relaxed/simple;
	bh=ule8uQVSZjN9SPPiWy3GFwV3RocTGH0iwCj1Srick0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OWV6Z64nnZkDrXHbTW28pf+gb/QC6V7GVhlfeY6lyDzwT9OKpO1geUnizccdmrZ6WcJQ2/69fb9zM8n0HkbO8kuQa1fz7zhPV0sj/eZfNTNj/KCA1GhEO7HD73GNp03LfFo0Nf5k1SlnGthzK34X7moCkTad6YR/GujaXSmudUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myKX29Bg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myKX29Bg"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a378f90555so351167a12.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787080306; x=1787685106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NBjTtOnXKHIl2x358G0aMOpF37tP5HHwZIxgH1uzThI=;
        b=myKX29BgKbqeVFArR+Ck0DDhnzsEzl1tfEvey3CzFrZywS1/GfaK9yFm/zGe96r+9p
         t/vMmEHON2LD8uUWU+Nb2zFUHMzDVvQc5C/ibjuK1z/mu9Wguu+xxLm2kut4LMom7rqN
         wcquF2lLNNG8IS+H0/5U9KFraOq1ugqvMoNLyeKldt4EvKD8yepmYYsxomGq553N+scx
         cq9pVhwoyqse82YDlKoTRbvU1x9wQRCKPfZ6/OwE1gRLgmOke051IBehv+SIc2W+C0MY
         jFZSh75w6eTJcL95GVRvHO5k+W7E0SuCDmS2wfmmNHs7kJB7IQcBcI3bA8/YOsHYuqHC
         Wtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080306; x=1787685106;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NBjTtOnXKHIl2x358G0aMOpF37tP5HHwZIxgH1uzThI=;
        b=CnAvoWHV98qE5muD9GR54CGCDbxEICOaju9ec/7we+ow2GZQswbHho2Bg6WB7y3fvz
         yom748vFfp1YUEElzPO6TLJx3GkcXWPtlzufRCW4kfLOSnbqVN5xdZwrY3L+dQ6LFCs+
         Cgr5jhlw8cMJ8VbhidOtDiugu029dk5CG0+9cL6jEGl5XXTC3GPSh0q06PX1kEpFjIx6
         lpEkwEIbn2Ucy/WtDL05dAICl0OlHy9yVbMGC9nIxm0hIvt0+VQFtn+ag3nCtq7IqZYU
         EZZ/6Pb590VXbBkr+06R3k1o76tHNbMF/92jTLjCLzTuKDN4DMtcQsjpfgZpYFxSmia7
         w9Ig==
X-Forwarded-Encrypted: i=1; AHgh+Rq5JpDt3RYDCsds+MWV/mMzh2rQTAAfDMFAUdnDfGkQuuZ+0F+IIfPz4j8nvxTBS+vMBZ0koYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoN69QahE71DldDRiGU/nb3Q4Blrow3OLeWxtI4aOWB2sgjEu
	/q5dCfPT78sErD4/xCo2qOw0OEIwZtLx+vIUF73HU2FIF2Ea8/egLnXpUhvg3oM2H6OyIA==
X-Gm-Gg: AR+sD11jm6e33Ky0TJlzUQM/ooijTCO1RHPZHU7CPiF1CGOciIUu3wdmPqOBAxEcbqe
	FsWIWxzPQf190N1P6yfLTFKU6BQI93mHKNy7MyXTADaJ7DOXIcRU1CHZ93OjWvAK5sTyd/Z8kGP
	5Yd8/yPxKb0ukGxrpNPwR8h/GAjA4pfE6kuhAFlbVT9pRUlXmK4aeU0dF53JKeTmrJSMCkbNYKv
	mu96ODVuOOHe5elzpc8ETDw1H93vwIYolLBfZKLuJPs92N3/RselmjhmXGgX8X51qQLqbN58Sdp
	+JFF/hYqrNQXJtWEUq2J+fkKe3l8kapHLf4V/GwQ/jpdNLnmGh9K/QQOvxKuB40mVzgYMtTEcEE
	rr4hKGvZBu1ilUcoAwGdgrD4dZT80tYaFrZjB3d5qjnbyvGYCd620Kf54tdLKqfS3i+6ScoF8fW
	otWtbuYsD81b0cenR7ubVbdL+1X29MDuUGNmcFsq4Xj49nMle4ssaFaejm7iKg37XszM6MavtPU
	WShRgx5GP6bQUPFU8Uu2g==
X-Received: by 2002:a05:6402:2310:b0:6a0:a644:355e with SMTP id 4fb4d7f45d1cf-6a3fb7191c9mr119441a12.2.1787080306275;
        Tue, 18 Aug 2026 12:11:46 -0700 (PDT)
Received: from fedora ([2a00:7c80:0:3b5::11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8531694sm2291552a12.11.2026.08.18.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:11:45 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3 0/2] platform/x86: hp-bioscfg: fix empty auth token overflow and clean up audit log loop
Date: Wed, 19 Aug 2026 00:11:06 +0500
Message-ID: <20260818191120.38556-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

This is v3 for the remaining two patches (patches 4 and 5) from the v2
series [2], addressing your review feedback:

- Patch 1/2 (was patch 4 in v2): Remove the special-case "if (!authlen)"
  return entirely in hp_calculate_security_buffer(). The generic
  calculation already naturally yields 20 bytes for empty strings,
  eliminating duplicate logic and fixing the 16-byte heap overflow
  (reported earlier by Josh Snyder [3]).

- Patch 2/2 (was patch 5 in v2): Remove the dead inner bounds check in
  audit_log_entries_show() since "count * LOG_ENTRY_SIZE > PAGE_SIZE" is
  already checked prior to entering the loop, and clean up the redundant
  "else" block after "break".

Changes in v3:
  - Patch 1/2: Remove the "if (!authlen)" check completely instead of
    adjusting the formula, avoiding code duplication as suggested by
    Ilpo Järvinen.
  - Patch 2/2: Remove the dead loop check and the redundant else block
    instead of adjusting loop boundary math.

Changes in v2:
  - Squashed v1 patches 9-13 into a single patch (applied in
    review-ilpo-next).

Link: https://lore.kernel.org/r/20260803143037.93105-1-meatuni001@gmail.com [1]
Link: https://lore.kernel.org/r/20260812111829.172273-1-meatuni001@gmail.com [2]
Link: https://lore.kernel.org/r/20260402-hp-bioscfg-overflow-v1-1-6985f8c9e67c@code406.com [3]

Muhammad Bilal (2):
  platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth
    token
  platform/x86: hp-bioscfg: remove dead bounds check in
    audit_log_entries_show

 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c    | 4 ----
 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c | 9 +++------
 2 files changed, 3 insertions(+), 10 deletions(-)

-- 
2.43.0
