Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B2439F75
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752040; cv=none; b=O9UVbMI74GzeFRpPu+Blgn3OpIBEYueNwPu+eOcfdkQKAydY4uN/c9wK5Lfzx1ZiJT+NU2GKPLT1dhFsJjKCs8bn1kcEb4KDRsgkfLNQlADYcwhVAmRyQuxgjEqnSWNCf9/G9CtNLLQiXvq9SQUrKA5UmnMoMyAKHIPiAszsPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752040; c=relaxed/simple;
	bh=uAh9TW42CviDLuCtV4nL6t7OhOtKICaD3uEJ/elmlNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrL4DtXX2jbXrJhJcYMGmdGOyIFDcV2iABMyIvV606XE0vAq2NvsixwRD8UN/E7A2PW3N3zygiFBs13fFs1E3sINex1vozHX0oM11G3zFyj7cnpfIhuln01tc8VlACD36azyX/rPGMIIuB+tZR3QDOGi4qb5WFWX/ibebt1XWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBZcWhhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBZcWhhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A681F00A3A;
	Wed, 26 Aug 2026 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752038;
	bh=s/zMlrY+SNN651tkABB/R/4SuT9JlRzgPBik+cyhyoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBZcWhhH49EggIRZ/qbMUpnEJjC5WiWTXpmrdS5lpk8Sy6OS2RhqbtGdGKlptkR4p
	 Rjbc4k6+FDUmuJLNSh4ALKbGAmshWsX/LL0tsQA0M/Ebb4k7WLU2vjnbtljoGAu7s1
	 kt6mWKYSooWlfqWI8OO0oIVMyG8czQz9+RpEZGm5AjTC4LI7gf1b5vXz5vtsyZFivO
	 9OfJ2c32gvqEcfCtRawpL5wgegmfR1AauVXAVlLK43g+brVlZqYQmBHM+Dap7k0TvW
	 1dhmBmAUZkGnE34gJjvfD+SsSpjuZC8YPiNnMe8Uzycm3RjgfiQZgmXXRLo5iAO+Gg
	 5vTEq8ZrExKmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Oleg Makarenko <oleg@makarenk.ooo>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] HID: pidff: Use ARRAY_SIZE macro instead of sizeof
Date: Wed, 26 Aug 2026 09:47:13 -0400
Message-ID: <20260826134715.3968449-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826134715.3968449-1-sashal@kernel.org>
References: <2026082517-petroleum-anaerobic-3fd3@gregkh>
 <20260826134715.3968449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit 8de2cef6d0de8cdddee8d653a18791525af26fad ]

Could lead to issues when arrays won't be 8 bit fields

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Reviewed-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 67bb1074e3d2 ("HID: pidff: fix OOB write when hid->inputs is empty")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 471dbc8fabc98..fe5462a19df38 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -158,20 +158,20 @@ struct pidff_usage {
 struct pidff_device {
 	struct hid_device *hid;
 
-	struct hid_report *reports[sizeof(pidff_reports)];
+	struct hid_report *reports[ARRAY_SIZE(pidff_reports)];
 
-	struct pidff_usage set_effect[sizeof(pidff_set_effect)];
-	struct pidff_usage set_envelope[sizeof(pidff_set_envelope)];
-	struct pidff_usage set_condition[sizeof(pidff_set_condition)];
-	struct pidff_usage set_periodic[sizeof(pidff_set_periodic)];
-	struct pidff_usage set_constant[sizeof(pidff_set_constant)];
-	struct pidff_usage set_ramp[sizeof(pidff_set_ramp)];
+	struct pidff_usage set_effect[ARRAY_SIZE(pidff_set_effect)];
+	struct pidff_usage set_envelope[ARRAY_SIZE(pidff_set_envelope)];
+	struct pidff_usage set_condition[ARRAY_SIZE(pidff_set_condition)];
+	struct pidff_usage set_periodic[ARRAY_SIZE(pidff_set_periodic)];
+	struct pidff_usage set_constant[ARRAY_SIZE(pidff_set_constant)];
+	struct pidff_usage set_ramp[ARRAY_SIZE(pidff_set_ramp)];
 
-	struct pidff_usage device_gain[sizeof(pidff_device_gain)];
-	struct pidff_usage block_load[sizeof(pidff_block_load)];
-	struct pidff_usage pool[sizeof(pidff_pool)];
-	struct pidff_usage effect_operation[sizeof(pidff_effect_operation)];
-	struct pidff_usage block_free[sizeof(pidff_block_free)];
+	struct pidff_usage device_gain[ARRAY_SIZE(pidff_device_gain)];
+	struct pidff_usage block_load[ARRAY_SIZE(pidff_block_load)];
+	struct pidff_usage pool[ARRAY_SIZE(pidff_pool)];
+	struct pidff_usage effect_operation[ARRAY_SIZE(pidff_effect_operation)];
+	struct pidff_usage block_free[ARRAY_SIZE(pidff_block_free)];
 
 	/*
 	 * Special field is a field that is not composed of
@@ -194,10 +194,10 @@ struct pidff_device {
 	/* Special field in effect_operation */
 	struct hid_field *effect_operation_status;
 
-	int control_id[sizeof(pidff_device_control)];
-	int type_id[sizeof(pidff_effect_types)];
-	int status_id[sizeof(pidff_block_load_status)];
-	int operation_id[sizeof(pidff_effect_operation_status)];
+	int control_id[ARRAY_SIZE(pidff_device_control)];
+	int type_id[ARRAY_SIZE(pidff_effect_types)];
+	int status_id[ARRAY_SIZE(pidff_block_load_status)];
+	int operation_id[ARRAY_SIZE(pidff_effect_operation_status)];
 
 	int pid_id[PID_EFFECTS_MAX];
 
@@ -642,7 +642,7 @@ static void pidff_set_device_control(struct pidff_device *pidff, int field)
 		hid_dbg(pidff->hid, "DEVICE_CONTROL is a bitmask\n");
 
 		/* Clear current bitmask */
-		for (i = 0; i < sizeof(pidff_device_control); i++) {
+		for (i = 0; i < ARRAY_SIZE(pidff_device_control); i++) {
 			index = pidff->control_id[i];
 			if (index < 1)
 				continue;
@@ -1002,7 +1002,7 @@ static int pidff_check_usage(int usage)
 {
 	int i;
 
-	for (i = 0; i < sizeof(pidff_reports); i++)
+	for (i = 0; i < ARRAY_SIZE(pidff_reports); i++)
 		if (usage == (HID_UP_PID | pidff_reports[i]))
 			return i;
 
@@ -1121,7 +1121,7 @@ static int pidff_find_special_keys(int *keys, struct hid_field *fld,
 
 #define PIDFF_FIND_SPECIAL_KEYS(keys, field, name) \
 	pidff_find_special_keys(pidff->keys, pidff->field, pidff_ ## name, \
-		sizeof(pidff_ ## name))
+		ARRAY_SIZE(pidff_ ## name))
 
 /*
  * Find and check the special fields
@@ -1196,7 +1196,7 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 
 	if (PIDFF_FIND_SPECIAL_KEYS(status_id, block_load_status,
 				    block_load_status) !=
-			sizeof(pidff_block_load_status)) {
+			ARRAY_SIZE(pidff_block_load_status)) {
 		hid_err(pidff->hid,
 			"block load status identifiers not found\n");
 		return -1;
@@ -1204,7 +1204,7 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 
 	if (PIDFF_FIND_SPECIAL_KEYS(operation_id, effect_operation_status,
 				    effect_operation_status) !=
-			sizeof(pidff_effect_operation_status)) {
+			ARRAY_SIZE(pidff_effect_operation_status)) {
 		hid_err(pidff->hid, "effect operation identifiers not found\n");
 		return -1;
 	}
@@ -1220,7 +1220,7 @@ static int pidff_find_effects(struct pidff_device *pidff,
 {
 	int i;
 
-	for (i = 0; i < sizeof(pidff_effect_types); i++) {
+	for (i = 0; i < ARRAY_SIZE(pidff_effect_types); i++) {
 		int pidff_type = pidff->type_id[i];
 
 		if (pidff->set_effect_type->usage[pidff_type].hid !=
@@ -1270,7 +1270,7 @@ static int pidff_find_effects(struct pidff_device *pidff,
 #define PIDFF_FIND_FIELDS(name, report, strict) \
 	pidff_find_fields(pidff->name, pidff_ ## name, \
 		pidff->reports[report], \
-		sizeof(pidff_ ## name), strict)
+		ARRAY_SIZE(pidff_ ## name), strict)
 
 /*
  * Fill and check the pidff_usages
-- 
2.53.0

