Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B163353A95;
	Wed, 30 Sep 2026 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731001; cv=none; b=Ew4/5a3JujMjeBtNxyLepiukphgJxoUDzpZv0vof+P5LlDo5JskD4Mr5Uv4dH6LxabU+ALQFcBhsdqH2C45aR8wcNqrcxmuR9BEBt41m6Q3NihirbL/A7tfpK/Toyl6aEbNG+64svTj7DWsYUJvtAbisf9tPW1DCn6kq7Hj2q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731001; c=relaxed/simple;
	bh=VOhb+ySPVjRl8pDoPgMbFA9u93Svvz7os4YzgT6Oa/M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iY3jzIjTbhHmUSnSMU6XL4oQDO3onC5Ew5SswyyyPMatRXGpNCss1DI48y/y/AiXr+ZP9E2Oaj28MgJCMo/e9zF9prHhvdW8Us59HtZhmuqYZOo1ZNGHGys+reKK6uolZR5PpDx9Sz3TMBYPzeSpGrg+S16ozlUtTkml+uy7TTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gonzalezerik.com; spf=pass smtp.mailfrom=gonzalezerik.com; dkim=pass (2048-bit key) header.d=gonzalezerik.com header.i=@gonzalezerik.com header.b=IkiGSpOE; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gonzalezerik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gonzalezerik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gonzalezerik.com header.i=@gonzalezerik.com header.b="IkiGSpOE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gonzalezerik.com;
	s=protonmail; t=1790730988; x=1790990188;
	bh=RdM+UiliwQYfF+1fJ+nv82vgIHd7yfAaTg60+i6aCqo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IkiGSpOEIM4h6WFSE3k2m5p+GByeaNGqppVbGxz2YLrtV2qKvRmyeZErQX24PBXnD
	 xnHX9nzt1x0gpaXCta43luyN2032c/HOoPCqr96luEukZty3A21DLb12iN9i0MencH
	 xwl7dvu6kwg91gvyl0qU45WiuMjp9eqbuxlkOknxpQ8Xbq+5FYZXrPx6tKiwApGBK5
	 UT3UQBN00Eb/FDICC5H0SpLp93pKbg3EbXKkQV+N3Wet8WCeoaCYQdRiqPjsinHpyz
	 wqw5bmgWONAGExAOCX0nTjWERXBZ+dKaPUl56j7QdcJVzarSw4oLiPVVhw2fkwXosJ
	 EGDu5i1pkO03Q==
Date: Wed, 30 Sep 2026 01:16:22 +0000
To: Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Erik Gonzalez <dev@gonzalezerik.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] HID: amd_sfh: Fix report type of get_report replies
Message-ID: <20260930011603.476486-1-dev@gonzalezerik.com>
Feedback-ID: 214839413:user:proton
X-Pm-Message-ID: 75a657cf4435a63336237d388f829bd3a93cc1fa
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

amd_sfh_work() passes the reply to a get_report request to
hid_input_report() with cli_data->report_type[] as the report type. That
array has never been written since the driver was added, so it is always
0 (HID_INPUT_REPORT), and replies to feature report requests reach the
HID core as input reports.

The HID core then checks the payload against the input report with the
same ID. Since commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB
by removing bogus memset()"), a report shorter than that is rejected
instead of being zero-padded. On an ASUS ProArt PX13 (HN7306EAC) running
7.2.6 this logs:

  hid-sensor-hub 0020:1022:0001.0005: Event data for report 1 was too short=
 (15 vs 14)
  hid-sensor-hub 0020:1022:0001.0006: Event data for report 4 was too short=
 (18 vs 14)

14 bytes is the size of feature reports 1 and 4 in the report
descriptors the driver provides; 15 and 18 bytes are the input reports
with those IDs. Attributes backed by feature reports then read wrong
values: the accelerometer's in_accel_sampling_frequency reads 10.000000
instead of 12.500000, and in_accel_hysteresis reads 0.000000 instead of
1.270000. Input reports are not affected, because their type happens to
be 0.

Pass the type of the request being completed instead, and remove the
unused report_type[] array.

The same "report 4 was too short (18 vs 14)" message has been reported
for the Lenovo Legion Go S, where the accelerometer and gyroscope do not
register. That may be the same bug; I have not tested that device.

The bug was found, and this change and description were written, with
the help of an AI coding assistant. The analysis was checked against the
report descriptors of the PX13, and the change was tested on it by
loading amd_sfh built for the running 7.2.6 kernel without and with it:
without it, the messages and values above; with it, no messages, and
sampling frequency and hysteresis read 12.500000 and 1.270000.

Fixes: 4b2c53d93a4b ("SFH:Transport Driver to add support of AMD Sensor Fus=
ion Hub (SFH)")
Link: https://github.com/ublue-os/bazzite/issues/5796
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Erik Gonzalez <dev@gonzalezerik.com>
---
Not tested: other devices with the AMD Sensor Fusion Hub (including the
Legion Go S), and a booted hid.git kernel. The code this touches is the
same in hid.git for-next and 7.2.6; the patch was build-tested on
for-next (clang, W=3D1, no new warnings) and runtime-tested on 7.2.6.

 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 4 ++--
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h    | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh=
-hid/amd_sfh_client.c
index ae6add0b9..a68b275f0 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -95,7 +95,7 @@ void amd_sfh_work(struct work_struct *work)
 =09=09=09=09=09=09    cli_data->feature_report[current_index]);
 =09=09if (report_size)
 =09=09=09hid_input_report(cli_data->hid_sensor_hubs[current_index],
-=09=09=09=09=09 cli_data->report_type[current_index],
+=09=09=09=09=09 node_type,
 =09=09=09=09=09 cli_data->feature_report[current_index], report_size, 0);
 =09=09else
 =09=09=09pr_err("AMDSFH: Invalid report size\n");
@@ -104,7 +104,7 @@ void amd_sfh_work(struct work_struct *work)
 =09=09report_size =3D mp2_ops->get_in_rep(current_index, sensor_index, rep=
ort_id, in_data);
 =09=09if (report_size)
 =09=09=09hid_input_report(cli_data->hid_sensor_hubs[current_index],
-=09=09=09=09=09 cli_data->report_type[current_index],
+=09=09=09=09=09 node_type,
 =09=09=09=09=09 in_data->input_report[current_index], report_size, 0);
 =09=09else
 =09=09=09pr_err("AMDSFH: Invalid report size\n");
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h b/drivers/hid/amd-sfh-hi=
d/amd_sfh_hid.h
index 7452b0302..928cff682 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
@@ -45,7 +45,6 @@ struct amdtp_cl_data {
 =09dma_addr_t sensor_dma_addr[MAX_HID_DEVICES];
 =09u32 sensor_sts[MAX_HID_DEVICES];
 =09u32 sensor_requested_cnt[MAX_HID_DEVICES];
-=09u8 report_type[MAX_HID_DEVICES];
 =09u8 report_id[MAX_HID_DEVICES];
 =09u8 sensor_idx[MAX_HID_DEVICES];
 =09u8 *feature_report[MAX_HID_DEVICES];

base-commit: 145c2b2e9a5c0f794fb4009bcb072ab19f8ccfcd
--=20
2.55.0


