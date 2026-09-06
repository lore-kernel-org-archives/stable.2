Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453BB3B71B3
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715147; cv=none; b=FrtP25CJa+ElXqXoRclexfKtjqS7IfLEO+R4Wm/qzh1qiwBi6Em5LUabFB6qMsrHxQCywtHMivjR94zGnuDjhGv5A+QDxrJPRG5Mv6mNXm0ZA8Cpd1y6EAErT793QxhIkVSAyeXnBQVltbLOOp8ELShbgu2E2PYyxbWePTqEtWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715147; c=relaxed/simple;
	bh=Sjtzyz3ys4mxwfnKdOGYEVk1JEHDSqtqe3Vo9E0qkT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji9/d2ms2fer2qOEY8mf1x4Hm0K5btSi6qLeZeuTUtZXo7pz6WuYU8cGb5TYbnt+lH3Yy/7oSERwJxh8ZpdvTy08JnEtxFSEdKI9DWOdsMAdq69PwiaEnxJEPm3xeZuxJg8laxGLw28ZIY+ij2uXyHTX8xToE/vNUNsYzAlCAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIqeX8GC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIqeX8GC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C46D1F00A3E;
	Sun,  6 Sep 2026 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715145;
	bh=FFvPivXBb2Vn8LYCDeA/u7P7NRclfM6wMaCMXd93UoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIqeX8GCghNwguCihvdHnQ68/5w50lau31wfmk2RZUvOqxLvVxOtYaYoRHLsd+uf6
	 SB/ZdCPo36L4z7Vp16Xg/Yq6I0d5CKLCg17hjIfPOdEO/+fmGS771/12SwlS5MTG8Z
	 MRWhZSpUmSJyZAT/00kl57/wmelzM0144LWN8P6IpYbih+038XS16LcZx8I2KO6o/C
	 B+m01UNA5b8JHCCO04L9Vd5mP8BgHEPIxP36ZbRgoqvziqBN1Q0BeCnD6htmhdnkws
	 u5BfzjkC5oYjxziGfyOpN0tHv0XjaxwaXwsBbSxrO2zCxPmPsJY9k3RhNJo8CFyAqg
	 TQMFvYtOpbtPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
Date: Sun,  6 Sep 2026 13:18:59 -0400
Message-ID: <20260906171902.1684623-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906171902.1684623-1-sashal@kernel.org>
References: <2026090300-visible-upwind-24ae@gregkh>
 <20260906171902.1684623-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 3c9258632c49436558f10776be1809ae051cdb9e ]

We can already handle errors appropriately from this function, deal with
an error coming from __add_reloc_root appropriately.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6d8ba4572922 ("btrfs: drop recovered reloc root refs on recovery failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b0d34879e267f..8ac37034c6561 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3862,7 +3862,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		}
 
 		err = __add_reloc_root(reloc_root);
-		BUG_ON(err < 0); /* -ENOMEM or logic error */
+		if (err) {
+			list_add_tail(&reloc_root->root_list, &reloc_roots);
+			btrfs_put_root(fs_root);
+			btrfs_end_transaction(trans);
+			goto out_unset;
+		}
 		fs_root->reloc_root = btrfs_grab_root(reloc_root);
 		btrfs_put_root(fs_root);
 	}
@@ -4087,7 +4092,11 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		/* Pairs with create_reloc_root */
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	new_root->reloc_root = btrfs_grab_root(reloc_root);
 
 	if (rc->create_reloc_tree)
-- 
2.53.0

