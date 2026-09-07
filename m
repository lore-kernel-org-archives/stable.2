Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED5381E83
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817003; cv=none; b=B4mMgOAqZ8mK0aU6UwGmcRmkev47zYnZ7Po+Io8xNnFQ9bt7gVEzcKcWk8LII8qOjDz+jAsD32LAnxjmIac2+Ns7lWameEsPG12Rj0Hc1TNywmvmgF+Ii90C/zaR2MoJzZLQLDDuuH4AmGNnnDGKhuXUU9su/WQ2WqML22ZKG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817003; c=relaxed/simple;
	bh=N92e/QdPuqCZnSeevHJIaIx0LfzeudcK3tiyZlGt8/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd3MO9oVzi8+w5mLvBOxgJf7vzI0GdjKNyUFRIULEIXugqSm76VMeu5nQu2tpZJEDrjfQHu9cej5RHkKSmbATlUrb57S8HXO4h9I/s7oLZrB+y9iq+0e6g0I5wl5zcmNus0DNL26luaV92jbATQmC7gfK/itp1SXh2etRlhtfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hetHgGwZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hetHgGwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51681F00ACA;
	Mon,  7 Sep 2026 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817001;
	bh=kuZo5CGRsYshkcdTEio8jjOR1vnk/S1Hyf8fsKezPew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hetHgGwZCXVIBZ4mQAucwl6i6sjuuI5SCRTcAaN4XRiU69qzTLp+sxqKbrBj0PGDa
	 EtFRnzjdwNxbN/fe9dM0NS+jk2OtpjVd0R2RDhqP24J7hYKuU+BNenMGMcb8r05UGQ
	 Phm1bmHf1+Ap8lLYLiMVjiZSGjlMzDR5APhaDxHrh344o6w5YOhY8TmWfVsQMDr06i
	 i6OckKzwhgFSWkhJ1kNLnhPkZc6+pdFz4A+rzOEEL7dpcSbIGTHjw6kDMrYW+I9PLF
	 8HeRuqRbbPz5rqX/SDoovZxYRooPuicizDPB1QLyBkwAiFeDQFU1DyzialyQWUhKfD
	 qCtmD5NMbbdDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] HID: sony: constify fixed up report descriptor
Date: Mon,  7 Sep 2026 17:36:35 -0400
Message-ID: <20260907213637.574137-3-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit d4781a27add1a881b92cd71d1ce6190c121d042b ]

Now that the HID core can handle const report descriptors,
constify them where possible.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://patch.msgid.link/20240828-hid-const-fixup-2-v1-11-663b9210eb69@weissschuh.net
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 912016954f5f2..8486228a49a75 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -99,7 +99,7 @@ static const char ghl_ps4_magic_data[] = {
 };
 
 /* PS/3 Motion controller */
-static u8 motion_rdesc[] = {
+static const u8 motion_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
 	0x09, 0x04,         /*  Usage (Joystick),                   */
 	0xA1, 0x01,         /*  Collection (Application),           */
@@ -195,7 +195,7 @@ static u8 motion_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-static u8 ps3remote_rdesc[] = {
+static const u8 ps3remote_rdesc[] = {
 	0x05, 0x01,          /* GUsagePage Generic Desktop */
 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
 	0xA1, 0x01,          /* MCollection Application (mouse, keyboard) */
@@ -599,15 +599,15 @@ static int guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
-static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
-			     unsigned int *rsize)
+static const u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
+			      unsigned int *rsize)
 {
 	*rsize = sizeof(motion_rdesc);
 	return motion_rdesc;
 }
 
-static u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
-			     unsigned int *rsize)
+static const u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
+				 unsigned int *rsize)
 {
 	*rsize = sizeof(ps3remote_rdesc);
 	return ps3remote_rdesc;
-- 
2.53.0

