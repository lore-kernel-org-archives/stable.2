Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D947F3B8;
	Tue, 13 Oct 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886967; cv=none; b=WiPBFmZnf+kpR8SR9SA/+DZEXFfoTMKyxHeF9/QgZGTSfjl/2gsGpDxbQDqfJNZXFv6sjxSG5HVWYQ8gIvZlrP7f//QMzu91b8Q3dw/UJaSj2s6HxO9WC5HXhKRjM81zWOJUa5wjMgrCAdSMdIsksVIQJYVxECtQeAazc//esdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886967; c=relaxed/simple;
	bh=WZA0rpgNDPllMGHYFpaR7CapTB61WQRWESEX/CO/DCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbA8T7n1SzrSru39Zg6An1ZV8tKNQFUbkLMgrfbTq/qHBYSpxLThbOzhCe0ou+mujxS10Q6+vB5xvx1mMx/t1z5Nh8uYO1Bid1OPl33VMEakloc4tyO2StM5fWJgfpP4FRPUb3z8mDZy9ZmW4n0AMDkW/Puo7VHle3FX8yC35Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KKL6+TeR; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KKL6+TeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791886923;
	bh=73a7iF8QhYAPAVCH/uv9rDskxAl4Kqe7zyPqPoQ5kNU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=KKL6+TeRZGsFSh8cI7ZczNJ/+FJiCuzWNybrXZDNg8PUsuOUOVbIKr9C7feQmPxDh
	 8Ej77BYTryXRTKOpxYEILsFV6UABt0GHpwfQOLuPs9n/zyQcKfxr/hCqdRUxsBrFcc
	 DXB0XRG5lRdBMOn/YLG7yTdZs8aBTQVVem1MadRU=
X-QQ-mid: zesmtpip4t1791886905t506ed474
X-QQ-Originating-IP: TOJr8cRyLA1Mrrq41Do0OvkT36/bWABJz8yebZs47VU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 18:21:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9452578437465061866
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	kartikey406@gmail.com,
	harshit.m.mogalapalli@oracle.com,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH v2 5.10.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Tue, 13 Oct 2026 18:20:45 +0800
Message-Id: <20261013102041.2113948-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261013102041.2113948-1-guanwentao@uniontech.com>
References: <20261013102041.2113948-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ONNzAaE3j5jC5+eN2W0q6T0FRz9SsEITHtDQkxbWwj4Fmfxz6M7Hbaev
	XGZPgaHjBMAoFxO+9itNeE1qmXrNyHMIOcGFcQ0RvsAPiK/1RslINak71MnoVCNX0IcuTvW
	g4sFpdRVvUGi3jwOALrkafh/yOJiR6/5fT6P3fIh3lY7qv9cHV4bMfVVpPNai9GWkRzxlJZ
	CuwIdKepvvjjyQxSd7hiRM+CoSrpPlfJX0nS+w9ydtiw6VEoeW/g4RE0op3kUJsruo7Y4Qe
	0sip/0OdMpLeSQ/sIHRRyPPhdmI0PJUvVxwpl8jArZWdc0SBYOY1LCtXYyBIh9xaUb2R5Zx
	cXMk0V7A2MVaN0ifzQwtmOVC9NRwS4Mdj6jU51S2prPazEKxRtyn3V2J1QdIK77mlOCpF4f
	PcXKHJI59OEqb1BjQvPjnkVHAiAAkJ2hGV4SfNcHXZbqLdxVxWtnhvUrs7jzF+8aCNPGvLe
	6O/O/8kvgpoGTejbF7nC7BK14vPXDQ3KQgn+n7s72uTVKsONn/y7N0eyuHdQ94ghqsfRALh
	pT2D3U81fmhmIYs1fbva7LrKzYVrDW5R8q/dChnzqvyb3cACkF80rr8+0qEUGmdFpBQvAPq
	LZ8DdjHaSC+lhs0vLfWmVYdCfuoMLr9TUOAnwJz3qhnglUpRYx0FciDFD5GESXIUlVoeaiN
	a/8/cnEFJg4ZhQIpWJTY9yW1U4qwvUG3d32atdAphaHQpsPkixx2ZORWVJ8gTUE4k+eFFMT
	ehy7wPLD53bD3JToEjg2V7aWjCtcVw4P3I6nwC8FdsG9WpDvfDKbE+0+vKMp51L7J3F/0y2
	mX3QY9+VtN19OrxYucq1pexDPQtzOOIPNOkDCSImQo56gXacShOEZdvySKWuNT5mxzkkNqm
	j628tELB83hLgg+HX1xk3RM35MJz0xcFWJdVDf8dM50ekZW6pI+f7eUv0z/hbCZ3qk0tO5P
	Sz1k3rAPIaoOCr1DVCAyYhLQlUqkVJqT9AccpQ8k70GCVmQxeDXWCnIwb7a65PrfKONCgQu
	ywlyU6Wj0Z5GPZgf1+Q7iNT1doTvC4foCgb2DrWQrpvjrBFbwfFcxh04AeTAlSSxV2+QVD7
	JXD6dtHbR9Qx2ZG9ADe8xDth1DzaGhlvivcSlIxOxOkukpgnwo7b1owe9jeIIXwz5TRPIDf
	b80QGHRn8GeYgjeg3lyUOCyTBeg9jUCcsWnFJS8AhcUMzOisWBk8PVyS2eQM4vhMkch3Cq3
	R0K4sjN0=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

This error path returns while wdev_lock() is still held, so one
malformed IE request can permanently block later operations on this
wiphy. Route the error through out to release the lock.

This bug is stable-specific: it was introduced by the stable backport
commit 269498ce6c1e ("wifi: cfg80211: validate IEs in
cfg80211_wext_siwgenie()") of upstream
commit a2f5286ca4f3 ("wifi: cfg80211: validate IEs in
cfg80211_wext_siwgenie()").  Upstream is safe because that function
runs under guard(wiphy)(), added by
commit f42d22d3f7963 ("wifi: cfg80211: define and use wiphy guard"),
while this tree still uses explicit locking and the separate wdev
mutex that upstream removed in
commit 076fc8775dafe ("wifi: cfg80211: remove wdev mutex").  Backporting
those locking reworks is not appropriate as a minimal stable fix.

This is a fix for stable v5.10.271 backport commit, so no upstream commit.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
Fixes: 269498ce6c1e ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
update commit message as greg suggested.
---
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

