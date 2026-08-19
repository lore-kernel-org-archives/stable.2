Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726635836E
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125714; cv=none; b=TkgcYOWfSqXSYJunA+eTn8H21WtPLRcoiWMZ/nlXPpuYwmjCWQP3f+2Nx8+2a1gdbfowBGC3qTXOYAcugjJ1T9Bnhakc1J6usiIBDwcwyl9j9h6Jj6qx1cc3z4fo34iRD4z7IxCsaWzJO8BpLPLuO4TdJmlSrJw3U6KtZN7BoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125714; c=relaxed/simple;
	bh=0OZXjGHKlQU0SAckmvdPuI4NiFdLlwYyhBllNqF+Dx0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=FVg6rl1SIbl4ES5M2oSSS1JVWZybzQxw10HRBUNISOaC5+XG2PGwfw2z7Ef2DliPATr0RwtG7PEgCjTNRMxwN6M1LjR5KocY3ejClpFEGhkMouT2+aFOoFJvfbUlGmE+mE6rdBax3eoT082pHjRtnJHCQL9iRnEaXMmU49MQJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iry/VUqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iry/VUqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2C91F000E9;
	Wed, 19 Aug 2026 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125712;
	bh=VDtTJNgNQGQfs9yNkL1WqjqW5oVSM1XCWBn+RK3zRyE=;
	h=Subject:To:From:Date;
	b=iry/VUqgUd7XSEKBWlR+esuRo+/ErXBxIAuGtaRaVlTLqsLjlNvaqQDeEdDXtj1Cb
	 tPtC91YVKUu5lFrlRmXTNdFUBGHpIGhDmaP72KsiJz+HX4ef8bhFSL8aMhK6AmhpMy
	 ezzw/56hKSxAJ9WmKfCdxGjyk4NTcuW/PWgpJwVI=
Subject: patch "iio: adc: adi-axi-adc: add data size support for AD408X backend" added to char-misc-next
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,dlechner@baylibre.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:40 +0200
Message-ID: <2026081940-finale-isolated-7bd2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: adi-axi-adc: add data size support for AD408X backend

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 60f6f7fd5f89c7f55991c5dc59f3ccc74cd6efd7 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Mon, 13 Jul 2026 11:40:42 +0300
Subject: iio: adc: adi-axi-adc: add data size support for AD408X backend

The AD408X AXI core can pack the sample data on the bus using different
word widths. Expose this through the data_size_set backend operation so
that frontends can program the packet format field (bits 3:2 of the
CNTRL_3 register) according to the ADC resolution: 20-bit, 16-bit and
14-bit map to packet format values 0, 1 and 2 respectively.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/adi-axi-adc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index ced0a2321ecf..aac6f4a0705e 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -54,6 +54,10 @@
 #define   AXI_AD485X_PACKET_FORMAT_24BIT	0x1
 #define   AXI_AD485X_PACKET_FORMAT_32BIT	0x2
 #define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
+#define   AXI_AD408X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(3, 2)
+#define   AXI_AD408X_PACKET_FORMAT_20BIT	0x0
+#define   AXI_AD408X_PACKET_FORMAT_16BIT	0x1
+#define   AXI_AD408X_PACKET_FORMAT_14BIT	0x2
 
 #define ADI_AXI_ADC_REG_SYNC_STATUS		0x0068
 #define   ADI_AXI_ADC_SYNC_STATUS_ADC_SYNC_MSK	BIT(0)
@@ -437,6 +441,31 @@ static int axi_adc_ad408x_filter_type_set(struct iio_backend *back,
 				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
 }
 
+static int axi_adc_ad408x_data_size_set(struct iio_backend *back,
+					unsigned int size)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int val;
+
+	switch (size) {
+	case 20:
+		val = AXI_AD408X_PACKET_FORMAT_20BIT;
+		break;
+	case 16:
+		val = AXI_AD408X_PACKET_FORMAT_16BIT;
+		break;
+	case 14:
+		val = AXI_AD408X_PACKET_FORMAT_14BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				  AXI_AD408X_CNTRL_3_PACKET_FORMAT_MSK,
+				  FIELD_PREP(AXI_AD408X_CNTRL_3_PACKET_FORMAT_MSK, val));
+}
+
 static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
 					       u32 timeout_us)
 {
@@ -660,6 +689,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.free_buffer = axi_adc_free_buffer,
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
+	.data_size_set = axi_adc_ad408x_data_size_set,
 	.interface_data_align = axi_adc_ad408x_interface_data_align,
 	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
-- 
2.55.0


