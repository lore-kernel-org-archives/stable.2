Received: from outbound0.mail.transip.nl (outbound0.mail.transip.nl [149.210.149.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBD36C592;
	Tue, 16 Jun 2026 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.210.149.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615356; cv=none; b=g1ZihCDCiwDmXpR0ws+rWSNeoS5HBdmcqdQDodET8EHuywC/hMX3l9s8DDBATpm82IAARi10yhgPxdHVAwcRH+N2sKPiQrBODRpwucm08S7AYWukyzNx5tOBTQen1XVdG2/q6MG/X7egfIIcEySESpKllSRyFt9j6eFdTH9r7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615356; c=relaxed/simple;
	bh=YjBIskBxzyth5ZS2HuUmqzJMu5fvYPW0oDwH7P9GADg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SEcgkjs8cIghOzi66+iFmq5vCNOkJEL9TDFKTJpQq+52zS+Qkge0pTHqowHEqnx9qR77WIAdNc+iqyk8/BCuTwb4hQ8der/zWCoSmJuVs10p4N+GQHwFs/xBxZeYXyTHfeUtcyjJj4YSPlV7jRLrfgHm/qtAljNSPUsQHmqhtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=iqYFIaJX; arc=none smtp.client-ip=149.210.149.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="iqYFIaJX"
Received: from submission12.mail.transip.nl (unknown [10.103.8.163])
	by outbound0.mail.transip.nl (Postfix) with ESMTP id 4gfnFV33R6zxPG5;
	Tue, 16 Jun 2026 15:02:06 +0200 (CEST)
Received: from [127.0.1.1] (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission12.mail.transip.nl (Postfix) with ESMTPA id 4gfnFR65s5z3SJ37P;
	Tue, 16 Jun 2026 15:02:03 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH v2 0/3] iio: lsm303dlh-magn: endianness + boot-time
 fullscale selection
Date: Tue, 16 Jun 2026 15:02:03 +0200
Message-Id: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEtJMWoC/x3MTQqDMBBA4avIrDuQZDSIVyld+DMmAyaWjC2Ce
 PeGLj8evAuUi7DC0FxQ+Csqe65wjwbmOObAKEs1OOO88dajfqYkB4rsuGkiQ8sWMY0h4yonK7a
 97aglmshYqJd34X+ok+frvn88zs9YcQAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Denis Ciocca <denis.ciocca@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Denis Ciocca <denis.ciocca@st.com>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, devicetree@vger.kernel.org, stable@vger.kernel.org, 
 Herman van Hazendonk <github.com@herrie.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781614923; l=6464;
 i=github.com@herrie.org; s=20240417; h=from:subject:message-id;
 bh=YjBIskBxzyth5ZS2HuUmqzJMu5fvYPW0oDwH7P9GADg=;
 b=p91uUwdD4zRdKxj5SmU5h7dnhR0ngLZef+qzfek9zeSg7cugs+NKkFroHbwPV9Xcr5jVZmO3d
 Ff+Ib+eIsTCDdKRXziFIsytBDBu9SOG6lw0msn6OcTiEBgVes2q0U0O
X-Developer-Key: i=github.com@herrie.org; a=ed25519;
 pk=YYxdq8fb5O9vhkW3n2dCH044FPZZO5718v/du7fRhFw=
X-Scanned-By: ClueGetter at submission12.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1781614924; h=from:subject:to:cc:date:
 mime-version:content-type;
 bh=DrlHoBBp0WHgfXuiLQmFAQiKIwBLibVGviCDOcxSy8c=;
 b=iqYFIaJXKHX0wNQARVQLvDs2sqFakEZEloRGhAqXdk2UGkjA28BTDOUInH46s8AMYgRioa
 WnwYxcSk1IOmmBknsiMcQLo7QWguQ5JEQZ+Ln2kh4MPCUer2YhHrRv0LkBEiTmfRJnq1Yj
 k2ksOk2UJrnfFWpZKTiBH3F26urQTz0ORzGhk4wMCjcXmqbRcSQViQlUqMstW8xhzuaRgr
 MljTLeaCwayWafn9vk3hBG+hheUYxYPXtYhDei5k4Uc3RjJ4AzVCa/5fc/Z3IQ0XgvFJn1
 rHCOya5gSGxqqHARntjmzYa9qFigqWeik1P4G8+95mWaH9yx2rUaWY/lr6NRfQ==
X-Report-Abuse-To: abuse@transip.nl

This series fixes two independent issues that together prevent the
LSM303DLH magnetometer from delivering usable readings out of the
box on at least the HP TouchPad (apq8060), and adds a small generic
extension to the ST sensors device-tree binding to allow boards to
declare a non-default initial full-scale.

PATCH 1/3 fixes st_sensors_core's read_axis_data() helper to honour
the channel's declared scan_type.endianness. The helper has
unconditionally decoded multi-byte results as little-endian since
it was introduced. Every other in-tree ST sensor declares IIO_LE
and was unaffected, but the LSM303DLH / LSM303DLHC / LSM303DLM
magnetometers all bind st_magn_16bit_channels (IIO_BE) and publish
their X / Y / Z words as big-endian pairs (high byte at the lower
register address, 0x03 / 0x05 / 0x07). The mismatch swapped the
high and low bytes of every magnetometer sample on these three
parts. The fix only affects the IIO_BE branch; existing IIO_LE
consumers are untouched.

PATCH 2/3 adds an optional st,fullscale-milligauss device-tree
property to the ST sensors binding. The driver core hardcodes
fs_avl[0] (the highest-sensitivity range) as the starting
full-scale, which is the right default for a desk-noise floor but
leaves no margin for boards that pick up DC bias from nearby PCB
structures. The property is scoped to magnetometer compatibles
via per-family enum clauses so DTSes with a misspelled value, or
that put the property on accel/gyro/pressure or fixed-FS magn
nodes, fail dt_binding_check rather than being silently no-op'd at
runtime.

PATCH 3/3 parses st,fullscale-milligauss in the magnetometer
common probe and selects the matching fs_avl entry. The LSM303DLH
on the HP TouchPad picks up enough DC bias from the surrounding
power planes that the chip-default +/-1.3 G range saturates the X
axis to the chip's 0xF000 overflow sentinel on every sample, while
Y and Z fall within range. Empirically any fs_avl >= 1 (+/-1.9 G
and up) works; on tenderloin the appropriate value is 2500 mg
(+/-2.5 G).

PATCH 1/3 is a standalone bug fix and is now Cc'd to stable;
PATCHES 2/3 and 3/3 form a unit.

Changes since v1
~~~~~~~~~~~~~~~~

PATCH 1/3 (endianness):
  - Restructure around a single u32 tmp + one trailing
    sign_extend32(tmp, BYTES_TO_BITS(byte_for_channel) - 1), drop
    the (s16) / (s32) casts (Andy Shevchenko).
  - Make byte_for_channel == 0 || >= 4 an explicit -EINVAL return
    (no in-tree caller hits this, but the prior code silently left
    *data uninitialised).
  - Add Fixes: 23491b513bcd ("iio:common: Add STMicroelectronics
    common library") and Cc: stable@vger.kernel.org (Jonathan
    Cameron). The bug has been present since the helper was
    introduced in 2013.
  - Spell out that the fix changes in_magn_*_raw decoding for
    LSM303DLHC and LSM303DLM too (same IIO_BE channel set), not
    only LSM303DLH.

PATCH 2/3 (binding):
  - Rename st,fullscale-mg to st,fullscale-milligauss. "-mg" is
    the DT unit-suffix convention but already names milli-g in
    the accelerometer parts of this same binding file; spelling
    milligauss out keeps the unit unambiguous if a similar
    tunable is ever added for accel/gyro/pressure.
  - Scope the property to magnetometer compatibles via per-family
    allOf:if-then enum clauses:
      LSM303DLH/DLHC/DLM: enum [1300, 1900, 2500, 4000, 4700,
                                5600, 8100]
      LIS3MDL/LSM9DS1/LSM303C: enum [4000, 8000, 12000, 16000]
      LSM303AGR/LIS2MDL/IIS2MDC (fixed FS): rejected outright
      everything else (accel/gyro/pressure/IMU): rejected outright
  - Drop the "(or analogous engineering units for other sensor
    families that may grow this property in the future)" hand-wave
    from the description (Jonathan Cameron); the property is now
    positively bound to magnetometers only.
  - Drop the overstated "userspace cannot recover without racing
    the driver" wording; document the actual probe-time window
    (the in-tree IIO consumers cache the saturation sentinel
    before any UDEV rule fires).
  - Add an in-file maintenance comment before the catch-all NOT
    clause so future contributors who add a new magnetometer
    compatible know all four clauses must be updated together.

PATCH 3/3 (driver):
  - Honour the rename to st,fullscale-milligauss.
  - Restructure per Andy: const char *propname at the top,
    device_property_present() pre-check, device_property_read_u32()
    error path with explicit return.
  - Gate the parse block on mdata->sensor_settings->fs.addr != 0
    as defence in depth; the binding already rejects the property
    on fixed-FS magnetometers, the gate keeps the code path
    self-contained against stale DTBs.

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
To: Bill Wendling <morbo@google.com>
To: Justin Stitt <justinstitt@google.com>
To: Denis Ciocca <denis.ciocca@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Denis Ciocca <denis.ciocca@st.com>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev
Cc: devicetree@vger.kernel.org
v1: https://lore.kernel.org/linux-iio/cover.1780652883.git.github.com@herrie.org/

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260616-submit-iio-lsm303dlh-magn-fixes-48153433b301
---
Herman van Hazendonk (3):
      iio: common: st_sensors: honour channel endianness in read_axis_data
      dt-bindings: iio: st,st-sensors: add st,fullscale-milligauss
      iio: magnetometer: st_magn: honour st,fullscale-milligauss DT property

 .../devicetree/bindings/iio/st,st-sensors.yaml     | 71 ++++++++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_core.c    | 23 +++++--
 drivers/iio/magnetometer/st_magn_core.c            | 32 ++++++++++
 3 files changed, 120 insertions(+), 6 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260616-submit-iio-lsm303dlh-magn-fixes-48153433b301

Best regards,
-- 
Herman van Hazendonk <github.com@herrie.org>

