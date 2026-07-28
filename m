Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45690414A27
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273287; cv=none; b=cVpr9trog24DuCD2XX/gAES7o88Kddq34jFDS+TPMCJQ5DqLFGKclLN5NRDa/j0IPZ9+UlnNTdn0y5ZA9Ub+w6DaUu9KIeSsa+ZEt9H6Z28rTMUVo7goOijQHy+Hmol9iZqFNpZ6N1hqQt148mr/ARJnzXvoOf8zL9HsaXxog5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273287; c=relaxed/simple;
	bh=z4cF7TbY37uHVjWLLdrBJ2Lqn1H/bH20qNEEbmWIRx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSKHU0c8YV8t4u14djwX6sF7lILgWx4Enb53/CMLpPB/rwgAOBs71/hFai6MtZuod8StuzKmHh5lsVyDWnSH3lMhowiyAb4qAdfPWhvxNzNwmhkBEY0XuhmfCRVQ0yEEpHkRdEPlXJ/ZZey8PEEFLtc5vMXaGvCFKTJO2NK+NF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H73APM8J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzUbBG9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H73APM8J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzUbBG9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785273285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y8X7sWmDRbdgNDLWYrb/Qp1hUasoR1gEA4uFTODfQ0=;
	b=H73APM8JDv62iZENZ0OmfHHlcdO9hx0hgE3m0usP7CZu9AxZGFuOCrBLeBkK6VtgBCBsUl
	dVASxJvPC0fYMFj0m7HRGG0rg6eqFcTRzyIKEYEXSs8OixWUviAXyg00vbgEUaaRuRFpsy
	z5DkOZROCh9xYkj+oprR/HHc4AX6gPg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-kC3LkWuIO3ijlR16L3AhTg-1; Tue, 28 Jul 2026 17:14:44 -0400
X-MC-Unique: kC3LkWuIO3ijlR16L3AhTg-1
X-Mimecast-MFC-AGG-ID: kC3LkWuIO3ijlR16L3AhTg_1785273283
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-49001defc4dso259343b6e.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785273283; x=1785878083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/y8X7sWmDRbdgNDLWYrb/Qp1hUasoR1gEA4uFTODfQ0=;
        b=VzUbBG9u7swYZEGdWs2FsOkjAmeBWMyiO8ItwHbrvY0alPQP8qgZkkVkYhlUl8jFCz
         UCSHlDHe1ln4EfGNX+zWJQ8ffIuB/7vnP4F6sqmEwz0GUY38UkD/M9iG4OElbS8Li0iy
         eQ5AShTuaE7teyX8FlR/s0kgRdQnfu6qFZvrvW7VakjpL8Ki7gxRBQ2/0rRtHvznXW/p
         VrXJK6QdBNhF+QMimVCo2NW0nTBUEDVfaX9iKE/HcwC2+sxmMQAm7tcjhB+CeYr0VQDG
         EIIo/MLq4HYJOXPbAONKU9uhoEEaJZwidxXJWUAVNgt+Ws+N0eRIAle8aAcehIFacryN
         Hzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273283; x=1785878083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/y8X7sWmDRbdgNDLWYrb/Qp1hUasoR1gEA4uFTODfQ0=;
        b=IzT/+PFKLlQxJP2nKQkL82HLpFsMCdNtdY1Ss+/odxDc+s4R+ns7l08EipncgTm87c
         e8fhWoR8lZlmYshkDwHwRtl+Ikl1B+kA5qlmVtu1e0a58zJsLFpDJ1kx6ZIV3+p/INJb
         Hf6SFHQZFTVPSs4reqodojAVUK5xXFqIkLm2k0fo8YIzrb6fVBI301lxa3MG2ghsgtgZ
         bIA6sDoOgGpQ/6NaDMPrKfNhpgXkSVpl8PpJDW1XW3c/e0PDO2RhRQmPqmSjHXyIy6Ge
         C9WQdBvBCgjMchlipBica87yCNjkAT34nVnm8T09tnRBBNca/L1kmUvF6MnmJTuJ7XBZ
         Wqtw==
X-Gm-Message-State: AOJu0YwwohKC6uMezXqchn5nLEn/wpmqbdgGpUXlr5sBF3NL3FdNCsEA
	8KZrIl+d3iTHCSboqGAp+1wFU5apcFxF5UiIbxdLWV2kOLMngm5n1vOlvIDupNbGL0qrVDJZ07I
	X2Omfu2ZxLnu2/pxzinGnsUg+8mYAX6aguCK4/tDhS/nQBiF4isKboo1+6g==
X-Gm-Gg: AR+sD13G1N8wU18w8VV8iJk2o8y/G+OazNL0V1Xcv83uao8eGSUTz8OUZ4PyD/b0O5u
	Sm2AcyuDnpRdAk+XKKvWANNMhyJ4+LcrBou1uqRVnF9Fb7Fb/3t2Nb9D+QBCdsghBMSbECuCkTJ
	1TSdUWI3mz+gt9hS3/R+D58wYio2lOmBC9kSUZz7rNUEWTQqWIz8tOcZa/wMvAdSzHX6PaRrbhj
	iL/JMRpy+Mx0juy2HnMM05w3wNAZHKVRliEmD1BhheWjedIS42H7p5p4EBkKCL83Uk3I/BplS5k
	Or11ZlFyUp+XmVaMpOC5N1X+BQfKFJtZ9Xj3sjlZ0cagPKtrH7C5Fq20HyzyUbG8uYlBSGgdxt7
	MJQMHsgs9UzzwE/mrvOL5MFX7jDQ2ZCD4bQIZZBOO2Fqj0NTpvUpBAF6yBJHH
X-Received: by 2002:a05:6808:1210:b0:4a4:989:bb20 with SMTP id 5614622812f47-4ad5bb44154mr2596593b6e.24.1785273283119;
        Tue, 28 Jul 2026 14:14:43 -0700 (PDT)
X-Received: by 2002:a05:6808:1210:b0:4a4:989:bb20 with SMTP id 5614622812f47-4ad5bb44154mr2596580b6e.24.1785273282708;
        Tue, 28 Jul 2026 14:14:42 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6ed2dedasm231357b6e.7.2026.07.28.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:14:41 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org,
	stfrench@microsoft.com
Cc: stable@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 1/3] cifs: use cifs_invalidate_cache() in cifs_do_truncate() for O_TRUNC
Date: Tue, 28 Jul 2026 16:14:36 -0500
Message-ID: <20260728211438.3859107-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728211438.3859107-1-sorenson@redhat.com>
References: <20260728211438.3859107-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cifs_setsize() now calls fscache_resize_cookie() since commit
fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()").
However, cifs_do_truncate() is called from cifs_open() before
fscache_use_cookie() activates the cookie, so the fscache cookie is
still quiescent at this point.  fscache_begin_operation() requires
FSCACHE_COOKIE_IS_CACHING to be set and returns failure for a quiescent
cookie, making fscache_resize_cookie() a null operation in this path.

The correct fix for this path is cifs_invalidate_cache(), which calls
fscache_invalidate().  Unlike fscache_resize_cookie(), fscache_invalidate()
works on quiescent cookies: it unconditionally increments inval_counter
and sets FSCACHE_COOKIE_NO_DATA_TO_READ, ensuring that stale cached data
is not served once the cookie is later activated by fscache_use_cookie().

Truncation to zero leaves no valid cached data, making invalidation the
correct semantic.  No inode lock is required for cifs_invalidate_cache().

Fixes: fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()")
Cc: stable@vger.kernel.org
Cc: Huiwen He <hehuiwen@kylinos.cn>
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
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

