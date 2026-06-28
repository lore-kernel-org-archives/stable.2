Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C2246BC0
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663960; cv=none; b=e1Ktk6A1c89nNr2MEC2HFV+Xr3UdDK/FQB2YRpAYo/myYR8yf+dpOrpWxfh/RdiBkuRZNE+X44nNVYvrvicoWDV+Jp8cdLI9e/+3CnqSK6/WdNSUtAECw/ze1zMO3Kdk8K2M4Cr9hyTJEeFQ3xuq+yXz/OOX4uCiMa9LQl+8lcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663960; c=relaxed/simple;
	bh=g2UA5Nh4NURnQU5YTpPXu2g0qAmphQXzC4iKtTM9Trg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHgQX+NtL8sUKvikZiIi1QGFRFcw+FQeiVIVtAuKtCR1DXSAmBFb/iqgABdaU3r4qdbw5uMfPSOoPMiYMl5Ej/qipYGIB4np6iGy0joZ9yCKK39TGOoQF7cf4KaiLn47X4LpwTknfKlxIRQuGaRsIvkxWAskCpFAvt5/o1sLPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKL0oaxE; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKL0oaxE"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dbcb505578so27265687b3.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782663958; x=1783268758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7van/FF1WCavCF+DOAc6ZN9nL2beTOurDM/vGTwpdMI=;
        b=JKL0oaxEiINbu1DR3+UgnHxBeii6/FkKYzrTKvU22+fk/ChTSA9jy4eXhj4jc7Gpg2
         w8iShpVkpWTw+VJMXd0bvzw1dac5s7uJYNjwhJR+yvxqbkEyzYHPLZcoX1vIyHvL0qM5
         Zeqz+0XIHZNyMZA/4gNAJx/ufqauTdTSGhhqWaVmEyjCoazpVp6NYmlgdlN2N7egKt12
         Bz6kccKKyd7hXyyOiMlBPGb5hSfPRnYntMwytSBFoXanRyeFCutJJyep1DeqmHIS45St
         MHvDrxjk5Qox3p+bJl9ydS8yzcYjbQZs7sVmlLS0vuZoiB32n6o196YZ2/3IxHWBjoQX
         itrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782663958; x=1783268758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7van/FF1WCavCF+DOAc6ZN9nL2beTOurDM/vGTwpdMI=;
        b=bhUc+pMMdHtX+AJyLCmlP1jMYfmxsdnV6RloH0k+YM6qlGplupoNomJ7dSMycpOxoj
         XQ2I0Nktzae4h4cNxF0LRH2L23t9lgSY8bBKUa9Uq5DF4f9OHK2iCkAY8H2mi9u4mP24
         MaFT+qWtXuKy55lDTP5CeV4MM3wWxLNgf1EzFqzSeqxNc4sCUUOA9mJ8GeFH7uGCy1le
         pHBgNm32wDm+r4NLEZe3fdw0Anku9EH8h41x/TVsmaLPoSw2Do4/ukRQnKtVX/jDIr0W
         xKc4pYu4XGQAYMb1vDpr6ndw080yUeM6OaJHrE1jSvVLmAG1zhSKl58FbjSGCNzUrngD
         0yAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5D/JD4SZNUEHokaUFml1Oe7TJJ2OtlfjJxegAPUa7mv/uCNz3hhEQ3nqmAs1Vxze13nrQ4QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxD/o0gkOOb3gF5sgDmRHCM3KtHBvmZUp/q2U46Taw6QSKqR3
	TMKxNXghzREN91TpzejnQe/R0tWYmEjufkI50Yyb81oa3w0KqmYfAOG1
X-Gm-Gg: AfdE7ckVzRt3wSb2sH23eX9QWFycYkuyXgoGTNzJbQwg7NRimcvfDT38bWrhCIkn180
	NVyFABlgXk0n0l9XZKUD2ga7WgeVX6hbDDkdS5H8blPPRZ0SQW8koL1SbF7hpKjS4vtVXPhOY2O
	Aj8EmeuVbwPm7lPrx8RnvtoJX8BaRNcolXeIL1Q3qx+9eETVJ8EMqC0dhYAHtFFO3oGkKjdukcL
	AfT+otCT/Zwj0tGTJqEitOLMhpyJP5nZ5VvV9X8UzO7liXswHfGxMCSJfI6Qs3Nw7s2uPcWdAlk
	nChIR2TG/KeGtGCpDqXOvpMVycssei3gauW+pmdUpedKX2e04bBobB0U4M7b1wh21BVHHuT9HB9
	ETbPOTu2xHRXDGiAInvzFYO7YpAoFHRff8pnTvQy+chcXm8F3vqhnijd+zkRC+2j/9C/4kmF7i/
	x8kYbPKCoMRVxPU2joKF0WXFLhbw==
X-Received: by 2002:a05:690c:6185:b0:80c:85b6:764a with SMTP id 00721157ae682-80c85b69188mr75232687b3.63.1782663958305;
        Sun, 28 Jun 2026 09:25:58 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80259d20d84sm106446247b3.0.2026.06.28.09.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:25:57 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2] net: usb: rtl8150: handle link status read failures
Date: Sun, 28 Jun 2026 18:25:28 +0200
Message-ID: <20260628162528.8273-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628151835.GC14404@carbon.k.g>
References: <20260628151835.GC14404@carbon.k.g>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_carrier() ignores the result of the USB control transfer and tests
the stack variable supplied as its receive buffer. If the device rejects
or aborts the request, that variable remains uninitialized and the driver
chooses an arbitrary carrier state.

Leave the existing carrier state unchanged when the link status cannot be
read. A transient USB error should not be treated as link loss.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/usb/rtl8150.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index c880c95c41a5..d51e43170e03 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -732,7 +732,9 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
+	if (get_registers(dev, CSCR, 2, &tmp))
+		return;
+
 	if (tmp & CSCR_LINK_STATUS)
 		netif_carrier_on(netdev);
 	else
-- 
2.54.0

