Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B3D2DF136
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161836; cv=none; b=YiCz+q7OBBSOflIU+owc2HF0saj80U+E8aLXxygwoFYAHYvO5KYOTzXOZZiyfO+AUeu265/fpW8aJJkUh7wmtFZDGAzTZx6WuOo2yQMWeL9RdTcdB4uz4DztAsAEt13G/sYGHGDWexUVCpWbtjJdUH4OBKsOXT5vXd7XdtpEmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161836; c=relaxed/simple;
	bh=1J1YNde8O6hDwqzJlhsMZCPdD9P20mhljmzAqRaQQ24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq9SvwPiKzqrwjWA7MKIvh9GjX58qG8Yijzs61Cpgltf7OC5gDZiRH7HfKMMBUB4fFPK/kBJutW+wRVIelzbm2O0fL5yPDNeJT6dvKLUmIv9ld/gwsI7ev68A5SCzoFKnT8uHqHFX1faK+8l3XXp/yr2JMb0+BH3nVIWCJ8O4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi7iu5Yv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi7iu5Yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDF31F000E9;
	Thu, 16 Jul 2026 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161834;
	bh=Bm68qltWf5EZUQ862OxuItJultFGHibyordENZAK8AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oi7iu5YvQqPX4OTWAMyWyUfh3s3R5KvvvpesO8LsXeC6umbA/QypmEZgZisy9ktJ7
	 l5sja8vopzGe5d+rHCs9+LxTtaObMXEgD7mlu0lTnWD4xZVWjGVVN7DaVcJnyvqC7k
	 OTPZoI8pZKKKktdwRfigefPzccSWDz6k0rhqE9RD/Vd3wm4AH6T2oCVWQqB80OfARu
	 l8WKJw19X57fAWdzI4cqJZCuudQfL9b5rq5pfiCwNeRemsHZlCq9A/r0ADpb1v8c5w
	 1MY0cr1+gPs+tDQFJA8ZLJz8p+9OmCTCh4C/BSrQRU9W3E9aDXZ68sRuu1pGgIZpGe
	 Ct0s/LQJOonOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] smb: client: Improve unlocking of a mutex in cifs_get_swn_reg()
Date: Wed, 15 Jul 2026 20:30:31 -0400
Message-ID: <20260716003032.615867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071414-lyrics-clunky-efa5@gregkh>
References: <2026071414-lyrics-clunky-efa5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit e2080b70c5851a132547bec3bd7dde847e649678 ]

Use two additional labels so that another bit of common code can be better
reused at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: ec457f9afe5a ("smb: client: resolve SWN tcon from live registrations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifs_swn.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/cifs_swn.c b/fs/smb/client/cifs_swn.c
index 7233c6a7e6d70b..35a3e73c195806 100644
--- a/fs/smb/client/cifs_swn.c
+++ b/fs/smb/client/cifs_swn.c
@@ -313,17 +313,15 @@ static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
 	reg = cifs_find_swn_reg(tcon);
 	if (!IS_ERR(reg)) {
 		kref_get(&reg->ref_count);
-		mutex_unlock(&cifs_swnreg_idr_mutex);
-		return reg;
+		goto unlock;
 	} else if (PTR_ERR(reg) != -EEXIST) {
-		mutex_unlock(&cifs_swnreg_idr_mutex);
-		return reg;
+		goto unlock;
 	}
 
 	reg = kmalloc(sizeof(struct cifs_swn_reg), GFP_ATOMIC);
 	if (reg == NULL) {
-		mutex_unlock(&cifs_swnreg_idr_mutex);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto fail_unlock;
 	}
 
 	kref_init(&reg->ref_count);
@@ -354,7 +352,7 @@ static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
 	reg->ip_notify = (tcon->capabilities & SMB2_SHARE_CAP_SCALEOUT);
 
 	reg->tcon = tcon;
-
+unlock:
 	mutex_unlock(&cifs_swnreg_idr_mutex);
 
 	return reg;
@@ -365,6 +363,7 @@ static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
 	idr_remove(&cifs_swnreg_idr, reg->id);
 fail:
 	kfree(reg);
+fail_unlock:
 	mutex_unlock(&cifs_swnreg_idr_mutex);
 	return ERR_PTR(ret);
 }
-- 
2.53.0

