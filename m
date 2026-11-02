Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619024;
	b=MWktwSOrQV2GEs4lbwLFrZTyQQ9QHTCDKL+V4cqpq3p1GUsmUzlb7pTCh7kyIw4NYbWQ
	 2BebL1a4VvpI26q6LOUBV1kv4ruAA12lO5y7MUdQ2l1/bDXNZunAuvjXfFWgEurvDLKKV
	 LZ64GwuYxcuA0CKgdeBFEZ6tLrO8HefoVXsalY83Xbx6ioYRL+JD8H4QXstuQcTBiIcyP
	 vyYuXNV0BbhN6oUXtef+Osjzuu9J3GuKN+e2Yqzc7Aaitbz07plXHDhpCFmpC+55dkrXL
	 AAlb+7SJ4FWUzlQUeG9guS2lLI8kAVTgYZ1A9SlFBnXQ33CTB1poOJN8mujR6U2fqow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619024;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Bm-Milter-Handled:
	 X-Bm-Transport-Timestamp;
	bh=hRh+Ct7nFS4KxrPLxdiO8grHaCG9qFyvg94AZZeSRdY=;
	b=uo1BBsoFwbb7dhqp1JpSyBKFgubV8xEjdjcysCaoq0gQMjwTBkxKRqSCewu8tSoG6un1
	 UIVkeBIdCGE1JqKj2q80vyxAqGtebY0x1DLnSSw1oOslRpsxyk6G746PzBTRawG1S4tGu
	 45v4D/YJ+KtEL8MAc5NIHZKMCZiU/nmZW/APl7dJt5jVwuCzqDHb584U4Ab7bBfqF1bIB
	 8l3/O7V44xDOVxRVmO5Wy8EeHpaVlJIfqUymvEFyCkozq5UkU1AL7uu2FmhEXSFApCDde
	 p6h9IrpYFBhqyf+3K8zuG9si6gDpT5T3dS6hibGsh0fR1NCYEISEwaLDNR/2huzAGrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA555606A339
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA555606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5677543DCA;
	Mon, 02 Nov 2026 12:30:15 +0100 (CET)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dmytro.laktyushkin@amd.com,
	dillon.varone@amd.com,
	roman.li@amd.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Don't warn about links without an HPD GPIO
Date: Mon,  2 Nov 2026 12:29:43 +0100
Message-ID: <20261102113002.3408350-1-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
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
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793619014499

Since commit def3488eb0fd ("drm/amd/display: refactor HPD to increase
flexibility"), the link encoder programs the HPD filter, and
dce110_program_hpd_filter() and dcn10_program_hpd_filter() hit ASSERT(0)
if the encoder has no HPD GPIO. That is the case if link_get_hpd_gpio()
finds no usable HPD info for the connector in the VBIOS, where
program_hpd_filter() used to return early without a warning.

This logs a warning with a stack trace on every boot of some systems,
for example with Ryzen 7 PRO 4750G APUs on ASRock Rack X570D4U and
X470D4U2-2T boards:

  WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/dio/dcn10/dcn10_link_encoder.c:1514 at dcn10_program_hpd_filter+0x39/0x90 [amdgpu], CPU#7: (udev-worker)/836
  Call Trace:
   program_hpd_filter+0x5d/0xb0 [amdgpu]
   construct_phy+0x96f/0xe60 [amdgpu]
   link_create+0x1f0/0x240 [amdgpu]
   create_links+0x164/0x4f0 [amdgpu]
   dc_create+0x3ba/0x720 [amdgpu]
   amdgpu_dm_init+0x2c9/0x420 [amdgpu]

Return false without asserting if there is no HPD GPIO, as before, and
keep the assertion for failing to lock the pin.

Fixes: def3488eb0fd ("drm/amd/display: refactor HPD to increase flexibility")
Link: https://forum.proxmox.com/threads/kernel-7-0-14-24-and-7-0-14-25-bug-in-amdgpu.187181/
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c        | 5 ++++-
 .../gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index c6a20378121b..0c1fcfd088ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1841,8 +1841,11 @@ bool dce110_get_hpd_state(struct link_encoder *enc)
 
 bool dce110_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms)
 {
+	if (!enc->hpd_gpio)
+		return false;
+
 	/* Setup HPD filtering */
-	if (enc->hpd_gpio && dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
+	if (dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
 		struct gpio_hpd_config config;
 
 		config.delay_on_connect = delay_on_connect_in_ms;
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index 32e12d894e31..ddb40e6507b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -1506,8 +1506,11 @@ bool dcn10_get_hpd_state(struct link_encoder *enc)
 
 bool dcn10_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms)
 {
+	if (!enc->hpd_gpio)
+		return false;
+
 	/* Setup HPD filtering */
-	if (enc->hpd_gpio && dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
+	if (dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
 		struct gpio_hpd_config config;
 
 		config.delay_on_connect = delay_on_connect_in_ms;
-- 
2.47.3


