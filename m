Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64F419301
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947964; cv=none; b=bWBvB5As2KnK6OT/5Fv/meu606kQw2o34nN3k3B55jgqGCoGpX/5G4hgSvLYqC7EMynjVJAjYIzmD5K+yVJt0oDsHHNgbgVWjhJP+p1wgkYqa7TBpyVTmYhARr4gbXn3azC6hZ4ZEZNBMYDBVdmkLScbhLRlId1OHZMWUf+OJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947964; c=relaxed/simple;
	bh=XVXaVxL+lneg9duu/TbnwymCvCWqh29aY5BS/FFAisE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ41umnD/r2njXPwFaKGggLyA2dinNKCyzqzjw9gUi+UE3vu/Gxp/zY3lpJLU1NwKg+Cm/9ULATECuYbe2yZldC2D++HgSGvxeoCeQCcOSLZtwbLNDtbRwn5C06Exj18aK6jbLNEl/rHvwxwnWHDycA4qBTkAYlNEnokd18wloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CIWD6zmV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CIWD6zmV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2695448f8f.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1783947961; x=1784552761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/juGqGDG2fLncz3tYXEPSwjfCpIrvLGtrL87h0T1kX4=;
        b=CIWD6zmVa0Abt3Fdzj1f8mK8xPKZMMKJRQc41pzVrxAKy/2xzmPq4/WJN1721yPSj9
         DyJqW9Wo/mgzQBLVGztQjmFpseUTXOk6HC4SnWGfJ8YIk5Jh6eSKufF1CaCTsdChvaXm
         tO0SvuWoIAbOsxDAkPMsw5U0AX1aAAWg5WX1VdHkKtjGTuiUkaIhVdWsE/7CW56G7gn4
         FrV40LU9QqITXqgRH8xr13ulyIHd8CR5kOAG6pSp0WqjgT78hAWvCFd14GvI5SN70aYx
         qjw1Odtk0Xw8jYHMnbXyqaV6ejTh/8qgg9uUQNVVweztwIgGtgf2z74kiYesnw5iqZqz
         MFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947961; x=1784552761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/juGqGDG2fLncz3tYXEPSwjfCpIrvLGtrL87h0T1kX4=;
        b=N9zSx25n/X3FANmuy73YLd+37qyyGirvDv9Dl/AM6oAEM3ONKPIdUrtQi7icAdS2yr
         /HEnKYmI3D6AyR7fP52Vyfn+0GR0GciaSHfJpJJkiDU0/ICbe/5exDT+R+Ua/KBPnbQW
         6kj3pIbgRUiMH4Wgt0wnf7z/u8Qi2C/tfgJUwDTyYAxawDPudFj5Ty0LaDAvCQ6PeiCh
         2BK9hmzN117CdIuDhih6Uau2h/ts63HABtA8fd8xZxEYzmJx62GjAfhvJ+patCuZSysn
         0AqD7OYF86O21gsNk2DOGlYKBNJ1gqrmDQw54oegJHUWQRtLs4YtG0s5QXY443N2Cc0E
         M4rg==
X-Forwarded-Encrypted: i=1; AHgh+Rqvvt7TkwU5xBfT11w86FNGxzXjUTix+3B7o9VSoPIjq8BSlLisMl1FOHrHvuOC2veYHoZ7J4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YziqEJvz/fzT6hzv2KNpd9GfUFCxuxocGuskHYypStgTIRNMqNo
	/VKX91yYcYK95Mgl3g1pGalSPvPtRzYELVA4XNhaTD9fr1owRfo8OnN4Y3tY8ZjaF48=
X-Gm-Gg: AfdE7cnw3lPl/WVmr2XM7dXXjQH5EVKSTUqFfMPWde8bWiwR5ip+i5tOhEWXOvxSCGn
	S/yPV4mNvSx3BSKhJUOVGEctuGVWOuSQx9M5vpwymufiRlb5yPqQ1Z7voLsIHjqG4QsbeMRqLLO
	ux4Pm8nQWs3+isquywXymHO4qbsjBHNg/WioN4Q4WExAF+275mVuOvAl8R2vAdobuOltIVcAPbB
	8pNCbl5Qy0oVTdADB2sLIw3WmoQzlY/YOWCRv5uG7m/B3AhsLUpnGXNrrBXP5WTzSCSunKRKvAi
	ObbJN+ye2vygG+hzQV0GCWhkVfbx0VPCDQVNaoLk4CFjkgIeFIFoymG2vXJTVlEwLfypd8WTXMK
	sZMGLTE9f2C7j4dWtWG3eGIaRrqVld/cHjBckzoCgvDAPgPYpj9ZOMMllObWJZJhVZJ41PHq3Sb
	qcUlhWRw5CSzjiSgnrrijAITq2uWmO/DkDFKxLKXBfkKdwv99wMy3v+ZpdSEbQyuKaPi9sLAQ=
X-Received: by 2002:a05:6000:4b01:b0:475:f100:35fa with SMTP id ffacd0b85a97d-47f2dd439ebmr9925829f8f.55.1783947961456;
        Mon, 13 Jul 2026 06:06:01 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6402:500:e91e:fe5e:857b:d0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm25321609f8f.3.2026.07.13.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:06:00 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 07/17] i3c: renesas: Clean DATBAS register on detach
Date: Mon, 13 Jul 2026 16:05:35 +0300
Message-ID: <20260713130545.568657-8-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The controller uses DATBAS registers on TX/RX logic. Clean the DATBAS
register for the detached I3C device to avoid issues.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index acc30ed615ab..b9784d238f61 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -935,6 +935,8 @@ static void renesas_i3c_detach_i3c_dev(struct i3c_dev_desc *dev)
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 
+	renesas_writel(i3c->regs, DATBAS(data->index), 0);
+
 	i3c_dev_set_master_data(dev, NULL);
 	i3c->addrs[data->index] = 0;
 	i3c->free_pos |= BIT(data->index);
-- 
2.43.0

