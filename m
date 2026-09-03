Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747094BC022
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447367; cv=none; b=pzBGn1mpZa6wWq8vrd3LU3GcnXY42PDIPLFnOepqC7g3bstJnj/r/dnLdKLjaMbgmnSOOB3P0b61Pv1uw7+wEMnGa28SgijeGmLfokm5i9ildIAnvi7+OrZL4Sbf0LtdmH4SrI+jPVFBiSuWsD2KfI9/3D3Rordlm/maE527zwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447367; c=relaxed/simple;
	bh=TSQ+0EvensPKd94dkm68chvPHwY8zyaPex7fcfJ//ss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P2eb8T3XMzYQ2+ayg91I2c9eSDVzua/83K6mlQAg0pyUB1WJSp3i0ONh0FCiREIY/kWYlu7eXI4z0hteU7YyXfr0XmjHlm6QcyTrbQkuYK8JcARfpFpiaiz9FYP89juBxSCEx2ObClIIKc39dRJ26wRNxAf4I5GvSfQhehWQxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MwuPafGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MwuPafGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E5A1F000E9;
	Thu,  3 Sep 2026 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447366;
	bh=3fJZ48ZVhLDFPnI8L2Umga6UmN8EX9CuMtzsQ84Swik=;
	h=Subject:To:Cc:From:Date;
	b=MwuPafGcBpmd1a7WgqBwR5aFs6gej2PiIGMf9oSOzLBgkwoY9P9jpeMLqI9wJslde
	 Ut6TD5R8X6rIz5/mby0uMi1WU+VlXRn07hZBnpi1n2ZX6S/Iw0qYTTAWBNYBTmqAJ1
	 AsgNJyZwY6nKcxvxPL2vAuilo3YhVkOOWj2pU8Fc=
Subject: FAILED: patch "[PATCH] lockd: fix swapped arguments in nlmsvc_match_ip()" failed to apply to 6.6-stable tree
To: oscarou@synology.com,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:33:01 +0200
Message-ID: <2026090301-mustiness-immersion-c821@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b9060689f49dc663e9a3d069c4a65ff63a836e66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090301-mustiness-immersion-c821@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

