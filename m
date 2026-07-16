Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC3800
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164561; cv=none; b=FyLQbKC/ueCEbmqT/kf+4fgg+fHh8IaySmveEb7JXclCeOMVW+xM8sIeQdDdweGXQci3jMhw/IKIT76D3q9tgjgfpqvWAjkVkdrWDhJBDs8suuIwVoW/0UoRuxd2Cbb/gOmQA8mibGLl7h2qyHgRQ4BO8k/tESUvAjHxXHcPrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164561; c=relaxed/simple;
	bh=1J1YNde8O6hDwqzJlhsMZCPdD9P20mhljmzAqRaQQ24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoKXn3LNEavWrpY4IQz+0jNbXtKpFPZ6hiKwKNe1LDi1qOOV9Nout6V1le3GkDEEUTtZGrhR5rDQ3FO1aIcVE8Ghu/lL5xDEESnPOSJfPhqe/DZU11AfTxVjR3N30ZwPkl5ZJBd7jOpo8Zy8V+51cedrwavtzMyzl7iWPDNQV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrKh6hsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrKh6hsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146361F000E9;
	Thu, 16 Jul 2026 01:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784164560;
	bh=Bm68qltWf5EZUQ862OxuItJultFGHibyordENZAK8AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrKh6hscG4nHSoAKW/AhJM20qR8n6bMlEgY5zZOFha/WiLJwjN52YsbE0EPCK+h9t
	 JsANg+kMbqqmXvm9W+KNf5YbVt/NmSRoAzAEVSSLOa4rRPrHYdlZ96kNgMxYbCM2w7
	 1uSSirIzRSUbB2a37nZIdWlqXyU2NzR47uTwIYSdm6w/DQIrR+sI6DrRAFAa74yqXa
	 ProVwdhWX94xsF998VyC7Xm0LQSppDvOQYt1icZh1oKqd8aVqVpaqK9gRdi+LWg0oi
	 eRxO6k2rfR1XnIJ8UoqO8j3FIP/2I61WdRoEYa9qFK3URiGwddwqeAkEL1Sl8ctg94
	 IB+LvsUm7PRGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] smb: client: Improve unlocking of a mutex in cifs_get_swn_reg()
Date: Wed, 15 Jul 2026 21:15:57 -0400
Message-ID: <20260716011558.683323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071415-silencer-euphemism-ea0d@gregkh>
References: <2026071415-silencer-euphemism-ea0d@gregkh>
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

