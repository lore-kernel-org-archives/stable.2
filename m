Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086225372D5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075059; cv=none; b=W+mZR6S0NOZhBtYPZo8QmyLoQ3CK0qjWTYCSRubjPNnSlmtC+U/mgHAxvzjEQvIxOLwInZNF47ypxXFmo6vsMETNXtShrYEghDavNLt3k/X4M++DkG3AwJss7kTGlbOKn2aSfLhjCF9f/q0Qlo5oBKXEj1g7ZlzrvQwxmXsAhNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075059; c=relaxed/simple;
	bh=/r8i7aXZ1gqHUy7W+uZ8yAHk+kw0DAkrWlAHo5IRoIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmVDmxYhjWnRynP4ZQpLLhgkD98NOLoSRtpp0FRUvH74nejuaCzT/OOl/50r9D+rLFLJF0loOXoYzMbRzg+EqNRVsJ+jM4tVhcMcPyVGXWPzcO/nxcfdUIqFG+pmomSdVvpFTpCI2QUXQCjzi/ZYmbWknEWEG6R1DJOsEs03ZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LToPItIU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LToPItIU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso19514935e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075056; x=1790679856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujrEZoEv2i6LyG/UkZyqltnJMtYwlgWq3Y+J8hijEX0=;
        b=LToPItIUrcBhRg2YJF6nzaaqgpbqbO88SnixlbAafge91ZS8Wf83xWRzzx6omnE6eN
         //5icTz8joqkM50Xxt/KYZIuID6158Xmazjo7ADu66YSBdWWcjYAjkkj7QoSPM6mwH4o
         usRHCvY2kk8bT7lqePbC/dJGq7bDePJRY6RJFWmPaIk2cpN6CB+Uxko5dczBqMbQfHnh
         o+aUiv6ELQHAkZV3Bdhd7AzM5gQnq+jqKklMGvpwkocp7lLgMsoytkqsH3Ueobl1PAfI
         ccVhmqz15ayUOXz58JFtxtjfzTJxLk4bGRO3KTmlP2a3vgjUc7Zjx+vw/6OmlETAxWav
         VVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075056; x=1790679856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujrEZoEv2i6LyG/UkZyqltnJMtYwlgWq3Y+J8hijEX0=;
        b=LDyDOyS+9SThllkG15W2wkL2dSVSwN5T+x/RnAqfjl/26Ofn8HWmPJF8AgPK4FaQ3M
         mqOEZWsV/Kl5cCbEoIswO5HTQW6l/OJJ4GSqwN5uPH8JkkWqHUmw2dgm3+4aOoDzMSYg
         Q8LwZ24k4bQTBYxHpvuMzcKxZkMNCeVTPdbQjKMCMvRCGyLyQ6rW80mBFM/VgzvfxUPM
         a5lHgWBL/kwRSZQXQN4fBT6kTSzLXAsFm9jl0Ng6bDZl5FkFOaOJjTtIuqEjkfPpeP1N
         EcmhVWj1Nwb0um1b5BRJEp+Hp96MrPm4oGtabXT1Wf/pVsFsfQ0tdSjT6hqQBOOlmCtH
         qK9A==
X-Forwarded-Encrypted: i=1; AKwUvBxAxvXvDph/zoxz7UVAF0gMy385uYr/LL0o6H0J+eLcAYCUsJxVE2LX4WlkOlU9pmx5IeuOzsY=@vger.kernel.org
X-Gm-Message-State: AFuF++m2wCoFaXLGFjnZe2mCTZAjJbs6PheP7amt47t7Y7VfdLuEvUDm
	jUsHsesfiVtFq6xll1gVhUeJpIw6aYS6zcMzMa8afny0kQ5upSyd8hmW
X-Gm-Gg: AYBFou0eRbwwwz1wPDCHP0+pu9hhVN1FhzZ5vHboozIomvb9xNL9rfrgG/9ReQZ+beJ
	LIREEniLewgZLcHFU50C1gZU/zPGrClFUfBrPrZTEDPQa9ZeWEDFOpLFmRr5HTM926NKMCb2Znz
	MUX4cT3V+NdDgi4Hsn0rhcy7FpuE6hjh14SOhjmCpD3oNtL6eZlyeMzOuTcsByAfzaV0ry2+DhJ
	MNPfnaLWxhUdUXh2JBAkIvs/+jrfWzZvIybZw+v4lKQhT6k9GaFabI7d/n3J0aUKks8VIVLOjbe
	IkDUkRGy1rvAEwjqAMSmAGHeh296+Z8lQJmcVXaR96vw+6NkdnRSRtjCIhpZA1OLf7lzooXtAyh
	6XcVBJtpnzQiwPRBjY5SNCyi7/TwFj6fNh/owkOoAsFFBDQdGgAPV1f3QstTqMIs2Nu+8V/ChBT
	0+jOG8U1BUsOM/MNxlhSSKhoA++b/+p2xadWb6vzfBC6vpT/91hTBvONkh4REW6ftECTT2wEIuG
	aTtKgrmlkE=
X-Received: by 2002:a05:600c:5250:b0:49f:bd0d:59f5 with SMTP id 5b1f17b1804b1-49fc5746338mr203488565e9.18.1790075056126;
        Tue, 22 Sep 2026 04:04:16 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:15 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 06/26] xfs: use correct jiffies comparison function in xchk_maybe_relax
Date: Tue, 22 Sep 2026 13:02:01 +0200
Message-ID: <20260922110221.1431-6-hackerowskiy@gmail.com>
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

LOLLM points out that we're supposed to use time_after_eq, not a raw >=
operation here, or else jiffies wraps can go unnoticed.  Fix this.

Cc: stable@vger.kernel.org # v6.10
Fixes: 271557de7cbfde ("xfs: reduce the rate of cond_resched calls inside scrub")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/scrub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index 737a5d6db15f..b093945f3631 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -40,7 +40,7 @@ static inline int xchk_maybe_relax(struct xchk_relax *widget)
 		return 0;
 	widget->resched_nr = 0;
 
-	if (unlikely(widget->next_resched <= jiffies)) {
+	if (unlikely(time_after_eq(jiffies, widget->next_resched))) {
 		cond_resched();
 		widget->next_resched = XCHK_RELAX_NEXT;
 	}
-- 
2.55.0

