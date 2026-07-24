Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C8471CE7;
	Fri, 24 Jul 2026 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932436; cv=none; b=FlL6oP9EbOC2CEco1HbFKEJ0SXcincnTTicZjwDHZ8fZrvjXsLQFAz4obS90ST1ToAhimGlv4X+T8QGGjbjkAXobfyrVs4ApMu3C4yeMAqz504uSLLqLx5hWcqL9Pt63xYhzUEOkpinezaTI6OBaAE4ACfX8wWeTH4ybqVRiq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932436; c=relaxed/simple;
	bh=PUeOkzZuAYY/8odiO0Mm3JnDtUkPjjC+85qgirmGOmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4NAS7S8FtSXAFFBeyb2OFjbE+UqzU5DorzTTM6VPqHRP3NwfUMiIrm4m4Im3aqXGoEu7mOsTRRbY+k84xg+B/xa/EeZQb0aKPchsu8cqSFgYh0h/rVHAo/S4Ez8RPx1HNHS9kphC4oV6HOjehiah4C6FjFjJJS6AqpzOtvrwjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUGLBwRP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUGLBwRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624BE1F000E9;
	Fri, 24 Jul 2026 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932431;
	bh=FJWB2LGl36ZCSAJ9K238RNzndOpMva91W3SzDFj9ZgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUGLBwRPY/U8pNewb5HiIQiGzkkO0TQYh6NiDXMjJMWFAmBuWmyo/q+oghFbkq8be
	 aztRLsdNDkjf/yjyo6dwnQ90ZcRqe8bofORQf86U7U/x1HgfPQrSfa+I2RRfiB0EiG
	 Nv3+PxRRS9+ahPhFKN8Mfj7PphuAzdXETmCl7ijiY20k3BWHMzCcbR3e2RHmlUB/BH
	 2bBrnMQZFsR8VyMsaxW2iQbN9FMYHi7BXpkYkojYsxwKyuFle53E2dsYPWAMQ0FqMR
	 Yy4H6qVVoaCTE+FkYbT7YR3WFmBMjE/J+ngaS/IUViHuo7BIfUuofnM1I6oM4YTNLU
	 e5J0NFpNVhhEQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/5] misc: fastrpc: take fl->lock when moving mmaps on interrupted invoke
Date: Fri, 24 Jul 2026 23:33:39 +0100
Message-ID: <20260724223342.629168-4-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724223342.629168-1-srini@kernel.org>
References: <20260724223342.629168-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junrui Luo <moonafterrain@outlook.com>

When an invoke is interrupted by a signal,
wait_for_completion_interruptible() returns -ERESTARTSYS and
fastrpc_internal_invoke() moves every buffer from fl->mmaps onto
cctx->invoke_interrupted_mmaps. This list_del()/list_add_tail() walk
runs without holding fl->lock, the lock that serialises fl->mmaps in
fastrpc_req_mmap() and fastrpc_req_munmap() everywhere else.

Take fl->lock around the move, matching every other fl->mmaps accessor.

Fixes: 76e8e4ace1ed ("misc: fastrpc: Safekeep mmaps on interrupted invoke")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 12dcd2e737c3..c75eafe872cc 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1305,10 +1305,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	}
 
 	if (err == -ERESTARTSYS) {
+		spin_lock(&fl->lock);
 		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
 			list_del(&buf->node);
 			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
 		}
+		spin_unlock(&fl->lock);
 	}
 
 	if (err)
-- 
2.53.0

