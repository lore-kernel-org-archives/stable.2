Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665680;
	b=u9iJKO47qnALIhREmQc5YQ2coFjQlupw5gpiE8Qbyt5+DYEKt1gLh2dtERUwMNabpD0A
	 fv6gkGapW7aXi/uA40e+wThOryTnlV36gvAluBiFGdCpiEOYJ4TdHzWtU74jQrVNNONjX
	 EX1hALfW9pqEjc1db6pLQf/HGbxzC4GW7Hyzg26wUX2JQx3PGn4iF8OHL4JX/QoAhm9hC
	 spn1j3TP0Gx1Yktl9zf61zhxz+LiiE3c7EfRYM8/U7ctvRkF+eQO9Ty2Opr+cSwyTb/Wm
	 MRZq+Lys+/tUC7H8xlQOAmIFCEMXqlIOQwjFBYlt70lXprEe5Ty+ntI7mRptYoRcGyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665680;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kt4JTsXJeVt+0WtAzRJ220bHeUM4BWTRmRwfeAUlTk8=;
	b=LjLgSHkNQT471EhjkLJ4NYo8LrJJcRsmj5iHjSVpbrSwAaZTNvMO+7mngA1aLNGKfeBk
	 RCYtFbunVj+OAQcVc16gplEr+E11iu9t66+jDiiHYUv6O+heKo955hhwC9BEn+s7z8jBj
	 B9F/p4ISU9WYmyquxgXI5tNcXnvO4rzRiGGGPm2aFf+xDOF7HTtyTLanyRPAdRL+l6fyj
	 wU0mcL5r41P/LPAa3kjZgc1W5nhrQ2ly9cpUwY/SHLeI1gjOphxqvKSj61Oq4osbkrqYv
	 vF1X40Hqq/lxXQhLXxM31bgTjdH7ZWgq/csSV1DbCizoJv0OYJZv7fL0wwYSIhW29Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYwWTRLx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A1606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYwWTRLx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214621F000C4;
	Thu, 26 Nov 2026 04:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665679;
	bh=kt4JTsXJeVt+0WtAzRJ220bHeUM4BWTRmRwfeAUlTk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYwWTRLxF3ujVu9gdM+H1nhNu6ls91l67+1NK+rL6v38aQK87Pwn+FtcAj/JS4u24
	 eeogEeSSGNWSxldVI+6lI8RTlf8MqVwfpx2IidgFvQesSN1UewNghkp0eIlYzjNETD
	 J0v1y68w6dmDi8IQfLloB5kKy0hf7Z6ifQ9iRNOJV87ty0OLJfZhrhiEPtsNysz9f1
	 fu0qh3Vxua71Vfa45U8uCIb/Onh69HlyOPVYYdCZ63uWJ/TJtrXTfZMh0qhuvHwMfg
	 fSzCoOPZhKxCZuP3WrauhduLbLtSQ1BA2qBpYQ0+whV8igKf86+1IK7r5QBea3Cn3G
	 CY7GVusgeZNDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: fix leak of lowerdata redirect on ovl_get_inode() failure
Date: Wed, 25 Nov 2026 23:01:17 -0500
Message-ID: <20261126040105.1870857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-ipod-frantic-30d3@gregkh>
References: <2026112540-ipod-frantic-30d3@gregkh>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit f1b7e5534854043077bb72afc8d87ad1e0b283e0 ]

ovl_lookup_layers() moves d->redirect into oip.lowerdata_redirect and
clears d->redirect before calling ovl_get_inode().  When ovl_get_inode()
fails, it does not free oip.lowerdata_redirect, and ovl_lookup() frees
the already cleared d->redirect, so the lowerdata redirect string is
leaked.

Clear d->redirect only after ovl_get_inode() has succeeded, like
d->upperredirect, so that ovl_lookup() frees it on failure.

Fixes: 2b21da920866 ("ovl: prepare to store lowerdata redirect for lazy lowerdata lookup")
Closes: https://sashiko.dev/#/bug/linux-dabbd363-9c71-4915-af72-e2b5e75fa58e
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: adapted the fix to inline ovl_lookup() code using local variables (d.redirect, ctr, stack) because the ovl_lookup_layers() helper and ovl_lookup_ctx struct don't exist here ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index b932b3b7bcea0..15613f8ef5b59 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1310,14 +1310,17 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
-		if (ctr > 1 && !d.is_dir && !stack[ctr - 1].dentry) {
+		if (ctr > 1 && !d.is_dir && !stack[ctr - 1].dentry)
 			oip.lowerdata_redirect = d.redirect;
-			d.redirect = NULL;
-		}
+
 		inode = ovl_get_inode(dentry->d_sb, &oip);
 		err = PTR_ERR(inode);
 		if (IS_ERR(inode))
 			goto out_free_oe;
+
+		if (oip.lowerdata_redirect)
+			d.redirect = NULL;
+
 		if (upperdentry && !uppermetacopy)
 			ovl_set_flag(OVL_UPPERDATA, inode);
 
-- 
2.53.0

