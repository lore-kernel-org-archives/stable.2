Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37732356772
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975169; cv=none; b=dBoDCEB4N3/BVF5K8jGm19g12avwBkksCS8S5kxdc75TtUzpgTlG3be9hRzuQzUc5FsPLEwUVP5WjW9nUXKTux1IjKLMVX0jXxS9YlVAx0Q7XJnbNCRRJkAv2TlAfBW85fgdXQZWCe71k2auH9eKsxBT2zk/E9xoHfPf1XfxXWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975169; c=relaxed/simple;
	bh=UFkYjqoLqmpLBSPtxM2kVEHTI35ar+FiDV4IYGblHQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eccmcHlGgeVEWomCjccbmv/B/NExKiGSY7+MJoEt24Fb5jLcmb8tr6nZQE+ZjZHL8P2lVhIhzE7zBa2pf5aEfrYJ+75WNUlSWQU63yxEsiFyslrXwxDsNRVcyKpiWgTDxbPKevPkQiPp2UjEU/yu9SZ2IUvV9PgYFjpCdg9FWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiNpPPRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiNpPPRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EACC1F00A3D;
	Mon, 13 Jul 2026 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975167;
	bh=R58yMrpyLhAc/PWwlX5g68JEU16gHrC5YLJDc3abSyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AiNpPPRe1d8qxIQ6lIvzaU9b/PDRCcXplKyAJWk/bwW216lJBwNfYPVB3yib0DYGL
	 2X3E+vwtVOQY1abf5Pt66IXOYmUEQKRCVT04hO0cNURyaDTveukjwBzXRMIkL6GtnL
	 XnRWgV2Oos0S3TVNd7d8Cq0qUWrQID3k+x89r1ReTbkTzpgIhQ/tjPpprM0PxHvvUO
	 vWBaYL5QQ623hBxOulHCfXoGsVpSqcnzTzKE/HV1hDNnyHgktoCmdG/Gcn5cxyIjXq
	 YzUY/udzVSv6HBTFvKE4ez/v7uNwxoP5ILYyKJviGLv+GCBNsHTfZklTZhrAF7672m
	 4WSBCETtuxsuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herman van Hazendonk <github.com@herrie.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iio: common: st_sensors: honour channel endianness in read_axis_data
Date: Mon, 13 Jul 2026 16:39:24 -0400
Message-ID: <20260713203924.2143667-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713203924.2143667-1-sashal@kernel.org>
References: <2026071348-glorify-lapel-3161@gregkh>
 <20260713203924.2143667-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Herman van Hazendonk <github.com@herrie.org>

[ Upstream commit 55052184ac9011db2ea983e54d6c21f0b1079a12 ]

st_sensors_read_axis_data() unconditionally decoded multi-byte
results with get_unaligned_le16() / get_unaligned_le24() regardless
of the channel's declared scan_type.endianness.

For every ST sensor that has used this helper since it was introduced
this happened to be fine because the ST IMU/accel/gyro/pressure
families publish their data registers as little-endian and the
channel specs in those drivers declare IIO_LE accordingly.

The LSM303DLH magnetometer however publishes its X/Y/Z output as a
pair of big-endian bytes (the H register sits at the lower address,
0x03/0x05/0x07, and the L register immediately after), and its
channel specs in st_magn_core.c correctly declare IIO_BE -- but
read_axis_data() ignored that and decoded as little-endian, swapping
the high and low bytes of every magnetometer sample. The LSM303DLHC
and LSM303DLM share the same st_magn_16bit_channels (IIO_BE) and
were therefore byte-swapped by the same bug; users of those parts
will see different in_magn_*_raw values after this fix lands.

The bug is most visible on a stationary chip: in earth's field the
true X reading is small and the high byte sits at 0x00, so swapping
the bytes pins sysfs X at exactly the low byte's pattern (e.g. 0x00F0
= 240). Y and Z still appear "to vary" because their magnitudes are
larger and the noise in the low byte produces big swings in the
swapped high byte:

  before (LSM303DLH flat, sysfs in_magn_*_raw):
      X=240 (stuck), Y= 12032..23296, Z=-16128..-9728

  after (direct i2c-dev big-endian decode, same chip same orientation):
      X≈-4096, Y≈210, Z≈80     (sensible values reflecting earth's
                                ambient field at low gauss range)

Fix read_axis_data() to dispatch on ch->scan_type.endianness and
call get_unaligned_be16() / get_unaligned_be24() when the channel
declares IIO_BE. Existing IIO_LE consumers (st_accel, st_gyro,
st_pressure, st_lsm6dsx and others) are unaffected because their
channel specs already declare IIO_LE and the LE path is unchanged.

While restructuring the branches, replace the previously implicit
silent-success-with-uninitialised-*data fall-through for
byte_for_channel outside 1..3 with an explicit return -EINVAL. No
in-tree ST sensor publishes such a channel, but the new behaviour
is strictly safer than handing userspace garbage.

Fixes: 23491b513bcd ("iio:common: Add STMicroelectronics common library")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7 sparse smatch clang-analyzer coccinelle checkpatch
Assisted-by: Sashiko:claude-opus-4-7
Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../iio/common/st_sensors/st_sensors_core.c   | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 78f5728417d5b3..6fd725b3c0684e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -498,6 +498,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	unsigned int byte_for_channel;
+	u32 tmp;
 
 	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
 					ch->scan_type.shift, 8);
@@ -510,12 +511,22 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	if (err < 0)
 		goto st_sensors_free_memory;
 
-	if (byte_for_channel == 1)
-		*data = (s8)*outdata;
-	else if (byte_for_channel == 2)
-		*data = (s16)get_unaligned_le16(outdata);
-	else if (byte_for_channel == 3)
-		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
+	if (byte_for_channel == 1) {
+		tmp = *outdata;
+	} else if (byte_for_channel == 2) {
+		if (ch->scan_type.endianness == IIO_BE)
+			tmp = get_unaligned_be16(outdata);
+		else
+			tmp = get_unaligned_le16(outdata);
+	} else if (byte_for_channel == 3) {
+		if (ch->scan_type.endianness == IIO_BE)
+			tmp = get_unaligned_be24(outdata);
+		else
+			tmp = get_unaligned_le24(outdata);
+	} else {
+		return -EINVAL;
+	}
+	*data = sign_extend32(tmp, BYTES_TO_BITS(byte_for_channel) - 1);
 
 st_sensors_free_memory:
 	kfree(outdata);
-- 
2.53.0

