Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88C37E5FB
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549541; cv=none; b=MxeAPqi6SX0gTP0PBx76sLKg8+VcQxrm9IuR61AYyz8WEGSLNboyc56WY9K+fLBZhYlKKOYOsfZ73DwuYC6lPJ97IVoKfHkrGQfzB75btm+lCcEaTcQ8+tcz64lpjEwWmngNqVRkNM+N9n8DkLxChV5n2G7DJz4dsJjTAoTECiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549541; c=relaxed/simple;
	bh=FfpE9gx47XFL6L6zt4Nf/2hMeTSsjdMQpREFCg3J8f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5KTc93ChBFAh3otZ0Ds1Qok0IQN2WiCvdm9ljJyDVvAsg8helUaA9wp4phvikArC8o+/IKZPSesSmHNFDD+Z9QRBiaNBhhOxJNWZHV3uLTkwFW27kNMgHMN/llD4pElgYRXsWKGpNRACK4IU13PK8el0XLaI7aFgYQdc9O0Qcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIAovMGo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIAovMGo"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so5613825a12.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787549517; x=1788154317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Hp14Tq1+SWr8nxWQEmqPzaXAJ69nm67a0CzINkY8/8=;
        b=nIAovMGokpyA21Bq79aexnoxsGR0WyYyARpeyOmoBs9e3t1Bi+GXLlPVPyy0ZapYYc
         5nQLLhRSuvZRMGzz5Oar+J3ibizlIlD125pbsNzosPpkJDb5fHUEEXoNYPDx9GHq5mpf
         jpsbiIbGRj82EtGJnBtHGgRepKguKLC96PedaU64vwdVHZ2SY+28/TuSmb84skP+p449
         gxP1CE9motvjPo3sfj6TtGYiAmD+63+96T82BV9R90zWKqQpR4z2AoinihidhfGq+w4h
         sQCygVz31srPoKuJiYPZUuITznGBbLlCtX0lEKky7s0U99Nmy7UB0njCLs6UgG7Xec3q
         G1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787549517; x=1788154317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Hp14Tq1+SWr8nxWQEmqPzaXAJ69nm67a0CzINkY8/8=;
        b=sREpPkIQIB2NK7em0Ms1Yt3jZF0kN8x6jo6cMsGC+wA1gVyn69ZzjFMp1aWMVAFMKd
         RF5YxqoBrDAYCzYNcltkYOArQDeJhXgB9BG0wYwx9JFOZDQBHsvyLidG32ipgYtAe2Dl
         PDxuXlVFKL7VYyNf2vLekJGuho2KHKCNYidjZn9xFYZQ3+biAxnFpfol2b8H4MupY+W8
         mm6d35lsA8xL/TuAaXzIEjMeOrepAXNP23IsRgZh9H1Op1XESwZigulwN5+keYc8RboY
         qeXXMKx5YiG6J1cl6V8vb273qlHcWFAu+CLbKiHb3c+uLyqUUX0qstfM+auRPmbBYgBj
         gkEw==
X-Gm-Message-State: AFuF++mzlRnWEXSdhRmUUuxc/6qHWWLWY/hM3cK9zBE3xnGyr1zMHcGO
	JMaLBtd03IGASscaq19tm0yzFst1xCTVUfTex0SbqL/y8B70sChN6qHXnOM9rmKbRNmpjA==
X-Gm-Gg: AR+sD13LsO27Svgp7/CQYQpGDYn+CFSBK5N0oXIJHDm1LO1FKe9waSJO0lBnM+TkOTQ
	19J41KdNGFfniT2EVyBLOW3xCZuGrKi91Rn1uwZPJvSTDCH3q3Gm/xnAoTDvc68TyzoaRNgZYgV
	xx5pRnt+/NSAQv3dAnVAAS2/EP/uAQb+Fb2LLFM6Lzxl9/hX2GBQ02S+SmN8ZwGKeAc9RV4B7gX
	FabzC20SKDWre7lh9mVL77lDQzzlv7NiFiGtzb2X7ECLaqrn2eggzWzMeWIoApczDi0+WnNOibs
	LHfIaD9OZgaymU0GTDNhRV+CjVXsUy0zhBExtH+KEBJ7zGAUuMqMkHhR56+QeLgxGVMgtIFO+s9
	f23o6x/AhiTF7YQKfhGCxmxf2zYwOSLJDtqgDn7uS4H1mCsB4wfs4UqbOEAFPC2rSguBXig8elK
	KKuLozGkGF3T41xr7+Zz+x0TySUqaB4xAKuLWASs8m5YHk55Jizl/ucnKvTqjqtO7NGdQk+DirC
	HaLb2CjpVXj2Cz4DRdqXPWeV/uKrw==
X-Received: by 2002:a05:6402:a0cd:b0:6a1:babc:5b9e with SMTP id 4fb4d7f45d1cf-6a582b0b815mr16460327a12.5.1787549517339;
        Sun, 23 Aug 2026 22:31:57 -0700 (PDT)
Received: from localhost.localdomain ([45.145.56.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5b93f3acdsm130428a12.19.2026.08.23.22.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:31:56 -0700 (PDT)
From: Shishkin Aleksey <demonaxsh@gmail.com>
To: stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	demonaxsh@gmail.com
Subject: [PATCH 6.12.y] netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()
Date: Mon, 24 Aug 2026 08:31:52 +0300
Message-ID: <20260824053152.966009-1-demonaxsh@gmail.com>
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

