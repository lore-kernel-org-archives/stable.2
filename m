Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102366;
	b=OWPZfCbfKxN36ORqHsAEQcu4ZU+mw5aWG8UTrX6HRibVqhgdRWYX3Lqz5bIXr9DfVVJM
	 WDuC21nmvti+2ctkCtaucm6NG3KZV9VDe5r78M0Y5R/mdU/FYwNID0iH199Kzt/EgAdb6
	 EVCzgu/8eZ8k3iMOD4EcChUS50ahpLA1wrzewZUCpwaGokcSOy0tV6+j2dnwTOF2cmfTP
	 VxcMln4ow/FhCK/TgQbleXEdD0f+KX2FZHgtq8z+YEGJ3ExsxKzW5eBOjk8nCiZTPX4xd
	 YCwOz1dBVCH8JC7ICWaJpnDHv+CB52ZLYXrNpv373wAV0KsmSY/X/aVZwKJIX3Jk9pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lA1w/HPqgREMk3LSOcc2vVbyuDL7Ipujn9ZkHz8l3fg=;
	b=dXhZuhXleyTqM6HBfkDC1leuuUkkqnbXgh6OHsxbp5nAoqWgQKDjr15juMPkhzsyyaEp
	 fb9kc2s5x2031PlTi3TNmgFoaN7pYi1P4nb+gdcxpqNKx24gClqVIeXDfIFW+8/fS46Zm
	 o4M+Kq1vs+lZu63SQAdMFrqxBVr7dkYOu33qahIZD+DbWJcKsU3CIBaC58SGXZ+fTs513
	 IMoo8cZr+yRev58LyG9Brvp4QEpP4ZpU15anvKg1Aj/FowHpro0awT9HosE+hQSOyQ3YC
	 jWUt3z50X7fCK1Hqxkx/xfM8D0djOVQtM4OwTwemAix5o8op7TWN1B+C1MI4mvqjOgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rt8u9bvh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC5606A331;
	Thu, 19 Nov 2026 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rt8u9bvh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1751F000C4;
	Thu, 19 Nov 2026 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102366;
	bh=lA1w/HPqgREMk3LSOcc2vVbyuDL7Ipujn9ZkHz8l3fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rt8u9bvhI6ZNLtyKv1NVRnGij9j/cnmA+pzueBpBN96wrhMvmMZxJTgu6achGnd2q
	 POZKvWFVik0TsgbJBI9ElJ6zih2weNRUgbu5MZocy9laG0ALkXrB+ioaWJOKUtx/TF
	 zY1WrNGvLgeQlgXo8nBaXpyU86OLN3Lu1WWl4v0ozskiXZ5IevahQomR3wPYQKpuHz
	 bL9W+bzUbE/zIzhx/zJbUOoi3oHNajJLEJdDWlBhRYAD16d+pXnEh6zy1XQRx82GVG
	 5b7JD26nOfTS3RM1C7DzOvz9LHa8NZQNqXuDnsG+7ahEa+jhzX11rnHuUGSWJ8WQIz
	 1rWqfD1XIoLsg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bogdan Bolocan <bogdan.bolocan@microchip.com>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 06/10] iio: adc: pac1934: Fix custom attribute allocation and channel bounds
Date: Thu, 19 Nov 2026 15:30:39 +0000
Message-ID: <20261119153151.1397003-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119153151.1397003-1-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
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

pac1934_prep_custom_attributes() sizes the pac1934_custom_attr pointer
array using sizeof(*pac1934_group) instead of
sizeof(*pac1934_custom_attr) and adds 1 byte rather than one pointer
element for the terminating NULL entry.  When active_channels_count is
zero, only a single byte is allocated and iio_device_register_sysfs()
reads past the allocation when scanning the attribute list.

In addition, active_channels_count is counted over info->phys_channels,
whereas the population steps unconditionally inspect all four entries of
info->active_channels[], which can write past the end of the array on
1-, 2-, and 3-channel chip variants.

Allocate active_channels_count + 1 attribute pointers with
devm_kzalloc_objs() and bound the population loop by
info->phys_channels.

Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Closes: https://sashiko.dev/#/bug/linux-e7b7eab1-9ed4-4d4b-b9c7-889bf720aa5b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/adc/pac1934.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 1d7608e8246a..c3da0c519456 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1435,10 +1435,17 @@ static IIO_DEVICE_ATTR(in_shunt_resistor3, 0644,
 static IIO_DEVICE_ATTR(in_shunt_resistor4, 0644,
 		       pac1934_shunt_value_show, pac1934_shunt_value_store, 3);
 
+static struct attribute * const pac1934_shunt_attrs[] = {
+	PAC1934_DEV_ATTR(in_shunt_resistor1),
+	PAC1934_DEV_ATTR(in_shunt_resistor2),
+	PAC1934_DEV_ATTR(in_shunt_resistor3),
+	PAC1934_DEV_ATTR(in_shunt_resistor4),
+};
+
 static int pac1934_prep_custom_attributes(struct pac1934_chip_info *info,
 					  struct iio_dev *indio_dev)
 {
-	int i, active_channels_count = 0;
+	int i, j, active_channels_count = 0;
 	struct attribute **pac1934_custom_attr;
 	struct attribute_group *pac1934_group;
 	struct device *dev = &info->client->dev;
@@ -1451,26 +1458,16 @@ static int pac1934_prep_custom_attributes(struct pac1934_chip_info *info,
 	if (!pac1934_group)
 		return -ENOMEM;
 
-	pac1934_custom_attr = devm_kzalloc(dev,
-					   (PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
-					   active_channels_count)
-					   * sizeof(*pac1934_group) + 1,
-					   GFP_KERNEL);
+	pac1934_custom_attr = devm_kzalloc_objs(dev, *pac1934_custom_attr,
+						PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
+						active_channels_count + 1);
 	if (!pac1934_custom_attr)
 		return -ENOMEM;
 
-	i = 0;
-	if (info->active_channels[0])
-		pac1934_custom_attr[i++] = PAC1934_DEV_ATTR(in_shunt_resistor1);
-
-	if (info->active_channels[1])
-		pac1934_custom_attr[i++] = PAC1934_DEV_ATTR(in_shunt_resistor2);
-
-	if (info->active_channels[2])
-		pac1934_custom_attr[i++] = PAC1934_DEV_ATTR(in_shunt_resistor3);
-
-	if (info->active_channels[3])
-		pac1934_custom_attr[i] = PAC1934_DEV_ATTR(in_shunt_resistor4);
+	j = 0;
+	for (i = 0; i < info->phys_channels; i++)
+		if (info->active_channels[i])
+			pac1934_custom_attr[j++] = pac1934_shunt_attrs[i];
 
 	pac1934_group->attrs = pac1934_custom_attr;
 	info->iio_info.attrs = pac1934_group;
-- 
2.56.1.708.g77570a6a1d-goog

