Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F133612E2
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127600; cv=none; b=Qc+L2rYw9NtKVAbZMY5FBY000oUGpl3xXU7X2xvqf8xyfr5jUZOfgqh4o+WDocPgU2YVgJTwiztrK8tIRH/7Pk4Olm5yR0J08YwVgIBUyxQEhVJ62sqKCRtp3Bz5qAihtRLwpveDKUG1CU+SvivCjXtlAFFy5P7gkQ3RvEl5XA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127600; c=relaxed/simple;
	bh=HR7GgsYIgZ/Rb/4lNt1pz0ZDoGfXHL3vQBycl9FtuhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9Jo5hLgAhSAPXv8U4ljD9pjNNSCw4v7Yif+Awsfuq+7P7S8IAgAi0PX+t0SxiVmhyPpeaJia/G4EZ7httAVlG8oWTKr3TBwMnAohyA4IdFMoeGy4tDf0A/rluFKYFUmNXlOOdKl5EsF4MfJ8T18oSGWVEwZ+8+m+mIaaza2+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPdFtJ3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPdFtJ3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919F51F000FF;
	Wed, 23 Sep 2026 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127599;
	bh=bLUsQXNtHC3E+6OOMG6MvDKTwjuQvxrFYM6sO2de8zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CPdFtJ3BsDIjQ7kXYaJOUsYGHrWxHgiaP9qNAuwvCNm9GfogR4cAOuC/Je8rWRrxH
	 ynRgPnbme040Hi5YpR5n0U3Zyf20uasdUUoBvjgI2R/0vXEDa3Umj2C+3czMSBK8G0
	 MIbvdpBRXgMmei0mzYHvlbtI0joAg9U2mgNHpXC5cQkzfuwckDQWngU3lXfOQVeS8c
	 7ji5iq2EhRbAqHdPtZHnYz5NX1oZzqAoz39OvbvrUxpUB9yHZvVvjQup3WCe1CcQg8
	 A2ZbBlkv6c3hedhgxLfm9l/faK/OKJj37pHvVOQoxoNw3YfxIOLMtiu6uN0bJrLYbU
	 TNjevXAxPcgRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: fix reparse buffer bounds in cifs_query_reparse_point()
Date: Tue, 22 Sep 2026 21:39:56 -0400
Message-ID: <20260923013956.878372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092258-electable-undoing-fab9@gregkh>
References: <2026092258-electable-undoing-fab9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 5f0306e731e2f46e91419eae57eee3a241c055e0 ]

In cifs_query_reparse_point(), the start >= end check before casting to
struct reparse_data_buffer * only ensures the start pointer is within the
response. It fails to verify that there is enough space remaining for the
fixed 8-byte header of the structure.

If a server provides a DataOffset that leaves less than 8 bytes remaining,
the check passes, but subsequent reads of ReparseTag and ReparseDataLength
will occur out-of-bounds.

Fix this by ensuring the remaining space is at least the size of the
reparse_data_buffer structure before accessing its fields.

Fixes: 56e84c64fc25 ("cifs: Fix validation of SMB1 query reparse point response")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Adjusted context to retain existing `rc = -EIO` error handling instead of upstream `smb_EIO2()`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 01c78d9e7ec0e..df02e2d9204ab 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2829,7 +2829,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
-	if (start >= end) {
+	if (start >= end || (size_t)(end - start) < sizeof(*buf)) {
 		rc = -EIO;
 		goto error;
 	}
-- 
2.53.0

