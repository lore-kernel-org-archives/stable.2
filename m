Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB41FF4F1;
	Fri, 11 Sep 2026 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093068; cv=none; b=HV83nFxDMogRSZrNsJiXMqT6xB5Xu4gcc3wdNkxkloszSt/KduDiRB14coYYYXK20dmVC1MFcXwATrEc3iMCX92hPZN3svO+QDjqK9Wx5yAypxdT2WVtz24SQt2NkkKDmoTXbf6n3QaVR1767PZVt9zUQKKXlLZRKlm4glMaclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093068; c=relaxed/simple;
	bh=XPThG9NnINeUCm1Zi51ahmjFxSycnVvO1IRnCgaZrVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZiDYHo5TBLWNEZHxwe1nZCWtGA3OjTz/GhM2688gVTvBawfDyomCl09BFLzJKrwCIJ02I1kdw4CMSUx/XCOQSzttOGZUjy+Km/YeUelRKflpT6i66hJWobMLItSg7eCzbImprRsS8gdoB/gyq1glUaGTT/qiXtuhEHF4UtwBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=NJOMAnRT; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="NJOMAnRT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789093056; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SKOhE2ExBAAT/4j/RALvlrk5dDEPSaVEE2JDijBjnrk=;
	b=NJOMAnRTo8Nbh1a5M7UqJP3WGXbQD2u7xceGYWwUFxyLGybekxzxG5GyHI5QnSfsw7HK6Fs5AqkW0iRsVLc+JRhV5LfakzL6Ckm/G1ED1Ym9ENe+i/ht3+YjIa2LQ47N43kZaTQ2Tua0TzE+0hdnRRt0yi6iv7YHqizbf91Sp7E=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1012895|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.124066-0.00440913-0.871525;FP=4546931855683348694|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jArxPkT_1789093054;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jArxPkT_1789093054 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Sep 2026 10:17:35 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH v2 1/3] net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
Date: Fri, 11 Sep 2026 10:17:32 +0800
Message-ID: <20260911021734.1396599-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
References: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NDP traversal in mhi_mbim_rx() only stops when wNextNdpIndex is
zero.  Nothing requires the offsets to advance, so a modem that
points an NDP at itself, or at an earlier NDP, keeps the loop
spinning forever on one CPU.

Break out when the next NDP offset is not larger than the current
one.

Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
Cc: stable@vger.kernel.org
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Verified in a QEMU guest with a fault injector feeding the driver's
receive callback an NTB whose single NDP points at itself: the
unpatched driver spins in mhi_mbim_rx() with one CPU pinned at 100%
and the thread never returns.  With this check the loop terminates
within one iteration.

Changes in v2: move the non-increasing check to the wNextNdpIndex
retrieval site, as suggested by Loic Poulain, instead of tracking
the previous offset in a separate variable.
---
 drivers/net/wwan/mhi_wwan_mbim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index a949987125..5679948546 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -349,9 +349,13 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
 unlock:
 		rcu_read_unlock();
 next_ndp:
-		/* Other NDP to process? */
-		ndpoffset = (int)le16_to_cpu(ndp16.wNextNdpIndex);
-		if (!ndpoffset)
+		/* Other NDP to process?  The offsets must advance, or a
+		 * self-referencing NDP keeps the loop spinning forever.
+		 */
+		n = (int)le16_to_cpu(ndp16.wNextNdpIndex);
+		if (n > ndpoffset)
+			ndpoffset = n;
+		else
 			break;
 	}
 
-- 
2.43.0

