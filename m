Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215360;
	b=0i7fb1CmpRFCH+nXJihsYIYvqp69DRFEnQxSeip5KdDBbEdl8lQCalKsKiAeFAbYygOm
	 1CglcggcGV82JeEExGln9IZM5dlBq/CgbA1rDMKglSFkGIWNIFRGI8YInCuoLYUjOFTR2
	 tVdfT1xenX98Q+4TGsEaKEwAJkbVX5dVXtap0HvYDlxwiRpGn6BaNsjK4Yi9qBMZcRpW6
	 yFW6DW1UATanODmg0tj+S9hlWhiLYvaBeXZlQIIrqmOC3ZAUSlEUF9KgZNAcdE/52mLZO
	 9YNgG8B7ytAp/T8l0kuFKsiTfKj/e8lLDjN5uGSh3f2SFd1B8aL8hKn4MSvPvCMivIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+KBLzQyqsR334QCpiwaANoenKn13j8vn07qxRoKBlVI=;
	b=Pm1jVuJMYSuMTSgruWq/1tEEezN1EyGtNACxvMQr4+Rk447t01EcmIO68C+KHiCMTlr8
	 G6LHNcOdQRyc4xlHnlU+HFr558iV+gUWDphoqdzehEDpwMHXBQw17uIDQmwmMVmUTdEVJ
	 lneIoNqf/ytgFHxKelonThM6HqJtfMum3qj/1+ohEbsO3xIGjsZTOgR1gD7NOtAr9OR15
	 lYoOMmTuY3snwtB7Nxwh2A0zFK7RdXkCBgYdgZG45/uOwFhrwr+XmNMQXT0bPp1XAknYo
	 INIVouzg6PBCHkH/Y1GFwOtluOTbmWlbIJkpyQy3z6PbVo03BdgjNiXfXb+HyDZPgHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wirenboard.com;
	spf=pass smtp.mailfrom=wirenboard.com;
	dkim=pass header.d=wirenboard.com header.i=@wirenboard.com header.a=rsa-sha256 header.s=google header.b=GP56uGAf;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAF606A336
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCAF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.a=rsa-sha256 header.s=google header.b=GP56uGAf
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so5049105e9.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard.com; s=google; t=1794215358; x=1794820158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+KBLzQyqsR334QCpiwaANoenKn13j8vn07qxRoKBlVI=;
        b=GP56uGAfqelAtz+ZKaQKSFJnHPlW7rl/XXFsOM4NhpYtf3oyCLoe/DAXcg/bArFdH5
         8MBGX+H3d0by1/+cPEYkqvKdwXrYv2aP8og9SOSauz5bDB/24hphmYKSGLIBwIMPay37
         90CIcMv7qfHO8+oJjghypJNcIEojMyuwI3z/w7Uc4YDSx4s4Zit+6DlQqdWztnua88kU
         m5WmvkAC/6oI7auisFFVKxYleskNY1zUgtSuopvyeFcQLNGA8pHqhmHfiJVUNZ4lqmxj
         b3g1UhBiwXbpd3fFqofeHZxJ/N2Txu0LjHKTCAuLunbblAdyLBr6gNZiYjiX8iIaNRGz
         2Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215358; x=1794820158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+KBLzQyqsR334QCpiwaANoenKn13j8vn07qxRoKBlVI=;
        b=bQC+nsrg9MYxjYo4zf3Xo3h4ens7D84B55c8dfEg9W2UnZwDksgcVBokx4Hl3G4F+y
         6TxFDhNjGWboQtmQNZIeGCXl14eh5S+/UPa4P4nHUlhdaXqSmD5eklu679SwH2Rde+MI
         bMWJBKU0veos37LySXgP7+rAko0pCquqnx06uKt2MTdaltVgw0P0hzTJ7mx7099nCJtk
         bDKnzaJzl3zPC82LQPWuIXNe//5RCi7YBdjhOK+AAuddXiWGjZci2MoA2kzHY0/k/BUL
         Gxi671UdG+Swhnl2RkHjzbM4Ozr6NvAWaR8pQXsQUWWcGAXkbA7dFk8vYCsW/6qe6ZaJ
         jhgg==
X-Forwarded-Encrypted: i=1; AL+hErHv2wugljOEeiRWaeiuE2on1SPvGAkGMiQmS8pmmVSUW4PT68eDhSRiQs/APf2MVMghPOlZWM4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JhqOXXZFCQ74MU4mTlisTdH7ir1WhcxgB4jbnWLLIDYQgqI2E
	OmmaldTmH+/OmgIrjCYR3e1MQCYls/UrAysb1nt3iP2EUiSp4/uTTJ7oFuTd4Gz3ETI=
X-Gm-Gg: AYBFou2bjx9y93uLkGXxqhBPyDBsNIfF9cwbro/wP482/diB85jnVOHk6rXilr1UTHa
	UGQCIYAveG/5RwHnuM7NGJ7DfSqA/JHF5Cift4sr8Id4mnHozZqNBUyMSPYdGZpq+E0uKVMRhR+
	rQBmPJNOOlfEp8DeOgGSbsQr4/pI6k76kX2ZXQ1PlNHPQF9xj8LYsw2uETHWt8dSAI8Ut6fmcIO
	9XdlbB+C+dFuzOL2QEHv0sNiW+JNDGfdTaU1w8DyDw0vy3WpXrHPqnZB6JHYzSNlwmSh6izdLvB
	iLOBJavlfIGyHI13TLHarxwb1ywDe8QemJj5FLT9Epbx3LZMdsPYjWGoEIJjFfarUS2zIobptc8
	XRDOcAmqI52ddMj0m38FSuRUVoXZhW/Wv009ZwVuF5KRuL3c2oRSTuNfMGUxkpmgItgVm1FXGHt
	yrYRcToz6xG83a6FyyAaPYIpMKV55G5FFMdJoJ+dtOLWUh0TGYZGM88heuUheom8o/KvPQVEt40
	ADXOJ8Levl38daMgN549v4P4kW+Xwp1Lke3W1cecEcp/3sxAszMsCTOTMD+ADzPZnJTcpoC1rjE
	I6hMS1XPAdQfKQsT8Ex1DB+/i3AufAc8KSJPCUzDOtpFJUWTL0YSp5BdEEbElXg=
X-Received: by 2002:a05:600c:474a:b0:4b5:2c72:651c with SMTP id 5b1f17b1804b1-4b963c6cac0mr68998635e9.5.1794215358048;
        Mon, 09 Nov 2026 01:09:18 -0800 (PST)
Received: from localhost.localdomain ([85.137.25.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f398a4sm8250905f8f.6.2026.11.09.01.09.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 01:09:17 -0800 (PST)
From: Ilya Titov <ilya.titov@wirenboard.com>
To: sboyd@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com
Cc: bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ilya Titov <ilya.titov@wirenboard.com>
Subject: [PATCH] clk: sunxi-ng: h616: register CPU PLL notifier before mux notifier
Date: Mon,  9 Nov 2026 12:09:14 +0300
Message-ID: <20261109090914.46872-1-ilya.titov@wirenboard.com>
X-Mailer: git-send-email 2.54.0
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

Currently the CPU mux notifier is registered first, so on
POST_RATE_CHANGE the CPU is switched back to PLL_CPUX before the PLL
notifier re-locks it. The CPU then runs from the PLL while it is still
settling. The comment for ccu_pll_notifier_cb() says it must be
registered first, and the other sunxi-ng drivers (A33, H3, R40, A64,
A100) do it in that order.

We see random hangs and oopses on T507 based boards when cpufreq
switches frequency often. In the oopses and JTAG dumps we captured, CPU0
was always in ccu_mux_notifier_cb() or ccu_pll_notifier_cb(). Other
CPUs were usually stuck on dsb after tlbi, waiting for CPU0.

Running a random walk over all OPPs with some load on other cores, two
boards hung 20+ times in about 3 days. With the PLL notifier registered
first there were no hangs in the same time.

Fixes: 087b4083d3f9 ("clk: sunxi-ng: h616: Reparent CPU clock during frequency changes")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Titov <ilya.titov@wirenboard.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 955c614830fa..00b7811f3a84 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -1235,13 +1235,16 @@ static int sun50i_h616_ccu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Re-lock the CPU PLL after any rate changes. Must be registered
+	 * before the mux notifier, so CPU goes back to a locked PLL.
+	 */
+	ccu_pll_notifier_register(&sun50i_h616_pll_cpu_nb);
+
 	/* Reparent CPU during CPU PLL rate changes */
 	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
 				  &sun50i_h616_cpu_nb);
 
-	/* Re-lock the CPU PLL after any rate changes */
-	ccu_pll_notifier_register(&sun50i_h616_pll_cpu_nb);
-
 	/* Reparent GPU during GPU PLL rate changes */
 	ccu_mux_notifier_register(pll_gpu_clk.common.hw.clk,
 				  &sun50i_h616_gpu_nb);
-- 
2.54.0 (Apple Git-157)

