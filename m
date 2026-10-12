Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244184A4821;
	Mon, 12 Oct 2026 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819717; cv=none; b=Oxk/2r1bzSOgAB+3msEYBa8Xw4+aG6xmX0Lzc3YOBxOfcYU/1HsgCCQgAVdAO9p5Jxs2VpWDcU4Y9luZZERpsZxxQvB3Y+/eX4shfRMPqKXXtcWazyPYsc3U24jTfr7FBqJ8Z1n94puWUDBB8kVpwBcyyjpQ+Z/cIWceftqeBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819717; c=relaxed/simple;
	bh=UENgAUKbiPmEAB5tiQuAB+RdFzS/wRbfUkI7IQ4znzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnBaH4B/5BUREL3sH90qx/P/worEcZ3YJtib8nzJ72iQPJREWPVXlnPGbsYEecnkh8GbdzVPJYPA6vx+jIuOus5wdk1xkg2Qyfe33L2tY66wiKrM5sR9qjekirMUIw0mnRCkUmodkQAy6KLVlIXQnnPsbp90/x7T9AiCU7NGsDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=m5sSOPQq; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="m5sSOPQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791819681;
	bh=qyQ0PlvSl8ju5dE2/elWxA5NN0Ne5kFMkm2t3npw0e4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=m5sSOPQqmlIczbjCuWPYwPjx5o0FcOvCkU2b80VAo6gn7+F5yUzP4hPw4vW8dkdVX
	 wD0IY/tc05cExObkttWgzmnMWJ6n/lTEM5XRRq1Bf9iDstNv6qdV9foAYJmWQ6PTHs
	 YhpS1iiQpKDsWt6gARWoQ/9y1eUQ9piOk8lqiOTY=
X-QQ-mid: esmtpsz11t1791819663t1d8dd8f5
X-QQ-Originating-IP: wDsLj23J7X6+GoJg0efhmwdlHAJAX+8vZB68CBLd+rw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Oct 2026 23:41:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10911215555370622124
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
Subject: [PATCH v2 6.6.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Mon, 12 Oct 2026 23:40:59 +0800
Message-Id: <20261012154059.1233032-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MJmIzNAivfWgGCxLP7TGWSmJE5QVI0ZCkf5qFlLuW+6NL5SukspeASM6
	c6PbJyf6kUWv5XpU6Dw+ve0q+Fth/rLdfybejUhvd1mrf0o3c7v5Nz+MQaLlHEI5LyC0t7E
	KDnSVCSeGez6NeSkOIypDZrQgm2oIBoCl0lBNZFSR0FNjGuxI/RtjnR+NtWC8874QdyvNWG
	JxxSicWdbgcww1eZC4T1Bsct2LQs27brQHMpz0lkl4K4zA73HjOrOYUR4p194kzfzOWJCuN
	7MFJxDRLr5N4bqEI6+M3aAaSOFDayUsxi2Fx31kjMoJcwqsw6A1H4TCg5tcf3WHKJJj+Zk2
	9rco0lqYyoUnwH4YbBhvHn0F/jDOXnZmeOcM7f+PiAL1sUs64wFuZkyScvD7iyOAXiPLY+/
	tV0qR4cgi+oOA8d7E1Fw+qyaGxF9a7x1PTgooWCMLtW5IpCAVLLTisPchAYYOzoJAFtcPHw
	p08ZW9HawoX4VL4lInMVYbgu6FGe1eN2Qt9UeH2DRNNXbAYZVJeMD8lf/IACsc4MVOMw1WV
	fc8xH1yxC06NAclS+5b3qx7F0UYXpUygIut1SpqC63GN+LlcX0UAvicA8f8tDJQpmMwbVDU
	cg2UGMglPAM8amXklFVHd95fgwrTWhySxdpAax4KSn51gZIKB/7E+MBjEcPzT1f2somlL/K
	yMnLxQ/SaGDpmHkRGHtGxU6Y0GuPmLcHueIV8+PNM1SXGFTEDHsyr97KD/2X4GuDHAAvMYC
	cZBs4+esC2pcYigprbnf1sP0DdGxoD9En8PT90O9qNO0W+qDaLMKOuCug86DtDdnOLFOhup
	/UEdxaEVflbsFXEc/W47X1f8GKiATltHtSrlxWebk+QSuwAgPkgIMWM+OKQFfGj4k7f4aGS
	iFcm4GvJeGFF5OQ3Gk22XGe35JnHwE0D6/B26f5HWo9Butz0mR/HZEfBnJw1mvtVvdjy7qT
	o8rOlIa9zdhEY00FcbGiqjmOuIUvAmwhe9skUKL1VHMXy1jf8154Vc2T1TXZ99irneFtSux
	eXxfH4RI5JxLh5q2VLhkC7+Rsnvf1CD5fk4bvx4FkSJ4Vypi4WUWLu5sN49TptIDQCztYaj
	A/qhkul7ZScopT46wjQiqQwrTjeeI4orfdePt61yo/9AXd4pIPdNCawSYeclXMF9wAfDCr8
	N5IYi9lqJYVCJJs=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

This error path returns while both wiphy_lock() and wdev_lock() are still
held, so one malformed IE request can permanently block later operations
on this wiphy. Route the error through out to release both locks.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
Fixes: d01f1600e8b0 ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
add Reported-by.
---
---
 net/wireless/wext-sme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index cfa903eb0e82f..0e7c314bdeef0 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -354,8 +354,10 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
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

