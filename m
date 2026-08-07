Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02052272E6D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070530; cv=none; b=dpAdxaJAlQ4NTYQgPMlkZqBgRsle1UzwFantZ+dj9Afinc28klan2Qj2E4o06+OuNVd+hlP1kEeADAOhrAqemG3GcNhpeXbIyGNDmd91ROD2ejLtodcONcNdaSSLxd95KL2yeo1FcSQeOzl5D6TgYfyFppMcKWFfnS8HqMr0Hh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070530; c=relaxed/simple;
	bh=uRqs+fCNOX42TFHl6VqCCHziTcP9wg4pqWDHQ6U1648=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry9ehOq2d/cPOESUwR9uUMfR2aVQ37rSFjf35A+TbJpLUq9MbCGe4JMoYAKNJMlzXNumHls6ZDko7ky1RgPR2DGf+Um21f2J2qM59kpHK79WGARFxkxv7n1SU5N+hEC3/aMVCrAq3nCuQ50xUQX38mmsvkWMRwOgFOqddB82zDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dc0WGuit; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CX3tM9c6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc0WGuit";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX3tM9c6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786070528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vwq7i/Gf17j5EKYufvi5JRhEhyqFtE6xGkW/b2fLbSc=;
	b=dc0WGuitVw3d/Rf2qjK2Gcjyyo+owOTCWzpbY6SNrexYfpkr7qpJHER+AtPuPRSq2r1YoG
	BktXbxRDiBV8AzVjWm5R96jIAt23hl4KnDLtZuSxdCwLrlnrGtC7gn3jD6wcYfAiZpv/l0
	1ww7ePROINDk8VC9dFoq20F0MZYLccM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-A4H3y4qzNaeM1IwTw41DQA-1; Thu, 06 Aug 2026 22:42:07 -0400
X-MC-Unique: A4H3y4qzNaeM1IwTw41DQA-1
X-Mimecast-MFC-AGG-ID: A4H3y4qzNaeM1IwTw41DQA_1786070526
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9fdc2870fso1587561a34.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 19:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786070526; x=1786675326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vwq7i/Gf17j5EKYufvi5JRhEhyqFtE6xGkW/b2fLbSc=;
        b=CX3tM9c6r5QYV75JdwVWVe7j7FGmd1BSe43INjXASgjZIRzcfRcPkbtcb77UVrNYoB
         VgitxKIKTSGGQNGsfNy3jIFK1eZ1SI9+N+EDAmmYt9sdcWkrfXyYroN5cPnC7W/+pAjL
         sSqAV9xI2l9DMZBhhZyyposqTBkeVjakOBgTbjotVk3BHC2jAXZHZd5eDPq89OtxjgQN
         GMiH18vufdrzIefAlY4O+fhtGsjMvu8NYdwPOa6zu1t+QKap7jbt7GYD7rkvwxrMNgnL
         GXskZt8AkXvF/Iye8wAdO6zpeoNLug/qXVmMkt0cuXNnPMx9Y3I7t3hmi4Pr3OpIRKLm
         9GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070526; x=1786675326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vwq7i/Gf17j5EKYufvi5JRhEhyqFtE6xGkW/b2fLbSc=;
        b=WbEaPVcPrXgY+aAGKPEz3q7kpXJb3Ll8+baqCb0plkH24vkLW/v/GHpCtDksNWqjSp
         RKyiI80/Fgrx11+3ql1pZ/M/Vpt6w5sDdWm14SSpLvIMHT/2YkXhXgaD8tmFtI9qB/ev
         GDwabON7x6DrU8YLuYB9gVANRe6OXoG6CmPJvEGIFTJphhSXAjrTYL9iKd4S+3VDcWw0
         EJNBOcUY2yNplumV0tU0b+K62qsTwrwYw2gj0SHDJABlZopYiNJ+RovSL5ERKW114dwh
         Bd3t14tc24qAwBQc0Jk6IFz8UWS9iCFjqnVSDj84vDfeq24ZP4Q4yb4czmXEx5kSWv5Q
         J+Xw==
X-Gm-Message-State: AOJu0Yy8iV8CSnOYI83lujdUi48k9oGhrnuJVKusgf9nUwbxPzaYsUCK
	ojPChc9SK4I89Oaus1WCoQxXMpfoiBV25mdJ5+sDtaLqHZjzTXMhb9skEnwbffT0aa4+OiOmb/0
	yJ/TOTbGXqKaqp2vBaT6Nc0l7L/CmM82j5vhQSijo3ZNONt7WrmONiua/sg==
X-Gm-Gg: AR+sD12ntG109Ao9GaNNir84C4rYqdhW/kK0DImh2InaWtKC51xa3+43KHHCzJETTo5
	JZ+F4X9IOO+482JOk/UHfS9gUmchlMXHNuIbquLjav1Xy+xwDi41Srx8zK2sUqfjZ/h3as5iKll
	cVfu5/0Nsh/G1XjUhiBPYhofCA+NHx+PyhK72Xk6YCElYL8++yWVQzogfAPSKyqJ32dxPRFDJku
	0fRihYbgdcXXxrbEe6XHOIqF+JZJW17GDmu6gqwc/G4GgTVZCEn1Gct9l2A3W81Uinxr8pfKHJ2
	zMN8fxZii3NUA4bJNid8wqogn2g4UvrF0qSVzIJX0a6wC28jWkTS3pSDSusgBjLmGStAlUfHrzc
	Mq4+lyy+3QMp+SlaAi+Bd7wjeoJAzPvEZIXT5g6wJ89L2/HKzI4HvoK1ys/8T3nDn+w==
X-Received: by 2002:a05:6830:2aab:b0:7e6:e8cd:bb7e with SMTP id 46e09a7af769-7f1e5c9972dmr11886026a34.4.1786070526215;
        Thu, 06 Aug 2026 19:42:06 -0700 (PDT)
X-Received: by 2002:a05:6830:2aab:b0:7e6:e8cd:bb7e with SMTP id 46e09a7af769-7f1e5c9972dmr11886007a34.4.1786070525796;
        Thu, 06 Aug 2026 19:42:05 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b563887sm356182a34.3.2026.08.06.19.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 19:42:02 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com,
	pc@manguebit.org
Cc: stable@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v2 2/3] cifs: don't update i_size in cifs_do_truncate() without a cached handle
Date: Thu,  6 Aug 2026 21:41:57 -0500
Message-ID: <20260807024158.3707995-3-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807024158.3707995-1-sorenson@redhat.com>
References: <20260807024158.3707995-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cifs_do_truncate() is called from cifs_open() for an O_TRUNC open
and find_writable_file() returns NULL (no cached writable handle),
cifs_file_flush() returns 0 without sending a server set_file_size
request.  The outer "if (!rc)" block then falls through unconditionally
to cifs_setsize(), setting the local inode size to 0 even though the
server has not yet been told to truncate the file.

If the subsequent network open in cifs_open() fails (e.g.
STATUS_ACCESS_DENIED from cifs_nt_open()), the caller receives an error
but the local inode remains at size 0 while the server file is still at
its original size.

When cfile is NULL, the O_TRUNC flag in the subsequent cifs_open()
request tells the server to truncate; i_size is updated from the open
response.  Move the size update inside the "if (cfile)" arm so that it
only runs when the server has been explicitly told to truncate, and call
cifs_invalidate_cache() in the no-handle case to flush stale pages
before the open is sent.

Fixes: 110fee6b9bb5 ("smb: client: fix missing timestamp updates with O_TRUNC")
Cc: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/file.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index ac89c1ba56b1..92af1782bd73 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1012,10 +1012,19 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
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
+			}
+		} else {
+			/*
+			 * No cached handle; the server truncates as part of the
+			 * O_TRUNC open request that follows.  Invalidate stale
+			 * pages now so they are not written back after the
+			 * truncation; i_size is updated from the server's open
+			 * response.
+			 */
+			cifs_invalidate_cache(inode, 0);
 		}
 	}
 	if (cfile)
-- 
2.55.0

