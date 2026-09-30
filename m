Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB94718C2
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810041; cv=none; b=eO6PajOTgCC5muYHZ8qiqtMqmYis0DitOVUwmqPKgn0J5DVvjg938UpbzmQ4bZj4lL656H6Cf285leiJWsFAtPJ9OORnFaphrGTw0nMqzIAbt6Owb2ACyC7pRWgBjunB1Mi3c6lu7+A3+jK2VqiITKgZCyTck6pf4l5kHOIlysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810041; c=relaxed/simple;
	bh=xB30LnXe2D/S88ZrdjK+TCW6TU4S6QpoJLhvqnYcMBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsOayvVujvo9rNfynDRSKR5PVhpj4kMe4mxHx/gL1wRpv6g7EtwWNxFVRtj7SBkXYm9vEOcwkggqFl914nNrlnvUhEu6p3rSDZ9xh2jXZ5DyfA/805WpHq3ShC8KD61E3rgfReMBNeOglkiWmf+F7qHLud7kS3hJhTWpms9AGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGa2AT/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGa2AT/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABB21F00899;
	Wed, 30 Sep 2026 23:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810034;
	bh=wN0vA6zwkzAzILBeoEiu5BxWsBp3eqkMDHO8QexT1bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NGa2AT/e/u2ag+zltf9UgOxN3eBnJmI9rh5kU5VYbTxE4bJQlDc1eMMNuFNoJDZg2
	 CQDozgAKOsyp7FluDdlP6omifnqQJv9OjDE+Y7TI001i8khvJXSLr+VKArvBNo1fO5
	 rmrSJa7da+J+x41csuqvg6YFtQZBY0OKdRJRgo7grHsDKf5JecO9xxeHE1V7EcQ97I
	 HeHDQ3sR1EUKxRoMEivrbil2WVUs2lPZdQB4zNGRUGlekKeEumuQs0JP2Foop2TQO2
	 G56y0HB2md8ES/sQhMAY+OimdYdf8uBE9ZMFV/tJZBgaCsBaSOGqoBIyUA7jTtk94D
	 LjhwwE1gX0PNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] smb: client: close handle after create-context parsing failure
Date: Wed, 30 Sep 2026 19:13:49 -0400
Message-ID: <20260930231349.590269-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930231349.590269-1-sashal@kernel.org>
References: <2026092945-conclude-congrats-b326@gregkh>
 <20260930231349.590269-1-sashal@kernel.org>
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
 fs/smb/client/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 8b92cbbc113be..dd2cb123c3e4b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3177,6 +3177,9 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
 				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
 
 	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 			     oparms->create_options, oparms->desired_access);
-- 
2.53.0

