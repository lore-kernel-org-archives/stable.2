Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F771438015
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235569; cv=none; b=fjcYx6fNBbaB7vGCxupf+lva6SOVTrty+W6GE0Ao9NSSsKQ2zXLhwA8TGEB378z87AR8MbuN18YORICi/q7X+4vJJZUD9x4lWxdFc54eR03CwkWZxOkO2gjJXZTNQCaN/I5mohbSGzPsCUn7J9nP3uFDrpDe58v7XzkbDXpxKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235569; c=relaxed/simple;
	bh=nAZX8R7H10g5spIAmS49lDc0sQxcL0bHv+WxBJnhyPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCy38QBSDSRTEeYbPw+1aemafngeFaJALsuCPs6kgChv3JegRMx4ZleNBX0tsjLz7oGqtLLvaagLO18gPnSt+AUNFfLNhrr5dr/XfBN3z/F9wPwSn758vqaP29oOtAaTRv+NXuGT3F9xwFMUuLmACiXEETIXk+8lRzxRUs+iafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4nrUmRF; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4nrUmRF"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b35611so855296b3a.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235565; x=1790840365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjRGNfMF+BIQhac//kksViQah83udRYtRSHNmn5Ukpk=;
        b=o4nrUmRFbsq0I5CPbtnWP/dzUMZTCaRM+2rosFc9HW3P0NooEKNwtDijhWI0X80xIX
         pgIfn3XuwhgrwFqLr75AMaMFhpjo61mLXEHG8w+cbZz1wKf2TPZh1Eu54UuKgdX+OQk6
         71pCyotBca170zvDjJ2AWj+/i41w2Q7eGQ6OH8bSjdBfeL/VrvB+KRw0QYuGRh02NWWF
         y/6iVE7GFS7Lc4vwZkeRBSBfI7LiMR9+/TPVzND0bSr79hBJ4mgKTZF5b7wP8BawBYl+
         WR0gplvnLyjvQV1W1U4l+KyBdH66whhperbrCOnxT/EbncY+xFGBHo1R9kvu+N2cgbTj
         e4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235565; x=1790840365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjRGNfMF+BIQhac//kksViQah83udRYtRSHNmn5Ukpk=;
        b=f4WvT1QNHtCnPclLccg3f69X6pAmTuCfsZwmu5mN1ZfE81wMVo8epxgQtpRncMEDA3
         J4djdLw0K+4pgQhVl4FuGuwFSnigvmGP39kIjyHmngoWide5zue8QbCah+PplNiLpUyC
         T8moiH+X44V8BxSps8Dm6/DUBqf6kQslHwukc0skLCTTAjwHBU4DPxDDmOEouX6qkoCX
         fVIZfQM8E0s9k0AcPeU5fXKTL6aRP76Z4aNHzhQytb8pG//z3AFEtDiqLKV8sZH5KMKs
         NaiWwfJLYFabpJ4VYMfg1q+X3+csOgyv7ksRXZ6Kr0Lsz5LKOz3NiIVfY8zpr3VOBo04
         KnEw==
X-Forwarded-Encrypted: i=1; AKwUvBwgU2e0Xgvn/ryK/MygK5lszo2DcsaH6C5oTHBuSlGA9lL366YJlz8aRjDbZ2A1rrtfLTQ8XTE=@vger.kernel.org
X-Gm-Message-State: AFuF++lzmXNrFSPh8YkACv8RiXemRiYCGpAhwrXAHV2tZ0HtIB4mMdLL
	olHBkhuy5uZ/Pb6EpYs1gQ/hysKwHUF0cwX8ZfHyqdRMLyhwt5W3zplj
X-Gm-Gg: AYBFou2NBMkhBxtCJF7Qfnj8bGAT5S3jlDHpCo+xT2H/hgu/Mhavj4g6P5I/ZmAM6/J
	9f8rUnjgS9AybvIYUuyVFMDvkvw62wx/ut/AfTi9/31uw7tNP3Cpw1yW0Ro53Us9U8GmnchgPc+
	HGMD58eBjreur29hS+2+ZOHSCTZb3iDsA2lFsnoVFR9CBZnN7bvhCiEvZ0w7UKEycNaU+J1ekPV
	Rqadx5C3o06fzxrlr0nlpKhIJCVwTIu2y8uLsF7ddddeni4YW6DY7bvH6LvTDUU7Q+GjkPEpqpd
	X2L3pG64Ut1QppIFgQVDTPqBwckX5qCccCLDmMeUSDGiUYFUtwXB3bbS55WTHNqhDNONMkcmcB8
	MXb7btPqiajqDKsCDqOxDgcNEwhW2P9KrH6u6adVGTZV+oQh9Oypfxg8IbOUg6DkrXLeoIUaDKC
	J1M8VILPoZZTX3CvPAMPPc//p8eTG77DKKhkWdiF7JkXckhJaE+wmCSLq/++YtKiZuf97JkO4kK
	oXiYfMYBRwukIamtTfqkON6ytezSrKg/rzDCsKZLv/pqbDrYLwItQ7xfxrje3u8gIpLXQodyOGL
	CcFu7DGIJw==
X-Received: by 2002:a05:6a00:8c02:b0:874:706d:9629 with SMTP id d2e1a72fcca58-87e9956a116mr1273156b3a.27.1790235564551;
        Thu, 24 Sep 2026 00:39:24 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm2393739b3a.42.2026.09.24.00.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:39:24 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	matthias.goergens@gmail.com,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Thu, 24 Sep 2026 07:39:19 +0000
Message-ID: <20260924073920.2782917-7-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-7-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-7-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), sb_blocksize is read from MMI superblock header
without verifying if it is zero or non-power-of-two. A corrupted MMI
image with sb_blocksize == 0 causes a divide-by-zero exception (#DE) in
qnx6_mmi_fill_super().

Validate sb_blocksize via sb_set_blocksize() and verify it is non-zero
before performing division.

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
- Split out as patch 6/6 as requested by maintainers.

 fs/qnx6/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index a32066d98188..b8f9e6022e11 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -375,6 +375,11 @@ static int qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	}
 
+	if (!sb_set_blocksize(s, fs32_to_cpu(sbi, mmi_fs->sb_blocksize))) {
+		pr_err("bad blocksize\n");
+		goto out;
+	}
+
 	return 0;

 out:
-- 
2.55.0.1082.g2b9226bbc0-goog
