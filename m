Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056023;
	b=Lkop/bWKwfdgUXd/i5FwIUt070y/7/aXDnnYy+FLoxDdB3vRnRQdBM0T2N0LX+uevo/3
	 x5ml/Xnt4PDLBcDQPaknHmNK6clupzHeRIecdp3pAsiHwopefPOMY6OORqC7rmq9b0KE0
	 laUd3pgk0WHBrYx4mUeDO71Tv0mNBZqeuN1DKZxIkJv8udDe7OPyEGN5G+nZ6/xqfCQxh
	 AgnU1ch0QP3p5wjiUWq/KronDFTIjhmINCyab+oNGIR5+upKhpq2mo5d3dD1FaHV5D/Zb
	 oXyAeKE3TC8CAs46gGn3gjDzGz9ffoTqaJkclOZbZXbIyDxXhQsBmkR4PNbHcA/qhWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056023;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:X-Change-ID:X-Mailer:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=U7Lzo1+qgVqmQiwOlvCzOwMeGoIrZ7vss+KIAcCk0lQ=;
	b=G0f0aQh+tUQa2P5zbsJuJUwVLdnZZHeg6Hk+wHcpT9GDYq6bpsf8YIec4SSKhJtanxZn
	 J5Zr8E0YVGyVClBF+Hpi6+SghkA6z9X8wU0zr8h5fZp+DfMFYDtj1ofrvJuDwDn30X8vo
	 IbLzpMYCiQbt0it6b5Uuu/EJiZEKCU/ccNF59YV0di2eC0lxyxB/9ZkX0c5cgSwdrVoUK
	 OC78+Hj3PUnyZppB+rNmnMrIE0B/L3f6kPhkoNh82rrydds4buo4/ZDqfkGg3zKauu3Bn
	 Mdp8wEW3D9QVAQbpXdRNRBZXMMUxOJZDvtx5BYTdOeDpzJDS5kmFIHLGYFXxzt6BtOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jv6xJLj6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3F606A31A;
	Mon, 26 Oct 2026 23:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD3F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jv6xJLj6
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP0gQ337396;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U7Lzo1+qgVqmQiwOlvCzOw
	MeGoIrZ7vss+KIAcCk0lQ=; b=Jv6xJLj6c/vpG0P6oYAYJYZS7fnbD9lky45hrs
	XiVg0UoOB3roF1gBdFomH1HTa74+wDgTSNtAiNKnWpVMe/Yr/cagqkMH7puzYx3H
	oY7kGCfgyyN97a7gbrvBQwAtsBELD3ZKHoOpIl2S3+5nbGqJlynjpUjbbeUX6T3l
	Wwbxgi5bJVLo29xSl9wdbOBnFmvhkT7Z+d3u9owvulboMOhhRMvu0/EGberWr8JM
	Ljg+5LpN5zG7B+ugygOi2ZtxnT/8dtBlalNR2O7p+yiOdiaF8jc4hx+JHodLnmjs
	hWstJgExYuDi4Bd3igSjwkTMebgCSAn/PxiKVIIA9XkkLCkg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y2pek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61Ni120265;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69QN60U4120225
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id BD36424D74; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Lixu <lixu.zhang@intel.com>, Cong Nguyen <congnt264@gmail.com>,
        Ethan Tidmore <ethantidmore06@gmail.com>,
        Christian Eggers <ceggers@arri.de>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jianping Shen <Jianping.Shen@de.bosch.com>,
        Alex Lanzano <lanzano.alex@gmail.com>,
        Justin Weiss <justin@justinweiss.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        "Andrew F. Davis" <afd@ti.com>, Archit Anant <architanant5@gmail.com>,
        Stefano Manni <stefano.manni@gmail.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Piyush Patle <piyushpatle228@gmail.com>,
        =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>,
        stable@vger.kernel.org, Adi Nata <adinata.softwareengineer@gmail.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Francesco Lavra <flavra@baylibre.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 00/39] IIO: Continue removing deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 26 Oct 2026 16:05:18 -0700
Message-ID: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261026-iio-b9364d28fa05
X-Mailer: b4 0.17-dev
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX61YOdmjLjuLu
 C3d2g6aNaRf+v7c1sOd+P6hWqEdzotx2m4hSVM030rDJZJR6087OBZXlhkR7H64rrxYdQM5zj+k
 mbjb9L2QPL9Hys2rI3O1WVh17PBWeac=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=WH0fWir_-IukjzuT9MEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9ldfGD/WXRWC
 dP/vkxHm6YxLzyuhyHa+FmmHI7otN5AVC0kVcsW0oWSMXKKlDYTsDP0sk6inOll3buEZwNjXPTc
 wlNqyq7Xz2O9SJsaSB0QJAB/JWjxbmmXqqZJVplr+o1rhZuWLqHZSDKNIEh7Ubb2m8xwBMNipxS
 c7CbjgUSvrSoCcMG3U1FZ7peKcs0peuHdHrti6FVFAi0WWUZmN1XtBreXzB2c5DqgMZdpo3YIrt
 yUDOn+0QadqhI36GBoSUjrexq9teueyL1Shg7Z38ve1ofEYtOmZniLrVVMiiYHjgvdzlaoX7PdF
 st9CgRm61vV2Iv+dSQbwp+qsDcbTbFZ8wEepOJQxitmDMhq8P/U5CxIBtS1/VgUxn/8MRSP1p0G
 O+auzCe2wrzgV/PA258MOc3xZ7kmWXCxCQ79cs9LKgboTpz8W0TQSgsIDZssKmCGpDNO+NqNQOV
 ULjto1tXXVHk3VFJLZw==
X-Proofpoint-GUID: 9pyP4rfIlJ4wOsOG0Y1HHCgmF4AFxXqX
X-Proofpoint-ORIG-GUID: 9pyP4rfIlJ4wOsOG0Y1HHCgmF4AFxXqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

A bit of technical debt cleanup that was partly a discovery exercise in
using AI tooling for this sort of somewhat messy subsystem maintenance
activity.

Replace iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() which includes a runtime check that
there is sufficient space to insert the timestamp.

A few other modifications of related code seen whilst working through
these and a couple of fixes for DMA safety. Those are not sent as
separate fixes as they are in old drivers and we have had no
reports of problems. So no rush to get upstream.

The remaining users of iio_push_to_buffers_with_timestamp() are
the more complex cases that will require more careful review so
are left for the next series.

I appreciate this is a large series, so if you have time to take
a look review what you can and I'll nibble away at applying the
ones that have received sufficient review.

Thanks,

Jonathan

p.s. First time I've used b4 prep for a series, so fingers crossed :)

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Jonathan Cameron (39):
      iio: adc: ti-adc161s626: use iio_push_to_buffers_with_ts()
      iio: adc: mt6360-adc: use iio_push_to_buffers_with_ts()
      iio: adc: ad4130: use iio_push_to_buffers_with_ts()
      iio: addac: ad74413r: use iio_push_to_buffers_with_ts()
      iio: hid-sensors: use iio_push_to_buffers_with_ts()
      iio: gyro: mpu3050: use iio_push_to_buffers_with_ts()
      iio: imu: bno055: use iio_push_to_buffers_with_ts()
      iio: light: as73211: use iio_push_to_buffers_with_ts()
      iio: light: vcnl4035: use iio_push_to_buffers_with_ts()
      iio: pressure: mprls0025pa: use iio_push_to_buffers_with_ts()
      iio: pressure: ms5611: use iio_push_to_buffers_with_ts()
      iio: proximity: isl29501: use iio_push_to_buffers_with_ts()
      iio: proximity: sx9500: use iio_push_to_buffers_with_ts()
      iio: imu: smi330: use iio_push_to_buffers_with_ts()
      iio: imu: bmi270: use iio_push_to_buffers_with_ts()
      iio: imu: inv_icm42600: use iio_push_to_buffers_with_ts()
      iio: health: afe4403: use iio_push_to_buffers_with_ts()
      iio: health: afe4404: use iio_push_to_buffers_with_ts()
      iio: adc: ad799x: use iio_push_to_buffers_with_ts()
      iio: common: scmi_sensors: use iio_push_to_buffers_with_ts()
      iio: adc: ad7766: use iio_push_to_buffers_with_ts()
      iio: imu: smi240: use iio_push_to_buffers_with_ts()
      iio: adc: cc10001_adc: use iio_push_to_buffers_with_ts()
      iio: adc: hx711: use iio_push_to_buffers_with_ts()
      iio: potentiostat: lmp91000: use iio_push_to_buffers_with_ts() with a scan struct on stack
      iio: humidity: am2315: use iio_push_to_buffers_with_ts() with a scan struct on stack
      iio: humidity: hdc100x: use iio_push_to_buffers_with_ts() with a scan struct on stack
      iio: imu: bmi323: use iio_push_to_buffers_with_ts()
      iio: gyro: fxas21002c: restrict available_scan_masks to all angular velocity channels
      iio: gyro: fxas21002c: use iio_push_to_buffers_with_ts() with explicit structure
      iio: adc: ad7887: ensure tx_cmd_buf is DMA safe
      iio: adc: ad7887: use iio_push_to_buffers_with_ts()
      iio: humidity: hts221: align scan buffer for DMA safety
      iio: humidity: hts221: use iio_push_to_buffers_with_ts()
      iio: accel: bmc150-accel-core: use iio_push_to_buffers_with_ts()
      iio: common: cros_ec_sensors: use iio_push_to_buffers_with_ts()
      iio: common: ssp_sensors: use iio_push_to_buffers_with_ts()
      iio: imu: st_lsm6dsx: use iio_push_to_buffers_with_ts()
      iio: imu: bmi160: use iio_push_to_buffers_with_ts()

 drivers/iio/accel/bmc150-accel-core.c              | 12 ++++-----
 drivers/iio/accel/bmc150-accel.h                   |  1 -
 drivers/iio/adc/ad4130.c                           |  5 ++--
 drivers/iio/adc/ad7766.c                           | 14 +++-------
 drivers/iio/adc/ad7887.c                           | 20 +++++---------
 drivers/iio/adc/ad799x.c                           |  9 +++----
 drivers/iio/adc/cc10001_adc.c                      | 22 +++------------
 drivers/iio/adc/hx711.c                            | 21 +++++----------
 drivers/iio/adc/mt6360-adc.c                       |  3 ++-
 drivers/iio/adc/ti-adc161s626.c                    |  3 ++-
 drivers/iio/addac/ad74413r.c                       |  5 ++--
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 24 ++++++++---------
 drivers/iio/common/scmi_sensors/scmi_iio.c         |  7 +++--
 drivers/iio/common/ssp_sensors/ssp_iio.c           | 28 ++++++-------------
 drivers/iio/gyro/fxas21002c_core.c                 | 31 ++++++++++++++--------
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |  5 ++--
 drivers/iio/gyro/mpu3050-core.c                    |  2 +-
 drivers/iio/health/afe4403.c                       | 10 +++----
 drivers/iio/health/afe4404.c                       |  9 +++----
 drivers/iio/humidity/am2315.c                      | 23 +++++++---------
 drivers/iio/humidity/hdc100x.c                     | 15 +++++------
 drivers/iio/humidity/hid-sensor-humidity.c         |  5 ++--
 drivers/iio/humidity/hts221.h                      |  2 +-
 drivers/iio/humidity/hts221_buffer.c               |  4 +--
 drivers/iio/imu/bmi160/bmi160.h                    |  7 -----
 drivers/iio/imu/bmi160/bmi160_core.c               |  6 +++--
 drivers/iio/imu/bmi270/bmi270_core.c               |  4 +--
 drivers/iio/imu/bmi323/bmi323_core.c               | 20 +++++++-------
 drivers/iio/imu/bno055/bno055.c                    |  4 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  3 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  3 ++-
 drivers/iio/imu/smi240.c                           | 13 +++------
 drivers/iio/imu/smi330/smi330_core.c               |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 17 +++++++-----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  5 ++--
 drivers/iio/light/as73211.c                        |  3 ++-
 drivers/iio/light/vcnl4035.c                       |  4 +--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 21 +++++----------
 drivers/iio/orientation/hid-sensor-incl-3d.c       |  7 ++---
 .../iio/position/hid-sensor-custom-intel-hinge.c   |  4 +--
 drivers/iio/potentiostat/lmp91000.c                | 15 ++++++-----
 drivers/iio/pressure/mprls0025pa.c                 |  4 +--
 drivers/iio/pressure/ms5611_core.c                 |  4 +--
 drivers/iio/proximity/isl29501.c                   |  3 ++-
 drivers/iio/proximity/sx9500.c                     |  4 +--
 include/linux/iio/common/cros_ec_sensors_core.h    | 18 +++++--------
 include/linux/iio/common/ssp_sensors.h             |  2 --
 47 files changed, 196 insertions(+), 258 deletions(-)
---
base-commit: c9dbe2a47f635465c9985b7af74d2ae310e98125
change-id: 20261026-iio-b9364d28fa05

Best regards,
--  
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

