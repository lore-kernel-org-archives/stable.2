Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788589;
	b=O6gBHHekrMtcWbqbMNzMMZ9sggO/VZSkBT8ovLU6Ecakj4gwOp0L7cen7Jeps+16p9RU
	 sVKpXZahxaJGN1nX2zxe0fT8hZAqBMLsOHQSQsiy9+lQKLryl2w70PnHblIWNFTcirNNd
	 B77ObD4MXRFSw+g1Pi4KOWjI907pTedw9niA7wXombZQ2+VS5TpfOEuBirzu9+ifj6QdQ
	 wBu7vmto3ZDGUJUl1uNCEg990u+frCpUQknw4LTlbg3iucLOALt613Pp5e49sb6+jAo5+
	 7oC9fY9ijZxT99M+f/0jVQ+AaJijm9eP6Q7iqepC6B1u10lX4fePeQ/UMxWNX3gYNFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g8GDWpuJEEwiEELyHxABV+752CFxaNvpiplpVAXeeOs=;
	b=DsWLEsJRMLjySgp92daXT2wNS/nzZCxBVbaNuPqmSuGDlsNdKGeGYpTY1vkrLJwUz1xF
	 BEErluOVOck0GCHoi0MOM4mSLJkNqbOXSGeNRQuNsxSQS2B6vJBw8igWNjwh4PwceK+pL
	 cL7tFsvJloW8VS+QND3DSf7fQtFUgrzS8KqNjqIkf6QPut+x2G7iJmCa2/3TKpVdscxI6
	 /EDp2jE4EVZvtIKONkv5vvJ7qCDfaTRjRTQNKsHX+IfEIhs44SXol4l9eZ+BU+KNl1EW4
	 UVaHOzWz7J2CphUV5nSQgO8/RGBEVQ4Gj54v9h4lXYnZaZIWZqIWbDmP0TaMpjYcq9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ZoewCmxe;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB1606A336
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 10:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2CB1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ZoewCmxe
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4d870d54so328352f8f.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 02:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793788587; x=1794393387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8GDWpuJEEwiEELyHxABV+752CFxaNvpiplpVAXeeOs=;
        b=ZoewCmxewUIzN6aiIcngtU40jl+60XtSwir+Tt5YZrbVwlPRzVt9zqOQyL/2XkaI/W
         6eAD+yC8vtvtBhAzkm7VnlG/6CYdjB2db6CMh2Yqpz0Ej3/nkaIWTvaSb7KtqKH8ndqA
         r322RBM1X+mbl/85NKWpX5q/wDRW9pTJ2HHx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788587; x=1794393387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g8GDWpuJEEwiEELyHxABV+752CFxaNvpiplpVAXeeOs=;
        b=w1LBK1s/b+5z4CQUqBF/hGD2IURkmI/WBkNiQqYv3NUqy6vi71nNP/bUapl6wRvFR5
         nMumFiY0Hdbm0vPT0vPTwBGljZjrxVIUKRLXNr2UJVcNBBg5R8i5clbwzZljE5UqbgF+
         PbQ8JqSxbWK0kyJG/+o3bR1U7t7AQp57j90KKiDzpaBaUK93OR94sbDqWKUTMxZqRPb6
         RVoYOqYwTJSjPT4ub3T9FxMxOLOif8ymadqdmo2rsMZAGhOGKctrBsatdubNR04X82Vw
         xMDFiNlImxwl1XVUq6FM0kmOUHBDk30AUT50qedXW8zm0AbnZEjFA9YJ3Qf1nHTHr9vk
         gYRw==
X-Forwarded-Encrypted: i=1; AKwUvBzEYYRQYfdpMAyC2wXOFX4xhBzf+4D3RStS/dQtp/yk8knWLLBzeU+f+ztsUx/r0BYUIcSb2NA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UUsX3MXOdIdTmWuvPKTZRtBPuPwFGgUHfsyWGU2Ou3ygTWIxr
	lY29RslHxL7PQ4a7SLSH5BLGg+D2korKG2OSlDUxon0P+oPDIM87N4vq9nRVOxxC8l8=
X-Gm-Gg: AYBFou0hAUGC8f98Ql9ciMAXoQmlarrTSLYnZgXOaPn07wghXfxmsrtFdPI9gJ2TNp4
	bbiBsB62mOBjR5MK/4w7mlMBOR7csllUce74LX5/uOdx+JavlRjhLV0FOe7Ohz/BkBcSMLRnY+p
	3ObbVRcDcbsNzA49LG0plI2AVRYZvmOOH3NB77EME0jWGlgo/o3QYzAuJ2UHAW5e1oWuPCg4ku5
	+SFX0iNtOHriRw55k7NDveMBuCg1rR9Iq0Zb0kV7Ncf0fb9SXQZUy8xG9r7wqC3L3sO3lbBKAq+
	UFuiGeJJddd2NnRCb85KZpiJAJQsfzd2BmItSQVAe6ov0Tn0LPQpoR5rsGTrAEc/rrYgFarzXKb
	Yr13MIdQpKIzjr7+nMfZmWmVeru7MQql1PLyUzFpq/3qK+zSPXZf/miVWQWbabv7ayKLPQHzJG0
	2W1ZiL50EFzdyzwVf1enWTo33Cc+61gTdfFpwE5IKJMVRxiU4En4Iz7+aNOBqjNG7o29fUJFq9q
	TffQmOiLzOwYhL3ry5pBJDbvvIqof1drb/2FD92LFK7f2OpeNpL39syPWtCPBly+HHjP6mChNXn
	hTA0Z10Vor1bnEZtHtv0S9RxI1PEHyGclSga+G85sEeRFjzwdCEgpKG0Qf4e/5PgHW5kxhdUzlq
	brN71FpiWwUuxAn6fSb6XNdhjWshhLoUT3U2v7lEoxn9A6x7a6Dk=
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id 5b1f17b1804b1-4ac17753befmr352610105e9.15.1793788586637;
        Wed, 04 Nov 2026 02:36:26 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([217.201.213.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2afee292bsm141685155e9.4.2026.11.04.02.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:36:26 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	linux-amarula@amarulasolutions.com,
	arm-scmi@vger.kernel.org,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v15 1/2] clk: scmi: fix SSC spread conversion
Date: Wed,  4 Nov 2026 11:36:02 +0100
Message-ID: <20261104103620.4054694-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104103620.4054694-1-dario.binacchi@amarulasolutions.com>
References: <20261104103620.4054694-1-dario.binacchi@amarulasolutions.com>
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

The spread_bp field of struct clk_spread_spectrum holds the modulation
depth in permyriad (1/100 of a percent), as documented in
clk-provider.h and in the assigned-clock-sscs binding, while the i.MX
SCMI OEM extension expects a value in tenths of a percent, as pointed
out by Peng Fan.

The conversion divides spread_bp by 10000 instead of 10, as reported by
Sashiko, so any valid configuration is truncated to 0 and the hardware
is silently programmed with no spread at all.

Divide by 10 and fix the comment accordingly.

Fixes: 77369b1e6a37 ("clk: scmi: Add i.MX95 OEM extension support for SCMI clock driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260901155657.6A5981F00A3A@smtp.kernel.org
Reported-by: Peng Fan <peng.fan@nxp.com>
Closes: https://lore.kernel.org/r/ZR6PR04MB375776A27E98F140534E8F7FE488B62@ZR6PR04MB375776.eurprd04.prod.outlook.com
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v15:
 - Add Cc to stable.

Changes in v14:
 - Add Reviewed-by of Peng Fan

Changes in v13:
 - Divide spread_bp by 10 instead of 100 as requested by Peng Fan.
 - Rename the patch title and reword the description accordingly.
 - Add the Reported-by/Closes tags for Sashiko and Peng Fan.

 drivers/clk/clk-scmi-oem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-scmi-oem.c b/drivers/clk/clk-scmi-oem.c
index be11d359b4ec..c1ebbdc6bbc5 100644
--- a/drivers/clk/clk-scmi-oem.c
+++ b/drivers/clk/clk-scmi-oem.c
@@ -39,12 +39,12 @@ scmi_clk_imx_set_spread_spectrum(struct clk_hw *hw,
 	u32 val;
 
 	/*
-	 * extConfigValue[7:0]   - spread percentage (%)
+	 * extConfigValue[7:0]   - spread percentage in tenths of a percent
 	 * extConfigValue[23:8]  - Modulation Frequency
 	 * extConfigValue[24]    - Enable/Disable
 	 * extConfigValue[31:25] - Reserved
 	 */
-	val = FIELD_PREP(SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK, ss_conf->spread_bp / 10000);
+	val = FIELD_PREP(SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK, ss_conf->spread_bp / 10);
 	val |= FIELD_PREP(SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK, ss_conf->modfreq_hz);
 	if (ss_conf->method != CLK_SPREAD_NO)
 		val |= SCMI_CLOCK_IMX_SS_ENABLE_MASK;
-- 
2.43.0

