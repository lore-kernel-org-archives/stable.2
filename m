Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809C270575;
	Fri, 24 Jul 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879053; cv=pass; b=rmKXkqwQt6V01nRr9Bd2s65gETYkIQSDQEPW1LobDsdD9Ut7iG6CW9642wfNHSzudQdQBadnSRPGixO2S2OJAMH/+wAreBZuGLxjPBT1L6Bniudh/e5x/56SKS/Yc4LVmbB6Ks/ypMc+sbEBbRS+houF70XPEsCmhXv1OHba770=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879053; c=relaxed/simple;
	bh=W36dC8wfCc01yMrNuL2V77CsM2C/MV6uys5QLRBenGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqmk1rXePcQs2XGTt3x7DZeBfZPwDRj+zqDZX5fXsEhQWJKrZve048fxCpugrsJjN0y2CcA/CCUlqEiaFDgB7pzTescSu5mezJgES4n4PltpiGWKDG3b1sx0nKBaA89iA5cAxZHwB/M+JZdGFNAsiw8RN7nPw8+hfEi960AsP0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=NhDGjhSs; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="NhDGjhSs"
ARC-Seal: i=1; a=rsa-sha256; t=1784879012; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RWY5rkGircPIX2yy+6nv2kZ86tnH3h+dR++mgplKTCpsT2pghkLia61TU4ifbKdM4NfSUcAdx1AIXrwrL8iHyGP6GReXvyD7ng1F54LLClmwfwtDzybsIYUjbhrxcwU7sOuwa7pb7Lkm6ZLPOOHDsllVNj6OGmG2mwRmBRcX3O8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784879012; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Le4ZX6sba4Tq7M3OLf/DlGvQrpsIeXOzElaPQnzU+cA=; 
	b=J4ouml5levgbf/onIJg0le/XpnS3F0ZdOHYRU5QIKqezIUIFEhTFxYfLEZBtkQ7SKNV5BRtyVxbKCa8p6CVZoj4Ul8K3CFNt13aHhsKUDJm3NXjeHiBqlrxfhCQREJu0E0K6lsnquhNo7dPBKafHBOyyoQw6VO5T7xe+OhevBnI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784879012;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Le4ZX6sba4Tq7M3OLf/DlGvQrpsIeXOzElaPQnzU+cA=;
	b=NhDGjhSsOZ2vmX3Z+Qs2x1kiD/dWLMZAsnB94sWKJvdm0TdJfbucEIW8YPuAnE8e
	LTrkEuykY1AsHy1puLGxxqfLgKXV5VEdHSUcHpgmQ1B+U5A3RZpo64EAlGrBB+0Tz6s
	8pYfuuW/bvXqjJiwkkzm4hj7Xniea1fHHBKZrU3I=
Received: by mx.zoho.eu with SMTPS id 1784879009962307.0625662205176;
	Fri, 24 Jul 2026 09:43:29 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: richard@nod.at
Cc: chengzhihao1@huawei.com,
	s.hauer@pengutronix.de,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ubifs: fix out-of-bounds read in signature length check
Date: Fri, 24 Jul 2026 09:43:27 +0200
Message-ID: <20260724074327.73582-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ubifs_sb_verify_signature() bounds the on-disk ubifs_sig_node->len field
before handing the signature payload to verify_pkcs7_signature(), but the
check has the wrong sign:

	if (le32_to_cpu(signode->len) > snod->len + sizeof(struct ubifs_sig_node))

The signature bytes start sizeof(struct ubifs_sig_node) (UBIFS_SIG_NODE_SZ,
64 bytes) into the node, so the payload is at most

	snod->len - sizeof(struct ubifs_sig_node)

bytes long. Adding the header size instead of subtracting it accepts a
declared length up to 2 * UBIFS_SIG_NODE_SZ larger than the node actually
holds -- past the end of c->sbuf, which is vmalloc(c->leb_size).
verify_pkcs7_signature() -> pkcs7_parse_message() -> asn1_ber_decoder()
is then handed that inflated length and reads beyond the allocation while
walking the DER headers. The node length comes straight from the mounted
image, so a crafted signed UBIFS image reaches this via
ubifs_read_superblock() before the signature is cryptographically checked.

snod->len is guaranteed to be >= UBIFS_SIG_NODE_SZ by the node scanner
(c->ranges[UBIFS_SIG_NODE].min_len == UBIFS_SIG_NODE_SZ), so the corrected
subtraction cannot underflow. Legitimately signed images are unaffected: a
correct superblock never declares a signature longer than the node it is
embedded in.

Fixes: 817aa094842d ("ubifs: support offline signed images")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 fs/ubifs/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index a4a0158f712d..1f770795ee70 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -217,7 +217,7 @@ int ubifs_sb_verify_signature(struct ubifs_info *c,

 	signode = snod->node;

-	if (le32_to_cpu(signode->len) > snod->len + sizeof(struct ubifs_sig_node)) {
+	if (le32_to_cpu(signode->len) > snod->len - sizeof(struct ubifs_sig_node)) {
 		ubifs_err(c, "invalid signature len %d", le32_to_cpu(signode->len));
 		err = -EINVAL;
 		goto out_destroy;
--
2.50.1 (Apple Git-155)
