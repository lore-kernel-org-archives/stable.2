Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793596;
	b=JBYqbGFtJiMFg2rtVkQVF8/iDvPJcvsufu+V0bwLUKJ/CJQbBbJ0zID3NQsDxIf41JgS
	 NhCNwWYtKEdIor/JIRIxdp4xPk/oeVfNHzGbwdtQ/unFidwvXuZ30Ta8Q+3rs/ftk1M4D
	 PVDJN5rVijXe09Wgvpmcv30OkBzP9+uANZmVkB4lYFiR5l0sxdTZAzXUxsFx19YXet7Bx
	 53SW2QhKgcW/9Ayrf/K6d9wLe13Xr7wLJeE84H3tRgIvuSpoBYaUMRNb/9tzeR5iV1YRl
	 CUI10fPd87g5/Qy7lnZ16vbubUR7zubDrD4mQbwt8Sb+qALWGR5224SM5oBnwGsYu1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QR2kgEHCu/dWEXONlrY7XEez5BG9+wzt7+gIHHSGas8=;
	b=R2KKY299hctJsEL0UBERHfiTH+8h1tUPwbx3eZK6Bmh1gdxQu1fJ+5oDhqa7jhFiIzFb
	 pJrPhHvnQx1hkvCFNDg3wXEJkozeq+eyNt1rtMlRyrqZdXcfmjwpTkLP2FJQLHcv1aPd8
	 Tfg1HPmvBbZco72mnsolMDewnNqmjEo6Y3xl6LUThkkRX9q26FHqCVr5WrQp5Ao2YHDm/
	 GxuLtU3PpY9rWgKLlKVXztGyhjzP52vhDmp/Rzs8XA6s76qKWstq7pEzHvn5GuipgZbOI
	 3raPPrPxyEGJleC5zW75YRHGsQBUOOAMVYMcMnZXRSdyOSNfxE9VlDpwcghI1GkvbOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="otmLjJ/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B44606A31E;
	Fri, 27 Nov 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otmLjJ/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C871F000C1;
	Fri, 27 Nov 2026 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793596;
	bh=QR2kgEHCu/dWEXONlrY7XEez5BG9+wzt7+gIHHSGas8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otmLjJ/xTHsjjhBH/OR/xNnhNj12+4nONqT9Bx+nDTczXKYJrdhIw77+vbLgwF525
	 YQ+MnctLCMBqIndTU1gkbr53E8g2oe0UqYD0Fn8cjKGJSV0hrwNfcdqnK00J67knmL
	 lfSZ47gJ+1Ce4ilY4hO08YenY9IJiNqFOt4N/7JbPxL+FUzBbl+r3yhiejJbJf5aL0
	 mUxpTt+M2vLgsupT4+C3ph4Ui00ICl5t2E6YImnvs2r6ZcPr+aVsEyzQyGC89mfOeO
	 f6/w47/CD5DZjTT8HQdC6ebc9pkIxXeAjGKL00dXfpLy1ppbvpWSb263DBy2ZV3Uio
	 Ulx3qbshK9QqQ==
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
Subject: [PATCH v2 10/10] spi: cadence-xspi: Skip tail read for qword-aligned Marvell b0 receives
Date: Fri, 27 Nov 2026 15:31:13 +0000
Message-ID: <20261127153158.2969573-11-lee@kernel.org>
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

In cdns_xspi_transfer_one_message_b0() the receive path reads len / 8
full qwords and then always calls cdns_xspi_finish_read() to collect
the remaining bytes.  cdns_xspi_finish_read() unconditionally advances
current_xfer_qword, even when there are no remaining bytes to read.

The TX-only path only accounts for an extra qword when the length is
not a multiple of 8, so for qword-aligned receives the read index runs
one qword ahead and later chunks and transfers in the same message read
the wrong READ_DATA registers.

Only call cdns_xspi_finish_read() when there is a partial qword left to
read, matching the accounting used by the TX-only path.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Closes: https://sashiko.dev/#/bug/linux-13cf6f1e-c300-4fa1-9cd4-08a48ec4f4b9
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Rebase onto spi/for-next; no functional changes.

 drivers/spi/spi-cadence-xspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index aac941aecd47..159b18f2f728 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1333,7 +1333,9 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 
 				for (j = 0; j < current_transfer_len / 8; j++)
 					marvell_xspi_read_single_qword(cdns_xspi, &rxd);
-				cdns_xspi_finish_read(cdns_xspi, &rxd, current_transfer_len);
+				if (current_transfer_len % MRVL_XFER_QWORD_BYTECOUNT)
+					cdns_xspi_finish_read(cdns_xspi, &rxd,
+							      current_transfer_len);
 			} else {
 				cdns_xspi->current_xfer_qword += current_transfer_len /
 								 MRVL_XFER_QWORD_BYTECOUNT;
-- 
2.56.1.839.g22a8290db9-goog

