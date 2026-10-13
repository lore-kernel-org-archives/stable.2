Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7873F929A;
	Tue, 13 Oct 2026 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886937; cv=none; b=IGk4I+k0rEcXBNQ0kAB0ggMh+uXX2QDdAUaoOByFnbBITLkUVtoO6NP/S24jazHssbN4BLes796cbGtHiGETMyCpnD/A8ffJd1/vilTDPEgV/PKTi2MKG1jkYsGFuL2Zsysdep8uy2mfyVELyOvZuKVGzmkYgup0YciiS3LyoDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886937; c=relaxed/simple;
	bh=KWnYftIawBeIpxwoFfYzH8mQDOt9sFs0GkMubn5eCZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJVuoD/WtAfAOkicOjiH4NY7GfSSVnJJwLS6YgC85LDemrq29Px0whqVmP1wHbOJzZ7PG+trIE7wIRz+YdWOJhHC8Q9WBnviFfwliT5w0z42FQdPIpK23syHgZtPbpsoY1vCF6JJIwMFIodyVd5QVhMe0pwCC89kSkFmhHNZG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gctRSr4N; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gctRSr4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791886909;
	bh=XvXYwHD2db+bIDoZSNw04OEUmoon4G2Jn8v+4/L6ez4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gctRSr4NtdjW7hAP43SaKFjqVO2wYL5gKlL0nZ1tUnTodBj9/WxWc+zALG6vCWSfA
	 J9wwTcierL3MpuiWR0ZDV/L5151AmTYmZXhe9998VL+BVs4mgfEz5Ekr9Z/lXhm+he
	 eoZVHr6sxnSQeMXdnGFrL2WButUTl/uNkYQF4CI4=
X-QQ-mid: zesmtpip4t1791886890tba51cc0f
X-QQ-Originating-IP: erpiaJXB4+sALwcDCbRKc9gfy9aKGYac1e3GBsudxj0=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 18:21:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10534299287409454217
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
Subject: [PATCH v2 5.15.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Tue, 13 Oct 2026 18:20:43 +0800
Message-Id: <20261013102041.2113948-3-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: N+cl0OTdzeOaTALkc0SVLgyrIfU93adyHZ4xLvhkvbDJp7Cpzzoas+Hr
	ysFP+4/XkyS++FUOf25uDT7B8Pg/MDeWVGd0UMt4cq9J+eTGrY6gUw5RpaAzRSWweVTBNbq
	J1n0hGvderjyZznoYQMZp4cPjwMaQ2BW545ylGjD+9XkjImborrayQi2LSSyzIHOlpMcxHD
	bHjJHrzerWPRWB2zuE/m1F1efTBmN6WzwJtDrj78Iz+H5IbN5TAEUY5bno0fbfzGxv8oQyq
	8DKsjsDfdaRu195ABTDzkQMFYsPTcfrwoIbK/HeWwGt4X4tmRSmmHgbcZTBWFnSxU20M2h+
	s6MphVjJnoH4z0pl+PK4DgI4wh/9ctwcLxohFBWq+qDFcnV6HTao5K8k/J7wk5AQcsKyzuB
	r6r7fFwpAKfpohArZVLwEHo7/ei5yHwJYsGkFFfu0NG85M2rCDXNPWF0KvL9Tk0beCFzGR5
	kxCgRjstwXnrz9hXeeugVUQU//YKncVKAVR2EaM8Ji5/cSWJAwEgmhYtBGbosHZAp+LXEIS
	CsZKWtefxbCauOyZJ18hnemkD830AnKmi9yYFLJgZDJq7fDWMkioA5v/rJ2/qEG4l5mXqbK
	qTvIVH/AA7oLgvI7w/+unBhJX1WP1c22XOQwgxKyIPYmgPAToZA+P7Ox+f5dGycxWGCFQ/6
	SFUpyTbKeeopEesZqMQJeLcm/Yt4x3uo1B65yWF8FVU/WAyoNda4e6jZg/NwPaTBIFIcDZr
	T+pR1vI6O5AAKVuEVG+z6ikc70KsgMkeKfaOs/B/8vFbhMgVkd5OwlSSzVCsx4XK/AjkZLj
	QL4PV61IMNYJseMdw+iA/NMf/T0rYxxYZL9+OYOwO4k0Ra2aah5Mbkv+xikMIR58nh+EDMB
	rWGuKIPtuboGLtPia8Jx35wPvHmTPEJt4lTqbDZ5NV5MuHXCVavj6m+G4AfY5CQDsnlyXiT
	27pShX7aThk7/wlPUkJZkOK2YfOf+IIGV7Cm0NJe/sZb4whq0GcAqJicEcqshtn0qZHtzGI
	zgRBe/v8XLscJApjUgjE6GkvZzNffTiBXdayx5q7BF9ZQNwK5YrpjT72XVu3EwLp7uAb11z
	msYVlWT5c0Y2bha9FQPdfjyH+5fWiLVkIfYR15y4gqOuoofBiDwwoW/Y8r2lJd78IVrsQm2
	ZwsCwMQMeiSGiHaTvD+j73OUdO+ICfLJZ23y1gH+O92GUALjSNx8ArDohIRfCRWxifgtZKP
	RLFa/+Go=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

This error path returns while wdev_lock() is still held, so one
malformed IE request can permanently block later operations on this
wiphy. Route the error through out to release the lock.

This bug is stable-specific: it was introduced by the stable backport
commit 685082f4be77 ("wifi: cfg80211: validate IEs in
cfg80211_wext_siwgenie()") of upstream
commit a2f5286ca4f3 ("wifi: cfg80211: validate IEs in
cfg80211_wext_siwgenie()").  Upstream is safe because that function
runs under guard(wiphy)(), added by
commit f42d22d3f7963 ("wifi: cfg80211: define and use wiphy guard"),
while this tree still uses explicit locking and the separate wdev
mutex that upstream removed in
commit 076fc8775dafe ("wifi: cfg80211: remove wdev mutex").  Backporting
those locking reworks is not appropriate as a minimal stable fix.

This is a fix for stable v5.15.222 backport commit, so no upstream commit.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
Fixes: 685082f4be77 ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
update commit message as greg suggested.
---
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

