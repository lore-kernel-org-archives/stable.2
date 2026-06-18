Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00633845CD
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787302; cv=none; b=FT1wk3uNMbYw15ZQXC3b0zKvMc/b4X44vARjFNBDhxrSbY82uNRXwHipv3JO5FOMID3PNFYZOKzEwsDppl9kE/Ljye18fpoyQUT6/zDzgZhiEeMHg1AzV3XD9Y2zLtpCE3sFcaDj9OHZuTSN3/eF+DFCykA322mTN3+8hYBv3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787302; c=relaxed/simple;
	bh=RRT8hrGj+s7KQb0uKabXz3/lqs42GcaEUUXRTa2EQfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEOKTZ/uxaepcBkaktYoWY7uXK+mfFY/21xjfTLGXfqy6UVxon/Xm15GjeGVNnzT3VGzHJIxCAMCFDMQ0q8TkiOZ05KxzkXtkDL0VoYJjV6ECya5Z4NWR2OwEn0ZMg8Hah/togaxYNJYDBZiwPaMVgl5zWkEfgbOqB70iW8UVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck/J2Ww9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck/J2Ww9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B64D1F00A3A;
	Thu, 18 Jun 2026 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787300;
	bh=DUSCofD6XHqh5rqG5RfOIBz6v/G6kVtJAGvrslmDqUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ck/J2Ww9zMFwsZm3aT2Y867ZeGwA/Ht7cWNedCwDyx2vWJwq+XMsPV6gExwSfrNEP
	 260rJTRz6R/LMcyFecOlRZQQvbsaNCWr9XCKbLOBrMo8GYrb5Z3MZzqdelNKUFOu9R
	 1u+OT7HA5AVGtbml/AL/uzuoO9rjFygDFWO7oS81lnUFVBxrkT7yBeBbU6m6XKZpRI
	 srKXWej796f5uIXeMwR4+rJst3TBlCx9tiXw6fv0miDYVz4m31iZZTfYKuNPVoW/o5
	 hf/l5kAGJIkL3HMoj1IeEDtUVSYtM98FoO/QloRF8Wr7B/sr7kF/kGvmSFyyJ4gyvB
	 ell3OMsnBnFOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/display: Bound VBIOS record-chain walk loops
Date: Thu, 18 Jun 2026 08:54:58 -0400
Message-ID: <20260618125458.649905-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061554-sabotage-criteria-6a11@gregkh>
References: <2026061554-sabotage-criteria-6a11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit ff287df16a1a58aca78b08d1f3ee09fc44da0351 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 15 +++++++----
 .../drm/amd/display/dc/bios/bios_parser2.c    | 27 ++++++++++++-------
 .../amd/display/dc/bios/bios_parser_helper.h  |  5 ++++
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index d8982aca8ef680..d2730af8e8030f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -223,6 +223,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	ATOM_COMMON_RECORD_HEADER *header;
 	ATOM_I2C_RECORD *record;
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	int i;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -235,7 +236,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -294,11 +295,12 @@ static enum bp_result bios_parser_get_device_tag_record(
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
@@ -870,6 +872,7 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -879,7 +882,7 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -1572,6 +1575,7 @@ static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -1581,7 +1585,7 @@ static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 	offset = le16_to_cpu(object->usRecordOffset)
 					+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -2665,6 +2669,7 @@ static enum bp_result update_slot_layout_info(
 	unsigned int record_offset)
 {
 	unsigned int j;
+	unsigned int n;
 	struct bios_parser *bp;
 	ATOM_BRACKET_LAYOUT_RECORD *record;
 	ATOM_COMMON_RECORD_HEADER *record_header;
@@ -2674,7 +2679,7 @@ static enum bp_result update_slot_layout_info(
 	record = NULL;
 	record_header = NULL;
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (ATOM_COMMON_RECORD_HEADER *)
 			GET_IMAGE(ATOM_COMMON_RECORD_HEADER, record_offset);
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 9a1663d0d3525c..b572bbbcb7d344 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -393,6 +393,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	struct atom_i2c_record *record;
 	struct atom_i2c_record dummy_record = {0};
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	int i;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -426,7 +427,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 		break;
 	}
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -532,6 +533,7 @@ static struct atom_hpd_int_record *get_hpd_record_for_path_v3(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -540,7 +542,7 @@ static struct atom_hpd_int_record *get_hpd_record_for_path_v3(
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -610,6 +612,7 @@ static struct atom_hpd_int_record *get_hpd_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -619,7 +622,7 @@ static struct atom_hpd_int_record *get_hpd_record(
 	offset = le16_to_cpu(object->disp_recordoffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2125,6 +2128,7 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2133,7 +2137,7 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 
 	offset = object->encoder_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2162,6 +2166,7 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2170,7 +2175,7 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2199,6 +2204,7 @@ static struct atom_connector_caps_record *get_connector_caps_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2207,7 +2213,7 @@ static struct atom_connector_caps_record *get_connector_caps_record(
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2288,6 +2294,7 @@ static struct atom_connector_speed_record *get_connector_speed_cap_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2296,7 +2303,7 @@ static struct atom_connector_speed_record *get_connector_speed_cap_record(
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -3144,6 +3151,7 @@ static enum bp_result update_slot_layout_info(
 {
 	unsigned int record_offset;
 	unsigned int j;
+	unsigned int n;
 	struct atom_display_object_path_v2 *object;
 	struct atom_bracket_layout_record *record;
 	struct atom_common_record_header *record_header;
@@ -3165,7 +3173,7 @@ static enum bp_result update_slot_layout_info(
 		(object->disp_recordoffset) +
 		(unsigned int)(bp->object_info_tbl_offset);
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (struct atom_common_record_header *)
 			GET_IMAGE(struct atom_common_record_header,
@@ -3259,6 +3267,7 @@ static enum bp_result update_slot_layout_info_v2(
 	struct slot_layout_info *slot_layout_info)
 {
 	unsigned int record_offset;
+	unsigned int n;
 	struct atom_display_object_path_v3 *object;
 	struct atom_bracket_layout_record_v2 *record;
 	struct atom_common_record_header *record_header;
@@ -3281,7 +3290,7 @@ static enum bp_result update_slot_layout_info_v2(
 		(object->disp_recordoffset) +
 		(unsigned int)(bp->object_info_tbl_offset);
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (struct atom_common_record_header *)
 			GET_IMAGE(struct atom_common_record_header,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
index e1b4a40a353db1..da1e30de3c59a0 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
@@ -38,4 +38,9 @@ uint32_t bios_get_vga_enabled_displays(struct dc_bios *bios);
 
 #define GET_IMAGE(type, offset) ((type *) bios_get_image(&bp->base, offset, sizeof(type)))
 
+/* Upper bound on the number of records in a VBIOS record chain. Prevents
+ * unbounded looping if the VBIOS image is malformed and lacks a terminator.
+ */
+#define BIOS_MAX_NUM_RECORD 256
+
 #endif
-- 
2.53.0

