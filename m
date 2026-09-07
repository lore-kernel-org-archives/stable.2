Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8D3947B5
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817003; cv=none; b=cqL56g2WU1qaG4osDZMEJjvqjMLa3aA7Pb+OOuSSGbgkDWfwaZtr7+Lxs+FHmmC5jexUg+IV85gtwTqtgnpo0wCPLefh9eZTAJHzwP3XdkCkLC8uQ+jKbNXiUDa4w3Pefln9RD9t619COXylkK7H6+486i3mGhdk/7Y1wl0An3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817003; c=relaxed/simple;
	bh=Bw3tfALxWZS3GOsnKv8ij0YaaUK0tXMXkZ8C0bYTKs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNVgECVmtf0jKJ57Ut6eviGAhLJcLzCI9X32cl0Sw5xQp2phUQbGBaDcChceckVqsN6wtksy8imhf01kct4gW6JhLyHChmEO1EpfY5l4zYSup3fI7jCpKsfIeeL09K3sHOwPzSlSAyMKoVFK4yghus91hQDqEqBvn6ofJnTLxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4V8mHIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4V8mHIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053B61F00A3F;
	Mon,  7 Sep 2026 21:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817000;
	bh=64CwKNZGUyzi2Fmz91jQMneITk5EuJcczoZOMenERCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m4V8mHIL+M2B8i5BrLRGow8HwLxzobmpQf3om5DzOc1B8CvgWnJbYAeANm5ATmiKP
	 RWNa0G4prLmuIf4OIgI9ZuZYGKjZ/wuq9yJnwQlg9fP5sOZZEk2XfHPbzxjsdCiY1x
	 IVLn+czPs8cqhYS7HQWLRV6ky7nAMTSq8c1bcYh3G7FaLpj/HUeyc67M3z8f3Q53Bk
	 34dpUeum6wUEdgzuxcRLmEGlmWzgcW5kHZMYIHR9PBpg+qDGUwHC3UmtsFME0jOQGb
	 E7/D5I5vrPOlowqtzPPjKc9FGJPHHnBeI2qWNsNBqEnnf5Lf9WMbAF+NRCqtUrmbtG
	 KwJ4huoHGs07A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] HID: sony: remove redundant assignment
Date: Mon,  7 Sep 2026 17:36:34 -0400
Message-ID: <20260907213637.574137-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907213637.574137-1-sashal@kernel.org>
References: <2026090344-dislocate-egging-04af@gregkh>
 <20260907213637.574137-1-sashal@kernel.org>
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
index e3e292b3362bf..912016954f5f2 100644
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

