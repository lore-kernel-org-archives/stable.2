Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278E35FF5B
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127625; cv=none; b=hBU4NdeiTVSG4KXan6GfYjlGEghpWblkNKu7cS6HBxAdBdmPugNauJdm6RpmSB/kjExu4HLPFdcy8vnd+dQ81+6skcwTJMbnIZJevNmPV8FfkK18+MnJs2U6WjBNVOFm67sDb53PxYJrX5gZ97pJAtszV9yvMUu/rCGfP1MpOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127625; c=relaxed/simple;
	bh=PxEBiu8phtJwI8vLKHLwbtiP3fFI9eC3wGz6sr5JWRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJWY0vQMaUbSqTdaj5JVkjexTQ5eOnX9RlNJwtaJo1vOnS3Hn8Od0Y9LVMJ+lWjZQ9M87ujGogTGWCr7JhSOIM56Ith1q2tudgJO7aMQclO9LRqeEH2DPkG6ralNB8WRbk/ustnCZ57APL3phIiZLMT/XFliMUDyAw3onAOzyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfmy7tno; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfmy7tno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC5E1F000FF;
	Wed, 23 Sep 2026 01:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127624;
	bh=bLVU7M9n749VT0uSJElHXdzt7ml83/5MVOCeE0vx2Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wfmy7tno2dnamYj9/DAPDL6V5SKmyTuQQ7mP93U+X0gcU+XnYhZeSRkD/kte6K/xK
	 gNdVeypRMJwB7zAT69w7NQREX1DI7cY0bSr2/uWkVyRVynGdpkjX42xb3ZE3dLrP8H
	 Js8o08yisaB+wB3s5XrHzzK1n4fBZhGDPf9YphldL+DMk4Joh2DlGvYdVzTKdFExQG
	 Vc5N9Ro9ye+3g1kijgdbU95ELh091m1I23LK3buscvkRa2MyK1uN+PZNg/HdU6macl
	 JwmSlccV9cO7GAW6NlQmPant2p+IBnyCVmqttnx8LBdsrmx7AoTyYbfdNUSiZjiz5W
	 y8/Upl8ZsW9KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix server->total_read for compound encrypted PDUs
Date: Tue, 22 Sep 2026 21:40:22 -0400
Message-ID: <20260923014022.880433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092214-passage-deviant-ba7a@gregkh>
References: <2026092214-passage-deviant-ba7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit f73726b83e4756fdaa099e1bc1143293bd57ad79 ]

In receive_encrypted_standard(), server->total_read is left at the
full decrypted frame size when walking sub-PDUs of a compound encrypted
frame. As a result, cifs_handle_standard() passes this full size
to smb2_check_message(), causing the PDU length guards to incorrectly
validate the entire compound frame instead of the current sub-PDU.

This allows truncated non-last sub-PDUs to bypass length validation,
leading to out-of-bounds reads in smb2_get_data_area_len().

Fix this by setting server->total_read to the true length of the
current sub-PDU: next_cmd for non-last sub-PDUs, and the remaining
pdu_length for the last one.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 51f8ea0c89065..c9866251b5912 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4972,6 +4972,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+	server->total_read = next_cmd ? next_cmd : pdu_length;
 
 	if (*num_mids >= MAX_COMPOUND) {
 		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-- 
2.53.0

