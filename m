Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177953ACA75
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560030; cv=none; b=M7KaqzsrORsWa2Zm+7KDhfVRsrLuFnMJ8tXM9pSraKaQ3Syx+KnHmQu4XBleplHrCLGvg3PjcH5O2mQ4YzCaT0AwCOcL7mtfCZnFaAc7/b+la2UIl9bk8d9J2Nctwv38i5XfAlEo/Y4neGG8WqbdQwSauSmgpEtHPDikiH8lSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560030; c=relaxed/simple;
	bh=iO0WOKLJYHeCiXQSmFOX5WJAULuW7dOAGV7QorpsBUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1b2NYrMKINykNRt33GSp8IMBf4wIs6+BFqAAt4/Cf8UnIUwrPuA3pIAoqyAqYRK8aH+1amQsj+T3n2wyLQD5uwnKonPKjuFpSW3prBqvX7erhhpcgrMahN5UOi6lDxdgQsKRgMAcJke/XTTc0S9kXCuSm9KOpCPq1fOW3Oa+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li6i+my+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li6i+my+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381b831d535so4541365a91.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560028; x=1788164828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HSkAieVQa1JTe8qhVM2kCKaOCfjEKvx10b2NLcrDjss=;
        b=Li6i+my+RObq+pYRpLSpe5E4RzyT3+WAmEFguA7HVF2EZR2kwAVTT4XmNxwF/PdVXK
         hnOnp7zD0wKktcXB1Ubn1Hit4FESUEQnrXwisjlRXib5gytmLxWg5enilp/TLQw71Grp
         69Qq8Bi9IKkuxyNCsMwLXthMU/8X8J440a81n13paNuJWwlIn+CZRUaL/bvaPzekmoMd
         o3CH8fmbieZHPMEAHMr90IJyPbmujjfttEz8gqgEOJ4BNry/A7s3Yh7GClKO3l6lVrVS
         k1eKSChCY5+BW1DmVzxXqnNMiwWz/rEC2rag+NXL/7r+7/oVNlAR3MB6zr6qPZmjL9pO
         2BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560028; x=1788164828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HSkAieVQa1JTe8qhVM2kCKaOCfjEKvx10b2NLcrDjss=;
        b=XOvCLhUfr0Xt3i4xlN47djg/PLntRekdy3tPZvVysxTQD3ggov1aLy0JsmzflnBggE
         2lWjATXkG8DTs/5q1JPztwXEXwBMars+iKP+/LuYQPYsZgimFsJDMJWnpyoCPO/wNXuv
         JaJ2lDz41MAR6Bu5Jz0HvnQz1NYqizbEAl/oasO0FRONedC2VdirqXTr5dIpPkBnqdWO
         LK6rAnp2fsfsJB8EETt6eEvP+phqTfYXRNwcwNIwdjjrdpD5V2Vt7XJ/17Pauq4ysv2f
         w7ofxB3BCrWR6QWebc5EQLh2bsUlH+KMyCpCHoKDFD4CEIwwkqNtEX73Hrhjz3eARO1N
         ea1g==
X-Forwarded-Encrypted: i=1; AHgh+RrvRXTxhMOwA7K5Sbk5mp97jEdOg3ZUCH+XZlrZu0epnSb9p7K/JjDcyPf7C50/6JF0xI1v28Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lKcAj3DV0nclBWPP9pn0MZvOlcWcsJyzgDG0oaT8yUddVZWaty
	55rhWoER9f+goPoA2r5/ZqvoWxhcHMhSqvdk4nZPG4tIFUEO3Zd/Z6Yr
X-Gm-Gg: AR+sD11t1nzEkg2ScvXnU6KRDxtWZKj+zG4XkcDL5++DlJWnTbTD+U6t0e8AuYNHgxc
	bps4egE0ZnB6UKRNTnLQKTGZrhseZldFaqBfS+YoDp5PeJ2kRK6W28VHkz8xKfe+SWx9GbTZakZ
	tJLkm/t8Th75JjM/HbnlCqRDD8NECTsRXguyZiLHqzQjIRv0VqnE2maXH/xdMVc4ZIfGhYEcYfw
	D7O5s3VW3otKjwrZA1yhuXw15hCRGGXwff1TfC3BNecTthc940c57TkMv9MLjeD+hdr5Evxncn0
	5BXYB73TLIJ+oJIHgSD49kl+zvCGIzvS7gsipOPcmFRdQmV8BBWHPybzPAUgKb3wCID7UIv97FM
	0WFgqwJweIK9aPkwL4AScAsJj+HqMPoexWXVDEOVx6m2tDNjjSNTucB80QMqKG0O0Gynbjh882g
	pKlDb19u1muOaliM66muvPj15OgIBuFftH8lrXtUsQGfLSHZPfagsWMUWK17fEgQefXT944A5aV
	wO8Hbnqqvz1AEAI/jXlnl8UGrGyMqo5QvOGqwd9T5HGimLW4lGwK+S7YODNsIeN+c/QAg/dVbvE
	JSHGGuQ9Vnkg8SO5dF1risX812L3IAU/dIue3bQTBFv75YjimC0L1qpuvv6IxD1+yzOsFwboWf4
	gUJGsoqvIHCXcr65T8qz6Acnv7Dht021qCuDcRoqCaybpQj0=
X-Received: by 2002:a17:90b:50c3:b0:395:5eec:b932 with SMTP id 98e67ed59e1d1-395c39e6433mr48365891a91.11.1787560027941;
        Mon, 24 Aug 2026 01:27:07 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm25994595eec.7.2026.08.24.01.27.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 01:27:07 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] soc: apple: rtkit: rate limit malformed syslog warnings
Date: Mon, 24 Aug 2026 14:11:40 +0545
Message-ID: <fa4dd49adf1579d6fa378e4115d4e678e8dc12a6.1787559303.git.acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1787559303.git.acharyalaxman8848@gmail.com>
References: <cover.1787559303.git.acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coprocessor can repeatedly send malformed syslog messages and flood
the kernel log with warnings. Use the rate-limited warning helper for
the validation failures in the syslog receive path.

Fixes: 9bd1d9a0d8bb ("soc: apple: Add RTKit IPC library")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/soc/apple/rtkit.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index da766df5a6d7..e70e3d2cfa08 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -439,7 +439,8 @@ static void apple_rtkit_syslog_rx_init(struct apple_rtkit *rtk, u64 msg)
 	rtk->syslog_msg_size = FIELD_GET(APPLE_RTKIT_SYSLOG_MSG_SIZE, msg);
 
 	if (rtk->syslog_msg_size == 0) {
-		dev_warn(rtk->dev, "RTKit: syslog msg_size is zero\n");
+		dev_warn_ratelimited(rtk->dev,
+				     "RTKit: syslog msg_size is zero\n");
 		return;
 	}
 
@@ -464,26 +465,24 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
 	int msglen;
 
 	if (!rtk->syslog_msg_buffer || rtk->syslog_msg_size == 0) {
-		dev_warn(
-			rtk->dev,
-			"RTKit: received syslog message but no syslog_msg_buffer\n");
+		dev_warn_ratelimited(rtk->dev,
+				     "RTKit: received syslog message but no syslog_msg_buffer\n");
 		goto done;
 	}
 	if (!rtk->syslog_buffer.size) {
-		dev_warn(
-			rtk->dev,
-			"RTKit: received syslog message but syslog_buffer.size is zero\n");
+		dev_warn_ratelimited(rtk->dev,
+				     "RTKit: received syslog message but syslog_buffer.size is zero\n");
 		goto done;
 	}
 	if (!rtk->syslog_buffer.buffer && !rtk->syslog_buffer.iomem) {
-		dev_warn(
-			rtk->dev,
-			"RTKit: received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem\n");
+		dev_warn_ratelimited(rtk->dev,
+				     "RTKit: received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem\n");
 		goto done;
 	}
 	if (idx >= rtk->syslog_n_entries) {
-		dev_warn(rtk->dev, "RTKit: syslog index %d out of range\n",
-			 idx);
+		dev_warn_ratelimited(rtk->dev,
+				     "RTKit: syslog index %d out of range\n",
+				     idx);
 		goto done;
 	}
 
-- 
2.51.2

