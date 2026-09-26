Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCF374A19
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790402109; cv=none; b=V8uQVTVV+nMbNRNoubxpp0JWI9eFr0zR3bkONfWkD+brtZorQ4KeOrGpGxgYK51v6IYucNI1eR2Ck4Feg/mdAbw0uchCl9GBUTmr8cmzBByQeKmrdpjzCzCMDvEzErLdPdwafHeN+2Ae1N7DDkdpFUQJ5qh+ZIIfrAIe+8GaayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790402109; c=relaxed/simple;
	bh=3WHZje11yMZBZBXyTJlYcEDav1jBX7oSpKCSUN+cI5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQRsy9GAVcbYp6VxtnUv8xbmRcSeHxQx8u8ueugizzPJm9HLOxk9wINUVmiSOrx9vnZfgGAEusomz3ApgMs1hzw8gaT5gWiwwGQ1byapVClHAetxwzRelzQODpFkHiOZDZp/h3VEzRacwU84Me9AWXndkG8GQGaPcdg+eavGoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHfT+KiX; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHfT+KiX"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e211a0so839739b3a.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 22:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790402104; x=1791006904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X/jLk3hOfvplWvnh8rdzJHMk4Xuu5RA6BKKGh8ixgRc=;
        b=HHfT+KiX1nZdmG1IoZJN3DFiOb7T6TY5o3deob0OFyOLlqWgTObMGxLK0kClm64k7m
         lP0LK2LJkWPtLbGoKV/kiPF0UiyGdHSktqqrsMp+5IDDx7I51qkhK3CcljAj6BJpDAPX
         vH3dzoTW11H/hfCYnwhSwPnt3A/2pScycJOkbmC+MwyvM9Wqpn1+6aujfHWDeVRSwjPE
         AsuutkrKosgeh6v3l6PKik1pEj5UuzQOxmBFS4E6LOuAZWuyxiPkrqwble7uQb2PFL5l
         d8ctnnx2PhWJIRhDmhxsbEI/TknS9cuzL7AlLfzc7aIJul8IY9ukJmovZTeuHkqoD2N/
         bv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790402104; x=1791006904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X/jLk3hOfvplWvnh8rdzJHMk4Xuu5RA6BKKGh8ixgRc=;
        b=PsigqjvPGP6wSWF1hOXkJ6AUUGNS5O2ZNbpsYotT+HBEj0mvRuQG4+A4aHsY4tuu4u
         JetMlMIsZ/Lstx3L//6tl7Fduy1ZTh9Lf3RJfMVrsEqQcPPZC6Hdx6Hob0EJuDfFiSSK
         y7IWm2gTK+qqYtehn7rQkF0oWN0CFmvR059qsytXLbpG6VcKdbQN8n03ca1NlqwhWTjE
         vo1MKDqKXyDHwCocR7Cfya5OS+qCZtWZDd3H4sXp3mt2OLz+JhCLA3DYfmcwXavtoox5
         8Em9xFGCysUWLn4JRN3Fq8tA2zdl4bMi8juRX20us3TBGglWbAEixwTsB08YZTwPLUT4
         8xDw==
X-Forwarded-Encrypted: i=1; AKwUvBwQmhrZ2SjAN7DWVGcHvgJ3VF1QaGYR2W3b/0LhIDswdJEyPmBmSHB2RnlKGm1BTjyQyvAzekM=@vger.kernel.org
X-Gm-Message-State: AFuF++lLfJOUj1algRGijnwgiWGqxv8R5eEvPJLlQBocfh5aUckinGdB
	s98hk0QqP+AYxpZRFhcz6dG+DA9VIDAOKubTGPe7bn8MPIqSSbEsuy8v
X-Gm-Gg: AYBFou2JUVMjRMvdEZ3jiWYpiiuwoNxLt+nCmQNGlGw3BLh7fShKsAbmqmwcw3WFtob
	BYfx3TafbhCIlSjGPa1D7nP1Hx+ekLLgNreBiBi4GqMPlkkMmd9JDQuDn6un0M1/WDhMoNKZUkT
	+BfvAPMtZ2caFj5UPzhkk/JHyzY2sfIfxem5FWIGK5qm9jOz2FNsjOJ9OxB4EsoqTEYRucrBQfE
	QqTx9j0wF91EmbTpGhPQQvuLtDJya7DgynmvAQvkCld4oDnhGShSY+uNbDlHomANtOjpS/tHLkm
	dy8WxCGdu7Fl0H9F9wQXbcPip65Vy8nrmG4XxHiGfbyyiFhtd9SmZ3Kww38v8I05wP4oKYJrXes
	wm/7JsMenRRJqLR81NbSLwnmpT2uKLWrchThgSkHb2tP57Y11cjvHiaFr2Xnpzm4YiUjmF/pzbE
	RFY0ARp3iAvUHOR1JPCq/NOUUE/L4f0kEDlIgh3GaV/o1Vb/YhlWDxtyAQF/mOjjMV5d8EDGNS3
	/ZyMSFVZhTVDl1kQ5b8B1xL8igOs5I1xlDP2x/fP72c8rL9qDUaB3h/G3Jb8nCerex8uRL8Bext
	6uUmFdEmIv/zJ9A76+4rCf2BuG0g0sLFct1f5sv1xlUjlb7B
X-Received: by 2002:a05:6a00:a203:b0:878:3538:8f7e with SMTP id d2e1a72fcca58-87e9f82210amr5561877b3a.44.1790402104209;
        Fri, 25 Sep 2026 22:55:04 -0700 (PDT)
Received: from dell-pro-max-tower-t2.cse.unsw.EDU.AU (pag-t2-pc.cse.unsw.EDU.AU. [129.94.173.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feac93380sm1964103b3a.33.2026.09.25.22.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 22:55:03 -0700 (PDT)
From: Weigang He <geoffreyhe2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Sat, 26 Sep 2026 15:54:56 +1000
Message-ID: <20260926055456.3289189-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
channel specs and lets ams_init_module() fill them for the AMS node and
each of its children, without telling it how much room is left.

For the PL-SYSMON node, ams_get_ext_chan() appends one channel per
"channel@N" child after the 10 fixed PL channels. The binding allows
reg values 20..50, so a PL node can have up to 31 such children, i.e.
up to 41 PL channels, while only 31 are budgeted for it. Together with
the 13 PS and 7 AMS control channels, this writes past the end of the
buffer. Since the modules are filled in device tree order, the fixed
channel blocks copied after the PL node can overflow as well.

ams_get_ext_chan() also only checks the upper bound of reg. ext_chan is
unsigned, so a reg below 20 makes it wrap and ams_pl_channels[] is read
far out of bounds.

Pass the remaining capacity down to ams_init_module() and
ams_get_ext_chan() and fail with -EINVAL when a module does not fit,
instead of writing past the buffer. Also reject reg values below 20, as
the binding requires.

Found by static analysis tool CodeQL.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM codeql
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---

Notes:
    Compile-tested only (ARCH=arm64 allmodconfig, W=1). Not tested on
    hardware, and there is no reproducer.
    
    The CodeQL query behind this report was synthesized with LLM assistance,
    and the fix and changelog were drafted with LLM assistance; I have
    reviewed them.

 drivers/iio/adc/xilinx-ams.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 158e6133abf50..373a9e799ee63 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1142,7 +1142,8 @@ static const struct iio_chan_spec ams_ctrl_channels[] = {
 };
 
 static int ams_get_ext_chan(struct fwnode_handle *chan_node,
-			    struct iio_chan_spec *channels, int num_channels)
+			    struct iio_chan_spec *channels, int num_channels,
+			    int max_channels)
 {
 	struct iio_chan_spec *chan;
 	struct fwnode_handle *child;
@@ -1151,9 +1152,15 @@ static int ams_get_ext_chan(struct fwnode_handle *chan_node,
 
 	fwnode_for_each_child_node(chan_node, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
+		if (ret || reg < 30 - AMS_PL_MAX_FIXED_CHANNEL ||
+		    reg > AMS_PL_MAX_EXT_CHANNEL + 30)
 			continue;
 
+		if (num_channels >= max_channels) {
+			fwnode_handle_put(child);
+			return -EINVAL;
+		}
+
 		chan = &channels[num_channels];
 		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
 		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
@@ -1183,7 +1190,7 @@ static void ams_iounmap_pl(void *data)
 
 static int ams_init_module(struct iio_dev *indio_dev,
 			   struct fwnode_handle *fwnode,
-			   struct iio_chan_spec *channels)
+			   struct iio_chan_spec *channels, int max_channels)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct ams *ams = iio_priv(indio_dev);
@@ -1191,6 +1198,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 	int ret;
 
 	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
+		if (max_channels < ARRAY_SIZE(ams_ps_channels))
+			return -EINVAL;
+
 		ams->ps_base = fwnode_iomap(fwnode, 0);
 		if (!ams->ps_base)
 			return -ENXIO;
@@ -1202,6 +1212,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
 		num_channels = ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
+		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
+			return -EINVAL;
+
 		ams->pl_base = fwnode_iomap(fwnode, 0);
 		if (!ams->pl_base)
 			return -ENXIO;
@@ -1214,8 +1227,11 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		memcpy(channels, ams_pl_channels, AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
 		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
 		num_channels = ams_get_ext_chan(fwnode, channels,
-						num_channels);
+						num_channels, max_channels);
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
+		if (max_channels < ARRAY_SIZE(ams_ctrl_channels))
+			return -EINVAL;
+
 		/* add AMS channels to iio device channels */
 		memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
 		num_channels += ARRAY_SIZE(ams_ctrl_channels);
@@ -1245,7 +1261,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	if (fwnode_device_is_available(fwnode)) {
-		ret = ams_init_module(indio_dev, fwnode, ams_channels);
+		ret = ams_init_module(indio_dev, fwnode, ams_channels, ams_size);
 		if (ret < 0)
 			return ret;
 
@@ -1253,7 +1269,8 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	}
 
 	device_for_each_child_node_scoped(dev, child) {
-		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
+		ret = ams_init_module(indio_dev, child, ams_channels + num_channels,
+				      ams_size - num_channels);
 		if (ret < 0)
 			return ret;
 

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.43.0

