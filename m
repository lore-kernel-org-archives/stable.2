Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B293423786
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075048; cv=none; b=EvRZqGV8HwlAknkf97HuRzF6cQUrZPmJwlV+NKzwl7iy4UWvl5ndPzFHzimuORW5+EuL4+p+iBJU6QOTMDv98yxcpSqNQShBWC9JXDu+hVdtLtjvMy8p25qVUmgc/IqrEwrprtvlCDbWdwoljKd+jJ4cs+C2/bf14hhLQpIkD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075048; c=relaxed/simple;
	bh=l79gK24wRz6rmJsamaLfvJNdBiM6KhjkQkmKyc3ZC4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbe4eIiVJkgJv47hFNoXipSWbs/wOtBC437EN0TRHtDeKKgwjfC2UjKkFY8KES/lsaAOeTiMt+/w38ofNrW5zwwJc4tQoV0oXUq9ckc+gIxFdijlbjgW1XBwhR89nX1LXhS97zOaR07wtqDPz3akbyu7Emvon1G1ukz2X5yaeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLI07o6A; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLI07o6A"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so23366465e9.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075045; x=1790679845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=egvbL7l77fQAZ5KegXFdqSavkTCxC7VS5CeDztoDLXI=;
        b=HLI07o6AXRA8feZEkOak2IQsCcewSMrekJf0tR+t1b9Z708dSYN8MHwQ968aR1qtjv
         Lr7hH3gIPV2HX8sRMZwOFc59VAFbqb6eMSH/vAQy6ZPhq/WuiR/Y0qopDDUQeE8VJ9zz
         YNIl1QpCshnpcW9TbKfjUd5VEBU3APesTvbW7tHhchs4d0pEjygxa1n1zJvNNuZKCKQr
         FwJCndByilPSmqsiUKj0D76X+i8Zq6U2G/I8w+kviJCCM0FIIhIMaBflyilB/x4iVLYv
         rXKYmdsdM1TxzSop+K0Y5O9vKQ1u54V1PQZzgWEJhGTmKV5jWxjthQJMePlHrEjiX3Q0
         8mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075045; x=1790679845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=egvbL7l77fQAZ5KegXFdqSavkTCxC7VS5CeDztoDLXI=;
        b=XEahcaZe9rqyUuN/mbBLpDidpr/4ZjiDCTsorCICJ6kO4JTdD7Nty2CZ8zk4rGri4d
         Asd4giEd8BZgr7pN5F4AEIhOhSwBzy+elCHrxQQdY8dqHJ9YH5eje8cUEcp2NRB7MWvQ
         H6j6UbAt2aBsxo8q2HkYRRwUAhVlr3KXABg5OLfB8dFuqMzNAoU2Dl4CLGcK/ALUWVtz
         SZ256wLXeiGd/8JYvT6H+ab6pjpdLk/qaS+A7EugDhvp1Rhymy6QFWXu2Lg1Z8hIj/DM
         6da0pjn+9W9HbzWtj6b3+IhxXSCFlxObOD7UZ9SQ9oQAmoiOTtzpWOfkOUVz5sxgiAnt
         QehQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUbo33gqr82hqYJfRdXEPZWS5Xy0tsQFjx+tXcyygH94m7KLS4SgAVBHFuGzs9wzhVirqf4C8=@vger.kernel.org
X-Gm-Message-State: AFuF++lCDTLNvUTxGsoETwMCVIS8TURb9rmZOL660O4TTBGlbKYLKeZD
	Dsp1xaJYfEATUGMjMUjaTVT/XQwuW9UMLbqjkMCAPNmzVGZvK/J+CT/z
X-Gm-Gg: AYBFou0VNhLQKF/FMalSTRaiO9Yev/UAnJiW3r2ECI1KgK1eSXEzUdwN+dz7nlXsxLk
	upoialuvAwGc76q+fIoIV8rvYte+R4oIdC+m/tDRnvI1BCR7rB5RbjQIbT0thMWn6zrttzavohG
	NTxn/Gon/Gp9BhBcmtNgrjM4ObxaQdZWSGfNIi9wnxFm6HsuDmcGM8qGA0SkcOy7u4AYeIVsgKz
	ydosLDADvkf0ejQG0a/j4Rsellz8bvUjQIyNv59zqDUv5WMrjIN1z0xHPb6yKFLzg9IwIxea3ZC
	onnvnINt3WqbHDfAMR3upljuqPhAwZvpEOwE4MurfSjWzl/OX4r3IPpjfTeBTa3OHvxcooQ01/L
	hPhXL6h3hfnNf+cDMOeW3w3sTvBqjGsQaf/c6/6N/3LV+/mKYznVFAPtHuAa2pKxwHsGhSQDZVc
	kuMqnFtvWFdI0NZpn0c/06JMFZpSGiRrewVwmso6Vv64PbUMIa0QcgtqG/aldF08yzIAcsuLBp7
	VKpOxrfkVmgAaQ3niq3xg==
X-Received: by 2002:a05:600c:3b8a:b0:49d:1d6a:4cfb with SMTP id 5b1f17b1804b1-49fc56db759mr256459025e9.1.1790075045425;
        Tue, 22 Sep 2026 04:04:05 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:05 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 02/26] xfs: don't assert when XFS_SCRUB_TYPE_HEALTHY scans return corruption
Date: Tue, 22 Sep 2026 13:01:57 +0200
Message-ID: <20260922110221.1431-2-hackerowskiy@gmail.com>
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

XFS_SCRUB_TYPE_HEALTHY is a synthentic scrub type so that xfs_scrub can
tell the kernel "Hey, I finished a scan and saw no problems" and have
the kernel forget that it saw indirect evidence of corruption.

Unfortunately, as LOLLM points out, it's possible for the health system
to record a new corruption just before xfs_scrub gets to
XFS_SCRUB_TYPE_HEALTHY.  In this case, the existing logic doesn't return
early and instead wanders into unknown regions of type_to_health_flag
and trips the assert because HEALTHY doesn't have a group assignment.

Fix the logic so that we always return early for a HEALTHY scrub type,
even if we decide not to call xchk_mark_all_healthy.

Cc: stable@vger.kernel.org # v6.9
Fixes: a1f3e0cca41036 ("xfs: update health status if we get a clean bill of health")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/health.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/health.c b/fs/xfs/scrub/health.c
index 2171bcf0f6c1..487ecc5f9f3c 100644
--- a/fs/xfs/scrub/health.c
+++ b/fs/xfs/scrub/health.c
@@ -202,9 +202,9 @@ xchk_update_health(
 	 * there's no sick flag defined for it, so we branch here ahead of the
 	 * mask check.
 	 */
-	if (sc->sm->sm_type == XFS_SCRUB_TYPE_HEALTHY &&
-	    !(sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT)) {
-		xchk_mark_all_healthy(sc->mp);
+	if (sc->sm->sm_type == XFS_SCRUB_TYPE_HEALTHY) {
+		if (!(sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT))
+			xchk_mark_all_healthy(sc->mp);
 		return;
 	}
 
-- 
2.55.0

