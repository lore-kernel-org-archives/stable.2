Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83D38E11C
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217634; cv=none; b=FH5UEQBYQOkB4Axxw9u+/fckvYE+Uo9+FxYjv1NDwH6BYgjyhRaZhpzFzY5cHSxba9VSSRom92EvnOS9UcTcUKjdEzFxbna4EZ2j2jdYiDZgILtaInVbplkbgRLjR1oMevHaGKQIFnx3KVycYPzeLASwISr5UBonkg2n72yz+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217634; c=relaxed/simple;
	bh=WEVzdHnIrxW7ukPFi3t/nbWPNFeamWzAa1bOWFuAGbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yd0+bd75rCUeitAB9/kxKilQAydMRt4pgN8vos/LlbZ9fYlOb36u/AKu/gSJmjBDrL9z4Qx9BtZdBIhJyuulG/3g3WFRcKwsjaTDpya3xo+tykFWfhoWEtsm1Lj1N4QiSKkRRG2iPbxoL6+KI38XFlvG+lW8H4os0ukQ1ePhH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=agEFV1CD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="agEFV1CD"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-915d64fead9so161032785a.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781217632; x=1781822432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OivJuIkzftvepgBn4SH1tH/D3MOGhONxBQFKa9XkFbs=;
        b=agEFV1CD9uXxWGpDGstZgq8uIv74/bS6xvUvu2BHfvUJ/tJ1m+6zxf+HpC/64TbpAA
         gB67bcPChYMgZkayQhR7gn4cIfymrgGKs9LWLJgVAh9JylL0PDITOWmrNEzzTiu5pPw7
         PqEgrTFvecYojJSEicpHdgGxcR9MUkKixO6qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217632; x=1781822432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OivJuIkzftvepgBn4SH1tH/D3MOGhONxBQFKa9XkFbs=;
        b=ePy59Ghzdat4FgcUvApc/cSph5dT9/h5sm2XmZn7//wG7LdicW++HpRjir+3TMSoaB
         PX6xmpHzGBSbw6NjehsERJicyXgJdkLGbB2vIlKMOxDu04h+H3Pq+PS7fUdEYP3JSpzj
         PzKZ1avrpYjyvHLEvPLfn8DOE2FO0Kz0jfimhREXaEFiDgBN0JgbKsi5UnTU0XDidQf/
         j5soQLO1vae9u+t5jZ/gtfMYsq2+ZFCEm64E7vRi2bOsWRPr5iP/BYJXHnYk1D9qKJtn
         LluTVbP2vn0o2nICYLcOe+XadLDzb9hNrckYyDwrGfGF5J9KirEq3Aq4IQ4bR4NASEK0
         dq5g==
X-Gm-Message-State: AOJu0YzukHB2C7WwrpioGvzKAZ3A+4obANo4Sc0DCNziXiarSuBXe219
	1TzYltqCSnCncVJHiNPHY6P/kS/uReWjlYT/WLqcZ9iushZW6hdK2H9T90hH71xTrCxxOtrkD6z
	aYVstYig=
X-Gm-Gg: Acq92OElHb3dS9vqSAT0LU5Yodb6Mgqmocn5gRMUAtRZ9xMbAJnTgc1zg2+H/F7gncP
	bMQwjg1/3LuAF3nqXaequgw3r+m1DswfdaZg+Lb2K71MjkfVQsfYXrHQ9j6CFRaAT+5vakYqL3F
	OnEpyAwPzYVEYrIh1Wo069E2dZsriYBhllpjH0h/bir8OKZLOzFBviU60ULAqMu5dYLWtx2Bem4
	X+1OZj+kQ7a3ahhez5zDytguW97aJpHa8u9Bc6PjZ7yWW8xf1B1D0lJ9+CLU8wctiwOsPrEDHU7
	JpR8buParELcQ8L5wXavDtPs4hNxpIWHH70XRUkIuBp+v+L46HN7prVDjSzUNEQpQtYEttDAzQf
	zLfpm60MyACPRbMTUJc0SaleOxRe2Fm3POlv020AIPXMXIWZK1EvSdD+ShdX+HLUVNrJExWLoHg
	2AqGEOMdkJ+mhXu9Jfm7wtoBeAR6wLP8c9thp1qcb5Yf4lQAPJQLEVSD5jZHwoRF9cAo/T4QXFp
	/bMnSy7Zk/BoA9ODnuVKOw9SbJzS7FY/A4=
X-Received: by 2002:a05:620a:450c:b0:916:1765:b774 with SMTP id af79cd13be357-91619eff271mr105185785a.21.1781217631701;
        Thu, 11 Jun 2026 15:40:31 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fe7sm46133785a.12.2026.06.11.15.40.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 15:40:31 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: stable@vger.kernel.org
Cc: outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH 6.12.y] reiserfs: validate tail item bounds before conversion
Date: Thu, 11 Jun 2026 15:40:27 -0700
Message-ID: <20260611224027.74281-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

direct2indirect() moves direct items into an unformatted-node page while
deleting them from the tree. It assumes the item body copied by
reiserfs_delete_item() and the aggregate number of copied tail bytes both
fit in the target tail page.

A corrupted filesystem can violate those assumptions. Multiple direct
items can each fit in the page while their aggregate length exceeds the
filesystem block size, which underflows the final zero-fill length. A
malformed item can also describe an offset and length that cross the page
boundary before the aggregate length is checked.

Validate the per-item page copy and aggregate tail length before calling
reiserfs_delete_item(), and reject corrupt metadata with -EIO after
reporting a filesystem error.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/reiserfs/tail_conversion.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
index 2cec61af2a9e..ba3dd6770d46 100644
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -106,6 +106,8 @@ int direct2indirect(struct reiserfs_transaction_handle *th, struct inode *inode,
 	 * and delete them.
 	 */
 	while (1) {
+		unsigned long item_len;
+		unsigned long pgoff;
 		int tail_size;
 
 		/*
@@ -120,6 +122,17 @@ int direct2indirect(struct reiserfs_transaction_handle *th, struct inode *inode,
 		RFALSE(!is_direct_le_ih(p_le_ih),
 		       "vs-14055: direct item expected(%K), found %h",
 		       &end_key, p_le_ih);
+		item_len = ih_item_len(p_le_ih);
+		pgoff = (le_ih_k_offset(p_le_ih) - 1) & (PAGE_SIZE - 1);
+		if (item_len > PAGE_SIZE - pgoff ||
+		    item_len > blk_size ||
+		    total_tail > blk_size - item_len) {
+			reiserfs_error(sb, "PAP-14060",
+				       "direct item %h does not fit in tail page",
+				       p_le_ih);
+			pathrelse(path);
+			return -EIO;
+		}
 		tail_size = (le_ih_k_offset(p_le_ih) & (blk_size - 1))
 		    + ih_item_len(p_le_ih) - 1;
 
-- 
2.54.0

