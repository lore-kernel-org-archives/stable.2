Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512171;
	b=EL26Gu9XaJDX7EVKfyZHo+a6o1Hsse41vdZLnfhmA1gxzr9sQrNVpRY6tJdk/DZbdoJV
	 v8pqgEGIfdCy17tCflWGGrC8jaZh74gAy0Lv6M/2XdtN4V0GCfo9GpmMZqd0Y69zINeG5
	 KXRHbs87HKL48142zsfYU6htWHELMMM/024dOALRaNTt/LovTtEF5ajuCUnfMDxSr9AcN
	 hnwb3gyzBxj4KA3VG4BnUpmSCtV3I6/iO6bLRYq7q6XFZFXaPDNcYC9TNWwsij+uazbyk
	 35p9cMSEy70NYztlzPPbx25hnIA229ICRmV7OEqe7apUVdqooalgkBvK6zh5HKn7yTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512171;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yeaPuQOyc2+PcyGK62lj/sAWaop4WT2t2qNQ1jKa9JI=;
	b=v1kEEGsI4N3TuU5G5WGU6Kyq4UxpasTWaC+kUFG98f8M+P7Zb7F4gf/eCt04L9uxqqH+
	 vmao9x2gcAJ1duKeCkHYLdxWh4p9LEwB5aMMlul2uDYYXTZ1jg76xDQ4ntWEzMirXmT38
	 FN2q8WaqAxn3uBgC2g1O70u2AUkcwtqyeHMZUcx6+Ddg6COGmpvGUrrpwxCQ46bONQPOJ
	 MwpHkxMg03HCrLc89/C7W2AL7m85O0NyUjoVwUtEEZyXoC4B+Rh3CyIpWmXyXSwnPMd/5
	 f44mg890cYG8bn6emkaMNwEzHAUO7iZXPnHD91YaFpUV7/gxJDtA7jQ6G4zBrxC3pww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRAX45B0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C8606A326;
	Tue, 24 Nov 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRAX45B0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795512171;
	b=j/R+zxJLcz5nlDzghtoshpeNVeMOmOkDxnGX3KtM/jR68hMYMkzgU7bLUoNzzd6ayuxk
	 wYVtQI2hYu3JCqKJRsJUIbZqeJ7Cz1um4Bep9qKcd4+4qbHerUnLDua4Iv1kE2C20/xd0
	 EYfJmPYyL0hyXqbiXJTgV/Ch1m70XhlKVrmtT4B5OUk0GkfSl876MSV6Imz3aJc9vZOrt
	 bVrs1RA5q8c+BYDn7JVtJBwb8o+fuJ3B4SdpbLIUAaVsOGt8+cYuY1KVl8wkyrqa6k1NR
	 CRFbxip3LBPAJwrt8wlhIqpZkgCBmfMl+LEtPjuWJkb/8pYVMzblADMNnQ9xSFDfNdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795512171;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yeaPuQOyc2+PcyGK62lj/sAWaop4WT2t2qNQ1jKa9JI=;
	b=jFpxeSe6i0q6X+DtrIXP/dlPczFhKtcJUfIB9j8NWn3G6afZCSBJjVOM29e2jwksZ3UQ
	 ygYpQnTa9+lkoyZOe78sjDh8ehDB70oWpRt5HPM3tH8l5pbUC4piEJ02gVyY8dn9Jxi3s
	 Q5akr3JZohOmE5bRqTjxKbwcZcfQjM5afAdh/syfteeBM7DBIh0svMZgZjHtnEY4pbK1J
	 q0Sy1t6Wt36YvGhCBXE2cctX6QuJgjEkjFqOLAeDikoOtiGDXS3cXfHu7pXmt4hezYvaJ
	 A3sxBPHy2uE1OsbUWkd6FQTc5OFsnfc49nE6Ksol7D/irCuPhmnqHupW0RDtkhkZ2Rg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D8AA41F000E6;
	Tue, 24 Nov 2026 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512171;
	bh=yeaPuQOyc2+PcyGK62lj/sAWaop4WT2t2qNQ1jKa9JI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=hRAX45B0v4dr+OwBfMHuIaWsq1OjqMrIEW9nuS1dqd+RfOutTcC8DTqv2aYkQ0xTw
	 OcakbjBquPSsXsPPyOaM+423A5srGkkKg7C8NsfB+ps24t4uEvRqfg7JIKjDlNNyUL
	 dIH27tT+x+43EC7Q4X3sVpfhLl0zZesftdoMOuHNfn+TjCbdfiFqBKtvaWXej0hvDQ
	 JrU6Bo/odPcYrVqYiiTmf3cSkDHCsFh/TLIKnVNoNQVUWreLv9YCd2tbm2vIh8ihsh
	 y2/xdlqN4aPWF5nlGLAFC6nkh7Qqm5VtZp/atniKcxAnQrQ/E0aQC0rCI/tlhu2K6C
	 2jMBFpHwszm1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6F1064C97C;
	Tue, 24 Nov 2026 09:22:41 +0000 (UTC)
From: Markus Haberlander via B4 Relay <devnull+markus.haberlander.rosenberger.com@kernel.org>
Date: Tue, 24 Nov 2026 10:22:38 +0100
Subject: [PATCH v2] mfd: cgbc-core: Add support for conga-PA7
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
Message-Id: <20261124-cgbc-conga-pa7-v2-1-18a114b1801c@rosenberger.com>
X-B4-Tracking: v=1; b=H4sIAF1XBWsC/3WNQQ6CMBBFr0Jm7RjaGkhceQ/Dop0OpSa2ZIpEQ
 7i7gGuXL3n//QUKS+QC12oB4TmWmNMG+lQBDTYFxug3Bl3rRiltkIIjpJyCxdG26KlpvWHN3jS
 wjUbhPr6P4L37cXm5B9O0V3ZjiGXK8jkeZ7V7f+OzQoW98artXa35Ym6SCyfHEljOlJ/Qrev6B
 WDrxr3EAAAA
X-Change-ID: 20261123-cgbc-conga-pa7-dc67d3e2ed36
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Markus Haberlander <markus.haberlander@rosenberger.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795512160; l=1669;
 i=markus.haberlander@rosenberger.com; s=20261123;
 h=from:subject:message-id;
 bh=IOEHi9ik+Gei7mZb0tLBs620x7KvO4P21+5TgD1iQJs=;
 b=/8vMuI5kp5xVkSw0F53JIvS5TevRM+LtzH1vjlnHPKRYKTMU1lsFeD10e1jxejYOjf3R/uMYa
 bsG8CYGNVwdAp5ESWSqFH1mKuSsZ1MXIW8Mqhz4EID1mVWMRl6vjSUj
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

Match the board vendor and name.

Tested on a conga-PA7 (board revision A.2, BIOS PA70R026): the core
driver loads through its DMI alias and adds its GPIO, I2C and hwmon
cells.

The patch and this changelog were drafted with the help of Claude
Opus 5.5 and reviewed and tested by me.

Cc: stable@vger.kernel.org # 6.13.x
Signed-off-by: Markus Haberlander <markus.haberlander@rosenberger.com>
---
Changes in v2:
- Drop the remark on the empty system vendor and product name from the
  commit message (as requested by Thomas Richard)
- Link to v1: https://patch.msgid.link/20261123-cgbc-conga-pa7-v1-1-f3d17fb02e43@rosenberger.com
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


