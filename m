Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20E51357F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950075; cv=none; b=TUmCLeGINQMsjQ38JAjKINcSemvz92+Q+3NP38n0n6l4BdjH7LuHBXABLGM1IAZYLmMNCOnThaZkMfDDlH6WT5ZiTpNAtW10i0eoxjav2trUTVWrlmcqt9GgL67EQTvvnGbmnohssm/r9wcnCjXXGBBdFxzpZVxGCWavlVKiX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950075; c=relaxed/simple;
	bh=cZx+uZiIuFsZk6tCHSQtItB4+f2cMD8GFoU88JBumm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8C99ddo8jvxohqU2JfMaiLDKKmWtU3RBQi9mjRR3gLHPtpYkA6/hXJZWZV27zMNqquoIWyygzvStYCXENIsHSZWJShQhPj4VmDM9DZZVCk6JaaSmAQ4ZEydilWeX+BXwYb+OQCFcZugn5ocydTJwQn9XzDoRmKPZv1VpgT58i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqIvomiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqIvomiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B1D1F00A3F;
	Wed,  9 Sep 2026 10:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950073;
	bh=cAknlqRwwstuFzZlz0yL94UQEdmEDIPt5ZisLLFUl+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EqIvomiSRFO6Ww5U6HwJasozBL9jNMQdVdq5lYLJVrtpiHo6o1h98481igmkZZBg8
	 EAhAvxeWqECS/x1FwhwaF+8r0n60Di38RJAXsIMgO6WrcgdsXV+elSNnMGXg6KKZdn
	 BgE3s5FeKahkm9LEeUfS38Y7dIJ0L2qp5EavxMgMg01+B2+UGP79vqjZEq//IFOPQc
	 EsfRHurYlCP+AI5o/0AM5/4n/T1B/IM05W8zXJXWwTruuDjKh3Sd8DCcYEFioHwfAC
	 aJjEPfx83Lblodj5/y/+dqBgOmUM6qqQGUd26c04KGFWXTKwd7/OImwhAL+//aoCcE
	 Y4ywOM47c8nCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oscar Ou <oscarou@synology.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] lockd: fix swapped arguments in nlmsvc_match_ip()
Date: Wed,  9 Sep 2026 06:34:31 -0400
Message-ID: <20260909103431.1544654-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090300-isolation-small-467e@gregkh>
References: <2026090300-isolation-small-467e@gregkh>
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
index 91a4c22c86ff2..4075d0eab263f 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -508,7 +508,7 @@ EXPORT_SYMBOL_GPL(nlmsvc_unlock_all_by_sb);
 static int
 nlmsvc_match_ip(void *datap, struct nlm_host *host)
 {
-	return rpc_cmp_addr(nlm_srcaddr(host), datap);
+	return rpc_cmp_addr(nlm_srcaddr(datap), (struct sockaddr *)host);
 }
 
 /**
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index d9930fc43ca54..ba838f529056c 100644
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

