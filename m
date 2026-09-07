Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EF3B14CC
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820089; cv=none; b=pQVuFmQtyrIeOuGJftH6BKc9g2f0JVqWkgavI42qoyb4ZXa3R+ybiS8PMMUWbzY++YXqJFUcyNGys6+CSsViH+VUfvKDADYL7tRaOBxWlUXio8Nd6A4v0Mv5sHvQ2KeF4Yb5Ev3UdAnJ+mTFP/pvyYNSmqTzLxRdHRcBPvFhEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820089; c=relaxed/simple;
	bh=Q16CIh4bJqJQkYMpR7boq+2OqFz6aJvBGbsNO6yiWzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQsOzxSZeWWxuAdqhWOBtMVlbOuAIhk+VN/TiHLbDUiBzIFi+YClQQ4t4U8bzbuRe290qxcstTrsBOt49YYY0rO8iOg0DsotonNaDnwWPCmBSvHu1r1GmioJSgkyK85qizZnYSg1g6A0BFyWgueLJtKyD8oJVMJaB5+cK0QSYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk+JcnXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk+JcnXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A9D1F00A3E;
	Mon,  7 Sep 2026 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788820088;
	bh=Xl/gPhk6qt0vNELL7fII4uXnrF2tr5oRTcNJl4al/yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fk+JcnXNNK/8YvlNcL0c/SMWBJYAAUE0dLtgGHt3ww1eQvNq+v3XrF3GS0bULzbu4
	 Q0J1yp0NFLj0erSUpAgBJV94/tEuwK6nzmP4HgbrX8dsQCNW5zLB31vAW02gzYkPE4
	 3LoV9+t3ctVZr4Hd67jx7t2TLX5+0KFdhxmth9n3DqPckSTWVrpdeyTLU58z1qyUL/
	 eFgX3Q+he/HuABqs5R9nVG5ZlQMkab3XlA/j+1/Hcv6t3/8akudaYP+RZN6qG6UeHu
	 BR0KUyAEASwuDfzBhymv9Tu5uFsxq2G2/Qso1fTkhh/FQMgQ0cMg0FpH3GbCY863qw
	 T4ou5vGJtNV5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] HID: sony: remove redundant assignment
Date: Mon,  7 Sep 2026 18:28:02 -0400
Message-ID: <20260907222805.669827-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907222805.669827-1-sashal@kernel.org>
References: <2026090345-compactor-scandal-09fb@gregkh>
 <20260907222805.669827-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 4e124ed0da2939dcd27849a3d6f41fbc537a20be ]

The variable ret is being assigned a value that is never read
afterwards. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/hid/hid-sony.c:2020:3: warning: Value stored to 'ret'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 10c9c16f07590..33e6e5cebb146 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2014,8 +2014,6 @@ static int sony_input_configured(struct hid_device *hdev,
 
 	} else if (sc->quirks & MOTION_CONTROLLER) {
 		sony_init_output_report(sc, motion_send_output_report);
-	} else {
-		ret = 0;
 	}
 
 	if (sc->quirks & SONY_LED_SUPPORT) {
-- 
2.53.0

