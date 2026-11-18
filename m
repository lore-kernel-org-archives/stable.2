Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006586;
	b=Il3UTTeoTvtYLGgUWKmYoqZ9UL3k7gonlU4reZCE22nDWReINGcL3ZTlW3xNcTzc+Rbo
	 Ny08tY9nC23c3mFK7qa4M+b+S4cYrgFTVZecNU98QkFV3T8cKyr84VWsLteoUYirKKLXq
	 bcSwNdAMS1gtlD6e1dQX42MUGzVRa8LTU6z21jL7pMzdMBuAUzjjLIR567zqw+8/uuP9F
	 xkOH5Upgh6pX6aTS9HWJfoFBtvceJCz1c8D/acjSppQJoXqVexrmKgqR4+iJzX3XAYnbZ
	 fCRTwtWTjEQaz+3mxBq0wb6QWaRXfRzIqHpFFXlI2PmhA/Z9rXEHOBPo+50HqnbIZEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006586;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=L97f02qH7wQfYceicHLsDzYmsR8E4X22KagheN2MNP0=;
	b=nR4jr4J5r74yl2JId4dsXgGYFuZFpSI3bDs3p+LagPL4Dpxk82v+OX0jv3LZptPKRVnk
	 EXBn/OercT4IeVCABqZhEDdWIzMsxRzeRnGdJKRHS3/tSgSvt8wB4WsdWJAmeO15fNsdL
	 MN1IN11FHQFArWHJwFgTsQauxLv7kFm9kzsBPRw7JqRAFJmul2ShX5vcc8PYGjLPophxA
	 tPsmcDLE5NBHvbNuo5OF4FQSANMskusiktHny8QvQrczrurh2qAjhwIa20lbV9hW1R+RN
	 pl4nR/zwPp8CidNcZtfEFrCDhTQXmHqi00q3gESCXg4rVPl7+ik/lY2JS+3+SqNUfEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CnNfdegi;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA08606A320;
	Wed, 18 Nov 2026 12:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA08606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CnNfdegi
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AICLNdr3278880;
	Wed, 18 Nov 2026 12:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=L97f02qH7wQfYceicHLsDz
	YmsR8E4X22KagheN2MNP0=; b=CnNfdegitsNITI5vuFSlmC0rbBl+4XSb2LeAnF
	NHTKAdW9Fm9BlM+ExY84xroRWl7z2rwV5FrdjNFdaJaHmE0BbGMb/9awXijWtjbS
	lDN4ZYlKql8W0xZ6X86dCk6fUkP1YBnssZq/b7MJOWH757AQdqdaJA/ABNoV6BsL
	JSZ6kPP//I3JxLMWtujBnJlHEmBCpDys5RDhU86EjnkgU8OkNLEHxIhk2DLR/XHe
	mjZY84hzR2J2lY3kAGYj7x1vmHKdRccMYqxeMUa+Y4jxwLMPMHuhAzdW/9119WMs
	LItEVOt+KqcU52c7q5UfbIDETTLQBZsViTEmAd+g83o7Jm0Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9k1ts-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 12:56:23 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AICuKp92734477;
	Wed, 18 Nov 2026 12:56:20 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-somedey-hyd.qualcomm.com [10.147.252.89])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AICuJRQ2734469
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 12:56:20 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4179325)
	id EF2BC654; Wed, 18 Nov 2026 18:26:18 +0530 (+0530)
From: Somesh Dey <somesh.dey@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 18:26:07 +0530
Subject: [PATCH] spi: geni-qcom: Fix sub-byte transfer packing and length
 calculation
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-spi-bpw-fix-v1-1-e475586ca8e8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGag/WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0ML3eKCTN2kgnLdtMwK3VQTs1QTI/PkVAvzFCWgjoKiVKAw2LToWAi
 /uDQpKzW5BGSEUm0tAJO+b/dvAAAA
X-Change-ID: 20261118-spi-bpw-fix-e46e427ce87d
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        stable@vger.kernel.org, Somesh Dey <somesh.dey@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795006578; l=8020;
 i=somesh.dey@oss.qualcomm.com; s=20260825; h=from:subject:message-id;
 bh=/vsBZYD7cQcupdE96y51pMZ9cxnTOxfRg/nb38EoQE0=;
 b=Z5tTSfIZLqglCBOEndB0V80NRBuF6KiCbSS3E/kpVc391AZlsftu7gq4ARhyv4yWXYMAoCGI8
 NMpI4SlIkIKCTqBYnchhkxWVXMyCatwvIsuYBIMFKDjUNRwfJPn88LY
X-Developer-Key: i=somesh.dey@oss.qualcomm.com; a=ed25519;
 pk=EdQJd0pMlRfHEn3JzZEcik8VU5W2ZWq2FMeS/v9VJ18=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=QenzLcbv c=1 sm=1 tr=0 ts=6afda077 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-czx3EHt1O5zhySWHf0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wwLDG5R-6o9rGBxlwNNiTZKU7Q-a17XU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MSBTYWx0ZWRfX0zEAE31RIjDs
 geGmYV2IyAP0F4ztVPTDO0Bf250uImvYHslSX49u3NYOD0fvOMXGU3NK9h1Cxr1UxJsCwIu9rIi
 BmDh67NPfkGgbdXdqYyTaQUTSL1qdm63o4pYyuoPWZhS2x8jUWe29cMbIcPLloFDcDHSfNk+3BR
 MGzNjj8Ma63HR0hZsGg0/7/dVDOwiGG3+3TmpcC4yQ10AqKoZ5icsOVVRkyF+8DnbYsXkOBEZ/V
 Z7lwRvALZ4GH8DhIaMLv7CtXCWU9DSTE53s9BBH0ItikY7gTeXGfEwXJgfIILbN9dLPm/iPa7wp
 BSm3AjrmyItdUkdftXGACSjOhO2CtjV7SjXksqwXPOaROriv7+Yof3L3ZR9/QbAYFJpgSzpIAwk
 +EduPBkNuqhKdKGmuXzq8l7Ptn+Axgh0mtc1SEL8NQHUGIHbHElQDO4GhNexOtL1GFAvI22kkl4
 CYmhfxxtz8dcXhse3eQ==
X-Proofpoint-GUID: wwLDG5R-6o9rGBxlwNNiTZKU7Q-a17XU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MSBTYWx0ZWRfXyZbMlEUg4xG2
 05ZRlqlhSIYppqaRv4ondcYHrpXp13ENEskmkDS/XER3OjThvJiZb+HnfMwpl0V6J5z9iwPa9pT
 MYH/C9pfF7ft48vdINrCjpQQam6oSR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180051

On iq-9075-evk, short four-bit SPI loopback transfers can time out
immediately after boot. The failure is reproduced with spidev_test:

  ./spidev_test -D /dev/spidev0.0 -s 2500000 -b 4 -l -I 10 -v

The test reports "can't send spi message: Connection timed out", with
the following kernel messages:

  [  732.730335] spidev spi0.0: SPI transfer timed out
  [  732.735216] geni_spi 880000.spi: Can't set CS when prev xfer running
  [  732.742882] spi_master spi0: failed to transfer one message from queue
  [  732.749619] spi_master spi0: noqueue transfer failed

At BPW 4, the driver requests eight protocol words per 32-bit FIFO
entry. The GENI helper needs one packing vector per sub-byte word
but only supports four vectors, so it returns without programming
the packing registers. This leaves the transfer dependent on the
previous packing configuration.

The driver also assumes that a buffer byte contains two four-bit
words. Linux SPI buffers store each sub-byte word in a separate byte,
so the programmed transfer length can exceed the available data.

Use byte-sized packing slots for sub-byte transfers and derive word
counts from spi_bpw_to_bytes(). Share the packing count across hardware
configuration, FIFO accounting and DMA selection. Account for storage
padding in the last received word, and drain leftover FIFO entries
without relying on a cached word width.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Cc: stable@vger.kernel.org
Signed-off-by: Somesh Dey <somesh.dey@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 81 +++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index e239c4333055..6dcaa31b3304 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
@@ -306,22 +305,26 @@ static bool spi_geni_is_abort_still_pending(struct spi_geni_master *mas)
 	return false;
 }
 
+static unsigned int geni_spi_words_per_fifo(struct spi_geni_master *mas,
+					    unsigned int bits_per_word)
+{
+	/* Each sub-byte SPI word occupies a separate byte in memory. */
+	unsigned int packing_bits = max_t(unsigned int, bits_per_word, BITS_PER_BYTE);
+
+	if (mas->fifo_width_bits % packing_bits)
+		return 1;
+
+	return mas->fifo_width_bits / packing_bits;
+}
+
 static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
 					unsigned int bits_per_word)
 {
-	unsigned int pack_words;
+	unsigned int pack_words = geni_spi_words_per_fifo(mas, bits_per_word);
 	bool msb_first = (mode & SPI_LSB_FIRST) ? false : true;
 	struct geni_se *se = &mas->se;
 	u32 word_len;
 
-	/*
-	 * If bits_per_word isn't a byte aligned value, set the packing to be
-	 * 1 SPI word per FIFO word.
-	 */
-	if (!(mas->fifo_width_bits % bits_per_word))
-		pack_words = mas->fifo_width_bits / bits_per_word;
-	else
-		pack_words = 1;
 	geni_se_config_packing(&mas->se, bits_per_word, pack_words, msb_first,
 								true, true);
 	word_len = (bits_per_word - MIN_WORD_LEN) & WORD_LEN_MSK;
@@ -451,13 +454,7 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		peripheral.rx_len = 0;
 	} else if (xfer->rx_buf) {
 		peripheral.cmd = SPI_RX;
-		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
-			peripheral.rx_len = ((xfer->len << 3) / mas->cur_bits_per_word);
-		} else {
-			int bytes_per_word = (mas->cur_bits_per_word / BITS_PER_BYTE) + 1;
-
-			peripheral.rx_len = (xfer->len / bytes_per_word);
-		}
+		peripheral.rx_len = xfer->len / spi_bpw_to_bytes(xfer->bits_per_word);
 	}
 
 	peripheral.loopback_en = !!(spi_slv->mode & SPI_LOOP);
@@ -522,15 +519,7 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
 				struct spi_geni_master *mas)
 {
-	u32 len;
-
-	if (!(xfer->bits_per_word % MIN_WORD_LEN))
-		len = xfer->len * BITS_PER_BYTE / xfer->bits_per_word;
-	else
-		len = xfer->len / (xfer->bits_per_word / BITS_PER_BYTE + 1);
-	len &= TRANS_LEN_MSK;
-
-	return len;
+	return (xfer->len / spi_bpw_to_bytes(xfer->bits_per_word)) & TRANS_LEN_MSK;
 }
 
 static bool geni_can_dma(struct spi_controller *ctlr,
@@ -547,7 +536,7 @@ static bool geni_can_dma(struct spi_controller *ctlr,
 		return true;
 
 	len = get_xfer_len_in_words(xfer, mas);
-	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / xfer->bits_per_word;
+	fifo_size = mas->tx_fifo_depth * geni_spi_words_per_fifo(mas, xfer->bits_per_word);
 
 	if (len > fifo_size)
 		return true;
@@ -724,16 +713,8 @@ static int spi_geni_init(struct spi_geni_master *mas)
 
 static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
 {
-	/*
-	 * Calculate how many bytes we'll put in each FIFO word.  If the
-	 * transfer words don't pack cleanly into a FIFO word we'll just put
-	 * one transfer word in each FIFO word.  If they do pack we'll pack 'em.
-	 */
-	if (mas->fifo_width_bits % mas->cur_bits_per_word)
-		return roundup_pow_of_two(DIV_ROUND_UP(mas->cur_bits_per_word,
-						       BITS_PER_BYTE));
-
-	return mas->fifo_width_bits / BITS_PER_BYTE;
+	return geni_spi_words_per_fifo(mas, mas->cur_bits_per_word) *
+		spi_bpw_to_bytes(mas->cur_bits_per_word);
 }
 
 static bool geni_spi_handle_tx(struct spi_geni_master *mas)
@@ -741,7 +722,7 @@ static bool geni_spi_handle_tx(struct spi_geni_master *mas)
 	struct geni_se *se = &mas->se;
 	unsigned int max_bytes;
 	const u8 *tx_buf;
-	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
+	unsigned int bytes_per_fifo_word;
 	unsigned int i = 0;
 
 	/* Stop the watermark IRQ if nothing to send */
@@ -750,6 +731,7 @@ static bool geni_spi_handle_tx(struct spi_geni_master *mas)
 		return false;
 	}
 
+	bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
 	max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
 	if (mas->tx_rem_bytes < max_bytes)
 		max_bytes = mas->tx_rem_bytes;
@@ -781,25 +763,30 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
 	unsigned int rx_bytes;
 	unsigned int rx_last_byte_valid;
 	u8 *rx_buf;
-	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
+	unsigned int bytes_per_fifo_word;
 	unsigned int i = 0;
 
 	rx_fifo_status = readl(se->base + SE_GENI_RX_FIFO_STATUS);
+
+	/* Clear out the FIFO and bail if nowhere to put it. */
+	if (!mas->cur_xfer || !mas->cur_xfer->rx_buf) {
+		for (i = 0; i < (rx_fifo_status & RX_FIFO_WC_MSK); i++)
+			readl(se->base + SE_GENI_RX_FIFOn);
+		return;
+	}
+
+	bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
 	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * bytes_per_fifo_word;
 	if (rx_fifo_status & RX_LAST) {
 		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
 		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
-		if (rx_last_byte_valid && rx_last_byte_valid < 4)
+		/* Include the padding in the last in-memory SPI word. */
+		rx_last_byte_valid = round_up(rx_last_byte_valid,
+					      spi_bpw_to_bytes(mas->cur_bits_per_word));
+		if (rx_last_byte_valid && rx_last_byte_valid < bytes_per_fifo_word)
 			rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
 	}
 
-	/* Clear out the FIFO and bail if nowhere to put it */
-	if (!mas->cur_xfer) {
-		for (i = 0; i < DIV_ROUND_UP(rx_bytes, bytes_per_fifo_word); i++)
-			readl(se->base + SE_GENI_RX_FIFOn);
-		return;
-	}
-
 	if (mas->rx_rem_bytes < rx_bytes)
 		rx_bytes = mas->rx_rem_bytes;
 

---
base-commit: 7cfbf79c66c63e807ea452abf0546e6f6d6833a6
change-id: 20261118-spi-bpw-fix-e46e427ce87d

Best regards,
--  
Somesh Dey <somesh.dey@oss.qualcomm.com>

