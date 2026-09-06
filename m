Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4461FB1
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788705475; cv=none; b=QTp3h5BndgH4bekVsPfWK/uXrQuNKfebeRB+vzAiMG5QJaLKcWY0Pk/3rAhlMXj2wS1iuzpabbY6/VjtgnBIRj7mlscy2W9hlLX0QviWQz5mcSdx/z6HuUbcYc3Q0kurJcFUMwO72e+02tVLuKqNma646q28hTi4uxij1pA2gGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788705475; c=relaxed/simple;
	bh=3iSvgFm/n9QG25xp2lDKDFsTnMaHQ0Q9i+XhIKX1z0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvtJJk0T1a6ZRk6yBx61FdNAVL/QKgrHtfREnAfCadgyWwOHSa+7vOYYsPLOyS9H0qkTP0h/tjtWi45lQW7rbuVs+DpNy3FnPcauq9l6PEV9f97/idIJiIne94U6K6/dQuH0hsiCdGp2RWeW5gawF+ryNJDZZTrtocxtHnyS/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a34GPF08; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a34GPF08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFA81F00A3A;
	Sun,  6 Sep 2026 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788705474;
	bh=wOiDCvHLAcrxf7yPJ1icugicLEhFPEB3+slzoNFjutk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a34GPF08JWBYJZhxbwe5/bl52NJTs200J/GR3UQ+xE7IUW4X4PLtN3BOl5lGPZxKW
	 xP357pMvQauq+DTm21tmhH4N2bLO8hgknZl7S3YaKlPlm6fJZWJzHt15hTmcfHYZBa
	 1+ClhP9VfTE2VSp64jYFuYHSZMDYoud86oUpqZhraU0vS3JQ6fDwWs1H5A6myk/LAe
	 etDpGADUiv5EfpMCGr3oGLPLjFu42FC3lVNLmdCJysMQU+adqgmVrT5IsbLctDyt1c
	 EA7NVBiXUovPIaZZX1Z/jwn3eg246QMRDqUOjZFZTznKsQNofSo51fBG8YtFso6nob
	 U9t6Y9cQdrzdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ceph: cap delegated inode count in ceph_parse_deleg_inos()
Date: Sun,  6 Sep 2026 10:37:52 -0400
Message-ID: <20260906143752.1258918-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-clumsily-rug-0488@gregkh>
References: <2026090354-clumsily-rug-0488@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 4bd3158bd62466d57ed72a3f7bc5f205fedd6919 ]

ceph_parse_deleg_inos() decodes interval sets of delegated inode numbers
from an MDS create-with-delegation reply. For each set it reads a 64-bit
start and a 64-bit len with ceph_decode_64_safe(), which only validates
that the eight bytes are present in the message, not the value, and then
loops over len while inserting entries into s_delegated_inos.

len is fully attacker controlled. A malicious or compromised MDS can send
one huge interval, many intervals in one reply, duplicate intervals, or
repeated replies that accumulate delegated inodes on the same session.
The original code bounded none of these and could spin the insert loop or
grow the xarray without limit.

Bound both dimensions with a single enforcement point. Track the number
of delegated inodes held by each MDS session in an atomic counter and
grow it only in ceph_insert_deleg_ino(), which uses atomic_add_unless()
to refuse to push the count past CEPH_MAX_DELEG_INOS. Because that helper
is the only place the counter grows, the per-session population can never
exceed the cap, so no separate per-session pre-check is needed. The
counter is decremented when async create consumes a delegated inode or
when an insert fails, incremented when a delegated inode is restored,
initialized with the session xarray, and reset when reconnect destroys
the xarray.

A per-session cap alone still lets one reply spin the insert loop on
duplicate ranges without growing the counter, so also cap the aggregate
interval length accepted from a single reply. Together these bound both
the loop trip count per reply and the xarray population across replies.

The cap is a fixed, client-chosen constant rather than a value derived
from the MDS. mds_client_prealloc_inos is a userspace MDS configuration
option; it is never sent to the kernel client on the wire, and a
server-supplied bound could not be trusted for a defensive limit in any
case. The constant is set well above that option's documented default of
1000 (a generous multiple), so legitimate refill behavior is unaffected
while the CPU and xarray memory a malformed delegation stream can consume
stays bounded.

Impact: a malicious or compromised Ceph MDS can no longer make a client
spin through an unbounded delegated-inode interval or grow one session's
delegated-inode xarray without limit.

Cc: stable@vger.kernel.org
Fixes: d48464878708 ("ceph: decode interval_sets for delegated inos")
Suggested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ adapted counter reset placement to the older reconnect control flow ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 59 +++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.h      |  9 +++++++
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5f2b70b846e71..c1b48b46029d8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -570,10 +570,36 @@ static int parse_reply_info_filelock(void **p, void *end,
 
 #define DELEGATED_INO_AVAILABLE		xa_mk_value(1)
 
+static int ceph_insert_deleg_ino(struct ceph_mds_session *s, u64 ino)
+{
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
+	int err;
+
+	/*
+	 * Cap how many delegated inodes a single session may hold. This is
+	 * the only place that grows the count, so atomic_add_unless() bounds
+	 * it at exactly CEPH_MAX_DELEG_INOS; s_num_deleg_inos can never exceed
+	 * that.
+	 */
+	if (!atomic_add_unless(&s->s_num_deleg_inos, 1, CEPH_MAX_DELEG_INOS)) {
+		pr_warn_ratelimited_client(cl,
+			"MDS session already holds %d delegated inodes\n",
+			CEPH_MAX_DELEG_INOS);
+		return -EOVERFLOW;
+	}
+
+	err = xa_insert(&s->s_delegated_inos, ino, DELEGATED_INO_AVAILABLE,
+			GFP_KERNEL);
+	if (err)
+		atomic_dec(&s->s_num_deleg_inos);
+	return err;
+}
+
 static int ceph_parse_deleg_inos(void **p, void *end,
 				 struct ceph_mds_session *s)
 {
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
+	u64 msg_deleg_inos = 0;
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
@@ -591,16 +617,34 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 				start, len);
 			continue;
 		}
+
+		/*
+		 * Bound the number of inodes one reply may delegate.
+		 * ceph_insert_deleg_ino() separately caps the per-session
+		 * population, so this only has to stop one reply from spinning
+		 * the insert loop under an attacker-controlled len.
+		 */
+		if (len > (u64)CEPH_MAX_DELEG_INOS ||
+		    msg_deleg_inos > (u64)CEPH_MAX_DELEG_INOS - len) {
+			pr_warn_ratelimited_client(cl,
+				"MDS reply delegates too many inodes (have %llu, +%llu, max %d)\n",
+				msg_deleg_inos, len, CEPH_MAX_DELEG_INOS);
+			return -EIO;
+		}
+		msg_deleg_inos += len;
+
 		while (len--) {
-			int err = xa_insert(&s->s_delegated_inos, start++,
-					    DELEGATED_INO_AVAILABLE,
-					    GFP_KERNEL);
+			int err = ceph_insert_deleg_ino(s, start++);
+
 			if (!err) {
 				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
 				pr_warn_client(cl,
 					"MDS delegated inode 0x%llx more than once.\n",
 					start - 1);
+			} else if (err == -EOVERFLOW) {
+				/* ceph_insert_deleg_ino() already warned. */
+				return -EIO;
 			} else {
 				return err;
 			}
@@ -618,16 +662,17 @@ u64 ceph_get_deleg_ino(struct ceph_mds_session *s)
 
 	xa_for_each(&s->s_delegated_inos, ino, val) {
 		val = xa_erase(&s->s_delegated_inos, ino);
-		if (val == DELEGATED_INO_AVAILABLE)
+		if (val == DELEGATED_INO_AVAILABLE) {
+			atomic_dec(&s->s_num_deleg_inos);
 			return ino;
+		}
 	}
 	return 0;
 }
 
 int ceph_restore_deleg_ino(struct ceph_mds_session *s, u64 ino)
 {
-	return xa_insert(&s->s_delegated_inos, ino, DELEGATED_INO_AVAILABLE,
-			 GFP_KERNEL);
+	return ceph_insert_deleg_ino(s, ino);
 }
 #else /* BITS_PER_LONG == 64 */
 /*
@@ -1011,6 +1056,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	INIT_LIST_HEAD(&s->s_waiting);
 	INIT_LIST_HEAD(&s->s_unsafe);
 	xa_init(&s->s_delegated_inos);
+	atomic_set(&s->s_num_deleg_inos, 0);
 	INIT_LIST_HEAD(&s->s_cap_releases);
 	INIT_WORK(&s->s_cap_release_work, ceph_cap_release_work);
 
@@ -4908,6 +4954,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 		goto fail_nomsg;
 
 	xa_destroy(&session->s_delegated_inos);
+	atomic_set(&session->s_num_deleg_inos, 0);
 
 	mutex_lock(&session->s_mutex);
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 8987d0ff96252..3e4b074d03147 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -252,6 +252,7 @@ struct ceph_mds_session {
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
+	atomic_t	  s_num_deleg_inos;
 };
 
 /*
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d1defb6a9aefc..4cc60b403a845 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -623,6 +623,15 @@ static inline int ceph_ino_compare(struct inode *inode, void *data)
 #define CEPH_MDS_INO_LOG_OFFSET		(2 * CEPH_MAX_MDS)
 #define CEPH_INO_SYSTEM_BASE		((6*CEPH_MAX_MDS) + (CEPH_MAX_MDS * CEPH_NUM_STRAY))
 
+/*
+ * Upper bound on the number of delegated inodes a single MDS session may
+ * hold. The MDS normally hands out a small preallocation window (the
+ * userspace mds_client_prealloc_inos option defaults to 1000) and refills
+ * it as the client consumes entries. This leaves generous headroom while
+ * bounding the CPU and memory a malformed delegation interval can consume.
+ */
+#define CEPH_MAX_DELEG_INOS		8192
+
 static inline bool ceph_vino_is_reserved(const struct ceph_vino vino)
 {
 	if (vino.ino >= CEPH_INO_SYSTEM_BASE ||
-- 
2.53.0

