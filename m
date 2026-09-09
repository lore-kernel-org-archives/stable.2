Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D84B2CA9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951447; cv=none; b=WieDANf0+VpzD9H+3HR0DthJhTGBQCaoXUYFUfwo0b4fPFtAFJit0z7JSP579jEGo6aLp+ZD+8Am8oN691ro8qFgyT+WFFNOaWdy6bQNb1aFmjGWE/R/6srP9O8d7jMdOMSteKKSCkRIKsYDRCPkONd1sDBRF8aCH9jSAZdz6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951447; c=relaxed/simple;
	bh=3b6bi45vmRV4CqLNPc0VyEMFgnhe6nRGutLBSEL4Who=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0APGFS0KvnpKwzb10WEhQKfbS2nXZWq/e42KjadRR5Q+rI7+lOmHPArUyRQm/W4eHmg+0tmj72vTpgtwCXu4Nc4w8ge0YQjMSdq/UWhyCxOpsvngJwcHODF/4HQzvp5QWhToJwMJ5LgLwEWJUXerlWP7PMo57/WTAFioVcvIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY8bF34L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY8bF34L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD971F00A3E;
	Wed,  9 Sep 2026 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951444;
	bh=TLgQlocaScL9Poam9TXJWLl57wIdueVrgC/XEOiAwV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TY8bF34LD2IVc+QzHOhvgwt5Sej4a9oj0AdVuqVWmC9faR6EsJl25/9xmuFr3IBzy
	 Xupbi+pbpLKfpxXbGwcAj5D6xxmH2EWRPHDzWXLWHaOL4jbL9LIBLgF1ElFfETf4dm
	 wGczfJv17uJTTlkJa6UCaqYj2oYaj6B5e7JfcWvzWt0qhEqnh+B/yt9MwxqhK8NbMR
	 bukWhXKP3XXTdAyGKwzaMr4nbdkSjsmjcuDXn6eimkyiZTTVEN7iNgO4z72mCQPI/Y
	 m3nhzu/BsldeFdJb92f3aHNLqyHFjJe2j27gTy/KXxg+4/naQQh4x8TROw+31lZPDY
	 0hMkY05avpXGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oscar Ou <oscarou@synology.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] lockd: fix swapped arguments in nlmsvc_match_ip()
Date: Wed,  9 Sep 2026 06:57:22 -0400
Message-ID: <20260909105722.1641802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090302-manila-aim-a3d7@gregkh>
References: <2026090302-manila-aim-a3d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oscar Ou <oscarou@synology.com>

[ Upstream commit b9060689f49dc663e9a3d069c4a65ff63a836e66 ]

When releasing locks by server IP address via /proc/fs/nfsd/unlock_ip,
nlmsvc_unlock_all_by_ip() calls nlm_traverse_files() with the server
sockaddr as the opaque @data argument:

	nlm_traverse_files(server_addr, nlmsvc_match_ip, NULL);

The match callback is later invoked from nlm_traverse_locks() as:

	match(lockhost, host);

where the first argument is the nlm_host that owns the lock, and the
second argument is the @data that was originally passed down (here the
server sockaddr).  This is the convention every other match callback
relies on (nlmsvc_mark_host(), nlmsvc_same_host(), nlmsvc_is_client()):
arg1 is the real nlm_host, arg2 is the caller-supplied reference value.

nlmsvc_match_ip() has had these two arguments reversed ever since the
unlock-by-IP feature was introduced in commit 4373ea84c84d ("lockd:
unlock lockd locks associated with a given server ip"):

	return rpc_cmp_addr(nlm_srcaddr(host), datap);

Here @host is actually the server sockaddr, so nlm_srcaddr(host)
dereferences a struct sockaddr as a struct nlm_host and reads garbage
at the offset of h_srcaddr; meanwhile @datap is actually the lock
owner's nlm_host but is compared as a sockaddr.  As a result the
comparison practically never matches and locks are not released for the
requested IP.

Swap the arguments so the lock owner's source address is compared
against the requested server address:

	return rpc_cmp_addr(nlm_srcaddr(datap), (struct sockaddr *)host);

Fixes: 4373ea84c84d ("lockd: unlock lockd locks associated with a given server ip")
Cc: stable@vger.kernel.org
Signed-off-by: Oscar Ou <oscarou@synology.com>
[ cel: fix the misleading typedef parameter names too ]
Link: https://patch.msgid.link/20260617075738.1151797-1-oscarou@synology.com
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svcsubs.c          | 2 +-
 include/linux/lockd/lockd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e64e0110f66b5..a967fcdd195f4 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -486,7 +486,7 @@ EXPORT_SYMBOL_GPL(nlmsvc_unlock_all_by_sb);
 static int
 nlmsvc_match_ip(void *datap, struct nlm_host *host)
 {
-	return rpc_cmp_addr(nlm_srcaddr(host), datap);
+	return rpc_cmp_addr(nlm_srcaddr(datap), (struct sockaddr *)host);
 }
 
 /**
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 70ce419e27093..d6034b8bbb7dc 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -265,7 +265,7 @@ void		  nsm_release(struct nsm_handle *nsm);
  * This is used in garbage collection and resource reclaim
  * A return value != 0 means destroy the lock/block/share
  */
-typedef int	  (*nlm_host_match_fn_t)(void *cur, struct nlm_host *ref);
+typedef int	  (*nlm_host_match_fn_t)(void *owner, struct nlm_host *ref);
 
 /*
  * Server-side lock handling
-- 
2.53.0

