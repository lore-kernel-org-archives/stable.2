Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083751;
	b=uD0W/yr+++x/wQzYqbrEVwjJgWYWQK0kveVZ3XOPoMEJ/UPEyWP9SH0iBdpdPeyUAybw
	 tyehyYn8kwXXgrCdKI4x2GAJiqgz56eINcrhYFz1XvF5/BPBYqtTHMHs6NLQZ5XtZ20s7
	 foR1N2UGVNYSnGDSCVG14+ch086oSbwgm9aDfSPXqO1kGrPVtEh76fGYbCStTqOTwNLQB
	 BLg43HeGeKVlpIkJUccTI8dAMvj2QkI3pTxXZm9/vTm2pT4rzX8ZqOnclT0ZOpofyOffr
	 tYQlAFWqVL+96K163Z0nvGmJgjDygQurUUXVclg7ZcSBnbdtWbXqg/k0xYa1guM3mag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083751;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=gpEAWVIxbWupLzv90UrOrrFdVYEi/6hmO1ydhABKc4g=;
	b=M0sJcXfzdkl3MiDGIbE79ev7TPXqLO9EO0TCQkLzIxHBH/xWuJPYD3C2BIh2bl75fnni
	 Cw34TbPXUy+CK0hgWCottVJOdCtZtjYRWrGv9FUMXwpfcxe5Ab5DLH8K9PvXV+q0B6/mZ
	 onXuoMHI30lA/9BTKZG7tTWbPfWwbUoTSMOLg1tqc4s+SWDmjf5OR78smYXKLQeGdjKf8
	 8frhhZwHMfXOvqmlTGOBmvOP026niYc8C7NoVTGWiFlPqH6VxsBnCDgcdDUDuZq/Po5ZX
	 s2gP8jEP2UY77Up4W7vjc0bn6SpdMOV50KAmboaZh2ANWioRA5YWvpB7oeoOPI7+P5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HKKmRv+g;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649A606A31B;
	Tue, 27 Oct 2026 06:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6649A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HKKmRv+g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gp
	EAWVIxbWupLzv90UrOrrFdVYEi/6hmO1ydhABKc4g=; b=HKKmRv+g8Z/PAAXJV8
	owYL14OEAqJkAZ2zwkiKg5sNdw704YfZa0+Bhp3wEb6shByHoO0hD8kR0WvPT0HB
	ghao3680vTORxfDv2+joN7cDoLjYiZgsKGTS1YDpu6NHIrs7EWZX3fdcuKdnt34m
	xkedVKESwTT8X+eERTUm5Se0Y=
Received: from pc.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnk4tESeBqAJpjCQ--.31930S2;
	Tue, 27 Oct 2026 14:48:37 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] mailbox: pcc: validate PCCT subspaces before parsing
Date: Tue, 27 Oct 2026 14:48:35 +0800
Message-Id: <20261027064835.2264459-1-yaojiale02@163.com>
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
X-CM-TRANSID:PygvCgBnk4tESeBqAJpjCQ--.31930S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1kAry7KFW5Cr1UGrW7Arb_yoW5ZFWxpF
	WY9a9IywsxAa13Wry2vws5AFyfCws7ZFyUKrWfGa42qwsrGF45XFy0k3yjgr98Jrs29F1a
	van0gF1DCrWqyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdkuxUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQU2cGrgSUUXAQAA3e

The PCC mailbox driver counts PCCT entries before its probe walks the
same records by their declared lengths and passes them to type-specific
parsers.  The counting pass currently accepts entries based only on their
type, so a malformed entry can move the probe cursor outside the table or
cause an out-of-bounds field read.

Validate each entry against the table boundary and the minimum size of
its PCCT subspace type during the initial ACPI parsing pass.  This also
covers Type 5 hardware register communication subspaces before the same
immutable table is consumed by the mailbox probe.

Fixes: 86c22f8c9a3b ("Mailbox: Add support for Platform Communication Channel")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---

Notes:
    Changes in v3:
    - Add the minimum size for Type 5 hardware register communication
      subspaces.
    - Reject unsupported types before indexing the minimum-length table.
    - Drop duplicate validation from pcc_mbox_probe(), since the entries are
      already validated by the initial ACPI parsing pass.
    
    Changes in v2:
    - Replace the type switch with a minimum-length lookup table.
    - Remove the redundant remaining-header-size check.
    - Keep an explicit type bound check before indexing the table.

 drivers/mailbox/pcc.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 14dc4a187bfc..5d20c5a6d183 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -560,6 +560,37 @@ static const struct mbox_chan_ops pcc_chan_ops = {
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
+	[ACPI_PCCT_TYPE_HW_REG_COMM_SUBSPACE] =
+		sizeof(struct acpi_pcct_hw_reg),
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
+	return length >= pcc_subspace_min_len[entry->type];
+}
+
 /**
  * parse_pcc_subspace - Count PCC subspaces defined
  * @header: Pointer to the ACPI subtable header under the PCCT.
@@ -575,10 +606,13 @@ static int parse_pcc_subspace(union acpi_subtable_headers *header,
 {
 	struct acpi_pcct_subspace *ss = (struct acpi_pcct_subspace *) header;
 
-	if (ss->header.type < ACPI_PCCT_TYPE_RESERVED)
-		return 0;
+	if (ss->header.type >= ACPI_PCCT_TYPE_RESERVED)
+		return -EINVAL;
 
-	return -EINVAL;
+	if (!pcc_subspace_is_valid(&ss->header, end))
+		return -EINVAL;
+
+	return 0;
 }
 
 static int
-- 
2.34.1

