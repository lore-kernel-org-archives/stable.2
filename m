Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6D2931F5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549893; cv=none; b=VQLy0uRQhOcClPDChT4jbwaUzZWbrB4eFGIPaJ/5o/eZThh5cJ3NPjioFPZjEW2FS9Cy9eI5I3iNI+opPcy63jFbYve8BF1Ufpf5RJ4bfMFDn4P/hOGCuZmMyuxlkK3QCcPNUOXXB7TvPOFsKt7/7KIt/a/XLeQcNS9aw+LBQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549893; c=relaxed/simple;
	bh=Y4izI4SIKVJdT//rjyCPIeqSN4dAIPQS/S4WK6UuD+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WATSqQvWWog96SNo1WUIKNA43X4UYIMsF3hYxGiatQlOdlyPumGHvsENTrfrHPH5Emf/RbHELD3fpaJ0E3eb5Wr/keREuDiWGrbgfr5LKPemuG5h3CNum4g26cAne19G1Nee0l2Zz5NZlk7Z11VyWfartnFFwea5D5FWM2zWKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnZ7MqRm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnZ7MqRm"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso2909461e87.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 22:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787549889; x=1788154689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e/b5sYZ37csabtcxzslReAFhNS21la4FAzycwFfh0FA=;
        b=CnZ7MqRmin6hnxnUuEhwN/jPYF+wbKqI189JLHZPionSZddZ6rjeWPocqENDM5KsHZ
         MIrdX97dtmoJIBjfAS80TGoeDDjrnTxZAi2XBhIrqrUUfYkPDn4I3yNXn0pVwj2P/r9E
         0Du79D6ZrWBtF/BsvZUj/AZ9fUPGlzx5gR9e/3aotIfC55rfKMJXnIt23A+XBzJfwdPV
         8yWuQjTQ6gQIVIQkqky1NuglPKPODcqcKjePgVWxGSThXemO+WgVg8SGllOQ9/Z/eH+9
         863+BW7m8PvUBEXBqf37jvjfRrV/ZPkPqNJh4vplhC92hO3W8/FLPA98xEYtpbCWcCOr
         p+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787549889; x=1788154689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e/b5sYZ37csabtcxzslReAFhNS21la4FAzycwFfh0FA=;
        b=rpZd8n/rSHLfnv7/8EItgXUKt8XydYtaTnyk+fo/WmEvFS6Lx/OIPgv3d0BjLeTSjM
         oYdmXkoGcWa4/ZBeMBBfjjiLUH2TVjZaNEHmYrn22NTs9Ri7bPdr+TzpFn+A7ZCDikxs
         bGl3ucfAnm8RQDVTRmN9pJIgdyL7dengY0DD9npkANEBd3sGMOt06CjVvEx5jB8+9GOI
         dFginAAxlPaIk29VH6t13kib3GXyoYUTp0DCkEm0NPgS3lx93ogwZjIBLn0VBbArySAj
         Ht92IMqY1IIlphYA79P4YsK1FYxt21BzBffuSSCT0oJFUfGFA8HC+/tFXSFPdDnbHRVh
         df5g==
X-Gm-Message-State: AFuF++nxwxy/N/zLC9XiU8GxpXrnAtna1Wu6YQNYgCug4ktGnIgyYfrx
	rO372/0lg/3IAQS6lNE6RLHaQb2ienx8w9LZUJ3XBP7v42Pl0Pf5FlheENErjqiY0afP/g==
X-Gm-Gg: AR+sD139JBTOmw1zEJEokwP/Fj7xHOkxd2V/MkNPkptvJrmQZMRnfdMb/MQAyh1AUcV
	fl26EIawERzdEmFsLGqAPzRM4v+zfUlwpUhBStGpufVWqSmystHe3OWXwGwadcZ4h6+PZeT+1SU
	sN0f/e0EL4GwP9h2MPTeBNjpAXJIBSvC9XzqsU1AkFFw75nHwFMImO86sH85Ff5slNBYs90c8bY
	FTI27HDtFZGI5Jtw0Nj7u4VIBmBGJL/q1gS/6tswieYxFJc1i8bQfvMAh9tSfSfLjIAeLcHekLP
	clN2u6QInACuE+Z1aeWjz+nRQk/E58NPIXk3PcA9UXk0botEirPiNVnr6D42+OIJtfWXbUG4K76
	yeHCyjGz7lc9B8l4d4aOeQj8o/lUf4e0JZAetDb1Ykx7g1T8vRnDt1zOwE7pgKkS782QeOv3ObL
	vWc0E0baRP9PzJNkJyrMfY+VvyxAXitmABMObRIFXzPI7quwRUDHaqJe1eHmNhdpnn9dn3ZEmLf
	thkIBtBmPTwS8VDtgDxHttTDcKM
X-Received: by 2002:a05:6512:8346:b0:5b0:11b4:fd7f with SMTP id 2adb3069b0e04-5b484224cf8mr5595607e87.10.1787549889265;
        Sun, 23 Aug 2026 22:38:09 -0700 (PDT)
Received: from localhost.localdomain ([5.18.158.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda25c9sm1459807e87.18.2026.08.23.22.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:38:08 -0700 (PDT)
From: Shishkin Aleksey <demonaxsh@gmail.com>
To: stable@vger.kernel.org
Cc: demonaxsh@gmail.com
Subject: [PATCH 6.12.y] netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()
Date: Mon, 24 Aug 2026 08:38:08 +0300
Message-ID: <20260824053808.972251-1-demonaxsh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit dbe556972100fabb8e5a1b3d2163831ff07b1e8e ]

netfs_unlock_abandoned_read_pages(rreq) accesses the index of the folios it
is wanting to unlock and compares that to rreq->no_unlock_folio so that it
doesn't unlock a folio being read for netfs_perform_write() or
netfs_write_begin().

However, given that netfs_unlock_abandoned_read_pages() is called _after_
NETFS_RREQ_IN_PROGRESS is cleared, the one folio that it's not allowed to
dereference is the one specified by ->no_unlock_folio as ownership
immediately reverts to the caller.

Fix this by storing the folio pointer instead and using that rather than
the index.  Also fix netfs_unlock_read_folio() where the same applies.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-20-dhowells@redhat.com
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Shishkin Aleksey <demonaxsh@gmail.com>
---
 fs/netfs/buffered_read.c | 4 ++--
 fs/netfs/read_collect.c  | 2 +-
 fs/netfs/read_retry.c    | 2 +-
 include/linux/netfs.h    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 5f3073ad4208..d99284e35126 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -734,7 +734,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 		ret = PTR_ERR(rreq);
 		goto error;
 	}
-	rreq->no_unlock_folio	= folio->index;
+	rreq->no_unlock_folio	= folio;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 
 	ret = netfs_begin_cache_read(rreq, ctx);
@@ -800,7 +800,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 		goto error;
 	}
 
-	rreq->no_unlock_folio = folio->index;
+	rreq->no_unlock_folio = folio;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 	ret = netfs_begin_cache_read(rreq, ctx);
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 2955dc31d3c7..782d7b730196 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -73,7 +73,7 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 	}
 
 	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-		if (folio->index == rreq->no_unlock_folio &&
+		if (folio == rreq->no_unlock_folio &&
 		    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
 			_debug("no unlock");
 		} else {
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 42abf574e678..a5487b00ec56 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -249,7 +249,7 @@ void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq)
 			struct folio *folio = folioq_folio(p, slot);
 
 			if (folio && !folioq_is_marked2(p, slot)) {
-				if (folio->index == rreq->no_unlock_folio &&
+				if (folio == rreq->no_unlock_folio &&
 				    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO,
 					     &rreq->flags)) {
 					_debug("no unlock");
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 6bd0dbfe8f0c..6f2c504dae82 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -266,7 +266,7 @@ struct netfs_io_request {
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
-	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
+	const struct folio	*no_unlock_folio; /* Don't unlock this folio after read */
 	size_t			prev_donated;	/* Fallback for subreq->prev_donated */
 	refcount_t		ref;
 	unsigned long		flags;
-- 
2.47.3

