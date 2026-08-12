Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B73EF0A6;
	Wed, 12 Aug 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526005; cv=none; b=gLemmooQjUyhr8vZsm6WiBgoGYhPU6mAYj8dADX0a/9yxvCT2r/oZPWNlE7se5htHcucUj4oFdS6G4WyB2GyT39vlzc494mbnYXygRTCGyim6TVX0qQVpDhDIt9TZsLUHIfnwCWNdJRAW/Mg7JCHcvEET95PV4a+xG2NK1k7uIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526005; c=relaxed/simple;
	bh=trdM72TaO8FxGWYEmtkxgykpXZnkeUbqxIMyWd2aia0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ue4ZdxrG804qd1F/4IZhS9AnPKWEoILDwowsMjj7SIFFEUbnYEPXNxCdDlJeL4aPUuFDByUjcCUHC2PMxifwBfG+3tJFXXCmRAhGl+/XKKrzqMSK1lSSFd/I5JuXpyMRkDTsSUhECM+9XdPruXr38bwNs+v04LJw0tjebC9zfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlF3ezyM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlF3ezyM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22D6BC2BCB9;
	Wed, 12 Aug 2026 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786526005;
	bh=trdM72TaO8FxGWYEmtkxgykpXZnkeUbqxIMyWd2aia0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VlF3ezyMJBiMq0ZPWz61zv78L+luUs0wzuOKXnaaYaR7P7IlFS4TcUtbz/1ESLgD5
	 4cjf8DeUgIi4Oxp/kiGIuzUfT2g7XVYLJOXS8adscB3qgSbbufReKhL6i5S6PzPq/M
	 hqnPIeAm9RqSmS0P/gZS1OhAfDxqGJc6vhKG0ggWdH/4sszCTqJbRjAtnyHSg1RBIq
	 PofSpqIXI275l+r2NNyqvdGr0pHAesGE/XMyzQi6X9P3z34a537v9fOgv2HwERJhFY
	 eHXJRhdF8Ixd/kfqXvOQZMxSM2DFOIoILkFZwXgXad02xN/DTn1hacdg9IQBWzU2wC
	 8Ag7kqHtqbBBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F67C5AD5A;
	Wed, 12 Aug 2026 09:13:24 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Wed, 12 Aug 2026 17:13:14 +0800
Subject: [PATCH] coresight: configfs: restrict address parameter value to
 root
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-coresight-fixes-v1-1-53fbf4e73241@outlook.com>
X-B4-Tracking: v=1; b=H4sIACk5fGoC/x3LMQqAMAxA0atIZgNtBKleRRxEU5ullUREEO9uc
 Xx8/gPGKmwwNg8oX2JScoVvG1jTkndG2aqBHPUueMK1KJvs6cQoNxsOS3Rb7DofeoJ6Hcp/qNM
 0v+8H2phR9WEAAAA=
X-Change-ID: 20260812-coresight-fixes-9af0df331862
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Linu Cherian <lcherian@marvell.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5748;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=MKr5RocVkwYr4HeccYdicCmDi3naOR5Zqa/nWJAQBFo=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBpL4/tBSdVfP5UbbLuezl2n8lM3rb328qmf8oxta
 9ureM1e+HaUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARDh2MjJ8+8hzvvHh7ElM
 G264LZvI8lYupZVhte9vzxtOWkWvlrgqMjJ8Pq5i5d/7wW7rU58H6tO0bi++FTe/p3i9zKGexcs
 9K5r4AIi4S1U=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

The preloaded 'gen_etrig' ETMv4 feature declares its only parameter as
{ .name = "address", .value = (u64)panic }, so on a relocatable kernel
the stored value is the post-KASLR runtime address of panic().

cscfg_param_value_show() prints that value verbatim with "0x%llx", and
CONFIGFS_ATTR() gives the attribute mode 0644 while every enclosing
directory is 0755. Once configfs is mounted, any local user reading
cs-syscfg/features/gen_etrig/params/address/value can recover the kernel
text base; neither kptr_restrict nor a capability check applies on that
path, and the plain u64 print bypasses the pointer-formatting
protections. The parameter exists even without trace hardware, since
cscfg_init() calls cscfg_preload() unconditionally and
coresight-cfg-pstop.o is linked into the core coresight module.

Mark parameters that can hold a kernel address, and give those a
config_item_type whose 'value' attribute is 0600. Parameters holding
plain numbers, such as the strobing 'window' and 'period' counts, keep
the existing mode.

Fixes: 4b7e62627a38 ("coresight: config: Add preloaded configuration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 Documentation/trace/coresight/coresight-config.rst |  5 +++++
 drivers/hwtracing/coresight/coresight-cfg-pstop.c  |  1 +
 drivers/hwtracing/coresight/coresight-config.h     |  3 +++
 .../coresight/coresight-syscfg-configfs.c          | 26 ++++++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/Documentation/trace/coresight/coresight-config.rst b/Documentation/trace/coresight/coresight-config.rst
index 6d5ffa6f7347..8df054b2aa10 100644
--- a/Documentation/trace/coresight/coresight-config.rst
+++ b/Documentation/trace/coresight/coresight-config.rst
@@ -202,6 +202,11 @@ Move to the params directory to examine and adjust parameters::
     # cat value
     0x3a98
 
+Updating a parameter requires root. Reading one does not, unless the parameter
+can hold a kernel address, in which case its 'value' is readable by root only.
+The preloaded 'gen_etrig' feature is such a case: its
+``features/gen_etrig/params/address/value`` defaults to the address of panic().
+
 Parameters adjusted in this way are reflected in all device instances that have
 loaded the feature.
 
diff --git a/drivers/hwtracing/coresight/coresight-cfg-pstop.c b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
index c2bfbd07bfaf..116954ad28b0 100644
--- a/drivers/hwtracing/coresight/coresight-cfg-pstop.c
+++ b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
@@ -19,6 +19,7 @@ static struct cscfg_parameter_desc gen_etrig_params[] = {
 	{
 		.name = "address",
 		.value = (u64)panic,
+		.sensitive = true,
 	},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 90fd937d3bd8..ead91c76fa52 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -46,10 +46,13 @@
  *
  * @name:  Name of parameter.
  * @value: Initial or default value.
+ * @sensitive: Value may be a kernel address, so restrict reads of it to
+ *	       callers permitted to see kernel pointers.
  */
 struct cscfg_parameter_desc {
 	const char *name;
 	u64 value;
+	bool sensitive;
 };
 
 /**
diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 2b40e556be87..2d6028c84c5e 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -304,16 +304,40 @@ static ssize_t cscfg_param_value_store(struct config_item *item,
 }
 CONFIGFS_ATTR(cscfg_param_, value);
 
+/*
+ * A parameter marked sensitive can hold a kernel address, so its value gets
+ * the same attribute with the world-readable bits dropped. Writing already
+ * required root. Open coded rather than CONFIGFS_ATTR_PERM(), as that macro
+ * derives the show/store names from the prefix and would need forwarders.
+ */
+static struct configfs_attribute cscfg_param_attr_value_sensitive = {
+	.ca_name	= "value",
+	.ca_mode	= 0600,
+	.ca_owner	= THIS_MODULE,
+	.show		= cscfg_param_value_show,
+	.store		= cscfg_param_value_store,
+};
+
 static struct configfs_attribute *cscfg_param_view_attrs[] = {
 	&cscfg_param_attr_value,
 	NULL,
 };
 
+static struct configfs_attribute *cscfg_param_sensitive_view_attrs[] = {
+	&cscfg_param_attr_value_sensitive,
+	NULL,
+};
+
 static const struct config_item_type cscfg_param_view_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_attrs = cscfg_param_view_attrs,
 };
 
+static const struct config_item_type cscfg_param_sensitive_view_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = cscfg_param_sensitive_view_attrs,
+};
+
 /*
  * configfs has far less functionality provided to add attributes dynamically than sysfs,
  * and the show and store fns pass the enclosing config_item so the actual attribute cannot
@@ -335,6 +359,8 @@ static int cscfg_create_params_group_items(struct cscfg_feature_desc *feat_desc,
 		param_item->param_idx = i;
 		config_group_init_type_name(&param_item->group,
 					    feat_desc->params_desc[i].name,
+					    feat_desc->params_desc[i].sensitive ?
+					    &cscfg_param_sensitive_view_type :
 					    &cscfg_param_view_type);
 		configfs_add_default_group(&param_item->group, params_group);
 	}

---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260812-coresight-fixes-9af0df331862

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


