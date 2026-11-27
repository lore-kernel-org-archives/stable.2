Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793561;
	b=KwTH2ei9+5u/cYjfbxuMDY+ruGkb04mbnUjX0z6DJgQTJcQAFBj/oG1ucg3JHUMaNnRS
	 eelMECSq78RdPLI3Gqgvy87qEhXlOGycB8g9diyzl6aHhcxpKi7H2xcd0gQ2SGVTOOwf2
	 rhinM91JgxkaMHAV1Blg/xFrwU/Z8ktGGdAp3QZhZ2xYwsd8LhRjkzIduh+HCfPgM/GN/
	 1ICOJBmh7YlNyTn3RThrKAfNyhbYRVlAGJhd8L/Igj3tkiDyJQ78NQ3S8nfoPFmBNPSv1
	 q/KtRlCwsLORu2ZcGGuSIm2Yt7kSsmaQPvDPq1BGwFN6h9Ea21xe65zM7ITkuW7lTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0gIlXVQ87uO7kfJWQw74uLJzWa1rKvwJQf0oUC7TuyI=;
	b=McoWckMIoTUIurihPCbZT2tKliCRWYQZx0oIZPridJ3UGpFFU7EIQv6h7ygmzpPZTyUF
	 6uHSq16EtZhrHdtHgIWoi4fq4jI7tuoTcWyvVL9wQObrJiV1ZSUlMmTcPLmjKZFiVqwRp
	 RHAdZn39zeqE6qab1dOkpWDFlMeMS79r0af57PowZaRm0cAl7JFhDklUU3y9ZeQFb4glv
	 gHbnZUl3qdSYYW5MfduV2BmBd2n2TQN/JJAELGXdUxuZBj9pLOu4EtLUk0UfoYH9tSg6A
	 qHirSEadgelfMkq4xSa61P/LfSmOvi0WQ9JOEn0mOS6sV1/e5jBo9izqc9IByYjwpBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5Mo3Nwv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D13606A31C;
	Fri, 27 Nov 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5Mo3Nwv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FC51F000C1;
	Fri, 27 Nov 2026 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793560;
	bh=0gIlXVQ87uO7kfJWQw74uLJzWa1rKvwJQf0oUC7TuyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C5Mo3Nwv8cVoWh1uzGDbcfOGefJYapYzDVJTdSCtlTwbHtNBUrd4jBdSzP5hn/0IJ
	 YBs4dScZXrux7mLAiabl2W8ayLr+tqL/eUAvOjFcn/PHeWr5gDNk2lvNpzzY4JVGlS
	 hLdllNkZ+5txf4n52Mk2PTmDWRKWFYEIKVDKCe7VnK2Rhj9FSQ0WBMUWbUHvLyUNl5
	 AMYdjrWTsRGCJmBYwWY1BFIyGveV8I+J8P56ANJlciLqce25e/RDE9+rUi7LHvAzrZ
	 662y7mDRSgCZ4u4OhdCnGeVm3vI7zCG9T7+Ci4IVrrMQSAKs3jHTd6G9wBi9T71FUm
	 3vCk1N9a8NRtQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Tomoya MORINAGA <tomoya.rohm@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 05/10] spi: topcliff-pch: Advance tx_buf between DMA chunks
Date: Fri, 27 Nov 2026 15:31:08 +0000
Message-ID: <20261127153158.2969573-6-lee@kernel.org>
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

In DMA mode, pch_spi_process_messages() splits transfers larger than
PCH_BUF_SIZE into chunks and calls pch_spi_handle_dma() once per chunk.
pch_spi_handle_dma() copies the TX data through a local pointer and
never stores the advanced position back into the transfer, so every
chunk after the first retransmits the data from the first chunk.

The RX side already writes its advanced pointer back and restores the
original rx_buf once the transfer is complete.

Do the same for tx_buf, so that each chunk sends the correct slice of
the buffer, and restore the original tx_buf once the transfer has
completed or failed.

Advancing tx_buf by the number of bytes copied relies on the following
commit, which ensures that each chunk covers no more than the bytes
accounted for by the loop in pch_spi_process_messages():

commit 3515e312e096 ("spi: topcliff-pch: clamp DMA bpw_len by bytes
not words")

Fixes: 7d05b3e868ee ("spi-topcliff-pch: Fix issue for transmitting over 4KByte")
Closes: https://sashiko.dev/#/bug/linux-625e2f07-fb68-446b-b1a8-b1f66aacb62e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Rebase onto spi/for-next; no functional changes.

 drivers/spi/spi-topcliff-pch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 0bec3012a6bc..cbe76c4ae2e8 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -947,11 +947,13 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 			tx_dma_buf = dma->tx_buf_virt;
 			for (i = 0; i < data->bpw_len; i++)
 				*tx_dma_buf++ = *tx_buf++;
+			data->cur_trans->tx_buf = tx_buf;
 		} else {
 			tx_sbuf = data->cur_trans->tx_buf;
 			tx_dma_sbuf = dma->tx_buf_virt;
 			for (i = 0; i < data->bpw_len; i++)
 				*tx_dma_sbuf++ = *tx_sbuf++;
+			data->cur_trans->tx_buf = tx_sbuf;
 		}
 	}
 
@@ -1180,10 +1182,12 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 		if (data->use_dma) {
 			int i;
 			char *save_rx_buf = data->cur_trans->rx_buf;
+			const void *save_tx_buf = data->cur_trans->tx_buf;
 
 			for (i = 0; i < cnt; i++) {
 				pch_spi_handle_dma(data, &bpw);
 				if (!pch_spi_start_transfer(data)) {
+					data->cur_trans->tx_buf = save_tx_buf;
 					data->transfer_complete = true;
 					data->current_msg->status = -EIO;
 					data->current_msg->complete
@@ -1196,6 +1200,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 				pch_spi_copy_rx_data_for_dma(data, bpw);
 			}
 			data->cur_trans->rx_buf = save_rx_buf;
+			data->cur_trans->tx_buf = save_tx_buf;
 		} else {
 			pch_spi_set_tx(data, &bpw);
 			pch_spi_set_ir(data);
-- 
2.56.1.839.g22a8290db9-goog

