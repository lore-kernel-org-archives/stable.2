Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.74.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7E4B7A43;
	Mon, 12 Oct 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.74.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819908; cv=none; b=l4g3ad3DCBhBwmdKZMkE0CYSHVWuVtaq6wSXfbdPlQVhYJ1QNKVPXJNB314lccd3BZ5wwJeCDlAwTbMqBCD4LjYzX5PWlDSUx++7oue+YpWxO6QMCiEBTDu5yZS7ibMJTo5GfNbzpOoORzv4CuGwskupi5+XW3YKZ7a4RY3PJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819908; c=relaxed/simple;
	bh=afiYmZiWKrCuDlyoRFPwgNWErAV0WYHshIGZRJwdjBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=re8X1i8IBosK0JObaAiZIOVP73/cZflPbWikSIod6bZMDOqslmURIN5SWYlPFL0UdmpFDvsQrQTLtj7MWCxpcyBZl4L+hlXAll6lZvm0rwsSgValTtV9PpP9Zfen9URFLCDrkGNY+2qXwGhUYFIyD8nsJNyD0cKTAKKoZJihpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=an2i+ocL; arc=none smtp.client-ip=114.132.74.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="an2i+ocL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791819857;
	bh=IH1PAcENCka62/qVlRWtKLfrH91qdtFzK+VcS20+6Ok=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=an2i+ocLOMp7vkCtCNU7aIDP9sUDRJEtLd/8J1zmHzXX+omvTMFhuqfYfOhlTaOJc
	 JRtHPk53x83sp7DxCY/sDdDdzauFHbaROJWmJGbywZM+a7IOsoEZ3AseFuc9VPu3ee
	 vxG3j3doxDwi3MXaSprsAx2U++78spHdWxuexRy8=
X-QQ-mid: esmtpsz19t1791819837t14199d6a
X-QQ-Originating-IP: 1gasTubtzfSTCdK5hgtx7Xz4z7/VZ9P5XI1IVEFP+0A=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Oct 2026 23:43:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12628146861029274795
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
Subject: [PATCH 5.15.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Mon, 12 Oct 2026 23:43:53 +0800
Message-Id: <20261012154353.1233790-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NVkR2RG4VPDubCxGp6iwawuk+akPYrKAbE0+i8cQ4iyLmJ+n9UWm8JI6
	+XL2ZZ8e+e84aXhU9MoyKaao/+DSf094DrFKTIYxDrYDHdAlVGkdR7f1GtDUDRyFLgv05k+
	vUMKr267X0NH641IIBtWG8Id0vnk9rKGln6eKa7OEqOC85XFu0fX5uPFjEZGJz5jHFRZCJz
	wOuvM8EdGpjtOdNNZCIjeWB1Ma8N8rYKZUmBxS0bn4zOBAliPhD0yl49TLRwLE0uyBMXGGD
	GK3wz35MNpCDFCe7Eu3IwvaNFnG03t4wkiLFt1qs7AT2y9xWIgTzUNPCzcuWB2P7BGVZkFS
	YpJqPJlayGFHzVwqBR04ZDue1+659RbytWSO1nVgMoY+/UNPr1pM1WapCN4mJRN+vi7fBpu
	Jy3ID0miVMfxD0dqiKibLG1kwEelqxGLTXV+6SS+R7NzF6fcy2QWPrYuv43VY6uipdkdl4k
	ZYG/96cQ36Svhur0iY9K0IdDRIUlKwmt3DsH2ehnjwXEN/6oGY/cXvrzZgT9vvVWd+SEL3g
	W1a3cv1/8jyS1jd1ftJQACS8WslKGnCnEY7r7/LxQIITinpCKu31hvEAc3NpMlvZqFQ60Tm
	2uZw/cG33Bix3ZJse8n4X9zM7dx9u7zjHWUAlHhY3EmITT0f8gn7+viEwSv2S0p/jF6VZoY
	HNPKQsEC5egaWMsLHTFBYe5NCZf2GLBHsHasy/dn97ruAFsPVgOzAINg8LNXd+p6MRRvk8F
	xICwonliMioso/aC8f5yGk5OcwPdxMfmu9w4e5+DDrNhh2OWnHYYmfXNMEaKlvYjQiDDSAK
	cxHGyrpOPxG9BOI2FquYZQ4Rqq2wZEkgFzIw+prNatWtbAoNs+fRhrHnxSAfakWPZPCLqR2
	awJvCTRN4T5HGOL2Nzo2TiVZseKQrpt3PpV8vY/xw31HQtdRN1yVln1mt2UyJUEfkdbwSXy
	+aOFrowFScKw0k7vDWFAMWcfYBrmT1hT6o87nNgIyDuIM7S7XLKymnulaWOgNrAmZt9TvUN
	s3RCqy6Sdm+36OTAdtqW3stLJQPpPAntyKaby0G+x5znt5LbyGeMQrGeJ+kgpQgzB+RNieA
	n4UjTMKVNGf9cVttTp/qxn354r8GjCw7eWee/YIkiRDlDJe4F4g6lLnfDqnDxv4sgODgzs2
	QiQTv5kESmqp9nch2EX42H/FuBb6qdfFK5ChcZ14jNrNiWY=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

This error path returns while wdev_lock() is still held, so one
malformed IE request can permanently block later operations on this
wiphy. Route the error through out to release the lock.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
Fixes: 685082f4be77 ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/wireless/wext-sme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index 1919290d1208d..f0c9aab622385 100644
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

