Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793997120;
	b=gRstPPQFOfiOXPwXvgZ9E6uEaDSJR7e1J/XfXEMRCHVv0cKEJF3hrOtnSlvRC95qH/q1
	 OpVz0fkn0BkFXS8Gqc171+zVBMujNCQUumyoOpfNH5HP9TfnG6811ppAkmOrWJuahcbwt
	 Ahfp42CNuF9Y42h9UFpeV2qA4mEII9qbii/8nrdQhtLKTxr28oxl1zcuC+tNSeAb71xCl
	 yioa3wHwvaj1b+FFgSrHV07ig4Hh6bnPymTUFlxUGSD1tIoZHoJpQbfbxCB8CcqR9RdXI
	 LcfuUDERobjKqnLcukP6yvvAu4VY55CUq+CP3wgsruGlXhOj4H/BQ+sWo+b/+kn8dEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997120;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=oOHMhpn1kGe3VlQcJ3A9W7pwnzxIoh+dezOOgYH0//s=;
	b=2hg41XbSGBIPG+p1Y5tHAXtdVAV0pOlYEHgW+KRAwuWf+hhL5HbkjnwEbERuHWLBQwx5
	 4UsQPc8RBjpu+792lRwZ2vnHkleajEoaTkmXXBVol4iUUirD5g+n34iCBA8pBcXZXoW7S
	 S0BKt6g1Nz+Sw8iq/QZk2qDFZGA8X391FZFmJVgz0eN51USl+sAzzsDomM4BbYFECzf47
	 Z/2kuhPLZGzqj2qgmIEVVhOHLU9CPF+MxjftP3aP3VsBcp2JWv/ReRLvV7Spj6XkS4jiB
	 sCN4fXL2B2MP+xp0OOc+1gThbXE9Oil25pHf2d0MY3Sqt1RmGZo+H5UpAVTpIhHGscQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7UQ+2Md;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366DF606A329;
	Fri,  6 Nov 2026 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7UQ+2Md
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793997119;
	b=lyrjqHySRI4bXd4v1d1WM6XVCdNaHFtqpxYuPNy07v972EljjqfCjBvxwMPXf1ittdS4
	 M5MzbVPOyevdh+6g9zFVx50N+Oilih+10+Skx+1/KMOv551NOK3JHiqhZa9YMfUxAmzOp
	 C38x73dcXCZnPbxzZ2OXOwQLu7pfqUUJuGn1+UXpUCrDI/0hNUExxxK4EelzGNuN35upe
	 ulkWJW09KTplYov15IfOK6SIeyWD5ULrMi63A8zMON0H8yTDPt+L6siIrgVt/Jmv3frfd
	 lquqA8abyLSW7tN0OD707wsaomu8yDkfL6EuZ4QoXKMDjzR97q5vbDsAkgGXkbMeItQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793997119;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=oOHMhpn1kGe3VlQcJ3A9W7pwnzxIoh+dezOOgYH0//s=;
	b=M9/nYBmwVYuerha4msZ0457XILCh5NjjHuRPer33UFf/bwn2hSezDcMlO3YgdHCXH+fL
	 L8xXXoPKVanWGPBAUr/EUt/nBRJr3oUQLXmmKsIPqHGlRxrkHhW8QapV+S8RaHSTRxBlC
	 IDiy5r1PaOOOk4sFrjBI8KeuDkZ7zHkj81Zj0qlMUxuSiecvQdrGeRVe1nTzMxUzl8Uox
	 mqlY0r8Q1M5bF8dfmHe4DU2lrPcDvRFQ0mH1TRdZq4t0g4wCPZP7uHqFVTXBszpB9YU22
	 uPnz/Br+7p++6xuponNpB3fNaAP+VEQc6PjZHatfPVVzKGQ7ZBmsKFDP8AuQKm7Z+gQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2EAA71F0089F;
	Fri,  6 Nov 2026 20:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997119;
	bh=oOHMhpn1kGe3VlQcJ3A9W7pwnzxIoh+dezOOgYH0//s=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=l7UQ+2MdRxjPexwRWXMptb7lRpWGAqvgFj4hWXIX+EN4r4Korr73C0JOgvVeziGYi
	 PmBUM1eLbwk1RHGD6pSUugZVQvMXZsLAW1GnSUJcIBnxi8qSon4hsX5iM60d4uVhF3
	 s7YRhcRu6sujyMabH4kDhPWL0j9NoZesPa9P534X5+JAL58bI2TraoK/8L3YUblQ4A
	 t/M8s8Y51IrrtH0Aq9vOK1mvD2ezMZTQWBBw9J3DFv6nkQcPVcqWuIKLo0XFafz50R
	 fxeN0Tn1Ob+GiAEthxNdT+s5nrqz/UKyBgjCN+wYSRw5WtyrSE2Ds27i+4r/VYqlKN
	 jX0Fukqvva7ag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B31334786F;
	Fri,  6 Nov 2026 20:31:58 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Subject: [PATCH 0/2] thermal: tegra: Fix SOC_THERM temperatures on Tegra114
Date: Fri, 06 Nov 2026 21:31:54 +0100
Message-Id: <20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CQAxA4auQrm1CBx0yXsW4gKFCSfhJOxgSw
 t0ddfkt3jvAWIUN7sUBym8xWeYMuhQQh2buGaXLBlc6T6WrcFstKTcT2hLTwDphIrpiuAWKvq3
 r0HnI8ar8kv03fjz/tq0dOabvDc7zA9qsbfJ6AAAA
X-Change-ID: 20261023-upstream-soctherm-t114-9591c6b779d6
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793997117; l=3648;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=m929wZ0aCncaA6g4wkYgu+Bj9JMpo6dWskQPUoPSN2E=;
 b=xtP2fQjeUtnSoV0Y2B87u7WaClmxukXQDyJN/UzYWkJuDbTAKjEQ5+GNSj34QJY2FmjwXXeJG
 i9k7pnoV2GLBnhnRH3xHbSPAH+lnEpHGYW72sGn+XdBjZRFGtLjtZfM
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de

On the NVIDIA Tegra Note 7 (Tegra114) all four SOC_THERM zones read 0 C
with mainline, in idle and under load, so throttling and thermtrip have
no effect on this SoC. There are two separate causes:

1. tegra_calc_shared_calib() sign-extends the whole fuse word instead of
   the SHIFT_CP field. On Tegra114, where SHIFT_CP is not in the low
   bits, this distorts the calibration of every sensor.

2. The hardware calculates THERMA * capture in 24 bits and discards the
   result above 2^24 (TCALC_OVER set, TEMP_VALID cleared). With the
   calibration in 0.5 C units a Tegra114 sensor is only valid for
   T < (2048 + THERMB) / 2, which is far below the thermtrip
   temperature. Patch 2 switches Tegra114 to 1 C units, as the
   downstream driver does. The fuse calibration stays in 0.5 C units,
   as discussed in the review of the Tegra114 series [1].

Patch 1 is Svyatoslav's fix, unchanged apart from the Fixes and stable
tags and a sentence on why the other SoCs are not affected. Without
patch 2 it gives three zones that work only up to about 45-53 C on this
device.

Zone temperatures on a Tegra Note 7 (P1640) in C, idle / after 60 s of
load on all four cores:

               mainline   patch 1      patches 1+2
  cpu           0 / 0     41.5 / 55.5*   43 / 63
  gpu           0 / 0      0   / 0       39 / 55
  pllx          0 / 0     44   / 52.5*   43 / 62
  mem           0 / 0     39   / 50.5    39 / 53
  thermistor      -       34   / 39      34 / 42

  * the sensors behind the zone were already invalid, the zone stayed
    below the real temperature

"thermistor" is the board thermistor on the PMIC GPADC, as a
reference. With both patches all eight sensors stay valid and thermtrip,
throttle and trip thresholds are programmed as 102, 100 and 90 C.

Tested with v7.3 on the Tegra Note 7 P1640 (me) and P1988 (Svyatoslav,
all four zones work; tags to follow from him on the list). The series
is unchanged on top of thermal/linux-next, but only build tested there.
Thermtrip and the hardware throttle were not provoked on purpose, the
highest temperature seen was 98 C. Suspend/resume was not tested.

The series is independent of "thermal/drivers/tegra/soctherm: Program
throttrip with hot trip temperature" [2], which is still pending; they
apply in either order.

Tool use (see Documentation/process/generated-content.rst): patch 2,
its changelog and this cover letter were prepared with an LLM coding
assistant (Claude Code). It evaluated the SOC_THERM register dumps from
the device, recalculated the calibration from the fuse values, wrote
the code change and drafted the texts from my measurements and
instructions. I reviewed the change and ran all tests on the device.
Patch 1 is Svyatoslav's own work.

[1] https://lore.kernel.org/all/22816196.EfDdHjke4D@senjougahara/
[2] https://lore.kernel.org/all/20261020-upstream-soctherm-throttrip-v1-1-c67f8a02ec3b@tsv-stahl-riesa.de/

---
Patrick Fischer (1):
      thermal/drivers/tegra: Avoid SOC_THERM calculation overflow on Tegra114

Svyatoslav Ryhel (1):
      thermal: tegra: soctherm-fuse: Fix shifted_cp extension

 drivers/thermal/tegra/soctherm-fuse.c     | 17 +++++++++++++----
 drivers/thermal/tegra/soctherm.c          | 21 +++++++++++++--------
 drivers/thermal/tegra/soctherm.h          |  6 ++++++
 drivers/thermal/tegra/tegra114-soctherm.c |  4 +++-
 4 files changed, 35 insertions(+), 13 deletions(-)
---
base-commit: 32cb06b34701827db0ff34244d84fc74e40ca350
change-id: 20261023-upstream-soctherm-t114-9591c6b779d6

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


