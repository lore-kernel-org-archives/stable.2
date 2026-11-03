Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746415;
	b=j7rQXEdSG1S8808vXZV0nNfXp0hXQLAQf7EknW9vZqjbUNe+OzRxAh/MOfEDp5CAxNXX
	 Hm/dvHgaQVHPTq+DEw22LRicWqFMMbO6e+Xp+tpj0nq8zEHZYyIlRAjg+t6GTWiLxdenC
	 eEBiq9CsXFO3cuRt73q4HtncgjpdLDW1DJYn65HM/R0ySDtkTyk30o8KyJ7Gw31LxgW5x
	 CzuNr6A/9sfxwnekGwABYvcZG3YzaC4Ru0dTyvbA8Z6PDPl9J3fQW3ilNYots+Cponw91
	 Hl+Yk9nYZEZBCReDqRy/Avv3jTX0670pNG0OMK+nT4xjBG1Ikv0L0iWSE+Mljh/GLiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Wc6qCbz7ti0d7DipF9tcPtrqQeE8ZBa7HQpF3/MFEtc=;
	b=LTAv8OzSaFQZOcXrsHYIrI8Zq026ANNtxQQ1UlYqkJEQnP6JnG3By8dx2X6Z2qd0bpdS
	 Tid6ru/o1kQmW16Wc/bav6o6dPWO+8jbZQ2iQHkSdNyFb3eRLL5tAJkgW5+ppbjjzJTIC
	 fbqnAgb93xsbbXfbSInrqtiSni0zzhhHvg3tltokIlRfkmMzI9TGNFZieGI+2I0HchY6a
	 Wk1Z6E2T4eiLfb391Fanc5IfyEPBlB03BBlMRCHcMDe+jfUAJUT9WZ6pA4vo0YlJFyDiq
	 utNvvwy6Pwa+beQIGeHm8epMAywwxR/UH+dryhJimjn67qURs4etHqzcCLarFF70ZkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwvcyB5C;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF9606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37AF9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwvcyB5C
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso88070a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746415; x=1794351215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wc6qCbz7ti0d7DipF9tcPtrqQeE8ZBa7HQpF3/MFEtc=;
        b=KwvcyB5CjrFjB3AM5JsPGC7/v2MUMFH62wJHwBoSVgdLXAs5oJBp8/c3kiEmmpujOD
         8IH3esGrKg4mI6jNhzCcrwoTuKcDxribhdC51mqS+mIfuID1+vkMMaxsm6OFV3Y0MBvD
         GsF4CNLTV+sFDHY4CdbqKkGFtN/rZJhkhL7a50kTnONXgwSkQr983tQeYbNcNy6a4JQ0
         8VCxCxbjO5ByUbQLs2fglbBcWnZMqv+mUCq1q279QK61eJ93Eyo/64f29+QbCYi7wNLy
         EiqX+RjNsLwN8ESiIb4fcIEJ/akIF/tWy74Nk8dZkHZUn91bbMxajRG0rG/xfJW8E01U
         sfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746415; x=1794351215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wc6qCbz7ti0d7DipF9tcPtrqQeE8ZBa7HQpF3/MFEtc=;
        b=Q8jF+tlGWQOnkgMEouqhpfX8bqT5CouJSzTaQzo6vOHf6BGFZbAtdhZMth+r79VxUK
         lc5ettZ8tpObggtCswRfxGIi+d0f25IFlTpmeOiSQjwKeJ2Abt2eN3yM6O77s1x/jWsL
         oXdAf04E3JbdtlVdN7GjLOyLcFCbNGBJG6TmMZXJrRUKj8Hfa4hgKdH6JjOUQv2ub5xO
         9B/9fshIn/NCrBtzbJklPMaQ2jxuWA3Kqmnrr3PAv/9IXNg/sBSzT3nURuNvL9VeacyC
         Bo6uwdd0Y947TdZGeFpurVGs3rJ5xj7yiXW+j/5n/PuHpJcB07hw4jmgUp9PBy2dGdIx
         IaKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxE+cgU4InoqyJVEEO8ktEbih7FOBu1Hqe7zxnjHHBWyXDwOincP3qjEQ1LxFIV5rudgn/CqtM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lkQrMlDB3ux3nOlj+GfLJT4ej6HSEFRAe+SnXDiIlk4Wt2JgX
	/ygi+u9CrfpBGplCdowVUJfVz3/1PJG68aqUftBcqjfC7+Pc/KqveSyk
X-Gm-Gg: AYBFou1gzBSL9czt7Zoxrs4P00b0h4TYccw27zLO+WCsnvZu6PlQtAhFrr0MLMGDnus
	vX4fEH9iVFZJOtMD4pzGNSkZyT6XqWePYEE2gLRaEmG6W3IqLBRx0ps0jpSC6MnxOIwG4BK/ygY
	RS2vKbl/+40IOgczfjO+Ic0Vh5bg2vbGIhGmB427VffnTytb4+TpOVIpIB/qN6BF8Ctl13u7HGK
	7qNMsuMwMS68tiW+zcWpVm4G/M/UV4GAJVG/khcWOuXIvKGu6JVcSeedX5dHLkkSk54nYO4RRu5
	1+ploIONSlblCUOXEzx3oBmQbcUypriNGWMmjdYo2bbFyABJPIY8zmsenzAzOWwJmyJzErl9mqL
	K1NY6QgywZlx0n2EYE9CSm/VGAaQIN5kQrUAKd01ATnF5KxvhiqG4IpFjhzU6yTvUXssjMRK5pY
	YzCtsqt7OMrf35QSDXwdt7yg29X56IGAK708ypHtMjgD7n9+2y2FCofz+HuFQL5NN6vfbOeFfKj
	9WgTr8VlFyS/81SLCNDgxvHm2qPDxv+l2nSHVngtJVs2P/SwV2Dff+xJFe4hNXCWTX60bHFI9a1
	unkdEFZby4HE8Ug1uNQ8LONGCKIOSis13e4wQB3xhLtjT+zC/EFZxZwNhB5P0vyJx6ip+anZjoK
	tu/6k/BNW/U+fV3EgAQZTwP0WY/KBZUUcSQlGnBiYY46jsdGyng00mTkpcjEqHTSizgCPwC9uBi
	brJogNO3hgDekTPN4iGBdfDBoPYtmgv2gkJjTasV5lQsIwMnnU9bUbQpp/RW30W0ECNdHdWs3Cb
	AqCIQJzFOzj+vs=
X-Received: by 2002:a17:90b:b14:b0:3b0:92be:ea4a with SMTP id 98e67ed59e1d1-3b092beee8dmr525289a91.45.1793746414486;
        Tue, 03 Nov 2026 14:53:34 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:34 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] spi: spi-mux: re-apply settings after child calls spi_setup()
Date: Tue,  3 Nov 2026 22:53:05 +0000
Message-ID: <20261103225308.3633046-3-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225308.3633046-1-jctchan@gmail.com>
References: <20261103225308.3633046-1-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

spi_mux_select() copies a child's max_speed_hz, mode and bits_per_word
into the spi-mux device and sets up the parent controller only when
the mux switches to a different child (current_cs differs). If the
child that is already selected changes its settings and calls
spi_setup(), spi_mux_setup() only calls spi_setup() on the spi-mux
device with its old settings, and current_cs still matches. The next
transfers of that child then run with the old speed and mode.

Set current_cs to SPI_MUX_NO_CS in spi_mux_setup(), so the next
transfer copies the child's settings and sets up the parent again.
spi_mux_setup() runs under the spi-mux controller's io_mutex, which the
message pump holds while a message is forwarded, so this does not race
with spi_mux_select(). The cost is one extra parent spi_setup() on the
next transfer.

Tested with KUnit (spi_mux: spi_mux_settings_lifecycle_test, added
later in this series) on ARCH=um; builds with W=1 on x86_64. Not tested
on hardware.

Developed with help from the Claude and Gemini AI assistants.

Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 28d7718138a5..a7ea6585b374 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -86,7 +86,13 @@ static int spi_mux_setup(struct spi_device *spi)
 	 * can be called multiple times, won't do a valid setup now but we will
 	 * change the settings when we do a transfer (necessary because we
 	 * can't predict from which device it will be anyway)
+	 *
+	 * The child may have changed its settings, so make the next transfer
+	 * copy them again even if this child is the current one. This runs
+	 * under our io_mutex, so no message is being forwarded right now.
 	 */
+	priv->current_cs = SPI_MUX_NO_CS;
+
 	return spi_setup(priv->spi);
 }
 
-- 
2.56.0.385.gac671c819a-goog

