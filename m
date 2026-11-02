Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637232;
	b=u3yv1a2gzAZAFXTVXE9SgJC525+8E4jTr8/pPhvbCWpbVSQPflhCxJdW21GC/4WN4dAO
	 +la0e2xIix6/EWnVKrWRn69OYtiJJ99mZadZlp33B78FFFyaRbWdJHnvZWcsWS5TRfagh
	 WSKK/V8hnZjx67uOumDkyqUImDKy+g/ByQN0TYaGm5C3zeF3zRRRp+mNw9B+SDaTUFg1r
	 VJD+fzX1qMUvK3XcjObp2367ZxzWaA07MTu+oe4mH/T7fDEXSyYijBgAqfuqQ9/gWg2V4
	 j0zNeNA3J76MUM+tgYHEVo+a0HdU9c56C6ZxCS62CyAlu6cwC+mzOU3cJTkKe1M1t+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sC0VD9K+GRm0JLEGdvuD2m6j6IAs+ZIVhO0JHW5MmvM=;
	b=5eShnxQUkP0WCmKhVyingz3wyVRdiEF4D1I0ip65p2/9cg95Ne9gSX1LYsbXtSDUb3Dj
	 XPb7mK9czBh8KzER4i4xLfsrSmXIll0yxsVQLejB+Pfmc1viVreD8hXes5eP8A2wOqsOZ
	 aMEDqGsU0gDljLA30pVo6EIAdJtSgBOV5g9AMVngxome6A0+BIfz9bzktxImnLAg3BFUW
	 p8I/qsJUwxaKX5MdUg073EnBU5d9iaPE3sG3MthOYOmhENjccb3jrjibHxumSTCabFzg0
	 oMkg/ZQuFMeh/qCDP9bzzb0n0KF93c6XokwnxvWKo6O1//7QNEGsnqKyH0LzL0nyZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ME3X5PBg;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866360A0C9F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5866360A0C9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ME3X5PBg
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso1312278b3a.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637232; x=1794242032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sC0VD9K+GRm0JLEGdvuD2m6j6IAs+ZIVhO0JHW5MmvM=;
        b=ME3X5PBgb9/pAJnL2YDewhmS+6M7BlR9ikwI+RBbGRzyWYHDgTpB5chHHQQcN0jFIg
         D1w1kcXcVHAYGo+MwONSD45Z+mWNPsgzoWG3Rlf8ziRzgyE9bEvgZf1uwDtRlJlev+zh
         OSovjuI/1Lhk4iY2PpLAeqbo8vVApLCg+JJgg749bvAgeXTGDeewKEwha9ovaYFc8lnL
         o2ZevIYPv08r/ystkb0GU5RYHNs49g5ADtibJFEyIVv47QXaq0dKs2QwBA9JWEIfQjVB
         s8p/sAi65VcavWeZ2nKGQgt5s5XLFEElhjyNL8j+J6iVmnPXeowiUgiR9+gbioWqAAlD
         XOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637232; x=1794242032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sC0VD9K+GRm0JLEGdvuD2m6j6IAs+ZIVhO0JHW5MmvM=;
        b=b+0KRyyG1EZ8tIofdYvG/cNqvKetOq4z2GbMUtoRlXEh6TRIqkGnRWR6taYgWPbd+/
         P0VffeLLJbezZk9YP6TKc4c4kSK+/uhAID2h0+clhWaHTeTrGZe0i7XwWjmoz3vcd/PK
         eupF9gwzzUU6oy5e/zQJNpNXUZUQdLDjFGk3Bk2XdrNTdbF7cZQrlvRGo/fnF6Vl/dH8
         UzJwsZlKEKMUOnoo/zwU8mV3FSOS7OelgcL7PwwLpse1GfiupbaRN9HPS3CU//pYMPSe
         VbEPB3Nf08QAfDT5UEH2q5Zl24FPCPBuZar6p8YB8OgtGgNoduQkgqP6FVjv1BIWntkI
         L05g==
X-Forwarded-Encrypted: i=1; AKwUvBzSKQscv0j4armVao1RFPVaQOrH6h3umc+ryW6ev0y6klqERm5BHmvb7NhXy/5vTVMC3fvhFwQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8vGchypB03sqc4W6fN/WAYESss5G5wQtBkcfufhyKOMAKhDSD
	ecUmAHEZG8v3bX2/jt3lrz/QOTatmqz0R/w/76OwJkXwuIsSPmgGVxvi
X-Gm-Gg: AYBFou2FtreGgtV1LuhZNpjDBHTtA7ZJ7H6T76aOEcLcAI910piLb1RJBlfM0oonotq
	4+1kVc7PMefi9Yn6vBV0SlSDkOwTvRPzm06bB5INQ4YnHNoK7sjA/dfsmQIYr/uwIkjEZzUzi56
	uWF7YUl9finZTXJbdPGd/Z4EtSnvzO3rV+QEC1mc/B9mRKH6NtycxJ3A+tqE700O5lJtW7/JWCa
	lmppwo85iVv1fDnkMkV4T2CH3M7XC0LjLW5FNhg5435m26nxzjzKnm45RmQb7v8N8E3Gg7Id459
	vmLxel/KGUmieuoYNyr/Wi8Uz0KBj3kTJtQt9W3iUNwyCvRGhmi0aT6/ioZI+jaz5POjz3yEhkA
	bQmvVSFL79hRdJuCIr9SkJoG/VmwuifYhjyTpIbG7KW1h1rYJ3MtjH+egb4bRjAcfpgiwzmzwGq
	5JaXvUbgwOLWahx91HhDi+tkYqkstAxbZLk28CwijisfdEif5Cw+pMWVnyXvRDJgcgmEAAi1nDc
	O8LE1cXe0qGL+FJeuWyDRWeF783MYN0XZHku909SCW95LD8Etkx0MCPgb3DOpGkbXA2TU38EUrc
	Ale1lZUlceQif3eMR5h/PU815DJu2N5LFM+O1oxMpHV1aiIWVZyZkmPwGqnTXtZqE+UnF5rhWUw
	+s2uSNmTbFq0LvtN+ZXD5fwQZftFu/n5FPQNhjTz+m2k1fuarGI44ObEwgDaz1QVrcMUQvBaIbA
	Yc+1aMsz6gEZaAyZH1VX/F7pISABxbAQ==
X-Received: by 2002:a05:6a00:349b:b0:851:8bde:7873 with SMTP id d2e1a72fcca58-8a9ba9f77a2mr8518027b3a.8.1793637231660;
        Mon, 02 Nov 2026 08:33:51 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:50 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/14] spi: spi-mux: release mux when parent setup fails
Date: Mon,  2 Nov 2026 16:30:11 +0000
Message-ID: <20261102163023.2574632-3-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
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

Assisted-by: Claude, Gemini
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
2.56.0.317.g454f8302e1-goog

