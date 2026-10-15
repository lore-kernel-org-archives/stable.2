Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508959574F
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096568; cv=none; b=jiGUOoRIkZH1RJkHuO7oo15lUHL7YsMIT2U+QC7ySf6b4WGFFKlP4nxqkjHIiExh+TPaS5btbkRYqBpvXeAI6ZN78oG+emXWy/TY99AD8RL04YgGTM0/h+gk1/cMeeipeA3LAVCheUjcOWdU8FC4fmJ9EITsrawp1RxUlGDDUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096568; c=relaxed/simple;
	bh=fJAIJMuzJlXMp+GWBJ+Z6kDPcsHz8ZNmrf0ByY3/yBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ww4z5wgc8Iso82dO1w6xbYMI2ErfV0Whh8WWNSBhq4uaN4ySe/wlstfs8WMXCXIl+YSIpXHJBFp3W90Wqx+z22yl0sN+RcSF8W/ku+WiJUchx89syrw3iiv0ambznuyPEUNVmblFwtlY6ATV4Qfey+zyNI0qdBu6Vw/+3NMAdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXpOkEa+; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXpOkEa+"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b83459526so52889766d6.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792096565; x=1792701365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJAIJMuzJlXMp+GWBJ+Z6kDPcsHz8ZNmrf0ByY3/yBI=;
        b=aXpOkEa+7eALWEOGtn/4O5gxOpgTm6Qw8lZCnJmtS1Ni/b7aCczEXDbWstV79+gBu8
         zXv6hN09g6wmu6boIgPgusPScdKu5cZHB53ZSn1vKfF8ZU00Bz4rczA6ngf5bmEQkO/O
         f6iQN6sJTY7L03gY7V+zTN3wJ//k/Ct/Uxnl8KirNR5JiSKzqyAdsVMP4kvhzk46MAYT
         JtMZFlPfHCk/nYQdt7QljpyFz+ovK9oYL4BMTTeXCcgrIYaQj84O1DuqfKyi0uHdTuQX
         BVY7XVCENP+P3faOU7Wm5eaxI+Hj4KbYuaT6mAIDYu9PaCoiLpYY74KVjcIMN+6Nssd0
         DzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096565; x=1792701365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJAIJMuzJlXMp+GWBJ+Z6kDPcsHz8ZNmrf0ByY3/yBI=;
        b=LjveQ1JsFjQ5eIvYmSbrmXYK2bcibPVN14DfQglGcDckV0BIU1H8qCo93d/j3C7u2t
         4ugfhwTvs3HzrFQc9CuBogQzY2L/PsFQNmoCXSdWPVA36kCUGXP1j2fyX3Okiiw4tJ7C
         pWsyhHXdb7+/n5mFLh6ENCnHEJOuZYYiviB7tPEqavBGs2nYkiBxIasrME2n60af3eQV
         0pFPzHhNDlF5cD1p+8F42vp6jiAFsLv8GmMQ839cwIf8uaIox1Xp0Dl18ggwwrd10fri
         wiwdXKKbpUsb8S0D1nVAqMlRO4fW83o85LRqcBqlpFO9Tkjdv/K9dyCbn0ujtC4wyPGN
         G1Tg==
X-Forwarded-Encrypted: i=1; AKwUvBxyAPUnVfbF0yrktb91eq/e2V4/MAid1oVuoRjmyGtyUQxAH5ybn9NBiE6O7fyRwLb6PuUiHDE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKX5QeYWhMIqbjy++98uFugGg/j74jbBmxYTQVOdRxxte3rhwZ2
	9O5GEPYSRCc9ObUcZA3mjABUPoFOe0y0P6EQZDTgAyS9VZms8T/eQJ1d
X-Gm-Gg: AYBFou12jKe8ns/1z4xxlC3TLS99eGPj1RoDayoLL32y/sdyeVJfDadlpAMvlg5j1Gd
	j7z5UwNDnBY7+ogT2yWfTpryTbnaYlFyAU2Z0vdsMTvXOAza4WG8Aqtn380W8HFFzjaFFXzEZKm
	1U7oW0NlGorHbg3yaxatW5yFFJeMCB2GWfguB3T8ifVbetFh7dYTOaxX3YDJ6PPsW62Ql3xHYag
	Qxrm3o6o87HXr4VJ622ZcaNiQsrqdpVOcV2eFpH7UKRt/fYdHU3Y51knFxPKpFpkpIL6UrlWZl2
	mWWkE0yyDoiME/nkXSc5l+tSjmjTfMKcCp9duU3QsDxtrp0Cu/8FIj9gICoU/dw54MTC43oq4ao
	ZA3a3zDdSi4qS4mdA2/g6wz/zZP6FexfiYr50wolf4fGFK16t6Kppr5aTAGl+WAQG/ZALi6hNjV
	NFFvY4GR3CVKbWGQTPfQxvcEPaCRKPeCTTe63wNEh2F16QBXsgKRL+deO9qgssdk/4qPn4b+a/d
	IRC9cTKvcf6U/RP7jBAbbZ74w==
X-Received: by 2002:ad4:5ca3:0:b0:91b:8afd:84e2 with SMTP id 6a1803df08f44-91b8afd8f30mr210166596d6.39.1792096564806;
        Thu, 15 Oct 2026 13:36:04 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba4b9f0sm4844456d6.10.2026.10.15.13.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:36:04 -0700 (PDT)
From: Dingisoul <dingiso.kernel@gmail.com>
To: joshua.crofts1@gmail.com
Cc: andy@kernel.org,
	dingiso.kernel@gmail.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on remove
Date: Thu, 15 Oct 2026 16:35:59 -0400
Message-Id: <20261015203559.2125485-1-dingiso.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015221818.09527ff6@systembl0wer>
References: <20261015221818.09527ff6@systembl0wer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

v2 looks correct -- mpu3050->trig/mpu3050->irq are now only ever set
together after iio_trigger_register() succeeds, so the unregister/
free_irq guards in the error path and mpu3050_common_remove() can
never fire on a trigger or IRQ that was never actually acquired.

Applied it, rebuilt, and reran my reproducer: the trigger now gets
properly unregistered on unbind, so the attack just gets -EINVAL
instead of a UAF. No KASAN report, no warnings.

Tested-by: Dingisoul <dingiso.kernel@gmail.com>

Best,
Dingisoul
