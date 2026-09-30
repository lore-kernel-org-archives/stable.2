Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C4501F30
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781250; cv=none; b=O9KZvs3gcphYpF9qvH1pIo7ymJckFJvq30QA8g9trTXrcVowNV5U5mceJ1tWtbPyFjAI6KNYiISrCQJxSR1lcd8RKGGDGS8UV5KLmS8TxmtoU+4WbNx6yGKGHSzsgG/g2FElWGfK+JMFP1HdYWmfK5N4U+pMiYr4atUhGyIFdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781250; c=relaxed/simple;
	bh=rkwmVtbCZhOJCO1Hml0vDeAhuDNPoQ9LMwr83sVhj7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvFUsJtIxDXvTqUQThuQM4PLGbow/seRAZIwjfqDFAHP1AEl2wLNYBeaDO7f/G4d4AyT/hUu4OXVz56DDsNVCRsF8BSXbc5L7ajqteCuxstfpUNyBjxewZPeZgK8ItkLmVMfdk7Zk2nNm9S+LZqunbpWBwua16qQqkMKDT+AlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLEiAYCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLEiAYCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B82B1F0089A;
	Wed, 30 Sep 2026 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781232;
	bh=giNFrpVpjASv6wss0t6fp+VCWujn3V6gWHHOj39xyR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLEiAYCHyUAOVyNs1lDydw5VcpZRAwKs5VEa0SFVMIMKqGCJgBNDbvxQ3YntHNFlh
	 GisAoEs2xQjHUCiZa0zvboOzLSIVLv2q632QzGLkJdhsj6jkVuU9vBYc/kZmRbYMO3
	 UJX7dnpeziL5SQMtUDpRaXk8XGDhfLpx69lBtYtDjuVnuFDM2MzrBIDO2WEdlxnGui
	 krq7guisxW4Q0+XsmJj/CLU6zM6Hr199shCIFxsluf3Q3PE+y0Y3RdmEwJIKQeuTLX
	 EO0xj1q2HI/30sEmaSO8Mh32WMw/dZoUPH+t7v3tj4OHQRVTxwCzI2jhwU2OZc9i1A
	 jwtjdVYsoh3Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] smb: client: close handle after create-context parsing failure
Date: Wed, 30 Sep 2026 11:13:47 -0400
Message-ID: <20260930151347.2502416-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930151347.2502416-1-sashal@kernel.org>
References: <2026092944-consensus-idealism-4247@gregkh>
 <20260930151347.2502416-1-sashal@kernel.org>
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
index 040a10fbe9dd8..aeb9630fa2ce2 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3291,6 +3291,9 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
 				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
 
 	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 			     oparms->create_options, oparms->desired_access);
-- 
2.53.0

