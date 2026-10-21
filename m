Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594119;
	b=PL5mjlNQI4xo0vZBLUFoSoemMwM2UWZgNlc2d1+pXbsNroJ7ky+KeaaVSLB3NCp+sr8x
	 aRnIDvWRB3dap1Sz9cQuqLPQUuciH+TKfsG2wAw4ev22rUbdAByh3sQknJnrPSJqbpItL
	 xDdjqArBgto0DxD3/tbig5R5Qu/ObLzKpUihnHVPM72JSmHue7s9K5iREzv4lGZPtB+kW
	 9Zw1OGL7S/h7eEt3NUuPIUx1mSZo26oL9XRPeH4kfHOrW+/8tqDbUFeHJm1BkB3wJS4cl
	 r/t/qMOKnU4xrjq6301vcnxVX5oiANRkc5RlEcwpLSixSSovVnII5MaDmD1aEaC1HYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594119;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WsFZ5sU62JSApb7dpz4cTMlNo6vxQGPJkNPsckKfYSg=;
	b=Eo8CGH0HKkDXaMKS7N+thae8DItnwWiQ0UIZRRJ8NKwp4GFukdCvaVbmpjvdTDJWu4HV
	 dwRNiPteyNls0XXu26WG7vQXhdWK+2KaqQqEBGTZQ8jcd014l4zErvt22lcy47gcy+c0x
	 XbsvoGiqAAUG1LDggX9CudV1+hUYYeWLVGMZGASYKUdB9qjWUWBPgRtvU1IzyFH6N+SBx
	 ZpHEh8FdnHxcdXNonkrNZNrxrGQFZPbRcsYh/VcwLv/6eE2HY6Wg27iEDCbF73CkD9gpN
	 7gOIbjiLSuDYeB+UDZYKUxQcBRgSW7y+rLOTD2VyMS4NocjIxFZxFH7FQtH5Et1m+fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=po44TFdz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C931606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=po44TFdz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989E51F000C1;
	Wed, 21 Oct 2026 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594119;
	bh=WsFZ5sU62JSApb7dpz4cTMlNo6vxQGPJkNPsckKfYSg=;
	h=Subject:To:Cc:From:Date;
	b=po44TFdz2JMO9mMWLU3La6dtsbQcB7SoIKCG2b0WTe6RjYT2zKoN7M1ccfrIivAyg
	 XOo2Hmuna7hr3A+BYVWD/MEx2p/r4+EWRoJb+12k/CmD+wtxUzbHt4P0rIDVQIuRfq
	 XgAt5ZVt6MB8gvH3PQ3tN9u3ns6sOVtRxE/a/drw=
Subject: FAILED: patch "[PATCH] unicode: free the map after a grace period" failed to apply to 5.10-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:33:13 +0200
Message-ID: <2026102113-bobcat-angriness-3465@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a96c5299bd7305eb984377681eb3222a57376405
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102113-bobcat-angriness-3465@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a96c5299bd7305eb984377681eb3222a57376405 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 9 Oct 2026 23:51:56 +0200
Subject: [PATCH] unicode: free the map after a grace period

generic_ci_d_hash() and generic_ci_d_compare() read sb->s_encoding and
dereference the unicode map while a pathwalk in rcu mode holds nothing
but rcu_read_lock(). The filesystems that use them, ext4, f2fs and
tmpfs, drop the map with utf8_unload() from ->put_super(), which runs
when the last reference to the mount goes away. A lookup that is still
inside such a filesystem at that point reads a freed map.

With a pathwalk held up in utf8_casefold_hash() while the last reference
to a casefolded tmpfs goes away:

  BUG: KASAN: slab-use-after-free in utf8nlookup+0x74c/0x950
  Read of size 8 at addr ff110001030fe658 by task walker/98
  Call Trace:
   <TASK>
   utf8nlookup+0x74c/0x950
   utf8byte+0x160/0x1560
   utf8_casefold_hash+0x167/0x230
   generic_ci_d_hash+0xdd/0x1c0
   link_path_walk+0x11ad/0x1d30
   path_lookupat+0x63/0xb00
   filename_lookup+0x1f1/0x5b0
   vfs_statx+0xd7/0x3b0
  [...]
  Allocated by task 94:
   __kmalloc_cache_noprof+0x249/0x560
   utf8_load+0x4e/0x570
   shmem_parse_opt_casefold.isra.0+0x92/0x270
  [...]
  Freed by task 97:
   kfree+0x1db/0x5b0
   shmem_put_super+0x72/0x170
   generic_shutdown_super+0x14c/0x530
   kill_anon_super+0x3a/0x60
   deactivate_locked_super+0x9c/0xf0
   cleanup_mnt+0x9f/0x130

So far that has been hard to hit. umount(2) waits for a grace period
in namespace_unlock() before it drops the mount, so only a mount whose
last reference goes away elsewhere, like the close of a file or a chdir
out of a lazily unmounted directory, can race a walker. So it is
reachable.

Delay the free until a grace period has passed. The map and the data
table it holds a reference to then outlive any pathwalk that found the
superblock before the mount went away. The reference on the data table
module is dropped from the rcu callback as well. utf8-core is built in
whenever CONFIG_UNICODE is set, so there is no module exit that would
have to wait for the callbacks.

Overlayfs points the s_encoding of an overlay at the map of its first
layer without taking a reference of its own. That stays correct. The
layer is held by the overlay, so its map is dropped only after the
overlay is gone.

Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009-work-fixes-rcu-v1-6-7446d2d335e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index f313532f5e80..74a74a48dd8b 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/stringhash.h>
@@ -183,12 +184,24 @@ struct unicode_map *utf8_load(unsigned int version)
 }
 EXPORT_SYMBOL(utf8_load);
 
+static void utf8_unload_rcu(struct rcu_head *head)
+{
+	struct unicode_map *um = container_of(head, struct unicode_map, rcu);
+
+	symbol_put(utf8_data_table);
+	kfree(um);
+}
+
+/*
+ * A pathwalk in rcu mode may still be in ->d_hash() or ->d_compare() of a
+ * filesystem that is being torn down and read the map through its
+ * superblock, so the map and the tables it points to have to outlive the
+ * grace period.
+ */
 void utf8_unload(struct unicode_map *um)
 {
-	if (um) {
-		symbol_put(utf8_data_table);
-		kfree(um);
-	}
+	if (um)
+		call_rcu(&um->rcu, utf8_unload_rcu);
 }
 EXPORT_SYMBOL(utf8_unload);
 
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 64fa44fe180c..3a8cb603eb93 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -53,6 +53,7 @@ struct unicode_map {
 	unsigned int version;
 	const struct utf8data *ntab[UTF8_NMAX];
 	const struct utf8data_table *tables;
+	struct rcu_head rcu;
 };
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);

