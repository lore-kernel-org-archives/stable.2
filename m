Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC83BB48
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783387844; cv=none; b=pMhHhzGrD/r1j31VFQ5dumj+Tajl8ew/fTGX+pQhJa85Lo/abF6OskIM+hBa+CKnRzVKt1Jk8T8K76DSY6UOm4d/IGeODyHBc28vW/2LOT6m+AFBVnl4GEkmqT4YGdupfGQ0ZOn0BsE9MWGxO9CvI5R4vO7f/XfuYmQWzrtnoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783387844; c=relaxed/simple;
	bh=hlzNnsVV1o1LCgnMnPlGAyIjyXfohOSH516CMeMRHeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+6PGIThLi6UqmlIfvg4PXTjgj4wyx++W5MNFdEq2r13WcSsdVh8MW3V4xFas1/+QHu5SRAHZKh3QtOB66JCW33WV1WbDd7Js12hOogxTDGbaCCSzQCTLHRicraM43ClCz6TYgT/RQSZSJ0fe1N2qxydcP75Xnz+hJfOyjRHIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHaIJQ0x; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHaIJQ0x"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384422b05b5so415478a91.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 18:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783387842; x=1783992642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROUC3cgy4QtTAai8fuwZ/i9UUpJYp/TQoiTouEVN0vM=;
        b=pHaIJQ0xeZJB1D+gX7nlpC3oz/xmmdw/1EyKN4id4/+x9EeAPpTVxlWtzik8mZRw03
         hBzYVGCDtAo0bmP/dNK34zc0bKFc6dy8XEQtZMBkNtCNaGp85He8zBWPMv8d4fPpPQRZ
         qrHDm0oM6TsngwbMlQUvHpRyzeKPVWm0sB9KLD62KmhD4ap51zQWvnMMrRj3qvkFsBK7
         fcpd95vDaOcY5Xm1vKuDiFMXTxZNBbFBayZ1n7LbCu9BzbPeoOqcpwzyQK5DjFaW0u1Z
         lWCT09L0FI0HmCovHSlK9KRDSq62qGRm0bH/Z1wxSpzWZoMySQYsFdj17JVUEK3PTo5K
         4p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783387842; x=1783992642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROUC3cgy4QtTAai8fuwZ/i9UUpJYp/TQoiTouEVN0vM=;
        b=HbNKMiLe8W4YYNWPLORYLT7psrqHusmJ+aNR43B0wsvwW45BOQ+unVwkGcOZjJ8Rx+
         n0hTYJaxT75p4bJYzWJaXrMQ+dKDlaSHyW3NgvQ2N9q32Eqs6JkVuMtSUUc02xO1nRIs
         IBIRpXT+x8OOu0IxRhCViU5vsG1NTgLUmGN7Te97/6m+dFJTARRhdCGCKJY4GVtKG8By
         /lRnNCscvV/neKg5qPnegCayYAxYXNvA3/7TWc+WnPSaWwInY+yJCmrrx67tCnnI3AZ4
         cTXHR+src83hvoIYisxJ/U8fyYGPcj6wnjxegNUkS/q5ixW69FFUzUuo+dppA0t6rsi2
         3Arg==
X-Forwarded-Encrypted: i=1; AHgh+RorqD+jaVpDm9QG9yi2Se9KltloQBk/suXAavuyWuW3SpI5SWEuFmPn4XB7efqROSZkRdaSmu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOnl5hk9ymGRk6DoDE9noYlr/ba2hzt3ent32vE480Q9H+c2M
	ZyUM16qWAKe6twTcuKhiQP4tcSsA1nUId+4GtUkG3JiwoKVUPqhBOb98
X-Gm-Gg: AfdE7clczzPPIe+yp4HaavT5bfQx8BYDXeqfXhLPqPT8NhB6utvZhFh/KLSG+Qan+JP
	+hm/JHfwYDBK/vG/T+uBzpQIc5QL+blLhTimubiP3F8tccSxrZSCX1m8hLMJmyfNOA22fyg1SaO
	HIeBrtfKmN8JIbY2++aMn+EpC+TdHozHwVLvD8azJDApkkMYhRFCQ+uoDSYEDrjhjeEpmxcsnzn
	SyeFgOeabImbRl89r1P0+8V/vMxBXWMgunRr8FTV2TizSEndqiD5GWR+EIjpKjFeDFpt/4MUiya
	f9SZDf0R3Z8Uc0Nwh1AXPCCJ2bAN39NrY6/EwIfuZNaFXRwSXz2V/qiGUSC1svl22juqmhA1RHU
	xemiqcIn+3LNugClXYrDiE59f29hRZxufwxr8w9FBvpsUm8UBT1/7lWp4vze5TwDgGwzxnQLBo1
	mT4utS6r8lM6qWVUJMzi9OxQBCWnnHew==
X-Received: by 2002:a17:903:41cf:b0:2c9:e9ef:bdd9 with SMTP id d9443c01a7336-2cccad90e8cmr5468245ad.7.1783387841900;
        Mon, 06 Jul 2026 18:30:41 -0700 (PDT)
Received: from kavandesktop.local.lan ([50.46.174.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e279sm2653435ad.45.2026.07.06.18.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 18:30:41 -0700 (PDT)
From: Kavan Smith <kavansmith82@gmail.com>
To: robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: sean@poorly.run,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kavan Smith <kavansmith82@gmail.com>,
	Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2] drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value
Date: Mon,  6 Jul 2026 18:32:40 -0700
Message-ID: <20260707013240.681012-1-kavansmith82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706180753.408753-1-kavansmith82@gmail.com>
References: <20260706180753.408753-1-kavansmith82@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSM8916 runtime DSI commands still go through
msm_dsi_host_xfer_prepare(), which re-applies the link clock rate before
enabling the link clocks. That is fine in principle, but on DSI 6G the
requested byte clock rate often does not exactly match the DSI PHY PLL's
realizable rate. For example, the driver can request 56250000 Hz while the
PLL actually runs at 56246337 Hz.

Because the requested and actual rates differ slightly, every later
link_clk_set_rate() call is treated as a real clock change and re-locks
the PLL. On a video-mode panel without an internal timing generator, such
as samsung,s6d7aa0 / lsl080al03 on MSM8916, that live-clock glitch makes
the panel lose pixel lock and visibly corrupts scanout on each runtime DCS
command, including backlight writes.

Fix this by rounding the computed 6G byte clock rate up front, before it is
stored in msm_host->byte_clk_rate and reused by later transfers. Once the
host carries the PLL-achievable rate instead of the idealized one,
repeated link_clk_set_rate() calls become no-ops in the common clock
framework and no longer re-lock the PLL.

This keeps the normal transfer callback sequencing intact, preserves the
OPP vote path in link_clk_set_rate(), and matches the fix direction
suggested in the original 2018 discussion.

Reported-by: Daniel Mack <daniel@zonque.org>
Closes: https://lore.kernel.org/all/1a682c5b-7fc9-3aaa-120b-64b239a355a3@zonque.org/
Fixes: 6b16f05aa39f ("drm/msm/dsi: Split clk rate setting and enable")
Cc: stable@vger.kernel.org
Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index eabdaa4..5119862 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -603,12 +603,24 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 {
+	long rounded_byte_clk_rate;
+
 	if (!msm_host->mode) {
 		pr_err("%s: mode not set\n", __func__);
 		return -EINVAL;
 	}
 
 	dsi_calc_pclk(msm_host, is_bonded_dsi);
+
+	rounded_byte_clk_rate = clk_round_rate(msm_host->byte_clk,
+					       msm_host->byte_clk_rate);
+	if (rounded_byte_clk_rate < 0) {
+		pr_err("%s: failed to round byte clock rate, %ld\n",
+		       __func__, rounded_byte_clk_rate);
+		return rounded_byte_clk_rate;
+	}
+
+	msm_host->byte_clk_rate = rounded_byte_clk_rate;
 	msm_host->esc_clk_rate = clk_get_rate(msm_host->esc_clk);
 	return 0;
 }
@@ -2056,18 +2068,7 @@ int msm_dsi_host_xfer_prepare(struct mipi_dsi_host *host,
 	 * mdp clock need to be enabled to receive dsi interrupt
 	 */
 	pm_runtime_get_sync(&msm_host->pdev->dev);
-	/*
-	 * Do NOT re-set the link clock rate when the link is already up and
-	 * streaming. On MSM8916 the requested byte-clock rate never exactly equals
-	 * the DSI PHY PLL's achievable rate, so clk_set_rate() re-locks the PLL on
-	 * every command. For a video-mode panel with no internal timing generator
-	 * (e.g. s6d7aa0), that clock glitch makes the panel lose pixel lock mid-
-	 * scanout -> ~1s of displaced/wrapped image on every DCS write (backlight).
-	 * The rate is already correct from power-on; downstream MDSS only refcount-
-	 * enables the clocks here (CMD_CLK_CTRL) and never re-sets the rate.
-	 */
-	if (!msm_host->power_on)
-		cfg_hnd->ops->link_clk_set_rate(msm_host);
+	cfg_hnd->ops->link_clk_set_rate(msm_host);
 	cfg_hnd->ops->link_clk_enable(msm_host);
 
 	/* TODO: vote for bus bandwidth */
-- 
2.43.0

