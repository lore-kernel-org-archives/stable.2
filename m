Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013080.outbound.protection.outlook.com [52.103.35.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097043BD25E;
	Sun,  6 Sep 2026 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737845; cv=fail; b=Hh/Cr6W0XQYYU2lXlp6VUWVyyGe2FO1A1AyJ3/evjO1NoYAWHf2/srKLpI0k+kkDVkRUn/fRlIh3VrHdMrXj3ZEvn2J1pQMto4Hj7Hj0Yib/gnj7sc8Ika8Xec3URuzdVEtTKzDbMP0aXyqDvvt1T1kMryYBq4Ap/WMv7E5Kiak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737845; c=relaxed/simple;
	bh=W2ree0b5JgGpGU8zAS0X0CU8ZtzyxZepRc8mOVVFvlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nW5sgPfsI7K6HR3KBm+TwPPB9V3MfdHrUHGzJwY7Plw1F/4EEWWDLOTPdYbLQtjzGa1ygOLlyF8mDjsknXLrgunmAch1MQ+WMbDecY/XiOoI3KVr5G2duWNthphbiBnegmraYaV/ExFs8grUQbBBMGWzdofmMQMR7Iv6TrYpj6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=POtvSSah; arc=fail smtp.client-ip=52.103.35.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="POtvSSah"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUMp1GZGyZNHKoIlIOsl3JCPQW4Hb6Qo7g3+x6ZH3e3QUC0GgsSB+XZ7e4y+lfn8JT+btRgN0w4ofUzX/jqqWkWCcnu0pBsV11vB4omyumYILJNxyXYqRMTC+SnNEqQIbZcyy4SJ1aa5wh2QfVTHayIkbd+YOLUVVKCPf7cVxSe4XsI2APYew/NbU7nRzw/ht0jmkkQO/RJtwq+UFZdZTGAJO8157GO2A7+D/VKxqmFJ+MdURAOJBxKgicbOTulyGa2C8Qcrmj9FiAj8Bre0pFU0xO+Y0+EcujuMy9eqYuIsJOTAWmdN2r2haDDtW3bnMaM6FuvUW/Y24P/ah7Cc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRPobl82tB0PJGemzdQLZN/7SPZtnLsk0Hn6RMmNGIQ=;
 b=YQuIvz3YOdKNGngK56Da0R1heNuSwZYTBUIwnVfHixFJlKKbbZmd4JDlwyX9NhX53yrUGcpXOgcx+8QiedOnZrvWG//6rnixDZq2cjxqGkhp5dbOexJLVV58CKX0WVH/geibq1qcCI50whtCYLNU1ZOy9v3kZgnF15jKZGzaE7L7ohnfTAUuVJ580iM6LozXicLsMhkff9bgDwxiZgOrS9OhznvvD7qHr9j8rigk6tQNQJji0dDHwQrqeofdfL0aDPC5LMyXUC/PLq9SWknvx+v0ZjQEVINhcJX8cDp0tF10TzyK1/gc2+e/NPJIhLG5tGpes+NxepluE25G3n1ahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRPobl82tB0PJGemzdQLZN/7SPZtnLsk0Hn6RMmNGIQ=;
 b=POtvSSahJ+bRN789ooldpkATo4V+Acm31B78ALliJE3zylvbpnCbd9XEDU44MTJFiAqKaey75Aersb8rIDOud56mEAhoHgxZEVZosLzRz4qIDRHaE10sj3JLPC3BEXRB4dlFxPgd6TlyJQcxHVyjrOtTSiGQqIjGA/J99kbPzbSiFwT6H+Q/yHMEV2n3mE9OvBst9wGAwJbELRJFYlLoqEF4Y/0u7vSUtrdat/M0DQD/Bk+R3eGqE9u7RBLaY5qpwqNFEvOqNE2nvuNpHvbLCN2ywjWN6WuO3V6LE1qMneEU6arZZGwVfqBBANEQGKuI8C1VPbrXpM89mkDsZrMI9A==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:37:21 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:37:21 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Kalle Valo <kvalo@kernel.org>,
	Ajay Singh <ajay.kathat@microchip.com>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: validate packet bounds in RX buffer parsing
Date: Mon,  7 Sep 2026 00:37:16 +0100
Message-ID:
 <AS8P251MB0001BF71A8397CE77A82E7E2C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0555.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::8) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906233716.87729-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0c49a7-2f32-45cc-cf7f-08df0c6fcbd0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5062599005|5072599009|4140399003|15080799012|25010399006|51005399006|23021999003|25031999004|37011999003|19110799012|8060799015|440099028|3412199025|26104999009|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFtZGEfPzZ8WbNz3HVPql/qvl21SGWlol4rjvvtnbUTumFDES77vX7SoISA1?=
 =?us-ascii?Q?YwVozi4EWmYGNLODhDNvvCT3QEVTCnvWvGeUqxkPRxQjzueFTQ6hp9P5wq65?=
 =?us-ascii?Q?DtkwpwYz1gEaEgzqP4M8n8CcGbj4qggwbNFtFVEYqdqhIqSHcEGhot4Wu9F5?=
 =?us-ascii?Q?kpPb9wHsMJstwTwuia2fhzFhD51bkJKEORxIKiLS4n9A0FIUfNTFeTW2ILbx?=
 =?us-ascii?Q?8GhGCQVbO9yW5RH/SQRv5Ftk2LutNVLYPB4M9XT1zr0Hm5st87Kpg95VZCrN?=
 =?us-ascii?Q?elo11r7wBAgELQGADwIXTp5O45sG2YeMnmHMUgNZ40TRl4DqokA/NRFMzyHH?=
 =?us-ascii?Q?wPEEvhGU0uO4I/SdqfYMCmMAbfc/db69W5Q52CZyTzj+zWeLXRW5px1LaYg2?=
 =?us-ascii?Q?O4EFqS3CkpYkiv0Nu3VWERnK6oEFaN+3YHiL8GX3XM+kJ+ENRDxaQrvarhsX?=
 =?us-ascii?Q?xbgb7e/lLGRYkI5JVHw9v7nWrbFgFZxa/lL8jUnceam1bGuEQGbukbNVfnfi?=
 =?us-ascii?Q?pOnktxMezWQLV5qEo6v5N0Sj9vjUI8DCczHEDvm9iXOQk5EgEKZEJO4oomqK?=
 =?us-ascii?Q?Evud3ghKc2cQwURSbaQCBo6/T1mXxH/VrTvQKX6bB+UscIZ8l9GHcfQcdEsB?=
 =?us-ascii?Q?Vck74iK0zVwqbLqAlB9ziyxGx7hqGX448Nj/9WCuSvVZaT9mrpwBZopcgTjS?=
 =?us-ascii?Q?uWKC9ieZbn5wRv+FCOMtOAT0pIXYuw4wlrzVZvzSymjl29V3l7NMT47zJvrB?=
 =?us-ascii?Q?zgXKhyBhNCZw36cvDwc5SaEPy5zMrDd5OF9CiAuCN8KWdxk68kTRymjMsQgb?=
 =?us-ascii?Q?/dvN1dTNUSYrE+ofFU4PZs/vqXbWBx4AjsVmV5IXH5bxSK+nSEnzj6Co7dtV?=
 =?us-ascii?Q?NfWJAMUNyFbJkI8p2zQKF2/CyITCj6DL7F3FmLQbcV2Aq0DHOh+YhA9bztxY?=
 =?us-ascii?Q?lVTwI9jJVq6W1VMytysY+O1zaGCUCO8EiNpzAVjsJKU8u/9X75bomb1giRZU?=
 =?us-ascii?Q?4YdyQc2SbTfYB6ux4S1LNUYDEN0KKX/7uH7K1zPjwmFGQV7qctdB8dDzvHI6?=
 =?us-ascii?Q?uInfWfGE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MhHHXKjBSiabUkvuFUka5wA8G+cks31v3rJMoBnDeg2bPjQQizlrCF1cnfKi?=
 =?us-ascii?Q?iPNlWPKERPDxyGPT00h/GNYYJs2yCXUx1r2ZtiNJGKqg9UetFadKVCJ2IsTe?=
 =?us-ascii?Q?+UhZGPuOWBLqWSYqIuV1Ff1aRbUiSnRiniMP+X/uNxNoTWZMn3Mc8TmBEk0i?=
 =?us-ascii?Q?ezc12zDEx/YUfR5V8GaF19y6zoQOb6bmmOXAMlmyGBjbRhLmKrOHTwzHLdvC?=
 =?us-ascii?Q?JAmJJEeM/+ZT9hwHlDQiC36axMsJj0plsMcF5Ibt/TTRDYYmoVZpu4GkGnN3?=
 =?us-ascii?Q?bHzSSHgO8YaQ5tp2sxnOqxyIUCQZdwb6JOudNekX0WN5WdQiyyzlxu70QU3m?=
 =?us-ascii?Q?bXhyCcPVpYOY1vWyycZVnKDFHjE8s5T1trsBF2XtI6m3wdg2Q12cFCGxzrAL?=
 =?us-ascii?Q?CYxmCtDJLCzm45xgKnvkRKd9frXIAnYEdvc3MckFKdqIen1qJKQYOowdUC+h?=
 =?us-ascii?Q?h3I2NpB2C22qIEe3F+CxH5StMPNZL7jtP30g5JSPRaoLutlpbi2UOXj7aRoE?=
 =?us-ascii?Q?28FOqIY53VGgjdfGsdy7v+yXddHYIl+04BCV5nqrrP0sZsEaM8a1UXF+qosm?=
 =?us-ascii?Q?g1k87M8tChcQtEjL7hYbTHzICz3kU7J3NEFUAXigTQBQAebpxMr1Ohmr1oSD?=
 =?us-ascii?Q?OdXLa2DRxvp8cEtdCFgd6jM4tM1wINEwM0WNuBqgPU84fteXCwv5dquW8us8?=
 =?us-ascii?Q?QOxwVDN2LSEvdidR2PbBaFuhtRvnPYw5jJkaoVpEqdLtkPc3qGg4nei/rqJK?=
 =?us-ascii?Q?i1yX5PKANxGB5ugmsQ8xFh/e+e1+ETEt8b1bJG86sQlnQsWxg59Njs1yYLsN?=
 =?us-ascii?Q?6eRxa8WlN+U5H2Os+meHA6RVzCEWCufRd15HtppI2MjPgKjd9IrRg8vYUMfu?=
 =?us-ascii?Q?2sLB4r9SjUnLzcmlvpE3bJ2S+4T6yL3zNvvKzAivQDQaBdi/YC0hi68pk1FE?=
 =?us-ascii?Q?AqOzSpF9i0wDfy6ij6758eAtlJmuFcYdZ2BXsqtBFCBhMJ6f0nfcdShOf6qi?=
 =?us-ascii?Q?Xj4GVw3RL9kv014wZmnSAU9q4+wQ3CGxwnDqbkPkMAz/MwZgY0zk8A6ZLbT/?=
 =?us-ascii?Q?ja4jTNmR5YjrpnMq1dzuI37Zmq3lWyRs39pTftuh/6GdDLSydoG/VLV18cJp?=
 =?us-ascii?Q?r5bNw9pHw2t7mOmVvW+41vkGrgU70BBJqJnPsrUIupXAs7Od3FOSt9FMMo18?=
 =?us-ascii?Q?xRpCyIE1Zn4zPEYxGdJJDKvHgKomdjlkPNavELqvV+J6aZYfzvghcntIehcN?=
 =?us-ascii?Q?0nNfh6J38A4sqIW4xY5ki1CXW0Nvz3fKv5zOnBhK0ZuH0lnaAE/0m4CMjAZu?=
 =?us-ascii?Q?xEYRriojrSpqFcqVNlQWokq3ry/WJo07LhjHXxuw0EdfZukMz/l0ugCVRmdT?=
 =?us-ascii?Q?BUNlbDUY6dfypAbQhhjoIsQ2KxS+jWbPT3/R0d0bSrlSrpwdzHwPQru/fa1u?=
 =?us-ascii?Q?HrmC1XNtYpSdr7HnS62btYqiiMLFNEVi?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0c49a7-2f32-45cc-cf7f-08df0c6fcbd0
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:37:21.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

wilc_wlan_handle_rx_buff() parses a firmware DMA receive buffer
containing multiple packets.  The header, packet length, packet
offset, and total-length fields are all read from firmware-provided
data without validating them against the remaining buffer size.

A malformed or corrupted receive buffer can cause out-of-bounds reads
in three ways:

1. The 4-byte packet header is read with get_unaligned_le32() when
   fewer than 4 bytes remain in the buffer.

2. For management frames, HOST_HDR_OFFSET + pkt_len bytes are accessed
   past the current offset without checking they fit within tp_len.

3. For data and config frames, pkt_offset + pkt_len bytes are accessed
   without similar bounds checks.

The do-while loop condition (offset < size) is insufficient because it
does not guarantee that a full header or packet body fits in the
remaining bytes.

Fix by:
 - Converting the do-while to a while loop that ensures at least
   sizeof(u32) bytes remain before reading the header.
 - Checking tp_len against the remaining buffer size.
 - Validating pkt_len against tp_len for management frames
   (accounting for HOST_HDR_OFFSET).
 - Validating pkt_offset and pkt_len against tp_len for data
   and config frames.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 4b116fe6f9ea..3ebcd688f2dd 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1111,7 +1111,7 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
 	int is_cfg_packet;
 	u8 *buff_ptr;
 
-	do {
+	while (offset + sizeof(u32) <= size) {
 		buff_ptr = buffer + offset;
 		header = get_unaligned_le32(buff_ptr);
 
@@ -1123,11 +1123,19 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
 		if (pkt_len == 0 || tp_len == 0)
 			break;
 
+		if (tp_len > size - offset)
+			break;
+
 		if (pkt_offset & IS_MANAGMEMENT) {
+			if (tp_len < HOST_HDR_OFFSET || pkt_len > tp_len - HOST_HDR_OFFSET)
+				break;
 			buff_ptr += HOST_HDR_OFFSET;
 			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len,
 					 pkt_offset & IS_MGMT_AUTH_PKT);
 		} else {
+			if (pkt_offset > tp_len ||
+			    pkt_len > tp_len - pkt_offset)
+				break;
 			if (!is_cfg_packet) {
 				wilc_frmw_to_host(wilc, buff_ptr, pkt_len,
 						  pkt_offset);
@@ -1148,7 +1156,7 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
 			}
 		}
 		offset += tp_len;
-	} while (offset < size);
+	}
 }
 
 static void wilc_wlan_handle_rxq(struct wilc *wilc)
-- 
2.43.0

