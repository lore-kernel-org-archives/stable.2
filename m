Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD2355819;
	Sat, 30 May 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173946; cv=none; b=lzqvRYlPuNIxfq/6CCUTboQP4t+gW+nRhYueXooS88UxyI3q6dYeXb985bnqgW9/DbOHBctQIzJMJ6hkMQqfqNdmqG47VvUKnVNjmDeVDSCsxs7Ieca/Jy9ZMZ6bMvs5ebNqBYUo7YBJm/rtiEHTNNIUphS6GEnuaYzOJlZ7wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173946; c=relaxed/simple;
	bh=ivtVcWkO/v1V1f72OYLD+Kr2+OjL1goztC6IflZtIec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdXwl5EIa4MxbnS5DIAK6Cg2XmIkF8w7SbI7dAknyIZFlRB8wTi0vtUcbXfnBsJIKLHS62bQ4HQX0bsD/jPoV7F1uk5M5hCAHz5/ktQ+MwNMqNj8DT//+XKtRelB+d31o1HyzF8woY177+3tjtRyXYpd/LDPFoiMgGzG7aL34Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYOSuZWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYOSuZWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FDE1F00899;
	Sat, 30 May 2026 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173945;
	bh=tLisUHuKI53t4eaaqFPc74kLG5u7gVAwhsx0GXoeEZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nYOSuZWmhUpCeb6hMb+cbFkSs/leMZbl0EuvXMSUfCptHK9KScwImprs98DvXhaVr
	 HbqDhAlqkiC47en1owjn3NI+RALPJRr4z+SZR/Q/VvBj/LBN+hv0xY4ZXPCpUawbee
	 LLDcmMgwgEYB4Zd5Brq2JBBMBUC6a/jk4Ltw+pduYcdJMrRApRlOCcJD7l6524T4p+
	 RpKLooU1YVTs7l4ohw1aRvlT8ETYMOIKF7KY7s1W59eblp9hu4nkVxv/ugmv3spE9z
	 q0OwGZ3cLFechYELp6+/H4Dcfeh3QSyI6sg5GK7j2CAq4lBtTYeQFRybCdX0+qsiAx
	 Q30jYqTEXWPvA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 4/4] misc: fastrpc: fix use-after-free race in fastrpc_map_create
Date: Sat, 30 May 2026 21:45:28 +0100
Message-ID: <20260530204528.116920-5-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204528.116920-1-srini@kernel.org>
References: <20260530204528.116920-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenghang Xiao <kipreyyy@gmail.com>

fastrpc_map_lookup returns a raw pointer after releasing fl->lock. The
caller fastrpc_map_create then calls fastrpc_map_get (kref_get_unless_zero)
on this unprotected pointer. A concurrent MEM_UNMAP can free the map
between the lock release and the kref operation, resulting in a
use-after-free on the freed slab object.

Restore the take_ref parameter to fastrpc_map_lookup so the reference
is acquired atomically under fl->lock before the pointer is exposed to
the caller.

Fixes: 10df039834f8 ("misc: fastrpc: Skip reference for DMA handles")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 47cf3d21b51d..f3a49384586d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -388,7 +388,7 @@ static int fastrpc_map_get(struct fastrpc_map *map)
 
 
 static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
-			    struct fastrpc_map **ppmap)
+			    struct fastrpc_map **ppmap, bool take_ref)
 {
 	struct fastrpc_map *map = NULL;
 	struct dma_buf *buf;
@@ -403,6 +403,12 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 		if (map->fd != fd || map->buf != buf)
 			continue;
 
+		if (take_ref) {
+			ret = fastrpc_map_get(map);
+			if (ret)
+				break;
+		}
+
 		*ppmap = map;
 		ret = 0;
 		break;
@@ -920,19 +926,10 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
-	struct fastrpc_session_ctx *sess = fl->sctx;
-	int err = 0;
-
-	if (!fastrpc_map_lookup(fl, fd, ppmap)) {
-		if (!fastrpc_map_get(*ppmap))
-			return 0;
-		dev_dbg(sess->dev, "%s: Failed to get map fd=%d\n",
-			__func__, fd);
-	}
-
-	err = fastrpc_map_attach(fl, fd, len, attr, ppmap);
+	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
+		return 0;
 
-	return err;
+	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
 }
 
 /*
@@ -1202,7 +1199,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
-		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap))
+		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
 			fastrpc_map_put(mmap);
 	}
 
-- 
2.53.0

