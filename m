Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436F34F270
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373309; cv=none; b=GZCs6Y2TPY9cxBqSMoYVu5quAUBdEmbAMYEWgjRxzYjpE/fdxl3RHudKFD+b17cNsACBMwReMQEAnVZ8Oa8KXwahcr9S8hQqVROubWWtwR/YVLgFYTYEnvl3yvv7RCfaDjinZd54zp4OMJHC7PgP5LuGV7w9ORo3UkhyAYRUvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373309; c=relaxed/simple;
	bh=lo+URCPgbSZCAE8oy1GdxlLuSVqjo9MZQFAxDEM6etQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezXWE+HgWJP60w1S1o+3q8Y8oTKxwpwUcDhD2qoJxoMwUA/sWqrKte64v3I9AgqpzvcVpIuU9QrUUZnu7qCz6eKRqQAYVT1bK0VGSnXXIxyTQHjEEHOvvqoGu//fJ8WlTO0W05r5hFZp0rXG6Wx8xrGsQ6aajwP6HgKY/W357+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUd4cdJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUd4cdJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC93E1F00A3E;
	Thu, 30 Jul 2026 01:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373306;
	bh=qWPzpgUP/GNxhsXhL/fehYOP/GmBsbHL2MoIbnT8l94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nUd4cdJaTwO3NOufj5BMaY7hIcK/X0hAdCkFveWZ+p2grJTOI/sfRNRPFovJCwB32
	 pf1DhNeARgRxr3C6tcOT2hFcDDDq5+/BoaCWS4JgQ7n7lzynfHBd4lP8XuQe+bOL0M
	 1ma6+f4cSUcJ5VFby9/hABVDPUhaYMyfgIjSgtJRqi2zns+Cw9YID4zDmujWVSGLCo
	 ZfJcYsgof6HRowstUcmPHyOy+YVFjHwTfHynouOSG/bW6hL+kuoUDJS/gYB3jN2juq
	 /Ycgn5nmVQbLkSY/y6LA7sn0HeKsyepiCcgs9KucpqfR0YGKBcKIF6Q84pvnf2cR3l
	 pGlxlP4LZz1rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 8/8] afs: Fix dynamic lookup to fail on cell lookup failure
Date: Wed, 29 Jul 2026 21:01:37 -0400
Message-ID: <20260730010137.1700032-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730010137.1700032-1-sashal@kernel.org>
References: <2026072131-schilling-spectrum-ef97@gregkh>
 <20260730010137.1700032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 330e2c514823008b22e6afd2055715bc46dd8d55 ]

When a process tries to access an entry in /afs, normally what happens is
that an automount dentry is created by ->lookup() and then triggered, which
jumps through the ->d_automount() op.  Currently, afs_dynroot_lookup() does
not do cell DNS lookup, leaving that to afs_d_automount() to perform -
however, it is possible to use access() or stat() on the automount point,
which will always return successfully, have briefly created an afs_cell
record if one did not already exist.

This means that something like:

        test -d "/afs/.west" && echo Directory exists

will print "Directory exists" even though no such cell is configured.  This
breaks the "west" python module available on PIP as it expects this access
to fail.

Now, it could be possible to make afs_dynroot_lookup() perform the DNS[*]
lookup, but that would make "ls --color /afs" do this for each cell in /afs
that is listed but not yet probed.  kafs-client, probably wrongly, preloads
the entire cell database and all the known cells are then listed in /afs -
and doing ls /afs would be very, very slow, especially if any cell supplied
addresses but was wholly inaccessible.

 [*] When I say "DNS", actually read getaddrinfo(), which could use any one
     of a host of mechanisms.  Could also use static configuration.

To fix this, make the following changes:

 (1) Create an enum to specify the origination point of a call to
     afs_lookup_cell() and pass this value into that function in place of
     the "excl" parameter (which can be derived from it).  There are six
     points of origination:

        - Cell preload through /proc/net/afs/cells
        - Root cell config through /proc/net/afs/rootcell
        - Lookup in dynamic root
        - Automount trigger
        - Direct mount with mount() syscall
        - Alias check where YFS tells us the cell name is different

 (2) Add an extra state into the afs_cell state machine to indicate a cell
     that's been initialised, but not yet looked up.  This is separate from
     one that can be considered active and has been looked up at least
     once.

 (3) Make afs_lookup_cell() vary its behaviour more, depending on where it
     was called from:

     If called from preload or root cell config, DNS lookup will not happen
     until we definitely want to use the cell (dynroot mount, automount,
     direct mount or alias check).  The cell will appear in /afs but stat()
     won't trigger DNS lookup.

     If the cell already exists, dynroot will not wait for the DNS lookup
     to complete.  If the cell did not already exist, dynroot will wait.

     If called from automount, direct mount or alias check, it will wait
     for the DNS lookup to complete.

 (4) Make afs_lookup_cell() return an error if lookup failed in one way or
     another.  We try to return -ENOENT if the DNS says the cell does not
     exist and -EDESTADDRREQ if we couldn't access the DNS.

Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220685
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/1784747.1761158912@warthog.procyon.org.uk
Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")
Tested-by: Markus Suvanto <markus.suvanto@gmail.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/cell.c     | 78 +++++++++++++++++++++++++++++++++++++++--------
 fs/afs/dynroot.c  |  3 +-
 fs/afs/internal.h | 12 +++++++-
 fs/afs/mntpt.c    |  3 +-
 fs/afs/proc.c     |  3 +-
 fs/afs/super.c    |  2 +-
 fs/afs/vl_alias.c |  3 +-
 7 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 41f7e11c139711..b0bea806af749b 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -228,7 +228,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
  * @name:	The name of the cell.
  * @namesz:	The strlen of the cell name.
  * @vllist:	A colon/comma separated list of numeric IP addresses or NULL.
- * @excl:	T if an error should be given if the cell name already exists.
+ * @reason:	The reason we're doing the lookup
  * @trace:	The reason to be logged if the lookup is successful.
  *
  * Look up a cell record by name and query the DNS for VL server addresses if
@@ -238,7 +238,8 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
  */
 struct afs_cell *afs_lookup_cell(struct afs_net *net,
 				 const char *name, unsigned int namesz,
-				 const char *vllist, bool excl,
+				 const char *vllist,
+				 enum afs_lookup_cell_for reason,
 				 enum afs_cell_trace trace)
 {
 	struct afs_cell *cell, *candidate, *cursor;
@@ -246,12 +247,18 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	enum afs_cell_state state;
 	int ret, n;
 
-	_enter("%s,%s", name, vllist);
+	_enter("%s,%s,%u", name, vllist, reason);
 
-	if (!excl) {
+	if (reason != AFS_LOOKUP_CELL_PRELOAD) {
 		cell = afs_find_cell(net, name, namesz, trace);
-		if (!IS_ERR(cell))
+		if (!IS_ERR(cell)) {
+			if (reason == AFS_LOOKUP_CELL_DYNROOT)
+				goto no_wait;
+			if (cell->state == AFS_CELL_SETTING_UP ||
+			    cell->state == AFS_CELL_UNLOOKED)
+				goto lookup_cell;
 			goto wait_for_cell;
+		}
 	}
 
 	/* Assume we're probably going to create a cell and preallocate and
@@ -297,26 +304,69 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	rb_insert_color(&cell->net_node, &net->cells);
 	up_write(&net->cells_lock);
 
-	afs_queue_cell(cell, afs_cell_trace_queue_new);
+lookup_cell:
+	if (reason != AFS_LOOKUP_CELL_PRELOAD &&
+	    reason != AFS_LOOKUP_CELL_ROOTCELL) {
+		set_bit(AFS_CELL_FL_DO_LOOKUP, &cell->flags);
+		afs_queue_cell(cell, afs_cell_trace_queue_new);
+	}
 
 wait_for_cell:
-	_debug("wait_for_cell");
 	state = smp_load_acquire(&cell->state); /* vs error */
-	if (state != AFS_CELL_ACTIVE &&
-	    state != AFS_CELL_DEAD) {
+	switch (state) {
+	case AFS_CELL_ACTIVE:
+	case AFS_CELL_DEAD:
+		break;
+	case AFS_CELL_UNLOOKED:
+	default:
+		if (reason == AFS_LOOKUP_CELL_PRELOAD ||
+		    reason == AFS_LOOKUP_CELL_ROOTCELL)
+			break;
+		_debug("wait_for_cell");
 		afs_see_cell(cell, afs_cell_trace_wait);
 		wait_var_event(&cell->state,
 			       ({
 				       state = smp_load_acquire(&cell->state); /* vs error */
 				       state == AFS_CELL_ACTIVE || state == AFS_CELL_DEAD;
 			       }));
+		_debug("waited_for_cell %d %d", cell->state, cell->error);
 	}
 
+no_wait:
 	/* Check the state obtained from the wait check. */
+	state = smp_load_acquire(&cell->state); /* vs error */
 	if (state == AFS_CELL_DEAD) {
 		ret = cell->error;
 		goto error;
 	}
+	if (state == AFS_CELL_ACTIVE) {
+		switch (cell->dns_status) {
+		case DNS_LOOKUP_NOT_DONE:
+			if (cell->dns_source == DNS_RECORD_FROM_CONFIG) {
+				ret = 0;
+				break;
+			}
+			fallthrough;
+		default:
+			ret = -EIO;
+			goto error;
+		case DNS_LOOKUP_GOOD:
+		case DNS_LOOKUP_GOOD_WITH_BAD:
+			ret = 0;
+			break;
+		case DNS_LOOKUP_GOT_NOT_FOUND:
+			ret = -ENOENT;
+			goto error;
+		case DNS_LOOKUP_BAD:
+			ret = -EREMOTEIO;
+			goto error;
+		case DNS_LOOKUP_GOT_LOCAL_FAILURE:
+		case DNS_LOOKUP_GOT_TEMP_FAILURE:
+		case DNS_LOOKUP_GOT_NS_FAILURE:
+			ret = -EDESTADDRREQ;
+			goto error;
+		}
+	}
 
 	_leave(" = %p [cell]", cell);
 	return cell;
@@ -324,7 +374,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 cell_already_exists:
 	_debug("cell exists");
 	cell = cursor;
-	if (excl) {
+	if (reason == AFS_LOOKUP_CELL_PRELOAD) {
 		ret = -EEXIST;
 	} else {
 		afs_use_cell(cursor, trace);
@@ -383,7 +433,8 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 		return -EINVAL;
 
 	/* allocate a cell record for the root/workstation cell */
-	new_root = afs_lookup_cell(net, rootcell, len, vllist, false,
+	new_root = afs_lookup_cell(net, rootcell, len, vllist,
+				   AFS_LOOKUP_CELL_ROOTCELL,
 				   afs_cell_trace_use_lookup_ws);
 	if (IS_ERR(new_root)) {
 		_leave(" = %ld", PTR_ERR(new_root));
@@ -778,6 +829,7 @@ static bool afs_manage_cell(struct afs_cell *cell)
 	switch (cell->state) {
 	case AFS_CELL_SETTING_UP:
 		goto set_up_cell;
+	case AFS_CELL_UNLOOKED:
 	case AFS_CELL_ACTIVE:
 		goto cell_is_active;
 	case AFS_CELL_REMOVING:
@@ -798,7 +850,7 @@ static bool afs_manage_cell(struct afs_cell *cell)
 		goto remove_cell;
 	}
 
-	afs_set_cell_state(cell, AFS_CELL_ACTIVE);
+	afs_set_cell_state(cell, AFS_CELL_UNLOOKED);
 
 cell_is_active:
 	if (afs_has_cell_expired(cell, &next_manage))
@@ -808,6 +860,8 @@ static bool afs_manage_cell(struct afs_cell *cell)
 		ret = afs_update_cell(cell);
 		if (ret < 0)
 			cell->error = ret;
+		if (cell->state == AFS_CELL_UNLOOKED)
+			afs_set_cell_state(cell, AFS_CELL_ACTIVE);
 	}
 
 	if (next_manage < TIME64_MAX && cell->net->live) {
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 8c6130789fde3a..dc9d29e3739e71 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -108,7 +108,8 @@ static struct dentry *afs_dynroot_lookup_cell(struct inode *dir, struct dentry *
 		dotted = true;
 	}
 
-	cell = afs_lookup_cell(net, name, len, NULL, false,
+	cell = afs_lookup_cell(net, name, len, NULL,
+			       AFS_LOOKUP_CELL_DYNROOT,
 			       afs_cell_trace_use_lookup_dynroot);
 	if (IS_ERR(cell)) {
 		ret = PTR_ERR(cell);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6630a6144b719b..244f8c9080dac9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -353,6 +353,7 @@ extern const char afs_init_sysname[];
 
 enum afs_cell_state {
 	AFS_CELL_SETTING_UP,
+	AFS_CELL_UNLOOKED,
 	AFS_CELL_ACTIVE,
 	AFS_CELL_REMOVING,
 	AFS_CELL_DEAD,
@@ -1034,9 +1035,18 @@ static inline bool afs_cb_is_broken(unsigned int cb_break,
 extern int afs_cell_init(struct afs_net *, const char *);
 extern struct afs_cell *afs_find_cell(struct afs_net *, const char *, unsigned,
 				      enum afs_cell_trace);
+enum afs_lookup_cell_for {
+	AFS_LOOKUP_CELL_DYNROOT,
+	AFS_LOOKUP_CELL_MOUNTPOINT,
+	AFS_LOOKUP_CELL_DIRECT_MOUNT,
+	AFS_LOOKUP_CELL_PRELOAD,
+	AFS_LOOKUP_CELL_ROOTCELL,
+	AFS_LOOKUP_CELL_ALIAS_CHECK,
+};
 struct afs_cell *afs_lookup_cell(struct afs_net *net,
 				 const char *name, unsigned int namesz,
-				 const char *vllist, bool excl,
+				 const char *vllist,
+				 enum afs_lookup_cell_for reason,
 				 enum afs_cell_trace trace);
 extern struct afs_cell *afs_use_cell(struct afs_cell *, enum afs_cell_trace);
 void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 8ebac8c030952e..37419d4aae43f3 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -107,7 +107,8 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		if (size > AFS_MAXCELLNAME)
 			return -ENAMETOOLONG;
 
-		cell = afs_lookup_cell(ctx->net, p, size, NULL, false,
+		cell = afs_lookup_cell(ctx->net, p, size, NULL,
+				       AFS_LOOKUP_CELL_MOUNTPOINT,
 				       afs_cell_trace_use_lookup_mntpt);
 		if (IS_ERR(cell)) {
 			pr_err("kAFS: unable to lookup cell '%pd'\n", mntpt);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 40e879c8ca773f..44520549b509a1 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -122,7 +122,8 @@ static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
 	if (strcmp(buf, "add") == 0) {
 		struct afs_cell *cell;
 
-		cell = afs_lookup_cell(net, name, strlen(name), args, true,
+		cell = afs_lookup_cell(net, name, strlen(name), args,
+				       AFS_LOOKUP_CELL_PRELOAD,
 				       afs_cell_trace_use_lookup_add);
 		if (IS_ERR(cell)) {
 			ret = PTR_ERR(cell);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index feb81729bd3dbe..89787b0e3c136e 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -290,7 +290,7 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 	/* lookup the cell record */
 	if (cellname) {
 		cell = afs_lookup_cell(ctx->net, cellname, cellnamesz,
-				       NULL, false,
+				       NULL, AFS_LOOKUP_CELL_DIRECT_MOUNT,
 				       afs_cell_trace_use_lookup_mount);
 		if (IS_ERR(cell)) {
 			pr_err("kAFS: unable to lookup cell '%*.*s'\n",
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 709b4cdb723eea..fc9676abd2527a 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -269,7 +269,8 @@ static int yfs_check_canonical_cell_name(struct afs_cell *cell, struct key *key)
 	if (!name_len || name_len > AFS_MAXCELLNAME)
 		master = ERR_PTR(-EOPNOTSUPP);
 	else
-		master = afs_lookup_cell(cell->net, cell_name, name_len, NULL, false,
+		master = afs_lookup_cell(cell->net, cell_name, name_len, NULL,
+					 AFS_LOOKUP_CELL_ALIAS_CHECK,
 					 afs_cell_trace_use_lookup_canonical);
 	kfree(cell_name);
 	if (IS_ERR(master))
-- 
2.53.0

