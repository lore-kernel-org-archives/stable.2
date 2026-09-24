Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4482425CF5
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235570; cv=none; b=KR6hbSy+EOEj8N7xFsaB9GppBQqwYJWzQYj0YvccRFh5yjMR9DI6PO4EybrpxivvnXgvkDpYLzWiQwoEPm8FetqX6VUUVSRJiX1BDwaMnIprc18vKl5aO3IVcpzGhP+/e8AIdaZPUFMYpLber3tTio6ZbI/Fld4zNv59BCFkBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235570; c=relaxed/simple;
	bh=IXQA/g2/TtuU53NTwmNM9C9/HvhvdSxLCYNOlhYyQQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjNJr6MyxFcJtzxxLRAcmg/vCZe448Fczc3IGWR7JI8xNdv1RBi/74b1hwfsoK4ufxMGsF8Rr0KIPGkQAi4fFysz1BYH8YbBrdvzgwupfvU116AiqJDswFXOi3/ctImDi3Vheo8NY7npVlUx1yrnTPJnOtO1G1Z2Jk2D42CdXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s48Ceb5W; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s48Ceb5W"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso868657a12.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235564; x=1790840364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xs8AxoWUxhLFlNeCv96y8zKxhfgG9jkD4bCJjaoeEwo=;
        b=s48Ceb5WjJjdaSHK23h4CqYfxo3dVqtXQc12NJfukJducfTqJgnlGR+hSAtVIxwZ2g
         1ljXhTxmObVEx/dv/kEEKvYoXSdfY1+O5ue3/vKahh/GzfT9xKKICGVnLsmR2DSshvFe
         pKxhhN+pNui89pw+ypXgELjtvA5oSSP523MPuvszMCvWa8D9jC2edBS8a5O53W0H+6rP
         id4EvZfy/GjxcWgNPiebN0l8bGnX3TxC1dSrYF/VFURcbnMR9JdCoopkIoSqJgf/En2h
         1QIyyhbalTVuKuy4NYJSRib+iWxZUmNhiOWLG2YMJ7Prm4FXOWqd/gLmHykWzlLFu9do
         B8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235564; x=1790840364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xs8AxoWUxhLFlNeCv96y8zKxhfgG9jkD4bCJjaoeEwo=;
        b=B3AWcTR/PTf5QF86plsEHBTcO/6hQDxwv2ziHaLtQse6zP3LHI2YFmuUv6AvJHBOeI
         SNfJHXtWAPsYtfckkbvybPUNpg6Yc6BWn6j9KEJTr4xEpE90BjRjPtWV9ZjSu//gpNdo
         AU2H0u2FAUzDzcGMq3wolmqvts0+g/OShP4PW0RhrBycpVuelRlD2qpOh21Dkioi7QLv
         MxVE7Ghl58p4BxfQ2OlP80odjOBoECjl+yO1uwMogI72TmTfVtjpREdbpDXq4+BLYnR7
         +9H+f4PcGouSMqVyseBbijOJAOEcrrckz1f1dDueukmpOlFZ1N2YNY8WQJ42c6L9KRVX
         anpA==
X-Forwarded-Encrypted: i=1; AKwUvBznySWwfmaPIQWOdqd2U/cxCGQ4MGcPt1Q2giRuFenTSgCsUmGrVVjhHp4rBE2+cgoKbdS34fU=@vger.kernel.org
X-Gm-Message-State: AFuF++mOsKggkVpgNUQ/cm53YV34OBDq5hZZFwqQ/tBSx0wBw/jurIoA
	Xn13ei+8bqi9dxVKnhpK3RqCGgOpd4qeLbciXJi2xGQr8egDdfjEymOH
X-Gm-Gg: AYBFou3RpKOUyiUqIu7n5NJOWxSu1y0D4sX1dd4J1HZr8Zv2JfvxA2OGkDoe7Du57Jt
	ruVX9lIfHushlCjPMj9En1EBVFmYffGIEVOc9FHVtRYuBWLU58MNGuyj0uJcJdBtq/QhKcTnCcU
	pLu4NLWW8CLUNRhNIJTmGNzjQu5MEbKeU1ZzTLPzBhNaC7+OnaNM9Oeu5IiIgqQ7HOwmaFVb/bk
	K99AM5ZkzZRpjVj7byx/FREhiyPv9LuN5ma+CQ3udiAOxAC/Jzel0h5zfvSqkGJELNKzAi2mIzX
	Zz7snaDeaUhxmj/cfyuGKgJKuptr4OQNhWu8b/coYPzklnMj4D7G89YO24ntPgUdtFFg0UjGNbS
	XqRjgYPB+/TmNwnr7EwkYNWViBfkPzig66wEC0j3Ax9F82Bjbh7Up9gXzCzBmCt2kvvnDe306PS
	VDyehUG3pzsTEtY5WTCzFdSx8BVg28hR1H9LkxkmTIdZBWWHO2In46PMVJ6Z1Vjg2V7HOP/gQHR
	qpsNneke0ww6wjCrNGva6lV8bAb7TxS+xWJ99ffTtqzoAyPLyQCJsku1Sm6hkKEqWiFlOsWeT0W
	USWOQLZi3W1BJPxdSW1B
X-Received: by 2002:a05:6a21:3d95:b0:3de:13b3:e964 with SMTP id adf61e73a8af0-3de13b3f96cmr775896637.79.1790235564107;
        Thu, 24 Sep 2026 00:39:24 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm2393739b3a.42.2026.09.24.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:39:23 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	matthias.goergens@gmail.com,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 5/6] qnx6: abort mount on superblock magic mismatch when silent is set
Date: Thu, 24 Sep 2026 07:39:18 +0000
Message-ID: <20260924073920.2782917-6-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-6-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-6-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_fill_super() and qnx6_mmi_fill_super(), when the superblock magic
number check fails and silent is non-zero, the function prints no message
but continues executing into superblock parameter processing, resulting in
invalid memory accesses on non-qnx6 filesystem images.

Jump to the error cleanup label when superblock magic mismatch occurs
regardless of the silent flag setting.

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
- Split out as patch 5/6 as requested by maintainers.

 fs/qnx6/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 49e29a918a2d..a32066d98188 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -328,8 +328,10 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 	if (dfs->s_magic != cpu_to_fs32(sbi, QNX6_SUPER_MAGIC)) {
 		if (!silent)
 			pr_err("wrong signature\n");
+		brelse(sb_buf);
+		sb_buf = NULL;
 	} else {
 		sbi->s_bytesex = BYTESEX_LE;
 	}
