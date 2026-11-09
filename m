Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218842;
	b=FJVI7PHmZhy0ZAuPTSLh4Xs688lDHrQ7VSEpBKX2X09Bt/97pAqmgWMp7DNFZ5MN74Xc
	 eOwYjY5FNdnLVvKB2pZxMaQ1mJkIK6iEZbc8sVDq6L/6KGAGFYm5XeJ5sMXKehGmgovPH
	 rfM4fvj2sBZjJfzyG+lySaCHHw43P3GWwZruaxgoFvCKOQ+sGl7KQU46Ey4vLgwIT7XjN
	 TdD5R7XC7pJ6DOjOSNbIjPWC0BekfL1ffZp0eqLele/S1qqsqXSsiqHm0QAFjx5eHCXFL
	 TSx9pzf4oF3rGHFZa0dqj6l7VEtOPYr+Xo6wbeia57WNY8kANhoE9DFqftxaTgBSfcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CjV2MobfznHWSd6tt/gdIURuRgsbs0R2Ml80INwwLeU=;
	b=MV6Orxpp4i3FpecmsazvPBcGI7Vv1et6Msr2EqI0/+HaF2RygDT9b3O0H+CtHcfHbbNy
	 516QlUsPEXnBBgKb+lLXilP2LNbgllZvJm0nqhLiIaGPD+S2WKjGHBE+WeT6VoRVZhZIS
	 oLeDVu/Vn5SZV1g4DIFk8zEVLwDSKVeb0FDLUrGKQ9DGzyu2hkXxw0HEOopIiv0kN3pkC
	 9FP91PZYZp+gZfr/yXIkXvPFkTjWKNj1ZWRcNKExQ4MlGBxyjL7UbBHcKi7l48bv/eC+6
	 Wssq5ELEL3zP01NwBW7YWOrXuBhYzDcYoo3YEh0Cg/EiR5IyLff7PxsPSmSRfTqH8Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="a9of3/qL";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SKYi8J97;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A020606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A020606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a9of3/qL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SKYi8J97
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A99v2Yd3035333
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CjV2MobfznHWSd6tt/gdIURuRgsbs0R2Ml80INwwLeU=; b=a9of3/qL/4+MO8WB
	lGHMVmTU62rb7WextgOeaYfECVNulD+JxEQXiv2o+3WOcNDeConh4zHrNfl3wtP1
	dmEnFp9YlHwyAZ40/tqS8Zkb+FYvJ/SVdmXTQH4q15PvZ/t8MYHf45rhiN1JB//c
	AJ9xFAQaPE+q29gR6sjkoBSwTyvu9b7EtbGHTDxqvTdkviR5SJ4yMPYRV2ZuwxCG
	UveAyYACnh2FZJePJhAHvhUOVNOXqWIcYv0/DjUa+tfz0eAnQTqcESlF3giJ5pOa
	+Y4BucgJ2WmW0NgK+P9xS36u43OYJZqgjm6bdT6twduSjkB5yHQyQUOBuacZlZ20
	BbSGMA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvc6nrcj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:07:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdaf3f2a58aso412669a12.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794218840; x=1794823640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjV2MobfznHWSd6tt/gdIURuRgsbs0R2Ml80INwwLeU=;
        b=SKYi8J97+2OgxoGsD780fr4IeIDgPlFJR5NTDW14l5Ay7saa+/U1gpCuwdE3WoTP65
         zebf1Qm2kEmsALB8q/mtta3rEcyUwf976yYbgp7E+WspdEuy98bAAM1bVxVjewUuT2Eq
         JNrtsc3zGPilX/U38DdnefAvvTMC9IqnbjRcalyV9msmUNf+XaHtdFItGUcibhnPtCLC
         DKGPLxPKkSJiEw1o7OeReEsMTL9WlwTTp+RescUmHVEGj5u+JO4LaD7rQohsXey4tIRM
         WTaNFTTkVbu5Rw+v8HFO8x3s59b0Vz3vmy7S8q8NjeMJIVb5DY875RvZQoUtgwr+O42F
         2MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218840; x=1794823640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjV2MobfznHWSd6tt/gdIURuRgsbs0R2Ml80INwwLeU=;
        b=fWHlA5kIhYoOMaxISji4+r4IizYztfJWtMDI5FjEpvDazCEYMcZxhJvY2j7sj87pgu
         65vGk4668XhVK98+AkBmWOWNgAyea2iIzzbxgIMWraJ6dOG9/SRaW9LhbmWKwW3D2BIe
         OPC+IIsU0M+Sg+YklmtZxJmetf8VGqz0Rx2w73OVnNfnxLKK1jdWrcX2VIqS1v6ZhwgS
         wo9O3hsW22OoIDL2suEYaD57hm3ns1f+43K+E36SFz3TK1bQltQTPVqXXtJ+L1gYVN0p
         bE/RwhsMq7vNMiIYGiEfxQepMPAuiSYikl76xJW2RfbiLWF5c1vtKYEE41jYM1A+oH+a
         KLdg==
X-Forwarded-Encrypted: i=1; AL+hErHXNMP5FU0udToUWyCoPore0DuRm+/hYU/k0QxiDt3C61oigQ3bwb6fcEVLzId12lKURkCjgx0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZGrIKeE1kABXl7udrTAmuI1ajY/fNPeJx23bGNMaxp8yySrlA
	Dw4+VTW7WIKle7y4AZqJqJQShCGvQv4+km1KTu5QGfsqp7nNbe2oBh6FObjn7WoOJdB6v7mihuu
	dmV2rvQZeB6y9LO132/SUikhmLUiPS92k48Zzv3jamvk5idrr5Y3w871vULA=
X-Gm-Gg: AYBFou0kAOQWWKVvpASVJdl6lEQO02ZJPPMyjoXwrR4mwmFARKgcnRqUZdAFaVUO5MB
	PZ4p3haVlAp1o3QTM8RxOHvfPFNpx40V1YLVK3mlLhKgLrryvBMkbSTvJNfOc3G0Fjoi/LDG+2I
	wJj62hbvt6xrSbwQgQXyF7wTEPpycrJPya6PFcp7ytEKtPhfBHYOiKNpbnVnlYSwSUmEtXRAjSk
	Jr/X0CKKHVcrZAiKkiT/mOr4r7nsVX0yP9VSrQ8c+PL0XGUWOkjY0+Fh8Gj+r757rD9MTAX+pTT
	DnZ90GsKn8ff/eEbxmBcBcErkDnCH7gTSt4xv6F69LR9DA3GVdBGfDgwimXh1XWZIJ7KrqdnAV6
	7lIkpGZ6ltlqniAawBtOQW2tqRgrHUXwo7I8z1nCFxLwGH7FmJxdc3HvPQG+6IB8N66F/BlUX2l
	eFKD7tgZmKRWbFQuIn2tnTDEfCO3vA
X-Received: by 2002:a17:90b:4c8a:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3b12d54fb2cmr2526901a91.32.1794218839548;
        Mon, 09 Nov 2026 02:07:19 -0800 (PST)
X-Received: by 2002:a17:90b:4c8a:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3b12d54fb2cmr2526877a91.32.1794218839087;
        Mon, 09 Nov 2026 02:07:19 -0800 (PST)
Received: from yli42-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm10034531a91.0.2026.11.09.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:07:18 -0800 (PST)
From: Yin Li <yin.li@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 18:05:33 +0800
Subject: [PATCH v5 1/7] arm_mpam: Fix the RIS index range check in
 mpam_ris_create_locked
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
Message-Id: <20261109-mpam-resctrl-dt-knp-support-v5-1-150335a79381@oss.qualcomm.com>
References: <20261109-mpam-resctrl-dt-knp-support-v5-0-150335a79381@oss.qualcomm.com>
In-Reply-To: <20261109-mpam-resctrl-dt-knp-support-v5-0-150335a79381@oss.qualcomm.com>
To: James Morse <james.morse@arm.com>, Rob Herring <robh@kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Ben Horgan <ben.horgan@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Gavin Shan <gshan@redhat.com>
Cc: Yin Li <yin.li@oss.qualcomm.com>, Andre Przywara <andre.przywara@arm.com>,
        Drew Fustini <fustini@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        trilok.soni@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        ganapatrao.kulkarni@oss.qualcomm.com,
        Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
        Huang Yiwei <huang.yiwei@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        devicetree@vger.kernel.org, Ping Li <leeonion.muyu@gmail.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794218813; l=1221;
 i=yin.li@oss.qualcomm.com; s=20260811; h=from:subject:message-id;
 bh=dTfzizx2O8pIWKkNOZ5/tj+tagXJPodOMUlPeZeSs18=;
 b=WY70CK6+b3HD6F8igEKO8LA8i7n1vIrZlsEcst/OXcFuilQ4b/kjdatXb+vwpsWJnrgAaH+bu
 vPCzTswnJ9zAht0xJL7Sy2MaO2ckK12jMWNndpRwzyY4PojyLFaYyPH
X-Developer-Key: i=yin.li@oss.qualcomm.com; a=ed25519;
 pk=e/2LM97aSWGBMrxY240URBi9Zi8/kL5hXgB+VHkYvW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfX9aK0+gIBpk6T
 slnaMatPgUB+2cwCnc81W0oLijEaQtlMtg/wH/lkRdGudQkKjA5a5vQwpXfzjhfKqYqvHmI+n86
 QoRvTuGdDUmGEAyhNTaNfajkpG49PiZ1SqeKJ/j5oSEmYFbznNEXRMHz37Y0/BsVvlln5tILUXn
 W8PJyMrNZ4kG80RolJGBUHSfBKtJ18krqWOAPnVTyVziT2Gmz/feEeVdgqGOt83+JrbnfRQq6PS
 Aj9I+2S2CXhO17n9SQbEFdUYk/wMhqWhad6HeVejLYu1iIlZQJAgfFihbpB7PJtHVbhtBPtmbwy
 fAdQvqGGiLSiYckZDymjef9OaDvk00vbj9LggcKWuLfEluL88RsYpXoDaYuJpC8sgvcEiRI3M4J
 WqBXcoq4zDGAafCqemadekGuuXmbXdgUHgqiUggOk49elTfF8yMyE/SXPQ84lDV6LxssxYTh+dn
 AzHS8rS92zCneYHI71Q==
X-Authority-Analysis: v=2.4 cv=WOjqzXsR c=1 sm=1 tr=0 ts=6af19b58 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=cxiLKowE09Ysm4E8lmYA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfX5fzao0urDVHV
 A6maQRUdaZkZTmRWsT3RWQ7uKZMSlx+tSl0uTxQRbVdAt5Z4J1hTMKm25sdSUkSIjR3mJz6Vfwf
 Uz5jJyvOo3ICokZ/R94Wg+6wcffh7K8=
X-Proofpoint-ORIG-GUID: V1-ucaZu62F9GUBzcgNzp9-8216IEb9i
X-Proofpoint-GUID: V1-ucaZu62F9GUBzcgNzp9-8216IEb9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090040

The RIS selector field is defined as MPAMCFG_PART_SEL_RIS (bits 27:24),
which is 4 bits wide and gives valid indices 0..15. MPAM_MSC_MAX_NUM_RIS
is defined as 16, so the check should use >= to reject index 16 and
above. The previous > check incorrectly accepted index 16 as valid.

Fixes: 01fb4b822472 ("arm_mpam: Add the class and component structures for firmware described ris")
Cc: stable@vger.kernel.org
Signed-off-by: Yin Li <yin.li@oss.qualcomm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
---
 drivers/resctrl/mpam_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index c067b6d57d71..05f785328dc2 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -700,7 +700,7 @@ static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
 
 	lockdep_assert_held(&mpam_list_lock);
 
-	if (ris_idx > MPAM_MSC_MAX_NUM_RIS)
+	if (ris_idx >= MPAM_MSC_MAX_NUM_RIS)
 		return -EINVAL;
 
 	if (test_and_set_bit(ris_idx, &msc->ris_idxs))

-- 
2.34.1

