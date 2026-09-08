Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5F2620DE;
	Tue,  8 Sep 2026 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837554; cv=none; b=l6IWm9CTwoK1OLKuE52/Zv8ODIjkzK6v9XGitr7nIEmg+07Gr/V+0I3IglDXKEhrtnXFd+fiV2sy6Uew6SrvInDHNKeB0RBmd1cuGErSr1286KeQc8sEhh0XbO81IyrH7DfTd8V1psPxGjdDofL/NHTZIvYliG6e3aNHG03ovhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837554; c=relaxed/simple;
	bh=RtekH477b8mBPWpnbdhhZdX+BmRPVLtD3qU/C0jKE2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zc05bCurKrkZESNQC/2mvdxw7UEX2St3wQ2v6kf5lh0uTr/H5Ib7lAXkxKhX3PGyzJiy7+F4+XSj1tvrKK6AJIGrEJkjckpxo7B6cYYTBFCzqeWS68lAfrQ+nKW1LhANgiptaJAoYVcbEx2n93g76RTRrfJYJej4gZuiBC8nMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0a6d4372ab3411f19a56ed5b684f684d-20260908
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d39c352a-7351-4bb0-bbef-2477c686d2f5,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:d39c352a-7351-4bb0-bbef-2477c686d2f5,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:371fa273cac59cfe1c2f1bb01abbd526,BulkI
	D:2609081119074HQKIZV1,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a6d4372ab3411f19a56ed5b684f684d-20260908
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1043975165; Tue, 08 Sep 2026 11:19:02 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: mchangir@redhat.com,
	lhenriques@suse.de,
	jlayton@kernel.org,
	xiubli@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] ceph: fix longname buffer overflow in ceph_fname_to_usr()
Date: Tue,  8 Sep 2026 11:18:23 +0800
Message-Id: <20260908031823.204166-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Snapshot longname reconstruction formats "_<name>_<inode>" via snprintf()
and memcpy()s the result into oname->name.  Checking the length against
NAME_MAX only protects the LOOKUPNAME/export callers, whose buffer is
allocated with fscrypt_fname_alloc_buffer(NAME_MAX).  The readdir path
points oname->name straight at the altname in the MDS reply, whose
capacity is altname_len; the reconstructed name can exceed that while
still fitting under NAME_MAX, overflowing the in-place destination.

Save the actual oname->len before the decryption overwrites it, and fail
with -ENAMETOOLONG when the reconstructed name would not fit.

Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
Cc: stable@vger.kernel.org
Suggested-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
Changes in v2:
- Save the actual destination capacity (oname->len) before the
  decryption overwrites it, instead of checking only against NAME_MAX.
  The readdir path points oname->name at altname in the MDS reply,
  whose capacity is altname_len; NAME_MAX alone still overflows it.
  (Suggested by Alex Markuze)

 fs/ceph/crypto.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index bc0a097a4cea..845b69ba890c 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -313,6 +313,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
+	int dst_len;
 	int ret;
 
 	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname)))
@@ -387,6 +388,9 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		iname.len = fname->ctext_len;
 	}
 
+	/* oname->len is overwritten by the decryption below */
+	dst_len = oname->len;
+
 	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ? tname : oname->name;
 	_oname.len = oname->len;
 
@@ -403,6 +407,10 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%llu",
 				    oname->len, oname->name, dir->i_ino);
+		if (name_len > dst_len) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
 		memcpy(oname->name, tmp_buf, name_len);
 		oname->len = name_len;
 	}
-- 
2.25.1

