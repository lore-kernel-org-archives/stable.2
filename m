Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102337;
	b=tzlWitQEl3rMIe8X9BIWMHylv7UOojenDSe0LpRLMDgTpts+r+1rfS9oykQrdOlw1Gvx
	 GbkC1R+6D8dSgC29XyK99XCU7ZIvl0kmn57+uef2yZXK2d97+G2GUVpV9FFvDYq7Sycb+
	 0dFODI39cAAzWAuDxhaPG8Sz1vQmQ1z661eIqmkkkVH9YjVZ7Jh3UhmJFd4vWuGkHwhfx
	 RIGL5+KBwNjZ5d6Nlk2ATGYUzcagYGGyyQ6gW07t+PBJdEE3CeZL4Xkl8W8BhdVBeDKL0
	 XWyaRksMpcdy9fAOs+SZX4IfndPtKHYlfDU/5WJkqad5WiKq9vjniWbpP5haeYVDELg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102337;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UW1YRQLobMQSz/Bf0uVAdOmHngp44w7eqCWrGUPaY7E=;
	b=xzCoNFufWNY4szfFr+xtEbr/inC0u+HZ4YGKbs7eG6YoYRC3pgPu5H76mvElfdcbgRiW
	 i3g5kSULPwmq+dwSQey3FzJxk1Zb7AzmCmexYgDmfiW7BE918dYrqrn3jfjFbFPpD/SX5
	 1VnaZAmD0h6pUNAuoJenW+3NCSv1F0Y5Je34aXT/W95Aj72qXypg6wp5J/6u3vj1xRcj2
	 iA/GCaw/Y+FW7iVp9rqikLtGvqtGsTj3alRPa+Egt5cpnUCuD0nCw/GXxMfpfbEllDVyK
	 5uAcoKEtxe7Lk1/UMBkj7h2BXPBj5Q4ZMpRqlywXo6UXPCcJZa3UwLCtlligz2T5s2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRhplDKe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBA60A2626;
	Thu, 19 Nov 2026 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRhplDKe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B751F000C9;
	Thu, 19 Nov 2026 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102336;
	bh=UW1YRQLobMQSz/Bf0uVAdOmHngp44w7eqCWrGUPaY7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRhplDKex6Nf1fBbQnRsg0W2n/vHX9YHr8HPz+KqaLjoFt/fHVGIaZi9OYNGuxIMY
	 Zdp+kDO5WBULSvipzsdL1jG+Nseek8JZ07MuBXFO8dsFXuOZjd7FxwLzFLnrPAX744
	 +05K6h982MhKx5JwzK5vWLcZY2YVbn/shHTBMj4rYAcOLA634uGuCpwjWnnKfWRZMv
	 gwgaX3jdJaQY5acoeQBQ1JkuJw98Fyj6ieNWsH+awHyQWYXUGOnajiMBv8aJbUVbV2
	 aAl/QRqA0yQP85V9zTX8e6ljuL6oS/dX04O/5eHFMn4D89Le19KY14K3pspNhvyhJl
	 LjExOSmEMXwdw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 02/10] iio: accel: adxl313: Prevent FIFO buffer overflow in adxl313_fifo_transfer()
Date: Thu, 19 Nov 2026 15:30:35 +0000
Message-ID: <20261119153151.1397003-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119153151.1397003-1-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
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

The ADXL313 32-entry FIFO plus one sample held in the output filter can
yield up to 33 3-axis samples (ADXL313_FIFO_SIZE + 1).  Because of
missing parentheses in ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1,
fifo_buf is sized at 97 16-bit elements instead of 99, overflowing the
buffer by four bytes whenever all 33 entries are read.

In addition, adxl313_get_samples() returns the 6-bit FIFO_STATUS entries
field (0..63) without bounds checking, allowing a malfunctioning or
spoofed bus device to overflow fifo_buf on the heap in
adxl313_fifo_transfer().

Parenthesise (ADXL313_FIFO_SIZE + 1) when sizing fifo_buf and reject
entry counts exceeding ADXL313_FIFO_SIZE + 1 in adxl313_get_samples().

Fixes: ff8093fa6ba4 ("iio: accel: adxl313: add buffered FIFO watermark with interrupt handling")
Closes: https://sashiko.dev/#/bug/linux-6baeb7fe-ad68-4961-b5f9-5f0c7628df1e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/accel/adxl313.h      | 2 +-
 drivers/iio/accel/adxl313_core.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 75ef54b60f75..de0bccfcdd0a 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -93,7 +93,7 @@ struct adxl313_data {
 	struct mutex	lock; /* lock to protect transf_buf */
 	u8 watermark;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
-	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
+	__le16		fifo_buf[ADXL313_NUM_AXIS * (ADXL313_FIFO_SIZE + 1)];
 };
 
 struct adxl313_chip_info {
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 6dc918c4ae17..72ef8652d398 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -921,7 +921,12 @@ static int adxl313_get_samples(struct adxl313_data *data)
 	if (ret)
 		return ret;
 
-	return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
+	/* 32 FIFO entries plus 1 entry at the output filter */
+	ret = FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
+	if (ret > ADXL313_FIFO_SIZE + 1)
+		return -EINVAL;
+
+	return ret;
 }
 
 static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
-- 
2.56.1.708.g77570a6a1d-goog

