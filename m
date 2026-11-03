Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746414;
	b=OYW15OUSn+sZxaZs1SuadrDLRfBNYCZz6G7pYERj83LPZZm2c4BA+WOzHKWCTHULgzaT
	 hp9BmwVQqeQEboxafo0PNPayFBxODGp9/eZkeNqrH5iCHfnwVRIA8x7Y1RruyASH8h5is
	 Ejah5YMy0JQkBwTddSIrMMYlNZW2WtqtrdVHQ8hN3pSvHUbdvwrNidogrXhUrgDNyNke5
	 PtZnhXSN7BFC0DW/7No/uR1iU+btIg4vc9eK4TchQEpMuMHDSXfYAf2jIMerUnnO5ojQ+
	 ISb1zLli017TKBm4BEGdyK0XdENHIAOUwCR8+QMpDDNkP5uneUYWTOzVKU3uzQKQDGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/ej9wHg+NEebYYZRQ8OvgGc8M4xhsrwyP622zhe9cFc=;
	b=C3vDj3aWEpVxv6IPfigURJcnnPoc0QHkuZaDSWBsMcCtXt1YrzC4A/lXNIR2dYMphNua
	 rjlAjdVrd8a97ZlLzCr4gQyWjneL+ikAd/IzIDSZKniV7Du+IcWSpQA3jvIeqU+ce32OA
	 QqmztB/06TOpAK9qm1GrMNmbzhrSjQzbt+N4ZYIUAFBpk6rAgva/2ZuzQ1jccJOu6l0ZJ
	 /3YJmhwsiwdVRHJ0rXedeSljcLcXOWxpsXpV2rbR8Tu9+WHb/h5mcEOEQf5UgqvrIeQus
	 eoBbwM2L99vz3T8+eafXl7AV9r05g3PaabLSHJbF0LvHWbwRNUTOXaNXptZ1GHdqXsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKAN8CYv;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38388606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38388606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKAN8CYv
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso97144a91.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746414; x=1794351214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ej9wHg+NEebYYZRQ8OvgGc8M4xhsrwyP622zhe9cFc=;
        b=SKAN8CYvRpttpa1v1rBN1XEJypbWTH712BPffEjYu9OF9gKHQ9VySqtWKFCkrw3bUc
         I6cdLEx5K4WNxgXljiL4R7SGZwb1nOCvgO5DDC+TuX1wnbJgVF1+5otmFdj6JZltIMrt
         AD4/KJYIL0zRoBDdSSlCXoep7GT6ALAAyYXyJ7InOug+UbTxRA/TXJ7ist/0BmsB678g
         q2Cj8jsUBB8EYGxSF1ffaceetTrmIzFQkOYMXyeOe2IhBLefEgdZ3uG4glrgG49qOqvk
         15o4fWEsyXCWh1NLWbvWNo1GAvR3vx4eRHDXireHPyozd77fbx8r3wnnKQItj2OZcqJs
         QfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746414; x=1794351214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ej9wHg+NEebYYZRQ8OvgGc8M4xhsrwyP622zhe9cFc=;
        b=qZzhSiITiU6bBm6OAIVfOfQoxnP0sWuF3alFlKvjElfS6bhcB6zqcA//KGru7rr+ai
         x7CUNbINC6971eF2/9SkQcmvp5PqQTOQ6ADuFlU5lWtdBebuwL4BDvezxfcYkl2FB6ji
         OfWtJTVPLN1HD0xKf0xG1Z0xIGXkQ+/AF23r2CACaK1xgq07nr/4lNg8JvEe2cCN7EbY
         OrZXj1mCKm1mhEROB61KjGD9W5qMJL993gg40e8umAr3oLS0z6LU2Y1ZqbO9Nij45sqR
         UGGmZFfpXPO4wb0+oY2lAdQySfC5YWVS78f/j+R/2nnV0Dv0dnlcaGnYWHNimxmxmUN9
         M0dw==
X-Forwarded-Encrypted: i=1; AKwUvBwQ2xev6MOPiauPXZd+w0GzypNG0xnkUyFJ0JTJYkIhTkVIcBMeD3cdVC5kFZE0DTsbAPdhTHE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uCvb7cmQn5nNAkwSHb8XEyRk5r8t6hXDizGgxRjyUiKF2rYF4
	sUhG7+AMSfFzbOBZboNbkGuqK5NbRKiV12sO8xIoZuJNYqDH5Z/eVob9BeGsTl2bwvU+XTV0
X-Gm-Gg: AYBFou0eYO2aLeCHyMjekhw4YCGAmrBM+kKrPYNpHG9n8JtdhhFmfH4dhW9vu9jeeRH
	rOFzhUZ/r/Bp2Sg2tsdnrPCVwpzByu94egvWN6YHqkta058ORgUUR/v+jQGb4na3CNWj/a+jqvA
	y54tOz2NN1S5d1jl6VaTloCaowjxH7oi9mLtKpbfF5Mrt2bqyH3k/2Yflf8//oqZOwzn8V8fnL+
	r8lKeWthXfpwNy7OdUJQrsTITC1qIBYT9i+cdl8doStgNOV4RSUp49zYy/h8g+3ZQqxG/3PIhef
	mVpLavvyJmv9hTx8hbobzW3DgGoqp5wMUzBSp1oQ4W9wzQXh2v/A4x41kHRaH3k58m2Icja6gWA
	rCmIF5ZTLX95atw5PNolTvKO4E1QyS1LyrgC3ulRYEcYN4jg/stRlduXdliJkBgbimBL6cd39is
	R+AtEx0Qilg/mx+7MnWJT0wRD2W0EJFnRj0+VkoRssRh8fC9O2ChLcXzaxewpo4jAMbCV2soQbk
	TCshhIXZ1+D++ahuFjUKlhRpr4pBWB2EmJ6VMnvhy8EJsgeDDwNkb+Tp6dJr/IVcYnoukL72RdF
	x0swMhCsN3o1HS0Slxs5SlXsXgCwBTqfsrsxBOtT14KZm/vYxwu4gGynVtGH5NhNjbxI+kd52kK
	pg2LTh0EgP3/vJRf0piAf9TzY0qAoJq6VyOpcPwHn2dwXWnCrPuqujpsGs7w64cMxBVlSJc3Sk+
	PCEY1KCeld/fHeH8J1enTfPFQYEP4nuEYnuOo3KTBnCs0AWHSj86siRcu8QCZdkzet1Q==
X-Received: by 2002:a17:90b:4c08:b0:3ac:8741:e2e8 with SMTP id 98e67ed59e1d1-3ae8957cb02mr12193950a91.8.1793746413635;
        Tue, 03 Nov 2026 14:53:33 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:33 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] spi: spi-mux: release mux when parent setup fails
Date: Tue,  3 Nov 2026 22:53:04 +0000
Message-ID: <20261103225308.3633046-2-jctchan@gmail.com>
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

When spi_mux_select() switches to a different child, it locks the mux
with mux_control_select(), copies the child's settings into the spi-mux
device and calls spi_setup() on the parent controller. If spi_setup()
fails, spi_mux_select() returns the error without calling
mux_control_deselect(), so the mux stays locked. The next message on
any child of this mux then blocks forever in mux_control_select(), and
so does every other user of the same mux control.

spi_mux_select() also records the new chip select in current_cs before
spi_setup() runs. After a failure, the next message for the same child
skips the copy and spi_setup(), and is sent with a parent that was
never set up for it.

On spi_setup() failure, set current_cs to SPI_MUX_NO_CS, so the next
message sets up the parent again, and release the mux. Record the new
chip select only after spi_setup() succeeds.

Tested with KUnit (spi_mux: spi_mux_error_test, added later in this
series) on ARCH=um; that case also needs "spi: spi-mux: finalize
message when forwarding fails" to see the error status. Builds with
W=1 on x86_64. Not tested on hardware.

Developed with help from the Claude and Gemini AI assistants.

Fixes: 5a5fc308418a ("spi: spi-mux: Fix coverity issue, unchecked return value")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 08fe1fa32dea..28d7718138a5 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -66,9 +66,16 @@ static int spi_mux_select(struct spi_device *spi)
 	priv->spi->mode = spi->mode;
 	priv->spi->bits_per_word = spi->bits_per_word;
 
+	ret = spi_setup(priv->spi);
+	if (ret) {
+		priv->current_cs = SPI_MUX_NO_CS;
+		mux_control_deselect(priv->mux);
+		return ret;
+	}
+
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
-	return spi_setup(priv->spi);
+	return 0;
 }
 
 static int spi_mux_setup(struct spi_device *spi)
-- 
2.56.0.385.gac671c819a-goog

