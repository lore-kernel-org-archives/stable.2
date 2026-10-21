Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583237;
	b=zSMhmXtD6jci4QzNSZEZ+rEig5j1Ws7mMXNOXL4iRiNCKiOLlRbyBiUAJXaY0YT8OxDZ
	 QLG/8gQd2DbN3tvix5wSeKLdBbn90G1LJ921pw3eTGyemqG49wW6AJNa6X3N4Qi+UEjth
	 91oZkOgMbXmvfoIF0vf4+E5EaVwdRZl9rmDsykRSh9+Xs0OIo/1ThUFzunt4SdURP4KTl
	 9IS5Pfy+m6il3sv2QdQiqAVuldZvuwcDSOPqBkRrTTwqKesUYvrPfos2JzJ097HgSqEyW
	 0bXV7fVbEO6jwkA+wnogWsE7/sCgimESWG+tTxLwiFAG59Jc5xFhmOE6NILdI2mL9Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583237;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fU1AkNuN4IrDtX3w/8xHJYtokhgNk5JLHyI0WEC05pg=;
	b=DVNN6a6UBvrAjniEuLAbvPYsrGKpEEAlT49ZehNHsqj3zXGoC5z2ymqkDknmJjvRPQqe
	 2CX5JZFeGj07mKnt1YtJ7m6Ri/kL4Vl+LDpYa34E8MjC872LWbJBWVWapSOziR0WvwqCv
	 kQYwploI0I3mf40j5SQ9VdOHwi0E5ekoPwDXYCe1A+K0NWbFZVAtIlCcG7ZBJN0fl9cwI
	 U8B3AS8+vO4lxAWHZSQTIoAf5Y83wD+HtwLNqbLGuMq4B7FNbFaUThCD39/ywezibZUSG
	 2zzEsrBxWaRhHu0X9/O6EiVoD1DRqxdFRmrWe+rL5LDRtghT+o0EytmzohWP8W3cQLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZfUpVKY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413F606A330;
	Wed, 21 Oct 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZfUpVKY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943911F000C4;
	Wed, 21 Oct 2026 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583236;
	bh=fU1AkNuN4IrDtX3w/8xHJYtokhgNk5JLHyI0WEC05pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CZfUpVKYqagzbLGhuy43IqexkMQWl1N1YpPa8n29sXgv2JsIF+Nx8GUEzUf/FsPUD
	 ABxuO0SENHcz6F2Z4XtSGqfBIJxUCwC1eBRBxA2NQnWqQfIdIBcYJHvkNa/LIeDMue
	 q6iBOgUNrtaDuIv0ODTQhZOCvebAVsvoAHtDtBKxCF+PxyAmgU7DZX5PE94Y+udiKC
	 Xl8Pwr+nysl42TPVqjSma+8YXwHVlO1asDwYQLJ8Y/OzBuMnM8wRazYqAFGGz5E5Zg
	 zMy+Q6y9w2HjogZcBtfqeSagdVY85UR7Eq3qqyn8Hf/Uywi+yUGfg4SDzjSWLxmT0x
	 CuIy3r5v1+w3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Oct 2026 13:46:58 +0200
Subject: [PATCH 5/6] listns: don't wrap around with a U64_MAX cursor
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-work-mount-statmount_listns_fixes-v1-5-8917a4c1bd14@kernel.org>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6641; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fonDJooPIga81SzmsUjn/L6dVa3zX+Y4OXEulF5C0SI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWGYS/jOuz457F/frFFmxuu31ax2Oq8gdKTy51O2Fw
 JNVvLsLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS8Zbhv3td0nS5CUH/NLxO
 T4l7JKz45USwplTCs1jXRE8u+zVVMxkZNvvanV28QjrNvv31TalNd9Q+dLAwlM2eMOX0fIO0X78
 rWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_listns() and do_listns_userns() take the last namespace id the caller
saw and look up the first namespace after it by searching the rbtree for
last_ns_id + 1. With U64_MAX that wraps around to zero and the search
returns the namespace with the smallest id. So a cursor at the largest
possible id restarts the listing from the beginning instead of failing
with ENOENT like a cursor of U64_MAX - 1 does. That's the case for the
unified tree, the type-specific trees and the owner tree alike.

No namespace will ever have that id. They come from a counter and a
caller that only feeds back ids it got from us can't hit this. It's
still wrong.

Instead of adding one to the cursor and searching for the smallest id
that's greater or equal make the lookup helpers search for the smallest
id that's strictly greater than the cursor. That's what both callers
want anyway and there's nothing left to overflow.

Reproducer, unprivileged:

    #define _GNU_SOURCE
    #include <errno.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <sys/syscall.h>
    #include <unistd.h>
    #ifndef __NR_listns
    #define __NR_listns 470
    #endif
    #define CLONE_NEWUSER		0x10000000U
    #define LISTNS_CURRENT_USER	0xffffffffffffffffULL
    struct ns_id_req {
    	uint32_t size, spare;
    	uint64_t ns_id;
    	uint32_t ns_type, spare2;
    	uint64_t user_ns_id;
    };
    static void list(const char *tree, uint32_t type, uint64_t owner,
    		 uint64_t cursor)
    {
    	struct ns_id_req req = {
    		.size = sizeof(req), .ns_id = cursor, .ns_type = type,
    		.user_ns_id = owner,
    	};
    	uint64_t ids[8];
    	long ret;
    	errno = 0;
    	ret = syscall(__NR_listns, &req, ids, 8, 0);
    	printf("%s cursor %llu: ret %ld errno %d", tree,
    	       (unsigned long long)cursor, ret, errno);
    	for (long i = 0; i < ret && i < 3; i++)
    		printf("%s%llu", i ? "," : " ids ", (unsigned long long)ids[i]);
    	printf("%s\n", ret > 3 ? ",..." : "");
    }
    int main(void)
    {
    	static const uint64_t cursors[] = { 0, UINT64_MAX - 1, UINT64_MAX };
    	for (int i = 0; i < 3; i++)
    		list("unified", 0, 0, cursors[i]);
    	for (int i = 0; i < 3; i++)
    		list("userns", CLONE_NEWUSER, 0, cursors[i]);
    	for (int i = 0; i < 3; i++)
    		list("owner", 0, LISTNS_CURRENT_USER, cursors[i]);
    	return 0;
    }

Before, on 7.3.0-rc7-00252-g4e3259b08c54 (vfs.fixes) in a VM:

    unified cursor 0: ret 8 errno 0 ids 1,2,3,...
    unified cursor 18446744073709551614: ret -1 errno 2
    unified cursor 18446744073709551615: ret 8 errno 0 ids 1,2,3,...
    userns cursor 0: ret 1 errno 0 ids 3
    userns cursor 18446744073709551614: ret -1 errno 2
    userns cursor 18446744073709551615: ret 1 errno 0 ids 3
    owner cursor 0: ret 8 errno 0 ids 1,2,4,...
    owner cursor 18446744073709551614: ret -1 errno 2
    owner cursor 18446744073709551615: ret 8 errno 0 ids 1,2,4,...

After:

    unified cursor 0: ret 8 errno 0 ids 1,2,3,...
    unified cursor 18446744073709551614: ret -1 errno 2
    unified cursor 18446744073709551615: ret -1 errno 2
    userns cursor 0: ret 1 errno 0 ids 3
    userns cursor 18446744073709551614: ret -1 errno 2
    userns cursor 18446744073709551615: ret -1 errno 2
    owner cursor 0: ret 8 errno 0 ids 1,2,4,...
    owner cursor 18446744073709551614: ret -1 errno 2
    owner cursor 18446744073709551615: ret -1 errno 2

Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/r/20261020110732.959552-1-shawnq1@163.com
Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/nstree.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 831f279d174a..58b2b55fa8d2 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -459,10 +459,10 @@ static inline int prepare_klistns(struct klistns *kls, struct ns_id_req *kreq,
 }
 
 /*
- * Lookup a namespace owned by owner with id >= ns_id.
- * Returns the namespace with the smallest id that is >= ns_id.
+ * Lookup a namespace owned by owner with id > ns_id.
+ * Returns the namespace with the smallest id that is > ns_id.
  */
-static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
+static struct ns_common *lookup_ns_owner_after(u64 ns_id, struct ns_common *owner)
 {
 	struct ns_common *ret = NULL;
 	struct rb_node *node;
@@ -476,10 +476,8 @@ static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
 		struct ns_common *ns;
 
 		ns = node_to_ns_owner(node);
-		if (ns_id <= ns->ns_id) {
+		if (ns_id < ns->ns_id) {
 			ret = ns;
-			if (ns_id == ns->ns_id)
-				break;
 			node = node->rb_left;
 		} else {
 			node = node->rb_right;
@@ -565,7 +563,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
 	 * then use it's list entry to iterate from there.
 	 */
 	if (kls->last_ns_id) {
-		kls->first_ns = lookup_ns_owner_at(kls->last_ns_id + 1, ns);
+		kls->first_ns = lookup_ns_owner_after(kls->last_ns_id, ns);
 		if (!kls->first_ns)
 			return -ENOENT;
 		first_ns = kls->first_ns;
@@ -613,10 +611,10 @@ static ssize_t do_listns_userns(struct klistns *kls)
 }
 
 /*
- * Lookup a namespace with id >= ns_id in either the unified tree or a type-specific tree.
- * Returns the namespace with the smallest id that is >= ns_id.
+ * Lookup a namespace with id > ns_id in either the unified tree or a type-specific tree.
+ * Returns the namespace with the smallest id that is > ns_id.
  */
-static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
+static struct ns_common *lookup_ns_id_after(u64 ns_id, int ns_type)
 {
 	struct ns_common *ret = NULL;
 	struct ns_tree_root *ns_tree = NULL;
@@ -643,13 +641,8 @@ static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
 		else
 			ns = node_to_ns_unified(node);
 
-		if (ns_id <= ns->ns_id) {
-			if (ns_type)
-				ret = node_to_ns(node);
-			else
-				ret = node_to_ns_unified(node);
-			if (ns_id == ns->ns_id)
-				break;
+		if (ns_id < ns->ns_id) {
+			ret = ns;
 			node = node->rb_left;
 		} else {
 			node = node->rb_right;
@@ -708,7 +701,7 @@ static ssize_t do_listns(struct klistns *kls)
 	}
 
 	if (kls->last_ns_id) {
-		kls->first_ns = lookup_ns_id_at(kls->last_ns_id + 1, ns_type);
+		kls->first_ns = lookup_ns_id_after(kls->last_ns_id, ns_type);
 		if (!kls->first_ns)
 			return -ENOENT;
 		first_ns = kls->first_ns;

-- 
2.53.0

