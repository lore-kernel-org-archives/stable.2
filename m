Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079933;
	b=fKEXeSs0PJTcrJZTxYYG2QpfMZnHynUdEecX486N8jMdrlPkK4RBzj9JtHhP/qyu5B/n
	 SeKn+HYn+APZuZUSaZ4Nbvy+mxEqPs6PdQedQABUIjLlYhpPvImFnmNZm1RPD3wvykxvs
	 LLNMI8vj6YctNyi8guWVY1HJkFGbaN+GHQqzjoivAUSxKDYavl44s9XitEZZuTdGW54xM
	 bXRw58/aPxUtnKpKc5DTRFeh2rnZBFQqCWBptauiyP3OwRA7Q5H5HiD2sfiVtMuNN+hzs
	 zpMl201TZ938bBFypFQh4jUdxP3fVoNYzJZJwTZ+6Dsm5k49WtsGGUvVPSx5rF1OQag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=589dD2JUC4L0PJxzRZvDg0zDc5A2k8fOfmKe7QntBu8=;
	b=S0NF/39GDtZ9TDD0qyEDbAv/6PIBRFxRCM9U+8gRy/g30DdYFd9aNviqNFa85536bYZ6
	 HfDV3Z/LI1xDfSVwoTIJxJAqvqDlZBTp/ZN8F7fxahFwPsLHzb6ghrNYJ9k7dGsJ0JsiH
	 xY8dMyaB3HOiO5ZhsbP37Pf4xITDuEfXQNoEWohWzuC6xpLkS5UvrdfZhqOhYBcB/bE9b
	 TlwZhwFIGHBf/5oPc9RLTRcIkOwDCUMmWd8eaXMtoMCpAMufzz7zax0SgoirzUccTa9YO
	 g1JU9fCLFaw63hGDtJKg4vWZOZaOZT7ZEgU3KKDUDUji0WF0FQDaHJqPr9cUdXZrrTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSKHGfc5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599BA606A334;
	Thu, 19 Nov 2026 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSKHGfc5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B330A1F000C6;
	Thu, 19 Nov 2026 09:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079933;
	bh=589dD2JUC4L0PJxzRZvDg0zDc5A2k8fOfmKe7QntBu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DSKHGfc5q/D7fqJnkceCBSJzmtvzyiAA94BOzGOg6bkVrg3YPAEV6s9qeGvU/WuhC
	 /oRtId5KwaTZpMa5AZCfBBDKh8dqpGk3b5vkrY19kcYWb3OxJYJP0TGirWOllila1c
	 rdE2sNqwn2VTnfBbqEx1gb3t5H0e8WnYr8UcjS+gvXjvujyIzzUCGAzLjYI7KR/jxe
	 idN9sfTeqRV4nH+GY0w16W9CT8IP1KC5xiFSWd7CK7bsk2ue4bOREZyF+Ara5P8+vH
	 XgGLN64w7R+Jsh0S9T98V5QYk5QPI4vLCt4m+NTwWRIhpRHaT8clNb0g0a+XgZKW8L
	 Fa4rRVgP2o9KA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Tomoya MORINAGA <tomoya.rohm@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] spi: topcliff-pch: Advance tx_buf between DMA chunks
Date: Thu, 19 Nov 2026 09:17:17 +0000
Message-ID: <20261119091810.3440619-6-lee@kernel.org>
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

commit 3515e312e096 ("spi: topcliff-pch: clamp DMA bpw_len by bytes not words")

Fixes: 7d05b3e868ee ("spi-topcliff-pch: Fix issue for transmitting over 4KByte")
Closes: https://sashiko.dev/#/bug/linux-625e2f07-fb68-446b-b1a8-b1f66aacb62e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
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
2.56.1.708.g77570a6a1d-goog

