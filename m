Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F335C1B1
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991796; cv=none; b=GFCOx9mP/vdfEhac3Xyt03SE7crliykBlo3yDz4id1F54pY9QDwTenOFLmDJjN7sQ/kC9QQH3WPpoFJU34FDzMD1cEbtIIW6htNpNh0pri4we8MX22fvU2tD84GwbbsUzZdwnYZpmXDqV+abHxhzne56GtyNaUpbG1ybzkysEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991796; c=relaxed/simple;
	bh=Qi8Dj92eb+93MVySEkyfqvNDAbJtJCKLds50WkZw8To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZYonGdGRiTLz4QzwgHPKE+0wuuCMA86wqGioUDyBI0NQvBcSjXKU9Z3z6ZV+ckKxV9Gcu0XUS0KbU+l1f4Xfhvj5eEqw7b906Mlm+9XqN1SDThMw4CQr0PJmoEXcOscK6f1uhdtB+kReUtXV6SAuPSGjC6eAJKyebXMuUnSw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh50wK6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh50wK6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B811F00ACA;
	Tue, 14 Jul 2026 01:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991794;
	bh=6k88QywO9eC5FLrSTJ2htNMjtu+rNQsUhLnhWC+BPxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sh50wK6TL1924C2OZbft7BSguCKB5dOACau0qrt5zCXe8tpw0Mrf2Jdtbu1YPnFbw
	 /s2HFG6IYMd9axJzQRTuXPY+1GeDb/xDyUxUrJPvLWp0stUYTPCL8pTTewz71itNWj
	 MVvd9ZwjeS7z7lguXioPfcD9+0gSeOsNDM84GCwPh4rgpJPUCKZRRBihILVUGyT2f9
	 rGnee22TA0akw4EMESzK1gFaddl9weAB3PictUlZLWG6r9b4vOnd4m4Wf+E60Or22S
	 KM/KCrJJ0OYcZXHiOuI5vhC0wsjBuOJ4hTFeFK+wszlk3Jw682YJNwWxvPjQXTyrRA
	 7F7bEI0n9Sj6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herman van Hazendonk <github.com@herrie.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iio: common: st_sensors: honour channel endianness in read_axis_data
Date: Mon, 13 Jul 2026 21:16:31 -0400
Message-ID: <20260714011631.2188967-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714011631.2188967-1-sashal@kernel.org>
References: <2026071349-oppose-radiantly-81a4@gregkh>
 <20260714011631.2188967-1-sashal@kernel.org>
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
index 35720c64fea8f0..dcc032f6874030 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -524,6 +524,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	unsigned int byte_for_channel;
+	u32 tmp;
 
 	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
 					ch->scan_type.shift, 8);
@@ -536,12 +537,22 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
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

