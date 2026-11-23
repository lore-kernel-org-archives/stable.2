Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420320;
	b=KwnoW7zVbM9DFG3H4JATQHtuiO+ee6v6qu7VIAny8RI/p6eeG0MkXns5Md37Aris1LUu
	 xB3Bz8NsBKSaKhPEl38KOFC16ivJ+aErbiOVOLziUj1i0b5SoYD1tF2mm9MUpGX1ZwJ8e
	 rMfPw6ie6WZy3PxMD8KtQZXUMTZVLAaniXiBdjZcDd5VxmGDSqVo/M8hpXJnHJtP5cEd2
	 U14k45unD0ILrCrboeUtdof6RKazB4eDlZqutTd3oDsJUYSx5AoAUTdXbS/0Yd668jJfU
	 whoJHywmX5e74yR3GHa5AQGENSBJI+X9j7Y9a1zQM+APNQ2B092LRDRQhQbU+x1dNzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YRyfRtj39QvPj0FnuGJPdIFrD+6NLjA2bCiGMIOAbQE=;
	b=d5iZx6gac9cRJeOT/6IQQMnB159RYPty3f/JnO8v8v80Yzf6ljIaiypivxDJ8+rTS9UZ
	 vrWVeeUeokrhIcJ26KjXU2JtreEBOiHgk++oSVLjjvVPCUMUtP45LrHGj8eZEmz1/nOQA
	 XyiVSuB2DqUqNUD0Vpt8Oj14sSfsd1Z9PJWLEG3tgbEbnlJBd+CRF4JktM6de2IYRAyiA
	 uuia0JFOhbvkjPICfgKqZ2wGQ2U6hsRzKfqCF3KyakjhP6XK3Htf6CItwiv64IeV6TNW/
	 vNzDoXA6hbARL4f3YlFo68vJRwIxS0b5hPIQB/DcnzqKcH6SYR/0FqLoVBNBLeDnjKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDElAKwj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51E606A31E;
	Mon, 23 Nov 2026 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDElAKwj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820081F000E1;
	Mon, 23 Nov 2026 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420320;
	bh=YRyfRtj39QvPj0FnuGJPdIFrD+6NLjA2bCiGMIOAbQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDElAKwjNFR8RXQExLIBsG67NFyZfajMfMvSoN5OkoxS+7/bxK/AVJN4dph/SzLJ2
	 31Qtt7YOv6E91vPdb9xklVcueeFmCjw/2DNB4yubAVUMbhfZ1AbDOpR2i6M/zoaH5e
	 43OukL4H2M+brxL7OTxVniRJmCZEYdyt/xEqDLTzRrNRG9AIDKs9kJxNvhkmNDpP1O
	 OcNW/NtK7IWcZLeQJ2FVOY+/0WfvXAxf0GAqfAvW7S9Ffk86YChpxhZHFGlvH3wKlb
	 pVlFRH3UecFVWLwazw+lpw4KJWiNwV6eDQaZByenKHUnFRlNoO0UHPHMIRAjqP9UyN
	 r8XrfsiaLFh0Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bogdan Bolocan <bogdan.bolocan@microchip.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 4/7] iio: adc: pac1934: Fix custom attribute allocation and channel bounds
Date: Mon, 23 Nov 2026 07:50:30 +0000
Message-ID: <20261123075122.373060-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123075122.373060-1-lee@kernel.org>
References: <20261123075122.373060-1-lee@kernel.org>
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

v1 => v2:
 - Order local variables in reverse Christmas tree style (Andy,
   Jonathan)
 - Scope loop index j to the for-loop (Andy, Jonathan)

 drivers/iio/adc/pac1934.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 5e901ab25c8e..a307689c6814 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1435,13 +1435,20 @@ static IIO_DEVICE_ATTR(in_shunt_resistor3, 0644,
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
+	struct device *dev = &info->client->dev;
 	struct attribute **pac1934_custom_attr;
 	struct attribute_group *pac1934_group;
-	struct device *dev = &info->client->dev;
+	int i, active_channels_count = 0;
 
 	for (i = 0 ; i < info->phys_channels; i++)
 		if (info->active_channels[i])
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
 
 	i = 0;
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
+	for (int j = 0; j < info->phys_channels; j++)
+		if (info->active_channels[j])
+			pac1934_custom_attr[i++] = pac1934_shunt_attrs[j];
 
 	pac1934_group->attrs = pac1934_custom_attr;
 	info->iio_info.attrs = pac1934_group;
-- 
2.56.1.750.gf70dc682cf-goog

