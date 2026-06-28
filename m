Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F034F507
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663728; cv=none; b=ZGulg0zX2c8KrQ6OVbSl+49Q9fsCtaROQDREaXR0Y/yeK9X02FcmXY9jxhc4exXlqXptpMknhwlW/majzSVdpJTTNXR6VxAOWIREsb5xS++QAwUP8wKbO3ZKOBkJYfctHLw9XAOd2oUPt5QgNe5orEcNZl18XUKkErqdk2nT51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663728; c=relaxed/simple;
	bh=b0hwOyHZBQXBuXPleLjrOyffa6xRckVe1PzWDbLAWrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrN4mQ7qMP9yFXZocg//s4xa2g4Q+BAEMiReTbmseoRhmAWJfXF3F+jQn03Nq/BZUVHYOXgRjx2dqAbkXXn4rHbLqJdNmaizMSCw6Xp/Y5HOpvbotNYNrrtn40JIcUTsdGLGmSNd4ncDoKj/IaYACwB1jzYzwHA6IlmB3BUqc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HRcVI4qn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HRcVI4qn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663627;
	bh=ZO0vYdG8+zInot9nuVfLo2AsAw1+BulTmqCbYLPKuCY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HRcVI4qnjb1AkVrH34BUR/rHo8kIYsddlEFWv7i6xj9cJanrCwGp/n3KXgAERWgd6
	 ImWMkUFboXNhZO/p5FvGqeTnTHjv+b2qkDnOaQ7SjY8rNYwT3lxEblU/crri5GlAZf
	 XDnAWHslzUub/pD1Mvyto2/H6mw0C8bDgmxrak2U=
X-QQ-mid: esmtpgz10t1782663602t210c06b1
X-QQ-Originating-IP: jvb42HwQiXkxxrDYUZA72+tDq9XqUQnubZE1FlAWL6c=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:19:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7245329537163941116
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 2/9] file: add fput() cleanup helper
Date: Mon, 29 Jun 2026 00:19:29 +0800
Message-Id: <20260628161933.532572-3-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NRN3UPsLzYKVYOy9VnnPe8YXmgBztWD7i2c2LnUN35CVK5M5zLyoFgjb
	Ry6zX1TEYqeY8KCigLR7s95H8jyHbcv/5d8kuUrPv3G6j1joUM7g/fo4MJWDaO4cMMFbKUb
	sfoFYDjHy1q7Tss3XlUMtbiOH3uFNiebkn4wO2GV/LP8PJBr7dXNK4E2ZgjVu8PzC9WY6SF
	T/JRLLK0Jh2hw9d91wCHeWNsZKxK6DybNS3QsyEtsYL6Yr3zCe1t438x0UXnPt4uUeSkPZx
	cV2TEscaEJEGNmSBbSfIBkwYqn+JKaFohlmP7ITjfRI5vFjxH3lDUMKZnQj9Np/K3arngMm
	sta9TOCBZaMqGm7LC5k7NSMcdE1ZvgD5eyAKrfBAwoUnci1ADTmkI/xvItrNCXfa8oSt4OV
	EVS18JhRy8Tw84Uj5M6imRP6x99ZsJ7HTbEAQyj3tghJ6p3IHtTyhlYP8g2TgM25pC/6WUH
	F+F5zNh+s8exr5VTBeh5eJNbGsWjbeyHseQ9zi0X+vRyKO4vldxBhdVPeCLwF/xd8uM7J8V
	KgvFUkxXo9bZbi5EvZoZP8ZYmbGvkPrl8WKt29uz3ib9fZYacHxeFuLY9L+3amaWJhMtrwc
	q1+O9io1RVDzMwrODzWttCPKTsYRfTdvfNIhxb4/4YFQswbndAre20vs0t74NFvNA2tLdnA
	jkbckjKuLSlq8EuteXqDMzIa18FpzrV2wff19WHHZtISQ6MjlLdrWL6wmEpD7oADMCdw6Ci
	ORmq80YvZpqNjabiHnhBJuR/2f/nAoHjadj0PxKsT4Y1Wtd/HDO2dIwPZSIhgaqYzgHTy8/
	OBhB67Vx2Hw8ORgBDGkirhWQ/4q2B/HXonPcBgEGIrckPnPjgmAzegDr+LinRlwfOs96z7U
	BPjV5KUNyhXzbhQUGbYl9LjURHVX4doJbKX2C0Y39/29g0LgbMQsPt6O4kItkhkgQBts+ad
	VuzkbZEuYhP7QXgwHRC1Q0nWTRZZURT/f2/ewVOWlbmKPGQ8VskAA4hlTVgqar19tJ1AZMR
	GY0ihdBUVDeAF+V7O26faE41+BvTxYuuxOr2jhmQ+cPFxx5DaX1gYK1zksJj1QVK6nX7TJM
	bLPJCaoNw38IlLDV27+Urc=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 257b1c2c78c25643526609dee0c15f1544eb3252 ]

Add a simple helper to put a file reference.

Link: https://lore.kernel.org/r/20240719-work-mount-namespace-v1-4-834113cab0d2@kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit 257b1c2c78c25643526609dee0c15f1544eb3252)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/linux/file.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/file.h b/include/linux/file.h
index 6e9099d293436..221ba0888107a 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -11,6 +11,7 @@
 #include <linux/posix_types.h>
 #include <linux/errno.h>
 #include <linux/cleanup.h>
+#include <linux/err.h>
 
 struct file;
 
@@ -93,6 +94,7 @@ extern void put_unused_fd(unsigned int fd);
 
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
+DEFINE_FREE(fput, struct file *, if (!IS_ERR_OR_NULL(_T)) fput(_T))
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-- 
2.30.2

