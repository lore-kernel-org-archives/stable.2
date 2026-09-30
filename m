Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE404D1787
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783947; cv=none; b=uGo3dOmmoV2hqjOozRE2S5tGA1m/Mp/pdXGwrKrCTafkw6O3kFS7PF2OhAzbKtJMB5QwcVf652WnD8rdi1sR3ifg1hQQrZIJneISy57D0KN8mLiVFLgCeK8E3urifeYsTxDCLfIACHwAJFZzpaVRtk5yN9C1JlDhauJ6sc7fld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783947; c=relaxed/simple;
	bh=fvsBMFcu3Leki1paprd4GO9igVhuE1WvRPncPexrkec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBDCTA9LoT4XjYhrWwqqocUz0xoRGPRZuwhENogE4iq7/SluXszgMc71UyYt2vWH3SyeyOKp6XhnDRG0PdzBDx9iKgnY/JAA8p2myVqYu0fJghUN1OaxwUDqhBABySSV3fs9Lj1kttZwfel2acUlvyvGw6TvlOGN9/nYffdGZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li+chHqJ; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li+chHqJ"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so3649641a34.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783942; x=1791388742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Izn5bAPBe1bZbR1JsJZ2Zid1xDZroTRIy3cYsqCZHmU=;
        b=Li+chHqJG+dTu0ff4+s8dZ9lcAJyMLq3PuEPJrzNJ0iBLYCRQda9hHJ6El+p2yMiv3
         ZPxEMa9lbxHSL4Jmvn01QaOLvCL/mJ1lfLzqR+ooZZPHC0YpNWEu/lr5joJTrxQAkM6w
         KbVLzZiG9detMAnU+2JFctEqSAYVfAdhuVAO+An7xeE7yrUWB/L71sKbPTy+VXccJA/v
         xZEDauwGtsH0BWsBmLYUnw63hbg9Mym7pJuRd0/6BC9ABqMITmnL7A2QSvzGgkfZUR6Y
         mXOfdiXjZO884k4/qx+JWxNOMCz/s1HTo3ymQZqMukCQbVrJSG+/rJki2KWm+oPlKnaQ
         3CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783942; x=1791388742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Izn5bAPBe1bZbR1JsJZ2Zid1xDZroTRIy3cYsqCZHmU=;
        b=YMoBSIqFSfqVIpQL/sti4GZ36pjRrhcqIDfp1ttpwK8QGp85m1b9EA73FEjARU9s7P
         dgkndusfzFdisp0KkZn+ZeABI0flbpn/IbayoqlW5+snPP/ANB+CED73WYy4BQlGyirY
         4DrinttD37zh/bnGKJBBgAlAceVBHXryKGXCkwMAxuqyPU59gN6I86daugpOWtxVP4c6
         McOtWP8Y9gWCW1Bm58gBlt9wKImJYWns2g+/BVT+YYfT7CWuhKp8tjdohAyUXngj/LMO
         SRSYFGewo/zwH8OJFpTv3tSECB62uko88xxhQKtTlXz4rermV7+qAnbN7XjEJoF/0EOQ
         RWmA==
X-Forwarded-Encrypted: i=1; AKwUvBzy9VXqcSKtKkPnZIHd+SLmjB+grKbNftcs9is2m22HZ9RplUu99EPa3ixpL9eXN9JmLVxKPjU=@vger.kernel.org
X-Gm-Message-State: AFuF++mmUblBHakTNg/G21KxmlRWjTE7v5XsJf2DGbZ8+2pHI+B/KJuI
	2naTkCNJESQx3+p31tqSdTTQWXJ5Vl8pGBgYw8AIO7DjY2ypn04zyiTG
X-Gm-Gg: AYBFou2vmFnWzictUdNEhtbDMyJdQeq4iJD4/nSV45Qrdy+fN66ASgHLneOkp+sd/l+
	bV/3Zbtax4qifu6RlhD/G6CTWqxQprF1n+Qf//syumcmVaENqlKfxwap4uuMh8HSx1vHl74p9H1
	T+blrl/xL8VGExd6XBjwz+8IVztBqEPjlXnhI5if5kTDgjtlzyy9boXsS1J0NNEMSFZiiVNJ2Mp
	HF/qIogdfJRvCVOc8UHSPi8WBIpu/QdsHEan92KOfsy/ChPugcvQYDQTVR56YnM1i7k0KumbCdL
	a8BTJJ77VySDPFGLZSHxK77YktNsA35bHy2EHsEWvarwZEktdwdj2ku9+w5CelDaJzQbz+37Lkd
	ah9Fo48cW8CKdDPS80HpDtw2YQ9NhqPvVKcgce1Voq+a014K0HyNX80kj0nW6pp2A3w6jY+fdGp
	1rIytuqDNKvb8I43NjrX8p/KKL5acYxM1QKJPmIE7GbFjjxGsI05IcxLZehYhOTNFoB/y6YTohP
	xy6IMTYTcgYL/ZC8Y6YZqAKKIKCM9e2tIgHlLs4
X-Received: by 2002:a4a:e914:0:b0:6b9:8413:89b8 with SMTP id 006d021491bc7-6dcf592ea93mr1794882eaf.57.1790783942229;
        Wed, 30 Sep 2026 08:59:02 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd982ed764sm332033eaf.11.2026.09.30.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:59:01 -0700 (PDT)
From: Danishk2445 <danishkhateeb03@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Danish Khateeb <danishkhateeb03@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Marco Elver <elver@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Luo Gengkun <luogengkun2@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Don't send SIGTRAP after exec removed the event
Date: Wed, 30 Sep 2026 10:59:00 -0500
Message-ID: <20260930155900.65984-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151610.GN88198@noisy.programming.kicks-ass.net>
References: <20260930144248.59858-1-danishkhateeb03@gmail.com> <20260930151610.GN88198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danish Khateeb <danishkhateeb03@gmail.com>

On Wed, Sep 30, 2026 at 05:16:10PM +0200, Peter Zijlstra wrote:
> Is this the same problem as this one?
>
>   https://patch.msgid.link/20260920075026.990582-1-luogengkun2@huawei.com

No. That one is an exec into a non-dumpable binary, where
perf_event_exit_task() sets TASK_TOMBSTONE and the WARN fires. This is
an ordinary exec: ctx->task doesn't change and the SIGTRAP kills the
new program. With Luo's patch on rc5 that still happens (567 of 2000
runs), with this one it doesn't, and Luo's WARN goes away too, since
perf_event_exit_task() sets every event to PERF_EVENT_STATE_EXIT.

Thanks
Danish
