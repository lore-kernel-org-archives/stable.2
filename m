Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC673F6C3C;
	Fri, 17 Jul 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309385; cv=none; b=rpDsUpgaXqQFXUtRgJ4vrWUWd9P45uB1mxQUa36nvdXT8Ihpng/Zn6zaFUJa4r9eV8/OiABBV0gVHUyNJDNhVgsxb1hr4frFfALMYQNLR1h9Jx1Pj74bAEciS+QEBVSyefpRoKJ7ujb8HuKRGxCPYJ5UeLsdlXXsEOIieRKDG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309385; c=relaxed/simple;
	bh=XF9wdLy8L2QQ1MIsBlaOqfidxTpLzvtKGCJJFg3XbJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIYNbLTVRR2u21rii3pW/Sj3MWnfJn8qJIWZSm8ps3WFSsjZz9nTPnsGbXzYZ8/e63jFKiPCpKpERKMQlrkh1eMoh8wD80BPzZ/GDpInXJNrl+ePP7noRrzGFCefak8ffNYfubZ1oSGm8BI0Tu4hl2ntsf3Jb5/HFCYubruylPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=b+9JInNi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="b+9JInNi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=6Wl5sCv+GUQA7woBHlPhm7ZYfAEeXe83Pf/DdhV+b1g=; b=b+9JInNi7RM1zc67G05aMrz0N3
	2LqNL7N0BXUS7P8+7/Epv5uX8e1IYzplvazQ5RYBzCmyTpCVjKSH6abYr50gG8OOKaa8iQCfW6YMI
	QKzgjQtHKgjSBbDPnKWmihVHlP8GK1j8ZZRTjy5KdyQRx7UatiGlTA8KxaHMbRSVjXaoMElzyUDhk
	UEBW43cljA14/t+ZgIhMp2ZnOH2PhS3qOTrFIFEZxJK7eyuTZ+ErrYPCyp4Zd2Go1ggK1wmASCnN0
	9V4bon3wzRcqO7kp/3plkRRhmDyVbMtSibM3QiWho/EOhStP+a7uoVfpWYhvIoBqiihPIsvRuGI5P
	i1IK+wZA==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 5/9] af_unix/scm: fix whitespace errors
Date: Fri, 17 Jul 2026 19:29:18 +0200
Message-ID: <20260717172922.3398851-6-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717172922.3398851-1-heiko@sntech.de>
References: <20260717172922.3398851-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

[ Upstream commit 2b9996417e4ec231c91818f9ea8107ae62ef75ad ]

Fix whitespace/formatting errors.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Link: https://lore.kernel.org/20250703222314.309967-5-aleksandr.mikhalitsyn@canonical.com
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 include/net/scm.h  | 4 ++--
 net/unix/af_unix.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 0d35c7c77a74..ea85f7427a19 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -69,7 +69,7 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
 static __inline__ void scm_set_cred(struct scm_cookie *scm,
 				    struct pid *pid, kuid_t uid, kgid_t gid)
 {
-	scm->pid  = get_pid(pid);
+	scm->pid = get_pid(pid);
 	scm->creds.pid = pid_vnr(pid);
 	scm->creds.uid = uid;
 	scm->creds.gid = gid;
@@ -78,7 +78,7 @@ static __inline__ void scm_set_cred(struct scm_cookie *scm,
 static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
 {
 	put_pid(scm->pid);
-	scm->pid  = NULL;
+	scm->pid = NULL;
 }
 
 static __inline__ void scm_destroy(struct scm_cookie *scm)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1d426f5b2580..c64d8ee0ede4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1887,7 +1887,7 @@ static void unix_destruct_scm(struct sk_buff *skb)
 	struct scm_cookie scm;
 
 	memset(&scm, 0, sizeof(scm));
-	scm.pid  = UNIXCB(skb).pid;
+	scm.pid = UNIXCB(skb).pid;
 	if (UNIXCB(skb).fp)
 		unix_detach_fds(&scm, skb);
 
-- 
2.53.0

