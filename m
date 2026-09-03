Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5B40F8E3;
	Thu,  3 Sep 2026 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432504; cv=none; b=iDIfsDY+SMgilaJyFiGlwt8gbuh+lLw29DcGpYIfk4Wq9AG3jEgp0Qx1Bu5ATD9dQYrmi8j58CQllAQgenPX/UAJ+r/ztvl+XnNkrEXpkv90Ixtjsug0h4dUhL6OejfmH6vVVMOO4Vr3NNjnPfClAoy9ryNdCMloS4RNsiQnUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432504; c=relaxed/simple;
	bh=gwTSc64pkHgPgsanVKcuL2s/zoNRDsEMhK6TOPry8Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u92VsAUQt+7kkUCv6eivcbVe6iw5wnvglvs7+vpWqBVJSQW6kcmlWqF5w/Xo3SGJHCREbtDB1ZwFbjg8UcJdF4o566DN1m0Nxhi/cm05Lij1zxqQ44BrYHrtTjtk4IUsbp7vvVzZrSX2Mn12yrq+hBVUrZu4QE7l3yfVW1HFPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f4633224a78411f19a56ed5b684f684d-20260903
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d7e4669d-066f-40bc-a177-4806e663f3c6,IP:15,
	URL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:d7e4669d-066f-40bc-a177-4806e663f3c6,IP:15,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:7e2a629567d72180bf23537f3cda4ce8,BulkI
	D:260903184814ZRT3184A,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50|99,EDM:1|-100,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_AEC,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f4633224a78411f19a56ed5b684f684d-20260903
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2013039303; Thu, 03 Sep 2026 18:48:10 +0800
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
Subject: [PATCH] ceph: fix longname buffer overflow in ceph_fname_to_usr()
Date: Thu,  3 Sep 2026 18:47:42 +0800
Message-Id: <20260903104742.729279-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The snapshot longname reconstruction in ceph_fname_to_usr() uses
snprintf() to format "_<name>_<inode>" into a temporary buffer and
then memcpy()s the result into oname->name.  Since snprintf() returns
the number of characters that would have been written, the memcpy
length can exceed the NAME_MAX + 1 byte oname->name buffer when the
decoded snapshot name is long, causing a heap buffer overflow.

Check the reconstructed name length and return -ENAMETOOLONG if it
exceeds NAME_MAX, jumping to the existing cleanup path to avoid
leaking the temporary _tname buffer and the parse_longname() inode
reference.

Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/ceph/crypto.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index bc0a097a4cea..076e7f2f3c0e 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -403,6 +403,10 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%llu",
 				    oname->len, oname->name, dir->i_ino);
+		if (name_len > NAME_MAX) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
 		memcpy(oname->name, tmp_buf, name_len);
 		oname->len = name_len;
 	}
-- 
2.25.1
