Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840580;
	b=4Tc2qsDigcQAS+vg7+8qidu/zMzV/WkbYiDLAwtM7BWrdfSaBpWT4CBrn8iy7SdK3HOB
	 gs/JwrBWHl+ualX9M8QY1udfAVwhQcuxbe16mFWQJXUidUfhPxJsFt4R0Y5AMqZDt7uOX
	 ZO61e2rDPU0/J9FcsYsvbdukZ23RK2UNMSPKUgLCj+iP0P8zuBml27pTycoe20QiTd0qr
	 FE0JynMStRjxa+6JKydqLuQvgAy1ZszMxRFxJZDzeflNDPRcnNoqyN4GEf8pAiEtKL0sN
	 M+Pb7pwp06uejVs7UFAS+u42wKrBZcsLC1TDTJUKctOcqngV8gMUfHmSqkzet5KY5Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840580;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SznGa8wQxTY3HB7vymMdw3O/52O5jg+K94yzGJBt9/w=;
	b=pvNYPfemHHrWdUroqfkQZJQ2KT8C3nbc37YBhXWLl0c2oPFcWuWsEgA8U39eIcZW1Q8n
	 c8N91LTchhT6+PxTEUDwNTu4LSx8ZpJ2qHono5O26Nk2N9KEpckLYblrwBQXOD1ubdOLf
	 Ck/5SgTmin/3YqiBA+JwV6eC3Tt0X7VsvpL29NN5Qp+g5mmm4hazQQyGtrd7JYIsXcf7y
	 KlYfvBqmoW06pmxd4DKkIRvqxM/ggMmLDVX61QRQzvGc1duvAipVoNrDoVrUdqTqJNJZY
	 8qtPMVGpMwsM6OkqIBRxiOafjolv47CMzGJX1oSF6OmQh6mMy0ZV2q8ERBf3Vc3D1hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kDE8CzIj;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71E606A333;
	Mon, 16 Nov 2026 14:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB71E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kDE8CzIj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 904CEC4EFD8;
	Mon, 16 Nov 2026 14:49:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93BB76023F;
	Mon, 16 Nov 2026 14:49:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E74D111BC1483;
	Mon, 16 Nov 2026 15:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840577; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SznGa8wQxTY3HB7vymMdw3O/52O5jg+K94yzGJBt9/w=;
	b=kDE8CzIj2lDlbayJjQVsri6Bp+6IEFIVf6swYGiPy5JobUxkRj0vemDbFizMb8MbACHKzu
	W3Dsz1r9I1nS6CjO/xgcdsYiIsBhLmDM7VC34UBOkpDluJFzP4s5zkpn+PDeoheTJf9mSg
	M7Eo2kfLOB6Fshis3Ql8vBR8zxLdaQ5BM/5zcT56mKJVOZ+XtbfcHhlLxi0QKdo+0IrRqR
	X44M82ZZGMoPx3CscQFBu2rmD+L9dy89MYtx1iWFMI3i3lMhKcCBjP4+A2Cm53yJgVxhu7
	MtoxoaOL3eN8xsT65CK0CaY5/htewPo0pNFq8AjL6aUSx0P7eMOjEsXL8iWwJA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v4 3/7] spi: cadence-xspi: Inform SPI core about size transferred
Date: Mon, 16 Nov 2026 15:49:06 +0100
Message-ID: <20261116144910.44151-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116144910.44151-1-paul.cercueil@bootlin.com>
References: <20261116144910.44151-1-paul.cercueil@bootlin.com>
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

v2-v4: No change
---
 drivers/spi/spi-cadence-xspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 43aef7837bcb..6c88116f8f0b 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1207,6 +1207,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 			}
 			cs_change = t->cs_change;
 			t->len -= current_transfer_len;
+			m->actual_length += current_transfer_len;
 		}
 		spi_transfer_delay_exec(t);
 	}
-- 
2.47.3

