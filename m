Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695308;
	b=LjjTx6QdT16f/pax255VcnLyZMBcx44fVWUwdWYlUCZ3fC5S86jpM177dRUCVEUiR0bR
	 lAOmB+oEtqcrxci07uMXFQv6naqG2F82MGhuoQfRyL4L7Kf0tyPw3H0SQMCZh+jkKRgu6
	 /RG6Czl8ooYEwo+21FJzqpCJceSA7dLsgd1Wk24XYDa7o8TneqhlwaWLIE4J8TNFnkFfq
	 K0m4oQqOhky1lGBLt9RJ+BolP4Ou70YUCmoeP5AWqedhjKkB3xstqMcweYX0bvsKFJNfc
	 Y8rGlEQdYL6pipsXlXv3SaZXcQNpQhe8Va6TWkM8bgCs1RVewvN4y4pYVZlu1ZUELNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695308;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GpC/kN1NBBm4imp5gYshw5jTke0NsIykdXIGbZBqn+k=;
	b=U+a3xpc3BrVClW2JPt5fu6MGY2cu38lf+3wBCIBgrtr99DN2Ffe6rEoYyZo2W/VJsJSn
	 7gpN/JeoHVAXOkBn7JMxNaKuaQ1Bnp06mCbmlN8ehTAx1Yxh239+pvGCvIFNLYYAq1vnb
	 f/KNgJ4rr/p+pS7BRlOHG3yvxSNM3haz/B3zGYZPnYYWNQYUB3SKntyhQVdK9PUNN5a4S
	 t0guGAVEL0HPKcnKYrZsSBLGnwA8suybnhFcRSyxOzBymtWtR2hSW0F7l9QeUiMGsZWf5
	 3gMXsAR31goUutqF1a/0cFyp26i/SqadgtpCRpERdSUiXxxnmEeS1eAfCbJYFsFv7mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="iKvyD38/";
	arc=none smtp.remote-ip=115.124.28.123
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C8606A33F;
	Tue,  3 Nov 2026 08:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B85C8606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=iKvyD38/
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695297; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GpC/kN1NBBm4imp5gYshw5jTke0NsIykdXIGbZBqn+k=;
	b=iKvyD38/A7wSZtR/zecIfrkiv025+wqN+Tz0DGWdZKi7XEkw/3u26lLLWO7/HzSXYaxdPGfdmRVlSiH9efu/6WqZAtSjHHAKNw++U4d+izIX1bfa0KPFEuuhtQYHDA6HyWyAuQ3y0hYEWZg2L1HHaB0C09nUtpjf8IIYB4i5OlU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4832416|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00521408-0.000768213-0.994018;FP=10174869151215584561|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvUy9D2_1793695296;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvUy9D2_1793695296 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:36 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: adi - bound the two-stream packet merge
Date: Tue,  3 Nov 2026 16:41:30 +0800
Message-ID: <20261103084135.426629-3-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a second device shares the wire, adi_move_bits() appends the
second packet to the first one at an offset taken from the
10-bit length field of the ID packet:

	for (i = 1; i <= adi[1].ret; i++)
		adi[0].data[((length - 1) >> 1) + i + 1] = adi[1].data[i];

	adi[0].ret += adi[1].ret;

Nothing compares the merged packet against the size of the buffer:
adi[0].data is the last member of struct adi, and struct adi_port
holds two of them back to back, so an oversized length field makes
the loop write over the second struct adi - its device pointer, its
length and its packet - and the inflated ret later walks the reads
past the buffer as well. The connect path also calls
adi_move_bits() before the length has been validated at all.

Reject a merge that does not fit in the buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/input/joystick/adi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index e07b71978509..03535e58d6a6 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -168,6 +168,9 @@ static void adi_move_bits(struct adi_port *port, int length)
 
 	if (adi[0].ret <= 0 || adi[1].ret <= 0) return;
 	if (adi[0].data[0] & 0x20 || ~adi[1].data[0] & 0x20) return;
+	if (adi[0].ret + adi[1].ret > ADI_MAX_LENGTH ||
+	    ((length - 1) >> 1) + adi[1].ret + 1 >= ADI_MAX_LENGTH)
+		return;
 
 	for (i = 1; i <= adi[1].ret; i++)
 		adi[0].data[((length - 1) >> 1) + i + 1] = adi[1].data[i];
-- 
2.50.1

