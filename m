Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC150423E96
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890145; cv=none; b=INlNfkjVCeOKSkkzsNeSI+k/+zFZdQLj15mwMtn4gDdW828H6UFgSPI8Ug3EMIsbEasfGsVACrUMZrEtVvG7qYgIh9EKzyLA0DO/Msb8IqjyKfRbS64LVJmtR2iZOzkyhtBeJ3OprTadP3RPUUm11b3MJsdD98o77DNBZmZZeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890145; c=relaxed/simple;
	bh=SZ0lL73iMOyNNCiRwPQ6Ksuh2Z9vS5CWyIyDXTZVpng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BulZL1qzQlZcfifTJc48chhGcXZ+OHP7jYDyAWMNPIgL/PB0XtPTqOgTX5ou9Ii7ihh9V/SxAa2AFuaPiPCKatW5z8Y27f6OrAFEoH9PFxpc6deQ1V4HSUdIS4xK/043kvqspqX96hVhnkuoObdYuHanSKoFM7HeRzuV9Dg9P6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdeb6oaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdeb6oaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377841F00A3A;
	Fri, 24 Jul 2026 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890144;
	bh=llSbjBr/Ot0WEGhtGX+dbjPY5edNYCYWbx9kW1IUj/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fdeb6oaVCw4/Rhx032kR/7qfSR7fO80fMTQ9/z/g+6GxALzRYW9FwnwkeiCbIBBYd
	 HnR/7Ct49PHdpS15iiwwVrXlIbngO+xOp2hLLyFhIoFZy4mh0I/OeVDYLWHdvziooO
	 FZFATWzlmtecvKnHEQgvUgOSEdx0sif76JswoFAkCLgZd8LrsOL7qi2m4J7OcPzTVx
	 4Rj2xM5aXfao4PegsSfHmodCUVbLEhzvyGov/rdH1blmVWBvJ20et0uNje6TpuMVm3
	 itWss1GF3fjUfUdog/CksqnfSv+i6n2fTCZL0fc4a4KKr1y6sl18FeHuPy0awkLIEf
	 opZ1QQqJfwcfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] fs/ntfs3: Fix very fragmented case in attr_punch_hole
Date: Fri, 24 Jul 2026 06:48:59 -0400
Message-ID: <20260724104900.3973962-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724104900.3973962-1-sashal@kernel.org>
References: <2026072042-litter-retold-6915@gregkh>
 <20260724104900.3973962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 560f7736b94622c077344e2c541c43c63b4e90e4 ]

In some cases we need to ni_find_attr attr_b

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 5e7b598660cf ("fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis pass")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index ca496499db71cb..69e9ece120c8bd 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2087,6 +2087,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 				if (err)
 					goto out;
 				/* Layout of records maybe changed. */
+				attr_b = NULL;
 			}
 		}
 		/* Free all allocated memory. */
@@ -2106,6 +2107,14 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 	}
 
 	total_size -= (u64)dealloc << sbi->cluster_bits;
+	if (!attr_b) {
+		attr_b = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL,
+				      &mi_b);
+		if (!attr_b) {
+			err = -EINVAL;
+			goto out;
+		}
+	}
 	attr_b->nres.total_size = cpu_to_le64(total_size);
 	mi_b->dirty = true;
 
@@ -2116,8 +2125,10 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 
 out:
 	up_write(&ni->file.run_lock);
-	if (err)
+	if (err) {
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		make_bad_inode(&ni->vfs_inode);
+	}
 
 	return err;
 }
-- 
2.53.0

