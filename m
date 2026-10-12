Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB84A0135;
	Mon, 12 Oct 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819947; cv=none; b=PZPOPm7YkRYiFHrvS09Q4XBwT+hQ2pi9ESpi6Hz0szC3AZV6AvJIaXEm26Z92X/92OA12WZjzvaiAR2w/eBwuutbXD2B2siZP03pzCFjYQ6v+xz3K+3ME5uhKF4YShSuLdE/lEAToafXpuo7YJf/g4ON7dYc2I2YVZ8Fwtgw/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819947; c=relaxed/simple;
	bh=tpQlsyFsOeN2lHB5j79EDvKgIaRb+vTg//jQK+WRxLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6AuA8SaCxJOrH9eKeYStPEDpPx8/IsYNHBcoxe/9tlw5GRYXUuyeDDPaaGZac7/XYYtKiJngJsRQKoRgEeu9Y1KhNNtoTnYMtDPnFRw9I5nZMqczclo4eQi4ncJwGZMnpsoCTOL7cZ9qNf5WbtZYLLEMGJ8db7ezyqcBau4NV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dWfeF0yX; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dWfeF0yX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791819903;
	bh=kxEqt5Gts0RU1kxbNAgsWZYVzdfaOgBqpNR+xKrLZOs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=dWfeF0yXEjl6QV+v9eA8xQBLvRN9EOO4uBjx331gTKzFs0POpOoxeLF0ITVBLaVx/
	 50QHkj8/jpMevsyhkH2ia6ZxaorEIgmlcmtSQg6BEGIysQs8Qio6eRr+bNpSMLjrzW
	 PNSPKLsMfUnAUMm1OpzPNvZ98KdU8sALEq5oDFTs=
X-QQ-mid: esmtpgz10t1791819885t841e054a
X-QQ-Originating-IP: KTklhDEBMjLIpu+F3Eyp2w3hqZ+wDfAlmFzrd2+lQ+A=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Oct 2026 23:44:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18403176566585101560
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	kartikey406@gmail.com,
	harshit.m.mogalapalli@oracle.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 5.10.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Mon, 12 Oct 2026 23:44:41 +0800
Message-Id: <20261012154441.1233984-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N15W4pXB+EjdiZPS1XfjbSr89RJfd2acIPbbbqfFgXd6cyKwRshM4Uc7
	2rd4er0i8356ZTz++vrsZX1ObGC7ISTZ48o/hwIdOEPXA0FndpWZ6wQaQcsi0Dhu8tiusrh
	cOe1sCX8C4IXhX+dUEmivXz8Jm6CeqNTuPtC3V68SUoX3smneFY7em2hsfG8WJTKdDEhy3y
	fACOEVeVKWSEKNBcQI+6z8TjkrLt3IfziE9BmczEBEUxh8r6TPWm/lqxETH+ajFDCmPeUJo
	sYmZWZpl2s2Rov8kPiGvAnwPTWnHIJAtaV5JaG3k1STFELQC/N+gqf1scGprO365nNxK4hz
	YZJClwQO7HpGGQ10gb97Ox11VSesb1FzaqlmVanb26rHlalHuSe41znwvVo2HhU1mYtMv0J
	+pAAL1V78sPlQfVjBqynPVz2nDaHjO6ZMaJOViani5cr86HG/NN3oepF8FcWKHCEssrcOJ/
	Lnicka7mHOZe/dQKeY7/dtlsjKdp8AuH9JIz63kWXIZOg1Rs6QMoEsviiQpRl3FobzQAHQA
	RSlSnCD1N9I9YzLLCLR7Ck2U9UwS1maN+HSXmjxVa7f4hHCJENKbvE9BjxVI4vONaGaEpCi
	5/lLidCGR+v/5weTAoQYOP0AJZT/kdLl0A+JQ0QQiytrfyCVycJe4eT0ZT9yH6GyU3SG9e9
	cumUdCY8stewprTsAnyZq84ebsNlMIETVicU0f//LagMZCHCoFRbE4CvJ0MaXKy3DDPJJrr
	NHwXRjk//wshnbJIEBY9+db9dGJjVXcwZNInYSa44UsXsOrb7Unrqo91eTpM9WQLI/p5zw7
	I1KO9uGS/Hti3G7kqxWOPr8LkeNnTWqeVesp4zyRsd4DuRka93Kh5/RPT4xbZmmIejW+W80
	v4+dKMHVewPRvp3pMbYgHOsQuWGqKeaXPYhpT++IUAUTW9fXRKNfs+AiveZT3r+alBQOluh
	lJws5bS7S+DMeSFvB4m+i1iigUpj6c5yJqoZk7M+wAsfXQhMp/LJS1gWdF0j2GVuylYUuc/
	Y5sa6iOSwnc/F5daDAe79L11L2ZDTHGypMZyAs98lMwqGpfwD61pHtam/sVaDfgyOplIN9x
	T8Mg+n7Kn5f2HQRXN4tW263WW3fZs2DalSccv3zEngUD+eP2ari+lBfgH+INdRvW4P4ZU/W
	kSy+QCLVq45XboQkCwPnRabkGC8ajGKucAMUcv05NUBYyua9GqV0/LLtCA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

This error path returns while wdev_lock() is still held, so one
malformed IE request can permanently block later operations on this
wiphy. Route the error through out to release the lock.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
Fixes: 269498ce6c1e ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/wireless/wext-sme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index d27ec0163b08b..943e94f4a2634 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -339,8 +339,10 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 			/* nothing */
 		}
 
-		if (!for_each_element_completed(elem, extra, ie_len))
-			return -EINVAL;
+		if (!for_each_element_completed(elem, extra, ie_len)) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		ie = kmemdup(extra, ie_len, GFP_KERNEL);
 		if (!ie) {
-- 
2.39.5

