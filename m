Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092746;
	b=l8wicbvoWizBVpDhAYM8gla+P9ih+Z5GoIuAzoXTB21CDhKDsIm47DQChzTDFSpbwqzI
	 pDzjY/BqZErMN2Tb9Djwd7BJ67ePSUDLmISi2JkcxqTiDBLclMSAtFcVIZxXX9Jl/G9Nb
	 nqcn3A07AeuHmFj4sK61BdFRlNtUvnxZK7vm4mLJQ5hHBVGYcl9nQ9lHyhojWz4Tjfvxq
	 tS34RCXLRiIkxBwKCpCXa3eQCpbOsoBRj6uRotYqPLeLJPjs40JjegxSUKBfALr276bxe
	 dxNSDbpdl/Cxq8UPyX9gB8yKoA7dZtCn0TrqoqKGhzey7g/JHUcNLM7+qlwY38RXZ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092746;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=DIMiaePVV9GcXMmhefDHZYoBfudUKELmzbg1o7Nw6s0=;
	b=qCXlXEPX5/8ZoiZdOieffH4bhmvsdScGPNtkS30qJCGd79FJTahD94FQEEvL5R7FLjwh
	 xVYTO0HGYjqrku+IzmDvUKedInRDmt65D8+TBT0GP70wbnthX7BxzvJQMK5G+ntK1CQBu
	 WW6XHaDEJj6lcbeJTBRqEbxLsJV6WHtr3936UO9gaE0m2sJyPV9nz4gIs+372R3rsrjma
	 Wu2YY8a7GfXeewyhmLXmDNZP/KMu59eumIWfSPsROqmfEf8mqlyjY5iITokK7rhm4pq1S
	 cjZgmwDYKWgYTcAG0DCvPPqy8ikvFI/dbcQmkXOT2iD26v3swjk2gEXQ8jKl2By5d/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=fKNReNxx;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DDF606A326;
	Sat,  7 Nov 2026 23:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64DDF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=fKNReNxx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=DIMiaePVV9GcXMmhefDHZYoBfudUKELmzbg1o7Nw6s0=; b=fKNReNxx7jbsQMz9QoJ0/b0oIv
	VvdJ3cxvHCSoLjVUNoqk5U39eCuLOCXu16s4JonptlVR18DB/phUibsX9y2eXpbAxzXw7oPt8DqzR
	KOqn8oXkJJMHPQ/mJi+1GkjQkgeKyu3/NIWG/t448lqNEGZy6qOKzDc8bbZ5Ymtth0D7TghRMmq0q
	x4srJ9xBS/8fT40w/IBylFOyJKl9QCNJfd/DkeZ073ncWZLrIGmz/iZQx7ZpLLushDSYylClKg9fu
	9fI2l64PPCtfnjB+U6pfPCOMc6K0MdoX+zxHuviMCw/iZzIsIgt8WiKu8l6LoAQ+iNhGU3wVavadd
	Q7vijMFQ==;
Received: from [151.115.150.205] (port=44646 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xPpTo-0000000EVj3-1hHr;
	Sun, 08 Nov 2026 00:05:44 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2] evm: fix TOCTOU heap OOB in protected xattr reads
Date: Sat,  7 Nov 2026 23:05:15 +0000
Message-ID: <20261107230514.1108379-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

ima_eventinodexattrs_init_common() queries the total size of protected
xattrs, allocates that amount, and calls evm_read_protected_xattrs()
again to fill the buffer. This creates a TOCTOU window: if the
protected xattr changes between the two calls to
evm_read_protected_xattrs(), names and lengths are written without
checking whether the data still fits in the target buffer. This can
yield an OOB heap write that KASAN reports as:

  BUG: KASAN: slab-out-of-bounds in evm_read_protected_xattrs+0x15e/0x280
  Write of size 20 at addr ffff888002c59bcd by task init/62

Reject fields that no longer fit in the target buffer. For xattr
values, also check the length returned by the copy before accounting it.
This also handles the case where a size of 0 is treated as a length
query.

Fixes: 8314b6732ae4e ("ima: Define new template fields xattrnames, xattrlengths and xattrvalues")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
Changes since v1 (after review from Sashiko):
- Handle the 0 case.

v1: https://lore.kernel.org/all/20261107194909.1061154-2-Jeremy.Jean@oss.cyber.gouv.fr/
Sashiko: https://sashiko.dev/#/message/20261107194909.1061154-2-Jeremy.Jean%40oss.cyber.gouv.fr

 security/integrity/evm/evm_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ac8328812e6ef..2ed0b67b9109b 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -389,6 +389,10 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 		case 'n':
 			size = strlen(xattr->name) + 1;
 			if (buffer) {
+				if (total_size > buffer_size ||
+				    size > buffer_size - total_size)
+					return -ERANGE;
+
 				if (total_size)
 					*(buffer + total_size - 1) = '|';
 
@@ -398,6 +402,10 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 		case 'l':
 			size = sizeof(u32);
 			if (buffer) {
+				if (total_size > buffer_size ||
+				    size > buffer_size - total_size)
+					return -ERANGE;
+
 				if (canonical_fmt)
 					rc = (__force int)cpu_to_le32(rc);
 
@@ -407,12 +415,20 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 		case 'v':
 			size = rc;
 			if (buffer) {
+				if (total_size > buffer_size ||
+				    size > buffer_size - total_size)
+					return -ERANGE;
+
 				rc = __vfs_getxattr(dentry,
 					d_backing_inode(dentry), xattr->name,
 					buffer + total_size,
 					buffer_size - total_size);
 				if (rc < 0)
 					return rc;
+				/* A size of 0 may be treated as a query. */
+				if (rc > buffer_size - total_size)
+					return -ERANGE;
+				size = rc;
 			}
 			break;
 		default:
-- 
2.47.3

