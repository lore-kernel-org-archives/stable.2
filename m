Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D637A842
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219297; cv=none; b=QwEPe9KZfv+GSgkbe69m1ul0ze5Cuy32pnW9TkI18KgOeYBDmyZUYnDGcggE3ifx1dpOLLd2zJNZQ+VH2S9xlGgkQsfk86ZRJ3mvI2Qje72JA9P3B5wUo+D4SkmawnBdhDb454R+xCPb2a35Pm/i6QqOHM2p+FbaVlEziibvVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219297; c=relaxed/simple;
	bh=fUr7ixu183sGMGJenCMYJCI8Lxg33qiUENi+1VzbX6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSHXmevrinxLkdBu1QvCKPBTQLznCG57IQtFrASUJbKcU2vO0INBm5xXuQAe+PtHRi5mhbwWgb2BO0Fno90s16LGA3cS3/hElNvRg1SfzeN9CwaneQhZe4OP+shwZKblrdS1teffyvFuPoGGUzmdUbVMs//cgojU1svGsIvoHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW7fBtox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW7fBtox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80671F000E9;
	Thu, 16 Jul 2026 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219296;
	bh=HFsUU1nBStxYRi5XCnsXThTh43emlFk+tsmZ1UUcHT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FW7fBtoxlB3SpHE5ecIGe2iAStIpGluffZOvnqp1E3rAWZHEFB/8cmKfY6deMvbKp
	 T91Y2f7ltkob6H4MbCx4XSUwe4MAtWo5fyfTxeomMpTIcavepxe/ltY0LrHfSqitfh
	 VzzHzi1eNmYqeomNlCPsvIGdWuU7kEXeRxFiZXw7UDhCBCTa+X3KYbZw8r1B5Znb+H
	 9BUCMsE+FsMqdlrQm49WFNHlEmK8doyh60AhR9KSlJU58LY2NxcOhrU7Ze9ue6FOqC
	 YXaDCtrA0/YLRez/tjZbPr/M3mNsFXpWHPpkkWjupRp3eZ8GtdwgQNbdcc24mRfOeb
	 gzr5AlnrT22zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Norbert Manthey <nmanthey@amazon.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: mask server-provided mode to 07777 in modefromsid
Date: Thu, 16 Jul 2026 12:28:08 -0400
Message-ID: <20260716162808.635328-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071454-prowler-bucktooth-a71f@gregkh>
References: <2026071454-prowler-bucktooth-a71f@gregkh>
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
index 472a110158eca6..c8a0a2edc6500a 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -767,7 +767,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 				 */
 				fattr->cf_mode &= ~07777;
 				fattr->cf_mode |=
-					le32_to_cpu(ppace[i]->sid.sub_auth[2]);
+					le32_to_cpu(ppace[i]->sid.sub_auth[2]) & 07777;
 				break;
 			} else if (compare_sids(&(ppace[i]->sid), pownersid) == 0)
 				access_flags_to_mode(ppace[i]->access_req,
-- 
2.53.0

