Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1039021D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230957; cv=none; b=KcAEXMgv61i9r1DeNA0UKlOI0BjS6gZSGTkxEj161Jgu/iaZkHdUrIqAkrv9mRrOIP4/EZ1gLc2IkSIXojo9/F2AcMh4ojbJc95Ae60lz98cEg+ZaUmg/MhztdD6i+FKPIuKQNQSVumUIG2XrrHbuVyOJcfYzxlODy0RWgHCrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230957; c=relaxed/simple;
	bh=G9mLZBrLnKkyNVbJd/6ZRMHwNYDE8384JlGwu/ljfxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1gbTvu0tO+0Re659TI4A6+oabVJf8Sm8LuKg8BbzBNBl3hHA2P/nF0/h5Io8OfqROM6Xzz/C02zDH5Cz7YTB6e6f0osLio6pgfyOIcPAA/9Zdq2EPrYETQei78vEplp2x7/WA/VygXF19x2TfwvzwHJXK2ds8djaBwaaHZ7qo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SCKYXnUs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="SCKYXnUs"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d712281f8bso48030835ad.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1788230953; x=1788835753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2Hqf2F4NTDgzpStKXo9pnpHlL+P2uB38kU58D+VtiM=;
        b=SCKYXnUszYDjGQY4xFRKP/SO5be/WQfomuAbyzURWtQXa4N9nueuUMLvd0xfh3zSxt
         qFWYqG4xm8wD4Ho0IMUmZm6oY9OsmHR5mFHnKQyiqERwlXFF18cVqNIs+otbGFQcd7fi
         fddDKtU2Lj962+XN88nlqZvCzVQzI/y1VsdMdBkGZImxGOZ7jfiDzJagahGsoQ17op2S
         ZPxXZAQg5Q74weMGoK2ElpVGO4pu9LbcSMLJh+gunHMctbz7u9I9i1PXa+/jADm+htN6
         Rr0ar0oc43irYWV3isV4jIlWdDIcQgHsIQ29RuxiFwlR/zxi6Pf842F0oD5OTKFUCnTh
         5zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788230953; x=1788835753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V2Hqf2F4NTDgzpStKXo9pnpHlL+P2uB38kU58D+VtiM=;
        b=VG0ucRibNfKYC+beThztjQEXDl7KGwlQuMtFtPFMku2lsUVxkfeDiPUFtaVGBVHyi7
         MsEagMwjX35YyHPYeC38qaSQhwRToVbDgwJNEax5cdwIZ6++q5F06sKwdgX9UuW7l195
         rPvv2o/PJo39hWvln5qJiy+CsBE7gQk1CJhJ3AzRS2trgHzFPzc806eANk3ArcjK58w1
         xvj7kaj7PsV6hytH35R2wCYhLiH3wxhHSaA1drT6avpTVHa505yarVSkDfcRMB0W5GhD
         c9nDOGPozmGJtP8zeNjzpMHMZCbcHy6ofA/JdeX3XjjJb6gsstd0jcN/d3eA84lYYVSB
         xrIA==
X-Gm-Message-State: AFuF++m88t+CfF0CmmZpK0a0sHYOcdToGpo3Ph86uC+kyE7O4tuyu2CA
	YTWWJDVsyqfd4IjdxWP1zJG0JOaUM02ZC5mXnk/aUBD+neEUQNT3wTxa2O6get6woq5HNNyH7h5
	PVlp3
X-Gm-Gg: AR+sD109N4g5BsdT/Ohk7E5c05sM0p95/RQdcmFZyZIwClaMgRalxi6raOl2Twow+51
	W2fSK4CSRWfRinUO3gJZkiMP2xGuRYBgyFj10ANpySS43sejINyZsY+89w1oHJTkJq+enzx3fUU
	H56UeJqTpUwwQEqn7kxi+6kRExV31u67Om+mIre2HK35OzOgL7FMVut/OyzCExhEhFkZqmGhvqa
	Gjy6IaynF+yfLNPu2gGyp4hDJv0uG0rZpkm6d2Fk4S9+rdg87f95iO9vuJh3BKjcycxDPjKBPMw
	vLQ8YhxBuJ2JgQR+umeteg/7adWFcT+adc0EFQTHoTFiNrk1sWbRxgamEBYjyN1xkZt/Sd9jZlS
	sOzCZjY2NUmPX2aWjU3DlThVCirzV/jrt+zQVINrNnasMuBgKt2UbBEhrxAFZuZ7xKiu3diwP1H
	dJ9A5s69iql/Cg6jOHcThigjAPLwp1V35t2GD6mQAunZcZ9LrSoQ2p5DPV3S3M+/GD0W5WegHCP
	8wdiPcQDd6FwWXQYLbXs5fr98XfWMB61uqaia9bUeMpFMaEakiIS3VpKjGeAQ==
X-Received: by 2002:a17:903:3845:b0:2cf:4339:aaa with SMTP id d9443c01a7336-2d94a8d4c2fmr64687295ad.12.1788230952670;
        Mon, 31 Aug 2026 19:49:12 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:1046:e64e:f2c5:7ce8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm26282078eec.4.2026.08.31.19.49.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 19:49:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please consider these upstream CVE fixes for 6.18.y
Date: Mon, 31 Aug 2026 22:49:07 -0400
Message-ID: <20260901024907.61883-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

Thanks for queueing the earlier fixes across the affected trees. My 6.12.y
request covers the three fixes shared by 6.12.y and 6.18.y, leaving these six
mainline CVE fixes still missing from 6.18.y. Linux CNA affected-version ranges
include v6.18.48 for each. Every newer supported stable tree already has them.

I applied the current 6.18.y queue to v6.18.48, then cherry-picked this exact
set without changes. The x86_64 allmodconfig kernel and modules built without
warnings with WERROR enabled. The affected 32-bit tunnel code also compiled
without warnings with the relevant options enabled. I did not runtime-test
these fixes.

Could you please queue these six commits for 6.18.y?

  8431c602f551549f082bbfa67f3003f2d8e3e132 (CVE-2026-23459)
    ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS
  179ee84a89114b854ac2dd1d293633a7f6c8dac1 (CVE-2026-43009)
    bpf: Fix incorrect pruning due to atomic fetch precision tracking
  d2324a9317f00013facb0ba00b00440e19d2af5e (CVE-2026-43391)
    nsfs: tighten permission checks for handle opening
  4ae3e16f4b3bf64140f773629b765d605ee079a9 (CVE-2026-53313)
    drm/amd/display: Avoid NULL dereference in dc_dmub_srv error paths
  0c3887a134f191723b53e2a47e501b534c8723ee (CVE-2026-63839)
    platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
  cce18c263e9623872327ba3c956012f73c1179cc (CVE-2026-64068)
    netfs: Fix missing locking around retry adding new subreqs

I used Codex to compare the histories and run the builds. I checked the
final list against vulns.git and the branch history.

Assisted-by: Codex:GPT-5.6

Thanks,
Artem Dinaburg
Trail of Bits
