Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795415576;
	b=aRB5HlML8Cs0a4OO47s4VORLFpoY5J3tqyiTr1rVQ5QCBkutsmVK6DHgs4SO8rKqX1mt
	 xEUoSspXdqkn/YTNOnedVwPG0De+KpK96z/IopBWCld9wgRcGhpLw7QabZtmrwG4aylBL
	 jK0AHhp39BLK+7P7EC6q/FTnA7EHPpruCs1qHeF4nNVuBbOEUNg9L8kXvqsklUKHp4LZ3
	 10zTlb116uDM9PsHekP97S3WFQeXlAPNnr5hjp4mQbc7bywtAGl6Sz5oGKK9Ydsi+tmkb
	 AfRXrq3Eyf0Y8iJFUvlkI9/FfVRDkNJrVRJto03LfrqZ7QgmQPV2emBWpcbMFwry5nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415576;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jJ5HTt6plunxin31vtC4rDMiI3PR3fN6iuRHRpNNp8k=;
	b=TaD/J3VjknLbTP9MLY8LJKVCqM8Os5fdmhYetIUq3YHU2SrQ4f1WGNLvFnIjCYTGhA3A
	 RpeE2Hgsjmb/j4kr6c8i7EWoBOiJ8Ln7HoLArGUNegUYccj5bizBN801HxN3z0SVRxQhJ
	 w40Q9N1uIdsPit3k8E0sfx53G17f/yVjPvJzX/abBE2BJGHZ+QoAk8pTqxkJvMmgMBZQ/
	 wAUlNJx/yyGOZwppBtleiyeDO2cj2vBm4LxL80sL/D4wYOMD+rroZjWs1xVRTRd7dmztI
	 Wll9KfBgztKdwmlK64XFGMcGA2xhQ6SiZAmRlJ7wSFqm+hKVOPiubhe4VyZYecWsNOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mO4UuqUH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC77606A31A;
	Mon, 23 Nov 2026 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mO4UuqUH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795415576;
	b=v+wDBH3k6afTKz7auXzC1E2PhpSZNF13SLI0fO8iRuSdDQJLTeG6uOarnQ6wR8hM2XGd
	 S658toaYmIByvkFUA5OKpSl8+KD1urv3ijvNQgeLDFaPa67kOzkC+7qOZxBR0U16Dk1Mb
	 U3teCoRPcetyZ0z026l1PuWu/kM26+ZpFT0LTLP3VB27FOaFdeyyPER/0b7oo4LRHIlUE
	 GfGlWIo1b24KRLybdWDCrAJxrw1RtodVW1Cerdpi3o1XF2U6eXNBG/kxJKNMt4k/2styY
	 Ri3jIxjYVZaxuP5x/I1ErveiFVlEoZCS1W9FTjh0xo3w9T3YEROOccz2L7Sh54eNWQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795415576;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jJ5HTt6plunxin31vtC4rDMiI3PR3fN6iuRHRpNNp8k=;
	b=u1IhZPFzwmUuNNdkgRTiy0WvdHRi11B8jBUCnbnDnIGQzb/sdg1dQPfmLu+kX2tM7bQV
	 1stEgfCCzhH4cjTlIaUW7uRewnh1Dqt5Xxrc21HeMPA8hZbQAQ/cl0KO1V4SB9HTZdTXJ
	 /6HPz804n22ACQ/jKhhUa7FFne2c3vp2TEWVBTuSvp8tSSSPjZevRrxVjQLdOGTDHqOLv
	 FVQ8NtTnwj48+2UGl+ZvDfLjblbdxkizyZA2fmShjj5DnJjATz/LQj0WxLk+NyRxIwNTm
	 HUJ6E9VvXYBwCHr8X7QJtegX/REYSrnADnn/bemt1t0VVHKUPBXY0XsJnHy1UtApg4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2FCEB1F000CA;
	Mon, 23 Nov 2026 06:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415575;
	bh=jJ5HTt6plunxin31vtC4rDMiI3PR3fN6iuRHRpNNp8k=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=mO4UuqUHklj3xa2LjzYeh5smm+9jQgMuQ7AkfEqt6jFk+DhFTuKbYagt1YvjPUdob
	 +jE4jmmMMz6kLRKj4sWOxVRI3nt6+aZdr2P3qmOwNmdMVs+Oe/cfwhwbTR9lRd0SGL
	 0/CQAM4Tw5JPbVOLl3X9NyGHDQwXHtszfKR2tlw1BBzgQ4cNfDeQjF9RuTcVVXDZwn
	 n7fJWN3ekBPu8quGHK0DCEwQKuYI5jg6jnGlvRnVwtYBU98Eqt1FqEM3dLpZZy9i9a
	 BW3X6+D7RqsJFqC/cXzhNdky5aybvsfWjiB796nn+r+PG3OX2mclWzwli2ZUD5cwGF
	 et4gx/rCyhrJQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 42DB04C38F;
	Mon, 23 Nov 2026 06:32:45 +0000 (UTC)
From: Markus Haberlander via B4 Relay <devnull+markus.haberlander.rosenberger.com@kernel.org>
Date: Mon, 23 Nov 2026 07:32:28 +0100
Subject: [PATCH] mfd: cgbc-core: Add support for conga-PA7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-cgbc-conga-pa7-v1-1-f3d17fb02e43@rosenberger.com>
X-B4-Tracking: v=1; b=H4sIAPvdA2sC/yXMQQrDIBBA0auEWWegKhjoVUoXZpza6UJFkxCQ3
 D0mXb7F/w0qF+EKz6FB4U2qpNihxgHo62JgFN8N+qGtUtoghZmQUgwOs5vQk528Yc3eWOhRLvy
 R/R6+3n/Xdf4xLdcFjuMEGVKK8HIAAAA=
X-Change-ID: 20261123-cgbc-conga-pa7-dc67d3e2ed36
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Markus Haberlander <markus.haberlander@rosenberger.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795415564; l=1513;
 i=markus.haberlander@rosenberger.com; s=20261123;
 h=from:subject:message-id;
 bh=v1CPWN/2XkF2f1MoPpYxZuyNZds9qyQfrKK/LTczYvU=;
 b=Y2uothSjoELTvG4Mb6hN5yuCH4QqU5F6vr3ENRqv1VUiWrYP30Km46XE/zr7onLPqOz4YGiws
 1b2VGJMzJ4cCHecyB24R07WlKZv9zD5RwgXp7oSmw/ppYxk8Rz8iFC9
X-Developer-Key: i=markus.haberlander@rosenberger.com; a=ed25519;
 pk=baNIWlZCf58g17gE2FS6ir0ymNwyBXguoQENSJkXdeQ=
X-Endpoint-Received: by B4 Relay for
 markus.haberlander@rosenberger.com/20261123 with auth_id=1612
X-Original-From: Markus Haberlander <markus.haberlander@rosenberger.com>
Reply-To: markus.haberlander@rosenberger.com
Content-Transfer-Encoding: 7bit

From: Markus Haberlander <markus.haberlander@rosenberger.com>

The conga-PA7 is a Pico-ITX board with an Intel Elkhart Lake SoC, like
the conga-SA7 SMARC module. Its board controller is of the same
generation and is accessed through the same I/O ports, so the existing
driver works with it once the board is matched.

Match the board vendor and name, as for the other boards: the system
vendor and product name are empty on this board.

Tested on a conga-PA7 (board revision A.2, BIOS PA70R026): the core
driver loads through its DMI alias and adds its GPIO, I2C and hwmon
cells.

The patch and this changelog were drafted with the help of Claude
Opus 5.5 and reviewed and tested by me.

Cc: stable@vger.kernel.org # 6.13.x
Signed-off-by: Markus Haberlander <markus.haberlander@rosenberger.com>
---
 drivers/mfd/cgbc-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 8a63923d1..cd68d396d 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -379,6 +379,13 @@ static struct platform_driver cgbc_driver = {
 };
 
 static const struct dmi_system_id cgbc_dmi_table[] __initconst = {
+	{
+		.ident = "PA7",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "congatec"),
+			DMI_MATCH(DMI_BOARD_NAME, "conga-PA7"),
+		},
+	},
 	{
 		.ident = "SA7",
 		.matches = {

---
base-commit: 1cb7268b6638c411fc32f373e965eb8ba9e9b2b4
change-id: 20261123-cgbc-conga-pa7-dc67d3e2ed36

Best regards,
--  
Markus Haberlander <markus.haberlander@rosenberger.com>


