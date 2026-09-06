Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE74CCDE5
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709276; cv=none; b=cikz4MBGoSOhRT95yh3lFA0hO4wV+CvsZ9GtElLyMZSB516YPRqWdgi5f4DqiVxt5+23vO2pvhfKIdgI/hq9T9x8o67VR+ye68WkuKRU6bZxvTHMp7/UN9LePG2tYaVq6LMDDVDehMJNHvQ60frfXhb85I1jLQ3kLxLxtAAZmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709276; c=relaxed/simple;
	bh=qy3fNLpE0d7LcwSdSmCiVzRrjW2ivGqmeuhAsp5Owmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lm/z2/IJrYQZgnTScs72OuLTFVMlnFmvBndWNm4In0imTT1w3k6tKlCFR9cizg8SsMCpLqdq5wyKggqMTlOZEwJqSb+GWQ+pIsoqYNbXLZrk/Ld9pG1mV5rjjgcAh0lGhbv6+TIR3Vx8/kIJ8tHzrQEXHdA0V9hMsh9aGPdwJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCS/uWVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCS/uWVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B131F00A3A;
	Sun,  6 Sep 2026 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788709274;
	bh=XbX2+KiunDXpl9+ITvPNm8PhPXm9m7S6sg01VrNNrKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCS/uWVGhVRwBUf/MLbTbndd73WJkkXryCGw+jMjRP1P+P/pImxfKPd3lhBgzbNEc
	 hs/u8Aq8AtRvdXY/gwH8khrxYLYzgqYiUj87P83fAz3GgX4dT1oDHizNwIovl9f3Uq
	 F9W7/l44Wzl8AAl9ayzPRq2C7bv9GpjRzBxOC+/nZdzYdLMqjG195OZRMPPljJJZy5
	 IzhxMGRwqodbxfpRid1GFze3gDq5IPlqkvZkH+9lmsMZOQB/Swb3ZzGc0MpSC1xiFa
	 YldTpn3Se7JyPssF9Y2d2MbHLMPmZEo7OR47ILNyeykrduGniKGBLf8l5r32aQPRTp
	 lTryITGPkhrUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] ceph: remove unnecessary check for NULL in parse_longname()
Date: Sun,  6 Sep 2026 11:41:10 -0400
Message-ID: <20260906154112.1496479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090355-tradition-although-cffd@gregkh>
References: <2026090355-tradition-although-cffd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luís Henriques <lhenriques@suse.de>

[ Upstream commit 2816a09678f50fc6a69e742e90cb1fd7a9f1f9ff ]

Function ceph_get_inode() never returns NULL; instead it returns an
ERR_PTR() if something fails.  Thus, the check for NULL in parse_longname()
is useless and can be dropped.  Instead, move there the debug code that
does the error checking so that it's only executed if ceph_get_inode() is
called.

Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Stable-dependency adaptation: fs/ceph/crypto.c is not present in 6.1, so
drop the original hunk.  Instead, carry the minimal existing-code context
needed by the follow-up: use client-aware logging in the delegated-inode
parser, serialize the delegated-inode xarray teardown, and reject reconnects
for terminal sessions.  This gives the follow-up's counter reset a clean and
correct insertion point.

[ sashal: Reduced backport -- upstream 2816a09678f50 touches 1 file(s), this
  backport carries 1. Not backported here:
  fs/ceph/crypto.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 4bd3158bd624 ("ceph: cap delegated inode count in ceph_parse_deleg_inos()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 939f9e870de0a..4893545b930c3 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -433,6 +433,7 @@ static int parse_reply_info_filelock(void **p, void *end,
 static int ceph_parse_deleg_inos(void **p, void *end,
 				 struct ceph_mds_session *s)
 {
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
@@ -445,8 +446,9 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 
 		/* Don't accept a delegation of system inodes */
 		if (start < CEPH_INO_SYSTEM_BASE) {
-			pr_warn_ratelimited("ceph: ignoring reserved inode range delegation (start=0x%llx len=0x%llx)\n",
-					start, len);
+			pr_warn_ratelimited_client(cl,
+				"ignoring reserved inode range delegation (start=0x%llx len=0x%llx)\n",
+				start, len);
 			continue;
 		}
 		while (len--) {
@@ -454,10 +456,10 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 					    DELEGATED_INO_AVAILABLE,
 					    GFP_KERNEL);
 			if (!err) {
-				dout("added delegated inode 0x%llx\n",
-				     start - 1);
+				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
-				pr_warn("MDS delegated inode 0x%llx more than once.\n",
+				pr_warn_client(cl,
+					"MDS delegated inode 0x%llx more than once.\n",
 					start - 1);
 			} else {
 				return err;
@@ -4200,6 +4202,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *reply;
 	int mds = session->s_mds;
 	int err = -ENOMEM;
@@ -4218,9 +4221,21 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	if (!reply)
 		goto fail_nomsg;
 
+	mutex_lock(&session->s_mutex);
+
+	/* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
 	xa_destroy(&session->s_delegated_inos);
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
+	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
+		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
+			       mds,
+			       ceph_session_state_name(session->s_state));
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ESTALE;
+		goto fail_return;
+	}
 
-	mutex_lock(&session->s_mutex);
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
@@ -4361,6 +4376,10 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 fail_nopagelist:
 	pr_err("error %d preparing reconnect for mds%d\n", err, mds);
 	return;
+
+fail_return:
+	ceph_pagelist_release(recon_state.pagelist);
+	return;
 }
 
 
-- 
2.53.0

