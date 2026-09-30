Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93651DE16
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789661; cv=none; b=hNzzZ3YdPdk/vk/IW6E2NyJ5MlAeUQorH9zaUxZAnjQL+LE9vvnrMCjRhGjXlXBeh4UaehrKEDZXUO+N98j0GL7lpsjYLmEXBRPdrAdgm6G3OY5TyOAXdMLurH16NaiDNlb2y1Pb7CMV6UQkhwvzuejNMIRrON4EQcVwDxaNATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789661; c=relaxed/simple;
	bh=lnixfhiZrcGOSB5pKIlYX415FHK/02bXR9i6bc64648=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbjgmuZMGE6KEynZB6m00BH8iPSG3jDcAMz85CT6op9UymHOngJ4zS5ouPq+mdDKvdCvMGX9L6kLiMCFYJ5epbXGqwg4VNTyjySQjGOpb0eYkplICp1KWaB5j4RcePpxy8awo7vpnL67kBwOXBrPE+r09oISMauyY0ZKEZlrQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLJl59zK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLJl59zK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACA91F0089B;
	Wed, 30 Sep 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789660;
	bh=rBihlAlabUIrPzRW82eAJQqcIdKMIq28Y5Jf3shD5i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XLJl59zKTw13l41tehtWqPOQVe65s9dtcukO69qAVBoI0JfneInAYcQxL/s8wGC83
	 OzD8vyFXcVOOtA8+AmmZrrNCfjKFSNValryaDyyY2eLvImBWBSlBTSZIrQu8Bmqqws
	 N5TyiqraV4/ZHed7jRS+VU+heTD4LxX/Emo2VyUqML3WJaMY88/zwR55HkSLvuSz8u
	 25rWKoGl3vGsC9Wp3LuKhrqzyiKnph6/hkTGAlZBuwYqbXyZMqNtUC1i5DFRObWC37
	 3U1r8V9HiYyl14xd9RA7TwxONSe8KUSPKmQ0n5XZmZb5+QLn35vZQCruPjFo/JhS4p
	 umojVJb1bV+gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] smb: client: close handle after create-context parsing failure
Date: Wed, 30 Sep 2026 13:34:16 -0400
Message-ID: <20260930173416.3643771-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173416.3643771-1-sashal@kernel.org>
References: <2026092944-ranked-citadel-c0d8@gregkh>
 <20260930173416.3643771-1-sashal@kernel.org>
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
index 9460c26d5fb2b..9f0d8a43ec8f6 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3292,6 +3292,9 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
 				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
 
 	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 			     oparms->create_options, oparms->desired_access,
-- 
2.53.0

