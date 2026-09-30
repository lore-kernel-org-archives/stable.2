Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC6455616
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797760; cv=none; b=iKTj4WDrsA1L2Ha+Q2I4DpdQYpuZczuz9xh4fHv0OBlq5w+eMUaHAlaJwzA2WGMHrAuymSr5z4ofXeO72JjEVX1jSTqfZJ8/qIy0hxE3Ntg2C0neBVNUviXy8q0f0T9LKdGGJpqXpI4Xjiva+VU+tntRu19Dtasc23uH+4F5/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797760; c=relaxed/simple;
	bh=fpC/5qtbMu2abo0VSdYaGDLyQdJ484RYZUSMDY3ms1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmBP5mhdlvKA5R1lHV+QOXlUvq70/z6ap+lc0EsBvAquSPxYWi1Hgsc7IOQgndrKFtEyWQLzj9tsHWRO/GMN5iF+Gc0YBJWUfec+twf/gbOol5UZLC82ai772e0ftL7xT9W1Qmqct7IUDv4zVZk2f102mpEQh9CeglOYP9dXbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9JF74fV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9JF74fV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398591F000FF;
	Wed, 30 Sep 2026 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797756;
	bh=eW77hB/aQjvwJfwPLN54TQ8KaKLOm9LOEDgOE0wCgqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F9JF74fVlURPWwCROTLzBXu1qXZFvwvS6hX6bKqqGugVk33KBJm0W9LdHLaC3sdEV
	 YqYMDNi25hmbj8AyQdRRY8M/gOfFfX5yAEwMfPRJZOplj/6R7WMWskZg0ufn6P6qDy
	 zWRlqetI6sc6eCIOMateQOyW7hCnwbYiBRlHJ2Th2ItHe5VmjESWWndu2neNv44NKD
	 NSmFgTfPSnuOGv386XGO4BQ5otCIkc/5NJD86P39XqxqvRUpRxPHfmVz+pDk8zEJ8n
	 9+TzAbPeqEkmgiLNb+7FwA+WXq44aVq92SoOa5aoclJPr7GAcORTerj9igUrTxY7Lp
	 sTK1IQLtYCDbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] smb: client: close handle after create-context parsing failure
Date: Wed, 30 Sep 2026 15:49:11 -0400
Message-ID: <20260930194911.886968-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930194911.886968-1-sashal@kernel.org>
References: <2026092945-chowder-rearview-c340@gregkh>
 <20260930194911.886968-1-sashal@kernel.org>
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
index a2dc353b6e691..2e339a2062b5f 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3285,6 +3285,9 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
 				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
 
 	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 			     oparms->create_options, oparms->desired_access);
-- 
2.53.0

