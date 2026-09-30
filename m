Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D785158A8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784726; cv=none; b=FrYF8cMfnDYPw/N87fK0LYPka50YdD3cqf9cUJSwWSNCBadxgcQHxOx7wfvP8t3M9M50CEnTOtUl6TqMhFy1IPvFo1HvtNVFl1ulTW8r8BFnxCfljYGS46rr1CM3PufhFpJVbRNIxgVvJLnj/o+y4tqCYgNU1FlnoIZG4mw6kiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784726; c=relaxed/simple;
	bh=bQPpbp6tGeq+hX5n2iycE27aos7e5pphlkoDG12/VDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFwrYQw4jdLAYZMTufoFPSmonboYNc8MnhNecx7kEBS1dNYNQOmGytNKpB4Jy9+go8goKRvXGwNk+PrQ2U0gwh6vC7ICMKoxo0Dho15CxoAzopifFgDJIA4FnXvFD6m7pxT2UZn3b/nMiD2FtXVb5Ilz3y6oGVMGN85F75zzrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biMqyEWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biMqyEWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584E91F0089A;
	Wed, 30 Sep 2026 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790784720;
	bh=yaGT+jHwW/A8TiwO510tFlfEU9nv/W6AvMPILaX8mzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=biMqyEWQB05h2tyEQ9ZR3eLX2X8Im72x0aHtKzMLKV0Da580PT7rvlYJPipsnE2Zr
	 feEm0d2DzF8vjcCUF8ZSiueJLpCZ/MSSTvvQdvSIqpMINb9dIhWYbPkCH+tER7MUPZ
	 h/Xd/4V73yte6KWOcoNzU/gk+A/3ONEKpPW1baRwoNdSYVLyroICsHbQgGqFNBGjen
	 zFD8UJitGZwE5x/8xsw7r0SUwDKN5kD5LU5xF+hh+1q/aKyrYG48V7lI3kwPfM/Gw7
	 54aXFLo5qJuPfiyegv+ryP37755QJ87F74De0ebcDBm+nnb4XtybWysTph4Oehn/YT
	 L1VJihboRJMgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: validate POSIX create context length
Date: Wed, 30 Sep 2026 12:11:57 -0400
Message-ID: <20260930161157.3001113-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092935-playhouse-remedial-7443@gregkh>
References: <2026092935-playhouse-remedial-7443@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit fa2e9900dd2a3f5a1e7ef5a8c5e8d435feedbfcc ]

parse_posix_ctxt() reads the fixed nlink, reparse_tag, and mode fields
before checking that the POSIX create context contains them.  A short
context can pass the generic checks and still make these fixed-width
reads run past its declared data.

The current in-tree smb2_open_file() path passes a NULL posix pointer,
so this handler is not reached on the ordinary open path.  Still require
the POSIX data to cover all three fields before reading them because the
helper performs those unguarded reads.  Keep the existing soft-failure
behavior so malformed optional metadata does not fail the open.

Fixes: 69dda3059e7a ("cifs: add SMB2_open() arg to return POSIX data")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 19b4f426e9afa..3584b179fe614 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1966,12 +1966,15 @@ static void
 parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 		 struct create_posix_rsp *posix)
 {
-	int sid_len;
 	u8 *beg = (u8 *)cc + le16_to_cpu(cc->DataOffset);
-	u8 *end = beg + le32_to_cpu(cc->DataLength);
+	u32 dlen = le32_to_cpu(cc->DataLength);
+	u8 *end = beg + dlen;
+	int sid_len;
 	u8 *sid;
 
 	memset(posix, 0, sizeof(*posix));
+	if (dlen < 3 * sizeof(__le32))
+		return;
 
 	posix->nlink = get_unaligned_le32(beg);
 	posix->reparse_tag = get_unaligned_le32(beg + 4);
-- 
2.53.0

