Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AA14FC8C3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075068; cv=none; b=mhBwPlj3U61OsIQRc7u+Tt1GvGFFBDb/HgpyPifbMDJRC/6Og0a/DvKYUj5uNnFLNredQUqBGHlQl939QtIf2XpPlKgbuoPrlnq5oIZtpA0hLaKIp91UnbVcyY1cYY4jxQUcV26MIO0E8Q0HY84RsEvKVN6XCiQXvYTGq402FGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075068; c=relaxed/simple;
	bh=9LeG/POK6782l8D8zDak7cgCU08OUHoQU+yEMWAKPa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDnHLad6+bHX2VX/OG+9ZEkG6luliMj/2jRnurDU6IC2FUHrLlAqmIcF1mMxPTKdsh+CABR5j6leMs3oEg3hzdTcl8lvoq5vjHRuSWYRgohIsU0z8v1vJipBhIKYjfv3gOdlCgWsQ2XqLDAG3oM/f7xKSZEvJui3TnuDt21oEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX2hJX9r; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX2hJX9r"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso34945085e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075066; x=1790679866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YD2iteSGKYJtyP/EE+BDAK9nGq/ymOW6rse9Kf3cQW8=;
        b=cX2hJX9r+rh5XA2KMcdzGng8zlXFnAJ6DfkpvoNsJhKY0HaiFlvr2fvj6jhn6Pf0Jx
         3nwJzGaM1WCpcMnwTHLCZnKMT0gvNp91NVjH5pQVh++uNHk4nVsSsW4WfUlB12piuusN
         EJyS7ue1L0CCVnID/tI34WG5y+lw4asXtgnN4rUgCYgMAV+ps1MTN0d1fngoUOy7aHB8
         BXOkSsyQpNzyWFogDiULdoQxONzyLi2q5tHHI2YpE/0q5UYrIFkAao5KP1f8HfYwmirE
         lP3FhEidc4mM0hgQVLJvI5a4PNMg3/SHkDjlEFmeY4Cqw9swqSmhSpyeT3lSUxS8dUVE
         z0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075066; x=1790679866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YD2iteSGKYJtyP/EE+BDAK9nGq/ymOW6rse9Kf3cQW8=;
        b=XQ+aSUnUMeOgKGr/wzWzI5nFrdr3Q8s3IPEXxGjn/GfN817druWSqWkvTVktKCaFzH
         7DmyImpZi4arao4scg85ky/ySFU8+kZ4G+ILggRgIS8VKNsswA48/IfaFq3VKk2giWfu
         aKttcTV2WuQPrw7KPs998jffqz41Je/FoEEAxXBeVvCvh64eCflcFbdm7BIf+fpOPhTW
         Tr2O43zjf8EXGzf1A4LtX+BbfFZmATPSI/+cCmdqyRaRVd7tZkNjEfluQDMXKRDWmtZB
         qa6o9v4iV9Z6sopsnKZN+5fXklywk47rEdmUijb7cOFpQG2SkB0Zq8RgGcdq4Nr04nzE
         +Sew==
X-Forwarded-Encrypted: i=1; AKwUvBxhld+CD3IQeKQhoNblqP6yyzjYwtO7rHDTf9OKjD8ThzeNi8rv9st+0Mfhf/6XjbT2u8jfzM8=@vger.kernel.org
X-Gm-Message-State: AFuF++n2PNM7FwxFSSwNW8LNlZT1szEYDYRxmWM8OLvw8bb3Akd416H6
	VidslGGr9rv1qa+C9laaD50I56umhUaaYpKqtHcvb7+q2Ty83m2X/PJX
X-Gm-Gg: AYBFou1nKb64lr2b80VnlY+BJZ/KZ+USh0XB1fS/4TjgqA8a35Evln3AwhtXpmpqF3S
	gqfRs6Rf+DzBMUhN7CJKwURZ8rx6FvGAVhlbN/2gEORUyCw1eVZdbkutSAwIgfW3HEzCBHSqoql
	6KVgudEyGErLbyxUg1Ma5Gj20wkWOZcD/DLjq1swVn8aMi5nl98zFITfnvzMHTFF95ASkaaDz/d
	dG153B05hFeCqmouNmzov6NFMwyyIJycw3FLUFsmj9qW5ScPFdmZRMUrYPsif5wbbYsA9bFcyG4
	jFaZm09ExRTUeHqXvIhzCeas3HLNwVQlOjNNA2+b/VuxdoL1cvPoeq5CYfXCtUbl9a6bSBtSTuq
	4z6S70HUWezRiuTUmb5XYXrZSDfKd5BNTNEWWG8ZNBUeXRVHc0MrYWu3a0e9hk+k8KKvtuPgJYY
	QelxZYI4sLm690HFyBNT6ksIDC4ssrlZbBKp3iD+ch5Q2JfDmm1n3Q/wka7fFFTAM+RxvOCHxUZ
	znqtQCKTowVqkNoAcKqfA==
X-Received: by 2002:a05:600c:3547:b0:49c:fa21:e73c with SMTP id 5b1f17b1804b1-49fc574121dmr159480735e9.18.1790075065473;
        Tue, 22 Sep 2026 04:04:25 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:25 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 11/26] xfs: only flag zero padding for dir3 data blocks, not dir3 block blocks
Date: Tue, 22 Sep 2026 13:02:06 +0200
Message-ID: <20260922110221.1431-11-hackerowskiy@gmail.com>
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

LOLLM complains that xchk_directory_data_bestfree can be passed a
directory block that is either in "block" or "data" format, but the
check here unconditionally treats the dir3_block and dir3_data blocks as
if they have the same header format (they don't).  Consequently, we can
incorrectly set the preen state on dir3_block blocks, which of course
we can't preen away because dir3_block blocks do not have a padding
field.  Fix this.

Cc: stable@vger.kernel.org # v7.1-rc4
Fixes: 939919ccddfcc3 ("xfs: check directory data block header padding in scrub")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 2a037aae904d..19d974c7e2b7 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -492,7 +492,7 @@ xchk_directory_data_bestfree(
 		goto out;
 	xchk_buffer_recheck(sc, bp);
 
-	if (xfs_has_crc(sc->mp)) {
+	if (!is_block && xfs_has_crc(sc->mp)) {
 		struct xfs_dir3_data_hdr    *hdr3 = bp->b_addr;
 
 		if (hdr3->pad)
-- 
2.55.0

