Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886312;
	b=3Ngv1sAyzHSwtsla8rRzzxyH9LLKg2J/FQZbgBM+e68knyHK0SxswcXSml7LDSo74Y0Q
	 W5XJ82KDuRCuND2hDGquQauActy1jLdaoN4TC1VpXtnPOAWXpVJTtpmeqk/1X95mkB88x
	 N7BWbnIdOGKKrSSuM7HR1FkF/jikyOZ3w8Dc7JPXi2F3VSaA5vr8F4T/eK0X+R4F4bOAT
	 EQoeRLosynNZ+2QI5bEGeM+pjMk2KoCbKgeXBSUxdr+uHt83PdU8/gQsmojWctj8oQbr1
	 1YGsCLgniOufL511xtm5PlH5Kzx22AWd4sglXSTECMwfqC4dotPZT8BwzdgOxFYvHAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q3PNQYvkpqnZHcZzyX6VO+iB2EzZVB7EckleNkGV5Rc=;
	b=k6fJJ10Bqo4t15ucDjaaLNIroyGXLMBxXCQmvjhPDOCOeNbBsH8S/FHKWhF6RSPSJdtE
	 C5OCzDoE2KLvv2MyGQrKjeB4FC/PW+n3Hwj+CPaz7PlW4hiu97y8aCECmZycnSSUf3xmw
	 7nhNY0pN/mLm7x8zq3vWH8lNQK7YtniV8+3aFUm3yVTbIEue9BrisSXWWfv8yG9RWqelu
	 vxFjpuOmaF1tLh35le2iz3r86sUxBdsBJ+U0iJJrRHXMxtLX8JbzPYDIiWFmBo1XJdbs4
	 bHVRL1laGqgtO6fkSkZl5dGiw3HJzA9ke/99jC4wrQpWcQTqjUK72aZBGlEATOwA9LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwJWzcQh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA3606A331
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwJWzcQh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09761F000C1;
	Thu,  5 Nov 2026 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886311;
	bh=Q3PNQYvkpqnZHcZzyX6VO+iB2EzZVB7EckleNkGV5Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwJWzcQhNi4jKGWBIsvon32DrSepxIcHNIvtnun4QRj5pVPK/+V96FXgCMiH2GZCH
	 p9F1eFnW8fMoj8BK9Ie7BGqjZDAM6OxTvJ9+k71V67Yzi3ZuZHU2W75TZRi8mClwhD
	 ZHKIYhcXCyaU9G78udr/3dNFbQLYQNXQfwSxUZn4mvMHrxEQEves0FAmOuE24X1M9m
	 GU1qAFjTH2oq903JtXDdaF5HrS2BleSAqXS/t6IHQQGWWdTLr240mtN/iYcWtWlIxo
	 SmdOKIw8SEVMt7TDmfIhaSJ8TkdZBuZKdsZiOakrUBGUIZAhK4ihywlyplYhhhXW17
	 8nkQ17xfI4DHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: fix buffer overflow in corrupt inline attr structure
Date: Thu,  5 Nov 2026 08:45:09 -0500
Message-ID: <20261105134356.1397435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110417-filth-stumbling-5b3b@gregkh>
References: <2026110417-filth-stumbling-5b3b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 017dd7a84ff4cd2275eb62f4ee6d63c705bac107 ]

LOLLM noticed a buffer overrun if the xattr scrubber encounters a file
with a shortform attr fork with sf->count > 0 but if_bytes ==
sizeof(struct xfs_attr_sf_hdr).  Basically, we have enough data to have
a header with a nonzero count, but no space for any of those shortform
entries.  In this case, the xfs_attr_sf_nextentry() call will run off
the end of if_data and blow up.

Cc: stable@vger.kernel.org # v6.4
Fixes: ae0506eba78fd1 ("xfs: check used space of shortform xattr structures")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Retained sf->hdr.count instead of sf->count and omitted the hunk for absent attribute repair code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index c785d80bbfe50..76e977a367216 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -552,12 +552,17 @@ xchk_xattr_check_sf(
 	}
 
 	for (i = 0; i < sf->hdr.count; i++) {
-		unsigned char		*name = sfe->nameval;
-		unsigned char		*value = &sfe->nameval[sfe->namelen];
+		unsigned char		*name;
+		unsigned char		*value;
 
 		if (xchk_should_terminate(sc, &error))
 			return error;
 
+		if ((unsigned char *)(sfe + 1) >= end) {
+			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, 0);
+			break;
+		}
+
 		next = xfs_attr_sf_nextentry(sfe);
 		if ((unsigned char *)next > end) {
 			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, 0);
@@ -580,6 +585,7 @@ xchk_xattr_check_sf(
 			break;
 		}
 
+		name = sfe->nameval;
 		if (!xchk_xattr_set_map(sc, ab->usedmap,
 				(char *)name - (char *)sf,
 				sfe->namelen)) {
@@ -587,6 +593,7 @@ xchk_xattr_check_sf(
 			break;
 		}
 
+		value = &sfe->nameval[sfe->namelen];
 		if (!xchk_xattr_set_map(sc, ab->usedmap,
 				(char *)value - (char *)sf,
 				sfe->valuelen)) {
-- 
2.53.0

