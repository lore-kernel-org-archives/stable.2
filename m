Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECCA2609E3
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999480; cv=none; b=oJcKo1TM+GitAgQGdgqXbbnYStQbmQ+b5WjhXG2H8upHkoDB4HdQ1zgbNlpei+Yeewf2t4UL+NAxSyP1gww84US+qBLqrQoQhgpU0ewV/SPt18yrsrak348BlfK2DlJNWgdvtJtmlKEZoNZfBR5przU8mQQG3nIk2QiZvnB9CVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999480; c=relaxed/simple;
	bh=zDBPfuyrRsjM7Xd+6ZmTmXqcpku7oQ/OWxSTjeMrbVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KStsElnR7ODBmDw/UuNzVePpUo7uPdmsk5DmYYsNqYRM+ds2CwmLYH2jvdnoPD2eLhCHoPsRddkmMXB0qIRyH2QYu5/xzZSCx1t3LawkKOJ8ez018T0VIrlpLiyJrVZoKcSIQGoFu8pohMNSi6p4IcvuoEikDxMrgHx1EyWzN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbCpoOCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbCpoOCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD991F000FF;
	Thu, 10 Sep 2026 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999478;
	bh=HjtHhHMqTG3OT82bXFOL64+sQEsLIgojaZQPEiD3t8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZbCpoOCLIx3q7i5yfYmtrVCovS0rjU7G1+aAmYG9nHZHQNt+mHFJ8McbQNupCrCQ1
	 dKyQ8+epjHmSzTfwVkO24gJ5+6jU4YWcKu6+/i79YIGa8++hvbYZUxBvzq1yPklTI9
	 cmkOC2bFjK3Cf0mQPR6U8UmgzMvBRGwmwei0n/I3LCKb2Pp9FOPUOwMy0xmSfuCFvD
	 wARtVUzCWPQVOeso6uZzPVoycX8xbbPYLgOXyMIUwFubqa/gDGA5uhPMGxb5SpikGB
	 RIXq/6rcmgjM7t/LifhFDdKxsnJSWNSgCmc6GCcrgMcgzC1jwKA4DrL8BiHa9YtaX+
	 v/Sr6mqiYquyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] i3c: master: Replace WARN_ON() with dev_err() in i3c_dev_free_ibi_locked()
Date: Wed,  9 Sep 2026 20:17:54 -0400
Message-ID: <20260910001756.3748845-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090419-hunchback-antics-d9e3@gregkh>
References: <2026090419-hunchback-antics-d9e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 471895799c2f46688792e175ced936ffeb6cdf01 ]

IBI disable failures are not indicative of a software bug, so using
WARN_ON() is not appropriate.  Replace these warnings with dev_err().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260113072702.16268-5-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Stable-dep-of: 456f832e5fc2 ("i3c: master: Fix recursive locking during device registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6eec1e6fb139f..067dd5946d512 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -3054,8 +3054,11 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	if (!dev->ibi)
 		return;
 
-	if (WARN_ON(dev->ibi->enabled))
-		WARN_ON(i3c_dev_disable_ibi_locked(dev));
+	if (dev->ibi->enabled) {
+		dev_err(&master->dev, "Freeing IBI that is still enabled\n");
+		if (i3c_dev_disable_ibi_locked(dev))
+			dev_err(&master->dev, "Failed to disable IBI before freeing\n");
+	}
 
 	master->ops->free_ibi(dev);
 
-- 
2.53.0

