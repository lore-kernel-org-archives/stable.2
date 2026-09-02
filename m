Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75E4195C8;
	Wed,  2 Sep 2026 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390075; cv=none; b=dxZbziUjEjvGG9KR6tLtlqx5+gECFAizHPrUipiHr+7FDOWrgDK17GJY0PXrgg642LyZo7J/czw8mdUlpYigsOwwnzAc0RaqE0+9x5wZR5XA5EkWCZ/6uTJLsDCvXs3oIyv73lRLRDQFUgGrYo0HgD1Gdec0G5H9lJntSah8f4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390075; c=relaxed/simple;
	bh=Jb726CQwB7FUTQYyG3EUVFK9PY2m2B5Jdn2aq4KroFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qgr89/dVhnT9VWhKIPuJr5BKUh7aCP59nYyPK7zt4+pjT1LxbXQ2v4DvSyOW6aYYAbiVaU2FkQ5YVgYKVjVoDss8l5mYH4DYE/rdMZCVfcwUDQKUnPZGeO7yM2UIspsGUQ4CbhGGg+KmxYecNyUU+HGn9pceS1xqp01NcUulPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hepmowgQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lAT/FCRu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U1f3QS/S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CVSoFHV4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hepmowgQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lAT/FCRu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U1f3QS/S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CVSoFHV4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 070C521D82;
	Wed,  2 Sep 2026 23:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788390061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qysi34Kn5KsSAFGVHgjIJNUVTwBXBlCr+X9G2rei06M=;
	b=hepmowgQgl6WeDaL+KRiyWuXMBfF5kFPyU37ToKAi38eSvINrECmu42b34I/S40AEm4wSn
	mDgeIiqlXDecaAWbgC2nTofF5YyOF1UWBvvTHWnGgloKefmfdwFXWsDVVXD/3xAya8nYX9
	oRBhGqGBAgshfPy7Evt3DYq1vdtekRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788390061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qysi34Kn5KsSAFGVHgjIJNUVTwBXBlCr+X9G2rei06M=;
	b=lAT/FCRu9gBejoc9QDABYbgVJOZEee6fU66yQDcvm5GQZCc5sleuYt2w0xl64j67Wb8U1Q
	FnK8su1rQO6qBiBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788390057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qysi34Kn5KsSAFGVHgjIJNUVTwBXBlCr+X9G2rei06M=;
	b=U1f3QS/S14JHKaRulrGlQCLYshIA5CvWHOzUAdj3UJZva8Y4sr2YJLzRm3xAOuRrgGJNiN
	5yNqMF9lAX1RWsyp4hzzA6I8bgg2yTEF0PynVTUDzsBAg02SAGu430gd8RUF9/hPxWcyMY
	JbCuxVxFJFwwkWt6n1fF4tzPFCMhEj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788390057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qysi34Kn5KsSAFGVHgjIJNUVTwBXBlCr+X9G2rei06M=;
	b=CVSoFHV42XULbzjdX3nyhWjzu22VjGhNJna0U8U9Y9Fd0RHlX7SjUkFIOPJXOUkax0Unyi
	qSOriFaBrZb1mHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44E7D136E6;
	Wed,  2 Sep 2026 23:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XE07OaeqmGquCgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 02 Sep 2026 23:00:55 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring/net: let io_recv_buf_select return the length of the buffer region
Date: Wed,  2 Sep 2026 20:00:40 -0300
Message-ID: <20260902230041.1320658-2-krisman@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902230041.1320658-1-krisman@suse.de>
References: <20260902230041.1320658-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]

In preparation to using this field as an upper limit to truncation,
return the size of the allocated region.

Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 io_uring/net.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index fbe719d86c46..647156c9331a 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1108,6 +1108,7 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 			      struct io_br_sel *sel, unsigned int issue_flags)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+	size_t len;
 	int ret;
 
 	/*
@@ -1153,13 +1154,14 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 		/* special case 1 vec, can be a fast path */
 		if (ret == 1) {
 			sr->buf = arg.iovs[0].iov_base;
-			sr->len = arg.iovs[0].iov_len;
+			len = sr->len = arg.iovs[0].iov_len;
 			goto map_ubuf;
 		}
 		iov_iter_init(&kmsg->msg.msg_iter, ITER_DEST, arg.iovs, ret,
-				arg.out_len);
+			      arg.out_len);
+		len = arg.out_len;
 	} else {
-		size_t len = sel->val;
+		len = sel->val;
 
 		*sel = io_buffer_select(req, &len, sr->buf_group, issue_flags);
 		if (!sel->addr)
@@ -1173,7 +1175,7 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 			return ret;
 	}
 
-	return 0;
+	return len;
 }
 
 int io_recv(struct io_kiocb *req, unsigned int issue_flags)
-- 
2.55.0

