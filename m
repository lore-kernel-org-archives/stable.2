Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809655;
	b=XGJofJN3/K0+rNgq1ZzSKXeHG+k3qhgzbkR02yr1BJo0ZZnbHgRLJpMoptZkw47FsPFc
	 tLAinq9QBdDxwyDpDs8KVal9LH9kTVAGTvyEyEqCPYTC2OGaEEZI7hd9+mammsmxCbIcz
	 mDlDXz260oZe4IwHh7Yu6DiCl1c4zBmSjz21JCkTllOOj+LTY9ThhblpBif2QyOrLog1P
	 W8Cd2/0McYgvuTS88EauE7rnwjAwPgYYMAm3eFjy0g6p1H0Yvs3wzudO68n6DtnTNojXQ
	 3tvPcEyZ//CruecEr1y/AQwpbG5JEjwWysgI+XuLG/e9IF3szBfLmo7rhaHMZgP/LPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CZm8Y69A5prDDQwZ1SdEfnAEhHWyrujiSq8M4aAwjB0=;
	b=4/5+ECfIJnnI8g693t1oVhF0rHQPG7g63PLVAEc80boKHuueqhigWbv8pWyhAS9gRBlK
	 dEY1I9ls6zKaU/FMIukOHzEXM+bjbhW21LYARRKLg861kd1Igaqi+A2XxnJ7AXI7SGOPk
	 ifStZ6sAS3DjXI85Gw7N7Gic5NCA6fYeyDPgtd/6FMOLPmdJAJuodSAfvTPbBb2bTqFz1
	 yIIQ/0lhcpV9sqYS/RTN07lH5WFyuQiOGjop0cxsPMAZwa4k0tdKCwyS2Li8aAJe/vHn0
	 mBYqmYf9U6TX1Ijr9HmA6n0yU8iyqqktKZO0h/oReAx8LAvrDrkSledpWDntg/EWlBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AcohlYTS;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B616606A31E
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B616606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AcohlYTS
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ba8fcc684so14665146d6.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792809654; x=1793414454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CZm8Y69A5prDDQwZ1SdEfnAEhHWyrujiSq8M4aAwjB0=;
        b=AcohlYTSJMZq+GAAY76u6+mVcRlzqGY9BQkfT6KfgzGu9tLA2/wuHyDW6/dh9oFneb
         34MnawYX5F2Zdv/9zHmkLmUsvPJ4084FqYqxNr/oHLc92Q/udQxfdoQpaBJt8RIW6LWv
         u0Jfd16viYrEUpw3wEfpqbndY7fl5/z6UZURZVtB3d28h7PwXAe84DKLIFgNZQZhkUaf
         Dq4LkyvcYNRaV11ykFfCHHBinmWZXGEKK4F9JlJjewB1YfckPufGRWkQN0Lgt+cQMUpv
         V0F/YouaEMOtu0ZJiMtP0Nty1XFdxctkGQSDNz8JhPj8SzvwX36x6LSdF0+dql7dBdir
         +cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792809654; x=1793414454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZm8Y69A5prDDQwZ1SdEfnAEhHWyrujiSq8M4aAwjB0=;
        b=DSg5v6sU1e6Qq5KIskxJwCNZCyv4mXljqvH3KbM07v+hO1nAoKpz9dUNGKmFE8bsJo
         vFlXgMdZtTmJNioSb6OrWbZ6WXFYwgaUTawMq6f+jTe3zF4haGXQmMylJXeSYQBsc9lQ
         CFESJO35SnFxb/whdKtm5E/e/qzCyuA0aPWb5k6eNu6fK3BOAadv8ldX+FQLkgF3zpg9
         M/bJ3I8LVlMAJd1LRxevo7auRxKGCtchl66tzQqMeOE4YWVamvp5dJVXjv25vhyxSqnY
         8zkk5EAjjicO33CnY7z877/vjrBBMdwpRh6k7SEj086/7crYwWPvz6UiLy+slOvrknpo
         XwQQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8T8Lk0dxxd1ZLSB3jqt3qgwn2g23tt/wO9tztiCPMy4ipKjhH+d5WEiVzAFHxQnHe4610Z1w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9VNXJ1OaaN7C+66JG8GGnoP/oQ02gmX3BLofJ+Durz4AHXrKz
	Pd1qM53N2qGR0wa6ko2T9z/9GeBj81rqpyd6YtH5M91DdpLB0mxSelQ=
X-Gm-Gg: AYBFou0hIBV76TKBkF1wVm+wmFV628pviYo5CykAWfksHdVpPqvi/E42wVV6TVKZe4b
	l33FzlWYadtYM5pWQ/vFimrdse5t1yPWBZXALFtZQIjCYK7s4zxf5ocZkIvhF5TL+ahwrfBnKPR
	dX0i9PpALcW/XhYnGBhIJHBYuEncAMj242XbG+f6ozVgNkRX2ac9my6MVDd4bwbjcJ0jSWSx305
	x48HUioNxxo2U/gUlXgOHvY885e48LqZJfxO09A5AKQC4j+OJIBKpIXIDhCft8KYB9luPSBj0DN
	axFI2NdEUYI2a+rHo5yWSO49GOVkI3kAF5d90ppq5MI7NVPJv/MfrUgxHw6kugL3q4uclOMqCjD
	S7B2F6KKwkm8YYha+QCPhdz3lu7p0FHSpMsZVlD4uhtIcSNMS1IIVyEG4vCdCFUdYAPtupabn2T
	u7x2CqkKh5PE2I7Q/xhinA7HUU2mx3UcjsnRepSlghPmSOgoU1muyKm+Bx3utnbNFO6Tg2Cx8wU
	jfk9Yew+cnf1tFDq4//5G7na61mqmA+FlYQFJNEgrwkmI5kLiW3PKAhmnB9flSk9HzDZrTt9qEL
	HKKF3pxvoSHXHIZyb7nca0y+gSmwYnZnfMS+48gNuLu9aID1ImVoF7gjgNPj9L8ctlG8+hKsVbY
	jFGOFp3nrTg==
X-Received: by 2002:a05:6214:5001:b0:91b:b0ca:9f8 with SMTP id 6a1803df08f44-91c48e57971mr14566376d6.26.1792809654071;
        Fri, 23 Oct 2026 19:40:54 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c48feca9bsm7203526d6.39.2026.10.23.19.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 19:40:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v5 0/2] media: venus: fix HFI teardown races
Date: Fri, 23 Oct 2026 22:40:49 -0400
Message-ID: <20261023223635.3c895c4752c4-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This issue was identified as part of our ongoing research while
reviewing kernel code.

Synchronize IRQ handlers before freeing HFI state, and disable recovery
work at the start of remove to prevent it from racing with teardown.

Changes in v5:
- Patch 1: no code changes; carry Bryan's Reviewed-by.
- Patch 2: drop the duplicate work disable from venus_hfi_destroy(),
  keeping it only in venus_remove(), as requested by Bryan.
- Rebase onto media-committers.git next.

Compilation test completed.

v4: https://lore.kernel.org/all/20261001175502.4045853-1-mhun512@gmail.com/

Myeonghun Pak (2):
  media: venus: hfi: disable IRQ before freeing HFI device
  media: venus: disable recovery work before HFI teardown

 drivers/media/platform/qcom/venus/core.c      | 2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: d7e7bca7169873b46e857c025c10f3336c1258d8
-- 
2.53.0

