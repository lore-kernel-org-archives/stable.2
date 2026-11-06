Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980341;
	b=XCBbFCua72ILFsR7JdaKWjB3F1Ym2LQZAMpxjsl2o0ojKeNeYbQ6X6MKRJF+H/jDAnXP
	 ECwQHXICBEZ1Qovn4pJGT69duBBbCT0xnIFuuKvgS9E6RjOGvnRApsfbJBYGdCYj0ntEl
	 PkGLWqbui2YYmbN0yWIodrCQHELRQ7GLkYo5mOMs7+GFY1ksq8PfUs0U9IVNw7v//TTN9
	 N9N+vq0LglZXghXXiYmYVGS9tB9pYSVph6JkIB/rMAAPGGIahLrMrLaE9iEcQWI/KYnoN
	 oWRrl8yEBe/SeO/ceyj8HvF83FTzeCoHA+/g6bmMg2woQsNJJ3oyb2fEnpbPufdnSLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HNB7FMaf9+d1tYs284izMdYn/bRHJGgOJdCh0UXGTZU=;
	b=K+N3R+cGo0I+SzwTdEBQ5sH1V/NigchB7gliJBggh7FyaBWGBTf9Qkn03DMUI5QnRqx5
	 jCPVaAiRlQzkMsm5C5AEyu+gXtTx+10gQSlcNQBoFx1VWI0kgahPZuwFTJm9EybZdfwwp
	 RteQUEaTxqRxMlwQ6AYXWnrg+BFK8qmSozL9gycBiCGlGOfAsBHaHIm+JvALD3WxunDW8
	 R/NQ6MuQw/BqO2nbGa4GBcBECGQfbzK76O/xOTN+iRBznewmWP4HW2QfZYAshOFq8tJyf
	 YnWDPRVCDPTG9nrJRLJ2p3bkbjcUxC6xQro5Mm5KI7iZO8weNAk7T1QpETlaihJismg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5V4AKLa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FA606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5V4AKLa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFE11F008A5;
	Fri,  6 Nov 2026 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980341;
	bh=HNB7FMaf9+d1tYs284izMdYn/bRHJGgOJdCh0UXGTZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5V4AKLao6FOZlvAgTQflcvh33ZTw8B7JpjDJaYvrIQhiqUMlB5kmezWXny0T+s+B
	 FceZkqF7a0N9tof8OJXDUR5EAH63tWghtf1LoPd7osjxNqhGyVDkUyRx1kNzqQYaLj
	 fEIga0A8BdXdSriXPHWys4Al+B2Oq1zWuoEdomOl+zwPJ4noIBgvkBUhnsC/mbxsG+
	 1hYq8LQC2J7bry9UqDLaluOrM4nz6yCVi9g6hN3dWTT496BHmxnaeBH6RzHomA1O9Q
	 2lWb2Q87xOQrU3EFQiDn0xkvTgWgERIu3hOrmXp5ZPA7/vKmVrTCMvlUQJ0+Ggnc5s
	 1sfufn3A2GaLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] HID: prodikeys: validate fixed-format MIDI reports
Date: Fri,  6 Nov 2026 10:52:18 -0500
Message-ID: <20261106155201.483050-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106155201.483050-1-sashal@kernel.org>
References: <2026110450-magnifier-vaseline-6e69@gregkh>
 <20261106155201.483050-1-sashal@kernel.org>
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

From: Jiale Yao <yaojiale02@163.com>

[ Upstream commit 0ff37294c41bd925258893310398bc2b45fcd4a7 ]

The HID core invokes raw_event callbacks before validating the report
length.  Prodikeys reports 0x01 and 0x04 are passed to handlers that always
read bytes one through three, regardless of the supplied size.  A truncated
report can therefore cause an out-of-bounds read.

Require four bytes for the two fixed-format reports.  Keep report 0x03 on
its existing variable-length path, which derives the number of note pairs
from size and only accesses complete pairs.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: 3a370ca1dcf8 ("HID: Prodikeys PC-MIDI HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-prodikeys.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index b53b0c02675a4..f2b9142e95021 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -774,8 +774,13 @@ static int pk_raw_event(struct hid_device *hdev, struct hid_report *report,
 		if (report->id == data[0])
 			switch (report->id) {
 			case 0x01: /* midi keys (qwerty)*/
-			case 0x03: /* midi keyboard (musical)*/
 			case 0x04: /* extra/midi keys (qwerty)*/
+				if (size < 4)
+					break;
+				ret = pcmidi_handle_report(pm, report->id,
+							   data, size);
+				break;
+			case 0x03: /* midi keyboard (musical)*/
 				ret = pcmidi_handle_report(pm,
 						report->id, data, size);
 				break;
-- 
2.53.0

