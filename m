Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366786;
	b=Cxgu/BOrgK2mmqs2mU87bTk3/YeblHtpY1vDBajGoeIPRUJME6fJX1RAa4wXo5NiMdM+
	 Fe0WaBPGDY6Y9o1LChtvGERx68TBM9DT+Uj0bWh49G83vUoSFxLKKfrRBYQPr6yXZDRQr
	 z0T9ITYMpy4jqGbcyoLkNer1vEZVEI69NXTHVS9Z3pqaboojtudfBnTQd/ajCn4xnvLec
	 SEae861CcvxNPbOux+ou3UIEt8a6aCXSDOIg8SlrZjkL2lsxpl4Riz3BuM57U99UAvW9N
	 6p8dbHrwCwt5gpiEKBmA+aLfdXT3qvgrV+pcIrrn0/ZtCJmTGqx7D5lo4Glwzv1dl3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cukOiM1/nQDpUWagJIOLud71lrIDc0Hv/xaf+slcQtg=;
	b=1oI8VI/u14DKGbhAMnkSTsu6H7DkhJyc3n6PSsorcVuZl3M/PbJmpQloSrPo/PG5xu2q
	 bgcgn7kUdrW/x4Ku0uzNpmHTU3gGfQgT4d/sue5hy4qH+Pc0T3gkcTwmbNzZKJEU32bha
	 mIISAM+YYpR3UdK/f/344xHiu1rfBJywOL8LRaKUj0XFGSVhBZl931lynaBvYJvjXdNEV
	 6pjhCik5jcPDnBcEw89OURO0bUxWOssb2jereUetcpoTmUd0md4Cuj7AXaPvsnHTzPxxi
	 brGvcShgbAgr7LJXE2anzRFbvTYHBk1r4qzV0duKgZsv3DzggQsUecbSTRHqznuHP9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3BiStrb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E454606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3BiStrb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A452C1F0089F;
	Wed, 11 Nov 2026 03:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366786;
	bh=cukOiM1/nQDpUWagJIOLud71lrIDc0Hv/xaf+slcQtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d3BiStrbInK7LjLCPrQh8L9WyqbvB1AJOCzlvbJ3lhNctaUSIQtxGFlgMmsQTFwiZ
	 hyshGuIatW9DxOxMUaCr/2J+FyUXKxYn6ig23wfe3O+a7jpa/G0ajeRyY4EAEL0d6A
	 M1ugp7lzpNPY3pDoHQjDrgXm0wo60rspq3eHo0B7HrOLza8UeF/VOIZvqOEEmXEMHy
	 N/343J0TmZ2YAz2TQxVCLwn7SxC/7mxFyOX6bmkkmae75o+whtqaag3MboJf92d/fw
	 VABza0305Xfk2veu3/MALfARA+hwwGKs4MP8MFiXHVlduzLbThtEu6Hkv0lTeNnW8q
	 CCh+TXNVJHcJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hemanth Selam <hemanth.selam@gmail.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] platform/chrome: Fix typos in comments
Date: Tue, 10 Nov 2026 22:13:03 -0500
Message-ID: <20261111030918.832540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050410-failed-7.3-ca75b38b1a3c@kernel.org>
References: <20261107050410-failed-7.3-ca75b38b1a3c@kernel.org>
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

From: Hemanth Selam <hemanth.selam@gmail.com>

[ Upstream commit 2d23d5e9cb468baf6e4fa78d0dd7e8555759385d ]

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Link: https://lore.kernel.org/r/20260904110900.20435-2-hemanth.selam@gmail.com
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Stable-dep-of: ca75b38b1a3c ("platform/chrome: cros_usbpd_notify: Only use drvdata when parent is GOOG0004")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_ishtp.c     | 2 +-
 drivers/platform/chrome/cros_usbpd_notify.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 3766cef81fe82..b21a27ad37625 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -369,7 +369,7 @@ static void ish_event_cb(struct ishtp_cl_device *cl_device)
  * @cros_ish_cl: ISHTP client instance
  * @reset: true if called from reset handler
  *
- * This function complete the initializtion of the client.
+ * This function complete the initialization of the client.
  *
  * Return: 0 for success, negative error code for failure.
  */
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index d842c05f4db00..6f5eea4938cb4 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -64,7 +64,7 @@ static void cros_usbpd_get_event_and_notify(struct device  *dev,
 
 	/*
 	 * We still send a 0 event out to older devices which don't
-	 * have the updated device heirarchy.
+	 * have the updated device hierarchy.
 	 */
 	if (!ec_dev) {
 		dev_dbg(dev,
@@ -115,7 +115,7 @@ static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
 	if (!ec_dev) {
 		/*
 		 * We continue even for older devices which don't have the
-		 * correct device heirarchy, namely, GOOG0003 is a child
+		 * correct device hierarchy, namely, GOOG0003 is a child
 		 * of GOOG0004. If GOOG0003 is a child of GOOG0004 and we
 		 * can't get a pointer to the Chrome EC device, defer the
 		 * probe function.
-- 
2.53.0

