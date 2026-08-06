Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF25431A30
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059797; cv=none; b=BoiqQ9YDox3A6NXltehAR/FnDwpmvXcDkoD34VRnQMdlvwGT1Y4NgvKIMsKNoeJgjsKEhufHqyw1YKJAqtarhtb8zbupEf6BrPDApQd7PUTki3EWn29oAOkJQ46YJOZroCXpq4MK2pQdqYs6i1wo1FksEIn4+jsY9QqKy5XmnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059797; c=relaxed/simple;
	bh=V5iaY52poqbJzhu7Zsven0kiM3cFpSh4ek/1jKKpNcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbiQEOxivp+rFlHOAK7x6GGN9CJYAjOEoyO8bHZGv/n0Y6zpLqRFCYRgwYRmgqRSH4br8l2XiNAkJdyw4s1EcnEP0zivdRj8nCidcINVHYo4q0IeqykSAScRVG1LaAJQ+p4vGgK60KrIyuyrvwHnfEjo5jR6wrrO3ZZo0itbtTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wt2DPRru; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqAXfWrI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wt2DPRru";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqAXfWrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786059794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPAnVyLzB8u5cZd4HHGxxAzPmugX7mgogomHsS+ogH8=;
	b=Wt2DPRruIlEd9Nqc8gD0ksEjUHlW6QP+zLRTnrexNbqCpvzAcKZsw0Rl0qTXRE1egEdZ6X
	zQ9e7B+LzP8wCw3tVNCaRAI7BVSFR5CG/23YYmG6duE5UB0OcGbDk2wQVWzrK4w6iYGUoE
	mT19D4JoaBVHHD7BYo5nyES0dhweQAQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ylVvB3zbMASYWvHsf8fVFw-1; Thu, 06 Aug 2026 19:43:13 -0400
X-MC-Unique: ylVvB3zbMASYWvHsf8fVFw-1
X-Mimecast-MFC-AGG-ID: ylVvB3zbMASYWvHsf8fVFw_1786059793
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so476643785a.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786059793; x=1786664593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mPAnVyLzB8u5cZd4HHGxxAzPmugX7mgogomHsS+ogH8=;
        b=JqAXfWrI65MRAqOBXfy2jZnMvxKi1LMfw8cUIbaPjHV/VO8PGkzcwUfnoB+/A+9w1R
         XR6+nHGf/thnz/DhNsCxAq9FsmB03lmRvW0UNvHyCmEtN+/KazZ7h/s/vQTZtHr+gC6U
         Ag0fQDMihqtmGxmMSB6HsY4ZHKtvxF4rT0EPzhKgelxSLaHcNf5igF7AkYkib8+mNcRp
         RQZeutF0qa9j6UjdNd7Wf7NBuUpHBNlEKO1LRhe5B9aRgW4/PH669DFTVotIAUCQgnq/
         Og2uJLnZbhagPbjVOthbxLgrHbhRsjl3E3p3osWIjvIvT3IRG28wUFSO12oRkaNaej6P
         hSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059793; x=1786664593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mPAnVyLzB8u5cZd4HHGxxAzPmugX7mgogomHsS+ogH8=;
        b=lY9WoCoDQulDhKqR3Qy8bsAcHMmVQiabNa6gUuoPhWUMNb7e7H2+sb7nU5pMmGVtqA
         sSVDqB8zikAKV0vMaJ11rrYYGKcqex0z0UNLez3OLaMcBB7EutWzlN4diT91zjomrB/8
         XLetim5gZ0D1jlbJ1odrrfaPPP346pjDhugO7LCR72tzQV5sAGAcVnT+iRGc1Pdry6y0
         WqUpcHAlnz/s01S9I5Lac+rEpDHToS1Q1zHcCZB4IlDpfW1NGfP66AA7I/LDgJ3smSua
         9OzzeVV7P+Cci5K5aSP/L3eUGNN0lF26Z25IGSyVYCTudSKncUF8LuavLLeTyTVs7LKp
         2iHQ==
X-Gm-Message-State: AOJu0YxfWEw9ksdoaOQxCcJDOYttpHz+iTxtt/T9TjSFGRfz8zm0FV+r
	dZXYF95xPV+iHwkSAVGt/7ceRapfBDFQPKvQ+Mqj9JCQBCaRVululGkt68RIboGKXuY4DS60Wkl
	xM9meCihZ1Z7JvO8jp2nmBPq70JnyulbsjANylf6ttLMAV/kcER8x125UqA==
X-Gm-Gg: AR+sD10EbOYE+NokYAalYQA5kffVfbuAliLXRWSPoA4r+WF5lIUqqB4mTtvFne8nj7b
	rkf3wwbLJYUvQJV8FNk15oYW0Q4kq7teD8QivcCZhY4wHgt6KXRGUpMRN+3vcAAD7tuKKxKOMST
	mXdEDi7xV/nAvNqwb8vXKww2VP8W3QO0UEnjVDKrM3RIuy9Fpgbv7CJIeEteqtu/dP9qEW7VliR
	I541L0kLf6LmQIA1/nxag45QPsxE6GxfVGWcvmUuv+v2f8zvA0zjhq22CMQJtpNuvS2ygCVaydd
	ECryCQYK5tAX2p6+MgZhEusWblk0B1zIrB2tkhztWedMOVQkeoHBtuoLqIaNrwk3SCet0xfhAAh
	m6z0ROM39/kRVhLhTlBjPf9E+j7ao9FWsYYpodtS4r719CpYcDRbKZAiDjbDLUt4ZVQ==
X-Received: by 2002:a05:620a:1b99:b0:930:91e0:8dac with SMTP id af79cd13be357-936491f30b8mr2046196785a.41.1786059792991;
        Thu, 06 Aug 2026 16:43:12 -0700 (PDT)
X-Received: by 2002:a05:620a:1b99:b0:930:91e0:8dac with SMTP id af79cd13be357-936491f30b8mr2046192785a.41.1786059792515;
        Thu, 06 Aug 2026 16:43:12 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03f05bsm26891485a.2.2026.08.06.16.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:43:11 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com,
	pc@manguebit.org
Cc: stable@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 2/3] cifs: don't update i_size in cifs_do_truncate() without a cached handle
Date: Thu,  6 Aug 2026 18:43:05 -0500
Message-ID: <20260806234306.3662175-3-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806234306.3662175-1-sorenson@redhat.com>
References: <20260806234306.3662175-1-sorenson@redhat.com>
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
index 389083f9ce00..acabe2ae237e 100644
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
+				cifs_invalidate_cache(inode, 0);
+			}
+		} else {
+			/*
+			 * No cached handle; the server truncates as part of the
+			 * O_TRUNC open request that follows.  Invalidate stale
+			 * pages now so they are not written back after the
+			 * truncation; i_size is updated from the server's open
+			 * response.
+			 */
 			cifs_invalidate_cache(inode, 0);
 		}
 	}
-- 
2.55.0

