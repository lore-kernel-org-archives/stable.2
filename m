Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CE3B6377
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337681; cv=none; b=lZqaovaUgoCfNc/uBw8q0bG4SXQr8nl/k3NfuOloh24lSPG2BV0xy2rV72n1gJROfIqvn88ZnJT8PdFJoCQUMBwTQHZEs3LVM0Bt0697+zT73RcMn6oYUYDAAMaPO7en/YyHiNMFfntLIcuKjWCIZ5PrTKWCMbouK06iXsPCNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337681; c=relaxed/simple;
	bh=VEtB8Ah6ZUnQoHBmv9KYP1wCthpDTt3Ro7V4Xp57/1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwDUmpMggW272dD3NxasjRLw455jx6JCOy6jzFwvjnyYKk5yVDHKcxKNI5EF+abS342A8InOGHP9HBWfafdboY3YH/ApWjSRQHAsyS0FiKPGIxcIxYc35Q0s2SwjgoMs8A8RkJDsWC/5lxMz83aLrgQ0w7d82Gm+qCqxXYJVGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIAlp6P1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmLwbm5V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIAlp6P1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmLwbm5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787337677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heEDdHkafbRutO9HRgBGIvgZBLa13kRZzKt4emv50QY=;
	b=SIAlp6P1oQ8QG/JW0ZfWTDAw2NdLbZBZ3Rz/WJCsfkWjvtUm3qdK6oemtlSxCNWvPR25TY
	hil1IRQzLe99uLDIRgI+kApwpma8nGWFUXk3cKXYS1QL+wnMhx0AiBAPugh6+VyWPA4+Y0
	RFHGN1TZ5EkqJZ1r9JeumGJ1aiAkbTE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-pnSjSszjN2iNaEtYlaeJiw-1; Fri, 21 Aug 2026 14:41:15 -0400
X-MC-Unique: pnSjSszjN2iNaEtYlaeJiw-1
X-Mimecast-MFC-AGG-ID: pnSjSszjN2iNaEtYlaeJiw_1787337675
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836cda1b76bso60170387b3.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787337675; x=1787942475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=heEDdHkafbRutO9HRgBGIvgZBLa13kRZzKt4emv50QY=;
        b=KmLwbm5V49PGevnzsXGH23G3hlkCq99D2Tn9a/OXi2m8EySMnwwNgdZf1zr5p3hR0P
         QHowBpj3wYxK5holEaF5ygI9zFGKyAikFDyMrXncwPqy6joT2kBLDJkBhbGSPqn10OwD
         SMAFpy8XJwGk1vleGoF7UkNb0U8UdUvrz+MbbWrQX5J46nBrCiRneC93cmhr4z8WznX1
         OkoBo9v2Gy1fzn4unnj2NNAP7bLySt3S43cO8WHFZXFLA6NwsWh83YPZ/JyHE3wu5hxa
         9gLUNK4iQz4sTaSklSDjC1xSAeNXbVaSHQ8oHAqjW+EifiznjLXgcMvnU/vmiDZc/yn7
         Qong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787337675; x=1787942475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=heEDdHkafbRutO9HRgBGIvgZBLa13kRZzKt4emv50QY=;
        b=mYZcmR/vdD1w3azOLTjalq4Xodps4v0Ty58kwjP0LfAZBtLtTeaIgtOmcHm/BtSw7W
         zLxpaPmVY1l4Capz6bBbgPgyT3xPgq25c8nGGSmBxpeu3v5hPn2GRlB+l73XOFNDBwji
         EynM3P3mk6cJzYWGffdUrYWgpsBeTE35HuRfCrMyGrUENzjgiqzA9pe/qbJbIOC4wVZK
         g6w06+6u7/thJs7wpjeMAppWNaEHl0ZzVh0CyUeY6I2+jQ7JsmWTQfHKocqs5BkRjOqv
         fIm7+8ske2kyqMnbGatZ7g1UXfyfIr+eapVuheo9uW6ha6gOQFLGvV137y3UZDt0kPm9
         fd3g==
X-Forwarded-Encrypted: i=1; AHgh+RpaByAYT3PmLIBa55Qu/59NlkUupxh9HtjaEjs+8vkCIyOa4tGipqgy+waHP29WCj9Yy426A/o=@vger.kernel.org
X-Gm-Message-State: AFuF++lguvjbuE7g7VySY3Hn719pwxAMWnj8iYs7+0DrwhPJsuXi6M7o
	wQefHI/kOBdIoL54hwE9Gx/hCsQl0KOL8/X9WMVL1/SWRmeQIPRWMVhgiACEJ0j2SuuwTjnYI+L
	ooIX2fhONa5VZSxvSg6NRl80IbTd9sZD8/UKSAZL0VcESlGby09iNi9617w==
X-Gm-Gg: AR+sD12vpw8oYugDufKKotjq3iSw1quQootLgIDVMYPCNMdSGNjXeTN3jq+gSV4Petf
	jhnzuzHlVFMQYkEDn+0qRSYKdwbjACE2fTDRm3s4pXV8BTxEpJ0q9HxTQ+xkyrUF5f1v4pBxjnx
	4eZ3ixb9pWtXN76Hc7yGGAqKMBz5ceJ7YSHgbd/wA8IsAUhZP2oCmBk8oeRlXfbQyQPBM5Cn6la
	LCVnMRchXsWBYpbvS/FWCLn19ANAVuOFUjMeq/8BkB4TEtpoUbfZVDGwHcSvfCjT6QYOtn6VKp7
	GkfGr7SS0v8db73SechYGuuKRIYF+9WGaNXpnhFOjHIWatkd33Pp+tB7qOfU2gHsnHNbLDETmDq
	OU6KP2TcgzMAROiy8X5P5l+cqt89cirkHwGwg91OUW8BoWOEJgoRJysVT5oyotck4yg==
X-Received: by 2002:a05:690c:6004:b0:822:854d:4563 with SMTP id 00721157ae682-84c9682009cmr2516237b3.8.1787337674648;
        Fri, 21 Aug 2026 11:41:14 -0700 (PDT)
X-Received: by 2002:a05:690c:6004:b0:822:854d:4563 with SMTP id 00721157ae682-84c9682009cmr2516037b3.8.1787337674123;
        Fri, 21 Aug 2026 11:41:14 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cabd2861esm539707b3.37.2026.08.21.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 11:41:13 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v4 1/2] cifs: don't update i_size in cifs_do_truncate() without a cached handle
Date: Fri, 21 Aug 2026 13:41:08 -0500
Message-ID: <20260821184109.1834871-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821184109.1834871-1-sorenson@redhat.com>
References: <20260821184109.1834871-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If find_writable_file() returns NULL, cifs_file_flush() returns 0
without issuing set_file_size, and the outer if (!rc) block sets i_size
to 0 before the server is told to truncate.  If the subsequent
cifs_open() fails, the inode is stranded at size 0 while the server
file is unchanged.

Move netfs_resize_file() and cifs_setsize() inside the if (cfile) arm
so they only run after a successful set_file_size().  In the no-handle
else branch, call truncate_inode_pages() to evict stale pages before
the O_TRUNC open: cifs_invalidate_cache() is fscache-only and does not
touch the VFS page cache, so without it old pages persist and may be
served as stale data after a later file extension.

Fixes: 110fee6b9bb5 ("smb: client: fix missing timestamp updates with O_TRUNC")
Cc: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/file.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 389083f9ce00..05aeb9d94ffe 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1012,10 +1012,20 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
 			server = tcon->ses->server;
 			rc = server->ops->set_file_size(xid, tcon,
 							cfile, 0, false);
-		}
-		if (!rc) {
-			netfs_resize_file(&cinode->netfs, 0, true);
-			cifs_setsize(inode, 0);
+			if (!rc) {
+				netfs_resize_file(&cinode->netfs, 0, true);
+				cifs_setsize(inode, 0);
+				cifs_invalidate_cache(inode, 0);
+			}
+		} else {
+			/*
+			 * No cached handle; the server truncates as part of the
+			 * O_TRUNC open request that follows.  Evict stale pages
+			 * from the page cache now so they cannot be served as
+			 * stale data after the file is later extended; i_size is
+			 * updated from the server's open response.
+			 */
+			truncate_inode_pages(inode->i_mapping, 0);
 			cifs_invalidate_cache(inode, 0);
 		}
 	}
-- 
2.55.0

