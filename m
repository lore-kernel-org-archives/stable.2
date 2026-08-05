Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA393E717A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917578; cv=none; b=PHlMw/tghLTQy7bWPjNT19/scfsHHMA/xaDsMzhwGTtTn9V2YfncPvRkIHigr4HOTZO9tpjFMGQDqQ1jb4ZsRGT+VvSKhUs9DQIlsVB3XBNVNE2aXaJvTPSDb8RUQFGHXh6EciT0vf/qNQBuGR/JBkVaMQ26x9cmQI+ns9ZGL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917578; c=relaxed/simple;
	bh=5+bgqUBoANfi8zQhQSTcZOEP0I32nAOARHOE6mkaSws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxCp1YEk6j+4TELUUh6M4a0sLRa2BzOjk+t09d+gi0zY2vHeGHCM790/TQICokGX/mqgmbdI+BeHKw/j/kafjvurZkl8L656lLFC05hJEmluO5z3QEN9W/wqS9eZb++0F3oGU+vfFSogyn+qXF5utqdYKVs6FhoWRAtVqtepWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJrq8eCu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJrq8eCu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so558040f8f.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785917566; x=1786522366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+bgqUBoANfi8zQhQSTcZOEP0I32nAOARHOE6mkaSws=;
        b=bJrq8eCuVHp7LVfljgaRbLXcca0CUnL+nFaszoiCUBjj4hS/1tP4p6UPAY4n0l7MlX
         kaYVSM7KNOj1marNDuiXSXXiOZnvhwjhk0Z1GkgHOPAoKsJxbVVxOFoykqbpx/PN9aYR
         eR+i0mnwLgOukmeSE5Lviuqy7NnKnyRKvNTDv7RioMbj8PynmVtly6vMFJBjmOx/sCkO
         CWyHj9hi2bBYEO55+ZX+cq375HTGbOMHvu4ndlJ+lkMxnjKDv54VhKUJms0BsldAAdyR
         dDT3ewAwCv22AiSYaCtgnXFWVK8GNye28Bi26GXHn/4ZfLd1TVlR85CQYL4HoeQp2qEt
         NSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785917566; x=1786522366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+bgqUBoANfi8zQhQSTcZOEP0I32nAOARHOE6mkaSws=;
        b=K5QaFt1bRMTO6LTNc3lr8dalE1+vR+IRgbgR7LJtDxDNVNa6dgc4X63NznvHHmLLd3
         halq2uV4P38RnAaBtSxr9P2/qYE7iEhLprfcH6RgO/QmSQdgMCAcqNlajXlSb90hlL+7
         qfI877x30Y1EYGzWw00fmmaqkzGhAtE4X8xTGB5ZpLIvMljpFVgP5lDzUtNvtqo7hyRM
         0ALxLG6ONaYvGIMuvK4WNweoUd8ScZByLWYRuE3x05qMUR6EB7tghN7J85Z2UY2Jc0sG
         NOsK4cngVyAKSqxh+XgzBGMJfwPRQNZfRLXSHkzpYRINESdqyPY2LsPexB6R6CTBlnym
         9C5A==
X-Forwarded-Encrypted: i=1; AHgh+Rrg1/DJbNTJVXEMWfv89bjE4A6kL/nPP20ASNgvEg2MN8CJSR3EBfNaUtAzmynhwr16MHzBU2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE24zLk74m/wd+nmARV4Nenjz8kOCF0kJVT0dS1fS9xrSq6JD1
	Yel6hMl54wGSnbFEbtL1lP8Rx+/HmXSTyuCpVD3YXDdPZRWXHLymMHpaPN+SW4LK
X-Gm-Gg: AR+sD11BxRgZcsrDQoUfcK0JwA4+8wTH2/4EoiUtv6bg9WwLNSY4/jTWdjF51I642zn
	bKChQr4yfw8vf36t6UWyhb72v3qYlEYA8pRelltnAi/6xEzS7NUlzwhO25NBMkZBRCcW1ZKEUV2
	ZbdQxxCmd1yi4FLw/uCIc/rN8r/I6VT1IAiIM+BWb5UAnb1kXpVzLIDh0/SPhehxHj8DgXYU9He
	gkaeFeW1IJr75CiOyc23yJFffvKjeulKt5LbepGdZMoG+++SAhdMHxBX5dv56y89JF3BG9yDJ6X
	KmlJFP4Zs872Z6WYt2mo5zpyRELIZf62llmd1GNVvNTJtMFc0gejrCwZagaaZL5xyGeMDVC8gk1
	nvtaOMB35kV3xovWBBC2TI4xUMUE0HWEwypWnALhisKJxX5QESy0YpJTR6QH3YLEzK0JFT2eT2B
	7eqR7XZZ0Sqks7T/m/g38/p5qpzYlAsMJI7f0WlfL27QQW3KcHo/cGnOfVORs8zN1LnsZUYsQx9
	X62RsgzYf0=
X-Received: by 2002:a5d:452b:0:b0:47f:8602:6887 with SMTP id ffacd0b85a97d-47fec4f626fmr5676202f8f.11.1785917566086;
        Wed, 05 Aug 2026 01:12:46 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:cc3:6030:c613:3768:f346:6d76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec24a279sm6544465f8f.35.2026.08.05.01.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:12:45 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Jie Luo <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Brian Masney <bmasney@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks enabled
Date: Wed,  5 Aug 2026 10:12:40 +0200
Message-ID: <20260805081240.11497-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1dc44e5e-7787-47f7-938f-1ac0676d96d2@oss.qualcomm.com>
References: <1dc44e5e-7787-47f7-938f-1ac0676d96d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/5/2026 Jie Luo wrote:
> Is there any use case that requires accessing the CMN PLL registers when
> no downstream consumer is active? If not, I don't think a fix is needed
> here. As you may have observed, debugfs clk_summary can still display
> the clock rate correctly even when there is no downstream consumer and
> the AHB and SYS clocks are disabled.

The clk_summary observation does not show what it seems to show, and I
have to correct my own previous mail on the same point: this driver does
not set CLK_GET_RATE_NOCACHE, and clk_core_get_rate_recalc() only calls
.recalc_rate for clocks that have that flag. So clk_summary (and
clk_get_rate()) return the rate cached at registration time, when probe
still held the bus clocks enabled - no register access happens at all.
It displaying correct rates with the clocks gated is exactly the cached
value; it says nothing about whether an actual access would survive.

As for the use case: on IPQ5018 it is booting the SoC. With the clocks
gated after probe, boards hang within milliseconds - 100% reproducible
on some builds, before userspace exists, with no consumer anywhere - and
the only variable that changes the outcome is holding this reference.
That is also why I do not think moving runtime PM references into the
clk ops would help this platform: by your own argument nothing calls the
ops at that point, yet the SoC still dies. Whatever the fatal access is
- a CCF path we have not pinned down, or something else in the same
clock domain - the platform demonstrably does not survive the gate
itself.

One more general point: the CCF gives no guarantee that clk API calls
only happen while some consumer device is runtime-active. The DT device
link keeps the supplier active while the consumer *device* is active,
but a consumer is free to call clk_set_rate()/clk_round_rate() at any
time, including while itself runtime-suspended - and on IPQ5018 there is
no link at all. So "registers are only accessed while a consumer is
active" is not an invariant anything enforces; it just happens to hold
on the platforms where the DT wiring exists.

If there is an alternative fix you would prefer - a different clock
handoff from the bootloader state, describing the in-silicon consumers
in DT, anything else - I am happy to test it on this hardware. But as it
stands, a mainline kernel cannot boot reliably on IPQ5018 without this
change, which is why I believe a fix is needed and Cc'd stable.

Thanks,
Stanislaw
