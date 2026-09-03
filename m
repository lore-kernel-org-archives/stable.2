Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C94BCAC9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447370; cv=none; b=tAnD4DcNKjTMUxxRnEdUDmGbLNm6leoUs8aqml88RR6izJcnjEB/VzornttqIHbIrPHSuJR0YfPiei8UJxHyS2azL+gaYCF4Zlj1ubWl51rkXbIVr9thFg1SK8tE+cVwg2Wnr7eforiakOS7mhuAxJs9E+03TXBvD/FfxuLN8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447370; c=relaxed/simple;
	bh=pKXb4cQXJLEx81+qAvxfscG3lRIGs3T89wFml308Gww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tLKDfKbiAQOXW+zIqJhViulSdWv0ltR5QQu73I/tuRejnjMM3/k0UKK7yxQSN1hsBOAJby9YEKUDS0Bj5WeT0RUSFB9JHvnB8762sB1vEx/d8xy1XOXau4TnE68pEyqoGOfztSFWYm82AwikmmmatKHmcFAvSyW7xaQB5GvQSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R5uBnZNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R5uBnZNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5361F000E9;
	Thu,  3 Sep 2026 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447369;
	bh=Mcr5UHYQnvnA7R7eZsSHtL47xup9yTtQAsayPud1Njo=;
	h=Subject:To:Cc:From:Date;
	b=R5uBnZNX3QJl8rOYd0fyY8vzQwaFt+0r/QXwDU+JrDxUIIxKcy+J0Y4yV0FEg31sz
	 5QyosmHk/K0WYF7iub1FuL/GZCNRb53EWSNQFAQ2oZn8+pa1iU5LD/Wr5t+ccmlML1
	 JgJqEun0EBeyT4eX6OoLy9mN9kHDCWgljpRtXY9k=
Subject: FAILED: patch "[PATCH] lockd: fix swapped arguments in nlmsvc_match_ip()" failed to apply to 6.12-stable tree
To: oscarou@synology.com,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:33:01 +0200
Message-ID: <2026090301-flyable-joystick-bb39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b9060689f49dc663e9a3d069c4a65ff63a836e66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090301-flyable-joystick-bb39@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9060689f49dc663e9a3d069c4a65ff63a836e66 Mon Sep 17 00:00:00 2001
From: Oscar Ou <oscarou@synology.com>
Date: Wed, 17 Jun 2026 15:57:38 +0800
Subject: [PATCH] lockd: fix swapped arguments in nlmsvc_match_ip()

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

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index e418a50c4180..14cc952fe81a 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -314,7 +314,7 @@ void		  nsm_release(struct nsm_handle *nsm);
  * This is used in garbage collection and resource reclaim
  * A return value != 0 means destroy the lock/block/share
  */
-typedef int	  (*nlm_host_match_fn_t)(void *cur, struct nlm_host *ref);
+typedef int	  (*nlm_host_match_fn_t)(void *owner, struct nlm_host *ref);
 
 /*
  * Server-side lock handling
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e44eb20d3453..ffab76278bb2 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -557,7 +557,7 @@ EXPORT_SYMBOL_GPL(nlmsvc_unlock_all_by_sb);
 static int
 nlmsvc_match_ip(void *datap, struct nlm_host *host)
 {
-	return rpc_cmp_addr(nlm_srcaddr(host), datap);
+	return rpc_cmp_addr(nlm_srcaddr(datap), (struct sockaddr *)host);
 }
 
 /**

