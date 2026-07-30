Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C83FBB5A
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408168; cv=none; b=NrflvOZwXMyj53rfSOQzxCU2DWDrn8BP6asIoSl+9GVrmbrLnT2WAF/gv17ciQvNV3cRt3mnDaCL8H3o1paTtc4xIT1CmKEmecG98jthc6VFcPndC22IW+QtLqkYL4CF7L66EpK306OxkkNcyX+LBucYtcNwJiFQ9j/bErpunkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408168; c=relaxed/simple;
	bh=BkrI1H7eJsex0SWvHczXR2CI4efZxQALrQb1owj11rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNVWzf4gxP+UHYeYtOY+mksp4PdZIKXTUHT2IERMsaa/WE95p3FdUBSGt8IMapq3FRMetzesAW78G5v5DALR2vg7njWafuh0h1YabZ+Bd6WUaHuRCpb8V/PEI3IqmCR9LCP8SdlF+M752+W/IboPyk9POUgnSvwx+qcc2uCWW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sFuBbPS1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gww0JpCl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sFuBbPS1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gww0JpCl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92CE97D6FC;
	Thu, 30 Jul 2026 10:42:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785408160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw7TMskyOQ+jsdjzzV6sqE73o9M9GSvMLIU6J/KJzF4=;
	b=sFuBbPS1Ng4mgNLmY/5h+8GcdnaThqpirEMrabSTK19Dg2Voa/mplswyemfgRM0XVJEPL5
	5e+onzRNFgqzC1okO8S9mh/P9qXPTQgRezhs2GX4TV8uUg2geU3tDg1FGr2vMNZf1drAc4
	gg89ArUrUAMcX4u0kMAUXb9XojU7ijE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785408160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw7TMskyOQ+jsdjzzV6sqE73o9M9GSvMLIU6J/KJzF4=;
	b=Gww0JpClgGyD227rVa0xa6YyVyPvVZXgMWA4bPN90TgKoiu6JQ/yKFC3pT2z+FJ7CHhr/q
	xSugbQ/yFFVvsICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88F7D779D0;
	Thu, 30 Jul 2026 10:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c751IaAqa2qAPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Jul 2026 10:42:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0C208A10B6; Thu, 30 Jul 2026 12:42:36 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] udf: Fix data loss when converting inline inodes to out of line
Date: Thu, 30 Jul 2026 12:42:29 +0200
Message-ID: <20260730104232.4086759-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260730104040.18150-1-jack@suse.cz>
References: <20260730104040.18150-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=jack@suse.cz; h=from:subject; bh=BkrI1H7eJsex0SWvHczXR2CI4efZxQALrQb1owj11rw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqayqZZ+X8BEX6muXiHEPWHF+sECA4v9lqAatgM 1O7DQj3DGSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCamsqmQAKCRCcnaoHP2RA 2eB4CACYU9KcBArUkNHyIa3JPe8fiT5GfP6aiOyNK54LzqYkN9PvoFPeJg3pak2vqC/wTPwPk0a nerYH8tzqcb4sx8y0zfB89KwC0rJT3coxEybCX5r3bqzmYum81tihdkqyQN0Vr+5qfvcTDY46ZA 0cJ/OIJmjN6Ji+pgWvr+g0o5h7/7fQLyx8E/zPtxGhQle4+2p9qJE5Rvmnoh2HcDqeD6NzkXZ1t TMrv0dSxlUbtVNXo1m0HwwVAU/PBMr6W2YfUqWmeNLVTKI4xBT00IEs1eBgcepzpvV0/n1vZfjZ /dFxXuglA03oQ8oLIi4M7fty/dYGd3wPFNtQJFCDs105jLGf
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 92CE97D6FC
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

When udf_expand_file_adinicb() converts file from inline format to out
of line, we use filemap_fdatawrite() to writeout the data to the new
blocks. However since 36580ed08776 ("udf: Do not allocate blocks on page
writeback") the writeback actually doesn't allocate the new block and
the folio dirty bit is just silently cleared. Thus unless the file is
written to after the conversion (as it can easily happen in case of
truncate up), the data is just lost. Fix the problem by explicitely
allocating the block underlying the data before starting writeback.

Fixes: 36580ed08776 ("udf: Do not allocate blocks on page writeback")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index b8b9b7132115..b5e374f355b2 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -405,6 +405,10 @@ int udf_expand_file_adinicb(struct inode *inode)
 {
 	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_map_rq map = {
+		.lblk = 0,
+		.iflags = UDF_MAP_CREATE,
+	};
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -434,20 +438,27 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+	up_write(&iinfo->i_data_sem);
+
+	/* Allocate the block underlying the data */
+	err = udf_map_block(inode, &map);
+	if (err < 0)
+		goto restore;
+
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
-	up_write(&iinfo->i_data_sem);
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
 		folio_lock(folio);
+restore:
 		down_write(&iinfo->i_data_sem);
 		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
 				folio, 0, inode->i_size);
-		folio_unlock(folio);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
+		folio_unlock(folio);
 	}
 	folio_put(folio);
 	mark_inode_dirty(inode);
-- 
2.51.0

