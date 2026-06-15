Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348940913D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540590; cv=none; b=Au+AU2QVuUe8q+g6U7zhiJ+p5skXR3wRgg7t4RO5XQQR9ew4U+E41e3EA/cDwGxFT+K09L3+y4xXCdBnuPMqDr5sHJHC7sy8G5mUp1F4wkPayFakSjauSIMe+RtSeDIukOsn/W04PWMamQR63lzyGtS8kgaIU/boPcA+968wn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540590; c=relaxed/simple;
	bh=NytFxH0gCqbGXjr6+hDbj0gVhKqvuFUKDyCdiepwnEE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sqCjq+ocKQLBA3Vu0DoWdRBi/UUg1H/1Q+/wLDWvk7WAcUr2cKK2j1j72wmp1VxCFVqHdeV4C7HjaOLviJZWAjRcquMqJrM4dApSPF8TQwl8BKnloR4k1nBcSEO2zgxHqUa4jVlRmeEn7KKiXYkFqPjfXrihf3i3ghhihcnkzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKMWTC8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKMWTC8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779151F000E9;
	Mon, 15 Jun 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781540589;
	bh=B/CYLpCzRiWMh8h2dy/q2qDw+bj2KjhLnEp6OH0r4kk=;
	h=Subject:To:Cc:From:Date;
	b=vKMWTC8TkOpigtiCpuweM2Owzerv43rGClrtA5VpGNxj1F5pTmINCZWBVLwWDWeUx
	 jh1JI1Lpuq1FfRwgjNZEcvps3YEPuHcCrjbLuvMTNWV1Zlz0DwWnmbumrZXp9ij8Hu
	 hGi28rSjUUMxGsgWLU62iYZvrg2KuuKOzwa5r8iA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Bound VBIOS record-chain walk loops" failed to apply to 5.15-stable tree
To: harry.wentland@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,ray.wu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 18:02:56 +0200
Message-ID: <2026061556-breeze-customs-7a2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ff287df16a1a58aca78b08d1f3ee09fc44da0351
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061556-breeze-customs-7a2e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ff287df16a1a58aca78b08d1f3ee09fc44da0351 Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Tue, 12 May 2026 15:24:22 -0400
Subject: [PATCH] drm/amd/display: Bound VBIOS record-chain walk loops

[Why & How]
All record-chain walk loops in bios_parser.c and bios_parser2.c use
for(;;) and only terminate on a 0xFF record_type sentinel or zero
record_size. A malformed VBIOS image missing the terminator record
causes unbounded iteration at probe time, potentially hundreds of
thousands of iterations with record_size=1. In the final iterations
near the BIOS image boundary, struct casts beyond the 2-byte header
validated by GET_IMAGE can also read out of bounds.

Cap all 14 record-chain walk loops to BIOS_MAX_NUM_RECORD (256)
iterations. The atombios.h defines up to 22 distinct record types
and atomfirmware.h has 13. Assuming an average of less than 10
records per type (which is reasonable since most are connector-
based) 256 is a generous upper bound.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Assisted-by: Copilot:claude-opus-4.6 Mythos
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 95700a3d660287ed657d6892f7be9ffc0e294a93)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index c307f42fe0b9..507b628abdb5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -222,6 +222,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	ATOM_COMMON_RECORD_HEADER *header;
 	ATOM_I2C_RECORD *record;
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	int i;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -234,7 +235,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -293,11 +294,12 @@ static enum bp_result bios_parser_get_device_tag_record(
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -966,6 +968,7 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -975,7 +978,7 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -1670,6 +1673,7 @@ static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -1679,7 +1683,7 @@ static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 	offset = le16_to_cpu(object->usRecordOffset)
 					+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -2769,6 +2773,7 @@ static enum bp_result update_slot_layout_info(struct dc_bios *dcb,
 {
 	(void)i;
 	unsigned int j;
+	unsigned int n;
 	struct bios_parser *bp;
 	ATOM_BRACKET_LAYOUT_RECORD *record;
 	ATOM_COMMON_RECORD_HEADER *record_header;
@@ -2778,7 +2783,7 @@ static enum bp_result update_slot_layout_info(struct dc_bios *dcb,
 	record = NULL;
 	record_header = NULL;
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, record_offset);
 		if (record_header == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 4f213ea865b8..0e1f973326ed 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -396,6 +396,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	struct atom_i2c_record *record;
 	struct atom_i2c_record dummy_record = {0};
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	int i;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -429,7 +430,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 		break;
 	}
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -534,6 +535,7 @@ static struct atom_hpd_int_record *get_hpd_record_for_path_v3(struct bios_parser
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -542,7 +544,7 @@ static struct atom_hpd_int_record *get_hpd_record_for_path_v3(struct bios_parser
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -611,6 +613,7 @@ static struct atom_hpd_int_record *get_hpd_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -620,7 +623,7 @@ static struct atom_hpd_int_record *get_hpd_record(
 	offset = le16_to_cpu(object->disp_recordoffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2195,6 +2198,7 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2203,7 +2207,7 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 
 	offset = object->encoder_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2232,6 +2236,7 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2240,7 +2245,7 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2268,6 +2273,7 @@ static struct atom_connector_caps_record *get_connector_caps_record(struct bios_
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2276,7 +2282,7 @@ static struct atom_connector_caps_record *get_connector_caps_record(struct bios_
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2354,6 +2360,7 @@ static struct atom_connector_speed_record *get_connector_speed_cap_record(struct
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2362,7 +2369,7 @@ static struct atom_connector_speed_record *get_connector_speed_cap_record(struct
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -3263,6 +3270,7 @@ static enum bp_result update_slot_layout_info(
 {
 	unsigned int record_offset;
 	unsigned int j;
+	unsigned int n;
 	struct atom_display_object_path_v2 *object;
 	struct atom_bracket_layout_record *record;
 	struct atom_common_record_header *record_header;
@@ -3284,7 +3292,7 @@ static enum bp_result update_slot_layout_info(
 		(object->disp_recordoffset) +
 		(unsigned int)(bp->object_info_tbl_offset);
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (struct atom_common_record_header *)
 			GET_IMAGE(struct atom_common_record_header,
@@ -3378,6 +3386,7 @@ static enum bp_result update_slot_layout_info_v2(
 	struct slot_layout_info *slot_layout_info)
 {
 	unsigned int record_offset;
+	unsigned int n;
 	struct atom_display_object_path_v3 *object;
 	struct atom_bracket_layout_record_v2 *record;
 	struct atom_common_record_header *record_header;
@@ -3400,7 +3409,7 @@ static enum bp_result update_slot_layout_info_v2(
 		(object->disp_recordoffset) +
 		(unsigned int)(bp->object_info_tbl_offset);
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (struct atom_common_record_header *)
 			GET_IMAGE(struct atom_common_record_header,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
index ab162f2fe577..19fd7aea18f1 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
@@ -37,4 +37,9 @@ void bios_set_scratch_critical_state(struct dc_bios *bios, bool state);
 
 #define GET_IMAGE(type, offset) ((type *) bios_get_image(&bp->base, offset, sizeof(type)))
 
+/* Upper bound on the number of records in a VBIOS record chain. Prevents
+ * unbounded looping if the VBIOS image is malformed and lacks a terminator.
+ */
+#define BIOS_MAX_NUM_RECORD 256
+
 #endif

