Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155B4446E2
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512112; cv=none; b=CIZWkn7mlaKQKUDIQXqK6ZHsGJOZ2GtKWBBMj71pIo5kBJLU4quBy/2oRt35losOsT0TQVGNFfdceK99/RzYKQFtrYBrocwiDnUobAzELwI0rR6T8PMxfKREYXOn3HNb2ruZTt5foe0KCaNK/LUYPJhREfjDGWnq77PsJgifuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512112; c=relaxed/simple;
	bh=52nLRTTzZW53P+KhFXoiebuaaIZj5U5rrocnkEh0ovg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5Xbydd8qeJdbgu1BSzNTUxwgVTNi2dhDfQTX74NUpEg2zdjjcaFpwacf0uMhTUYei5OfdWhiyrPSvt8mU5UjFHxWIcFysIGzFqbQQX0Np2R0pYQ4ZEuvo7neI0J0OpzGBIT7PRT6r1+/3OAO7xPSNvOYPjQwH2b8CHnfsDWcKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DExVsOpH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=keAqPoJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DExVsOpH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="keAqPoJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785512108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDt42OCPMiF5ACU9K3Vyp5738A0ZbescXylCCtt+Clc=;
	b=DExVsOpHHeCQHI65u7Gxk2S+I8PnAjfSu1n/wjzF6EEASCoGXgBoChzupGn4QJkp1xsmjn
	jbxFNxexmtSC8VhC+gVvNxxu762xkhNqPSeHSSZsZmyp8kLR4BC1GDR9nt71IDR1s1ZIWx
	yGFqVwZyE7BRmXGFTvugqLuttkyAg78=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-IRZPzSg4OSy8DVRBVVbwcQ-1; Fri, 31 Jul 2026 11:35:07 -0400
X-MC-Unique: IRZPzSg4OSy8DVRBVVbwcQ-1
X-Mimecast-MFC-AGG-ID: IRZPzSg4OSy8DVRBVVbwcQ_1785512107
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a45997664aso1408697b6e.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785512107; x=1786116907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lDt42OCPMiF5ACU9K3Vyp5738A0ZbescXylCCtt+Clc=;
        b=keAqPoJwocTdfb0TI0TXgQEIZEp6Fc5L9n36I1pSdkG/4F3kEADDVPrwXUXFdXF3/V
         YCSfrHNO9WfGwWfMuRiCoYsvGKap+3wLqifdmUEHCIH9tJ8pv+iDUxAjeDIf5vMkTj/1
         jOmf/LAyo38Nju1zpcJVZY/Ctke6hZTUD3OTOOahVgXc1SxjDo16sSs/Hz6laARdnlK0
         1qAVvE8xGc4DG2qnJxKDWbXKgJVWtpSGM4t/Jgx2WOuJs6UK/s8gh9L9DClzrSFj3y3m
         T5uLsNrWoV/QfopNOWlgViWMdAagEgmhjk1Dhozc1J5CpAy2xdJ9sKMe9+MngK/jjXak
         +HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512107; x=1786116907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lDt42OCPMiF5ACU9K3Vyp5738A0ZbescXylCCtt+Clc=;
        b=kebBPmaP6OEwyh2Y/X/bSbfMZu3g5lJaSuNfZivM0IFQ92blFhOIWTJ58w5mxcayLM
         opevhBl/8wFvBGAb9XFWYMlPFPqFlOHYiom3kv44MgtulioLmvep1w37Bcl2hicCUJiV
         7zSOP73QnVXqMB47tj72pcKCCKcV2RWKUQ+sVKQshF7rZ5+RdgepWJxlawa1E83RymuI
         3rpGcIceqUGvZNbTHygH/HNpFMMMf9Ed3r54FcE/vbgxuEhtgLRLuMk9F2wmuKY0l52S
         skbPReUBtLgU1YCoDEIFeJx1P74JAyPH2wTNXT9tc9cXEozV8mQFH8lOCdd/mesrsh6F
         NpPQ==
X-Gm-Message-State: AOJu0YzE1Spgj0B8kejB//T/Ep00Lki4VnoAV+sTlaR6U24V3Ltqv2eF
	CASpLlCVfIsSaxgbTpiyutwvpAwPiSj5p+2ARFHFIuQbTYziOB6Mdhu6euuNEP7iKC2q9TjxBgk
	zCtJig7FG0U3D8g3q2CSB4M4x436wtMm6H3OqrXjCn2ULuJwWyBNXI9AMyBhPWtchi+4c
X-Gm-Gg: AR+sD11Rb5pbJpwpqrdc7FRN3tYXeiPYxCnE6Ovoy3BqdwrCqpItnHy2pMuizZtHYMY
	/GqCngBx+CRMOl4sLsSOoXIYTOqGXsT4IQGYnUbxiUM09od5A7uDQGCNx5k+CfYRZeSAKv/LO1O
	580O83zNTCeFHoaVIiJUeblU1dVCFtinZ97bL9S5YkEqnF4syx5OSM/pMU53Oew3JAX/pEFdi/9
	fU0ZO+VfwR/rMKqZaGT1742PxYOg7Z9RHu2cwAFa/33wb0i3o1jiE5Gp9gZoo7ByKvNhj2MWZlr
	0qMLr5a7ca1HBjZ+sSCP5ya/ETEciBi/EpsUj6IDEXEFCsLPEWDi0aPHmuDSQfXYZgbLAr17yTa
	HEyPUp6xCfo8Hj0KjxjjQEe7rgGBVkjto8ENINRCqymI9cMr54Lv57Dz2HbPn
X-Received: by 2002:a05:6808:6c82:b0:496:11f1:f2ad with SMTP id 5614622812f47-4af5e037ee2mr651192b6e.6.1785512106640;
        Fri, 31 Jul 2026 08:35:06 -0700 (PDT)
X-Received: by 2002:a05:6808:6c82:b0:496:11f1:f2ad with SMTP id 5614622812f47-4af5e037ee2mr651136b6e.6.1785512106226;
        Fri, 31 Jul 2026 08:35:06 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58ce144esm855813b6e.1.2026.07.31.08.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:35:04 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org,
	stfrench@microsoft.com,
	hehuiwen@kylinos.cn
Cc: stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v2 1/4] cifs: use cifs_invalidate_cache() in cifs_do_truncate() for O_TRUNC
Date: Fri, 31 Jul 2026 10:34:57 -0500
Message-ID: <20260731153500.660569-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731153500.660569-1-sorenson@redhat.com>
References: <20260731153500.660569-1-sorenson@redhat.com>
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

