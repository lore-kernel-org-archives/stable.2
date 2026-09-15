Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22907471433
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468435; cv=none; b=hVBTdTXshZg4MK3Hg91EMF7pp8MQLnuQQumKeOg4hI5Wh79/ihC/mChmk+ZdIQKcTUq2wQ/ypvrG9DpO/Nutjp1f8h7JRF5hqP9fY1NEPk02P+Jthd1oKvHhvM9rz0vUV3TK56V9jvV0c2Yp/tTE2QXq6EhYJb4gtKp6WlrsVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468435; c=relaxed/simple;
	bh=Iot54+4YH8z9WLeHeMdtitMcMTgj08iIM+GUm+BjpzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sm11HOQ6J423t8ezSPMZzI/b8pYu8w7bP0U0+luk3gLn5lFVKoLXuoxvJIfn5WbszB13WmPjZjy8mSMbl64OVUX940ij4Pc4rE48xXoGvEK9gFdOop6beSuaUGkjxIEhDp6daSeHAJsq9gJSGakA2PPWhXyUz1zlnhH4o0CyOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuwslfT6; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuwslfT6"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so26062466b.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789468431; x=1790073231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlZV+gDl5kHNbM3FapkIWa6VkdcZp6BNeCy2FJirDI8=;
        b=KuwslfT6126NUlu62A1yJUTxClIOFQQi5mrK5wgmLXufa5FeYrNGZCDvWnOAiJUc88
         BMwEKyeUhb2JUrdnZeCkVr78NAF7D5NPbWRYFjDar11UEr6QujvQVxae+VO8PpngKbhQ
         n5+kCmAF08RDzPqSxz3ZL2Cgw7tTr/QEcPXOoiDmLgELnW9NOhP2XcLcdn571vDQiAKk
         kWkl3mF9tK1P4btY+2TKa7dLB7m6ktVkgCLN4ErwvMw6g0+c9SY9OBpyz8MntJPa6jw1
         VSrZC61CrFJ/3gHERY9Vjpqf9QsuquJbksLv3DijhAOrFck32FeeTcqpCWGAj5JjkMzh
         rdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789468431; x=1790073231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlZV+gDl5kHNbM3FapkIWa6VkdcZp6BNeCy2FJirDI8=;
        b=IfZzj8xcwXlsi1PPP74f1+6AmhSuZOjgYRRPDZndCrmPQYiUyR7dwAiovBlDGDp/gs
         jzrKfD798y4hzHvmfbm5/yA74Z2XojlUI8oOl5fZG2LHs1clpEw5m0TOP6gPFwyL9GIA
         UL8FSQiLQtiO9oUb4Wcpk/fGGSZ34JK9FoS0lcWUoWgs0Tb9A9HgLBntzAUL6/P0ROsN
         jTEx8prt395/IonTmyVCyCUaEb5gHh8d2Ck1oPqrKtBUHGfpQboMS0MMMgc+qs5vxFFe
         yGt4E+raJRtaZFWo+jAgJ4/SVilgFzXNRAqYRzEQAkI9hNXSu7LE5hasvVIn5uAhDphC
         WQUA==
X-Forwarded-Encrypted: i=1; AKwUvByYNmfCYcgW7jQLZcX2ZPAjbXxulEbouKzrIYsJ++j+Sgtc5HvsFQorJFvYrIr6MD0+kza1aq4=@vger.kernel.org
X-Gm-Message-State: AFuF++nXC0XhIdmrRfACUdFdl0mbXGe61EX0RAl+qy2erKxY4ApEUK1V
	+HtQKGdI0XWgc2ON/eRiaiX//uq6l3RXTW/IRkJAWHVg6vcOPXp/6Kou
X-Gm-Gg: AYBFou1eIkmWfgzIBLd/XRW6elTHMmy4NMlSQ8LU6HQI1AC356lrJg4SfmhVapqn9pq
	RN8NMVp+DsSJodP2MCDSrdtGOnzzOA80Sbk6ItLaY9sW/0fY0UvyBh0FGWTsh8xor//03xJ7OFg
	SXhYNHuAAPDAYpPjyq2QikCS2E7eXr1LFBahMPqbFdb4PgIttqEmqpdUo+fQs9VU3wpSx+eH1nT
	HvYI/iDsiFI2eggTGzwNBaE8ECQWjsFcxZcrxKcEqqqyGLzOK91bW74GOW8cXNPJvoYcfaW503M
	GaYC23jWwOob9vasyp4Np2ZXsVQ4baysuq/plW5nsPK3UUIavnqmOvzK+unZEeFRd8LdluCUgYd
	Z5llh7f0lziMIOJ/Hzs6W8LaQwigLZo/NIrcaj4zLqCRQJDB2IRZxb3llCIZqHrbS0uhDF/mCwF
	xgG/qbDUvuap0Srs5bqHA2wMixcZGc40zKQJsgb6weMrxH+XMDiROhrtVXy8/6Bqjs1jF1T5GKb
	68HuidPS3Mm5DCkpZcqQJJSG1uQMtGzySFZJwLhr6r91GjEIB5WOFElkHmjCGJEJcva9A+BKqlR
	ZdJ/Klvqb3AtDEWWZLae84465y2gSQQMzTjTRpsVLDpZ82ynXZJ4froF8qN4E3dS0ck2FKTSpLk
	NUetZxr4D91+4QO3ngPNcIV0pB8fsn63eUj4s4KUmo/q2xNlK5rb5CmFBkh7ZusC7eez47JxLj1
	Ip1E7FiTx5iZbFfdlNOQ4y2pIBUG/j71Ws1NIPSwUR0BmB3Kt+r45PHtueMlM02PyMchKoZSVeR
	oFfXGmrmJi3yRGu1PLFbx7qn2k=
X-Received: by 2002:a17:907:9610:b0:c26:2da7:347f with SMTP id a640c23a62f3a-c29d734648dmr49184166b.0.1789468431374;
        Tue, 15 Sep 2026 03:33:51 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.oa7bb030819b2a894-tp.internal (219.40.147.34.bc.googleusercontent.com. [34.147.40.219])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4e8a1sm566041866b.6.2026.09.15.03.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:33:51 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] clk: imx: clk-imx8qxp-lpcg: add missing pm_runtime_dont_use_autosuspend()
Date: Tue, 15 Sep 2026 10:33:44 +0000
Message-ID: <20260915103345.1334-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915103345.1334-1-joshua.crofts1@gmail.com>
References: <20260915103345.1334-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_lpcg_parse_clks_from_dt() disables PM runtime but doesn't call the
pm_runtime_dont_use_autosuspend() function, causing potential resource
leaks.

Add the missing function call.

Found using Coccinelle.

Fixes: 18cdbad40c6c ("clk: imx: clk-imx8qxp-lpcg: add runtime pm support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index f0cf6cf91899..b31903060361 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -279,6 +279,7 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
 	}
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return ret;
 }
-- 
2.47.3

