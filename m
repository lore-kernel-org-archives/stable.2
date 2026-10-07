Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC476BA3D;
	Wed,  7 Oct 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331308; cv=none; b=RK9CbqOMTV3A5fcaUh0YtQ2cydWpVJlc4ALi58Llh3t3TiuFv+ziGjKkiO5W/bbFNn+kPdb995PQnUA0Gz03G4dHg3vc4Q8Yi5Hvn+1fZYDb7rV7dEbn/XiPCAVwltRB/Py15nTsuVWrJulUOy7xXO3OhHLJHv/cBUP4S2BQaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331308; c=relaxed/simple;
	bh=AkGS+MaheHpMXKrbQvabwmv4zQHKgmRepF9YCokERMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zk4ORoEIF/LLnQtFrYNLZCI46tZIIUR1tucK1bpPzdfmyPt1jQS/3TOSZWd8UAelSqvQMDfsOtVe1VBmjJu+yaV+4nSiHTHuEknijD39VECO7YY5dgIr5vK/MPtb5EO9TVUSxQoMCDWcV5hgmHJgkTRWujcySON3hHJyQ6t4ftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=maxx-cz@web.de header.b=wRZkB/jm; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=maxx-cz@web.de header.b="wRZkB/jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791331298; x=1791936098; i=maxx-cz@web.de;
	bh=ZWg9/jfR+xrgJptM0nvWKuFbQmw0DbnJHWBCAG+qDlw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wRZkB/jmG93rRPjnz4VRA16InrO1yBk1lbkEbOFWu5elti6aCCXXEQU029Jq46dF
	 eY3ASnofltCkFge4eceaNmxFHgMhNBQeJqzjocM1rc+kKcJh38bU7LDFuGB5tgDdm
	 BnBGd2+1e2HpyzorDcF98PSe7zt/+t2pAAw+AE9lcCuofZCSDwwtsNsciTvp8bq25
	 dOuUSv9l/FCuhONVHsLZT3HQuzzJ8Tf3qdY2USrH+P+r/NducdE/PlHUSvSOANL8F
	 iuaMD7bLGWEfgQd9e4uBigfTrF5SXlq5OlO0jIkPYy7ywEPgS9fdqwwBrVnSU/rwo
	 NEG7Mw8Vnd0IekOR/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXocY-1xB3gk1udo-00TJ97; Wed, 07
 Oct 2026 02:01:38 +0200
From: Maximilian Czirr <maxx-cz@web.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	Maximilian Czirr <maxx-cz@web.de>,
	stable@vger.kernel.org
Subject: [PATCH] iio: hid-sensor: Fix scale for magnetic north heading
Date: Wed,  7 Oct 2026 02:01:07 +0200
Message-ID: <20261007000107.16533-1-maxx-cz@web.de>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:godCFues7cS5y5valh4YuqOhDHD99Kb+X+LVrTnTXlcMInzlw1m
 l0HI+gcDMrxum19HmgbkSLSGdhhOSrginqnFNuASweXFNtCOgdpLJkNbar0UVvyggZ/kVfH
 eaBUPhV84ecRXxcfyhNWknd5on0ubdLujzAbWGwoGOFkRS8ISmvcRqdiS4VWBhEz+TYx9Wh
 W3GwaswY8AavIfaolW1CQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AE0/sroMNLU=;Y5P35OrEEIFFS6fsVlmzO7+Gzm1
 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

hid_sensor_format_scale() applies the HID unit exponent only when
the usage and unit match an entry in unit_conversion[].

Rotation-from-north support uses
HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, but that usage has no entry in
the conversion table. As a result, the unit exponent is ignored and the
heading can be exposed with a scale of 1 instead of the scale specified
by the HID descriptor.

Add a unitless conversion entry so the HID unit exponent is applied to
the magnetic north heading. A sensor reporting an exponent of -5 then
correctly exposes a scale of 0.00001 instead of 1.

Fixes: abea9c62c32f ("iio: hid-sensor-magn-3d: Add support for rotation fr=
om north")
Cc: stable@vger.kernel.org
Signed-off-by: Maximilian Czirr <maxx-cz@web.de>
=2D--
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/driv=
ers/iio/common/hid-sensors/hid-sensor-attributes.c
index 9e7c26e37880..26f8554d18a5 100644
=2D-- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -38,6 +38,8 @@ static const struct {
 	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000000},
 	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
=20
+	{HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, 0, 1, 0},
+
 	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453293},
 	{HID_USAGE_SENSOR_INCLINOMETER_3D,
 		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},
=2D-=20
2.56.0

