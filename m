Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com [74.125.229.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB404AA1EB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107130; cv=none; b=BymVt5DEnLY5vgL90EETckju5TiRwh/lUkmo0Oun+pzjKjDkMBQ2aK2urRmI91/lZCtPCX7FJc41fkEnsPPPsYTKgYUbd5Wi2yzvQZBsjGl4mmzeocQTCNygrFR9UxlXvNuSmAHwTjVtbqfnYtxGyQ1Z071m3HBNzpDJuMlIGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107130; c=relaxed/simple;
	bh=WKOh/3rPUbo6AQsl6PxuNwCtS+HOGnoHYPfAzkfTmTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rELYLGoc1ww5qIMtr7nN+Ru0XGutHmYTGjEb+nJ7jzKa8DBY4jmeV0CehATQip/LKZqgQFIW8GiX1ygVZ8UuUCw1t7hbN0QUA9LWPn1llxcb6Sg9cENbsK0QMbatc1I1307Inpj3oszyPbeg8TfZs0fNLHjOyXHvyU0gtx8YsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=OPDp8dZC; arc=none smtp.client-ip=74.125.229.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="OPDp8dZC"
Received: by mail-dl2-f36.google.com with SMTP id a92af1059eb24-14373bcc010so265383c88.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790107121; x=1790711921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BjX+mNuhQOmLJprMYKkZ8OPoLSpzkGrxDeWbqW/+m4I=;
        b=OPDp8dZC9ud72KyV3bUT7MLbrU2d8SjsIphqH7MnBzipGVTwlWGpBzHB4iwE6YHaXX
         na41k5QWFYXEGdHew5dek377TzotMn/0Haf7X7ztn+sTsZwfEXM87hao2bwQzhkJy1eH
         XcfglYVNz/jHmPO4rIrM7o5/nmsIhmqQvbqetHlxRfdLR3Jxg5/+xNuy8F0H+z9X9TJl
         3hDWS9zsCwfUz3bo9TSfsE6NsyxXKjGv7z7AtTwDwPq/NO4B1QAVjOOx8WfExJAvzeAf
         3W4+90DTKoI2fR/oZg5rPo0OWBX1jANqf6gOKTUQRalfjzJs6mNURZjaW+VcgfN1TKc7
         LTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107121; x=1790711921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BjX+mNuhQOmLJprMYKkZ8OPoLSpzkGrxDeWbqW/+m4I=;
        b=0nCi7j03pdi2Y7COEVpR3RVXrZZJ/0ws5m421unvPBLn0mevtAhMH7QSDsVgTBWh8F
         3/z4bfhDhCWJuzTCL3vc1ZeVeg1cUu7u+nVe540MVGIHdbKzeg1fLvr+dnj4w4v32bIs
         UBTfPh+1lEmFXIXbWqidMXWKRZD/NgDEGjENgPXiJkpX0GMbBbzDBP1IpkG6T08j6JwC
         vEY5m2KRAVPx89EviRIZyqggmsaECUo2ZwRHadI4HEzUUicQr8LwDoXUDGYIi/iH6pXa
         VOTw0k5ex5vMdHH0YjLLvXQjDrqqfg94fw40mjR/jtkBMSav9sGPtH8co3m/O4gECJMP
         IIGg==
X-Gm-Message-State: AFuF++lb7wAYjbahSZkSAan1iBdO+2E45kN4yz9KvY9zJVK7ogtV3hRt
	xvWDo1Ob1ARp5q86POVDp5msqH8tLl/F4fcbh46hqXlymAfnNFAT+nE75xHHUvg59wluMqtwxVm
	lEp4uEbU=
X-Gm-Gg: AYBFou2YX8wFlJ4dUjXKrZ2Ewr5FyWoGgXccgJMK2jDtCg2MO51wYerCsASuP30qdiE
	d3pmCoibWkJMX8aKgSGjlL0t4y4e6VpgxWh0xF6R7kDUYhplcG8/PF/6yia8zHNVzlTLSDDTDG+
	XIOHcJLPj7Mgt4MDSfo8MHMaQjP/auBRQx12zw2PfHX6WFeBXLL2I3kSvdiKtH5GCWB2jUXvZl0
	Lxnq7Ye8cTaqilxJq69zK3TO5U43rvbZgD/1CaM5CH1OJz6voCzOGNb+nOVKI07WBUc4UH5euCA
	3cpE6j8OwzR1GVZxc6OlRk0EapIBjS75XdjTwH1dW7ujQRfBzWJqwxKNlJQ1UbSaueJ5qPhNB2q
	sizlAKeE4Res4KqgTsvjoSPUoViQUSO6STdxY5IWKWYBb/BrCXo1xzSnUQ8rP2CC55OqioTKALP
	epiGIgIr2q70Mg9w09kpBdI3DqgOlQ5dmnet9eK9G20/gOgoU/DOQrN4TNLXyQ22Anw6ACXRjEQ
	9FQ4KsVbjx/Rp+fE+lFPRZwEt7ot3pE5FscoarQ+eFrUtzOhtYMbNU4xwx+73CEbVdXQoM=
X-Received: by 2002:a05:701b:4591:20b0:144:fa79:174 with SMTP id a92af1059eb24-144fa79031emr52410c88.44.1790107120989;
        Tue, 22 Sep 2026 12:58:40 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e975223fcsm459820eec.31.2026.09.22.12.58.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 12:58:40 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.1.y] btrfs: don't check PageError in __extent_writepage
Date: Tue, 22 Sep 2026 15:58:35 -0400
Message-ID: <20260922195836.27193-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3e92499e3b004baffb479d61e191b41b604ece9a ]

__extent_writepage currenly sets PageError whenever any error happens,
and the also checks for PageError to decide if to call error handling.
This leads to very unclear responsibility for cleaning up on errors.
In the VM and generic writeback helpers the basic idea is that once
I/O is fired off all error handling responsibility is delegated to the
end I/O handler.  But if that end I/O handler sets the PageError bit,
and the submitter checks it, the bit could in some cases leak into the
submission context for fast enough I/O.

Fix this by simply not checking PageError and just using the local
ret variable to check for submission errors.  This also fundamentally
solves the long problem documented in a comment in __extent_writepage
by never leaking the error bit into the submission context.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

[ Backport to 6.1.y: apply the PageError-to-ret change in this tree's
  pre-btrfs_bio_ctrl __extent_writepage(). ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and Btrfs maintainers,

I am continuing with CVE backports still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53429

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 fs/btrfs/extent_io.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 28dbac0bfab2f9..aeea8930b973fd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2299,38 +2299,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
-	/*
-	 * Here we used to have a check for PageError() and then set @ret and
-	 * call end_extent_writepage().
-	 *
-	 * But in fact setting @ret here will cause different error paths
-	 * between subpage and regular sectorsize.
-	 *
-	 * For regular page size, we never submit current page, but only add
-	 * current page to current bio.
-	 * The bio submission can only happen in next page.
-	 * Thus if we hit the PageError() branch, @ret is already set to
-	 * non-zero value and will not get updated for regular sectorsize.
-	 *
-	 * But for subpage case, it's possible we submit part of current page,
-	 * thus can get PageError() set by submitted bio of the same page,
-	 * while our @ret is still 0.
-	 *
-	 * So here we unify the behavior and don't set @ret.
-	 * Error can still be properly passed to higher layer as page will
-	 * be set error, here we just don't handle the IO failure.
-	 *
-	 * NOTE: This is just a hotfix for subpage.
-	 * The root fix will be properly ending ordered extent when we hit
-	 * an error during writeback.
-	 *
-	 * But that needs a bigger refactoring, as we not only need to grab the
-	 * submitted OE, but also need to know exactly at which bytenr we hit
-	 * the error.
-	 * Currently the full page based __extent_writepage_io() is not
-	 * capable of that.
-	 */
-	if (PageError(page))
+	if (ret)
 		end_extent_writepage(page, ret, page_start, page_end);
 	if (epd->extent_locked) {
 		/*
-- 
2.39.5

