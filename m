Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700734;
	b=oFXCaPPs7iJH2nHvLbFkSQqg8rRJuzUWL4aik813INtSHLHtTvCGQ1VoDlrkFO9jOxKB
	 cNP7n/iZvMbT7lp16Gr8JqfOgKgY5SU5CeKAk5hS5QFW0XGdx2531huqgKNWNwuz1Rpn3
	 b1txBg/uJPF2IcsskBopArl6oqL07X38zhPbri/ayiKxTnHEUJMctnPt24FliOKg34vGL
	 UiMmExAtgepkxKuwvBmES9eW6t4KfeJvTcoB8DgM1cVTM5ibWeTMk1tWrGwtNPYXpyQO+
	 QIjfwp27Mlc/phSm68AFBLG2yJnCwZJ66OCVQgvavaULtkgrtpafTZnmaTY9xDJXEoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FfNOitLIXBWU/EzJpPhxbyv+UkEWJ2JnXPpF+ZYiRo4=;
	b=MQoGbz0B437ASHoryApg5nvy7zA+dY1fdifCz9j65J2JQnqjQqjhAqkwKjMxpSadQtNx
	 os5HhCabXXD0muDMcEq8CQyqF2zDGP9rwLsesW7OrVed4J/gOL3UwooM8w70r7ZiEYYM4
	 Fm7qqxPTcqGhdyRQLe9+wGcA+Qhhve+TQOHh7beQZilq/PK8SiwqI/68PUkE8h8JuMRpK
	 yH3+v19kqCYUru2CE7RMJqDlhXtvebUWWV9r77L3KGACi94JLz5vcfwMNwjWBxMtYcr+3
	 /BlPW+YHhFOFiA26THzncyqo81Ibky3GaW8OjWCxQkB5BfGa6JRLPdNwdjtNvNs+TLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2gakbdt;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C641606A32F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C641606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2gakbdt
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9cf928dc9so2518355ad.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793700734; x=1794305534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FfNOitLIXBWU/EzJpPhxbyv+UkEWJ2JnXPpF+ZYiRo4=;
        b=C2gakbdthO2ch0hfbmtxSmZ0Hirj4mIMqIv1yfvxzNQBGgoazOeSxau91fX9x0ovmU
         +TzPJSce3FNeiA5crKSeebOsG1PXz/49YYd6buyHWeuMAhlg5UEjYWETsQfFrWu6K93n
         KOPM8W7gDbYxfrC3jy3SAdq2AgQrrgFOGqLivpbr2cO6eWQF576MXVSlFnj/nV+lDkoW
         Nsa842j3LaYzltc50hJbAUB6k6+YdxOj45/GPiLX0OOeDk/n7DGMi8E3J8MdWEn4QRZw
         nliHY5Di3ljO25IUg1cW4QosN2WocV4Bq+kgpzUxQmB94ZXar0d4dvrflAl/eSe8Avab
         WdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793700734; x=1794305534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FfNOitLIXBWU/EzJpPhxbyv+UkEWJ2JnXPpF+ZYiRo4=;
        b=gmKTNGSLGKkx7P9kgY+3CXNyBYYZXazvPNB8BPi5ROA7vw/0vRxmLVFbGtGFk2oVJ8
         aMMuym2y2gCECzg1DHQtZX6Cji36p7xb7B2qN6R3KfIH8KalEbKW2PPDAzgZ8+jpLK7Q
         pWaAsRg8/EEbFR8EsIKjT6d40mqTZg9E0fph8JDF96rYpFNqWaU1Tn7M/OiJKaIyxN/Y
         K+LwNJ4iAZ7YsJ6iVevzr5Yu50+Q3vzqQ3Z7g/TZhAsGzvPlHNz0m4EKSP6Lt0Bwl1zA
         GJ+lad7jqe2JnA+dLYW+7qZc3LERqpi+4PE8aAl26TAnR5LwIt2TgxQRuLhepZRuW9Un
         3DXg==
X-Forwarded-Encrypted: i=1; AKwUvBwOGtGSNlBQRnsGx40Ofl6ZJWDXlMwA2bDQVfUVRfUV7hL9yz+bgT6iuMFJaA/CgsAvnM9p7uE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z9wQKGCaKn/daX4SKWlg6dyOqqIePPvwI2FG3JQSpskUYyD3D
	AKOpQUtt7PuXqYdLEGL0O2HliQ5T1QSBD+52wSqX+1TS3gcOEigvBlXS
X-Gm-Gg: AYBFou3FaknbZUjsXekJuPpRZ1oRRKnmtovDqfQVDXaRsBYZtrRUXky+xuvaegAuVhh
	sxhGd43sMN03oV4uDKgdATDGlyeLyufe3nyFwjGhLtJNfaxZdqi2E+FgMkNHkCSuYAjWwEfcSug
	zOiWpoD+gqsYKNr6OOPiUz1SuL8NopRXkLWO5n6xaEZjQ8dOom6OtF5GXIYZWtF8Xi9QR5BLfaS
	Yp3IKqot9KuuKk0XLr3cdvte+IwZoLRJ7zbJCw6TKIh19gM6ZVCH6fkXRhkO0E7fhPQi/z8Fzwf
	U0hpQAcr2/oQIa56Y9kDGTG4Aexh3hQu7wGTz23AoG8W0nqZKcZ0Mvaix6DHLM109ClFPu8MReJ
	8rln7RnjgDRYt5Vwx8SWOAiJQkTmeq+dbinC28+jzjY0OqMmHT5KUSvWeytSUDtcvvLiENRDNUR
	o7OVSkJVehu5sZKbuBCCTxYbCcxWKWzasM2D723BRmHlxw5aPYjyH8quSdchu2nQIpov983cpNA
	89Uz1u6OQV+xoObY8CByULxHvnIx9UO1zLtJm+W41cDpgMiU8XJ17QoLqxq1ZePAGOFhYUIRYek
	SQl07x+240G7Sn7JVQx8gvmyJ9w7MqHEu6Bg+8fyRVYrjV7VrCH70M4h9dQ=
X-Received: by 2002:a17:90b:1cc5:b0:3ae:3d82:5d88 with SMTP id 98e67ed59e1d1-3ae8917bf84mr7426716a91.0.1793700733700;
        Tue, 03 Nov 2026 02:12:13 -0800 (PST)
Received: from localhost.localdomain ([106.101.10.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aebc89475asm4934624a91.0.2026.11.03.02.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:12:12 -0800 (PST)
From: Seungbum Ju <seungbum.ju@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Seungbum Ju <seungbum.ju@gmail.com>
Subject: [PATCH] f2fs: wait for node writeback on the first fsync after a checkpoint
Date: Tue,  3 Nov 2026 19:12:08 +0900
Message-ID: <20261103101208.4550-1-seungbum.ju@gmail.com>
X-Mailer: git-send-email 2.55.0
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

f2fs_add_fsync_node_entry() numbers each fsync'd warm node page with
sbi->fsync_seg_id++, and f2fs_reset_fsync_node_info() sets the counter back
to 0 at every checkpoint. The first node page fsync'd after a checkpoint
therefore gets seq_id 0, which f2fs_do_sync_file() passes to
f2fs_wait_on_node_pages_writeback(). That function treats 0 as "nothing to
wait for":

    while (seq_id && cur_seq_id < seq_id) {

so the fsync issues its cache flush without waiting for its own node page.
If the flush completes before the node write, the inode's fsync-marked
node block (needed by roll-forward recovery) is not covered by the flush,
and a power loss can lose data that fsync reported as durable. In our
traces the first fsync after a checkpoint returned before its node write
completed in many trials.

Start the numbering at 1, so that 0 keeps meaning "no node page written".

Testing (kernel 7.0.0-42, f2fs built as a module from the same source,
QEMU/KVM, block-layer FLUSH/FUA model with dm-log-writes replay):
- block traces, append+fsync after sync: FLUSH issued before the node
  write completed in 29/30 first fsyncs unpatched, 0/30 patched; never
  for later fsyncs;
- crash-state replay (28 cells x 3 recordings per module): SQLite
  WAL/TRUNCATE/PERSIST, LevelDB, RocksDB, LMDB and an append log lose
  acknowledged commits or become unopenable in 24 cells unpatched, and
  are clean in all of them patched.

The same code is present in Android GKI android12-5.10 through
android15-6.6 and in the f2fs dev tree as of 2026-11-02.

Fixes: 50fa53eccf9f ("f2fs: fix to avoid broken of dnode block list")
Cc: stable@vger.kernel.org
Signed-off-by: Seungbum Ju <seungbum.ju@gmail.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1234567..89abcdef 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -361,7 +361,7 @@ static unsigned int f2fs_add_fsync_node_entry(struct f2fs_sb_info *sbi,
 	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
 	list_add_tail(&fn->list, &sbi->fsync_node_list);
-	fn->seq_id = sbi->fsync_seg_id++;
+	fn->seq_id = ++sbi->fsync_seg_id;
 	seq_id = fn->seq_id;
 	sbi->fsync_node_num++;
 	spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
-- 
2.45.0
