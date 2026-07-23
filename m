Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3453E3163
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847672; cv=none; b=o5C1JlEHgwvKg5FgsbqFizAq5DRSqc9boBnAG70+qrwiflkLJGJ0NhST3IQYJtaz+xG6pnO0gLvDqf3Bk5q8rPW19SqO2JTgifAkmZORXUDB0BPyUixgO0eOpH3TAD9GfxRhbVXZhwfpmvwYjZBM0UKSa9T/ZWYqreLkGtr/w5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847672; c=relaxed/simple;
	bh=wnkam4gARZPimI6t3q6/gi53lYyin+NicZ/A9htdCU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+dl1CXbKdMmx7fn9on7sD/U9CQeh6Yo3iiVFoOoysToiSm/311Bm4gMdqJ+Y79KddsPxBX90QTB0nckNWoSu9DCRbQlPcwuod+wUj5inzXP2CgzgBWxX8qiL2Luh/1nvjvQDHBvfw6AnOMclCeGsboLApS4Xfwb4JvPuWlA1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y19sT8fE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y19sT8fE"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so148826666b.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784847668; x=1785452468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NkiiwKU0NKOWW0DOqWdWOWQ7VLeFhZ7u/mJhBXHCR5o=;
        b=Y19sT8fEkOIsL8IrKnzfW6BE0AvFo2eY9ikmiKCU3ZHRpEr08rDc5E4xUOAR4XbIl8
         yzN9Eu52MnwaHm1mQ2Rl0xs8uTVy/2GJu6Vglq3fz7zwK/y1snJCh+cJkyuMbtLizMNT
         DuWAQM7S50332ckydxQHsY63k67WG/EHKG4bXRgqxws/M/vkgZ0Wa8mvklyznKQYkyIJ
         4WdYtm5bqpbTKFS+0CTiL4PpYWvPXFS04b1+KTh3pjdsDeAwNK5NSPOZZCanledXDMMK
         n8rl9N2D1RB05ZtjJJbA/WYHcd0b4gRxpIG0hb5Njuyq77f3BX4W9Avw/zihEKG0tMxE
         zr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784847668; x=1785452468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkiiwKU0NKOWW0DOqWdWOWQ7VLeFhZ7u/mJhBXHCR5o=;
        b=P3M+mo0fm61L1tvtA4TVf2WDixp1kdHHthyIXQG1hN+qIm1nLY0GI5a1zKko1Xx21g
         Yu5huQVbVRcDKGqh/FC+pg9zypq1XYcy9SIAQrlnaltvTRVaij84HwqlEMuTaUYNQtao
         WNMCwkI8qzddKlENKksYRxsdAobkct/pfW0lhW0CHEP+kjS2d8CcuLF/xt4PTtteIHjA
         C1peIZvdAKv0UUfhANKHeS7C0cRfchmhLDe46oOQw18k+KVKlxBExUZ4nrj+MMjF4v0u
         qRrwmB0wvYHRs5joOoqCEYIDlOWa9vOQZWwZ9oYJDjjOEASgrVADrKb9haMDWIsa/SpG
         2d1A==
X-Forwarded-Encrypted: i=1; AHgh+RocWPgTqep6fDnxDcMCA7nGJmuppMjI0PKjNRh62aHqWbtmx8xVRzLy8pU8fhWz2zfVAMArmU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdtUp2VbYnkU5G73qBqh5JcRzbxAiytfJBG2ngZbGlvI3o4lA
	ycyK4IN6kqmLsHED9F5+KPkh5TaOcP+qU8RUpKXlgAqF83+vkZzR+9v9
X-Gm-Gg: AR+sD111iRj8GEBC9LnECZrOsXKZgbez3L8BGIli48HhY2Pb0waL2R6gY85aIrbiZ/u
	vchWy6qWK1/PQdVUnkz7ZtYDx2mYVflQIMW7+7GHRHV1qnTacBdvbCs7V7E2BSt8uKfWWsgrWrF
	tCkStGk4GQMdJswAw32pz0IiFBY6PN+nf/EQ0Apypv9yHKPLycXjRmiFssr5eZjuy7L58hm2t3J
	1JKE9M9FOJ8HiOiuv23h2EhM3zoKfOD77lWY79cXx679LxBR/qz5XzRM2m8bNI1bJsq2HYfAZNn
	j1eCRufLcS2C1Zo4DKeDgLMd0bc2R6kq225gal0vOkCO4miQMkBeaUapPIyo/I76kwqzIprjAZf
	ojVY/F3jdtnR1aPPfeyq4zsWgHBonDT3qGctK0p+Cte36NjGdKOUL8Bvp7jbqoHj4WrFoXw==
X-Received: by 2002:a17:907:72d4:b0:c1c:4858:c19c with SMTP id a640c23a62f3a-c1c5098acf8mr214121066b.23.1784847667654;
        Thu, 23 Jul 2026 16:01:07 -0700 (PDT)
Received: from beelink.. ([186.247.163.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a78e0fsm277534766b.2.2026.07.23.16.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:01:06 -0700 (PDT)
From: Your Name <qwe.aldo@gmail.com>
X-Google-Original-From: Your Name <you@example.com>
To: linux-cifs@vger.kernel.org
Cc: linkinjeon@kernel.org,
	smfrench@gmail.com,
	senozhatsky@chromium.org,
	tom@talpey.com,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: only rebind the reopened file's own oplock on durable reconnect
Date: Thu, 23 Jul 2026 20:00:53 -0300
Message-ID: <20260723230053.684176-1-you@example.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

ksmbd_reopen_durable_fd() walks the inode's m_op_list and rebinds every
detached oplock to the reconnecting session:

	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry,
				lockdep_is_held(&ci->m_lock)) {
		if (op->conn)
			continue;
		op->conn = ksmbd_conn_get(fp->conn);
		op->sess = work->sess;
	}

The only key is op->conn == NULL, which every detached durable handle on
that inode matches, not just the one owned by fp.  When two sessions hold
durable handles on the same file and both disconnect, reconnecting one of
them adopts the other session's oplock: op->sess is overwritten with the
reconnecting session without taking a reference on it, while op->conn
pins the connection.

The sibling teardown path, session_fd_check(), keys on the identity of
the connection being torn down (op->conn == conn) rather than on shared
state, and so does not have this problem.

Once the adopting session is destroyed, ksmbd_session_destroy() frees it
while the foreign oplock still points at it.  The reader in
ksmbd_close_fd_app_instance_id() validates only opinfo->conn, which is
still live thanks to the reference taken above, and then dereferences the
stale session:

	if (!opinfo->conn) {
		up_read(&fp->f_ci->m_lock);
		goto out;
	}

	ft = &opinfo->sess->file_table;
	write_lock(&ft->lock);

  BUG: KASAN: slab-use-after-free in _raw_write_lock+0x74/0xd0
  Write of size 4 at addr ffff88810a970528 by task kworker/0:0/9
  Workqueue: ksmbd-io handle_ksmbd_work
  Call Trace:
   _raw_write_lock+0x74/0xd0
   ksmbd_close_fd_app_instance_id+0x183/0x410
   smb2_open+0x1346/0x4430
   handle_ksmbd_work+0x2bb/0x7b0

Reached from an authenticated session against a share with the default
durable-handle and oplock configuration: two sessions open the same file
with a durable-v2 handle and an RH lease under distinct AppInstanceIds,
both log off, one reconnects with DH2C, and a later durable-v2 create
carrying the other AppInstanceId walks into the freed session.

Constrain the loop to the oplock owned by the file being reopened.

Fixes: f363a0fb134a ("ksmbd: fix app-instance durable supersede session UAF")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/smb/server/vfs_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index d95c405eab11..1e9d13344825 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -1720,7 +1720,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	down_write(&ci->m_lock);
 	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry,
 				lockdep_is_held(&ci->m_lock)) {
-		if (op->conn)
+		if (op->conn || op->o_fp != fp)
 			continue;
 		op->conn = ksmbd_conn_get(fp->conn);
 		op->sess = work->sess;
-- 
2.43.0

