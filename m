Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F953806D9;
	Sun, 19 Jul 2026 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450736; cv=none; b=OBRKYO4pfPKXoAMy4KIbZET+p4/Ni0TWkAsO5mv+DjcG7Ck+BH3KBhtB2HFEpDfeKQrcrpdA7LYGbkpQET8QMINXVVoNKNkShv0toUMspDfCvLQ0HLUezPysVrCkJWVib0DB9sjzqDO59OlU9T/QUxo8WewMzZ4JjZrS4BJQzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450736; c=relaxed/simple;
	bh=mr5uU9bG1jypqHI5+oUDLAsVh1KcDPH3TiYZ2d1fmWE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=o1IOrl3GgliveaexVVTPpfIIAhNuwqag6nheKYKWqhI7XWGx5UffizpI6aOCXUiCkSO1/Sscywhy+4RlioB+3YxQBNNQwrv/RjzFJ9IAkfEcOcSiRHI1FzIKm1HWGL9qMOEOlLTfy0ryK+AOzCZa4gA+EIueq9I0eRxJU9OjlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iI4kFqPS; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iI4kFqPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784450723; bh=dUvX8gecFJ2u6baMcbOFCOLfemTBHpSn5RLuwC5A4MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iI4kFqPSnKO213Vb+OvYUIeoShKsYfvrFeF40f11/BpMQ75TIgyts64PeT5DrTm9e
	 Gvs1SR2CIt+p+66O9rzvxZfglq+V9vC93yguBr9M6TtjdShgo8w+Tr/I/vev6e9Ei/
	 xr2m0MNMcXvWE4frgK6vKQhdPWye87Ma7M1M11bw=
Received: from ikun ([223.65.85.165])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B5213A5C; Sun, 19 Jul 2026 16:45:18 +0800
X-QQ-mid: xmsmtpt1784450718tarqiyoj6
Message-ID: <tencent_ED3CBD42DCDC72213E6292A83A7924155109@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ7hi3npMz4REHgCb43EKtDQcpCCg1bQ7BYSLYUEYMA8MwGdlBQa
	 CGDza58dQ51c+W6O3yQ+6bbyo4iVMbPjZn0WhWxzXcvyFzOYh5tNVCbtybO9WfRPfppBNls9FKSh
	 vKGUorclOfrnjnlWA39oxDXYWgfbeYVi8dvDAGuGYHXg5cPrxJP3kP8J528dOpkVWOwF7O10e36u
	 gj5VtJpcRgsUH4pZFH2PMZsxvDwMMuEhIujpzF4yEiAcHpIjK//zziYJa0n036O0gquYcoX6tRkV
	 T+9je79OaQNohcLOu/+lQh+ZQcBzL5Luldf79Y9g1WCPLgTrspXxyThK7Ue8eeIMOn9a4bGfGxU4
	 f6knND1sSWModBTxyb7t10O3eGS/Bvv6LbSdMOqn3KGy7jy+luIeX3XP9vhecFe7kzI7+q5bzocR
	 Xs14ys/PnIC5V2JvwdrLNQH185aA08Fp5up5/Utv7gPE1clIwt48QqD2WKtuJpbgFD601meVpDbj
	 nfywIBffOOViqw8IpKuCKvmiHyaLXXKfikr15rb8bzbK2Y79iWJ3zlh0pcsHmxyGfTuwfSVfiMJ2
	 qndRrYXkhzn8GHb4/iKDwLvkHlCY10D53QvzZv8hvWh5hHJZfEC7pbSxtVfwOVUtWly5dcXbGU9E
	 GsIn37mdgIfFGoc77ZWFP3Cj8CckX8cmlGvzUiDq/goSm4DGEtenrGvUKDQ4zE6ldMVS1Q9uu02s
	 hA+mMG3pK674ap00vKIdSBA0W1fWyOvMCDC7RyvrLgojs0NBY3o2fFBOWNfTPRztnPQmzs5jRuaI
	 4yoisfKKG1tQqZo9obDv5Cj7FqvjClk1aMqa6CtyyY3EGY7nOG2Eeq3dxzoj9Eb5Oclia74mBvEN
	 Qy+b1V6OFXncQmzUJvpZ3b1GPk9i5l2NCp3Kc7GtBSFodVX/aq62p+dshdt+1Grf7xKT7JEyezGr
	 2sBCiMYpm1GnuwXu8n06SMYgX4rA3BipwPwDano+V7tFZeeh0ZeGYZJXo0g/siMjVpOnjMKzUnZ7
	 JffUkSZL2YtwxwbUK2YjEJ0ABLsnY=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Guanghui Yang <3497809730@qq.com>
To: jaegeuk@kernel.org
Cc: chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Guanghui Yang <3497809730@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: fix dentry folio leak in find_in_level
Date: Sun, 19 Jul 2026 16:45:14 +0800
X-OQ-MSGID: <20260719084514.586-1-3497809730@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <tencent_E3A22766836A9AE740D1CEF328C4DB8D0805@qq.com>
References: <tencent_E3A22766836A9AE740D1CEF328C4DB8D0805@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_in_level() gets a dentry folio with f2fs_find_data_folio() before
calling find_in_block().  If find_in_block() returns an error, the
function stores the error in res_folio and breaks out of the loop without
dropping the dentry folio.

This leaks the folio reference on the find_in_block() error path.  Drop
the dentry folio before returning the error to the caller.

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Guanghui Yang <3497809730@qq.com>
---
 fs/f2fs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a9563f7fcd88..0562ad211351 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -320,6 +320,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
+			f2fs_folio_put(dentry_folio, false);
 			*res_folio = ERR_CAST(de);
 			de = NULL;
 			break;

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.52.0.windows.1

