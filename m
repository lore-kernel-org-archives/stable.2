Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079967;
	b=g8FsLA5tDZfIBO0hTj0kX9qXM/Ilse/KsY1lEzWiOU6Fo5vBT3Tt5I5/zOcaRXNI8bTj
	 Z8bm1AJfDaSdcQRUyqOA8l8wKS3VALaGqPn3SUnfJdQSNcZhrmV9jbNQiU3OtHXuBR7B8
	 P/hRClvsMVx/FotYZI2yFjNjE3n15mamWiHBH9ahc2qDj5jPj5xveaO3csksy3IH9gZzW
	 8IROqldKpF5jbsLsgCmQb6h1LUhmPXQe5qCeFEw/vsJPiyemyh5Zk7kxB/AEIEjGtQalB
	 kKrUsm5KWJKPLP9w4YcHPKmlCsh3bfqjNncTQ0pBN5i2DQokkmtOla4zaIgFpjHMywQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=STK9ZpfNos3+Nxtqh4zAepk2/6TXCoH1pGSTeeq0pDg=;
	b=j86Dn7VCaWc8hcq0H/c/C/Ssd9hwuanhwCQjgIYN2xsgZ7aOHTK91tKLYasgpXvfQT1e
	 pPXG56ceegTsXLsCq+0SWgwaC+n14AznKbWstWKVpCJY6bmxOFNghgJrt7KuOLH53tPEm
	 E3HksfQMT2+tWC1kXuToZaJKMlHxFJcUlqBDvryhAGs+3avsnl/Sp0OZOCpHRuIQu8Aew
	 JHlkbcIqi82mGxZgiEgmMTor4NPQy0U8F/MQoplJCw9xc3QexwRzIWJIYwuUGb/21s7QP
	 muclkA65MrWnnHzVbX9hGopzC8xMlCvO5Bc4X1dEVuDkdT+0itQl9oBzAAAyHP3kPGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BiL/fK68";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E6606A33D;
	Thu, 19 Nov 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiL/fK68
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831501F000C8;
	Thu, 19 Nov 2026 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079967;
	bh=STK9ZpfNos3+Nxtqh4zAepk2/6TXCoH1pGSTeeq0pDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BiL/fK68j70Yyx5AXjXgMLkcAe3z7dEAKCA392ik7Nfn/EXK99tdLvAWobuwSfY/Q
	 F5bGqPG563i8+IzTNPuaMPcjPVJm+PKBA0cy2MXWgj29YZBTOM4lVzqsUABW247YiV
	 lg0R7siAzWSs/xOU7GV0GiBK9rKKs75qOZ/cT1CijT404R6nvdliZlId1mG850y/Yd
	 5CKLEiAFkt1ulPOG/DQLeHUCtHsPs/qO1U+A2iClnY3Qf89IeWegyeKKE2NFom6Nj0
	 BMRn+vd5ZQbfds8rmwg8qYpT7GmZkdHy9RZSN0EXBlvx82maEk0oorD2bhq8M6yJ5Q
	 N1qBSW/OVR/qw==
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
Subject: [PATCH 10/10] spi: cadence-xspi: Skip tail read for qword-aligned Marvell b0 receives
Date: Thu, 19 Nov 2026 09:17:22 +0000
Message-ID: <20261119091810.3440619-11-lee@kernel.org>
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
 drivers/spi/spi-cadence-xspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 4c9af6146a5d..bd0fdbbd4060 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1309,7 +1309,9 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 
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
2.56.1.708.g77570a6a1d-goog

