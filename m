Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114197;
	b=sV3+5fGO8Mt3lxPOLhVJamAfY9vnfn1cKctWXIK9WlF6t4CwLPw03t0gVE7nVbHM61Hn
	 CAl4gru2VrQPeZxpP6kBI1l6P520qC1R4B63huipt+oEX7oDN/qDzQPph5yAMpvdsJNUd
	 DNbxEJSmepIsL5WubrfGGHIdU+o794TubMi3vhy19oRReX3FO8LUQtpVcI7q/jxKIxBhn
	 rD5BCb2dpm1756lgwG4QAyT7VQ4MBfHz9gXTt5xYDcvcerYf0kjYvSssHSqpGvn/S0vH9
	 DYqgKuYLOQC+pDdyiHwN5Aub23YbV3TsB+Q/r9wfKAl9dD5CbQfvBivqhqnHDHmqFHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uTppmobKlXCQMDn3ZVLxidM0e+PEeg9PY8KBlnC43UE=;
	b=X+D4eJ6Dxt/QMRxWhbYr865nCNR8WKNvuLgOs2zn840o5kdV2JU8wLIGDMGs/ojnQbgl
	 23qkva4IfPyrCyUGlUBOyaS3Rg2lkNOMpnqN/ZRR58Klm4xPVnvreIFKbhZjgwyftbBWI
	 Vs59vbqvK2J9R+UiZ9RxS+moYEXvY98YmQz8EcTrGaNaAwDizdblfouVv8eAvAHCEPU2g
	 JZCz6vOuxEGKabZOjiXiNPsEMmNAWuZ7yK8TArFEagoaNYWGm9JUzZrn2Ei3+Gab5xoeY
	 HZ/tbJz7Z2q2gcLFHdBDZ3D/PKd8MPcMZ4/19un1GJ49zoPdGK0goP+mh3RsgrRMMQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E45A7aCi;
	arc=none smtp.remote-ip=74.125.231.139
Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B5606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B89B5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E45A7aCi
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-828c0b569f6so1804281a34.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114190; x=1793718990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uTppmobKlXCQMDn3ZVLxidM0e+PEeg9PY8KBlnC43UE=;
        b=E45A7aCi61MU/blkZE72dtLfe7C9BLMirAPuvC7djnoj5oT7666j8k2GG/oUKL3hbv
         5hhxwpqTjSMetX56AsLS03dd1i2rE8+ZBBGRLribP4n1eFthw8KiyR5Qn1C+H3KxYWEu
         rIx9AyYL/mBUb+aucQRu8OzMCqUioax5nfCImwaq8sBMWi3l+uqJtWi7Sd6SCuO0zN4Q
         5MuRxgHpMEG9B/yKkdzSU6u6z/JiqtW82z/fKSs1wdeIu+3FCdOOruHDzYHeRlfhUb3J
         HH7wTl26p2yFhyxlBTzS6hAqFu4H1//0OaunyBnpxc8x5uIgOkKAIGRBVv2+ygabVYo5
         a8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114190; x=1793718990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTppmobKlXCQMDn3ZVLxidM0e+PEeg9PY8KBlnC43UE=;
        b=TgBv3iHBh8g75n2ZKMkFyGepyxq77s7cl2KqCQWu8Nkz7Lbqk4HqEUuXsGL9mWGK3n
         Gp0d8UeK0r1ubu1QmgDqdWq3bALbVQwt6XWMbjVYj+Is9JNbsPSwuFvwAOCf33L3Umiv
         arOOVvFXwZzOwTU258HBCsCAiOyzMN7lKCRrwVx/OxpQ2DClgpw2UjLLVgyrPVZGiZRt
         11SMbdmfo3trEYb7pTi76GBH+Jj1tnSpCd6QgM9ZMHcBx2/E7NjIfHZqo1WtVmO25vPb
         fQFyEhygQ0SGWXFJ3CnaX7fhx5lNg8/LHhkmH3eYJQAYtIUAVizsj7n7O8+zav5dTyDJ
         2OGA==
X-Forwarded-Encrypted: i=1; AKwUvBxss6ih4dICFnH7w/k8oyX4zQqRm/JwtutrGy9sExML3KT2miPIwMRAEuiefjka6MeH01NwF5M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcHIaJ6yclJo8egbNKx5lfP22vO7Y0wpfDvWxJ0KX8BiCJlm7c
	M3JySjUA7kTMpVLLtv6na42P3jFLTQFt+m+gxDJAcJLxLD0lLHmto3up
X-Gm-Gg: AYBFou3ByXsvg2CeDKaCNIc4tq4lK6ygA9fbBHyumwCnE3qjPNwJKkPYHmE0KnATAu7
	fUGxBCVHs3DucnZf2xL/u3bn4fAcv1m/iAWqiTQARZN6lu2FpGdCnwuGcId1Ib17YycZrmQ0lCI
	KDPNsxHhTMPu0OHpAi4svzNQ4OR3fjMCl5su841k4peBOwokpAmcdRtHTTMvRC31syVdKyozDex
	bk6o9k61YREP5NRjy36TXVI5ti+kSRJsuQDtRo5xsNRbfw2iWnwqdkfhPnBsULzr1zL0L48YLRA
	wPxi97YGnhbPaXCgr+pD+kMAu/O55mLzPkrZ3TrxUJEZRg2aSlyuRiGKYiJ0Y9G14O83qGXN56l
	87a3Fz/P3cOB2eaL413Fnh8BXSoXeUCPIfvulibUGI51C0qUB87pyB69Nd+JbDNktp/I3iHRLhw
	iCNziWQIKoOsXXU6jMx3m1EOuC84qbDWw5wLyzuiqTIDlPcRrwMvxVz9ZZxyITp+YXlYYBhoYgV
	Vy/rWzH/luPkpd0RbGdGYEy+mkF1WBW1Lypo5//oX7wY87LLJTpSpE7sc5Dpgyora/RhIlLLZVg
	SIk5lhJ7sFBr8WilRCE=
X-Received: by 2002:a05:6830:4393:b0:81e:1262:6536 with SMTP id 46e09a7af769-850fe4f7abemr8973671a34.15.1793114190396;
        Tue, 27 Oct 2026 08:16:30 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.40])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d7fsm10768970a34.2.2026.10.27.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:16:29 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix UAF in al_destroy() on stream inode eviction
Date: Tue, 27 Oct 2026 23:16:14 +0800
Message-ID: <20261027151615.971171-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

al_destroy() unconditionally dereferences ni->base and frees the shared
base attribute list:

    void al_destroy(struct ntfs_inode *ni)
    {
        ni = ni->base;
        run_close(&ni->attr_list.run);
        kvfree(ni->attr_list.le);
        ni->attr_list.le = NULL;
        ni->attr_list.size = 0;
        ni->attr_list.dirty = false;
    }

ni_clear() (fs/ntfs3/frecord.c) calls al_destroy() for every inode
being evicted, including ADS stream inodes whose ->base still points
at the base inode: the base's attr_list.le is freed while the base
inode is still alive (iput(&ni->base->vfs_inode) happens only at the
end of ni_clear()), racing the base's ni_lock-held attr_list consumers
(attr_set_size, al_add_le, ntfs_load_attr_list).

Stream inodes have no attr_list of their own; freeing the base's list
on their eviction also leaves the base inode with a destroyed list
(size=0, le=NULL) even without a race.

Only destroy the attribute list for inodes that own it: a stream
inode's ->base points at another inode, while on a base inode it is
self-referencing (fs/ntfs3/inode.c), so the ownership check is
ni->base == ni.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 fs/ntfs3/attrlist.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 8710560cf2944..6aced486a45c7 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -29,7 +29,17 @@ static inline bool al_is_valid_le(const struct ntfs_inode *ni,
 
 void al_destroy(struct ntfs_inode *ni)
 {
-	ni = ni->base;
+	struct ntfs_inode *base = ni->base;
+
+	/* Stream inodes share the base's attribute list; freeing it here
+	 * would race the base's ni_lock-held consumers and leave the base
+	 * with a destroyed list while it is still alive.  Only the owner
+	 * frees.
+	 */
+	if (base != ni)
+		return;
+
+	ni = base;
 	run_close(&ni->attr_list.run);
 	kvfree(ni->attr_list.le);
 	ni->attr_list.le = NULL;
-- 
2.43.7
