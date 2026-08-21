Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350D341057
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320631; cv=none; b=ACTR5R7Snm82kon45yogt8tv6Nw9iwDMbQiG4m0ont9X5yV191sop9JLBCvyW17iQYA2ZfykqyzUg0bs4lzFexyAdSSPaAp59yh+JxvT9VR0hgzQbZCvcoh9SOfEGHXFptQvdYDxCy1iujuN8X6rej/tnWzsEa8cXaPM7Bw4mOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320631; c=relaxed/simple;
	bh=bbhgCz/PoN/VYdzPfW9SJ8KfnpB9xgPHLKXOVw3ZwZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le1xJOoG1xGdU1snzCpxB6qk1H46HALRVDM3pEVveYH2HmV7/DXJbUUFA/kLDSz+SJG12kRq9m6QDHGj11Qe8oDQQGb3Q6AvoXdvCmuNBZswB72wKK0XHLAWSfyV4hznjAIripMQE7aAwTcXokgpspSNW4tn2F/Hpiz9R+SniPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZiWBeC0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZiWBeC0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38deea72eebso990365a91.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320629; x=1787925429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gyOnyMmEXCZBKLQwxjb8ydf3Caf3mgLgb333lC5gOLY=;
        b=gZiWBeC0bNZZc8Um0ba82DQvLE2/79GxbL1RK6D+w/OqbYVvzHRum6X1BL+87376qD
         HwKpsUEsS2HQO1QWJx0OMIwXXqxPiVGuJmWFsOgPmffNYnmFLXLR+TBgK/VfosN9Tk05
         26RJJkvZpRPz+8ZocjOzpr+kvEilzXv+t+0a2uISg2hf/udZ7scI4FHrCw9OCEJ0IuLw
         lDjCZ5Qg13xQweFnVi2MHcyfsX8m4keJUjyLV5zG8Lk6s1X36sfxm4XAkVt5hd5R2XC4
         TUv/l1Kt5ZkeIK+gOTefF69q7tQVndDQCMqnyfv9XMg1j/DtyxfDp8AKo0Oub9V0in+K
         FZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320629; x=1787925429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gyOnyMmEXCZBKLQwxjb8ydf3Caf3mgLgb333lC5gOLY=;
        b=qd2SIw4+DQpFLHUu128MUIhFy8DsWFxKxtrThbyHDBzjHJBdqT3sgo2ocL42jruZZO
         glLeRKGgrN8CumCFO5tcKYhJaFl73wtQY3lJdGmUI5EgOG6evRBV+ZVle0DLU/tTOor1
         J03twWGOCsf6TzZtP/FZ33RSS9m3jTJQLgMZt20gU1YWukFMnFIYZr3a1XkPTHLF50P1
         s7zTTNJ8za8eTpZbXVpUdK4qPHkYOlQHDHSmZEU3+hUp2vMB/j6TQIB5iGs5Wpn59Tw8
         KNqpN9QjwBWtwHbQjoYkpJWy7AHOIJXkHGEqbFbuMMuir8bOQHLj4RW7ePU9Om3icrtG
         dtzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rquz6R9HWiD72YUJwYheV5FHBGoid1ErUQ5CGcvzMINW21+zO7Muk1QBkrj9tAD3siC3yhB8tY=@vger.kernel.org
X-Gm-Message-State: AFuF++lRPvuX+ke5cVgy7FpphBGSzhdSqNfUWsGM3jYQyqxrO1IsmtVB
	I7UfRug67VRG/31TR2q7ZFInYlakbHfmJILErLoDgWfZpVk7yBXVmQhL
X-Gm-Gg: AR+sD10tY7gMl7z1AHVkbvvKihbSc0SD9B58mXiO3BRfqm7xuxLRl9gBt1RfpgLgYMp
	VMGLo4hfyjKPs3SwHUeklmoywFKP0MlJBgUJGRvPzUKzWuFZ+4VrxvvzYrQK+m/QDX+4R5EA9Fv
	xH3iRW4OT260ZM5lqStCfyWBpItJ6Z2LHLUmxBlZxFgByJd2RF/Qiz/N9Ofd8ctQDpQWtMrA4sz
	BnN44jPtkzHWHkaLVB7NjsSC+LoXWlMvOAw3N3b01pkH6SPiXaAbYAlMi+GU44mlFpyYFfgW4Lw
	ceinu8fSh+/vpIbutpcEUvDAF5xeVXuHBc4jVGnuIRcZIMBx0P6M5hzVNUZCMBHs4hghI03olzg
	tcXXKgLeJ2fbg2dSceg15XfdA8zEvk3HHB2go9dgPRhEORD0jny14O1tE4UbFGH/DffLbCKKzaZ
	RMYxtY+EEMyaAyfjtar/r/tn5TMgzvlRSkgCITCDchr4hOTZF+XBzAwwqggfn4qGZDbSndN5u7Z
	Ed55OGLsZjeymb6o3Ol4QkZc1joeaWGhEnyJugm/nKp4VWVGO0YkLMfQncBXMJCk2FWvs4awi8e
	Snm2Sm0LDRLq7WiwTy6zbg==
X-Received: by 2002:a17:90b:314a:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-395c3522213mr11052450a91.6.1787320627942;
        Fri, 21 Aug 2026 06:57:07 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:57:07 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 06/17] rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers
Date: Fri, 21 Aug 2026 14:55:57 +0100
Message-ID: <20260821135608.275233-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rzn1_rtc_set_alarm() updates RZN1_RTC_ALM, RZN1_RTC_ALH and
RZN1_RTC_ALW using separate MMIO writes without first disabling the
alarm interrupt. If a previous alarm is still enabled, the interrupt
can fire while the alarm registers contain a mixture of old and newly
written values.

Fix this by disabling the alarm interrupt before reprogramming ALM, ALH
and ALW with a call to rzn1_rtc_alarm_irq_enable().

Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 44e8db466cb7..09631a3a5134 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -280,6 +280,11 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (alarm > farest)
 		return -ERANGE;
 
+	/* Disable alarm interrupts before reprogramming the alarm. */
+	ret = rzn1_rtc_alarm_irq_enable(dev, 0);
+	if (ret)
+		return ret;
+
 	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
 	writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
 	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);
-- 
2.43.0

