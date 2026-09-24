Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7D427F89
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235567; cv=none; b=ia3aCQgFj36lX004fm3lRNIiJJN+jRj/bYhO0s/kEJ/kop/TxVDZvAxV6zGPEYiJbYex/fJwkk7YllvU5aO7EM7d6izqxMmO3i4UkjyzXqmc65Uf0oc7wGuBUg90U0Yi+Uhn+aO4TtiliTVIzxzEvf1vycvmsETo2ZvmIwy2c9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235567; c=relaxed/simple;
	bh=PjIKux1hcNvgxfpiHRvfSPqe0WlSzXEpKyqS/KZzy5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7DEfNUXBOW2bPY1yWDyMPFRgmOuDdgGf8JkH4sZVE8OhGcjG0nonTKN5oQGGjOpw5S21IZMR40fKggt7fUlC38QfKo0G8VsM7ze+9osSvAnkNdHLO/qcekAb8Tnp67kB1jri6TXuArJ25xTBoi6LlNJDc6zEjS4SNH1gjxf4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG5w3nd8; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG5w3nd8"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1074771b3a.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235563; x=1790840363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYOjaZsmA/UC/cCkN5UkTpeL0qbdNP9RpD8AiUnhENI=;
        b=GG5w3nd8eVJrszCocCjdL7iCie2GQLtXDwqz64kvch7WrNVhmNiWd63D6zIuRT6k0M
         Gzv9eAJdj0SSuS7PdsIdWuqbTXGinE/oTHeKuETh+io6+iEloN25c3BZJCx4MHpI7w5i
         +GYuHiAxR7LCYP1Ur+kfnI07H/vEscv3Wzgz+D9XJAHHSjMDSALt0igJUmNIh7o/tPYh
         YynMKa/7OcGtp9+OwsXCkYn73lYYK/KUlTb8BBMY/U7uDtt5xSP0grfJiM6b87H/Xs8r
         OofUgaS4lX7mNdkBmBdpiz/lMJfz9gOXjBYsES/G9qJmQ+dpfy4bSjBtDJ7/SbSNptTi
         FxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235563; x=1790840363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYOjaZsmA/UC/cCkN5UkTpeL0qbdNP9RpD8AiUnhENI=;
        b=A5fst3YmVsJkEOy9/9DhwSvxSX2qC5r4+hmapdKRfM9If3rt4LdEjRXWEf7L//ig3A
         gqgmaHN4b3OPTBU3nMeSCs+iHqUgNFq5r7OhLsMMVXqxYlGxLpud0zs8fme8S4dcsEw0
         voc1+YIQflgC2QrQwlRfx5P8SCEkV7HihZcFwxL3fSVzpANp4zp40tnubZ3C7YSWrB5b
         Lf3Ix/Dy/FQIpWI7U5b8ncAqSBScy17044s0nZmrwHL5ivDXrYbqtvhqmHPg2x9IfApp
         6+E1IjN9G3QKJwdyvLthhnEyAB6d9HoO0gFLyt1KpT1KhPINpWEpoc07SqKz/iGS4LKo
         5r1g==
X-Forwarded-Encrypted: i=1; AKwUvBwMszKUYO5KTjuuz/vV3b5ydh8qT4Ke9Ok55/oX1YX0f0JZNUAOz6wGH5rxHmvW3q7dCpQfXuw=@vger.kernel.org
X-Gm-Message-State: AFuF++nYxOKl5aqNILhqS/C5DMFBMUC3JpdJ9SIElYkRS9UY2iPPQuIV
	tidYXqc40uwd2l4PLOKRiDuVNeDimPPuS9KcI3Bxwi2gvul9CN88FJ9n
X-Gm-Gg: AYBFou3763jfh61cuXdJosXTn+5Vi9fnszNuHn1IO3RwwG4NksJl/3p2tI0p++M1AXq
	G6vTtSFQz1JvGpjP1WGHu1NnQ6u8NPZbtMZz//2AHokEPxKnrdsZRY/rUqNSBvL6ld1SZdRnRWA
	nMjTbV1l3jFhiSfm74FXm8glibrqhudhYAfgoibUTT9iusICWZMt9L/F1uOKtXgGRb8uHeyh5DW
	dBnQfPTF/LIVSHuMxGoGxIsgJI4wBboJ0c+huOR4jZoA8XCUHQwwTZI+4h8SS5RMrUtHQ1VOP1w
	RAqukxRT5J6WMd3vAp70BGtbqKJXgxKyi0OWaWI469fqP+rsopWIKmkOkJSwCpkGH+v50iWZx7Y
	pkj/IV4QoXYjymGT45dB3+OCmGAY4eznMZg4a4Mlf9agkK2tjXVtyHk/9gZ1QftLDcGUl1ueDKp
	wVeZGsuZh3grYZFhIM1Q/iJoszu98rcNrV0h7JFHlgbnqLgtuFFozo3kVW4CaMkX2CUsDNAghtU
	OaNNV06vsZz3juEh/PgloUPbVef3hSz2uSmPmhrmDA0CVhcj3DrA8b08fB/zNKNegMH6MwK6/aC
	jMOisDpZiQ==
X-Received: by 2002:a05:6a00:3d4c:b0:86b:b06a:d3ad with SMTP id d2e1a72fcca58-87e99568559mr1319879b3a.23.1790235563022;
        Thu, 24 Sep 2026 00:39:23 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm2393739b3a.42.2026.09.24.00.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:39:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	matthias.goergens@gmail.com,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 3/6] qnx6: avoid double brelse() on error path in qnx6_fill_super()
Date: Thu, 24 Sep 2026 07:39:16 +0000
Message-ID: <20260924073920.2782917-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-4-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-4-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_fill_super(), sb_buf is assigned the return value of
sb_bread(sb, 1). If parsing the primary superblock fails, execution
branches to out_sbl2, which calls brelse(sbi->sb_buf) and then falls
through to out_sbl1, which calls brelse(sb_buf) a second time on the same
buffer head pointer, causing a double free / refcount underflow.

Fix the error-handling cleanup sequence in qnx6_fill_super() to avoid
calling brelse(sb_buf) twice.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Add Tested-by and Reviewed-by tags from Matthias Goergens.
- Update Fixes: tag SHA to 5d026c724220 ("fs: initial qnx6fs addition").

Changes in v2:
- Split out as patch 3/6 as requested by maintainers.

 fs/qnx6/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 444458ce3e77..70438cf5efdf 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -348,7 +348,7 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 out_sbl2:
 	brelse(sbi->sb_buf);
 	sbi->sb_buf = NULL;
-out_sbl1:
+out_sbl1:
 	brelse(sb_buf);
 	return -EINVAL;
 }
-- 
2.55.0.1082.g2b9226bbc0-goog
