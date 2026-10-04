Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210833F5A8
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791085785; cv=none; b=aYoxL0c1Ya2nTMF6lgKlco4vuqdRnA6+tUUjwU4WOjTx6cLG0etULsdlBthXKgLF85kCtuU/xyh3nw/UCroXYounqiIN6PXxD2WwRsFIXDcBaSPuICjCiQcCgOuYvRLvR7H0Wvy8dW4/aj5XmXilH9iydcnahBYM3gx1Tu2WBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791085785; c=relaxed/simple;
	bh=/6I2hA6GsEXGdVEF6v+iLa+2A0Pts4hK73T0JGKi5Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5d55JdjwuwBksecpPuNW67aK0aKp3oQ4VloKjNNEQLGu0/uJ269JbTp2t7BBMFFU9PIPht7dNGYKcLCMP9HSpLSlRAXqjMwBFT7xMfGmiroL73Ubc7wQQ8ZEBmVoJ9iHWleQ3k/gFW5R1cfli2OElqzaykv8fgBosUF5Z4flLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kKOant5K; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kKOant5K"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33fb4680717so2001401eec.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 20:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791085783; x=1791690583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BlpNX7iexQd3fC/4/YWVoO3rXK3espdgEA9PSfX0GmU=;
        b=kKOant5KnjlUYfgAkJCGd+jAGiaAMyvFEpP+5pvF5UXlSlaAJYxu0IHrurrl+BC3gc
         TZfd29JoOrBsUl7lL96R3XVV1vZ3FqiOYpzB5i6Kg3SUJ9VztzMz2rcoNda+Bh/XHuVO
         buChzYYz+2PO/+eb65rCWMcgQibZSfbo7rtwm/9Y1tr42c1j2uBhGEOGPatSXN69q8L2
         g+gRNTy1WiENnWVA7ws4C5Vc4xG2KhSZGn4QzMxIY//3qiiuaFr7yjmNeThq1uvlDB4/
         QPr3w57xliA4UbGRQhIs55Ebu18lcrirXEBsQk2M9xmIilhZDTeRB9U4FEH20YSZHJOE
         ieIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791085783; x=1791690583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BlpNX7iexQd3fC/4/YWVoO3rXK3espdgEA9PSfX0GmU=;
        b=DPkI4lTG/eCU/u+7DVeO2Wc5gllmSmstdCKxoqbR2ydfzO/jiI7Vo34ijPI/jyGYSf
         5eBCkuN9fbtTnYY7W7wZvP9zNP5xI44dKkaWrIkL0In2M6U8WVLFEQ+1m+nYBVjIf/6l
         upnLHmXa8XkkZ5NCmA4WujI0XsvvQqlyG1jljQvPt5lTtU5l+XVsNEOjmucuUkdGAo+o
         USVlQDBzadDs8S1Ox22QHkC+70MWS1GvzcdaNtM1ZcFqYVOtUopEk/VvWjSyT7CN2fxc
         cflnyyklKYjGw/S5W3mlAorrdIewTe3qXLaHIng1eNuF+FOhEanA36hcKIysCjhWnlms
         7TvA==
X-Gm-Message-State: AFuF++kGXM6HZGxjIRs4Lwipz/Oavqia/enT+g/EhV/lfL7VhT7q00VI
	e8ocV8GGMys7jn4iDViLAtZEJmfn7ZeePw5urDZRHYhqmDq6ehd6G6QnOy28vJG9waLwc7r1Fuc
	ANvtoXFE=
X-Gm-Gg: AYBFou0akLeiqrqteWvutScpxK3nCKqw06pczYHHxBmd0zOsHndEnXIHurB3ktf7BBX
	qr52q0wceR++4f62wcfzAUezyG//sSSAjc08GIA+8jmL2bIUUmtc9l21fUOeLJ9Gr3y4EzRlLWK
	LqKObUZpUNy7jBtyXPHAqoyxaAq1S0HX2teqAzKmJ34Ca8AGf/m2nbGcxUa4cTkYF8V6bkP9FbG
	bqJR/P4DzYrN12wjsKuL6/1GQK3cBLtpfP4kuRAacL1NJtZ6+BgiKXNgmaT2hI0YTpRNDQWL+GR
	IQHJFNtnL0tkeRGjE6JosluYIdYgSTZ1mMh1fsmj8dx+7X8hUTpK6nhxtHz7BrZ5bSVcDHJuKCY
	q/R8kpJxtgzuysLIowQMAcdB/1L78mQAcekXOgxuWH5MmJ8K1ZvrQVm48aqiw+2667zeUZylEwQ
	rokUSDjwlxfQkvIvICwSCYDIIzvypYw0tZhRxNlx9RS9BV4kZLhQe64OTI0t5YGVLZvTYcXoomG
	OfGXvPM2VR5+sxkA0/23C8dezNYkhOCjxa1urX+ka9u2Pdavv/6YMXcC4Dx0Yyh/0JdYJY=
X-Received: by 2002:a05:7022:108b:b0:14d:c7ae:85e1 with SMTP id a92af1059eb24-151c3aa1f5emr5699377c88.21.1791085783128;
        Sat, 03 Oct 2026 20:49:43 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:a817:e330:2fc8:fa47])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a6cbsm10107071c88.5.2026.10.03.20.49.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 20:49:42 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Please consider these upstream CVE fixes for 6.1.y
Date: Sat,  3 Oct 2026 23:49:36 -0400
Message-ID: <20261004034937.70523-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and Sasha,

The seven commits below are in mainline but remain missing from Linux 6.1.188
and its current stable queue. The Linux CNA records mark 6.1.188 affected by
each CVE. I checked every newer supported stable branch independently; each
already contains the fix or is officially unaffected. I also checked the
current mainline history for effective reverts.

I cherry-picked this exact set, without changes and in the order shown, onto
Linux 6.1.188 plus stable-queue d0298d81c97e (tree aab7b6473661). The
cumulative x86_64 allmodconfig build with CONFIG_WERROR=y passed. 

Could you please queue these commits for 6.1.y?

  573601521277119f2e2ba5f28ae6e87fc594f4d4 (CVE-2024-38630)
    watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
  63b7af49496d0e32f7a748b6af3361ec138b1bd3 (CVE-2024-58096)
    wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode
  afd0f17ca46258cec3a5cc48b8df9327fe772490 (CVE-2026-53353)
    hsr: Remove WARN_ONCE() in hsr_addr_is_self().
  2a892294b83f541115c94b0bb637f39bef187657 (CVE-2026-80602)
    perf/x86/amd/lbr: Fix kernel address leakage
  c4ef5ba1131346159e31f4ef858525cf377380a6 (CVE-2026-80883)
    drm/tegra: gr2d/gr3d: Initialize address register map before HOST1X
      client is registered
  7e85f6dbc85616de2172bce8eaf84b387a723cd1 (CVE-2026-89860, 1/2)
    scsi: qla2xxx: Initialize NVMe abort_work once at submission
  06b5b2a5d499323f1c3256ead35798e8e3d15e60 (CVE-2026-89860, 2/2)
    scsi: qla2xxx: Fix NVMe abort reference leak on repeated abort

I used an LLM to compare the histories, review the vulnerable paths, and
prepare this request.

Assisted-by: LLM

Thanks,
Artem Dinaburg
Trail of Bits
