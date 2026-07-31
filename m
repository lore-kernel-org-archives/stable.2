Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285242EED5
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518007; cv=none; b=d1vct7fmqeWayQbvLBjAdpUn+i/A7bki/PSvfNEYfv5skuexbW+GtFNQrWeFpoegDKufB3wqfgFkeCZQaqvfKtsPnBFKT/mabBEAk0QWnUBtaj01yZofrnqGnUraV2MQ/MVaL/C4ksIMzLRWYSreDTXYtYGDVq0YWXzS0jMTr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518007; c=relaxed/simple;
	bh=52nLRTTzZW53P+KhFXoiebuaaIZj5U5rrocnkEh0ovg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5dRrRYPl4xI+CiQDGeaz1nSWBBXy8RRfy+Uodk82QZa5YZ/2XH4UImHn4fg+XC+Wwc4uLPPXYsiU/+4voWc+6XVFBJRWrA7fCMyO3ekqVk8ZrQcUN3TmtLdbmD3w3y+5jOXA3wNVVxWdKmVPkv47ZEQ7CyrwKU31G6KHRHGlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GubiAkWx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pYOqkQAe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GubiAkWx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pYOqkQAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785518004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDt42OCPMiF5ACU9K3Vyp5738A0ZbescXylCCtt+Clc=;
	b=GubiAkWxqWQaSGGTqUd97Vg5OvT1aD2q5DPwd0i/+Spibu2QhMM8yTpwh+XrSo6S+azOrD
	E1e4TY3Z3qD9iTXg6LQkhOstZfJbm2lvXllVV/FdI9kM7rhYOo4dDnzhDwzvDZNVb0gM//
	QjZCYLSevHvXlRIhG2RC0jzZgPjnjEc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-woSkEeHPNQSE8YqBj3QJzQ-1; Fri, 31 Jul 2026 13:13:23 -0400
X-MC-Unique: woSkEeHPNQSE8YqBj3QJzQ-1
X-Mimecast-MFC-AGG-ID: woSkEeHPNQSE8YqBj3QJzQ_1785518002
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5283df62d68so11260681cf.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785518002; x=1786122802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lDt42OCPMiF5ACU9K3Vyp5738A0ZbescXylCCtt+Clc=;
        b=pYOqkQAefTfwRXkE5ovQ+c/yn+2V3x5izzQCUu9DyNPcf/0vKGdbYZlsML1jR+HwKp
         r8aEFlyW/wFVJphcd6P2d6RcPnzMLpjHBGHUNuKR3JbjBlyOlscu2pIe1WyyR/0xQHa9
         D4V1azlwqOV2v3k2kTO4vqc/8px136Y/47JiLjz4R3EvXXAAS2P5g2BgmV463SdWMEab
         JC65anIJNOraGrViivXmVV9wWHK+3oCzXXAngeeOLWpvB+ZU93LVBiJSXfaIErZFDBOE
         zJj5Z7qTUUXb1kqehiCoHyrrW38Wh3zZrvkzMaioS3R2QBPMobwsdZIRQA2jz9sS2CLv
         Z9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518002; x=1786122802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lDt42OCPMiF5ACU9K3Vyp5738A0ZbescXylCCtt+Clc=;
        b=pCO+HRgB19cVMtXbI9lFLLvjhIfhY5APMiAZ5YPduabAL6EPmtuxXdLpnbwzNR4nHV
         m4oyOrOQNABQ2JbtqFcMLfxBQN6Yo+NVyLPwk8CvWHUs7Btv40rJgMiQHhj1Mi/U1oq8
         7q8diakX02CZ0Dx+hjO6I1hGuDQpH816uue6mhKsWqKzxm3AwXYpDrJ9vKxZ+alWhUgZ
         9oMZxufjsARMums5yOTOzpRmoE5zG3Hofjc+IMyjAdrazDym0YbYZerdRr/S5uRnpVKV
         IAs2ds0SBkr9XSdkKXEccvdXdUKWU920opADxOtDC3o2GL1CFvvxCFUeRtVGs23UzGbx
         AF3g==
X-Gm-Message-State: AOJu0YxPpxKYZFqZpqzT517hdTWncpzlDkCMNniNSmZXB1tfr1F1s4S/
	D03K/w63VhB/mJti4Bg4TEfzY735F8FhVg4SGNQpOedOJtNJdqoTgoaB9SplA3WQQptqGQxokTe
	35LryTWqGB1OhMfw5Qrn1it6e99+9+fv1n/CxttGK0M0q4awHBQeOJA0XMA==
X-Gm-Gg: AR+sD12Av+kbM79sMzahsUX8RBFWn7Z6dH1kx4zNPGV8swew7z6ip4CBTZaR9XHdcGQ
	5fLTWmTcnr9MBwXsMwH9MX+gm6ZkkdW1S/nko9vO7aoAiw9M4rBZLPIYvDlFG90XfXNIYcJ2NeO
	1LeRZHVk4kw9uMQcxYiN1kCBmAA+m5EFd2lfsMfKWmb6x2VuIfKis/hnTeTim1t386hlbo+ha+r
	KajG7sZ+ekx7/cUUlxsPYkA07GEiCIs0ZQij02h7S9XBVMjzJcrdeJRe8o9XIWa/7wzGnTwoR+V
	fBbX6SqYqzld87zfJfysdr52oTzM1yxYK69EPcCECoEKp2d+vs1De0rG5Jf1BTgC2wflFn0BRDV
	+v94yi94/SWP5MxC30pjVWZFJX8laEyyCnlYv2kUBF3qdrueepefXzwfHZ5WQ
X-Received: by 2002:a05:622a:53c3:b0:528:3ae6:14b1 with SMTP id d75a77b69052e-52b5684b9aemr16961291cf.43.1785518002337;
        Fri, 31 Jul 2026 10:13:22 -0700 (PDT)
X-Received: by 2002:a05:622a:53c3:b0:528:3ae6:14b1 with SMTP id d75a77b69052e-52b5684b9aemr16960831cf.43.1785518001870;
        Fri, 31 Jul 2026 10:13:21 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434a250csm14676316d6.13.2026.07.31.10.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 10:13:13 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org,
	stfrench@microsoft.com,
	hehuiwen@kylinos.cn
Cc: stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v3 1/4] cifs: use cifs_invalidate_cache() in cifs_do_truncate() for O_TRUNC
Date: Fri, 31 Jul 2026 12:12:28 -0500
Message-ID: <20260731171231.686427-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731171231.686427-1-sorenson@redhat.com>
References: <20260731171231.686427-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cifs_do_truncate() is invoked from cifs_open() without i_rwsem, so it
cannot use cifs_resize_file_locked() to perform a proper fscache cookie
resize.  Instead, add cifs_invalidate_cache() after cifs_setsize().

cifs_invalidate_cache() calls fscache_invalidate(), which works without
holding i_rwsem: it unconditionally increments inval_counter and sets
FSCACHE_COOKIE_NO_DATA_TO_READ, ensuring that stale cached data is not
served once the cookie is later activated by fscache_use_cookie().
Truncation to zero leaves no valid cached data, making invalidation the
correct semantic here.

Fixes: fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()")
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
---
 fs/smb/client/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index ac89c1ba56b1..389083f9ce00 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1016,6 +1016,7 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
 		if (!rc) {
 			netfs_resize_file(&cinode->netfs, 0, true);
 			cifs_setsize(inode, 0);
+			cifs_invalidate_cache(inode, 0);
 		}
 	}
 	if (cfile)
-- 
2.55.0

