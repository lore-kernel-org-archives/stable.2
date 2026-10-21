Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568221;
	b=qkK3fvm2gPhIJjXA47+U3VQgdxgZ94Xt4VPh+vtsqoSpRQ6LP1frIdV2FZtPbifYyUvE
	 AIfRPDsJ5ZqiMNFjsAT7RCtnBfMaV98jJEj1xtaZkxNg3DxF3YbyRK947fhvn3MyUcXyW
	 oA94owSwe2ZGXPUu5lRNJo22UeexBnLHRRFFylC+u298LddAY9Ql3CegeIoxxY3b0ukCL
	 v3/SwmLQBjjdYkGnDpbxycgJokm4jVzpKCEhh6ofLFtC/+xaGqqDFk4j7kbLMROH2O0x8
	 6K04M/FFfeD4+BO/HSNlCyyAwQB7NhXv3GT4GPRKEbHQMYIAqRQK5nQxtyUMnRTGEog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
	b=GZM5xWU1YmT5hQkbk+rmJMcnoJBsEW172DMo+IEA1tfPi4mS6SHpNTk2Od2k1gm3zqeB
	 wloBpsGI0Izzkl6leaBtBxKCUBIB8RLcA9QY7wcVDYawEzzVWPn/u8DEh/8UOH+i8b7j8
	 pe2y1OhrbpH2Cmcie2mxVCNt0807OshRlmYOlpBHMllXyaDzeU4HWXFJyajnyIsklhQWc
	 ibKuZfMvjC+XHAlOQKz/GvCN36aonV4U8ykEXIXzIryDnHA/HORfzr+UCYT6oK+2cuX3u
	 alX3O4e5BttrGi7NPpsTGNsxq+76gMcT61qjqsyJlUJrrwBLJK/zTMeN9BwLqw2WhUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gagodWgB;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C6606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E7C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gagodWgB
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06e79e152so186336b3a.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792568221; x=1793173021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
        b=gagodWgBrgFA2S7b38LrES3z1xTNxB2kePPhg4Th6LZJTOssH549Zk5x5ny88HFah+
         vKG9FKZnV8i0jqsHU6lhMf/+/L7XD3H8SwpN8IxefAD+LvQUGLoPK0PdLIz48F3Yqt+l
         dviCyu+7XfHzDAMgm2o1wULlGbFcv1pkVmalVRV1I4HdlY/B24YAu4pGy3DRbr+SDDtw
         QgK+bPW41dChCJRH+4c/gPi3g8B4g1ADLu3qF8/wAaFv7qxfbx0leJLPa0IbFlcKP/cJ
         NRHHvV5Tv7rsylfBuURyLghW2AIfF1efHWFM1r7lx1h8G8e6d2ipA8VifrV7coTzD6Fy
         +BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792568221; x=1793173021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXD1UXa/1j2wgsFUv0w36GnGU79I5JqF8Ggu7ibN9oo=;
        b=CR4F5KmFcGwKzC3AcN/HaIzmoYvO/ueijqY/bxW9Yjkvq/PcO1/5kxmpr5r/Ks1O87
         2AV0h8wSkrp7QIJHoYHIK18A1XXGWfFWCAUmGrDwu6wBN/k2xMGUHJUkx009jNlFtk3O
         GOKMDezu27itHu9DaAi8acHXZwayBT6swJ/GW0fKSpr5lnNgwYWTUOybd8oiVIJlpQ6i
         8L6EllTIns7/Zw2/TU/5tN/dUQNlqQsQ0CbarHBU5651t3ISHPdQF1TYclS/0UBrrghM
         6z3OukzcMg3PHQqBpB0EWnywwYBdFoszB7ghiT1AqZsqC1RS67T9+fkAFsy3fqTo7zT2
         rUmg==
X-Forwarded-Encrypted: i=1; AKwUvBzOVgotYadAInnyj8FR8lUqUq6I/i7sRXhxRDURLoVYt3ZOFLMyZgY1T4Cc/0ZIHamGDqDbjgA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBkjtkC1iSxXuWFvJ3eoBwLk4SdXshB2Nf3uJkl8WbMlRnS+D1
	h+DiTFKPwfsPAJcSeZRu++eefqbm3zwQq/EClqOCXFTVvXIAOjvC9S88MkerLw==
X-Gm-Gg: AYBFou2+8hrBkA+Ntd+mafK5TBGi5UMvxx+AkavcPknorJcHhzQiEtavHk0WCz6WmO7
	SJPGGWJ0hkxeGNvCqgaiPNXdaOAriTJaHQoGqFf0O5nBlVN89LYqXjnNvOBGT/nZ2Ve770ULmWC
	vsoI6rWVQ2Nd3O8fvaVktWm1XEWs6+4VP8I2F8VrwN4EPmW1PQFSaYHzijthAzq/Nr0gc3PEBry
	BdRA6SDbEwDquywtMbnXwyPytvKKjW8NInq0dbHD/BfosUSgBID5SvGYU0cw68j78p0moTs0izv
	K0D0ZvswgMRlpGzsoqbwCHkH4KWu+o/achOTKFLI6bm+FppfPqsedH7Dos0S5dz43ZzcjNGN48m
	SZwLNe6wM20w/Hewvx8wgwMDiXpNHwxS5X58sXfiJzNMP8X3pXAUojvGLP5GysVsjfVluBRoPr8
	cZq323k3cMC7IBQcVLgLRVmKnRviPOFZSOK2DjElQbOYqxGYK1ZuhkoN4pN8iyQvS2m2IuQ6sEH
	qEhAflJJPfzivcio/sf/cdocP33ivTn8ZSCYOn9s0YPup5z6j0=
X-Received: by 2002:a05:6a00:1c94:b0:8a0:20e0:b131 with SMTP id d2e1a72fcca58-8a089f250cemr919057b3a.19.1792568220671;
        Wed, 21 Oct 2026 00:37:00 -0700 (PDT)
Received: from linux ([103.155.143.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895dc12asm541962b3a.40.2026.10.21.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:37:00 -0700 (PDT)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
X-Google-Original-From: Hongyu Jin <hongyu.jin@unisoc.com>
To: linux-fsdevel@vger.kernel.org
Cc: hongyu.jin.cn@gmail.com,
	hch@lst.de,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] writeback: don't requeue inode already on b_dirty
Date: Wed, 21 Oct 2026 15:36:34 +0800
Message-ID: <20261021073634.132369-1-hongyu.jin@unisoc.com>
X-Mailer: git-send-email 2.53.0
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

Since commit 846a3351ddfe ("writeback: Avoid skipping inode writeback"),
writeback_single_inode() calls redirty_tail_locked() for any inode left
dirty. When that inode is already on b_dirty and older than the newest
inode there, redirty_tail_locked() moves it to the head and stamps
dirtied_when with jiffies.

Append to an f2fs file so the i_size update puts it on DIRTY_META, and
dirty a newer inode before each checkpoint. Every 17s the checkpoint
syncs that file and redirty_tail_locked() stamps a new dirtied_when.
17s is shorter than the default 30s dirty_expire_interval, so kupdate
never expires it. Dirty pages pile up until writeback or fsync().

An inode that was I_DIRTY on entry is already on b_dirty, so only
redirty it if it was not. The b_dirty_time case fixed by commit
846a3351ddfe ("writeback: Avoid skipping inode writeback") enters without
I_DIRTY and is still handled.

Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 fs/fs-writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 58a6403780aa..fb33a63710ec 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1898,6 +1898,7 @@ static int writeback_single_inode(struct inode *inode,
 				  struct writeback_control *wbc)
 {
 	struct bdi_writeback *wb;
+	bool was_dirty;
 	int ret = 0;
 
 	spin_lock(&inode->i_lock);
@@ -1932,6 +1933,7 @@ static int writeback_single_inode(struct inode *inode,
 		    !(inode_state_read(inode) & I_METADATA_WRITEBACK))
 			goto out;
 	}
+	was_dirty = inode_state_read(inode) & I_DIRTY;
 	inode_state_set(inode, I_SYNC);
 	wbc_attach_and_unlock_inode(wbc, inode);
 
@@ -1954,7 +1956,7 @@ static int writeback_single_inode(struct inode *inode,
 		if (!(inode_state_read(inode) & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
 		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
-			if ((inode_state_read(inode) & I_DIRTY))
+			if ((inode_state_read(inode) & I_DIRTY) && !was_dirty)
 				redirty_tail_locked(inode, wb);
 			else if (inode_state_read(inode) & I_DIRTY_TIME) {
 				inode->dirtied_when = jiffies;
-- 
2.53.0

