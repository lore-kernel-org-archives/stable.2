Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793589;
	b=AgXlq9x9FgTV/t2vuGssSRDvkALkIcHXpZ/4xu2HH8tPp7a9mBocCnLp2E5erqPDSmBQ
	 Q4o+7lQjT56l1240yWvYDi16MS2mRjsPRQx2HEf2SQhOX1Dbhx3Fjo8TmhrkINIhIuE7+
	 HmORKhEIgKHQEiQO+kzN/WTSJgfhLpk43x7pagcIGRZcPZKw5XVZQ2Uj9+R9Fwz4+Ylj6
	 N5sfacz4soQGtrFKgwDXMqF1W9dRLLffnNIKoKlz0lBy0OlzZYw6b5ax97mUb3zT1MBuI
	 gbadIw2svZuf3Df3Ju6Trc/npPVIMAC7FeSAj3VH0Nd6fJ5eYrp5+TwklR1nRU+GMHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0/nTWV6qM+caWLX6wOpXvstHX8JRYMb2GFwuAiImwMI=;
	b=lW6gutTEyhLL5pgkw52Kb3WKatkArbQ+7f6RREknlpPzM0vNzqqIJaGe3ARAldpZDE/9
	 cVCsFb4uYYwCdfHVuYG+Wy0IukgWaxzIaBS/k3tyOGWiFtkE2vM0MCzmFr6MuHsxW4JVu
	 6uxiJwCm4ILlHA0u4hL8uWUrGuwt+e51huATqiQ3ma0M3xq8tsD6VF5Tyx/qyC0Nl5Cx7
	 XGiDB80IaAx6rPDBY31sqmaNfA3FlPsTDT/juG2Ybg4Ju6Kp5ViMLDmCJYATgG5YGWJxm
	 Ioid7YOgfbiABN7MFnC1+jijR6WWTUTupP9k2ZdWUn9Z8zIKSbaZAFpxiRO4cYw+wKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOwsOI+y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19A606A32C;
	Fri, 27 Nov 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOwsOI+y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851CF1F000C1;
	Fri, 27 Nov 2026 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793589;
	bh=0/nTWV6qM+caWLX6wOpXvstHX8JRYMb2GFwuAiImwMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VOwsOI+yQ2IGPDLki6KQQLsyxsCC5jGTm2NUw2XrTmkQMZjHDR5gVxKtap6CM43V+
	 VCs1jW2MV8l7J8I5htjCXVIQEe7w7IxCtedA/uaKm9LGRHL5Wak3EpaoEq7o4MiHcL
	 74MOajQGpKxB0YueRycVlITs/9tAfL5q9QhWjBEXg/W7OeYWUk5Cz9CIHv1HYfemxD
	 7dg902l7X0HGf1BTQm3yoQRK5/Aj1rW7NrxUujBsXAGHqzifPvvM246WOXMQ2E08c5
	 XZcwYlMynTs4PSYpNSPvlMI19QB7ogTRKcjW4VUWNp5pFdfLaeptMNFmqHBOtL6MGl
	 RePGXlHwtbliw==
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
Subject: [PATCH v2 09/10] spi: cadence-xspi: Advance tx pointer between Marvell b0 chunks
Date: Fri, 27 Nov 2026 15:31:12 +0000
Message-ID: <20261127153158.2969573-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127153158.2969573-1-lee@kernel.org>
References: <20261127153158.2969573-1-lee@kernel.org>
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
v1 => v2:
 - Rebase onto spi/for-next; no functional changes.

 drivers/spi/spi-cadence-xspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index f8157757b2f9..aac941aecd47 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1343,6 +1343,8 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 				cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
 			}
 			cs_change = t->cs_change;
+			if (t->tx_buf)
+				txd += current_transfer_len;
 			t->len -= current_transfer_len;
 			m->actual_length += current_transfer_len;
 		}
-- 
2.56.1.839.g22a8290db9-goog

