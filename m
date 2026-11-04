Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816554;
	b=w8HXfRdfVvwMt+TbLa88XsHUi4EgeQ0iBc59K0XtWzFmfm3dC4IAuJpFKtxA+2g7dLBb
	 i/+FIqoxgQ8Jd1XOpU62hbjjoW8739ce5HvBIKOGCcoROKMlpY1jBy79/XndRrLU4LUtE
	 7jxa3r+fbumbu/g5dYWizy5fEwp8unwhlADX5lhJaCsudY8IwdLjpuR7O8sqp6owKPdC2
	 8LfnEgl8BdHbTAFP99ZuhmOm3hyLSXR57cjuHQlV80AIe8/vwJWLg7ZXtekMjybJYHAB+
	 s4IjbqsWP84ieHiSbanqNRhYcNgaojWZC6sDWt0BC4R8Es4a8at7lltFnVWanAKPF3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816554;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4SFsR7xWeUl+BS10OP7lmYGGvnyf9dQ61bFNjp0KTLQ=;
	b=pMQ7LeQM+4VNwY7JbewUe1uQTTt9dMODtYiG6uKfC4qv8AsfQKM93ZPYKgvd8/BYNpe/
	 ayQBP1b/s3SxWiG7ugBW76N9Puu+rgVDkkJzB+ZyDjCpklgwOwFG2lrsYpeEtxJFhSUH+
	 WHfWhjowxCPrRd+N6QpIKefYsF8T/WTNuId+KI/FJTGCAt3TgWIjw2klY1mBkpzEGMCB5
	 +wiOuwvDE0bo1fdlWZnVwlcmUBPAi4FZgo0AIoW0Jqte3WmdJx0zDZUjnXWAbPRqwx070
	 CYjXFhFPZgcOvWVMBLR1AZCeTzZlvcTI8cwSUOq0Y8gEUH8+H2J8BSkSJOywFP/Kxqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pnsh+QIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC06083619;
	Wed,  4 Nov 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pnsh+QIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560CD1F000C1;
	Wed,  4 Nov 2026 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816554;
	bh=4SFsR7xWeUl+BS10OP7lmYGGvnyf9dQ61bFNjp0KTLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pnsh+QIA3AjWopkFFSmh/+shes8gsW77uJOZjnahBg3sVh4pWXNaD4XyTC7hKBJpn
	 GszIGlIp7ZtHco8UnVo+41oGJclvr6dE+2rsLoltOEWuNTkfR9x4gHBSzd5njLCKfu
	 N1O5JCdsaA+qNImTr3sKKmJ1Q4NYFXzdZqZI9aboWeDiwzzC8oeswc+gxXgZBzg7N5
	 M8mwhveUqqjX4r07PPnqhx/IzD5CaRdHsJxUQDzt6yu+cJDgw50qReZDReDlUtGJoL
	 ih1nK+/CYG0K/YelxBp0dXkUB36Q1jWUybSGbsFxCWKb7nUjKSLEkGn24f86X11tSJ
	 cKCiitK3Enayw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] regulator: core: Use ktime_get_boottime() in set_machine_constraints()
Date: Wed,  4 Nov 2026 18:20:56 +0000
Message-ID: <20261104182148.1176116-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
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

rdev->last_off is tracked against CLOCK_BOOTTIME in both
_regulator_do_enable() and _regulator_do_disable(), whereas
set_machine_constraints() initialises rdev->last_off using ktime_get()
(CLOCK_MONOTONIC).  If the system suspends before a regulator with
off_on_delay is enabled, comparing a CLOCK_BOOTTIME timestamp against a
CLOCK_MONOTONIC timestamp produces an incorrect elapsed off-time.

Use ktime_get_boottime() in set_machine_constraints() so rdev->last_off
uses the same clock base everywhere.

Fixes: 691c1fcda535 ("regulator: core: Shorten off-on-delay-us for always-on/boot-on by time since booted")
Closes: https://sashiko.dev/#/bug/linux-4afd38c3-0589-4544-961d-4e3cc5ed8639
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6d522731e4d9..6b5fae3cd486 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1698,7 +1698,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		if (rdev->constraints->always_on)
 			rdev->use_count++;
 	} else if (rdev->desc->off_on_delay) {
-		rdev->last_off = ktime_get();
+		rdev->last_off = ktime_get_boottime();
 	}
 
 	if (!rdev->constraints->pw_budget_mW)
-- 
2.56.0.385.gac671c819a-goog

