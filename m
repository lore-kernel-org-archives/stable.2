Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B73B635A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718610; cv=none; b=GbnYWJVH+GseEJX3Gls66l0ednxL4hWYO4wC0Bf1kWLvPjvYFd83bGA7JQWnNcjsL4zQiu801sxXrJuqOm6G5yUYxpYVOti4CfIH3vT8jeZxkosjvjyGWAzCMeE7qYZoz/9dN1PSWUHOcWCMC8ujg6Y4QrflrBJ2xK1XMp0FnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718610; c=relaxed/simple;
	bh=AcfVmJkqR7bn7li+332O5qBBSAUO/bk1Bc4usi+5dis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmCFOBMB4rtxMBIvQzWeG+o+rI/YDCBemxvx1CUizHTbXKUqrWJzRCkSDij8txtRqnTxWBmgfRZjRkygdwJljDGrWDrQQIY6Z6B77G0ve3FfUNfnCc+aVILR7r8EY7iFGY4yQnBhkAybXrg5pULtsx3nAXzUWUq+L/GanE2oCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiqIuxbe; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiqIuxbe"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15f6d667bcso177093766b.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718607; x=1784323407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQKLAy+q4WVq9Y37Ln7ncK+4sykkn+Pf4c/5Lgs8Ca8=;
        b=jiqIuxbeT4L5eptOQ665YH+n4GrvpqwTY2oNkLjUmoIETEOLjgWTaovOX22Rxu+KG7
         6nKGD0zCQ94VWL7hTDIa8SrjBOCraae7krjMthM5FJvcRk17myuT2MXwKNfc9Pb9moy4
         /xmCDIbCnp8N5+T1ZCFUH/bvLM1v9heFsZWqZxuEsFp9JG38Ta1ZRNMPvbJVPI5Qn5Bz
         aqJvbqeynhujN5kCREF4gW4E9q2XMfI20feOZDt9kSGFSWavegFUA1BvtFSdHGkWgnct
         O18OeRcx0aze4aMd8AXxGtoGNNL6xinuHTp73RkllvsRDROVpvYMgWEZwMFescOvAHMX
         fctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718607; x=1784323407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQKLAy+q4WVq9Y37Ln7ncK+4sykkn+Pf4c/5Lgs8Ca8=;
        b=rc5rtdJwt8/j/xx03XZpizp5G74YfnFQBuFky565pAO0Qzp1yqBQGPvVHEBiY9vsXs
         j1HkY6No1k39j9falDJQeJJW7G6OsilJf8e2zCLweMDxhiBsI3y2ZLpMz/e9oRm9ZRbR
         pCXhslD8O+0fUzI7pFZY2nxE3NUnLi8bIS102lIdrEkiHyfljtk5k7E465p5C7DsjPTS
         r1QUKKjHXo0a/GMkU+f4ZOpBgfpA6ZLVjlrJORlP4GO1GjRKMgpOnglav5RSRRX22fJj
         bP/Bhu0SzhzELmWa4cMQiKXjukAcTpglBGrigJthLqeLQ4yw+dXbAQSkXLGdOVbS/OaZ
         Usjg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2x4TNY6/DfaM3j43YkmvnGH7kZ4Hp3eBHC9kRJX8FgcZoxd6/YEdnVUue22X3sECJOD6nMuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85/19syzX4dSWm1GbKXx4Nk7wI1OwzB0KWUNx5EYgRtOHeuG0
	mOO5xpXDD4WxBWtWhfxunAOEfJnyNZhak5cv4607exGmTIb7C6n4yd/3
X-Gm-Gg: AfdE7cmkJmOGOfmgwmyISUxrkjMqbzs+OhNvRc3NN/MffC2/PPEi4iR7YFeYa+sDMsV
	kSSln8akMPeR8OEK4mqlId89jWx0mraY+DSh/xoMPCHW95KGLgnk3UEffdG0qJK5vwiA4xtp4Cj
	vifU67fk9uzExu2Wbi6GVP++2/zyu9tjbuP7I5YfI5bTJ26Nr4GiQR1i5z04Ku6CH3LFGtRqKdj
	c6zZ4+ffp1q9b7tvKEr9fuTUgOxwMTHBbepV1ORs1F0RlS4dMITCbmWvPbuiNtSRrrR72LyJAz7
	tjPqoD+tk6Q7lL3IwRS6O4Lgm490m2+HA0zkwhvpiWZ60GqoEF4N3NSC2LjXiGsmBkRxi36KTaE
	c8aOpiHl/+O+rCYOSbTpjfxa8C71Mihf7YoLGt4Gla6tK9ZgYdzJq1pdhtZ26ISOcXXBsaC/hYy
	qU8x+ZjJE1rpOG18bVOmac+I05JheR2Q2Ni37CyR8mfm0CCWjhihkkmYT+zlY0vdc=
X-Received: by 2002:a17:907:3f0c:b0:c12:34ed:e100 with SMTP id a640c23a62f3a-c161f38b21bmr21774166b.62.1783718606434;
        Fri, 10 Jul 2026 14:23:26 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1602f5e9c5sm137784266b.21.2026.07.10.14.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:23:25 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: greybus: audio: bound topology parsing to the received buffer
Date: Sat, 11 Jul 2026 02:23:12 +0500
Message-ID: <20260710212312.117781-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Greybus audio topology parser trusts length and count fields taken
straight from the module's topology blob and never checks them against
the size of the buffer it actually allocated, leading to out-of-bounds
reads of the kernel heap.

gb_audio_gb_get_topology() reads a u16 size from the module, allocates a
buffer of that size, fetches the topology into it, and then discards the
size. gbaudio_tplg_parse_data() then walks that buffer using fields
stored inside it:

  - gbaudio_tplg_process_header() computes the control, widget and route
    block offsets by adding the wire-supplied __le32 size_dais,
    size_controls and size_widgets onto the buffer base with no bound, so
    a module that reports a small allocation size but large block sizes
    moves those offsets far past the end of the buffer before they are
    dereferenced.

  - gbaudio_tplg_process_kcontrols(), _process_widgets() and
    _process_routes() iterate num_controls / num_widgets / num_routes
    (also from the blob) and advance a pointer by a per-element size that
    includes the __le16 names_length of an enumerated control, again with
    no check that the element stays inside the buffer.

  - gb_generate_enum_strings() loops over an attacker-controlled __le32
    items count and, for each, scans for a NUL terminator with no end
    pointer, walking off the end of the buffer.

A malicious or malfunctioning module can therefore make the parser read
past the allocation. The wild block offsets are most likely to hit an
unmapped page and oops (denial of service); the byte-at-a-time enum scan
walks from a still-valid pointer and can copy adjacent heap bytes into
ALSA control name strings, which are readable by unprivileged local
users, so an information leak cannot be ruled out.

Thread the allocated topology size from gb_audio_gb_get_topology()
through to gbaudio_tplg_parse_data() and bound every walk against the end
of the buffer: verify the block offsets are ordered and within the
buffer (the "< previous" tests also catch a 32-bit unsigned wrap of the
running offset), check each control, widget and route lies fully inside
its block before use, and give gb_generate_enum_strings() an explicit
end pointer plus an items-versus-names_length sanity check.

Fixes: 6339d2322c47 ("greybus: audio: Add topology parser for GB codec")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/greybus/audio_codec.h    |   4 +-
 drivers/staging/greybus/audio_gb.c       |  13 ++-
 drivers/staging/greybus/audio_module.c   |   6 +-
 drivers/staging/greybus/audio_topology.c | 135 ++++++++++++++++++-----
 4 files changed, 120 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
index f3f7a7ec6be40..f9225cf52d843 100644
--- a/drivers/staging/greybus/audio_codec.h
+++ b/drivers/staging/greybus/audio_codec.h
@@ -167,7 +167,7 @@ struct gbaudio_module_info {
 };
 
 int gbaudio_tplg_parse_data(struct gbaudio_module_info *module,
-			    struct gb_audio_topology *tplg_data);
+			    struct gb_audio_topology *tplg_data, size_t size);
 void gbaudio_tplg_release(struct gbaudio_module_info *module);
 
 int gbaudio_module_update(struct gbaudio_codec_info *codec,
@@ -179,7 +179,7 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module);
 
 /* protocol related */
 int gb_audio_gb_get_topology(struct gb_connection *connection,
-			     struct gb_audio_topology **topology);
+			     struct gb_audio_topology **topology, size_t *size);
 int gb_audio_gb_get_control(struct gb_connection *connection,
 			    u8 control_id, u8 index,
 			    struct gb_audio_ctl_elem_value *value);
diff --git a/drivers/staging/greybus/audio_gb.c b/drivers/staging/greybus/audio_gb.c
index 9d8994fdb41a2..0811652bc417f 100644
--- a/drivers/staging/greybus/audio_gb.c
+++ b/drivers/staging/greybus/audio_gb.c
@@ -10,11 +10,11 @@
 
 /* TODO: Split into separate calls */
 int gb_audio_gb_get_topology(struct gb_connection *connection,
-			     struct gb_audio_topology **topology)
+			     struct gb_audio_topology **topology, size_t *size)
 {
 	struct gb_audio_get_topology_size_response size_resp;
 	struct gb_audio_topology *topo;
-	u16 size;
+	u16 tplg_size;
 	int ret;
 
 	ret = gb_operation_sync(connection, GB_AUDIO_TYPE_GET_TOPOLOGY_SIZE,
@@ -22,22 +22,23 @@ int gb_audio_gb_get_topology(struct gb_connection *connection,
 	if (ret)
 		return ret;
 
-	size = le16_to_cpu(size_resp.size);
-	if (size < sizeof(*topo))
+	tplg_size = le16_to_cpu(size_resp.size);
+	if (tplg_size < sizeof(*topo))
 		return -ENODATA;
 
-	topo = kzalloc(size, GFP_KERNEL);
+	topo = kzalloc(tplg_size, GFP_KERNEL);
 	if (!topo)
 		return -ENOMEM;
 
 	ret = gb_operation_sync(connection, GB_AUDIO_TYPE_GET_TOPOLOGY, NULL, 0,
-				topo, size);
+				topo, tplg_size);
 	if (ret) {
 		kfree(topo);
 		return ret;
 	}
 
 	*topology = topo;
+	*size = tplg_size;
 
 	return 0;
 }
diff --git a/drivers/staging/greybus/audio_module.c b/drivers/staging/greybus/audio_module.c
index 12c376c477b3c..9367ab6debdbe 100644
--- a/drivers/staging/greybus/audio_module.c
+++ b/drivers/staging/greybus/audio_module.c
@@ -240,6 +240,7 @@ static int gb_audio_probe(struct gb_bundle *bundle,
 	struct gbaudio_data_connection *dai, *_dai;
 	int ret, i;
 	struct gb_audio_topology *topology;
+	size_t tplg_size;
 
 	/* There should be at least one Management and one Data cport */
 	if (bundle->num_cports < 2)
@@ -308,14 +309,15 @@ static int gb_audio_probe(struct gb_bundle *bundle,
 	 * FIXME: malloc for topology happens via audio_gb driver
 	 * should be done within codec driver itself
 	 */
-	ret = gb_audio_gb_get_topology(gbmodule->mgmt_connection, &topology);
+	ret = gb_audio_gb_get_topology(gbmodule->mgmt_connection, &topology,
+				       &tplg_size);
 	if (ret) {
 		dev_err(dev, "%d:Error while fetching topology\n", ret);
 		goto disable_connection;
 	}
 
 	/* process topology data */
-	ret = gbaudio_tplg_parse_data(gbmodule, topology);
+	ret = gbaudio_tplg_parse_data(gbmodule, topology, tplg_size);
 	if (ret) {
 		dev_err(dev, "%d:Error while parsing topology data\n",
 			ret);
diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 76146f91cddcc..4095e6c741efa 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -134,21 +134,35 @@ static const char **gb_generate_enum_strings(struct gbaudio_module_info *gb,
 					     struct gb_audio_enumerated *gbenum)
 {
 	const char **strings;
-	int i;
 	unsigned int items;
-	__u8 *data;
+	u16 names_length;
+	const __u8 *data;
+	const __u8 *end;
+	int i;
 
 	items = le32_to_cpu(gbenum->items);
+	names_length = le16_to_cpu(gbenum->names_length);
+	data = gbenum->names;
+	end = data + names_length;
+
+	/*
+	 * Each enumerated value is a NUL-terminated string occupying at least
+	 * one byte, so a valid names block cannot hold more items than it has
+	 * bytes. This also bounds the devm_kcalloc() request below.
+	 */
+	if (items > names_length)
+		return NULL;
+
 	strings = devm_kcalloc(gb->dev, items, sizeof(char *), GFP_KERNEL);
 	if (!strings)
 		return NULL;
 
-	data = gbenum->names;
-
 	for (i = 0; i < items; i++) {
 		strings[i] = (const char *)data;
-		while (*data != '\0')
+		while (data < end && *data != '\0')
 			data++;
+		if (data == end)
+			return NULL;
 		data++;
 	}
 
@@ -1009,9 +1023,40 @@ static const struct snd_soc_dapm_widget gbaudio_widgets[] = {
 					SND_SOC_DAPM_POST_PMD),
 };
 
+/*
+ * Return the on-wire size of the topology control at @curr, in bytes, after
+ * verifying that the whole control - including its variable-length enum names
+ * block - lies within [@curr, @end). Returns a negative errno on overrun.
+ */
+static int gbaudio_control_size(struct gb_audio_control *curr, const u8 *end)
+{
+	size_t csize;
+
+	/*
+	 * Enough of the control must be present to read its id and name and
+	 * the fixed part of the enumerated descriptor (items, names_length).
+	 */
+	csize = offsetof(struct gb_audio_control, info);
+	csize += offsetof(struct gb_audio_ctl_elem_info, value);
+	csize += offsetof(struct gb_audio_enumerated, names);
+	if ((u8 *)curr + csize > end)
+		return -EINVAL;
+
+	if (curr->info.type == GB_AUDIO_CTL_ELEM_TYPE_ENUMERATED)
+		csize += le16_to_cpu(curr->info.value.enumerated.names_length);
+	else
+		csize = sizeof(struct gb_audio_control);
+
+	if ((u8 *)curr + csize > end)
+		return -EINVAL;
+
+	return csize;
+}
+
 static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 				      struct snd_soc_dapm_widget *dw,
-				      struct gb_audio_widget *w, int *w_size)
+				      struct gb_audio_widget *w, int *w_size,
+				      const u8 *end)
 {
 	int i, ret, csize;
 	struct snd_kcontrol_new *widget_kctls;
@@ -1040,6 +1085,11 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 	/* create relevant kcontrols */
 	curr = w->ctl;
 	for (i = 0; i < w->ncontrols; i++) {
+		ret = gbaudio_control_size(curr, end);
+		if (ret < 0)
+			goto error;
+		csize = ret;
+
 		ret = gbaudio_tplg_create_wcontrol(module, &widget_kctls[i],
 						   curr);
 		if (ret) {
@@ -1063,10 +1113,6 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 			struct gb_audio_enumerated *gbenum =
 				&curr->info.value.enumerated;
 
-			csize = offsetof(struct gb_audio_control, info);
-			csize += offsetof(struct gb_audio_ctl_elem_info, value);
-			csize += offsetof(struct gb_audio_enumerated, names);
-			csize += le16_to_cpu(gbenum->names_length);
 			control->texts = (const char * const *)
 				gb_generate_enum_strings(module, gbenum);
 			if (!control->texts) {
@@ -1074,8 +1120,6 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 				goto error;
 			}
 			control->items = le32_to_cpu(gbenum->items);
-		} else {
-			csize = sizeof(struct gb_audio_control);
 		}
 
 		*w_size += csize;
@@ -1136,7 +1180,8 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 }
 
 static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
-					  struct gb_audio_control *controls)
+					  struct gb_audio_control *controls,
+					  const u8 *end)
 {
 	int i, csize, ret;
 	struct snd_kcontrol_new *dapm_kctls;
@@ -1152,6 +1197,11 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 
 	curr = controls;
 	for (i = 0; i < module->num_controls; i++) {
+		ret = gbaudio_control_size(curr, end);
+		if (ret < 0)
+			goto error;
+		csize = ret;
+
 		ret = gbaudio_tplg_create_kcontrol(module, &dapm_kctls[i],
 						   curr);
 		if (ret) {
@@ -1176,10 +1226,6 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 			struct gb_audio_enumerated *gbenum =
 				&curr->info.value.enumerated;
 
-			csize = offsetof(struct gb_audio_control, info);
-			csize += offsetof(struct gb_audio_ctl_elem_info, value);
-			csize += offsetof(struct gb_audio_enumerated, names);
-			csize += le16_to_cpu(gbenum->names_length);
 			control->texts = (const char * const *)
 				gb_generate_enum_strings(module, gbenum);
 			if (!control->texts) {
@@ -1187,8 +1233,6 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 				goto error;
 			}
 			control->items = le32_to_cpu(gbenum->items);
-		} else {
-			csize = sizeof(struct gb_audio_control);
 		}
 
 		list_add(&control->list, &module->ctl_list);
@@ -1210,7 +1254,8 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 }
 
 static int gbaudio_tplg_process_widgets(struct gbaudio_module_info *module,
-					struct gb_audio_widget *widgets)
+					struct gb_audio_widget *widgets,
+					const u8 *end)
 {
 	int i, ret, w_size;
 	struct snd_soc_dapm_widget *dapm_widgets;
@@ -1225,8 +1270,13 @@ static int gbaudio_tplg_process_widgets(struct gbaudio_module_info *module,
 
 	curr = widgets;
 	for (i = 0; i < module->num_dapm_widgets; i++) {
+		/* The fixed part of the widget must lie within the buffer. */
+		if ((u8 *)curr + sizeof(struct gb_audio_widget) > end) {
+			ret = -EINVAL;
+			goto error;
+		}
 		ret = gbaudio_tplg_create_widget(module, &dapm_widgets[i],
-						 curr, &w_size);
+						 curr, &w_size, end);
 		if (ret) {
 			dev_err(module->dev, "%s:%d type not supported\n",
 				curr->name, curr->type);
@@ -1259,7 +1309,8 @@ static int gbaudio_tplg_process_widgets(struct gbaudio_module_info *module,
 }
 
 static int gbaudio_tplg_process_routes(struct gbaudio_module_info *module,
-				       struct gb_audio_route *routes)
+				       struct gb_audio_route *routes,
+				       const u8 *end)
 {
 	int i, ret;
 	struct snd_soc_dapm_route *dapm_routes;
@@ -1275,6 +1326,10 @@ static int gbaudio_tplg_process_routes(struct gbaudio_module_info *module,
 	curr = routes;
 
 	for (i = 0; i < module->num_dapm_routes; i++) {
+		if ((u8 *)curr + sizeof(struct gb_audio_route) > end) {
+			ret = -EINVAL;
+			goto error;
+		}
 		dapm_routes->sink =
 			gbaudio_map_widgetid(module, curr->destination_id);
 		if (!dapm_routes->sink) {
@@ -1320,8 +1375,12 @@ static int gbaudio_tplg_process_routes(struct gbaudio_module_info *module,
 }
 
 static int gbaudio_tplg_process_header(struct gbaudio_module_info *module,
-				       struct gb_audio_topology *tplg_data)
+				       struct gb_audio_topology *tplg_data,
+				       size_t size)
 {
+	unsigned long tplg_start = (unsigned long)tplg_data;
+	unsigned long tplg_end = tplg_start + size;
+
 	/* fetch no. of kcontrols, widgets & routes */
 	module->num_controls = tplg_data->num_controls;
 	module->num_dapm_widgets = tplg_data->num_widgets;
@@ -1336,6 +1395,20 @@ static int gbaudio_tplg_process_header(struct gbaudio_module_info *module,
 	module->route_offset = module->widget_offset +
 					le32_to_cpu(tplg_data->size_widgets);
 
+	/*
+	 * The DAI, control, widget and route blocks are concatenated in that
+	 * order after the header. Their sizes come straight off the wire and
+	 * are attacker-controlled, so verify the resulting block boundaries
+	 * are ordered and stay within the allocated topology buffer. The
+	 * "< previous" tests also reject an unsigned wrap of the running
+	 * offset on 32-bit builds.
+	 */
+	if (module->control_offset < module->dai_offset ||
+	    module->widget_offset < module->control_offset ||
+	    module->route_offset < module->widget_offset ||
+	    module->route_offset > tplg_end)
+		return -EINVAL;
+
 	dev_dbg(module->dev, "DAI offset is 0x%lx\n", module->dai_offset);
 	dev_dbg(module->dev, "control offset is %lx\n",
 		module->control_offset);
@@ -1346,7 +1419,7 @@ static int gbaudio_tplg_process_header(struct gbaudio_module_info *module,
 }
 
 int gbaudio_tplg_parse_data(struct gbaudio_module_info *module,
-			    struct gb_audio_topology *tplg_data)
+			    struct gb_audio_topology *tplg_data, size_t size)
 {
 	int ret;
 	struct gb_audio_control *controls;
@@ -1357,7 +1430,10 @@ int gbaudio_tplg_parse_data(struct gbaudio_module_info *module,
 	if (!tplg_data)
 		return -EINVAL;
 
-	ret = gbaudio_tplg_process_header(module, tplg_data);
+	if (size < sizeof(*tplg_data))
+		return -EINVAL;
+
+	ret = gbaudio_tplg_process_header(module, tplg_data, size);
 	if (ret) {
 		dev_err(module->dev, "%d: Error in parsing topology header\n",
 			ret);
@@ -1366,7 +1442,8 @@ int gbaudio_tplg_parse_data(struct gbaudio_module_info *module,
 
 	/* process control */
 	controls = (struct gb_audio_control *)module->control_offset;
-	ret = gbaudio_tplg_process_kcontrols(module, controls);
+	ret = gbaudio_tplg_process_kcontrols(module, controls,
+					     (const u8 *)module->widget_offset);
 	if (ret) {
 		dev_err(module->dev,
 			"%d: Error in parsing controls data\n", ret);
@@ -1376,7 +1453,8 @@ int gbaudio_tplg_parse_data(struct gbaudio_module_info *module,
 
 	/* process widgets */
 	widgets = (struct gb_audio_widget *)module->widget_offset;
-	ret = gbaudio_tplg_process_widgets(module, widgets);
+	ret = gbaudio_tplg_process_widgets(module, widgets,
+					   (const u8 *)module->route_offset);
 	if (ret) {
 		dev_err(module->dev,
 			"%d: Error in parsing widgets data\n", ret);
@@ -1386,7 +1464,8 @@ int gbaudio_tplg_parse_data(struct gbaudio_module_info *module,
 
 	/* process route */
 	routes = (struct gb_audio_route *)module->route_offset;
-	ret = gbaudio_tplg_process_routes(module, routes);
+	ret = gbaudio_tplg_process_routes(module, routes,
+					  (const u8 *)tplg_data + size);
 	if (ret) {
 		dev_err(module->dev,
 			"%d: Error in parsing routes data\n", ret);
-- 
2.55.0

