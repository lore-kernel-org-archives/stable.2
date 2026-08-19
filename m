Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8323D5C06
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124234; cv=none; b=QGxyrQe9CcA64oFPk22DdpemLp/2LJo+nnqNHOkAnJ8EzBg2Dxk0+xRiUE1ZaSQNoBGdTQBQDCSncK+e9I0Nssey2ylf8yWnSJGzQhFGK+hjo0RpybKMECtQ2bkRMlndHRG/WpdJUGoOJbkDf3eFjZD7YXDN/JjIKQsCyOemENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124234; c=relaxed/simple;
	bh=pDEyC8yg/6PuLQPU3KAOde5jSjKdXzhA+xDS/oZrXQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qs5/K983wgRZtyfL/FojUuQTKalvC+EKTWVu+4IdjZe7Ax9xvyMMhLQkkJ82H2RCohw5XGerCE9ejMszXortkq8LldD15W6Ic5MoZOvtEW2NOOe5nBHPDZ8JtmuP9DoKrYqRgrzuODXYTLJ6TJEbtA8zVootPqspobJmK8kYHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J8yD4lUM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E4aOuZA/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J8yD4lUM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E4aOuZA/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6ZTPe3240964
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=as6Mr7PNRNvWHpLUhs1CPs
	1ku7dFM3XvF7EJEYN0mUs=; b=J8yD4lUME+ttkvvAOQV5fIoFv2l8NeyojkHBHB
	b4MrBB8BrUlEsB5NxfMKq8obTCK37r4rQQ5tcCXKU1glAGav3pYWEx9EdTJIQtHc
	aH20mIxXj5NGVjFEh5FUlqq+UM2KUm3w2ym6ZehdXqired9JDiwtzLl9gF3NKnRg
	fc0Xq6NmuN5eV43K1wd6ykz1UharDnZ8T+J53FgzOEYkh9z2WlgKyw+Los4XfrYH
	lnr42H8QsvyAPi4dpKuHJN1TARncPitQbckAcsVO8JRirjlRuCwuaQ/pfw1Bueno
	+0bD2sr/PwGiaiGUzTbnpM2yev3dOi/TEBiycIXRcpjSjJHg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm9wt6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:23:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930b6bdcb4fso104160085a.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 00:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787124231; x=1787729031; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=as6Mr7PNRNvWHpLUhs1CPs1ku7dFM3XvF7EJEYN0mUs=;
        b=E4aOuZA/EUMSjYdgc1FbDZMcj/hl8SJx+68XrUsUfJ4+6iEt66mVewDq7dUziZOzgd
         EcB8TXJjWcZNQzlK8vU3703Oap0AkN4ICXvHIxrfamF/VFM5z678n2NyQwCiYupQq0Np
         1yjzHJ4ntx9mRSS/FZJb6Gdxi78ClB1+hLWbOQCAqBQhcjUai8Gle20TReH6Kdj4Cgle
         FwaV1bmMJMLOcMX2ECFCY2k3PrS4g+LVdXJ9FAoC+S6/kdaM5guS3Xj0qsNyycL5+HZD
         NSIMG4NAhlKQ6DxoEdfv5xBOEXHQ45yeCvU6rdK3/EK/J7z7UIlojAiczIE+g8k6Q2Yd
         ImdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787124231; x=1787729031;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=as6Mr7PNRNvWHpLUhs1CPs1ku7dFM3XvF7EJEYN0mUs=;
        b=mcO7D2uNn6Dn8bd0SSwNxhckIPlrTtlhsvnHohP0dYVrfAvSmWXKR4Iit8qXrJGfft
         gtF9tOely3pnaKIKzSBn5EW6zgsN+MyqqWfKD76QExpnGAnLaPThSWmJbUdX39G51mgH
         o13LNDx3rs49M0/qd8aQoSVklxlGbXYMQrHTO6u7TLSjCPHFr9EwcxDtgHTSG9qR/ops
         j5cC25QUFcKkgeMmTqJ2SwCvTKm4TNiw/T0WQHx8AOHs7qhJqwUf6CXVfJAhf8oJMp7Q
         oYFDZ8+l88NxCHyNsp/NOKlOUduiH5WZwaLdVN3ysoUkCS/1HlF7JxNIs1quzcNb3JTo
         astg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7IUAAVdS7LScYW5FF6LUrKf0XLvQNmQDQzHei/cxPOp/FitWZqQoy8ZIsR/CGjg9R1nOwZPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC37JluKa2TdhcCS7I7Xsfx3S3MRaUdqyo/36h7QGZvkm/Wd/s
	Y1+npOYeoc1ldid6tYIlYWGAz+0WWPil2s9TVC7Yv9D+Atj5pZyd+4SAxn5QW5oXwYrTnZFGXr+
	8w7HoCr3THifwS8EBifU8Q6UQT9hVlrsfGEkvIs/LoL/EXDu+nhphP4zMaYc=
X-Gm-Gg: AR+sD11JB2v6rt/zDy9Z4yRwPJqir2/Qq0+771+nTF82Okuzd6+nli3ET/e9lzLBZ7H
	qYzz5kDSV0gD5p3HZkdfrimHLJ7qY0wMCE7hawy7UL3zyxvSLkUoN0GAQUw/u61CWQBC35NtLwI
	dQffVwRayUDmwBXCQPvgJOlRWKjHTCkYU/zVeKT19C/wgXNh7ho2hW+SO0TNLhCF59In9LYSMTs
	Rtij7XqXhgt/scqm8zj+gxht66uTT7VDrhInggqHdtqzFZmdrYWRXECqerIPxJHnl3xrhzmGOfM
	fItDoK2rPhB0EiZ++MayAs05YrfnCUI0UBqB1BR6+tMcxP2mu6goNe0RTcj/xSTar8WPKfVINeY
	tXo9AKQPX
X-Received: by 2002:a05:620a:2590:b0:936:ea0d:ffc3 with SMTP id af79cd13be357-9371e2e6e9bmr235779285a.22.1787124230997;
        Wed, 19 Aug 2026 00:23:50 -0700 (PDT)
X-Received: by 2002:a05:620a:2590:b0:936:ea0d:ffc3 with SMTP id af79cd13be357-9371e2e6e9bmr235776785a.22.1787124230379;
        Wed, 19 Aug 2026 00:23:50 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9dff4c1sm30155695e9.3.2026.08.19.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:23:49 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 10:23:28 +0300
Subject: [PATCH v3] soc: qcom: pmic_glink: Fix device access from worker
 during suspend
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-b4-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v3-1-169b00e0d9d4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAO9ZhWoC/yWOQQ6CMBAAv0L27CZQkIhfMR5gu8AKtNAVMSH83
 arHOUxmdlAOwgrXZIfAL1HxLkJ+SoD62nWMYiODSU2ZXrIKmwLVEy7kJ5wnIexGcQO28kYbfWK
 siVgVvcPNh4EDbr2MjLrqzM6yxepcF63JuCxzAzE0B476b+J2/7OuzYPp+S3DcXwAOl9St6YAA
 AA=
X-Change-ID: 20260819-b4-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-95a4f21e6632
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        stable@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5200;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=HeQpy8inBozBcb45Bnj54ZLHMUDA77B/OCwmkkTxCEk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqhVoCPscWPALk4ZzqGC3K7Fj55ezvXO22xJcSi
 2Omj268KwGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaoVaAgAKCRAbX0TJAJUV
 Vs0iEADAvLOzIocBkBFLtMofop/V/RDIUyCEGHVRwJXpRNwWSRY2j4jqG0bD7taQ9TkMs3Dav9k
 brbY3dHWziUG/pZruAoCTc9E0Plf3rwpwZ92OoeVOFxR36JVixiXrL1v1fBzhQnXIOyPVO8d8Ue
 Nyc7UV3qcYsd3IUNc01WmhZ0o98uQFRoLdqpe3zYpmFgaEgCRkn+ITRDZxJNIXRCBLOhE7IjcyH
 G7d6jvaDwpOBV568Di26uibwjZHnlMcak6eFTmAuMeXjXJegBRvFnj0KDuyTaLiEuUEFpadBYnc
 Uk45mb1nwKO8n5uFMObeBMi9sZ7+1kLEWh1aM8raeilRjj4xqJI7QUg5PWNcdoExBPN2tsaomVE
 GH4/ENjW+NYBR7RhoiBteR3pffi8nxL5rxZzbEod13qNVXVNMNbBWmXW4T03fCRdb9l2LvTo++m
 E6wV4rWhzmvTG6MQd8vHbC4uYZsOiBD5W+MIuW9TtMl5vGw8TeMoEl2/DP0AR7bikgvAU6gzYUr
 /PxAYxQLm3suw5GwOjF5QydYEgYppMwKfasnszgy3uH0cOgFweb6EGMXD3aqj1M3t0TUVKkTbYI
 Aw+ZLwao6xFFpkW0Ahx1H99VaLuKJqZvyCyelvYxSSAuvxJlkieHnM+42lZ7fj8m9X4zJf+J/DS
 X0NlVyMoOHmTMgg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA1NCBTYWx0ZWRfXxe6YwF/M7gXN
 HGmlqQjhSu7e0AzD3E/GQWi72tuKzqmeyCZReOSjeV6dPxo0R5+2cfINsvijVe/dJow3xRARx00
 P2E7aCSntWShMLg53bNAoz/6x3JjU+pPocJgYcJFtZT9NQKr83gJidrRF/WKg9D6fz7c0KE+naf
 v6c4BuIEj7lrroHwo3jWjSaqayK/w7sSFVPFPtb0hU9E9M1vkKNFTC6iidNs5k6SXTOYqOv0Prc
 xO7J7HMMxlH46gTmsLhTdfzOhJqI1XaUYVkP58hvhM38hQ7fAGCQ25kemPru9Au2vsck0EhZ3tb
 gJHZ0a/qAWi8jwlEiljLTLx0Cccrg2zoXFsJjU6lyWg36PLORqPvTm6bYwEb0wzspr0j3jxy3JU
 jpijq7LU19TiR7tiwwbim4QryVSBi8OmlsPN6FLlwYuPEHEfY3kx36uk13dAA08ASJp30hsZVFe
 SWrPw0IwjJlj6xGSREA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA1NCBTYWx0ZWRfX3Jwdm310s5+c
 nly5ToShFVd7k1Os5kzFJqp/L/pWD0bkh/skKBDaMPAQgAKGDYQ9gTMwU1bbAhd242RgPWeVSNr
 +dmraFhVQD4Za5gFfZRCJKsF3J3Fxxs=
X-Proofpoint-GUID: _Nl6JeGwkC1qvnaHaP347tpd0OqHb2yw
X-Proofpoint-ORIG-GUID: _Nl6JeGwkC1qvnaHaP347tpd0OqHb2yw
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a855a08 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wcTf6FotWcWifOkf-SoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=xwnAI6pc5liRhupp6brZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190054

From: Abel Vesa <abel.vesa@linaro.org>

For historical reasons, the GLINK smem interrupt is registered with
IRRQF_NO_SUSPEND flag set, which is the underlying problem here, since the
incoming messages can be delivered during late suspend and early
resume.

In this specific case, the pmic_glink_altmode_worker() currently gets
scheduled on the system_wq which can be scheduled to run while devices
are still suspended. This proves to be a problem when a Type-C retimer,
switch or mux that is controlled over a bus like I2C, because the I2C
controller is suspended.

This has been proven to be the case on the X Elite boards where such
retimers (ParadeTech PS8830) are used in order to handle Type-C
orientation and altmode configuration. The following warning is thrown:

[   35.134876] i2c i2c-4: Transfer while suspended
[   35.143865] WARNING: CPU: 0 PID: 99 at drivers/i2c/i2c-core.h:56 __i2c_transfer+0xb4/0x57c [i2c_core]
[   35.352879] Workqueue: events pmic_glink_altmode_worker [pmic_glink_altmode]
[   35.360179] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   35.455242] Call trace:
[   35.457826]  __i2c_transfer+0xb4/0x57c [i2c_core] (P)
[   35.463086]  i2c_transfer+0x98/0xf0 [i2c_core]
[   35.467713]  i2c_transfer_buffer_flags+0x54/0x88 [i2c_core]
[   35.473502]  regmap_i2c_write+0x20/0x48 [regmap_i2c]
[   35.478659]  _regmap_raw_write_impl+0x780/0x944
[   35.483401]  _regmap_bus_raw_write+0x60/0x7c
[   35.487848]  _regmap_write+0x134/0x184
[   35.491773]  regmap_write+0x54/0x78
[   35.495418]  ps883x_set+0x58/0xec [ps883x]
[   35.499688]  ps883x_sw_set+0x60/0x84 [ps883x]
[   35.504223]  typec_switch_set+0x48/0x74 [typec]
[   35.508952]  pmic_glink_altmode_worker+0x44/0x1fc [pmic_glink_altmode]
[   35.515712]  process_scheduled_works+0x1a0/0x2d0
[   35.520525]  worker_thread+0x2a8/0x3c8
[   35.524449]  kthread+0xfc/0x184
[   35.527749]  ret_from_fork+0x10/0x20

The proper solution here should be to not deliver these kind of messages
during system suspend at all, or at least make it configurable per glink
client. But simply dropping the IRQF_NO_SUSPEND flag entirely will break
other clients. The final shape of the rework of the pmic glink driver in
order to fulfill both the filtering of the messages that need to be able
to wake-up the system and the queueing of these messages until the system
has properly resumed is still being discussed and it is planned as a
future effort.

Meanwhile, the stop-gap fix here is to schedule the pmic glink altmode
worker on the system_freezable_wq instead of the system_wq. This will
result in the altmode worker not being scheduled to run until the
devices are resumed first, which will give the controllers like I2C a
chance to resume before the transfer is requested.

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/Z1CCVjEZMQ6hJ-wK@hovoldconsulting.com/
Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Cc: stable@vger.kernel.org    # 6.3
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Reviving this old patch since it is still an unsolved problem and the
conversation about it stopped. The hope was that this would be fixed
in some other way, but none of the solutions discussed off-list seemed
to surface. So maybe this can be merged as a stop-gap for now.

I've been running with this patch (and the ucsi generic one) on my Hamoa
laptop ever since and the USB plug/unplug during suspend issue has went
away for good.

I intend respin the UCSI generic patch as well.

Changes in v3:
- Rebased on next-20260818.
- Picked up Bjorn's R-b tag.
- Dropped the RFC prefix, sent as proper patch.
- Link to v2: https://lore.kernel.org/all/20250129-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v2-1-de2a3eca514e@linaro.org/
---
 drivers/soc/qcom/pmic_glink_altmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 13c434f8d03a..465e5d2316a0 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -451,7 +451,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
 	alt_port->mode = mode;
 	alt_port->hpd_state = hpd_state;
 	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 #define SC8280XP_DPAM_MASK	0x3f
@@ -502,7 +502,7 @@ static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmod
 		alt_port->tbt_data = *tbt;
 	}
 
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)

---
base-commit: 5453bc3279e9f8578ac3e534d476240e40c879e1
change-id: 20260819-b4-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-95a4f21e6632

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

