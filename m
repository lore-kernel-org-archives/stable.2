Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71665218B4
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112226; cv=none; b=KvKFbJQ8Qu9u/o9nWf1UiCeGZirFqmJenESVKlZnDSfvhgHi53b06rTLWhUcONHRZd5y1Gdg6frl11vJw2Dk/F9zevRMcL+e4g0Bfh24xn6Ydzvp9LXyciWK+RIgrMoBWGgJFO2/5CXgTamEc7BDCYneF07zCJKUV+7kRC9n4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112226; c=relaxed/simple;
	bh=Zpo47GwXrTvLTedER9Qn2W4wilMPdjGrzHfMNTsxfCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUF+tWwui+w1FEHOM+1A091GWFVPUOiZ3+3lvH9vbpPUMgzpN/c5gP2UaMvkgwSBTCaJdJk+KU5itOv3dfMCsHWeaTv1ypFGOdGMnhrgQc/Ea4uA4SxJz/cHwpumLSuEzp7H2lH4iKE4z30eCLTe8DDJtNQZDBL6Mlwlq8Po8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSm4PFhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSm4PFhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360D71F0089D;
	Tue, 22 Sep 2026 21:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112212;
	bh=CDMx/LRlYqNLGDE9dT8OVQlsQ/2x/n6/ewRZIdOI+oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSm4PFhS9hw5sGw6yEcWWsgCdh+nnflUqfxdpzmXzxZ03Enz5+6QaNrWgDmXztTso
	 f6NvWU4w7xVVbO/Po3p+mAOq4XHkjh4kO28yMq/Wy1eMdv2u3E5VBApxXLbh5zMWR6
	 OuBXN9mgRG6XXeHsZ1iW3EKgXINPMleHCUN673ZxjszuUcT/aPkokCN2fY/qhlEn25
	 hyG7QY4Zs9RMZxB5yar+D3wKhbqlr8swgA87Y+1t1yOFId0IZ2mhLUI/Os1hsVvFPt
	 Z7om43XWw10XplZJmHPSlFiUCDSXPONpiZU8M4UoNNTlCsEBAMzDTqrpejuH7tQ7oD
	 rQu+YnEb/XBzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: fix reparse buffer bounds in cifs_query_reparse_point()
Date: Tue, 22 Sep 2026 17:23:30 -0400
Message-ID: <20260922212330.753714-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092256-matchbox-catfish-7337@gregkh>
References: <2026092256-matchbox-catfish-7337@gregkh>
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
index 5956d6657383e..0a5b580e52275 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3015,7 +3015,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
-	if (start >= end) {
+	if (start >= end || (size_t)(end - start) < sizeof(*buf)) {
 		rc = -EIO;
 		goto error;
 	}
-- 
2.53.0

