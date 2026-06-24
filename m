Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF17257844;
	Wed, 24 Jun 2026 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782277670; cv=none; b=jAnsWD/cpgz1ryVo77IpZ8H86Gmu2e/5TDUIidKiysx2F1KoJ9y/OierzsSwjoG+YeqZW5DbuiyxKQILTbfRdpAOplT2XNwvErrSOLfT8VNLtbuG+HCw4/NQt0yvaP/T4otRMxyf9AXuKE/S72bOGPpR2JofGLNiEj7+d+aZZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782277670; c=relaxed/simple;
	bh=IiPeOZSgLMfe+PXUwalBzq9PKnNPFUelMHh/CXPVXj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkxjsoZfPbkG9Ng3EEU3tVWZ9bn3yEZs5Pn8rI7DYvAm9yrMzjs06eDGP6Os07MLlioTcRz1MQ0M5Ukq0blwTWd0NmZ3LK0/Q5R+ZieP1OQIwumMN5/JldaErNojd1XuM4fTdY+2WHWMKuuzhO/wZzCWVeuA8mnf5I0H+0Fvlj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iwo4fnma; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iwo4fnma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782277647;
	bh=sQm+M57B5ThsKu1I0KXa6VwnAFoKFPzr5SeMbIFyTgI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iwo4fnma4FQKg7bdRqnuFFkafUHsGeeiS2xMnY4G9GQ+NGnb+SznmLYt+xprZAZDk
	 CBN2SgddxAiMs9seDTpH7UDgr90TkVt7yW7Uv6fFGAMixDLVzHYnYlfzMfHhjf5VhI
	 kfwCH+DFy6UepZKA8LMDu3xh2NRw1K8iHJ45jV7A=
X-QQ-mid: zesmtpsz9t1782277642td260bbad
X-QQ-Originating-IP: CQQ9J/AS/GDTeQf6VdrXpnLtJGYUMi4uWiYcw7gtBa4=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 13:07:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7685092155646536603
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: andreas.noever@gmail.com
Cc: westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v3] thunderbolt: fix bandwidth group reservation indexing
Date: Wed, 24 Jun 2026 13:07:19 +0800
Message-ID: <BF910BF87AF1F9F7+20260624050719.4113548-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ODv7h+a+UA536S+SKs71lJP+r5X/PZDHQfBWQqI0QWKUfvlCFqzil1Zn
	AqPBedNg+c9A4kOp81eX9qawUto+8g33jiEaAKW7FaNk2w4Ok+ml0SVxSggvIb6ek+raQ0v
	1lL73HLAh5K9bbjjL/5aWF5OlmaGpJJVTIdbI0UdSJVsK6JnfhfajBX8nPKJNEWmVPUmajX
	Z2dLPjMCJA9uNM6goFzBGvk5scaNceM/rEh/duwkjjq/OkmMlRabbVThYnKDs7sKAgaxY39
	taks3KEkGkG9kgN5Mdnhw0m43jd92Li/R+j9NCwrOeJ8URYjZwtSmXz8b1reLBwbdI/4z36
	uC3FaGqusnikjjXCn0+KoRgvH7wUdY7UZVy/UZLXd0MvssHvaAOnvojrdJSkgZUklBVyTZe
	fZp4N/Eche89oqvFHiDzHbRB047Fm3tdbT8pNh+2/uhgdVleaIqj2sCxdBPen/5YOBHQ39E
	llER9ycwzNyd35z6f8cXHUaP0empfJbTVb33w6rLqfxSDgsKpQ9PnbOu+F0knnNJF9qu6is
	Bn/yGeEf3cvGd2ATQ1ZJ/fUzEsIt/bJ7nH2IawpU/WUKgwKEkaPAgIQqvR+8i/Im3UE/yfO
	aIoN+a9Hn85ma0QXTrGG+YsU2tu4JCuOwdN5+HU5F9LHb6FIq43CcMI3FaKck22xCxCi7F/
	Wn3zvfE2lNiI/oAxcLh7A2iLIKZHHpnJ6xBPyvzI+0hKH1KsO8AoO2nYbUxZKbvEsN/QLHy
	mR/u9DI4I9KpenMqk22A6WIdvumz1kAYkaX2cyUNWCJO/pJTqNSlGVnEqWncNhtrF8XNr6I
	jclIkr6gMDEKeLvayq970XCi4psVZicrxXGpCk2EoDov54FHVwj3LBAgP0WR93HRz0p/aNY
	2aC7OOglb84soM6UeJ406W3dNZvNybfWwdR4AYTio474WGuuMqnOyd5jL+h6GzV7XvtFISu
	XvaCu1j/y6PhkUmskR0IJodyOrswIhWD6wWpLinl0Wv32kVdSMx/eehcPvHNgOR5Hmq3ZVW
	SWUnyfgEny/GQ3vlKcaQof/JImbBo/k9arVNbADO1H6qvm5eNQ
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

Group ID 0 is reserved, while valid bandwidth groups use IDs 1 through
7. tb_consumed_dp_bandwidth() uses the Group ID directly to index
its group_reserved[] array.

Currently group_reserved[] has only seven entries, covering indices 0
through 6. A tunnel in Group ID 7 therefore reads and may write one
entry past the end of the array, and that group's reserved bandwidth is
not included in the consumed bandwidth total.

Include the reserved Group ID 0 in MAX_GROUPS and map tb_cm::groups[]
directly by Group ID. Initialize every entry with its array index, but
skip index 0 when allocating a free group or restoring a group reported
by the hardware. This keeps Group ID 0 reserved while making IDs 1
through 7 valid indices in both arrays.

Fixes: 52a4490e89d7 ("thunderbolt: Reserve released DisplayPort bandwidth for a group for 10 seconds")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
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

 drivers/thunderbolt/tb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index b7cc689..aad09e5 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -41,7 +41,7 @@
  */
 #define TB_ASYM_THRESHOLD	45000

-#define MAX_GROUPS		7	/* max Group_ID is 7 */
+#define MAX_GROUPS		(7 + 1)	/* Group_ID 0 is reserved */

 static unsigned int asym_threshold = TB_ASYM_THRESHOLD;
 module_param_named(asym_threshold, asym_threshold, uint, 0444);
@@ -1585,7 +1585,7 @@ static void tb_init_bandwidth_groups(struct tb_cm *tcm)
 		struct tb_bandwidth_group *group = &tcm->groups[i];

 		group->tb = tcm_to_tb(tcm);
-		group->index = i + 1;
+		group->index = i;
 		INIT_LIST_HEAD(&group->ports);
 		INIT_DELAYED_WORK(&group->release_work,
 				  tb_bandwidth_group_release_work);
@@ -1608,7 +1608,7 @@ static struct tb_bandwidth_group *tb_find_free_bandwidth_group(struct tb_cm *tcm
 {
 	int i;

-	for (i = 0; i < ARRAY_SIZE(tcm->groups); i++) {
+	for (i = 1; i < ARRAY_SIZE(tcm->groups); i++) {
 		struct tb_bandwidth_group *group = &tcm->groups[i];

 		if (list_empty(&group->ports))
@@ -1662,7 +1662,7 @@ static void tb_discover_bandwidth_group(struct tb_cm *tcm, struct tb_port *in,
 		int index, i;

 		index = usb4_dp_port_group_id(in);
-		for (i = 0; i < ARRAY_SIZE(tcm->groups); i++) {
+		for (i = 1; i < ARRAY_SIZE(tcm->groups); i++) {
 			if (tcm->groups[i].index == index) {
 				tb_bandwidth_group_attach_port(&tcm->groups[i], in);
 				return;
--
2.47.3

