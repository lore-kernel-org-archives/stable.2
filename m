Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786863;
	b=3BqFAo0JHync25aNopqsWz/f/VeX6Etc7K2Sr7uxt0Zm3/iUkMmnWG3Xnf0tIMuPvDLg
	 bgVO+EEplaicgPD7GGQyHYVBr2gNRtL0Hz4lGIz7Vgob3iAG9Iawz5kqbt5GtxgieCj+1
	 KPDjhh6UUWjnM9KJlOoKrOjuifb6cCczVO8eQ4Msy4GFI9o4O8dCW9y7xa0xnZE3RWrkk
	 54KoKwUJ07rFde5Jc1E+htS2UFtUo36UEQZez0xOEbJ/4Y52jdBHj3BqHB9X1sWBJ9dEv
	 olXaOO+7FD4De4TwQv207pCZN0saQfVeXz6HFlm5EH6n5XXH3XkO0KovPMK7YHnwfBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786863;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=NTmWlY+XRW0YMuvEswA1sIR0fg4QDW681aO4CKPIjSg=;
	b=HVtIIhwFUdf3MhmedToARedu2AOykZsB3qaiS6JDtG5exeY5Ygxqidu5fVmJT88vU6Hp
	 1xCOTAb4eBr9DL78jhyRLxJGVqOpZtrs6HKLvzxaer79MKXCf2M1WLUrIsjZfMP3EKJQl
	 CcJBCGs0PDdN6ntQtuusItqj+UErQi2+9pkdNgTeoeR13rT/jkfTkF6116HYGye6Q3WqL
	 6D4RgByIK724iTez9k6mcJYCL9G9Wk1hRA9WlsKdIOxw05fI/0MuxdJ9+dKnwzlLp15Qp
	 mGmVvpubGMpIVWa5O4xHoc8u8CUYQVm4wG0+5nErSc2KJsJ46tT6O9ORY3uueQeU7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Gy3dZFh7;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80563606A331;
	Wed,  4 Nov 2026 10:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80563606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Gy3dZFh7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EF98AC8F46C;
	Wed,  4 Nov 2026 10:08:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0EDF760770;
	Wed,  4 Nov 2026 10:07:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5B0810329217;
	Wed,  4 Nov 2026 11:07:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793786859; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=NTmWlY+XRW0YMuvEswA1sIR0fg4QDW681aO4CKPIjSg=;
	b=Gy3dZFh74FG32530KZ1XCETtIJggwGCX4Fhhha4zOBQprQVEc1zKScWANfNJOHNPUhTcmc
	uG/Z4vzPyAXubfJqXYItky4CKfBUADTvAR/FD4sLPZR55pY/nFJmRwrV2WElI0CSZd5Hgl
	FbS+/2EEcwNYTOQ1lF5k6G5IdDuwVgWyLYy3Bv0pTgWRfr8SBOY9b7B4lVJ+pxc2upyJTd
	QCHrDsHd8pBELBw0FrIYoxEibEdnFSHD58mkq+yNm6GW8bYdOZ/UR5Oc3+NDTlE5JZnwFy
	uyBz/rDiIh29gHyO1rZmmUSehq0aoFi8+LH6R0MB1Foi6E+Kz5obPd043YrxdA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 2/5] spi: cadence-xspi: Inform SPI core about size transferred
Date: Wed,  4 Nov 2026 11:06:40 +0100
Message-ID: <20261104100643.162694-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104100643.162694-1-paul.cercueil@bootlin.com>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The SPI core expects the 'actual_length' field of the spi_message to be
updated with the number of bytes transferred.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/spi/spi-cadence-xspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index e3e265f51e56..3cb2f95b98f6 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1205,6 +1205,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 			}
 			cs_change = t->cs_change;
 			t->len -= current_transfer_len;
+			m->actual_length += current_transfer_len;
 		}
 		spi_transfer_delay_exec(t);
 	}
-- 
2.47.3

