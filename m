Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080973;
	b=zNvBMyNFKt/t8jCp4Du7dQr7Rc2lPOEWH0sYGNcGv5Gx68XOzsoo/qGdcE2oJ7JqKWLP
	 OOMlI4bmohJfmcfFg+OY0KNBiXg9ceyEQitrEI6Q5tLnJn8oH+iqJeQVbQJc8Cw+zTqqJ
	 6aMrh+q7fCJE1HUHeRfSEhBm7jl9IWGH33i4Fu1hMkq/RbiioTSTmj1Ll36556J6Om5Oy
	 aotI2cJcjGwqvYVi/ido3zfax3PwhzVsKEaO4UC/TYPPWb+FvVohr1aUFtCl2SC2zyJSv
	 VwWSIJm+SszAo9OAegxbRP9y31pNOohuzbnwXBzBm24295xEJ3pP0V9Ax3528C6L95w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080973;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=/+pF8ulalzoN9iVRVw5yAMloH9f98sQtIGRgxx6MQ4o=;
	b=P0RhUjT4e2VwWh8Qbde8QNPWEggK6u1mSXW+qkfwVEazUmBgb5/8QBK9xogj7k31n9Oo
	 VAlEs+5yx/qPYSj5UdgCbIEh3FAsi6QPwxaPWdTZWY9truIFLG9mq+/PH6d/K/2xRoC6o
	 Q24Y7JB+8rjWJ6KHZK0uJvbKPH335smtjSWH9c2GjBVGVY3FeyQ2uYYEI/mC6YJOro2UQ
	 zN0AZOwBG5C2/clvzNZuC4o9uyF7Iv7p7MYKNdN8z7mPsUS2TEjb7Lmxb0KzS0hPwIfP9
	 QmNV97xknIZ928idcwLbDAPmZks+7plG4Jj+y4RXluX1OxjecQY6kasTaexcgyAWEIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=b7FnOmJu;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82189606A326;
	Sat,  7 Nov 2026 19:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82189606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=b7FnOmJu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=/+pF8ulalzoN9iVRVw5yAMloH9f98sQtIGRgxx6MQ4o=; b=b7FnOmJu22QQeHWMKZWdmZGqug
	q/kZI/Z4pOz2YGhY+ANb1zHFJ+0UNvY8fYv1bWVAC1kXxV6DwcAD9OqV65NlFX/dawzz/Pq/mq5N+
	cixgoR/8WNGj+uZeeVgYdTqNYwBzKRAx1AC19TMIiIwQbVeX4NZVFGtyaR03pz6V/7GTqfZyQZVF7
	CAltwHiMXE06RwCbP3dgDABIZTl/1i8USP6z44o72HDsx82OITxNi5KHQRT9qs1OA49umEoW8Q4Xi
	n1yG5YhyJKV9XHbbNw5CxCJy2ijhHC1wv7sGUMcC+aQYZyGQ5ZtM35N4phi+SX12r0J2LaqLee3HV
	GFUU6Tyw==;
Received: from [151.115.150.205] (port=40112 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xPmPu-00000009BTJ-0Zv5;
	Sat, 07 Nov 2026 20:49:30 +0100
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
Subject: [PATCH] evm: fix TOCTOU heap OOB in protected xattr reads
Date: Sat,  7 Nov 2026 19:49:10 +0000
Message-ID: <20261107194909.1061154-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
values, use the length actually returned by the copy.

Fixes: 8314b6732ae4e ("ima: Define new template fields xattrnames, xattrlengths and xattrvalues")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 security/integrity/evm/evm_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ac8328812e6ef..4b01ca0b4753a 100644
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
 
@@ -407,12 +415,17 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
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
+				size = rc;
 			}
 			break;
 		default:
-- 
2.47.3

