Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FEA72630
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730454; cv=none; b=FC58RgZko1u7y1xy+h5rVvrSRweHMH1Jf0DLzuRtVqV3VamW7fh8EdmFnoWsT2J0cnCXtmLHBRLYVHwaW8v42fqDLtpTEXbVlJNhWDRNnxk4tjNOMr6u7/TcJRmLG6d9FPNuJ5VtbrLE6HkbACP32Vnb/825jm4HU9GJiuBJpJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730454; c=relaxed/simple;
	bh=dsrb2nnlzQKp7GUWZetEFF/tjXJmHfUQW8Pen/ISFcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4sXTpsr9qBppIXl0Naf5y04ZhU/0nAW3pI9fNxAfGw+8SprINnj5EVnqsmnf8Fl9MCCrW93Lp7q6ONfJsWMn556bJgfNBhG/pWGLPqK7aM3jRZC0aONT+JDphUU3Y5IsNCotWMLluxJZv93W9s2XhYSCv8Hv0Qkz8XEChpzc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Zb5mAF6I; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Zb5mAF6I"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd025d06so3500163c88.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790730452; x=1791335252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zaXHRhsayLLA899a0yLIQYT705UjULcNm+T5JbX4Jjk=;
        b=Zb5mAF6IQZrXlI5N/aWj19PzFMOmZ+q+TVjjjFHCrraTcOOuIWzOToIzAH9N7pZFMT
         roRmPxKo952Z8BH0eirYauEix1xC2dl2GWilTmD4qeL+TzANxi2CTNZ3p/ay/j0WymWO
         BqNB7+HXRZ+Quf4XiugkoRlH15/CfKOVbens9YSxkrYCpH/aWXPKnG8Zeh3mNlFSI57H
         ekJVVF8R2v3/2cIHbFIYT4k6nbqfS1pDlUUwSR9kZHwrqp5WCl7WnKiclwBlvJEjGPUU
         BhBLH6ecBlkg4+arDafvDNnwNwlaTa92wyM7Y20Fj39ldCFQ/VBvIlCEiDJSBvM/airB
         GvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730452; x=1791335252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zaXHRhsayLLA899a0yLIQYT705UjULcNm+T5JbX4Jjk=;
        b=nwAkivI0+u/AzjB6tJexLPfn2iRmtQhxgJiYep5bQaeWxp36qw2qGN02sTPOtJuRfY
         k7mVWjkPvVgfZE8etkrOWzu4+wyHe820FCT48+b/y0j3ae7W8uSqEHVpLhohwLuI8uVX
         z0v+W4NWFMP+5ezK/hQwNGq+B24wFWMcH5hQ4mI8KcS4fXLvOCbah3bWlzArts/ZvBxn
         KY8jJ3fu1xyEtg8BIzegsajyDJmYCfynfICUKg0+6P4Ng5QWTKfwg8TB4CXXsxrghWZp
         lZpol2DiZfwoisGisrYvllORePRHrbGV0I9qfCdL1rR15LX6fDyHMsDFrwkkrEV6Or3Z
         R4ow==
X-Gm-Message-State: AFuF++lwRb4oKOxUQOcdnm2QVVuTxf2gTZk1QG2Rg6IR85HdMTwcexzj
	UbU2otNhPuFDjIeCkvbFKGfcW2x8O3hT/jjTLzRUu9wsphl69UEfRZPac/9+Daf14jg/pj8t69A
	dw3PiSCg=
X-Gm-Gg: AYBFou3Z92aZfwQHj30Qiz5WIu170n8ad8onUfovQ4Q4r91iPdoayw3m3NAxf7ZjTVV
	0NTHVcILKGxSreEaheRIAKHqEJnzPHopXanS09+0Cf7PoZw42Je1xMuoKmmJjuTtK6VZ/wkzIdE
	JSiLwpvauRDhOC85yuAd6ad843XlDx3D/mUYdQNAPpiAIOA0ffdUi0/mDZna1s7Z2SDxn5yASwS
	QAXCD7LyZaWzpC0bEJ1/ooZ72i8ua47b1mD1dZSEfth9qJ4zyCPR/AdUANm+RmYlnCFcsrsVUKL
	T9vIsuspBx9ostUxlXRvSC+BeydYtsa/VBpLcOHE507R/iwtldJ82Vso2i4WG4gVK5F0ZKKeOBJ
	Nep9k0jwE/if8vR5y0Kf6EdpaJCl2GmsVNFCsGxc76gOAYPxJcRZQo0C/qdy/XhGFkCqU7jcaUV
	qxh7DvWK1qATHy54WikZk4YQgw01Siaz7U5l42KEE3Sfpb6CGnFMtvrAJptdT1JTwS2UI0srMWy
	z511rXq7zu7lWzktNr4zgXwFdr5a8ru/QNPBIOm8sPajP1g84yLb3v5nBqXwgZ05Nh8RIs=
X-Received: by 2002:a05:701b:451b:10b0:146:606e:1f62 with SMTP id a92af1059eb24-14c9e29a175mr1040002c88.41.1790730452081;
        Tue, 29 Sep 2026 18:07:32 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14c60c55ed9sm2223598c88.2.2026.09.29.18.07.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 18:07:31 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] ocfs2: Avoid touching renamed directory if parent does not change
Date: Tue, 29 Sep 2026 21:07:26 -0400
Message-ID: <20260930010728.94306-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 9d618d19b29c2943527e3a43da0a35aea91062fc ]

The VFS will not be locking moved directory if its parent does not
change. Change ocfs2 rename code to avoid touching renamed directory if
its parent does not change as without locking that can corrupt the
filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and fs ocfs2 maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2023-52590. It avoids updating a renamed directory
without the VFS lock when its parent is unchanged.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The code change is identical to upstream.

Could you please queue it for 6.6.y?

CVE: CVE-2023-52590
Upstream: 9d618d19b29c2943527e3a43da0a35aea91062fc

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 fs/ocfs2/namei.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 113102009431da..5776980402de95 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1347,7 +1347,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 		goto bail;
 	}
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (S_ISDIR(old_inode->i_mode) && new_dir != old_dir) {
 		u64 old_inode_parent;
 
 		update_dot_dot = 1;
@@ -1364,8 +1364,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 			goto bail;
 		}
 
-		if (!new_inode && new_dir != old_dir &&
-		    new_dir->i_nlink >= ocfs2_link_max(osb)) {
+		if (!new_inode && new_dir->i_nlink >= ocfs2_link_max(osb)) {
 			status = -EMLINK;
 			goto bail;
 		}
@@ -1608,6 +1607,9 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 	if (update_dot_dot) {
 		status = ocfs2_update_entry(old_inode, handle,
 					    &old_inode_dot_dot_res, new_dir);
+	}
+
+	if (S_ISDIR(old_inode->i_mode)) {
 		drop_nlink(old_dir);
 		if (new_inode) {
 			drop_nlink(new_inode);
-- 
2.39.5

