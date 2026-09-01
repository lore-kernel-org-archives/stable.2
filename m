Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5B477998;
	Tue,  1 Sep 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253995; cv=none; b=bC1rPAKbg7vElOk9FnZM8HJD8gGDZd2Lhmx9sLnmXfxynj4rKvrHRpJGLRSCjc9bU/uczuFXIneJKZqpP1FWGCk7B+KgXEyS5OHdChcMDWgC6Mm3NNFgbCLvI17Mty/2MkP8ZYM8eJbQnj+QV5ilj69V/5z/7ThmowWQ0PVoFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253995; c=relaxed/simple;
	bh=jSXYix9yBb31/PdY9vT5wtW35bFOVCqqBXMTiuDYgWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RafPIvwRj8fnqgfzRiw7ghOybbuTQLFTvN8dKSU4oWr3Xrl11a/WqyQ6+oPJOSl2I7VgRTCFjjI4uG2PxDC6WUkdRsmlguinM7tBN6jT/o0SuuIOzLAtjA7LarH3ru5aM8q0hDZmOk1etaO+DYB4JhIGR8QrKjpmnhXGVy0fsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O4PDZzyU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=30dWzUUF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kv2lVQxp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QI0fp81H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O4PDZzyU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="30dWzUUF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kv2lVQxp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QI0fp81H"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B2461FD95;
	Tue,  1 Sep 2026 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788253986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9/yDbDroYMYWQ5jgXtiSBkd5LhnzJvmafImsogk+Z4=;
	b=O4PDZzyUAAf9sZhIc+J6qbLMvWzQ1zIyw7EHCrLIJzz2a6MpfajWlIt5qMgRJn0To/u/2y
	Wp4XZuSZ3dXPMAJQZXUJfXUnZe4qSkdzW/bSf65TWL1xZzFNmDwIZn41tRh0ILXNqVX9wV
	SPDtYPobjSzd8sIQ+sAkVrVv5m6FnEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788253986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9/yDbDroYMYWQ5jgXtiSBkd5LhnzJvmafImsogk+Z4=;
	b=30dWzUUFbGf+5rBzxD/ua1a7TbL7ZM/klCGakIvhNonGIA5xncSBPbuohiflmGbvmDffHK
	+MO9nX0cRcGQXyCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788253982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9/yDbDroYMYWQ5jgXtiSBkd5LhnzJvmafImsogk+Z4=;
	b=Kv2lVQxp9tUqg0M2rt4Fa7Jhw7WMkN44RhG537sA02MAoheJrKmXbm9R1hLWgOdMXXcVA7
	8Zdkrtcn/hIko3Sy/qAZU1/ztpLhqM7lRcY3Vgtux2GSfka22BLDzZL9U4ywdRRStweysN
	vG62yCfSks53ObzJc1Y2Tsva/oumBo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788253982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9/yDbDroYMYWQ5jgXtiSBkd5LhnzJvmafImsogk+Z4=;
	b=QI0fp81HygXY7PdAMRBNWFeFgxuJJlQcQ4DsgsIqOFxAf96Raz8mzS3A9+EI+/7dj50BAn
	y0GoOhGn1oArFaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 571301369E;
	Tue,  1 Sep 2026 09:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0tI7FR6XlmrIMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Sep 2026 09:13:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D27B3A13AE; Tue, 01 Sep 2026 11:13:01 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] udf: validate the device specification EA before using it
Date: Tue,  1 Sep 2026 11:12:25 +0200
Message-ID: <20260901091256.1226297-3-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260901091037.30587-1-jack@suse.cz>
References: <20260901091037.30587-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4294; i=jack@suse.cz; h=from:subject; bh=j0Tn04c/qgnQ95WBl/EGXEwba7cD9Gn0b7ZbBJA4RlU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqlpcY5qBmTfocdLGXbkSPmyteIcDj/3Jf7H4n6 nADfT09YkaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCapaXGAAKCRCcnaoHP2RA 2WZsCADbCU/63sq1cf566Vi1Mom+wdeE2DGDw6Z6FYODvkoIOFv3KtoCcpEqOuESKDB6xoOZz/u KpLRmlaUGDGXoHzNmDTRr8+nyUD2GT/aB0PDddpKzaTogiE2gXeFHVhPRVFgq9e+zVfM4eD4i++ FA+ySWjvJSA8fneFIQRgxkpV4UzwhgzGbxRMSRNkDKpVwjrE8/BdigSWVsg1FsPOcVCA+cxPmUh anQm/L3SD6GaAk2jkSwyXN2ZWYSai4L88yV+v/bOIkE9iVw11wuJWXY+J7dN+8J2QlX1vn/uARb jrzUoS/lPGadTwWRlKEleE9BpDpDkNGENCKF4A0al1e4nZjM
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,qq.com,vger.kernel.org,suse.cz];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com]
X-Spam-Flag: NO

From: Yunpeng Tian <shionthanatos@gmail.com>

udf_get_extendedattr() bounds an extended attribute only against
struct genericFormat, which is 12 bytes.  A type-12 device
specification is struct deviceSpec, which is 24 bytes plus a flexible
impUse array. Thus a corrupted filesystem can contain extended attribute
that is accepted by udf_get_extendedattr() but udf_write_inode() or
udf_read_inode() may access beyond the end of provided buffer.

Provide a udf_device_spec_valid() check to validate correctness of
extended attribute that is a deviceSpec. While here, check the result of
udf_add_extendedattr() before dereferencing it as it can return NULL in
case of error.

[JK: Removed duplicated validity checks]

Reported-by: Yunpeng Tian <shionthanatos@gmail.com>
Reported-by: Gongming Wang <gmwgg05@gmail.com>
Reported-by: Mingda Zhang <npczmd@qq.com>
Reported-by: Qinrun Dai <jupmouse@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yunpeng Tian <shionthanatos@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index e45e546a739a..baf9845ac06b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1336,6 +1336,26 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 	return err;
 }
 
+/*
+ * Verify validity of struct deviceSpec on disk. udf_get_extendedattr() has
+ * already verified the generic header and made sure attribute fits in the
+ * inode so we just have to make sure attribute space is large enough for
+ * deviceSpec struct and required impUse information.
+ */
+static bool udf_device_spec_valid(struct deviceSpec *dsea)
+{
+	u32 attr_length, imp_use_length;
+
+	attr_length = le32_to_cpu(dsea->attrLength);
+	imp_use_length = le32_to_cpu(dsea->impUseLength);
+	if (attr_length < sizeof(struct deviceSpec) ||
+	    imp_use_length < sizeof(struct regid) ||
+	    imp_use_length > attr_length - sizeof(struct deviceSpec))
+		return false;
+
+	return true;
+}
+
 /*
  * Maximum length of linked list formed by ICB hierarchy. The chosen number is
  * arbitrary - just that we hopefully don't limit any real use of rewritten
@@ -1654,13 +1674,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		struct deviceSpec *dsea =
 			(struct deviceSpec *)udf_get_extendedattr(inode, 12, 1);
-		if (dsea) {
-			init_special_inode(inode, inode->i_mode,
+
+		if (!dsea || !udf_device_spec_valid(dsea))
+			goto out;
+		init_special_inode(inode, inode->i_mode,
 				MKDEV(le32_to_cpu(dsea->majorDeviceIdent),
 				      le32_to_cpu(dsea->minorDeviceIdent)));
-			/* Developer ID ??? */
-		} else
-			goto out;
 	}
 	ret = 0;
 out:
@@ -1757,6 +1776,7 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 	struct udf_sb_info *sbi = UDF_SB(inode->i_sb);
 	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	int err;
 
 	bh = sb_getblk(inode->i_sb,
 			udf_get_lb_pblock(inode->i_sb, &iinfo->i_location, 0));
@@ -1821,6 +1841,10 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 				udf_add_extendedattr(inode,
 						     sizeof(struct deviceSpec) +
 						     sizeof(struct regid), 12, 0x3);
+			if (!dsea) {
+				err = -ENOSPC;
+				goto out_unlock;
+			}
 			dsea->attrType = cpu_to_le32(12);
 			dsea->attrSubtype = 1;
 			dsea->attrLength = cpu_to_le32(
@@ -1828,6 +1852,10 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 						sizeof(struct regid));
 			dsea->impUseLength = cpu_to_le32(sizeof(struct regid));
 		}
+		if (!udf_device_spec_valid(dsea)) {
+			err = -EFSCORRUPTED;
+			goto out_unlock;
+		}
 		eid = (struct regid *)dsea->impUse;
 		memset(eid, 0, sizeof(*eid));
 		strcpy(eid->ident, UDF_ID_DEVELOPER);
@@ -1962,6 +1990,11 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 	set_inode_metadata_writeback(inode);
 
 	return 0;
+
+out_unlock:
+	unlock_buffer(bh);
+	brelse(bh);
+	return err;
 }
 
 struct inode *__udf_iget(struct super_block *sb, struct kernel_lb_addr *ino,
-- 
2.51.0

