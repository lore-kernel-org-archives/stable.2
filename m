Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373624;
	b=IYxp9H+/gHOTXZxSHi8hq/4KtCZlzxsSpvNAsagRXCm5qi8PKmlRmh6sK6POHlMuJf54
	 56XvlA/JNBInOTLlXoPnjWBpkyRKQsQiml5DwJ/pqPaI5WFMZsDGcgzMiXWUq4sNHCTDv
	 RWc/MSs+I3O9QCMwxBIANjTkNXXjZWnlBfcRxKuMiz1v7fQXBTA73awuxJ/VHQclYdA79
	 M3FaqrBsUogZ9SCXRUcLm/AIelPFJ8TnpsTXfkRXWmYWPn+b1qoS3kntcVSUj/e6fq2ew
	 FPDZSz1EEtbJWe4nBQ8nYD/0YBuRJH+dYy2+mZ7/Pae62eQtiA5mIf23vaGNCsnyLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kR0ob9VEjgJirx7lFfMjEvdI9SbBQzso8ejXyYRhdAc=;
	b=OJ0JXu+Z/Pw2zi037CVSfyX4AwaZLdI78sE5mvc3+45Zku9IFvfSYMuQZlN4MvF0DPUy
	 ifhY3HalYtAfNYtduUen9BrvjgfC6GjTXMpxXpiIbyX5rWSEjhi0CV/DfyoGJnrulCd08
	 bRRG385Y4DyubGT8zOfJH7pvdW9qPCqPKvky+2hPAIy7ED/jso0pUf5rf37KHTNlzBBW9
	 bEQuQrdVhBT2tXHuYFB15wyBffbHotyCNXrm08omXsgrgQPnqsAIeJpCu0jBp9MF8i/vT
	 uixe7l3D4AGS7i/sKFyvBs2VJcd9mbqDQjGIx6Jhrf/oqPEUezC8zfe3V1+kfyg9McQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRHgb0ws;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B4606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRHgb0ws
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1D91F0089F;
	Wed, 11 Nov 2026 05:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373623;
	bh=kR0ob9VEjgJirx7lFfMjEvdI9SbBQzso8ejXyYRhdAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRHgb0ws/HslYA2S8+i82NkI/VBVgn6+rJHwzCwVfxsAuRcjeNX6UpAmyBNq4dDVv
	 FAA5wIXathaS5wfaGQVmTiHd48dkVFGHcdXOd78XqoHvhw7hTuy6tArQ8KQGNskOf8
	 Lkgc5b84NfvNrFks8qP6IOw6LYdZjunbFYuG2LPQpUgPDWkgI33iMRJGj30QA8Ji6i
	 5QEytRSbf7pZYM2WP/KK/leKp0eQc0ajlY4Rv6aDG+qpqsQr3Hp9FmAX4Z6H30XaTr
	 C5OKwbUavi4jIKIdEWP/QLuKeOeMBkaVOiKKava7qsz27D6CfU9HclXD+AbnDjWYMb
	 yFk96SuPgUgpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ceph: fix 32-bit overflow in readdir reply count check
Date: Wed, 11 Nov 2026 00:07:00 -0500
Message-ID: <20261111050609.1226791-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062909-failed-5.10-52913831ba56@kernel.org>
References: <20261107062909-failed-5.10-52913831ba56@kernel.org>
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

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 52913831ba56efceaafd80b501d68fa00f79bde6 ]

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
[ sashal: adjusted context for existing pr_err() logging and an already absent WARN_ON(1) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8154c08d54977..637f7aa82c0a2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -355,10 +355,8 @@ static int parse_reply_info_readdir(void **p, void *end,
 		goto done;
 
 	BUG_ON(!info->dir_entries);
-	if ((unsigned long)(info->dir_entries + num) >
-	    (unsigned long)info->dir_entries + info->dir_buf_size) {
+	if (num > info->dir_buf_size / sizeof(*info->dir_entries)) {
 		pr_err("dir contents are larger than expected\n");
-		WARN_ON(1);
 		goto bad;
 	}
 
-- 
2.53.0

