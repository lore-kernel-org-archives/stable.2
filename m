Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FA14F70
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078460; cv=none; b=rB1u5ACm2nlJdDhVTnCX3/3ogAiMG/sW46gzS37uF2z9LSCHPsT38J3vqqeUnxmoKSvtwW8qT4/fFuJLnhdvLX0Mq+fxVgaaiCcIViW27TtYDvWCuguMxXZy02hzhSHf37Givbuxdq7NqX/hmMAT2xrORmqFAZqqWhBCxg0bGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078460; c=relaxed/simple;
	bh=YQFO4+tN0ij55N11GljdGaPyqlxxPgcRBQ2UVbyN8Po=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4AHI1MGfiR39LAkVUSTZxrlubainp995du+eK873GpCO1n9LsmAfYJjk2KZhz4VIsI0bpdvsCesKYt/L90VGuFuu2v1s45tddBuD4L/tJ29DjYvzvKZyiFfa8eI99QiR86yHAuJmZ+oGc4p7FIu7TCPl1GqlGS8BkldVLZbMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=XbTdVfsj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="XbTdVfsj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d7195706f1so24022355ad.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1788078458; x=1788683258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oAc7PD9CKcngrtLRqBe2l3ysucC3tQvC5xBBfhp7msQ=;
        b=XbTdVfsjxaYycbQYNbBVlCimA1y36tSDtdFXHhwt8g1uDJdLUHMG6QZUm4o783ck3h
         PT5AsXZwfeAggdVV/iAyoEzq1Ch3LikoLYMf0flV1FGXvVw/tIxdZ2pAqCGZqzbJbOjM
         cOhrZ0LQGcTiVtFc0mL5LlLxO7jNWE5B9utHd6il1HJyaQtWZonLKwt+RNqouOgxloUq
         foC2mhhjiNGT0iCdPGVOdRyQzN7ElDhm4IYHlqX8WsJGK4JuRf2QwJhy18utfeOpfH8H
         gknzm6ynVn49kbS8QXy9Q7cwbwxeHqU8WVaZkCBr3+7QBbDTGzUe132EdJfCBazrKz3b
         JUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788078458; x=1788683258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAc7PD9CKcngrtLRqBe2l3ysucC3tQvC5xBBfhp7msQ=;
        b=kcTBGrXtsJBk8smgy6s4jXwJT1XdLnXMJrI+JFGgFNfLtsGsLMvAZVgWOwGtkthyVi
         UIYVgwDIAg94oHcMg6UXWobWPRIQu9wuDWAB6LjtXlMhwRrmNVxSwOxXcpRyMH1MO/+k
         0MYLlEcFuIn09qh9drwtQ1NxuA1I94duW0cUgycjjBVe/k+qqxzEQ31VJaHbMjQNk+C2
         bps/6/Z0faSsTEpbDXJiarEG1q/WTB2tnd36b1Ky/DVslOg1w1bfzlWaAHivwRhpU0rg
         P+v0huU4pprWgIgyYWdFMh6FoBaehExc1/JWlZdN+oA7bXwmgburOYItqv09cU/S71KZ
         eRIg==
X-Gm-Message-State: AFuF++nA6kXsYn3sCTGoLQZIfRRwUEULb8rUWLQQEcswhUevMJbqVkbw
	fPVBAX8CegChOrsTHwZVCm+3HyR3uM0peY7FIx6fWrQt5kFTJs5P/6d5tUCvttRYzDluth6qZUk
	f6JLz
X-Gm-Gg: AYBFou33CVy5M86LyqfiCOShl1mkq+dTjonRDyxRR/CEkh8FBiakNKEFgRUHzDI6ghI
	4LjDNWGl81vjBxLRynL0u/ulxg1LRCwci5UOPD+rDGD2f+JJvguSebWlbFxA82UF+3jlj9lih46
	EXdkfPHiRPZliW93L2+2VOa2Z9RN7Ob6PDVpVgrmWdIO8b1Wcp+E8m6KtExUSHdIgBoN+qKf5Rm
	pJcXhW1xWxQ0UbjYH+mCqKJ8kfaQbsMyIPwAAEO+wzfe7JlE8Nr/ZWtbTMZSBmlsHnFp1bUcnL7
	dtha2nc+qmbpsN0lS/0948NzGvakNb/2HTJJq09GK/KlJiD6knLN2G4KhaNylo2TmG+FyJgacwQ
	QOmJPC+dPIm7CLvI1Vihf54bFWwuCo2aqtF8J8qUtmJCzRtP6NI1figvHXuhb3UgxxPWdDlLhYP
	ZilA2lbOAkeufOBL+wO9P8O/wZT7Hut6XvaHq/7EcxufsAasJRiXQ+OwghmzmwNUEdQoijwP60r
	B8lZtkhAhngo8fjJHh8PWJnymAocEvYZYRo7h2YiqFWuFBNxp5M/HLSpf/H
X-Received: by 2002:a17:903:350f:b0:2d6:d3f9:d394 with SMTP id d9443c01a7336-2d74ce2d81emr221022165ad.0.1788078458530;
        Sun, 30 Aug 2026 01:27:38 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:88da:a0f:ac8e:bea4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b4bc05416sm7254285eec.6.2026.08.30.01.27.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 01:27:37 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please consider these upstream CVE fixes for 6.6.y
Date: Sun, 30 Aug 2026 04:27:33 -0400
Message-ID: <20260830082733.35424-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

Thanks for carrying the earlier 6.1.y fixes into the newer trees. After
dropping them, these four mainline fixes remain absent from 6.6.y and its
current stable queue. Linux CNA records mark v6.6.155 affected for each
CVE. Every newer tree has the first three fixes. The last remains absent
from 6.12.y and 6.18.y.

I applied the current 6.6.y queue to v6.6.155, then cherry-picked this set
without changes. The x86_64 allmodconfig kernel and modules built without
warnings with WERROR enabled. The PowerPC target compiled cleanly after I
enabled the related config options. I did not runtime-test these fixes.

Could you please queue these commits for 6.6.y?

  0f022d32c3eca477fbf79a205243a6123ed0fe11 (CVE-2024-27010)
    net/sched: Fix mirred deadlock on device recursion
  d7f01649f4eaf1878472d3d3f480ae1e50d98f6c (CVE-2024-39478)
    crypto: starfive - Do not free stack buffer
  d48e1dea3931de64c26717adc2b89743c7ab6594 (CVE-2024-50225)
    btrfs: fix error propagation of split bios
  dbc30a57bd8e026995e9fa8e8c31cffd18542c01 (CVE-2026-64070)
    powerpc/hv-gpci: fix preempt count leak in sysfs show paths

I used Codex to compare the histories and run the builds. I checked the
final list against vulns.git, the branch history, and stable-queue.

Assisted-by: Codex:GPT-5.6

Thanks,
Artem Dinaburg
Trail of Bits

