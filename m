Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDF432BF5
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235567; cv=none; b=HwILBGhnF8t1+LoE+24hF18yU9ryEfsy177gllfZoLgrtaewt3Collg1IV3fh0K4z/NfWh6fLkJzrOL/zkO/jr1T3wkXPFAJDDATDqA+LmUc59k4yEKojutSHl+Y25hZ9CM9gpEBvpTviP5ie5Hx1aFqXMXy/NSl+QaPZHTJQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235567; c=relaxed/simple;
	bh=7YWyQW2nIT/DP7AA69wm7GhY7/fhiC2zL73JCRhmnho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ+V+B9MwMU8/e9YQyxyo1aOPAfgm7oNaz+/UZfyiDlhjE8otXPTr4PeF3hf7rez0hUflYEO+sWPCIJobZ7kYgVY/UQwULhQaAalT4DNE6We3yxGjtyhQx7hzEloyjX+nDeA8d6zQCAFMTa6fnn8v6BhMscXCO4GSWRz6LcFxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiF8C91n; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiF8C91n"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e25187so745020b3a.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235563; x=1790840363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXIXng5mMMcvqXckQNVDsp9c78xkHqRtRXjDnEK7bWg=;
        b=NiF8C91notgKl4By9arR9KVwFe8+irxjBR+Kfh83LhkPjgdVLpHVtban+jtKE7mTuH
         KujtCJiSvA4i3f2v8LynMnAJujP0fh6ctBX8MI2KKCaZVxT1p1Suwr0E/YOutsk9/9qP
         bgZ5Aiqf9azds5xePAuYXMKYVpUcIvYr8WuvTYSzkrUzRJ8nu33tkvxEeLj6F5OQtBwB
         t608DUN9fcjJizcptoPI71CuB/E3CIP5aIXCo8leMaVaGTYYLN1SkiBKyu8LB4GLZdL6
         67LMuV2fTecoE7hcDrRQq6IHHomf7rGLKKxY9Ca4FEv92KGiKfsgY/gGtU/XZgTf8moP
         6j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235563; x=1790840363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXIXng5mMMcvqXckQNVDsp9c78xkHqRtRXjDnEK7bWg=;
        b=uNDXW5P4+k6iB4sNNL+VwB9gNynY574QmPI4F8wTVLsYpBMUX5DVTQcUcjs8MYNCr2
         kxxeDAKAXZa8cnx0gVjfsbK64rM8tjUUzme7R3092ZHNtET8+XaqYXLE2C0n0diRF72q
         ZACZYvX1rVT03jk46ZDSsoEzHXZhIzk8b8xBxBam+XUPm8I8LzhaqYZ951PhoD7zV1hl
         o1T5Fv/ifr2NNpsvAkIab7wbUVaz4nVmMwaq8f2bheEgBMnSFUrU0VXwRqAKQy7B4gGi
         K7yYaszLs36Kt/X8CFQA6CUaOUslUuVYmqsilsDmoH47Okwwxdn22VR7RTgOsdsauz8Q
         5V9g==
X-Forwarded-Encrypted: i=1; AKwUvBwan7Y2xDdFN47+r1WppxNdaV3ofstpOtORdF0tE3mHaGFH+LVKPU9j6AXHFwz//QB7B87P510=@vger.kernel.org
X-Gm-Message-State: AFuF++kyi7VAYOU4jklrdudAAs4926fzcftIONmLugJrDYjUTZpcXEu5
	vPVgZ2t84cHsAzbzb4QI/vlXxkQ+RoePaMCaNPw4HR+b5zWAyhmCFK92
X-Gm-Gg: AYBFou3Rl1dHYf14SCS3mUUwMwdmoQoopBDUL64SvI7u8MSg+Z2BZmsS3LzdnfsO21p
	PlcDkNGg83X+aiWZIWPcSmBBbnLiGJqre2aEgSbUeeH/7UpUPuq7Wr8gyVpYT28CERzPrqzmBHa
	HzipkHaS7yqwtUZnIKBwGR1Q0MOl5Q5b0Qey6JftWGYKiHM5pPGPbzNXUPqmJBYw3ELTQJs4vc1
	USrpq0mCZX8BP+9PtMcqKBNotoKFPHLsJPziLaeTvmDmnQC+6UO5bEtpWY3qGAv+fHoZfVFTXvf
	BwP8Y33vqky5v2cYi4dZ9MCgkBW1eNXaz9E7VYsTOSyftlS09xTp3lFtE9SqIWlelOsZO4ZPN3l
	2ZUjtwyVECCWSIlhLGu3/WLhvzhsgoelberw5RA6LmKASHPbGb6/UUYHGiRf25Hj6vycZLyX7dK
	lZTnE5IqK60WV1WMuBq4n4KNmQvjkJTmYunyM04WI0B0i+7dmE3JJsFcPYrtYD92DXpeJHMMMtQ
	fC5xYqZPb/pxhtbWK0pAJZ43Tk8r8yhsXf0bL8sLhI/RBPOhowaW5B01+YeA53DGczVdS/88WQx
	ycZgwOCqoA==
X-Received: by 2002:a05:6a00:2a0f:b0:874:705d:f63e with SMTP id d2e1a72fcca58-87e9b896643mr1227518b3a.32.1790235562568;
        Thu, 24 Sep 2026 00:39:22 -0700 (PDT)
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
Subject: [PATCH v3 2/6] qnx6: release bh on error path in qnx6_block_map()
Date: Thu, 24 Sep 2026 07:39:15 +0000
Message-ID: <20260924073920.2782917-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-3-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-3-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_block_map(), when sb_bread() succeeds for an intermediate indirect
block, bh is assigned to hold the buffer head reference. If a subsequent
sb_bread() call fails inside the loop (or if block number validation
fails), qnx6_block_map() returns 0 without calling brelse(bh), leaking the
buffer head reference.

Call brelse(bh) on error return paths in qnx6_block_map().

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
- Split out as patch 2/6 as requested by maintainers.

 fs/qnx6/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index e1981e4ae47d..444458ce3e77 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -242,8 +242,10 @@ unsigned qnx6_block_map(struct inode *inode, unsigned iblock)
 				ptr = bh->b_data;
 			} else {
 				pr_err("i_block exceed max blocks\n");
+				brelse(bh);
 				return 0;
 			}
 		} else {
+			brelse(bh);
 			return 0;
 		}
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog
