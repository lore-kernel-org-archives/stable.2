Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFF2E7F39
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815602; cv=none; b=Nq8XeFmtOq1umHokwLbK4JMPuFXdUE37ugNaWhhUPRP6HtLWImLbOe/kFgPUfRsyPm2wCiGqxvor0PdWWca6crYKMwF2L0rAAA5KlXhdM/gQpGGWPwMleAni3SitL7Venl0mvhyIZEEP8QhfdmMSdilUT4OaadnMaOTOsxEngR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815602; c=relaxed/simple;
	bh=lV6/UAqPODFTB/J8ey4bSBGiza8gAoYlYjqNCnfyaXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siPmdnVDtMU9tBNwGFjQrJRfYDVFxzsgZdM2Jv0fQf2CwGxc5tlAwzeoewu7qaKf1L1vNc0fO0lpnCR2Gw89MjHu8nIvY+UZIKwNuWDnVAtkDIxt85NcfA9jI+6CPhTV3IMcwtIdNy+VRQjlX6Sty61tV2VNAk8qISwRgh+wYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDbY61hA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDbY61hA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEC31F00899;
	Thu,  1 Oct 2026 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790815600;
	bh=N259QhfmO/O5/PFUqu+cofw+YuKOQU0lU5VXZDBuuUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NDbY61hAB05l0GBazmekb0uvQWMQCsz6JLBL9tjzpiyYxRmykRlwjK+O+9gueB7v8
	 qsgxTzn2s2cLOMdD4pOzENlyRlz6+1wECi1OGMrw7j2+AImj7neEBQh+cMWl4TqxcG
	 lIzGlFZHYazF/GlKEuNG+yBm8zDgvvDkPUJRbT61k48QAAla+YUcwjnYLd65up3e3m
	 OIlswFB2Anjawm7zYYWtEKnMmnBsaBxGl5GcDog6cUCzPCKQ9Ycmod0KZvO9ybPyaK
	 jsCRvqBkeIl9yslnsRov19x3gpBFp2kKLCCO5lVS87dpabV4xJOCloTM8R08Cx86M2
	 mjaJ5fH5UaOmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] smb: client: close handle after create-context parsing failure
Date: Wed, 30 Sep 2026 20:46:36 -0400
Message-ID: <20261001004636.2232529-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001004636.2232529-1-sashal@kernel.org>
References: <2026092945-vendor-cesarean-fd29@gregkh>
 <20261001004636.2232529-1-sashal@kernel.org>
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
index 8c46757d4c838..c154803d6646e 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3007,6 +3007,9 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
 				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
 
 	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 			     oparms->create_options, oparms->desired_access);
-- 
2.53.0

