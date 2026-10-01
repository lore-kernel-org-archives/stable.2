Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC24E77FB
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852468; cv=none; b=E/aAVs76CX7Ve9VMMzT6rNM6e/yXtJDZU4rz0BXeNA6btbVBZaIUkcQ9Cii12j/9WlSwCOf4JhdBbjFaU3lu1hnSfcSbHzMy+H4kupT1nc2xOs7TFpvAWAH9hFxXBRU+QxVRtbdwl3jxJbh7Yi4juR5x9BN/EPfcyhAs89tX7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852468; c=relaxed/simple;
	bh=RheFhrB6faGcOQy6CGqRo8dFp9BCaa6lioddkWb2NUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPSTtMMK/cqUkhLNrLRe3LG9W02OmZXgz6zoWD815ZcMJNYfdUWND6tJdD1h+aELD//jZxneKY5riAV+oTjeqXdrpQ95/A7s74eGpPNtsJGlbu+vBkEl/nZrs06LSzdviQNpqGNDZ++kQYlPpU4PuV2eL39aNHry0CKzscAe7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4yfJZNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4yfJZNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3BC1F00899;
	Thu,  1 Oct 2026 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790852466;
	bh=36JnT39rwAp60bYlbS7URAPfW2TjyJucZ8Y1H6+0qYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m4yfJZNnphL2VUtFfXiiSY93zF9N+4pCuqk3F0P6ETy6DSrvb4S04b3tjgDvoqoDH
	 rY0uL//NyeE/TamxmDr5jv07lVOM+K6TsBscGoJaOHc72cinT42fY0MdjuzBJ+DIcj
	 xpNHTXY91/0NSdPTp5XjmzOO8XCvvqc9ElXQztV2o+4g6ySrZQ3B1v90jvaUZDUj2S
	 lOIn0Cc8LKkHwpdD39X9PwMTO6e9jn/Sn0qHLaUunfrkav92fVhyaXFTNHx3MpRP6c
	 einOiI+zRObWAYKTiejvzfusKYZiFx4flJdZc9qrzALs6wuzNzbN+UsD9CllblRJWS
	 /sdNPpaLQT4MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] smb: client: close handle after create-context parsing failure
Date: Thu,  1 Oct 2026 07:01:02 -0400
Message-ID: <20261001110102.3713269-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001110102.3713269-1-sashal@kernel.org>
References: <2026092946-apron-radio-67f9@gregkh>
 <20261001110102.3713269-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit 566820af017e81497fb5e9d3ad6e7ffe2828bc8b ]

SMB2_open() accounts a successful CREATE response as a remote open before
parsing its create contexts.  If smb2_parse_contexts() rejects malformed
context data, SMB2_open() returns without closing the handle, leaving the
server-side handle open and num_remote_opens elevated.

Close the handle after a post-CREATE context parsing failure so the error
path releases the remote resource and balances the open count.

Fixes: af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
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
 fs/cifs/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index d8cacdd54acb0..9f80729f4d0b9 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2940,6 +2940,9 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
 				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
 
 	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 			     oparms->create_options, oparms->desired_access);
-- 
2.53.0

