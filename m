Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E3526A89
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950586; cv=none; b=rDB1kPZBJ5CeF2LxfNg6g+ln4zWLxb/U5XDf86hHzQ8QmiQEtEJDa/8TPWS39hhiUYKnB0G6OLyiAl7WRucZMXF8vEx/aocTV+QFdzoQ0nMfthVsM+Pv97geRUisxxkv51qQemIiEUwXONY036GD6JalJ3W5EEObjnNf/F9VxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950586; c=relaxed/simple;
	bh=fRcbYzfwhefvk/+c0TewifTfKDiUE/SeLJQvmhlnM0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0XLpLpSqube3Upg7Sd3UeACsAGxLlcH0fL00ZGDls+JNBqDy4YOxCTXe3l06FBXW5+I9eIWlCeJO0UnjV4pHY7V3ntWIvdrqXZqoI8Y1zEH2yZkosScvNq+XaffL2ikJoS7oGgW8izVH5vcDxNPAZc8VY2e3fXOlzRDJ+K+DN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipfUBJkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipfUBJkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BCC1F00A3E;
	Wed,  9 Sep 2026 10:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950584;
	bh=6qlZoiEa2i9wQJfA2fmG+jG1sN8J2L8vAdxFbCpjFig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ipfUBJkYHJk5imYzVhkKPV3mcVeRTIm7n7K0emJShGKh9SbuFpRp//O/KHKoktIra
	 JXBdxNwkL9QU1D+kQxGLa/rMXn+YHc/z6/czQp5aSmJ3J+rQx8SIcvfez3jQl80GNF
	 rGj5Z+ItlJt2uq4sMOgPjMVX8bsgQGdF9FTqNd57zMrx5AWQXnlNJayeb/yb8k+RdQ
	 AvCwecZKZXYo+KOPTUxMpzGRk2kZgYZhRr5hJkBgdO3ZrRKhER+iW+JtSj1yRXe1JI
	 0kTjR2XYpGWL/bS9aFNGNK3ODFEQ846Vbv9PRy3IrOodmODWIsFxK6lkd6o82dtg7i
	 irK39bY40cB8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oscar Ou <oscarou@synology.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] lockd: fix swapped arguments in nlmsvc_match_ip()
Date: Wed,  9 Sep 2026 06:43:02 -0400
Message-ID: <20260909104302.1557843-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090301-flyable-joystick-bb39@gregkh>
References: <2026090301-flyable-joystick-bb39@gregkh>
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
index 616ed213adaad..90c6527ad712c 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -493,7 +493,7 @@ EXPORT_SYMBOL_GPL(nlmsvc_unlock_all_by_sb);
 static int
 nlmsvc_match_ip(void *datap, struct nlm_host *host)
 {
-	return rpc_cmp_addr(nlm_srcaddr(host), datap);
+	return rpc_cmp_addr(nlm_srcaddr(datap), (struct sockaddr *)host);
 }
 
 /**
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 61c4b9c419042..4044502355ae6 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -268,7 +268,7 @@ void		  nsm_release(struct nsm_handle *nsm);
  * This is used in garbage collection and resource reclaim
  * A return value != 0 means destroy the lock/block/share
  */
-typedef int	  (*nlm_host_match_fn_t)(void *cur, struct nlm_host *ref);
+typedef int	  (*nlm_host_match_fn_t)(void *owner, struct nlm_host *ref);
 
 /*
  * Server-side lock handling
-- 
2.53.0

