Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B73515C0
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964720; cv=none; b=Ns6u014T5NZzci7dcxDopSI0v96uOpbcVpLHRVqEqFwZm1NZWw/87YR+x4wnCck3TAEAVsAaAKv1wda+NhfYrvf0joXh4hnwwg4OtwnO6OF7o3NQ3mNeLx1FEUO/5oYmcjKkF5X39tGjkQ2SV1toVIMLNoiqqq/QikVWWW5Ug2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964720; c=relaxed/simple;
	bh=o5a8cwchYptTJ18OlpOPh8cxQZIhxGe/fRbf5AoNx+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfnZ4itCe4SmH3tV1SpaFdgOMfY9CmOqQZmriXLCUtumUjlVbIo1GAp/t5PuQq4Aflw8RM6n9jxQhbzQLcJm9d3zeDKc7yId1Axo1sALZhfWbOI0IEg/WUjZjDIoCbCet2yO3EcUBi9JV2s8Xs5pWNDZpfHMwtoqA149fGSVV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoaHgwix; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoaHgwix"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1770838a91.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 21:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964716; x=1790569516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A2auV0/VE1Iheg/PPPrS18TZ3S2aE13Fg8YmU7kSPxk=;
        b=aoaHgwixZOjyjCqvmfFPYxEbMTisz/Yi+Bf34aEjdnP2oIKqn5odWq+AlvQ9lRrj0P
         HckDteinIXc3NWUN3e0K/FwXHLLy1bF6OfQtcIQgrL1Y0FtcMJEwHKxXB2P3ztEW9YFO
         XYZXmxbfOgXnD35EHhUtEJiZ+YB5IFoKtLhn1ejzDmSKKib1bynlRaM9HMGnQ201wOrg
         u2KL7UUPxUqdXlkqAErDcRhfuLyQyzium6ehP3vSF7T/rdH8RKr+KFC79oe4B4CJubz4
         4qoiAvrHGOOtKDH4/Zw8G7FExo9i+HGkrYKBaZOTK/vr38+0oaA+VVO+8wN9b/U8m5QF
         wRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964716; x=1790569516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2auV0/VE1Iheg/PPPrS18TZ3S2aE13Fg8YmU7kSPxk=;
        b=J3NUxv4gdldnRstJUEgS1D9dVtPT7s0pvAtd4/YAmD/ewxpgEd3GNQZ1ebRApGwqVt
         f0lYQw+TQrMT7tz1rG4+4bnHYAnOZl4BUswQ2gdrXgXnQ5TRXXfHLxFu2FsD4xaQHiZd
         6KYlcD/mEvp3yon0hkkialKpJuT76QrbSHSnMzWNu9BnQsWUrxcFGHPalJhjvKYrXa58
         f2VOmKW/Ucnt12lrsYl8KVGlFejyPj9NCQguY2zhJHtmeXU10SH9WjwoIgEi6EP/pnc7
         xF1rh2qNpxOpKFWwUwx6Xa/WB4MSqJKXW1rqr3E8GvUK/MwejAKCXtLouuJwMRNO2BY9
         E18w==
X-Forwarded-Encrypted: i=1; AKwUvBxSWrajU2XRn6KKNxKUBIc2pIKaO2gvHWv8sastfN9tiujzqFXJitwBCDYmf5HZJSHJhkpT8Lg=@vger.kernel.org
X-Gm-Message-State: AFuF++kJPFEUZp7g2wFjfSI91Liv3GcWtN9nF5hcZiDPoQaQKsy7ZK90
	hX6cfOkHBDUeWDCzTx9QdTtmmtjjPByQ0NFOguP2cJmnl4ba3bnGRm42
X-Gm-Gg: AYBFou0YeIBsSJxoAPa8QTb9okwxk8ys8tliRbVW0wJgaPVyYluQjDIGDV6viTfVwPg
	V4sA2o+pklVeUxOf01H4da0pGS87lV3jcEnqLSIMSIYquGywj3xX8dvA8V3b0UZQ1F5wQq+kcgt
	vir2hcelWSlrP7456oERg44JJjQw1GWmOYIZT3f2OOBYVtl23cv8qiWt3jrDYHNvFxAyVaum/gS
	DanR7zPjZecANtdjWUu49EbiJqKkFegou8EtbhQ47GUxfHC61yXfel9+b2ejJHJI3S7g1UAX07F
	xuUt7NGIZbVBfS6zJ1iDRMrXa4tvwUab+H9qqqneu4KG+olOv8oxZZ1oBto5n2UqgAaw7IiPNb+
	M0EvgM21WkRBo2532cGFdoHnRevnBpRYbvl5ujWP5IyKFBjIsg5xqSaxqKv4uIS0t0IZIZ9w1Id
	UtN6yscP8rcpKBS9nbWsP7ZsocTjcR+f6Xj886MWCOwoNLt4lDRZJko4MzclfYBXW48S6Z3GQi/
	Jday7WZpgd6Z7AuHe/Tkoiz3YuxXEjyfigNmnjf0o1l8Lmqj6+pd+soD2PNNC3D3ibSINkib3GZ
	Z7zZ2B9aYQ==
X-Received: by 2002:a17:90b:4cc1:b0:3a0:3d1c:2dc6 with SMTP id 98e67ed59e1d1-3a03d1c38ecmr3528951a91.66.1789964715575;
        Sun, 20 Sep 2026 21:25:15 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm11742139a91.13.2026.09.20.21.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:25:15 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Mon, 21 Sep 2026 04:25:11 +0000
Message-ID: <20260921042511.1473629-6-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921042511.1473629-1-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
 <20260921042511.1473629-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), QNX6_SUPERBLOCK_AREA /
fs32_to_cpu(sbi, sb1->sb_blocksize) is evaluated before sb_set_blocksize()
validates that sb1->sb_blocksize is a non-zero power of two, risking a
divide-by-zero when sb1->sb_blocksize is 0 on disk. Move the offset
calculation after sb_set_blocksize() (matching qnx6_fill_super() in
fs/qnx6/inode.c).

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted QNX6 mmi_fs
image with sb_blocksize = 0 on /dev/loop0 and verifying that
sb_set_blocksize() logs "qnx6: unable to set blocksize" and rejects the
mount with -EINVAL before any division takes place.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the qnx6_mmi_fill_super() sb_blocksize division ordering fix into
  its own patch (6/6) and remove Markdown formatting from the commit
  message, as requested by Damien Le Moal.

 fs/qnx6/super_mmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index 18298e273a13..28cb9322278e 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -63,15 +63,15 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	}
 
-	/* calculate second superblock blocknumber */
-	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
-					fs32_to_cpu(sbi, sb1->sb_blocksize);
-
 	/* set new blocksize */
 	if (!sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
 		pr_err("unable to set blocksize\n");
 		goto out;
 	}
+
+	/* calculate second superblock blocknumber */
+	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
+					fs32_to_cpu(sbi, sb1->sb_blocksize);
 	/* blocksize invalidates bh - pull it back in */
 	brelse(bh1);
 	bh1 = sb_bread(s, 0);
-- 
2.49.0
