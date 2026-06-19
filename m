Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA9363087
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870432; cv=none; b=qwJLtnY8G86vHkLdWePtfNLxcdz49UYgQ5nzfUH7T8j7kGSVy0MtTDwnm2XZ7neS/PYl6wT4DOblJYAC3CFAMh1ZZsnoQiF3RQkuecqpDh4EgEY5shbxvnpllZJEfj9D/YUz7T77p/3Tk0APVmafWecZszurYhZvFgHiGRlzMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870432; c=relaxed/simple;
	bh=Vg5wHxwQRmjxfOpg6Q/n/wEes06PZcgmmFj4ceOkcY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYhnhy6ej1FPDCVU5AcwFgTgYi77qxFaGOGJQ3jLejwcYTMPDAP2XwNGnsI9yikBixfAOdB0sAFOZm/+v9teAZ/yrDuQJ8ij5phw93vdgmBcA1CkSn5wRb2csEo6/CHDcMiE7BToAlGDlJ/yRK62GPwo5OSy5q0UUz7UOoL0sw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qR7vq6O3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR7vq6O3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso30183485e9.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781870429; x=1782475229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LdvO0oEjrFRjPZX/mnbADsvNWAvZHhQoS7JQpSrd/U=;
        b=qR7vq6O3Yi+Fy7A8PgU//m+ADU5YUhcyGWBsMWjZ+lIgtnCWS7x4GJ/34HCdvadG0L
         tOWloF/2JjD1X075XRxZ87zn093zWg9kuGX68xUdE+v8PBx+Gg2aRXgI6rkot0aVYnwg
         hLkt3qTpM/DGyM+51Grsg0RkUplKhfKgJoBSlkW+2CfsTBlddNeKirMc7NP664wQORSA
         2BR8T5XzNZALIn+xWvREC12hctz63A6NtoSY3gZbtqfLuEJ9uu45a2CvTQ5q3wk2YShj
         B4MuAQhDHV4xhss0UYeCO/tQtl7Itv+yghM+4roXJGpr4QqGgPLzfN4M7BXscGVtiaaf
         sB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870429; x=1782475229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LdvO0oEjrFRjPZX/mnbADsvNWAvZHhQoS7JQpSrd/U=;
        b=lLIixZuU34PCkLFRCEac1Hbmlz4OffmfCyiHLBQZmiEYe/rEv+eucTSiMejIrpMmD/
         SXQhrFr9RbufFEd6+frnYiPl8p5MUICQH9xEdR4FMrycuUTQjR01oNB5AW3qC/EtC6uy
         2PPIDXS4p1QoSnJaCOrs2yn0pOzEAgTVGISvQcmIMCsFaexWdAf5hXOHaDS/Ti3yh2Gy
         L1AjXOnb2j4qW5KTKhdzVonMcL6Q5gsa/J2PFMA+ap9UvxNSqrQxeA9D9nai3k8p0aZp
         S8ddWjOWXaDzEGqMnp0q3ics8Ye/OcU5aJUyaxMksdNKxXkQE/CH32dDEGklZLmL9pJC
         yZnA==
X-Forwarded-Encrypted: i=1; AFNElJ+eOUE2khjDVSEKJNptOBsYo9gbg0M9oOjhoAmWhQV0tvkXXTYY62lM4OmNna1isOnVhBKdlwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiNGN9R691HW+wgZf5zA9KWW7XQD5avAjtGsgZtHKgnIbTf9l
	tnTg50w+olhbHKpz+FmszTxCRSG/5weuUpdZYusw0voRiETYQK4A1Ys=
X-Gm-Gg: AfdE7clmvGCbwZXzSCeh3mRBrSNkZqbhJbFGpYJAvLKWPFuXpbMuPB3WCIUbulEf1FU
	yOOKO568SLfyxJyc0o3Cpw5QqcGc8IBYscYukbnAy0sO0dm9MjFZwCvCc4lujZvXHT0OWFwfkZQ
	zOkC/De36/2IG/Qux2vXxnkufe7EULFE7gROZfxiVQhurRCc1TqKaIwV0qBXqkpZiIYo1R69aYO
	F6NqZd/d6RhbN2Ees/FY8xeydIeVDTiSIjfwtah0SEZ+OCx9u/0rrA4ved0JZOYEopjm8LGTpI/
	l6BwIEIohzExeK89jOs6V2DczZ3YRePUb2YhCd9MEO60rEmP+vJtPunuQm4vjQPKGCpWvwsUegb
	6qH6UNG45InMPuY7nfVB+jxOFysgWGhCJwste5ljGHe+/RgUSBM7+QyIN+A==
X-Received: by 2002:a05:600c:2d89:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-49240a09f97mr23365025e9.8.1781870428832;
        Fri, 19 Jun 2026 05:00:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm102995695e9.0.2026.06.19.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:00:27 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH] fuse: check fi is not NULL before calling fuse_passthrough_release()
Date: Fri, 19 Jun 2026 12:00:26 +0000
Message-ID: <20260619120026.2630196-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

fuse_create_open() calls fuse_sync_release() with a NULL fuse_inode
when fuse_iget() fails. This propagates to fuse_prepare_release(),
which passes the NULL fi to fuse_inode_backing() via the
fuse_passthrough_release() call, resulting in a NULL pointer
dereference.

The existing comment in fuse_prepare_release() documents that the
inode can be NULL on the error path of fuse_create_open(), and the
fi->lock access below is already guarded with if (likely(fi)), but
the passthrough release path added by commit 4a90451bbc7f ("fuse:
implement open in passthrough mode") was not given the same
protection.

Add the missing NULL check for fi before calling
fuse_passthrough_release().

Found by syzkaller.

Fixes: 4a90451bbc7f ("fuse: implement open in passthrough mode")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c59452d60b8d..9b368eab159c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -313,7 +313,7 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = &ff->args->release_args;
 
-	if (fuse_file_passthrough(ff))
+	if (fi && fuse_file_passthrough(ff))
 		fuse_passthrough_release(ff, fuse_inode_backing(fi));
 
 	/* Inode is NULL on error path of fuse_create_open() */
-- 
2.47.3

