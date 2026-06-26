Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2D211A14
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447333; cv=none; b=th3SLHk3uFpayH0x4027R9TH7CGkaTMvNBuR0ClGdj9GZYM4cBwIn3qBhjjsiv+3BbBvh0srw3zEHum6pGabzPrpxCHDJ7BQzuuJ1eRWq0whg00r7e7UwWB0B4pwYlYoa+OVoaXbojSWK+NwhfSUXabsRHIy97Z0+w0YlJGhQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447333; c=relaxed/simple;
	bh=0C0IjCYWJ6gzo44qxkoSRDofRHrsLyyyjBHkwqfonaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZESoeobFvti/6JzRZgyyege4VWzhuAMf/VmdGvURkGW/0T1rLYdQwTfEDoi/o8+t+WHFLAWyMp55EW1LczFWGkljbB3sX5zj6d/8RlTWeQOpOZUp2JqfvNngvlDsQ6P0VBRlPsuVbbnSL27fRWSQVaAjY3R1rCAel9BUIJerfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RsL3yu/J; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RsL3yu/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447296;
	bh=MyeGzdWtJPNDd1e6oKLKGjJ49Ouc+aTJc25q+GIkkPQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=RsL3yu/JHpa4pGXWAuUtWEA+jFAfWiEC5jYTfNrViihNwvxZIvM2PnlvwbUq6w6T4
	 F2bTvfdwiJ5r+2AtDzcuVJPz0VEs/0ArNuMNOXQtSvHP0I77lQYK5Akr6fLNa5I1iV
	 ZBm6PcttbK7XoAvTyJodVMOFCx1Ki2lwtccqTsis=
X-QQ-mid: zesmtpgz1t1782447289tb04409ea
X-QQ-Originating-IP: qX21DUoW/numuD2+8vi5N7aggvDBEAZYuQlaS4CdUwQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8357307985730952757
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.6.y 7/8] eventpoll: move epi_fget() up
Date: Fri, 26 Jun 2026 12:14:02 +0800
Message-Id: <20260626041403.85968-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MDnRDgydGgijembCjR1l7znKCI6L56VdL+u6qV8PTNCQju6zkI+kQncF
	/P0c4lWL+Jqmkqib+JnImv+cQTC74LYwLG9crJNbFleIAbQhpJO3fIb2xeSMPIjmxVYq8eK
	lb25P/WTNgPsYTQoNNwilC9BO5nVI3GITfvugFbcbHfuEyNiEFnriBlWHpQJ/pHv4rbTiTh
	AYyJiLi3s5NOWGuBMu/nSM/G9ZsXI+9XoUtjFVPcf8lJJCiHN9LU7CskOzNDaPodzA4F9KQ
	B2q0Z8JSk+NNWe/CIUjI9ygzpQ9IeTFalxwpI8oLuXbZlrtDSW1VTg05ZO0XbFw74mvNi++
	Cw8aUvUaSzun77qhqr8EZGngzfE30qgYrnnMhwQCBljlExwrd9QsYoGNuxwlwZirv64S551
	OZn7O3GopQzkBP3c+7TyFLWM9vrt3xhiebVIWYCbxYV51nU926pRTcwdrDwR3N1/RfPUF1w
	B9sPqgtZXDTo1Tz26GkrOIsSbvIPxmuAdq+phXiF1UChkJFLr13mD1UwGcZEZxfIfE/6upA
	WZKlAdO60L2TUUnKvv9L8pAtA2Zm0BWJRLRnbGv/pNuxz1uYSuhWqX3dHjrHR5I0wuKEzXw
	DEY8d3QTXyCPzIoNyOANa/y9/JMEqeDEgZlcfyAX11e/LHcyHjCx6exLs6tHrLr+ZWBm5P8
	bKF+u8CyrGygyJouxeKPfN89Mt24QDrDka9j7FPngA5Prx9gJ0s4vav9BTY/DTF2uyOdPdj
	XrvJDl7lIiBMTbfv0j9QL76K11loeZ/4TOmk0WRujhQSWgrCIwIeochvBPjRjsqqu7eQl8D
	LIQ3fKDVNSRV6OV0djzml6AKtyNcr6nzfRexGfDJ8HKf7Jmaf5WJvUd2FAix12Xg50ataEY
	8ErbmiG1BW+4cZP8q6k4EYXEBhXbd5OwBtqe4sFRAg3bR7GEk4pM3EVQYYsruBNkY1uXWIU
	pqdDaAMVFfB5pgnuN0C70vENssWYlZBaunvKP3gT0xZ76JV2nA3mvJnyhk4Az4jPOmCBzN9
	ldW0u796rCzuM8RRNMrtJkJY0NSTMPjUK7l/JQssyW5iszKqmTw5ouHIQjEfJhLI29/eeEV
	URaQoVBFoCY51eTHM1mxQhD2WUMA7dEN+5sL0stT/mhfTe7KB2b5Ps=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 86e87059e6d1fd5115a31949726450ed03c1073b ]

We'll need it when removing files so move it up. No functional change.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-5-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
[file_ref_get(&file->f_ref) from original commit left as
 atomic_long_inc_not_zero(&file->f_count) due to v6.12.y missing commit
 90ee6ed776c0 ("fs: port files to file_ref") and its dependent commit
 08ef26ea9ab3 ("fs: add file_ref")]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index db5d7c1d726c8..fc4668a403c9d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -715,6 +715,34 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+/*
+ * The ffd.file pointer may be in the process of being torn down due to
+ * being closed, but we may not have finished eventpoll_release() yet.
+ *
+ * Normally, even with the atomic_long_inc_not_zero, the file may have
+ * been free'd and then gotten re-allocated to something else (since
+ * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
+ *
+ * But for epoll, users hold the ep->mtx mutex, and as such any file in
+ * the process of being free'd will block in eventpoll_release_file()
+ * and thus the underlying file allocation will not be free'd, and the
+ * file re-use cannot happen.
+ *
+ * For the same reason we can avoid a rcu_read_lock() around the
+ * operation - 'ffd.file' cannot go away even if the refcount has
+ * reached zero (but we must still not call out to ->poll() functions
+ * etc).
+ */
+static struct file *epi_fget(const struct epitem *epi)
+{
+	struct file *file;
+
+	file = epi->ffd.file;
+	if (!atomic_long_inc_not_zero(&file->f_count))
+		file = NULL;
+	return file;
+}
+
 /*
  * Called with &file->f_lock held,
  * returns with it released
@@ -886,34 +914,6 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	return res;
 }
 
-/*
- * The ffd.file pointer may be in the process of being torn down due to
- * being closed, but we may not have finished eventpoll_release() yet.
- *
- * Normally, even with the atomic_long_inc_not_zero, the file may have
- * been free'd and then gotten re-allocated to something else (since
- * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
- *
- * But for epoll, users hold the ep->mtx mutex, and as such any file in
- * the process of being free'd will block in eventpoll_release_file()
- * and thus the underlying file allocation will not be free'd, and the
- * file re-use cannot happen.
- *
- * For the same reason we can avoid a rcu_read_lock() around the
- * operation - 'ffd.file' cannot go away even if the refcount has
- * reached zero (but we must still not call out to ->poll() functions
- * etc).
- */
-static struct file *epi_fget(const struct epitem *epi)
-{
-	struct file *file;
-
-	file = epi->ffd.file;
-	if (!atomic_long_inc_not_zero(&file->f_count))
-		file = NULL;
-	return file;
-}
-
 /*
  * Differs from ep_eventpoll_poll() in that internal callers already have
  * the ep->mtx so we need to start from depth=1, such that mutex_lock_nested()
-- 
2.30.2

