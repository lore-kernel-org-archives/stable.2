Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048916;
	b=d5l7ZJvTHCxW/aJaEc5iy2bDJdi5Ps1a97YWNSm9wHh31D6Zxl0u8W5gaI0W1QV9Cb02
	 HFKpC2VMdXWru12JHybokFjeSDvMscDePJ1tJ2zqFcLdpuSJ/rFLONbvn9iP0UGTW5aJ+
	 vK/wZ4q/cauIOAhrFwCwp/P9Opc0LKz1KTzNf1FtUurzZMdgkX/8k2w/7Lt/R1eAXtMDq
	 S2t1aTSMg7JNIM7WhhF+llwOEgf91pNeYRdsksT1+X3IDG5dyTHkxruOkmmeKq0dkc2bV
	 hVQTH+JrA0ao3loGZFfN1STqU3988uUta8Oydc8tXOhs6BCzsbvDHaBP1JXnLFh/AOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bXj9IWzgajOoThnha0IwCMsn53OH5sBxdwD0Ham44Kk=;
	b=oyBVKvOTjQ9FdMIqjSuEwFyI9YwcCrpJ7x6JONhCbhMb10ng/X+EuGuDrfYzkmTaVwC1
	 AKrUL18iIMQk5nzROWe3teTjUn89XEAC6fXczrzGO0jh9Z8wEdrmexVv00mmxELdXy/9n
	 4RNAe6QwIe0+e4//GFFUt10bJhhdT5ChJgc8kpH9yjbNrNa8q3ymGitUPE2aMO3nD1vWy
	 dhyILOJooC5r413FpWTmIPTCGgPXo3+uiiY0VmE4kNXSZf83VKbwaNdPeMKDoDn5lHFHZ
	 /QPNm65tNrcb9XjeLxY3aA+co5qqInIbEpsKt+Ust2Wej772/zrdkhso/F7zrXQLXRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRFicdku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRFicdku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2464D1F0089F;
	Sat,  7 Nov 2026 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048915;
	bh=bXj9IWzgajOoThnha0IwCMsn53OH5sBxdwD0Ham44Kk=;
	h=From:To:Cc:Subject:Date;
	b=CRFicdkuq7WGPfXtYap5RDg7e6/CQCfm/VepMKiRksnVcQgEGXC6/aIBJIVYChrO1
	 fRlR6Mt1vVj64qaAZLQ02HpYYyiWo3R4BnSTLN0F1Phzwu7zY5F3c/6JYsMoxsSDdo
	 gmD2bDDJZTVRMgKcJcXoVM1TKgyxiKbcUNWO6KLJiFAw9ThaDjxbuKgOw0NkQGhNdQ
	 QnS8nvTTL/CpSelLoeLcr6R2+fhZ3qf/DPK41Ge5L25M43ArGEKpkdu5P94AozmH9S
	 CO5kwQpoj6D4/Dri2KeE6HJ/ez21ffSmC/Ce0mLrGKP3nd4RTIVcOUlrGeEIucDP3w
	 yui4D4eZvdFpA==
From: Sasha Levin <sashal@kernel.org>
To: jeremy.jean@oss.cyber.gouv.fr,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: fix 32-bit overflow in readdir reply count check" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:13 -0500
Message-ID: <20261107055513-failed-6.1-52913831ba56@kernel.org>
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
git cherry-pick -x 52913831ba56efceaafd80b501d68fa00f79bde6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055513-failed-6.1-52913831ba56@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




