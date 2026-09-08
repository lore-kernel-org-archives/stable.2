Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C61D54FA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829408; cv=none; b=Iy+wykRNXvDtRX35WTI5mUGcr7OzyyT1vsKN1vHt6PATRNOWhbxkdLYTmUUN7QUO0N95jXzNoknvxq/o+Lg1Brofl0A+XFWHA01suWnH089dfv/hoe/AxhOYy2JAR2IUMDtdkrmFV5Bq1gUCPxEpzFUfuHecvVtICRSrfp3IH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829408; c=relaxed/simple;
	bh=eyhb+IWT0m7RGcWmmhQJQA/y8Bf8r7j7D9KN1wCyHd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTiZ02THHyHG9z9Klg0Mm2OS8aWv21auExxHfP5/tnlRGaMOw6cTcpHC2Tu/P5VGAC/c+Ykn92+4DMGlzo7zRxe8peyuW2zpc7TUbyNS0ZnzMdJervhagKNan5WymjSNaUZlVU0aUHWoCAlwfnWxOF8LF3ZmxC+g9YqFbkQlX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwETmeD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwETmeD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41431F00A3E;
	Tue,  8 Sep 2026 01:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829407;
	bh=MvngbCfOjij/9fOobS3hcXuP37xJtn+oJ58kCRHDrfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwETmeD2fubippJMNOo+28MFj4FUwcO7LyYVjeGdH8IglTE1duB3xlw7p1T+0Syy5
	 ghKdaef8UGYUa8hwyekSvY27bJQ53vlblZBOcxTIqUu/ihgjHcF/a0vxBVOMWTWyhI
	 ZkTCT9U2Sy5BlNBi2+h2ak37rbLhmAXn8YwhICozj3+nhOJ61o3kdRxZ5RcovUP2AN
	 E728Ry6Ldeyp4ct4HK0Pmws9xSI1raKHQp5mN/dFbRkhcQmGg/DgYPiTVME9FFy8ym
	 rJza0mnJXEFG1V79s7z5sqgA1RC9n5vcjFEft05BYwHtHdD1TXa1YA7N73eoMW8FD0
	 2PUBEpp/NmaLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] smb: client: reject a tree connect response whose byte count is too small
Date: Mon,  7 Sep 2026 21:03:23 -0400
Message-ID: <20260908010323.1670112-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908010323.1670112-1-sashal@kernel.org>
References: <2026090337-dismiss-carload-0d51@gregkh>
 <20260908010323.1670112-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 65deb18359341141d37dc86fc7853511be3c87a7 ]

CIFSTCon() bounds its strnlen() over the byte area with the server's
ByteCount minus two, which for ByteCount 0 or 1 goes negative as an int
and converts to a huge size_t.  The later subtraction wraps the __u16
bytes_left, and that is what bounds cifs_strndup_from_utf16(): a bound of
up to 65535 against a ~16 KB cifs_req_poolp object runs off the end of the
slab object, and the bytes reach userspace through tcon->nativeFileSystem
in /proc/fs/cifs/DebugData.

Reject a byte area too small for what the parser consumes.  Two bytes is
the least it can consume, and no conformant response carries fewer.  The
new trace point is the 129th smb_eio_trace entry, which __mode(byte)
cannot represent, so the attribute goes with it.

Fixes: cc20c031bb06 ("cifs: convert CIFSTCon to use new unicode helper functions")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ adapted the fs/smb/client change to fs/cifs and replaced smb_EIO2() with -EIO while omitting unavailable tracing changes. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 5b58e198c2f0e..31fd29dc6f8d2 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -665,6 +665,10 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 		tcon->tid = smb_buffer_response->Tid;
 		bcc_ptr = pByteArea(smb_buffer_response);
 		bytes_left = get_bcc(smb_buffer_response);
+		if (bytes_left < 2) {
+			rc = -EIO;
+			goto out;
+		}
 		length = strnlen(bcc_ptr, bytes_left - 2);
 		if (smb_buffer->Flags2 & SMBFLG2_UNICODE)
 			is_unicode = true;
@@ -706,6 +710,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 			tcon->Flags = 0;
 		cifs_dbg(FYI, "Tcon flags: 0x%x\n", tcon->Flags);
 	}
+out:
 	cifs_buf_release(smb_buffer);
 	return rc;
 }
-- 
2.53.0

