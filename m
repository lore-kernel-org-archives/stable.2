Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B133C1BE
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786188335; cv=none; b=pu+PaqaxPLhA6hgVfQHecqqEwt8ijQjZ/PCgZ9VWh2r0kCwSHnOG3ytzjLD2a4Y3TNMf2qV7ovXi/OOYnZdB59EAWWRGyWVjbNDN1xUh4PgOaq5MO28jNeQHlNJk0/1eEyOVOFXkMlxCqu6gQkAln0c8/S+S0GLoTUB97f+VHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786188335; c=relaxed/simple;
	bh=IyrLD+xOFGegidxPyTKb2SJKhYGf8XZnAXwmn3D7l4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9kPhe65DCwNXXwPCEj4rw5xHB/HXvFd4UbuaLSfQgYRaLKhPh7Z+jjeKjR05vaKZSyMtDM8+FFU2GNZsXB8T++hCtiJ5VKbk13TlGsyebqu6nRU1LCZbFHLKJ6ZxP3o7fZ/68cJ9M2xdIu9YQuJfn/Ih3ixNd1Ayjd32qIgmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFwnYq6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFwnYq6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96921F000E9;
	Sat,  8 Aug 2026 11:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786188334;
	bh=92AbvF1fdfv5VQPfXd7FU6e6xgX6YeJMiU0+N3WLGRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aFwnYq6DOZqGwsRwF7vxc5uGznito8/5k+fHmXozhHRKVN8uxScmez1cxPacuqGm0
	 SeF2/ZuxcntdVxgOem/ixQ6C5lC7OxAEV+qCWB9yIuw9AknW+cpwDX1wo3rkkLXD6m
	 6AWFx3jY66t+xABI7O+xpyXD+kYGSPIG1XFwhFlC02IL4GdO86ZC7wyuY9qiYxHl3/
	 oOx5zhwuroCGBXtscIQlwsjt+rDJwgoPt9vOTaOiJFZjdqdhKjetBcAkzfQJNGDB8V
	 yvzVxD/9p2ANQO7mCK0RFQEZSvFIHF3CQqSnzSpwL3OoholyR4ae/yw4NA3U9f0yws
	 JuwyhanW59zFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] libceph: fix two unsafe bare decodes in decode_lockers()
Date: Sat,  8 Aug 2026 07:25:31 -0400
Message-ID: <20260808112531.101285-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072947-glitter-prevalent-2aff@gregkh>
References: <2026072947-glitter-prevalent-2aff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavitra Jha <jhapavitra98@gmail.com>

[ Upstream commit a109a556115271ca7896dcda7b4b7e45e156c227 ]

decode_lockers() in cls_lock_client.c contains two bare decode operations
that allow a malicious or compromised OSD to trigger slab-out-of-bounds
reads:

1. ceph_decode_32(p) at the num_lockers field has no preceding bounds
   check. ceph_start_decoding() accepts struct_len=0 as valid -- the
   internal ceph_decode_need(p, end, 0, bad) always passes -- so when an
   OSD sends struct_len=0, ceph_start_decoding() returns success with
   p == end. The immediately following bare ceph_decode_32(p) then reads
   4 bytes past the validated buffer boundary. The garbage value is
   passed directly to kzalloc_objs() as the locker count.

   The sibling function decode_watchers() in osd_client.c already uses
   ceph_decode_32_safe() after its own ceph_start_decoding() call.
   decode_lockers() was the only site using the bare variant.

2. ceph_decode_8(p) after the decode_locker() loop has no preceding
   bounds check. If an OSD crafts num_lockers such that the loop
   advances p exactly to end, the subsequent bare ceph_decode_8(p) reads
   one byte past the validated buffer boundary. The result is passed
   directly into *type, which is used as a lock type discriminator by
   callers, giving an OSD-controlled one-byte OOB read with direct
   influence over the lock type field.

Fix both by replacing bare operations with their safe variants:
  ceph_decode_32(p) -> ceph_decode_32_safe(p, end, *num_lockers,
                                           err_inval)
  ceph_decode_8(p)  -> ceph_decode_8_safe(p, end, *type,
                                          err_free_lockers)

The goto targets differ intentionally:
  err_inval: is a new label returning -EINVAL directly. It is used for
  the pre-allocation failure path where *lockers is not yet allocated
  and must not be passed to ceph_free_lockers().

  err_free_lockers: is the existing label. It is used for the
  post-allocation failure path where *lockers is allocated and must
  be freed.

ret is set to -EINVAL before ceph_decode_8_safe() so that
err_free_lockers returns the correct error code on bounds violation.
Without this, err_free_lockers would return a stale ret value (0 from
the successful decode_locker() loop), silently swallowing the error.

-EINVAL is correct for both failure paths. The data received from the
OSD is structurally malformed. -ENOMEM would misrepresent the failure
class to callers and to stable@ backporters triaging error paths.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment can trigger this against any kernel client that issues the
lock.get_info class method (e.g. during RBD exclusive lock acquisition).

[ idryomov: trim changelog, formatting ]

Cc: stable@vger.kernel.org
Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/cls_lock_client.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 66136a4c1ce7f..639793597b76c 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -299,7 +299,7 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	if (ret)
 		return ret;
 
-	*num_lockers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_lockers, err_inval);
 	*lockers = kcalloc(*num_lockers, sizeof(**lockers), GFP_NOIO);
 	if (!*lockers)
 		return -ENOMEM;
@@ -310,7 +310,8 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 			goto err_free_lockers;
 	}
 
-	*type = ceph_decode_8(p);
+	ret = -EINVAL;
+	ceph_decode_8_safe(p, end, *type, err_free_lockers);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s)) {
 		ret = PTR_ERR(s);
@@ -320,6 +321,9 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	*tag = s;
 	return 0;
 
+err_inval:
+	return -EINVAL;
+
 err_free_lockers:
 	ceph_free_lockers(*lockers, *num_lockers);
 	return ret;
-- 
2.53.0

