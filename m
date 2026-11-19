Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079960;
	b=pg4//QADUST2aOV3cDon4KSqwp9AUugYp1eb/BV8EtitcImWfCwtXymAQzxEag5hXTNb
	 i5fBRuKPTO9lJfkBLT8Bi1K+agmg4GTU16AEPgIwFnwrwLZxcAjI3ucFZFr26UI/F6n93
	 z9SSd9GcUotFAJfXl1Xpsb/76uJfwfoaKSZWNcHy0Gwgn6c5ubkhxd6Tcm1dcS5cjrMof
	 ZkN/dEMUZZpxsEtb4bhRgSMK8IDobDckXXXJGcNl8CtJE8qCJ5LyO0JDKGkQmaG2dF1u/
	 aWuuvcAiMP97xGXsKxmRfJP/Zq/ss0mnbpKyzDCdDkAliwZn04p3eyi1Nj03bMBjjUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vy7dQdwcLjuJGzzYP6/5w/8O3IX+03j/FcYO1YTEpQA=;
	b=hMXZr9uw6087MKBG7lHs8y3eNwFQObxji0iG6WCjIQbWCFuNKK81gxKodj/3BfR1Q9U5
	 pkAme7dKKhzhM1ttUIWZVt6qtY2CMJFm2tTFfX6RxxbTz3y+Vi+OftzRY6Ev9XuQq5dip
	 2ulsnyrjxUpNg3guSaBLea5vmJ+oqoeFgYYCZsuEVkazRS7MdEOcGIUa5MpSM1ozdG2WH
	 CxCDcvG3STyO9C9v+MaKgSd2WzPVG2fDQFSjRVUKNjT1GsMWdy/ESaPEDtO836Z/qUzY2
	 iJRfPb+/nK3Vfey27ModKufF+6GFrB4kP2eOY+H2htivQQh7EwNK4QBYRa4u+ZWAs4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7IFV685;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78677606A324;
	Thu, 19 Nov 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7IFV685
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26921F000C6;
	Thu, 19 Nov 2026 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079960;
	bh=vy7dQdwcLjuJGzzYP6/5w/8O3IX+03j/FcYO1YTEpQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7IFV685e9SSCvDcxCfQ6vM3+LAXZYL5UDDrOU8MsVZ1n5z7AiVj5HNI1rM7oNaEA
	 IreAEUEdzYBCZfEHPAZOHwGsigyPZrB+BLMF0WAmKXgEdUMpXwBLEB11TlsNHg4++y
	 8uGVLXVkBXTfMF/QzUCfhyeLWNmg0hmSfyJSoazh9FLOV5qEUAoRRMSDPBg+uddKBk
	 INfMIiRnT5P2Ie3BtS5LGAtPOXoHdtHxtsL7UhvXFqjSWAEm9k561Lr+u2Mul/edPc
	 Uj6PEQI4zlTdINDiY0UzMv8qajCKJ+10F9o+AJr3V6FRa+jSDtYH7UJEyWKxUhXF1f
	 anw6Qrw43KxAw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Konrad Kociolek <konrad@cadence.com>,
	Jayshri Pawar <jpawar@cadence.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] spi: cadence-xspi: Advance tx pointer between Marvell b0 chunks
Date: Thu, 19 Nov 2026 09:17:21 +0000
Message-ID: <20261119091810.3440619-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119091810.3440619-1-lee@kernel.org>
References: <20261119091810.3440619-1-lee@kernel.org>
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

cdns_xspi_transfer_one_message_b0() splits transfers which are larger
than MRVL_XFER_MAX_LEN into chunks, but never advances txd between
them.  For every chunk after the first, the leading byte is sent from
txd[0] again, and a short trailing chunk retransmits the start of the
buffer instead of its tail.  The out_buffer pointer used for the rest
of each chunk is advanced correctly, so the data on the bus ends up
inconsistent.

Advance txd by the size of each chunk when the transfer carries TX data.
TX-less transfers continue to use the zeroed scratch buffer, which is
only ever as large as a single chunk.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Closes: https://sashiko.dev/#/bug/linux-e2ba3b72-ead8-4562-bdb2-4992253c59b4
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index c4fcbf5ae091..4c9af6146a5d 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1319,6 +1319,8 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 				cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
 			}
 			cs_change = t->cs_change;
+			if (t->tx_buf)
+				txd += current_transfer_len;
 			t->len -= current_transfer_len;
 		}
 		spi_transfer_delay_exec(t);
-- 
2.56.1.708.g77570a6a1d-goog

