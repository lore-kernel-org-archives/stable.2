Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBE422530
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059805; cv=none; b=Hgm9sm6BWTh5akQYHa+7vAV82YKzGsYi53m+f26POXFGtn1rE4ekF8vUty3WNLhCy83Yzp9uHtbT2ZyBzxTKsmNg32zxZ59YnwD6bQ/pzdfjvd1BrsYl1NCLNOB1p8AYaeAesTR08pKBvUWMGAJSy2NIKYKcpgZnixldRbrbi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059805; c=relaxed/simple;
	bh=vj/ZiibbgyOF245m8EE4XGt9LdWTvEP94G4b7Yqr+QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV3Hhkmk5oeO1tRklYT6cbWNDfZDjRZAuYhBkhqbBxaq7Bl8BqzVBCPWRKA2viu4SFtJt9XpKT+DF7gZFNtshPuw/20k8TrV4BqqRFRtKLJggRq+cASe39IEfHSG749FUzSisq2kfLgSo0+q7nvutn+tIGvdOBMmCzoH9wDomdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TF3o9Ljn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iz301R19; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF3o9Ljn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iz301R19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786059802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgQO6c8L3JLrPOSlWX6dvSno5AXv3uRrAtPYOdKDujM=;
	b=TF3o9LjnraX8bj/z3T8uGkOyi/MJjkbD+ic9BF/qCDygqCScSVqBjJOf/4gmxFgfgmll7Q
	i0Zaz2vl9oRwY5UGCwpoulZFUKPF8iJUkV6D7zLsTzSC83X0zs8vLbJ1wZOB+nmW1IVscK
	6Hq8pRjZYcqLbdvMxnIRHcXht+jGxGI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-qiVktDqkO3iLwx3HzobXLA-1; Thu, 06 Aug 2026 19:43:11 -0400
X-MC-Unique: qiVktDqkO3iLwx3HzobXLA-1
X-Mimecast-MFC-AGG-ID: qiVktDqkO3iLwx3HzobXLA_1786059791
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ac0a54110so304748985a.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786059791; x=1786664591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PgQO6c8L3JLrPOSlWX6dvSno5AXv3uRrAtPYOdKDujM=;
        b=Iz301R19ljH3kmkmFrVWUIythCuRcemRj1jQr+Eqqg7gxQ3kudW9cFg7PnIIERlDx1
         1T4XXajCat6dQMIgVp6yBfNbYnrCRGWbPRE4a2Yd7Wv9RclF2urdnbFt6oQ5gtFsJ0YZ
         0QWDgdumD7oPHM+UMFSF1GGUboXd9RUxZKX5ApbmxnNWw9bsaplAxjH23tGoiqylg1/c
         WZEBIWLl7vHMH1x0e+Ce5cP24AWvt++puxGtsgiSN/idBhgqa56XvJjwSfS1RgaWfkSz
         amSo1D3RxoyWsQEJf+O6a4xJxcvlrPYzW+hPJiDXgI7WS9AYNfZp2/xSLQx1wzOed4K3
         GL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059791; x=1786664591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PgQO6c8L3JLrPOSlWX6dvSno5AXv3uRrAtPYOdKDujM=;
        b=pokmY3VlxKqDghV3ZVpWNkGlgZoVNd2Qz4Zvc6A5tvXhRaY8Z1684BcBYmeOcjmE5v
         QC8VGu/dVnYNsGLQNHpcvGGu5Ii84S3r8D0HHzA6ugg4E+Lnx+ZDMFquC4i/fealEzVS
         QMZdehiInPFU3C3HTJLrATD/4c/oh5ZhStJkCVna8bff5fX7d4XQuA2ZUu9vZZyFTuXN
         EGe/j4Q1+yUfJpKQz3dsNq802sLOZkmcoqvYbDPb3MD0go2HiYvTwtWDVylSwS1GOzjK
         sUptstlqw21k5xaoDGb+UseEqwHPqlBuMrwoG9MkUuGA5OxANUjl/1dyPORO+ay9GKKX
         JO9w==
X-Gm-Message-State: AOJu0YyTS2PIUHUPasWdS4xYbncVjnASAuXvtM3zpsEXWLA3FvHOHefg
	fHItafeX7/qcrAVSi1AMigGh9B8kk/2iNhLs6C0IVKTuv5SPPFA6KS+6C0b75DCcITWbr6BIOAa
	cf/paZvnYCT03lCq7/klQzGgwWWu/N7Hp6KixUQjGvjmuRH4jlmbQyPP4ag==
X-Gm-Gg: AR+sD13JNpAIMmtfaXEwWumcyhNj3ohD4nn8VEgLn3OEz9iNSdfW06AFz/qWjFY6fTT
	k/gJZ0wA8vOA5hA8TR4F3WzK7osYydMU813JomN1RjaE22wYOdA02dwKSweo9T4isJ66lz3ynFA
	6/73TcxsMjvwvnDMWXWus/FrDlwdXP1k/sY5DXUHOhvninU+iLDBC/xq+63jrx95hOLnkhmJbzG
	wA0PajcV9R9CeSVkKuzzfk8BNXp/5pvZASYrsuWx7eEqGDLCuOZ3gtP8X/CDjHW18bYCKc6jAN3
	mquVLzUo/cAjjowzt5X96jkRlpLF9lcYaZHYp657VW8GAACu3fm3vIBixrRdea+Jx5LBA3RusEM
	yyzpb4o3SkklB88KZ2Qj5nu0J+II/LtFbuUb9DrsUyPLcONqb+glQgCoCMMVIRoG2Mw==
X-Received: by 2002:a05:620a:a003:b0:932:fd59:3e57 with SMTP id af79cd13be357-93649148855mr1850259185a.41.1786059791105;
        Thu, 06 Aug 2026 16:43:11 -0700 (PDT)
X-Received: by 2002:a05:620a:a003:b0:932:fd59:3e57 with SMTP id af79cd13be357-93649148855mr1850256785a.41.1786059790675;
        Thu, 06 Aug 2026 16:43:10 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03f05bsm26891485a.2.2026.08.06.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:43:09 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com,
	pc@manguebit.org
Cc: stable@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 1/3] cifs: clear tcon after cifsFileInfo_put() in cifs_file_set_size()
Date: Thu,  6 Aug 2026 18:43:04 -0500
Message-ID: <20260806234306.3662175-2-sorenson@redhat.com>
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

When the else branch of cifs_file_set_size() finds a writable file handle
via find_writable_file(), it borrows tcon and server from the handle's
tlink, attempts the handle-based set_file_size() RPC, and then releases
the handle with cifsFileInfo_put().

If set_file_size() fails, execution falls through to the path-based
fallback, which reuses the borrowed tcon and server under the
"if (tcon == NULL)" guard.  Since tcon is not NULL at that point, the
guard is skipped.  If cifsFileInfo_put() dropped the last reference on a
tlink that was already removed from the tlink tree (TCON_LINK_IN_TREE
cleared, as happens during reconnection or session teardown),
cifs_put_tlink() will have freed tcon; the subsequent set_path_size()
call is then a use-after-free.

Setting tcon = NULL after cifsFileInfo_put() causes the existing guard
to take the cifs_sb_tlink() path, which acquires a fresh reference for
the path-based operation or fails cleanly if the session is gone.

Fixes: 110fee6b9bb5 ("smb: client: fix missing timestamp updates with O_TRUNC")
Cc: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 2eab50dea774..d6caff2e29d9 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3121,6 +3121,7 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 							size, false);
 			cifs_dbg(FYI, "%s: set_file_size: rc = %d\n", __func__, rc);
 			cifsFileInfo_put(open_file);
+			tcon = NULL;
 		}
 	}
 
-- 
2.55.0

