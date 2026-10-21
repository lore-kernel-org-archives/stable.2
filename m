Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594963;
	b=wQbEVOaVwU1u3HE+L2PTtxWwsKTS+3zyZkpl9HMTgFIaj5jL0RBC7k/rsnBtbduXQ96b
	 MLD5sxsgaxRypFEqZM7iZzmZZ5wzQZLCiJbtAdCW0NTF1ic6NusnWtzK1s+KDJqUpJl5k
	 0pLWqrmKIHBvuCP/fWsr0NxtIwkKpcEjKqmIXymXuecePzwS3w1HdmUVQ0kcTOkUcL3Z+
	 ue2oy6ya/UsXwgjOx+pPsoeb3cRVBonpxf7NrfMdtgrvyVkMDP+E+ar2DgIl3LwJEd2UO
	 uohX3ym3Ij7SPCuwS5+UIOPWQYPymYUGOTyyCfa2slqx3Nb0wZhRh4+5lzk8nbEAuDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594963;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=d5JxF9k90cA5rrayOyNwrmjTdjOiAyML1KCzl9Ju/xA=;
	b=3OIebkuvAZyap7msg53kZ6vMHyYQOAij+ALW7UJKToB9/LVHnXswjD5SorQDGIkIu+pN
	 X4o42jNUqGG7bM0tk8ak7t696WyNFnduKtmOYSPfQJlZ2W7mzTvn8crSgfgamY/ciKVIm
	 xsrWC9J+JLwl8nk+xOzt2b/MwRDU9Vp9pL8ZwXwwQND3TLD07mmT9DqvHEM2sPt4+LQZ7
	 8LqArc+1TEbdGTdWku5e25I1FE41zR+fCxEp1DbNhm5oKDqMDsVtHoE289Z/A9rPrUE/p
	 2eGiMH3JjoaZFWaeKsViWBQU1JmzvG7M4Qjk032gB7DxO3YeyZrZBlywbhLdJhoeE5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Kb5CqPro;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E6606A319;
	Wed, 21 Oct 2026 15:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95E6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Kb5CqPro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=d5
	JxF9k90cA5rrayOyNwrmjTdjOiAyML1KCzl9Ju/xA=; b=Kb5CqProWoljNLQKNL
	rLEqQpNjBOGWopPeGnGtvBdhzY9Ot8ton/Ijr65VxBdXJ4WKze3+dL9yIN6Mpj8h
	GjptTPNp2B9Au8pRW7cQWZB6WBj2wZUSEQ3UJbiQV0+Ac1nvQnEY9MxThluIJsPT
	dQnUAXz4ufk5Zg26OtFJSvENY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3_8ro09hqpMAiBg--.20706S2;
	Wed, 21 Oct 2026 23:02:03 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Keith Busch <kbusch@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v2] lib/firmware_table: validate subtable bounds
Date: Wed, 21 Oct 2026 23:01:59 +0800
Message-Id: <20261021150159.399043-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_8ro09hqpMAiBg--.20706S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1Dur1UGF4kuFykuw4kZwb_yoW8tw4rpF
	1fK3s8trWFqFy7Xrn7J3WFyF4YvrW7W3ZxAFyxKr18twn8ZF1rWFy3G3sFqFZ3ZrWxWF4Y
	gayjqry8Cr4kAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhL0OUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wsAOmrY0+tkOAAA3I

The generic firmware table walker dispatches matching entries after only
checking that a generic subtable header is present. A record whose
declared length is shorter than its header or extends past the table can
therefore reach a handler before its bounds have been established.

Once a complete generic header is available, validate the declared record
range before looking up or invoking a handler. This rejects zero-length
and truncated records while preserving the existing behavior of ignoring
trailing table data too short to contain another subtable header.

Fixes: 60574d1e05b0 ("acpi: Create subtable parsing infrastructure")
Cc: stable@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
Changes in v2:
- Preserve support for trailing padding shorter than a subtable header.
- Add the stable and code-author Cc trailers.
---
 lib/fw_table.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/fw_table.c b/lib/fw_table.c
index 16291814450e..40846044e01b 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -172,7 +172,15 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	    ((unsigned long)table_header + table_size);
 	subtable_len = acpi_get_subtable_header_length(&entry);
 
-	while (((unsigned long)entry.hdr) + subtable_len < table_end) {
+	while ((unsigned long)entry.hdr + subtable_len <= table_end) {
+		entry_len = acpi_get_entry_length(&entry);
+		if (entry_len < subtable_len ||
+		    entry_len > table_end - (unsigned long)entry.hdr) {
+			pr_err("[%4.4s:0x%02lx] Invalid length %lu\n", id,
+			       acpi_get_entry_type(&entry), entry_len);
+			return -EINVAL;
+		}
+
 		for (i = 0; i < proc_num; i++) {
 			if (acpi_get_entry_type(&entry) != proc[i].id)
 				continue;
@@ -186,16 +194,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			break;
 		}
 
-		/*
-		 * If entry->length is 0, break from this loop to avoid
-		 * infinite loop.
-		 */
-		entry_len = acpi_get_entry_length(&entry);
-		if (entry_len == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
-			return -EINVAL;
-		}
-
 		entry.hdr = (union acpi_subtable_headers *)
 		    ((unsigned long)entry.hdr + entry_len);
 	}
-- 
2.34.1

