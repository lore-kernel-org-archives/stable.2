Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592597;
	b=s/vXKxpKqX/YjiMFTnoJRr8Q7TMdz1v7A5qfMEZhUFwdvAgi5Wy89xqmVBA5u/Bd54C7
	 s0WZeOLxzTqAH1Ot3C3lQ9WU9Ydm820rv6AW+KjoTf7v9av9z1fvaV90zF+ibE6JxUPoA
	 3Y6LAxPtgZms4M3QcCYxixi0V3yU41yD3KGzFeyESyyRsnlE+fOazCXaKukd/H8/mvWjd
	 aqURyy4JFOXWmCd0Te7B9Qx1QB2tOWbww6b+Vx3K/sBfLnmjeSBgajKkdDZhoKzYzr3DS
	 EcMkDbU3HYTZjygXGKykuYuBtOOc7WaWMerA4VRH08w4uDs19tHAn9Xsfw8mT9tCMpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592597;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=B37ML7y2GpxDfNDUAEu44dJP3aupGyMyTRKY8wOrYOA=;
	b=dq0zyIFZ9KXeoMNYhfmEVi7GZ8MwOSvlxGyr5KMRLzhG0KAODgc7xvDXr793e6FMdMgQ
	 E6vzcN0wql8Jck/v4gQ0oIiF5itxwaxYrJJelUMCw5cLIoqnmIIiHBsB+dO47mkyuv4RZ
	 6GkOk9WirsxndHAHqE4G74Hvdqzr1LLeSDcUgaDxfj5N3+er4mlS+0sfCO46IMnuWvwqf
	 Qpbz2rxrXb4O1VTliEu9odBM16WPRLNQzlCXsWPAZ378wOZDeJUxuUt4J1+MSn5Y2S9c7
	 Y35CAo31JezRjEXmYXaaYavhzUjYAfdIK5LWxidYeqIK3AXMh0VNMJWSwasTxZCX/CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="BLNlP/8H";
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352D606A8A7;
	Fri, 13 Nov 2026 17:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5352D606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=BLNlP/8H
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4h40KGZz8XrrJ;
	Sat, 14 Nov 2026 01:56:36 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592596;
	bh=p3N4SLBZbINwkZIeKKCo7HF3f+3cmWEq6vs69cDRrfI=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=BLNlP/8Hm7Nj+BVyWcIXhmgPYx+PTNPuZutPeBhaSD2xg0t+UGAsj4JnwgeYEK7xi
	 xlR+M1oZw0t/PsgoneYcy6o25/WNrK7+9+obb6hpb6cf1VBhblLkijrERzWDkpdOyG
	 XgQCaYHUBzUAKUNxjM8MLOHG8R1NfWJT7md348MHhKXE025JDrFSlbniZx3i5aQ+9s
	 FRgERukuq6p9xI744TiFSDSFi+eMuKo0SRbAlpbQl7AAOgIIY5lxx7n9OGbaJLprMY
	 QX5ECqQ7vPKxmUjW1luy+rUCJO1x4XKgvUqtOYxwrATOI3TUtm4Es7eeHGqvAzg9uz
	 LcpcwgZwGMsLg==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ADHuRcL093860;
	Sat, 14 Nov 2026 01:56:27 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:56:31 +0800 (CST)
X-Zmail-TransId: 2afc6af74f4f316-1625b
X-Mailer: Zmail v1.0
Message-ID: <20261114015631783qLqT7vW5WFvIIlzpzEygX@zte.com.cn>
In-Reply-To: <20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn>
References: 20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn
Date: Sat, 14 Nov 2026 01:56:31 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCB2NCAzLzRdIGF0YTogbGliYXRhLXNjc2k6IGdlbmVyYXRlIFNBVCBzZW5zZSBkYXRhIGZvciBBVEEgUEFTUy1USFJPVUdIKDMyKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADHuRcL093860
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 01:56:36 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74F54.000/4jR4h40KGZz8XrrJ

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_scsi_qc_complete() only recognizes ATA PASS-THROUGH(12) and (16).
The 32-byte form takes the ordinary completion path, so CK_COND is
ignored and errors lack the ATA Status Return descriptor. Successful
commands with CK_COND set therefore complete GOOD instead of returning
CHECK CONDITION with the ATA register values.

Recognize ATA PASS-THROUGH(32) by its service action and read CK_COND
from byte 11 instead of byte 2, which belongs to the variable-length
CDB header.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v4:
- Code and commit message unchanged; retain Damien Le Moal's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261112220122679csrHZJU28_17KSmt_fom7@zte.com.cn/

Changes in v3:
- Code unchanged; retain the Damien Le Moal Reviewed-by tag.
Previous version: https://lore.kernel.org/all/202611112231319337i08AK7ZzIXm9DYFhmtXx@zte.com.cn/

Changes in v2 (Niklas Cassel):
- Move the unrelated invalid-PROTOCOL hunk to patch 1; this patch only
  changes the completion path.
- Regenerate with git format-patch so the index matches the diff.
- Keep the Reviewed-by tag; apart from the moved hunk this patch is
  unchanged from v1.
v1: https://lore.kernel.org/all/202611042211545962bhKeo8yjWPGFgya4g6LG@zte.com.cn/

Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiled
ata_scsi_qc_complete() verbatim with sense/completion stubs. For ATA_32,
CK_COND in byte 11 now selected pass-through sense and CHECK CONDITION;
CK_COND clear remained GOOD. Error and preexisting-sense paths selected
the pass-through helpers, and byte 2 did not act as CK_COND. The short
CDB paths and unsupported service-action control were also checked.

 drivers/ata/libata-scsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e2847fb32e78b93fd0c8fd3b57e78ae3b17654b6..374918eae53ef4cb082bccd903773f06e6c55fa1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1888,9 +1888,12 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	struct ata_link *link = qc->dev->link;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
+	u16 cdb_offset = cdb[0] == VARIABLE_LENGTH_CMD ? 9 : 0;
 	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
-	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
-	bool is_ck_cond_request = cdb[2] & 0x20;
+	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12 ||
+		(cdb[0] == VARIABLE_LENGTH_CMD &&
+		 get_unaligned_be16(&cdb[8]) == ATA_32);
+	bool is_ck_cond_request = cdb[2 + cdb_offset] & 0x20;
 	bool is_error = qc->err_mask != 0;
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
-- 
2.27.0
