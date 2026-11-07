Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048807;
	b=I5/2pqGikltX7k8Q6s5Ofo2qsmpd4ELscwsqLYPtR6JeXZNrN/yZClMQDPgj0tZt+PQA
	 XvA9S+yBnxSKSBZAvRVZApY3rQMVdL5FIp7bdXKp+ON0Tr2yzRsu/BntR6GWjVe25a6il
	 fNv1t1obxuIf9QnfmOgBo/zeRBBNrSMsia/dZy2kJMahftVVUDjHDXwojYmsq5fzrx4ja
	 6gPT8lktBoNyaEdqezBX7eLYSHR6TA6wSNwSexEQplFEyrX7tk2fr1C/OgfaGBVyPoHUC
	 BaaRoWzBSvGafmo9499ncwp8IdclS9CShGimYS44mZlhWboO0mAjGWUBr3x+FlEGh4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048807;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N1p6p11rIul9Mk/LSp96iS1mbs2wglYAEtoJ2kaB6Bs=;
	b=iVnQFmvU6i8cNDO8ziWZXoWWITf3S+Clk67SGrWdNg7Ea9pZXsFXvwkKZM4Imzvi3RFM
	 fpKzKX76KJSb/sB8UOcOeI6nOCS2+1bRkkKUGMBc906jyzxUEZ//yCOKbtr0W7tkIlF/N
	 xCJ9d3Dm+4Q5MoOhtw4JHPdkPdqULb02LTXk2c2W8kqGNKYsTs9yg79hZVxlUNSPBc6KE
	 vi+EQiMBxYDCsvoZRmWYFeXqbl3FAq0fpg9ak7raoTPwITmzB+OX/riHrexWf/WefS7sD
	 YDmXXxg3CAbCA/o3Phme8KqP5E6F4OhSDhkq1P0/+ca0GoKp7akxiHP60kAX1IfSvmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YF3ycmh/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD1606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YF3ycmh/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E8F1F0089F;
	Sat,  7 Nov 2026 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048807;
	bh=N1p6p11rIul9Mk/LSp96iS1mbs2wglYAEtoJ2kaB6Bs=;
	h=From:To:Cc:Subject:Date;
	b=YF3ycmh/KrJRUIM/nwJGd6tLiAzvnFTVZOTUKkjXKnov3ngRMQ8V+o298iSE+9/9m
	 y5OWpqVIXvIpJ3aBTmS21Qugh9Eh51Fl/IVyWN9ew42ow+G1/K4WurvvGmbPeUkcj2
	 Os/64NvHv00bVgDEV2a2ktKpc0PwXJs1HOP0/maGGU1r/yyI2SmFEJvd4dgm/ydAMe
	 kMGNSk2VbGN5do1o06WqaFH/1N0vFF5NsAPomTYALOulBktqFvIR8y4vMmozJg1wlf
	 qjfq7WI4X2IHTua6t4iTGOo0MbuOAFdGMhEJB8jzUQOMhYX5Zb10KSPzY67ngoX3xs
	 yaRJyspMaYM/w==
From: Sasha Levin <sashal@kernel.org>
To: cel@kernel.org,
	danny_pidutti@hotmail.com,
	danny@lightningiq.io,
	bcodding@hammerspace.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] exportfs: Release the get_name() directory file synchronously" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:25 -0500
Message-ID: <20261107055324-failed-6.1-49184daab016@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 49184daab01674ca400cbef58ee101dba6dbbb9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055324-failed-6.1-49184daab016@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 49184daab01674ca400cbef58ee101dba6dbbb9d Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Thu, 8 Oct 2026 10:09:03 -0400
Subject: [PATCH] exportfs: Release the get_name() directory file synchronously

get_name() opens the parent directory with dentry_open() and
releases it with fput(). From a kernel thread, fput() defers the
final __fput() to the delayed_fput work item. NFSD threads are
kernel threads, and NFSD reaches get_name() through
exportfs_decode_fh() whenever a file handle's dentry is not
connected to the root.

On a filesystem with more directories than the dcache retains,
nearly every READDIRPLUS needs a reconnect. The deferred releases
arrive faster than the work item retires them, and each pending
file pins the directory's readdir state. On ext4 that state is the
htree fname cache for the last leaf block read. A 64-thread NFSv3
server under a parallel tree walk showed unreclaimable slab growing
by about 90 MB per second, and the same workload on a 5.15 kernel
ended in a global OOM.

Commit 5ff318f645eb ("nfsd: use __fput_sync() to avoid delayed
closing of files.") stopped NFSD's own closes from feeding the
delayed_fput queue but did not cover the exportfs reconnect path.

Release the file with __fput_sync(). get_name() opened the file
itself, read-only, on a directory, so __fput() involves nothing
that could wait on the caller.

Note for LTS backports: Kernels before v6.6 need the __fput_sync()
call guarded by current->flags & PF_KTHREAD, with a plain fput()
otherwise.

Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
Cc: stable@vger.kernel.org # see above, needs adjustments for < v6.2
Reported-by: Danny Pidutti <danny_pidutti@hotmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/DS4PR04MB9846BA3C16BC5ACED8B589228D952@DS4PR04MB9846.namprd04.prod.outlook.com/
Tested-by: Danny Pidutti <danny@lightningiq.io>
Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>
Signed-off-by: Chuck Lever <cel@kernel.org>
Link: https://patch.msgid.link/20261008140903.2784-1-cel@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exportfs/expfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index eafd99507afee..b5768f94fbb59 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -336,7 +336,11 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
 	}
 
 out_close:
-	fput(file);
+	/*
+	 * @file is the read-only directory opened above, so __fput()
+	 * cannot block on anything the caller holds.
+	 */
+	__fput_sync(file);
 out:
 	return error;
 }
-- 
2.53.0




