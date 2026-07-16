Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379E42EEA9
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226140; cv=none; b=aoo9K+a8pOMVe5govkPfXLw8X+9zSdB4SpsZJC0A77FaHQOlYL0wSWLvFBoq2LtZny4AQlhbmZvw/Wkxs3G7NWeH11Jj8Tpd1MwpAhzhkLqXi3/CvN9GPcxGsPz3QO47V8gCRk39u4YUhYIxarwh+yJ0VlVLB2ThWYfR4YVEPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226140; c=relaxed/simple;
	bh=ud2tgaDNLYGjIF+j32tSIQ+nMPm5oHeUnagNGOv7H20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kR9EinjPeVvo74dFyZZtNmf4I5Rg/RTsbUXhGIG8kfo3jOQAz767d+AhSvhADP9q0/YtBX7oZTRlWJrz36UV+Xwy+7jgJ6B/4pnvg9mG3P+7DS2Rhk5gZLlzbfVGEFlqe3EyE5f6VYqStpIQM44iKcYp4fRBZHyzQaUj4ZZfbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0W4J/T/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0W4J/T/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0DC1F00ADB;
	Thu, 16 Jul 2026 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226131;
	bh=WSfN8fr8LaXGDyMKyN/zdaiOm8xjuaTRWsCRV1Sk3+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0W4J/T/mam98L0xbY24Tyh0C7rF4AGIsKcNCMng5OjxSkARr9gWf0FTdwgZnfvR7
	 BDrUjphk6CP9wA2o1T1G48GDA4Q+RIHyHRKrYZgFLtZ8LQlSyjFTCthzvzL/p+PUhp
	 HG5lqI2USWfKpyiRB5Bbrnh/ddzSciq1B71AnAyHmQpVt3DffwlmZCzKIhDxvHgVQe
	 skeAhmjaYHYJk2PHEzMevJiD5Uvh7Z6w4F9lXj/mtBWHmoDJVi/eKUCImPQkQE9f2Y
	 GMn3wesOLg7i4F4rkA3ykVid3XYICAC6/+oQWsNMTBWphhGnyqtvmWi1NgD4IkI31Y
	 MN+mRpVrjpmmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/7] ksmbd: destroy async_ida in ksmbd_conn_free()
Date: Thu, 16 Jul 2026 14:22:03 -0400
Message-ID: <20260716182205.921233-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716182205.921233-1-sashal@kernel.org>
References: <2026071415-rambling-chooser-b760@gregkh>
 <20260716182205.921233-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit b32c8db48212a34998c36d0bbc05b29d5c407ef5 ]

When per-connection async_ida was converted from a dynamically
allocated ksmbd_ida to an embedded struct ida, ksmbd_ida_free() was
removed from the connection teardown path but no matching
ida_destroy() was added.  The connection is therefore freed with the
IDA's backing xarray still intact.

The kernel IDA API expects ida_init() and ida_destroy() to be paired
over an object's lifetime, so add the missing cleanup before the
connection is freed.

No leak has been observed in testing; this is a pairing fix to match
the IDA lifetime rules, not a response to a reproduced regression.

Fixes: d40012a83f87 ("cifsd: declare ida statically")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: c1016dd1d8b2 ("ksmbd: track the connection owning a byte-range lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/connection.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 524caba512e79a..bfc3154175c77d 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -40,6 +40,7 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
 	kfree(conn->mechToken);
+	ida_destroy(&conn->async_ida);
 	kfree(conn);
 }
 
-- 
2.53.0

