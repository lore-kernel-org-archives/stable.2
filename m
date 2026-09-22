Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160715372D5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075063; cv=none; b=eau73w/JcsPDYQK4F0+rLwx4YiQSUsUcDp9AbDOdKnOT9HPU+oavHuKVcDFhpx3pN4F2j/LNM2mwW6dvZkTlWzbHb2vj2cscmsny25DnpMdRzz1AoLknzukC9Dmk4Uu7MFN9gfu5D/B/j++H6g9bxPiki4vXLt/beGJ88UlDZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075063; c=relaxed/simple;
	bh=S46k1f+cwOwzVTWjS0tNPmenov1DO6QVpUxVGjVpyGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1ojAEFPRH7WHEBXJmN3jA3b5oSdThzfu887yjtpCZFPx5mdCpn7WD7u+PEme791EkpeWI2x4PnxGALsq1UdK/upacqYSCwRioCtHlzaHeC1WUOtPp8UzC6aXf8y5TCW7zGOGcsenBPKqWQMHvpGYqWB70XtRdmOXjJWaZuR2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNwwoSHP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNwwoSHP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so20746615e9.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075060; x=1790679860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVhG3WREwXwj9LcXH8TbSq3Nlslmhj9o3pbFkFFS7E4=;
        b=tNwwoSHPmXH85apVksCd0e8vYmJ6iKkNnRxYKJMjyG20WJUM3PVUKcDECcp2KjoBi+
         m1PCVG9cNH0UNpxZ72x3bpXjsDWuX4zfKmt0WnDpef1MD4zm7BYtt+hrkYDm6lIa76r5
         hSmfUSE3aLnwDiYUl1U6SrZ0gCzmRWwZF9snNK+tb2yNoxN0hx4th9LBScPH+BF7ILAr
         GsRPUkiOWaBfP7fBacIweHPIihyNa+ffp0SlR+yEAaI7jkjCUY5wX2pM0YN5diShSlU+
         G4gG9F4swUz4Nq20pY17zD3CeaymnxfNiH6ZyzQfhBhAc9IYdEyFCwTUW4H00+/i/F+H
         pUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075060; x=1790679860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVhG3WREwXwj9LcXH8TbSq3Nlslmhj9o3pbFkFFS7E4=;
        b=0oJhQSZ3BLc50f5Q+Ppihw6DOcNXos8GuFusVyLiyOIH6vYqO0hh/Rka4WWn9nRL4N
         P9XtZb8HXv4C+ANLgkSZUsz+9KZ2O1RUMoJwyW5Uk+ldwfFxN27jB9DOXPiCx1qDF11Y
         GVbPq7fZytXp1e49J1dv+5hKP/PkqQz2HHP9OHtf+PABpacOmm8uRP6DxD30QWGfEvWn
         NdvEc5pnloWjqen9flfDiIw3Zke2NFOasQ1Y3y2HRQCXlOgFoUInoaIr9tQaXqdqWE8N
         /7+mC0rbBOYtH2Cp+timgOONsTYO0biEBbg+ujIY/ekWqzOBsfs8N0Fj1UCG8yjNVe3+
         6Xaw==
X-Forwarded-Encrypted: i=1; AKwUvByBftVemlqrh3/Vep7a8zBraU4M6O5CJ4LokyBLkuj8IqoiG95MCKAKXgq5BbD9ae3RQdGOM9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++l/ZJH1O/y2270AznMlnrhH+bE4Zsrqk9P69EZFnK1FwiO2CoVj
	IayJptdHamXIzvhiGUzmsvWowwmwR3hhE91jXhCMoqRdm84jnUp/r6jc
X-Gm-Gg: AYBFou114RRlCi8eP4GgXcTUU4TJTsZWIw5ANh6Wov2ojMAImzwOg5atG/BkNDrAyrx
	OZwoU/dYUgOfFbfV4neyro6c3VZYj6rv+Zo/qhbdiQZ8LeIpsHbNnV1v57W/wMCkks8RSaWbUBU
	Ue7d3tcDlBwjrS1QK4WgSScCmN3bBQGomKENdVdZye5YjiGxzX9tRKcBFPei5jeuYZIJh0gleCp
	8PXknVYCwaRGzp+F+ZDEADg0eWhxi8cTnRAUNwQcmfWM4E2aiux241aBxrrvUnr0jUP3y7neovc
	5CUwinWa8yB5sZxb+OTKNDDPi58GHJdYM+Sk14X4GGzdp1C37vKa/dWwkVKPRJdjtLA6b15hp/W
	sisQWErhQS5Q0tKKJRjAzsEFYN7Pcg9H+kTEJp0dP+Yqx7mo5ViQDfAZupFAHPRS5SSxXDwDv8x
	cTykcvPOGZgpc20sH4SexVOU2WRDA+7DKc4KA8cb8MX65JFFEbCpV/Q0/GUqK5eLLX3VhLiZuA2
	70ncXmYzFY=
X-Received: by 2002:a05:600c:3544:b0:49e:7c8c:bc77 with SMTP id 5b1f17b1804b1-49fd8868d52mr39231445e9.7.1790075060187;
        Tue, 22 Sep 2026 04:04:20 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:19 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 08/26] xfs: don't call xfs_exchange_range_finish for a dry run
Date: Tue, 22 Sep 2026 13:02:03 +0200
Message-ID: <20260922110221.1431-8-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM noticed that we strip file privileges and whatnot even for a dry
run.  We also shouldn't flush dirty data to disk or trim COW staging
events for a dry run.  Neither of those behaviors are allowed by the
manpage, so fix that by exiting early on DRY_RUN in various functions.

Cc: stable@vger.kernel.org # v6.10
Fixes: 42672471f938cd ("xfs: bind together the front and back ends of the file range exchange code")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_exchrange.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 07090487c581..fafb4e3f065c 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -633,6 +633,9 @@ xfs_exchrange_prep(
 	if (error)
 		return error;
 
+	if (fxr->flags & XFS_EXCHANGE_RANGE_DRY_RUN)
+		return 0;
+
 	trace_xfs_exchrange_flush(fxr, ip1, ip2);
 
 	/* Flush the relevant ranges of both files. */
@@ -709,9 +712,11 @@ xfs_exchrange_contents(
 	 * other file write would do.  This may involve turning on support for
 	 * logged xattrs if either file has security capabilities.
 	 */
-	error = xfs_exchange_range_finish(fxr);
-	if (error)
-		goto out_unlock;
+	if (!(fxr->flags & XFS_EXCHANGE_RANGE_DRY_RUN)) {
+		error = xfs_exchange_range_finish(fxr);
+		if (error)
+			goto out_unlock;
+	}
 
 out_unlock:
 	xfs_iunlock2_io_mmap(ip1, ip2);
-- 
2.55.0

