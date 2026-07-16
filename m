Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9336F433
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217857; cv=none; b=ORGUukubaHcFR1dLZPxgV+I6bn4XXvkjtiwJT3LNrL+SWYSHX0RuN5t6d7FJE/4D5kuXsmnlN3PJb4VY+CH2tpNdAILedQzOH5e/3IxLwk5LVLw2pljzN4BKLeUWIKhAPH1BR4r/cLlIIM75/Q9ew95mlyZ7CF/us5ekftD6GAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217857; c=relaxed/simple;
	bh=DqYN+VYo69R5P1danw09qZiQm+Qk3iUvI3yXBeB9SiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7bt1Rf/3zaGNzOdFUQDeqRa5LwYmkavh3TajrspHzERnbInPn6ltsam1VNgJm9yF8/lETFDjlzCunCXJnI7ZdAwUMsNskp4tLFKL5nkamJiH9op8tXr9HOdZE4CKJSpVk5OWm7Jo+Vnlnd8uhI95R2DowxzUIfvWHQdS+uMm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGfYaE8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGfYaE8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3171F00A3A;
	Thu, 16 Jul 2026 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784217856;
	bh=NmhlKBfEN6eAdRsI++6RBIgaul9PoiJo1DM62sOLEBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JGfYaE8ZZpmSJ8j1oNGbIzsbeBeokMwdEG1CqkkMljOsG4kAuGfPu0v2mQuNW/yhN
	 zzKTKBwKRo5O8g6SNLndddfASGVC2pTt/v4DysqGYrLona7CHVKOJaAiPE3UUMgOE1
	 aM98sAm8FKUrgs8dg65Eh3/iYNrfemJJYyStXPP7F+ypGxn+Va0KFLqLZnDVRc/vl7
	 c9ls1rllrclaVt7ZBZOpaEon3FW2ITaSfwuC1uqo0DzOjiwKc0fxaSYmE94NC+C3ls
	 p/gHxk1D7/Pt9L1sSQ2VlZPq2n+5eb6o9iHMPfQQIFmEbUp1TINrZt9JwqWFPUPPrr
	 41fqK+0/IAd7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Norbert Manthey <nmanthey@amazon.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: mask server-provided mode to 07777 in modefromsid
Date: Thu, 16 Jul 2026 12:04:14 -0400
Message-ID: <20260716160414.619549-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071454-wolf-talcum-3f10@gregkh>
References: <2026071454-wolf-talcum-3f10@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert Manthey <nmanthey@amazon.de>

[ Upstream commit e3d9c7160d483fc8f9e225aafad8ecbbc43f3151 ]

When modefromsid is active, parse_dacl() applies the server-provided
sub_auth[2] value from the NFS mode SID to cf_mode without masking to
07777. Apply the correct masking, same as in the read path.

Fixes: e2f8fbfb8d09c ("cifs: get mode bits from special sid on stat")
Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
Assisted-by: Kiro:claude-opus-4.6
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 0588b7f76f5d1c..1b52e0c88877ae 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -887,7 +887,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 				 */
 				fattr->cf_mode &= ~07777;
 				fattr->cf_mode |=
-					le32_to_cpu(ppace[i]->sid.sub_auth[2]);
+					le32_to_cpu(ppace[i]->sid.sub_auth[2]) & 07777;
 				break;
 			} else {
 				if (compare_sids(&(ppace[i]->sid), pownersid) == 0) {
-- 
2.53.0

