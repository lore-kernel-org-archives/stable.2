Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7CF38758F;
	Wed, 24 Jun 2026 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282456; cv=none; b=VhiLqwFC9AL27lsB07mPQX8fIOEpu1c86wUhC2p9+asy6k9y+uAFPc/3Kd7anetXv76f0gN+XpyutjBAMbcmSirnVMBeefTpTRB2hTgAy0/iSTSo9heZ1w2129G42IpiXlLH0Jtc6AOSvb2rkZUNnW/QCMxBAa+gVWS5gSSSFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282456; c=relaxed/simple;
	bh=5sZq2MEmOZzdOLk1yMKeZt0Arc4QPKJAuJvhZ9wbT4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fHYkslsVYB4+z4Rl+qSEjTOnY2vNS1cvq1FSnq+ZlTRWIQ14ewAcwPZYNp6DJrfspvUfEErvEBdKYkA1tiGnPefMZ7J8tF+B5uH+h+sq7GOXN3TOCW36cjczSzniWFAcy+dyEg5X0F4jUUkXhIuXMc+hCK8tW7TkbpxM5kZlriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ivje4ESn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ivje4ESn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782282431;
	bh=OBOWGHs0suZ0nAimJdxPtgJE7kQ7tpW2enopv6Ogv/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ivje4ESngw8Oxq1nKogNIqTLvpEoBz1QMYNghLwVEn9OcKX4GzCWZ2+SyV/VIbHTt
	 qKArSzE5P1tXFZh9RYmFCW/J01qQcfuoubqXFqd4TyUHFtK/3tVKMkkvymtTumrkAA
	 hiZnh4RUmH0IGzQDR5pRCQKASB9mL4VGJMRAW3Lo=
X-QQ-mid: esmtpsz20t1782282427tdaaa7dd6
X-QQ-Originating-IP: jsBfDqdOal073tfexxLZ81gxvHcUMiZ4k9Oz7bAbS+k=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 14:27:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8524247679303276143
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: andreas.noever@gmail.com
Cc: westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v4] thunderbolt: fix bandwidth group reservation indexing
Date: Wed, 24 Jun 2026 14:27:03 +0800
Message-ID: <7683233B90328D40+20260624062703.601833-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OZr+81FobgwuqGOTS8S6aVcM3CoJKk8voFpTYHCtsCgOJkC3MDm4ozmU
	YqjKAkPovPdaT2kzV3GWPOzasXUe9WfJPI8y5a7cwXdeKT2MYT30fTCM/Fu2ZtHvSTsDkT2
	J773/D5dj29Dmgln9nKenAzwfp6xlWLjnPNQHUFgej62KeYuXQ278ImRpRd8saEYDokodO3
	IcQf0y3A94QR2+XoG2ZAhFRV7CMvskl18xTwNeE9tcD5r4s6Ik6u5ArOqrJrFXSCLS0v/HS
	cY3doo+rFGnCTybk8inJGj/dnI4P5HNq98WdssL6TMMCbKV5b1ehZB5nxzHulxHPdwaeBkx
	EZso8ZRRwX143muJ6VNj7jiMbtbdUYr1yrtxtVef+u/DK81erUC0OkRZgPUeMgSciPQsgJu
	54yx00FZDknSOORIOE3Gwp4JjexbqvIr1nI09ZqGh/n7Hg5zbsdncpkxGAofA1zqxCff1Z+
	9cqh21F6HnLcraB1s8m1EX4JLQkunjmfN06z4XtmkuqprlriStY4QpcvfLlDX9siQgZJ6K5
	yCvH4HFXTQPzA4pnsfq8rEhwWDMV6TVR12ZXGqFznkXxyYSjNzHPvYhj2Co3P7wS6FfjDV/
	gdz9I9+uYEYgHFPT+xBpYohaz4DHgTctcLsaE0DcNT+8FaPYM+gjGncI9z+knggoclGQsYf
	G8DizYyHWx45Ca2Mn4cRfib2b/n5HoS/TqEV2fHJYD4pQXn6DelZwtuy2QLhuSaoGHvgXQn
	52wjz1S3kT8EjDOm1WLxYtMyUU7wfwd7wVJrfiwG1hiHDeyAXhhwzt1M+vXaJhZx3XrTnqn
	M4DVoeBQSJztWnEGQEisPZs99Cgb+J4geu+S2u0x5EwDxquGhrgMCPc1/VBIR3CIzawMgfQ
	xpH0SGxLN/hROFjEZNgAhymSQa4qDxHnT6Vw08CuD5SFj98S0UqbtVVvUxzAUZfT5hXbrVa
	Ui0yJUbiJqSA0JwAqEcF7+qr9q2cM1EYnzwWzY7JxlYxEOUNfVz1fQA3NTFDbvZoVAdPbmG
	4YMMX8sMmtDUs4YDhSVyLhycGsqd+O4186K2EPxyM1rOfwF+VHCj5wLCBOY6bQnOuInFPWO
	h9+kBbj0wNVh4kCE07/nEw+sPN3g9PX7rA6iKLEAmK7nVhNzOtkeH4=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

Valid bandwidth group IDs range from 1 through MAX_GROUPS, while Group
ID 0 is reserved. tb_consumed_dp_bandwidth() uses the Group ID directly
to index its local group_reserved[] array.

The array currently has MAX_GROUPS entries, so its valid indices are 0
through MAX_GROUPS - 1. Group ID MAX_GROUPS therefore accesses one
element past the end, and the final group's reserved bandwidth is not
included when the array is summed.

Give group_reserved[] MAX_GROUPS + 1 entries so direct Group ID
indexing covers the reserved ID 0 and valid IDs 1 through MAX_GROUPS.

Fixes: 52a4490e89d7 ("thunderbolt: Reserve released DisplayPort bandwidth for a group for 10 seconds")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v4:
- Keep MAX_GROUPS and the existing tb_cm::groups allocation, indexing,
  and iteration unchanged.
- Expand only group_reserved[] by one entry.
- Drop the bandwidth group remapping and loop changes from v3.

Changes in v3:
- Keep tb_cm::groups[] sized with MAX_GROUPS and map its entries
  directly to Group IDs 0 through 7.
- Initialize the reserved Group ID 0 entry, but skip it when allocating
  or discovering usable bandwidth groups.
- Drop the incorrect MAX_GROUPS - 1 sizing from v2.

Changes in v2:
- Keep Group ID as the direct group_reserved[] index instead of
  converting it to a zero-based index as in v1.
- Include the reserved Group ID 0 in MAX_GROUPS.

 drivers/thunderbolt/tb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index b7cc689..47753a5 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -609,7 +609,7 @@ static int tb_consumed_dp_bandwidth(struct tb *tb,
 				    int *consumed_up,
 				    int *consumed_down)
 {
-	int group_reserved[MAX_GROUPS] = {};
+	int group_reserved[MAX_GROUPS + 1] = {};
 	struct tb_cm *tcm = tb_priv(tb);
 	struct tb_tunnel *tunnel;
 	bool downstream;
--
2.50.1

