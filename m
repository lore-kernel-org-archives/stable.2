Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049933;
	b=LjwX7u7q+ZX2mTajwcbdVmJr+L3tsiALNoKHxLP/rtPiV+1QxORTKg2Dkpv9jhiELvqe
	 QspXW8DGgzLeKT4IwO6jJcC1bE5dEdx5xBRQmLDbGBP48P5LYDLDJ7Yva6ZAWKb/LQ+e0
	 eVvi4CiloGw+32yCp5VR6VAMHAeFG3+0GdcLiYZAnEwGbTvc4kaI/N9bZVCn0OO5dQ66f
	 EAebHqah+G48ZPW6gLH/JnWLbrgEx0hSz1Ql5/SeZ0Pt0FzWmiQUFss7x+503NN9aMp/I
	 AdZiKIYNQIZuTrKA3WMQrWuG7kiRnhZ0PDkThH5xnRR7wjLhmoU7KcWuWAyP+wzL9Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZiheMVM+MVAJQbcNuv38nVM8vyzJM1XEuimNKc1dTUM=;
	b=jS6vOpWRrNSdSB/Z6/YysC9YwpYK5k5YN03QvFgXWl+CIgKySsn2ajSDkilim/5sGbc2
	 Le/qahzrnjOVkRXWhO4JmlMJC1kuhIgdImKQ1BVV1XfXTkbjX4YytUIpR2AcbOzIMtKqa
	 Y3FRGLnZXY6EhSiZgnM3l2d9Ioy8711oTHccH4GiZFT5yza8vBZlHocEx5dZsWx2lyMJG
	 LCBQaNYjGtncjeXVoW74za6flKRmjVtSpBfl/fMYCNAdB3239b6AX80s65SCKY/idlstM
	 KMoVXWNlazQVTSbavQ/py9pesp1uJmoRlVN6wwP7En8RBrBRiS+tGUCA8X3BhhmMSAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NW3JY7UI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NW3JY7UI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7201F0089F;
	Sat,  7 Nov 2026 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049932;
	bh=ZiheMVM+MVAJQbcNuv38nVM8vyzJM1XEuimNKc1dTUM=;
	h=From:To:Cc:Subject:Date;
	b=NW3JY7UI6mnkR0rRngYIDWSw8LcljG4G86BZGHy2CqQq3X2MKzKclsUldGFnWaUVA
	 HQKi22NhxFiWK87Ibop19GDwTy7SZt1UIBsl6yz1y6L4M4MCK52g6WuHs49rAMgCWr
	 MZA0NA/iU4hPX4aYbsj91F1f2OPus8czEotpO1lXieTC3lO3pEIYclCRWj01dIa1+x
	 sJviuq2aGGpu0WGAp1YXh2GRQ/cUSXQ6h5FFBG75/PkoCVfev9Q3Nw6tFwNv2oYgum
	 G0TJIo2rFsVRk+RONWtRxsIj12S0dP8HMsFT5Xo+QfS5c9DQnn/h5LZiYE2c7FbucT
	 fgXxqMMpHBIjA==
From: Sasha Levin <sashal@kernel.org>
To: jeremy.jean@oss.cyber.gouv.fr,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: fix 32-bit overflow in readdir reply count check" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:10 -0500
Message-ID: <20261107061210-failed-5.15-52913831ba56@kernel.org>
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
git cherry-pick -x 52913831ba56efceaafd80b501d68fa00f79bde6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061210-failed-5.15-52913831ba56@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 52913831ba56efceaafd80b501d68fa00f79bde6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Wed, 23 Sep 2026 20:25:34 +0000
Subject: [PATCH] ceph: fix 32-bit overflow in readdir reply count check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

parse_reply_info_readdir() checks how many entries are in a readdir
reply by computing the end pointer of the decoded array. That pointer
addition can wrap on 32-bit kernels and let an oversized count pass the
check. For example, a count of 0x40000000 with 156-byte entries wraps
to a zero offset, so the decoder can write past the preallocated buffer.

Check the count against the number of entries that fit in the allocation
before publishing dir_nr. Reject oversized replies through the existing
error path.

Cc: stable@vger.kernel.org
Fixes: 54008399dc0c ("ceph: preallocate buffer for readdir reply")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/mds_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a207b342e7dae..9f13f3f7b800f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -504,10 +504,8 @@ static int parse_reply_info_readdir(void **p, void *end,
 		goto done;
 
 	BUG_ON(!info->dir_entries);
-	if ((unsigned long)(info->dir_entries + num) >
-	    (unsigned long)info->dir_entries + info->dir_buf_size) {
+	if (num > info->dir_buf_size / sizeof(*info->dir_entries)) {
 		pr_err_client(cl, "dir contents are larger than expected\n");
-		WARN_ON(1);
 		goto bad;
 	}
 
-- 
2.53.0




