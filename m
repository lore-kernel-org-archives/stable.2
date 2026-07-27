Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573B3D2FF4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186016; cv=none; b=SmxHKGB2ovlMLK1XgV25pvhMKA9C+V3gyc8Yo5mcb9pRPNUYQ5LZJLFtLdfNoD/FMKCf7dyuSvDucvs9HXmWEO/U5v1DBFbSSRJMtbZgM9J4aSNTAW9xEyTHo84f6mB23JRpFcJy8ojhcnEutC9Ff864en8iRkJc755BXqzQ5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186016; c=relaxed/simple;
	bh=zm+bDPRWk5bRCFCSZd17wABkFyERCUW/YXykrPvgnFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2/36YczNNlJfZHv1R3AA4iJUM2sqVqylZiZ5kkiH+xMcn+F9XJ5i6xo1TBMP9Zww+w68a02d/9z4hmRQkiqbLaLrVHOsgENp6Ao4Ty0A1xlqAkPd3IbH23SVhISXFGWeKPzphwPwWBpW4kxmlwWK6gCW7pH/jnT8/pzxE17K/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU2KVy3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU2KVy3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED481F00A3A;
	Mon, 27 Jul 2026 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186015;
	bh=UGQ96ig8ZwWNHOwWgtbILU/tjN1DtsYS4mleySix6VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BU2KVy3TMWGMs+fAnoiaP43klfQOyAW8z2qRRR1XUBx5wmHZhw3xqIShODhmW03JN
	 0Cf98jSSZF8ixUjfgY6lNz5GOFrlr61Rw7pkdZa2t2yyG3b8JFYXG2G9nWsW4Yja5M
	 OtMDeKXHuazQAEUFYm2OSEUe+DMykvP1XQNMuoiDDSIHzRIWVUjb924WkZV4eWd8B4
	 VeQbzxZlcZ53bOcCLYA4+UK9dUECGrQmyZxrorIXD1DaoF8blTJ6h3Mavm6lhZ3AAl
	 UiUjt/mIlll/hDBpP+4gBo9PLNST0r4V6U2b0D8NxhDWXH8+vVtimQkEf39FZvNtYf
	 vyOG+mkC4i61A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] dm-verity: fix buffer overflow in FEC calculation
Date: Mon, 27 Jul 2026 17:00:11 -0400
Message-ID: <20260727210011.1929439-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727210011.1929439-1-sashal@kernel.org>
References: <2026072004-monitor-wolf-7764@gregkh>
 <20260727210011.1929439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 31d6e6c0ba8d5a7bd59660035a089307100c5e8e ]

There's a buffer overflow in dm-verity-fec:

if (neras && *neras <= v->fec->roots)
	fio->erasures[(*neras)++] = i;

This allows *neras to reach roots + 1 (the post-increment pushes it past
roots). This value is then passed as no_eras to decode_rs8(). Inside the
RS decoder (lib/reed_solomon/decode_rs.c:113-121), the erasure locator
polynomial loop writes lambda[j] where j can reach nroots + 1 — one
element past the end of lambda[] (which is sized nroots + 1, valid
indices 0..nroots). The out-of-bounds write lands on syn[0], corrupting
the syndrome buffer.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Cc: stable@vger.kernel.org
Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-fec.c | 4 ++--
 drivers/md/dm-verity-fec.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index cebcc8fd25d700..d1e4fbc5a21d9b 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -250,7 +250,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 				     (unsigned long long)block, PTR_ERR(bbuf));
 
 			/* assume the block is corrupted */
-			if (neras && *neras <= v->fec->roots)
+			if (neras && *neras < v->fec->roots)
 				fio->erasures[(*neras)++] = i;
 
 			continue;
@@ -268,7 +268,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 			 * skip if we have already found the theoretical
 			 * maximum number (i.e. fec->roots) of erasures
 			 */
-			if (neras && *neras <= v->fec->roots &&
+			if (neras && *neras < v->fec->roots &&
 			    fec_is_erasure(v, io, want_digest, bbuf))
 				fio->erasures[(*neras)++] = i;
 		}
diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
index 178ecdddbbd310..c19e2d20657284 100644
--- a/drivers/md/dm-verity-fec.h
+++ b/drivers/md/dm-verity-fec.h
@@ -50,7 +50,7 @@ struct dm_verity_fec {
 /* per-bio data */
 struct dm_verity_fec_io {
 	struct rs_control *rs;	/* Reed-Solomon state */
-	int erasures[DM_VERITY_FEC_MAX_ROOTS + 1]; /* erasures for decode_rs8 */
+	int erasures[DM_VERITY_FEC_MAX_ROOTS]; /* erasures for decode_rs8 */
 	u8 *output;		/* buffer for corrected output */
 	unsigned int level;		/* recursion level */
 	unsigned int nbufs;		/* number of buffers allocated */
-- 
2.53.0

