Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748354;
	b=ATkqecm1Xlaa3fLMkatZw2yfQKrd+51VPproBw/TE7WN0xcBHFjydVUve09s1Unx+g5U
	 C9hK7uJnrKRJUxRBIDBY9H4He4PsLqX+Ial77qWN11i1GQYm0vsuf1ArDv6qEGRqEu6PK
	 M1FdhPsc96eXNU9W7u00jF+wjI1VmcJ7nOHdTJItlqAMb5y9sIzjvG6oDS7VAzg/RbIDP
	 DxzOi6e0k/tFUovnTZBK3pnmjCyW2F/hRSrAOoc/ttatKIMLndQHqwFwVu6rMrPOMcel+
	 gwf8GOjguLgFqvA8JKRctOMi5i1YizUkWDZ3Hr9Zi9xnR3LjXbc+wqji0jpbheLNMVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748354;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CT/Cws5uIyWHGwD15sUwHFGgBljncjvYFBe3U6nEdjs=;
	b=VhX/AuHyOQxNwasF1xJztaZETGHZHP7cGRGpnmMGyCTsFM+VCfZ/Qel5Sbq7JL2LReb3
	 8aTLtDs9jxAWBy1/er2ZDs+EMnRT1ECA7Bc1ZmK1FaYe8FRGNuZZ2gUd/k5zO+liUjWe3
	 4hAKHSYMBtTdBlZbRpYHD4pDHzR23rugQPxdEnfkKBJ3ozTeyjl2/58L0/cDiqD0wFqM0
	 J63KAtb28q4WdFh/qYnbArEbWaB0uBS8dBRHvh3eCImvA4HpcM1Q1q/qPHydii642PpbX
	 /HUHiyYHLFQJprviBnsNsPXOcKDtuSKGli8tHr9Eljjti/0mvr4Na0oGHevvB3ZdB8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E25606A31F;
	Fri, 23 Oct 2026 09:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E25606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CT
	/Cws5uIyWHGwD15sUwHFGgBljncjvYFBe3U6nEdjs=; b=ojHdOs5i2By8cPuYn8
	AbSYkMiozYNtoARXNA3S7j7wvszrKDI21V8MgiN/N5Zyrh4yRhC/NTsHi0ZmW6Yk
	8xv0dKmoe2SHCGdLCCBrdyEaxA6qJFLdF68MQoMHaZsefG94tZ0+YRTSoN0bSR4E
	/0Zo7VYfE5zAv6F0y47uMXLso=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v3UgK9tqy0UHCA--.32485S2;
	Fri, 23 Oct 2026 17:38:42 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] mailbox: pcc: validate PCCT subspaces before parsing
Date: Fri, 23 Oct 2026 17:38:39 +0800
Message-Id: <20261023093839.715037-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3v3UgK9tqy0UHCA--.32485S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr18Cry3Jr4kGFWfGrW3ZFb_yoWrAFyUpF
	1Yvas8KrW3Aa13WF12vwsYyF43Aw4I9a4UKr4xKa4jqw45GF15JFy0k3429r95AFZ2gF1a
	v3W5KF1UCFWqyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQo7_UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQJknmrbKyK7rgAA3Y

The PCC mailbox probe walks PCCT entries by their declared lengths
without checking that each entry is contained in the table. It also
passes generic headers to type-specific parsers without establishing the
required record size. Malformed firmware can therefore move the cursor
outside the PCCT or cause out-of-bounds field reads.

Validate the table header, each subspace range, and the minimum size for
supported subspace types during both the counting and probe passes.

Fixes: 86c22f8c9a3b ("Mailbox: Add support for Platform Communication Channel")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---

Notes:
    Changes in v2:
    - Replace the type switch with a minimum-length lookup table.
    - Remove the redundant remaining-header-size check.
    - Keep an explicit type bound check before indexing the table.

 drivers/mailbox/pcc.c | 49 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 9888dab64639..91cef0ee3391 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -553,6 +553,38 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 	.last_tx_done = pcc_last_tx_done,
 };
 
+static const u16 pcc_subspace_min_len[ACPI_PCCT_TYPE_RESERVED] = {
+	[ACPI_PCCT_TYPE_GENERIC_SUBSPACE] =
+		sizeof(struct acpi_pcct_subspace),
+	[ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE] =
+		sizeof(struct acpi_pcct_hw_reduced),
+	[ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2] =
+		sizeof(struct acpi_pcct_hw_reduced_type2),
+	[ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE] =
+		sizeof(struct acpi_pcct_ext_pcc_master),
+	[ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE] =
+		sizeof(struct acpi_pcct_ext_pcc_slave),
+};
+
+static bool pcc_subspace_is_valid(struct acpi_subtable_header *entry,
+				  unsigned long end)
+{
+	unsigned long start = (unsigned long)entry;
+	size_t length;
+
+	if (start >= end)
+		return false;
+
+	length = entry->length;
+	if (length < sizeof(*entry) || length > end - start)
+		return false;
+
+	if (entry->type >= ACPI_PCCT_TYPE_RESERVED)
+		return false;
+
+	return length >= pcc_subspace_min_len[entry->type];
+}
+
 /**
  * parse_pcc_subspace - Count PCC subspaces defined
  * @header: Pointer to the ACPI subtable header under the PCCT.
@@ -568,6 +600,9 @@ static int parse_pcc_subspace(union acpi_subtable_headers *header,
 {
 	struct acpi_pcct_subspace *ss = (struct acpi_pcct_subspace *) header;
 
+	if (!pcc_subspace_is_valid(&ss->header, end))
+		return -EINVAL;
+
 	if (ss->header.type < ACPI_PCCT_TYPE_RESERVED)
 		return 0;
 
@@ -812,6 +847,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	struct acpi_table_header *pcct_tbl;
 	struct acpi_subtable_header *pcct_entry;
 	struct acpi_table_pcct *acpi_pcct_tbl;
+	unsigned long table_end;
 	acpi_status status = AE_OK;
 	int i, rc, count = pcc_chan_count;
 
@@ -821,6 +857,13 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	if (ACPI_FAILURE(status) || !pcct_tbl)
 		return -ENODEV;
 
+	acpi_pcct_tbl = (struct acpi_table_pcct *)pcct_tbl;
+	if (pcct_tbl->length < sizeof(*acpi_pcct_tbl)) {
+		rc = -EINVAL;
+		goto err;
+	}
+	table_end = (unsigned long)pcct_tbl + pcct_tbl->length;
+
 	pcc_mbox_channels = devm_kcalloc(dev, count, sizeof(*pcc_mbox_channels),
 					 GFP_KERNEL);
 	if (!pcc_mbox_channels) {
@@ -844,7 +887,6 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	pcct_entry = (struct acpi_subtable_header *) (
 		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
 
-	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
 	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL) {
 		pcc_mbox_ctrl->txdone_irq = true;
 		pcc_mbox_ctrl->txdone_poll = false;
@@ -856,6 +898,11 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	for (i = 0; i < count; i++) {
 		struct pcc_chan_info *pchan = chan_info + i;
 
+		if (!pcc_subspace_is_valid(pcct_entry, table_end)) {
+			rc = -EINVAL;
+			goto err;
+		}
+
 		pcc_mbox_channels[i].con_priv = pchan;
 		pchan->chan.mchan = &pcc_mbox_channels[i];
 
-- 
2.34.1

