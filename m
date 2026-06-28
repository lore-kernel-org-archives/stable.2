Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1EF507
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663750; cv=none; b=QU2t5RIw2OVnTgwv89FROjORP0NFBOk1zpAinieiEDzoaA1EzQHnXQMoloLXDcV/HjtzCobPbf8FtsCk4pWkZQ+EK6kvcNTPevSlFR6ZrG+Rqh5pupSHDDx+aQuUyOgeG/ubY29hKdFeruS3SYbcTBg2BhR6sSduwwJ1fOY9QoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663750; c=relaxed/simple;
	bh=YiKN6ThymJt4nP7btDks0d/vJ66qmLfbSO/M9xvo0Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wa2w1ao2VfShAEm5lPU4VQ4WO0HDPEncrkrMS2cdlWgUJhD1DY0lh96R0Z4wNr3ZHokUTvLzCcpNkVSXAM7vjrhxqC9Xr68Ex4r9JatMfuyWIlvz9oyue8FMeMXfKnkHRBvdR8ZD3LzWDfhxygLdUwGyiHQjxWk0blWKY+en2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=R/YlVBAS; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="R/YlVBAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663640;
	bh=ceG/fupnfwaIEWNUaY6LP7LAecAihAeuZ6RepYPWVPE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=R/YlVBASto+VJ7VmE+yRu5CkQFLjwDZdTIuUrTuWFCSqpXUEN5W+poXQIgy1Waul4
	 49DQnfi4X1uxqnFhErTgEYMZiVGF/G1pjcp94sF2RFTgyVKfdHAXzZDkKPwRCqOPfP
	 wzygTZV04gkj4lcxzVv8CwYxCbPUIKafChf49ogU=
X-QQ-mid: esmtpgz10t1782663634t1c9231a8
X-QQ-Originating-IP: OryhUP4FsHskGUjCsPhAqUVrRTeCkr7MwKqWiOzvfZs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:20:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2615349062572791112
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.1.y 6/9] eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
Date: Mon, 29 Jun 2026 00:19:37 +0800
Message-Id: <20260628161933.532572-7-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <akEtsUNOcuws0xPC@eldamar.lan>
References: <akEtsUNOcuws0xPC@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nfza43amelPGi2q7aLpdHVYy4tlHIpihrr7YVAmB0QAjdRduf8/sKdEa
	tr8F9N7bR582dZDvghLT4o1hE3Pu48OM23nU7mw1xUJgYcoeyCW/vgYGlYVAFa34dKPg2vp
	+wtQvZqJW4z2Y/n+X3c/gAV49NXNQoUi0PymkTZyuMNhTVTUJNUJUzxy2qSEV3i42JsTyaX
	Q3jXgA3YJlWpzIleVu+QlVTndGIYvwm0L/vO5UyU1XMe41gspNj9RYmb3tdWs9bfnPQFmgM
	gBzWgGdsXUG2GVsUiSYY54mzgMvYvyy6Cr0PErFz9gqB3VQSUg/kLbejC20oEFGCxioE6T1
	FIBlRN5jlH+wr82XFfMyQGo4ucFLtBRfgPBbX/kPAGpspL5RUr/2Iy3VmgfDm3LuUEIN5NU
	6hbEpSrOXGEMoglgbl0qaA02Jk6pNWgL9YrgubOBwCm42xrgjCzZp+ldvX4aHCXVYYOQk+p
	SV4bUUdY+uOFMt3hI2RfDv/rv0zl6BWBKdQ1ppNVbEpsF8YZ8k80VjHrwoExJyEePCxnjZi
	5+JOG0URxu4tbfPCOVMM6t2Yl1xpgdj43IOegSW5eSCzFJ3pHwsbMjiBSYd/JMZsEGRu/GV
	U6HIDAxizqAULaVbIfTuHIOYDJTbCOVEHALV7gZAID+5dzpB4497MPhhc1tMGmDPC6IkWNV
	vCoXfU5OBZ9fYK4EnhX6pbUvAGwKrILFb2wMCUgc1HPmFn01WtWemjUcWKB3ypzrB3asymt
	uvE/yJxVLcSGKp1zF2bOZu8K+gFpp/jzjpbnRMp9W6GjLtmSRMZTjtXLlomEPKZhRwlLE+X
	uDRe7MTyt9Mm2AKayPu62iysrj/RXl6Nfngh97pVfUnvan0rKUrnaGwruHWFm3xpvMYCClo
	prUij9RgYeThY/zC1+EdCXcM4o39OFYiycSgI0Kt2UJAYMqu18fqPjLOukZKSyE/GaZMUMs
	1B/KDKwejdEyOBGEdATDfAbp+NnJTVc7xWN7zeTxYtgzoUu5tnEAVKrm++2Jfk5B5WxaowG
	ZvTWCLW5Yr4s+/6GYQ+O2tLd8fljyAw0Ma4ZrGQdNxuZE9xK9B0WWkXdJdHWOaChrp12x7R
	jF2xSWpQEpOo52cuGAf1h7za6V157kd6kzPinlMtI46cSlUgzvmb44=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0feaf644f7180c4a91b6b405a881afbfd958f1cf ]

With __ep_remove() gone, the double-underscore on __ep_remove_file()
and __ep_remove_epi() no longer contrasts with a __-less parent and
just reads as noise. Rename both to ep_remove_file() and
ep_remove_epi(). No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/eventpoll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 93251a4858ed7..c63c2c46869e9 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -719,7 +719,7 @@ static void ep_free(struct eventpoll *ep)
  * Called with &file->f_lock held,
  * returns with it released
  */
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
+static void ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 			     struct file *file)
 {
 	struct epitems_head *to_free = NULL;
@@ -743,7 +743,7 @@ static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 	free_ephead(to_free);
 }
 
-static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
 {
 	lockdep_assert_held(&ep->mtx);
 
@@ -789,9 +789,9 @@ static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 		spin_unlock(&file->f_lock);
 		return;
 	}
-	__ep_remove_file(ep, epi, file);
+	ep_remove_file(ep, epi, file);
 
-	if (__ep_remove_epi(ep, epi))
+	if (ep_remove_epi(ep, epi))
 		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
@@ -1013,8 +1013,8 @@ void eventpoll_release_file(struct file *file)
 		ep_unregister_pollwait(ep, epi);
 
 		spin_lock(&file->f_lock);
-		__ep_remove_file(ep, epi, file);
-		dispose = __ep_remove_epi(ep, epi);
+		ep_remove_file(ep, epi, file);
+		dispose = ep_remove_epi(ep, epi);
 
 		mutex_unlock(&ep->mtx);
 
-- 
2.30.2

