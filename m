Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049836;
	b=dYiR55D9esE3wNqLfK7R3XR4EcwOzal2JmPw4S/GoSGY/oXCNBnz0lRBEnHcMQs84Iyt
	 22p1yUNlzFa/u7wZC+b2/3AGF+9jmL/7S4z6OkYAduEp48kShWsNpzdMS2lOskx96WtUm
	 t20js28HnUXNAFyR6g3X2/mrLlCa9P0vEcUvsArRuaiO0redhy44+naWgH0RVDB5zNkhn
	 UZmz0d0qxrKTs4W5q4kXeSNoFNRGj40Z49Ssenm0qrQaLQ+/412x1tbKLdB+9MmQcAp1s
	 qoD3dsOyRoZtREZcE15IhmlAgvfXJ+oB9rgVB0pUKzA9InNhbSxcpvuUrSnUhbSwYsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QvAP2yZpUom9WeKb3aueAQloRm3t9Ldg/0CxZ3GGinU=;
	b=ZZZrJaTx8Q7TB7tYEHO38a6DEBHNnZMomVON0rRpaZACndiASZv/VDp0NCXlcZ+XtbmY
	 j1KrmbZURfcVoDNO0wsEK+vkSBbneJpnXYXv7ghh0r467rC/g2N1u8oeDvL/ggnBKP7tP
	 MhqxXpy2lP+5NM2f1N844Qc3niO4NtD+KjAKyltyFBaD3LZOhqVJC/pO26hJM5KgYMDrp
	 pe/9InwpG8AaKdjx7p1VWXnQlhggtSzs8SVVRxrKxofG59rGoD7umlJbTRYwgVrycueII
	 KuRujONiW0tDRLyBSpTDYmOPDuwWED/5warDPL6y9ljWhQ1nYlK3UWSYq/+D2s/uyaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AIgZ/6yD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIgZ/6yD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4C51F008A1;
	Sat,  7 Nov 2026 11:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049835;
	bh=QvAP2yZpUom9WeKb3aueAQloRm3t9Ldg/0CxZ3GGinU=;
	h=From:To:Cc:Subject:Date;
	b=AIgZ/6yDW4skll3r1sKtZMlMW2a4qGQX+qx98OtdB5XUSHBuBYXByGQtK2Qg+CrQt
	 dOFCFIZGeFZhquWWJkx1ChkvgUqpcYxaXbDSAKyWwWIm6zJwNIBPiKABA2Z9m0COJm
	 9f1+FFT3N3daVUVK+KehUxZlLEch60vCgUhwqYM4gg1Lf9zJcygCPasyC7lxlDT4Yh
	 kVbL1NxPUUGUZdALIsPAK40lWlQLtqka4cvIAGdGTr/ZuJp2B2Qfv6z3PwLgxWpNue
	 JAkGal4zIh2K5XodKofK9qNuhyYGqfbll2+9aMk4oqHAf6M6z6Ky+2v1qWK7jxP1IM
	 QLlVBJxsDiUWA==
From: Sasha Levin <sashal@kernel.org>
To: cel@kernel.org,
	danny_pidutti@hotmail.com,
	danny@lightningiq.io,
	bcodding@hammerspace.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] exportfs: Release the get_name() directory file synchronously" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:33 -0500
Message-ID: <20261107061033-failed-5.15-49184daab016@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 49184daab01674ca400cbef58ee101dba6dbbb9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061033-failed-5.15-49184daab016@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




