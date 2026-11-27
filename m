Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.124.121.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785359;
	b=yiubrnz8KVju3asAd54QTCb6m8F6zmUp8GNRvbfBqRrvlHZgS8IyUtT6WMXahXWiUsON
	 jaDrpwXQNPRoR7H3A6wmx5cNsOddKn0QzTMBNcicuT9emnkSOysGhVjc1nO6eZgfw0SdV
	 Amk6fCqjgBmB6zl6Z7Y9X8ilfxRNnqnH+/416lPumLfiLD7uXULtvIbzaQ2JBo6lkMtDh
	 bOTc7rf06C0FhyL8129Wu3LkEpyeRa0QmOVle5uC7HbaArFlihcRqrs0qHkTJCslBfbAA
	 Ux9zkZWpFvBkv0NZl6fvUgPVwB4Nx1ZyD66bjjf3R+XVMdc86AZyqaMbwuVxajE44Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785359;
	h=DMARC-Filter:DKIM-Signature:X-MSG-ID:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aCFTVSVXG6wB77a8PDQDLAYBUxPyj3OUMGSVgEGZX8A=;
	b=RxPhlwr9HZHOfCGfgRqPS4s638BBrp7vZkKUvOaRu/wEuynQ8X2csUCjypL9c4kOVWeb
	 HRal/je6C9cKglRw3DG/gyhxOcgTWI0ZTvyAURNTYSbiGyExuW5l1yIza+TsRisSB1GQ3
	 sXgYGCRwUPsWAbeN45SW11kpqqUiTcG338AS9/+IsHrB/P8MnqObFVLFa2xqCu0tbWAsq
	 3okCru6RN5M8uRuKivaeb3zduct//NL1Axf3iyVQdfhEUKMpHShB2wC8kJovLBj9Pug/u
	 cw3EvUdt7nPuGzfemVt8tmMDGQR71MgfYhdfEx2D1n2RaUdi6GN5orH2HrWVbdBlx3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zanders.be;
	spf=pass smtp.mailfrom=zanders.be;
	dkim=pass header.d=zanders.be header.i=@zanders.be header.a=rsa-sha256 header.s=202002 header.b=U3nrn1TM;
	arc=none smtp.remote-ip=94.124.121.26
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B5606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C37B5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.a=rsa-sha256 header.s=202002 header.b=U3nrn1TM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=cc:to:in-reply-to:references:message-id:content-transfer-encoding:
	 content-type:mime-version:subject:date:from:from;
	bh=aCFTVSVXG6wB77a8PDQDLAYBUxPyj3OUMGSVgEGZX8A=;
	b=U3nrn1TMXWL8RX8Yae4iIAaIUF9CKip7Ejz9rEzZs+PtXY9ebAIiLtVdNBPcGcU7NRlooiyOz7+mQ
	 MGqMUgngD9n8ODjRgbeyFEiqZ13tWeIxeq5WFHymxJQEl6l0gcSTSLH82w3htRayPWTLso6vtvtFcA
	 1ebBrNhFfeyJb+mdceyUbTA2dGeHiGMmuIkaNEivo/fpIoxjUNGzJazpkARwIsbpauO/r7GnSXkRWr
	 ZqbHAxVUIok0t59W5s9ZgaGYt4JXd2l5Zlh4traBd27GTFj4i4i1kd/5sOPYpsUqt3SzWSYHMO1Ki3
	 l0UsXzSl3flRVJYDgSOTCmdrOo3rg3A==
X-MSG-ID: aac02d20-ea64-11f1-8642-00505681446f
From: Maarten Zanders <maarten@zanders.be>
Date: Fri, 27 Nov 2026 14:15:31 +0100
Subject: [PATCH v2 1/2] clk: vc5: Enable PFD frequency doubler for
 5P49V6965
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-vc5-6975-dbl-v2-1-5a05581902c1@zanders.be>
References: <20261127-vc5-6975-dbl-v2-0-5a05581902c1@zanders.be>
In-Reply-To: <20261127-vc5-6975-dbl-v2-0-5a05581902c1@zanders.be>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Matthias Fend <matthias.fend@emfend.at>, Adam Ford <aford173@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Maarten Zanders <maarten@zanders.be>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795785348; l=1089;
 i=maarten@zanders.be; s=20261117; h=from:subject:message-id;
 bh=kd89PotW/xzgMsI9YP0phLrL9nJkd11Q+dQOl+MrkK4=;
 b=jGmOSPVID50W9Bk+ui5uXjOvD4qdyODo9dinxEbnOtGZsBVHMH+7wFz7mkfzidmWo2R/IoAdJ
 UMA/ukOqCRbD7sa6bMw5vzDaHc15nP0frNo36DgstP6QuRK+pf/J/GW
X-Developer-Key: i=maarten@zanders.be; a=ed25519;
 pk=9vkWF6gtn9DS+97n+W487XUEhrI3+9cvA7Fdon8T1uI=

The 5P49V6965 supports the reference frequency doubler, but
VC5_HAS_PFD_FREQ_DBL is not set for this device. As a result, the
doubler setting is ignored and all PLL and output rates are reported at
half their actual value when it is enabled.

Set VC5_HAS_PFD_FREQ_DBL for the 5P49V6965.

Fixes: 2bda748e6ad8 ("clk: vc5: Add support for IDT VersaClock 5P49V6965")
Cc: stable@vger.kernel.org
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Maarten Zanders <maarten@zanders.be>
---
 drivers/clk/clk-versaclock5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 1cf8526975eb..ffa9e1c74fcd 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -1299,7 +1299,7 @@ static const struct vc5_chip_info idt_5p49v6965_info = {
 	.model = IDT_VC6_5P49V6965,
 	.clk_fod_cnt = 4,
 	.clk_out_cnt = 5,
-	.flags = VC5_HAS_BYPASS_SYNC_BIT,
+	.flags = VC5_HAS_PFD_FREQ_DBL | VC5_HAS_BYPASS_SYNC_BIT,
 	.vco_max = 3000000000UL,
 };
 

-- 
2.55.0

