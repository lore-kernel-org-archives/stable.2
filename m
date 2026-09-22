Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CAD539765
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075092; cv=none; b=YfgId73PcIBqQnwfhhO52DuMkn2xCHQ8YO3U8V71L4VrKfn6U2HfbVeXQSKoc5Su59mtj/67xAFRwa1652BcW6arhhvzuS3Awxi5tIUZCbnytj2f2vk0hkttLROEcRr2I9TPloGEaO7F7/wTSoTZVcpI9KVMdtXBy/W9bcjatGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075092; c=relaxed/simple;
	bh=WkmNayRsugJXw2m+SjZehu4lLeqw+qc5vGPeRZ3tnXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWloBwiiLcd3ZL1J8EJkZYUot9sRcox48r4RwQhf6xl2VuoBOk4QFEowrEFhHul09nbkIb/4eDXznY4Km72gkSb1WNoqroZ9giBP+dmCDW8CWycrORmFi601aB1spoBx6c+ZskPHvLaDCa6UvP5Gc/3auhpdBKCVvdvgzhIGQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQmXcuEP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQmXcuEP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so24343355e9.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075089; x=1790679889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5q9q9I4JmgLpZiHNOnXY73HDIqKDWmotgW69+toxNbM=;
        b=DQmXcuEPjJ/lBZQyooLojSUYgBtT6M7Wc647VqzaK7ZN7uZEoQD1cnbLEnTOsx/9vT
         sqZ+EmoKHgnuYUh6CkyNOgE/pCp1Cb0bwYdEvaKJ99l6qroflafbrZua7Z6E0vKCtBXw
         ZvxyL7OpaTWpp4LcEM/9qtXe3VJnXjsLsckRGtqQ9CXbNXW9i8U8lUOA93jhro3RelcV
         hmP2a7+dVqfUJZ/JE36/xHLEzUtYpilBDsO2cnJ0q1I88tlWZ0/1kzxlQdYk/W/74m3A
         SrUoEg7qR4G6OTpFq2WRcHb3ibFwPeR8mybqzhOljHJ8UyEHeK6BhpKfrLdpyB0bGKkC
         TLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075089; x=1790679889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5q9q9I4JmgLpZiHNOnXY73HDIqKDWmotgW69+toxNbM=;
        b=YSZcBvwUziPg+OtT2fZzsDK/2bfXizVPo7eaUl1v24lKypMYAEA5t3IOy9Rc5STZk3
         YFtGzVx+Ny+5voegmnTOKVzQeMdMhOWJrtSBGX0Sg0zRFfOA6SjZsw/losEqyd/9BYUc
         8jHQnWzZClPu7SoR64zoO1tZaqyDVEMRIqm9Q2VGizECLuNXjx7X5eSv30gudqaniDq8
         sMX9ilocpHArzckGBQwUuEEWbDTT7VEBLVR3n9JGcsE+Udr1ospKMM6kJ0rsdLNORrPp
         mioZZvtLiVVeDOGWfQKjgt+Fs4RAC/Bens48X3U1IGbkjiqyRQ5mIshmmDGUeh7dKpGV
         JNUQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5RRsUkTjuT9DUmfIupfLaO5rDJBIBqJ720UEAFdxcJTkv0oTkErxl0MT85SlqCst7rAE5Hz4=@vger.kernel.org
X-Gm-Message-State: AFuF++k6Kfj/a8s/Y4YkCRbpgufaSC9oHZf13CdDv4J0ttiWxENCdlaU
	gSFJgqhM5HrH2ZPvkn9A9MH1b9TRdVJ9rjxeb1+6fErGy3QUhDpS8+KF+1HL1kudmp0=
X-Gm-Gg: AYBFou2w/SbFAOPS9aPgCSm7d2IyM1Rg6AVs7FV53uODYD1psj6zrMRN8sz96/CCGDJ
	H00G+nZg8B2mxHF8oUPCN54G/2iFTO1Ej5UMgGM+N2IQ2j4GQUENUapvV+lMNOm08lrmtcF++O8
	gpcBXs+NcS91K2XBOdEf4LdRZM4xoscqjl2XpETCErOgemEMsacUjdyIjNYs1w6iArexsYQ55Su
	wALZ3cn5/jS5AraCOLanAlXqEnb5wTJz1LjKSUjT6TmxnZhZrUoxi3osBEKGphHL11pJdCjNKR5
	Rz2tc13g8piVjISMBqRLK70v8p6/D3nxOJIajOcvn4Wm7aK8uq6klVJqW4N9vOgU1LCK6bY2Bjt
	aRUdwDZBNJnhESvocrz8fYR+ngj+qoElAECTi6fSTt71UVqFJkl4WhRWV/dviiRPmPBqAV7U5/C
	WO+D9zMXum6ofWmltbAHdxPqNRD4vQq7U/3YyrW1q4NuUVXECcL3JlDKNrLZmr3Y0PPXEVJEhdP
	Q7de/QwwaE=
X-Received: by 2002:a05:600c:8584:b0:49f:cbf1:e76d with SMTP id 5b1f17b1804b1-49fcbf1e9a5mr124334815e9.0.1790075089205;
        Tue, 22 Sep 2026 04:04:49 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:49 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 21/26] xfs: don't merge different file IO error types
Date: Tue, 22 Sep 2026 13:02:16 +0200
Message-ID: <20260922110221.1431-21-hackerowskiy@gmail.com>
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

LOLLM noticed that we can accidentally merge file range health
monitoring events even if they have different errors.  We shouldn't do
that.

Cc: stable@vger.kernel.org # v7.0
Fixes: dfa8bad3a8796c ("xfs: convey file I/O errors to the health monitor")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_healthmon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index c3749675ef19..2bdd747f1ead 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -247,7 +247,9 @@ xfs_healthmon_merge_events(
 	case XFS_HEALTHMON_DIOWRITE:
 	case XFS_HEALTHMON_DATALOST:
 		/* logically adjacent file ranges can merge */
-		if (existing->fino != new->fino || existing->fgen != new->fgen)
+		if (existing->fino != new->fino ||
+		    existing->fgen != new->fgen ||
+		    existing->error != new->error)
 			return false;
 
 		if (existing->fpos + existing->flen == new->fpos) {
-- 
2.55.0

