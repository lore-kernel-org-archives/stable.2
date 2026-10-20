Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501220;
	b=xrLMYBDSC1+oPfwhGRrDWc/I3ipQvwz9gfGEDEpp18NM9veFHh23Ybg5UOTsBWy/490E
	 AmKbWMZ6rj8J7QSJZFjvKQVOuiXj+q9/eQOmZZWK/QISpicxaIhgCp5ols1ZRTX4/XhzJ
	 0v7/3NmJYYAejiBZ4cvMb79WrXeUhKvBhgXcxMbnIc+09Us6PIk7Hrg1SgS4SQv6NEPpY
	 Db+4gDOwQAHBNMrk+zKj6HvtRZXqaMVv7gGjxiE8wk5bOciDoj5+0qo4kLZEy2bvboHUU
	 vZzI/SDIv6ssDQ1A/E3zHvtcdpQIq0JAn1th7CELqIelXYDp8jy1hS8XoNoY807/e4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=rW8APe3WvjmaSlpRO1MnJJ5xQdZ7K0W4HoHT++1heEM=;
	b=f7ybcj+oyb8QvmdAx0MLRmqn0ghEdAHyZLdkaNVV8PiOuYGR7xND+/Xju5xx/3RA/rPS
	 Zy+ndWaLnrhm7vR+VV5/m4EW3ZX3NdJJDGt7B8dCr10T4dbN/LpGRlUEGU7DaZYf+dq9Y
	 rRP4lb2qtbDw+yTgniPko19daUo4HCviB/W9tmCTewbEZPOvt2RTpFqfsPmlF1FkQ/v1v
	 FztWLQszxLHTHDjV17XZbx5GvVOuhzZ/yvdAyMknO1HdxJKipflh401/RBDscin8Wy6CY
	 oZwAOJhdQLAfzo3D6dO+MIGPu4aCZcN2orvS/FQcF2Ngee5sBPJoMky+9XQDDAsegGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k0O50tbB;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA460A261E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50FA460A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k0O50tbB
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1dec056ddso18332215e9.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501219; x=1793106019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rW8APe3WvjmaSlpRO1MnJJ5xQdZ7K0W4HoHT++1heEM=;
        b=k0O50tbB7rRUcvvLidpA78bwoI4CqFjyw92MDTzEykafkkwRFDrkax55mWY/4ie3/P
         831qQdZz155hEgrCVw5UMW8Q9nppUowTea3hO94Fs2Kn3SQBHE6BKLWgEDElgti6dwjF
         iyZKcKjy9J7mO+YvC0cz6Qa4PDYgpE60AwlsG+hncYHA4X+EqABgZQw1PsCcnsQzyd9t
         Vr5ekisX4jQAbBeKn/J6cedjVSbtFctD6ryWrubcu8/fALJtsmIC5ALPRZihYeNolvWB
         DbirqEB2S1U1kL9OrDDEqe3pHRb5FB5NhTla+qhOxs/EgRANIVlip4ezG83dxL+yO+Cr
         +clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501219; x=1793106019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rW8APe3WvjmaSlpRO1MnJJ5xQdZ7K0W4HoHT++1heEM=;
        b=YImFt/1COE66odQRwIeM1tncLWYah4foswUr5MhsqvpMkNviklkXqmSn54ixPdhi13
         3o4YQp4IVzK8NXOwQTorJLWymPTenYfSdkPpdw0rssXV9MdgUsakKMl8P2rAd3VEZral
         GZARIEbfYnTkQA9kvVHM0xPyCmuQqx9e5bVBLrY0Ux/jtlm271QfzaUoe/U2HL8V8le7
         WETPhqzChTDUDhTMZtwRRjmHImx7j8+EapITCq8uzOkdybMe5Uf5588SxKjbFS+rj8h4
         4LeMmqAoeXLiu3OOvho/6HbJIhGpSioKA0PJc/qhKXHbak6eCjSTedfnAi97jaCG+Amm
         T6yg==
X-Forwarded-Encrypted: i=1; AKwUvByT2Rk5RG5XVnhDdnrDwyUXMdUEDacUTxOIphl/RaCtt0BoVcNTSY3mnNFQ6ePqlV7FMRfYf3M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSw0RV9sGIB3zZ9zduikJ4qmy52gq7cCIyzu+q/AAcdlJCUs4y
	2J3M/EIBTbgnbxpFcx8A2UAc45EUITaWNiB1jz0jhdb2DTM06m9GRPtDDW4/+xBaCjbXdw==
X-Gm-Gg: AYBFou3YWRFm3K47u8WQQ6WyaMWOH4HytCCVRxIsjR+DbAzO8BUzUIFHmbbznNQi4Cg
	N4KUyfEJUPsEhbHF/CxVE8KsFGshpZH0+V1wIw1klAjX+ia3x2VXe/MtAn7pZ9A+8JrtKsHRSof
	Qtf5OTgVUzlFIOecWSfXWf0+ekiJD0YPRkiE9iIBeYuBSfOofjgoG58d2boUTZbansQWTNBN1Ms
	EqJKyaR8AN8+Ofo1IIOnfBYN1kU2Cz6cnvELsZspSJov/RCdk07PsmF3P3yXRZtry/hMsTZZUMq
	4Gh22LkU4bx4qgMOm2dk9L/Gz2Fu3u6HyUro7z1ktuGbqSeF21PTDdte2AjtFJNclanTKGRtgx2
	vRYoZ7KXPPgPmzWLcJeWTNKcCMfp619zVkycKCMa5fx19rUrLE6I65ENbobvNsLKU0jvoQB+ecf
	doHzs+Qfk3QXN3UNKQ4y9RFuT8phZKJm5IwRYctx6/a9EHi95cDDbnI++IDsJ0v32mOMZ4eKuw4
	8RvdlkPLQpCxk2kzJS+OI3Lh6b1SAPs/Qz/YbStJfVtIB5Zqjt6S4eqx3pszh0Wq1FT9ZBb9w==
X-Received: by 2002:a05:600c:3e05:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a1d763625emr222865625e9.29.1792501218007;
        Tue, 20 Oct 2026 06:00:18 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm6114754f8f.54.2026.10.20.06.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:00:17 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 20 Oct 2026 15:00:12 +0200
Subject: [PATCH v3 1/8] of: base: Fix stack overflow in
 of_parse_phandle_with_args_map()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-fw-devlink-nexus-ready-v3-1-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.li@oss.nxp.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Leonardo Costa <leonardo.costa@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

of_parse_phandle_with_args_map() reads the #<stem>-cells property of the
provider referenced by the consumer into list_size. It then copies that
many cells of the consumer's specifier from out_args->args[] into the
on-stack initial_match_array[]. Both arrays hold MAX_PHANDLE_ARGS cells,
but list_size is never checked against that limit. A malformed
Devicetree with a larger cell count therefore makes the copy read past
out_args->args[] and write past initial_match_array[].

The cell count of each provider selected by a <stem>-map entry is
already rejected when it exceeds MAX_PHANDLE_ARGS. Apply the same limit
to the provider referenced by the consumer.

A plain reference to such a provider, without a map, now also fails.
Previously it succeeded with the specifier truncated to MAX_PHANDLE_ARGS
cells by __of_parse_phandle_with_args().

Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/all/aq1CSswlo57jZpMH@monoceros/
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
v3: New patch (Uwe)
---
 drivers/of/base.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f63a9486b130..5abadab22392 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1587,6 +1587,11 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 	if (ret < 0)
 		goto put;
 
+	if (list_size > MAX_PHANDLE_ARGS) {
+		ret = -EINVAL;
+		goto put;
+	}
+
 	/* Precalculate the match array - this simplifies match loop */
 	for (i = 0; i < list_size; i++)
 		initial_match_array[i] = cpu_to_be32(out_args->args[i]);

-- 
2.43.0

