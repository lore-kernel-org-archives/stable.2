Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218851;
	b=gEbNmXklu9nj4ZoFVK3RuvCTAgOw/mqTRN6cTpnk2lQT7RLQ5cWm/q3VDAbOnwz03sAg
	 LhCWl4DsYU94Uy57mx1Y0Wool8Yut/wop8d8hgBbuH0mDFIkzWlXObODB+eVozhKzae/5
	 4iNDHinvPwcTk816yQfRncubewZVeKn9lvDjBNx2GkrqadpRswQfk9nzVEBJq2fULeWX/
	 NWITPVcqP1+nxtLxEJWAcZuTrpv54rrR6NxyK0rsO2NpkohVB+72tiXaefa4zI+GaayjK
	 VHLn3dpt8p1Yspm2+Jf0KHBXCh3xbG/+IllyybwVXDt65bL90kXbJVyVLi/2j6rjCtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218851;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AjrhCINlUbKIbvCUMy8NACyvmSbvDdLn5Ljj7rMFcZY=;
	b=BW18NtulvPKD1IEHZq6QHsn+jVjL3V40TkvnCIh3dUR1ygjxI6RCNJWSIuLlJ12Xiu7M
	 F5ldcWVxMMJ1VzhOcu9EnMk8AUxSN0vgeL3Xy/5sCTC7en0wUVrdYEojFC5Ycf3Acnw8D
	 KsOwqVelJlKPC844l6WFuwG+X3U/C5fMxaclNnkKc30cHJodwjayqtQ3UhkbEn+KbL+aB
	 XEuzBIY1FgMLnKOWTkWrT6d/Um7XilpBa8C8+X51P1gQj9sxwIotmHbKiYhtfzBd6IkjJ
	 6uvECdn/LbwHrz47gjMYix5pvQBtcLqeBe6aeoSE4DpqdQKW1gWfg/3q648qswfGy6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qb863sBI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=diHyuIW4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16572606D81F
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16572606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qb863sBI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=diHyuIW4
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A99unPi4077628
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AjrhCINlUbKIbvCUMy8NACyvmSbvDdLn5Ljj7rMFcZY=; b=Qb863sBIHPMRDAn0
	hes8I7xH7m4yMwSRxsNLe/4HAEiM+QtaDNVayXp9m0sO1myCv43xXTfSyHo0UfZ6
	XOgdTP9+inmJQdkuOan2FHy+EW3bo+ccojW+OIiW/UjB2oLXXPFJ1KRChj9WRS9a
	4ZvldPqTgTLeLnHnojOY+PTMFnMVBu0VAOa1mVf4jDlB7CxQAKGlY+DsFlnjfXgx
	mgzko6BcUp844bHQwbRmDDfNVTVXeaEsBh0skLlXH+tJuhYtIPa9c2e2QH81h/dO
	c8zFafIkUW4TZ+0h1HZ7sz/K8r0P52vsI7LXpuqxjTMSTzwHJOEN0ZGCGAiXSimf
	qyP1SQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsv735s1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:07:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so620955a91.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794218849; x=1794823649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AjrhCINlUbKIbvCUMy8NACyvmSbvDdLn5Ljj7rMFcZY=;
        b=diHyuIW4x2u7X8upjj5uTywyfsgc0XCeivLftd47HHXlBapYMrm0PHpD6Kci/XQnLT
         E/gsVMwjotuF92x/CTFuQKSqazjWxULXOKTOtC3Z5hCUsH24VbcTMknTplyyfwiUnaoc
         9NjrMIxUARFKin4tIF1qo4exI0Y2LaxrCPqJ27J65Nwg1kdo+hcdYIzAO2xbjbpyhAfz
         lCr9uhhxuF+sNM/TFiq+DTrWPEGZiZvP9Tr8L0ta9bF899YA6x1GL/84gH2mnXGN2Z2k
         R1mmW4lHuqsmAYovVQ13TUoNBldD6oNKgkiybYTZ2AEnn49S3goGkA4fiR3Lj55Lm1IS
         n1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218849; x=1794823649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AjrhCINlUbKIbvCUMy8NACyvmSbvDdLn5Ljj7rMFcZY=;
        b=W9VfqxfHWDfQ8izsORPPU3kdD91seCMGr6m/b5wB9BdexleV3r3UClREqYrfzumBbb
         U0diNXnEvASXwkwo+qnr3CqJj2apg565DxV+8Cai3a2NyUtiHaaLyagqzYztfkgAf8uo
         ZxPux0jvCxIOUwxRdlGMuqWfNc3GF/TFzmRKtIEFAqz8A8CrS8loURhryuip2UMw6Baa
         W4M0so69U/UvimhdUQY1myWuBqF47xBQng4xSZcAWqauxVrzjyap19jChqSbvIR6D5U5
         UtXq/IQX0NvcnhgS4jgGY7p2FaV0ZxaBS2r6gtBiiMvsbeI7FNRi21F4REkt7xVOiB1Q
         +MZQ==
X-Forwarded-Encrypted: i=1; AL+hErEynenUYw+I5poWFTXdKDwDkKSEnU6vm1UmrWOnrKrsje8zg0k88/2JQXrezuPxpHDR3M03PNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tUMnHNzSSBMM1oxtlBo11I+xJfyp36rEMC+m66D3TvZxxuWFY
	7+HSVankEFaQ6QGwcZYRfmbUEkNrVGsfyrJyGt4lGb/iazl8UtseLGNqCbOWuALC7ncClS8q4mi
	luH/NCmB8EUqMt8MYinP0bkxWHAvg85JYvwm+rP4CZC7ADy6HWeVi3upZ3Pk=
X-Gm-Gg: AYBFou3qTss8V+JtHl30MJ2voiAPB8M/xKoB6svcznwLEiIOPLkunbasKomFc2BpC+G
	Qeep6PL5SurvnaYEwxCCFQ5LpMCIRW7XfQx2iUauwb+nbSbYAi4F74jslVa06LTEF0L8xPHIqXq
	jXCa+Tg82eXz3Ibv0K4tL7I+j3BfqnWePvVsSCF+f9RtsBqfcZnnlAEsX87xhB9di2GIxQWVkuj
	tVd9OU9Xdp9634zjFZolm4ng/24yNfCOdbe4ev0kxaXk2bn/qqg+sTmENGIgWomZ8Mm1VWgOGNN
	zckYjYeq9MRCQnctxNfCDLrlNCRbfKlY1vJzMR2cimE/m9XNB72U9GnCsc7GD47Kp/Ue6F7fgYv
	ekRtLGraMK3duap9GH87z3TfOTxJIWvfrlMc42OTq3HiBQ9boVJknpLF4324bLfK4U516Jmm1eN
	161qKY81fVKOuYiOcOTxWPwTuDHiaG
X-Received: by 2002:a17:90b:53cb:b0:3ab:5758:3757 with SMTP id 98e67ed59e1d1-3b12d5ef7f7mr3152483a91.61.1794218849194;
        Mon, 09 Nov 2026 02:07:29 -0800 (PST)
X-Received: by 2002:a17:90b:53cb:b0:3ab:5758:3757 with SMTP id 98e67ed59e1d1-3b12d5ef7f7mr3152416a91.61.1794218848687;
        Mon, 09 Nov 2026 02:07:28 -0800 (PST)
Received: from yli42-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm10034531a91.0.2026.11.09.02.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:07:27 -0800 (PST)
From: Yin Li <yin.li@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 18:05:34 +0800
Subject: [PATCH v5 2/7] arm_mpam: Fix MSC MMIO window size off-by-one with
 resource_size()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261109-mpam-resctrl-dt-knp-support-v5-2-150335a79381@oss.qualcomm.com>
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
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794218815; l=1979;
 i=yin.li@oss.qualcomm.com; s=20260811; h=from:subject:message-id;
 bh=M5HKKySRXJjebPuf/KLcSrGcy+Dr1wAQmzTykz+vO0Q=;
 b=Q4QHKXfPyNxTfeRfp19balrlzMk5OdUU4eKG1aMyyqKAydxt1uebl+7SdXXRpbAEmQKQ5kN5Z
 6b+fSzkJixxCQwVFnssHT0MQsX9Umf3yTmY82A8IiSaPn1rVqaz8JAS
X-Developer-Key: i=yin.li@oss.qualcomm.com; a=ed25519;
 pk=e/2LM97aSWGBMrxY240URBi9Zi8/kL5hXgB+VHkYvW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfX5u94AkCginL4
 pfI9MzTT9rfHn44b+Z2cB1zz43Xuhb17qKYOZqfWJ728Pbt4QMQu7pxMrI8wTP1rpDR0gIj27G3
 RU/hi9cGrx5Nnym3hgbEyx8PQ2qAdzhFqt9ypTjBEQrlJN+Qu1SeQ7NN3m2r7KXTJOCG9R7C8xx
 a/gqvqRwEcTNjeZv725HTn2/cCpzhIo5qsFeYcTXD2dFWcy4LLjgocKWyheR1AiCI7tnmL3i2O9
 tI9jlMPpSfcZ0T895U4TE+DsJXV82rZa8qRkpwt1V5fq7fHoShTRnzO+OmeGy1F+1jnpZkh6RiW
 TogcW87zCXgVNgMb1N0KQuxtSJgnOEDbrd9PHZiDobr4Bp6CeCAUnb5iQJteSnG/Een9qWDjQpJ
 EjcaukGRcXsUZ8QqemVBMxz+E3rjVx/4pgf59cmx2OtSEdGrrpKGp736SSJA2PcP/LdLefg2T7Y
 ugBncMFGZeVVcjTIj+Q==
X-Proofpoint-ORIG-GUID: aKUsPaHTnxSgCkRgEJ673pVK2C4D0eoS
X-Authority-Analysis: v=2.4 cv=bcb+w+PB c=1 sm=1 tr=0 ts=6af19b61 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=i0EeH86SAAAA:8 a=s3E7sL18FQBPR4dFS-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfX3X6hN3/0FBM6
 qB/PAZijho4GIEu9QgysXhx2Igt2WcAOGcK6nSFn+IdvRlijSXH4PWQkFa3CeY5WaobHDU0ktGw
 VxM0utV11Vv9kjFwukPNgnJcCYlSEEg=
X-Proofpoint-GUID: aKUsPaHTnxSgCkRgEJ673pVK2C4D0eoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090040

struct resource uses an inclusive end address, so the window size is
end - start + 1. do_mpam_msc_drv_probe() computed it as end - start,
which is one byte too small.

mapped_hwpage_sz is used by the register access bounds checks, which
have the form "offset + width > mapped_hwpage_sz". With the size one
byte too small, an access to the last register in the window is
incorrectly flagged as out of bounds: for a 0x1000 window, a 4-byte
access at offset 0xFFC (bytes 0xFFC..0xFFF, legal) computes
0xFFC + 4 = 0x1000 > 0xFFF and falsely warns.

Use resource_size() so the size is correct. The ">" bounds checks are
correct as-is once the size is accurate and are left unchanged.

Fixes: f04046f2577a ("arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609030809.ObirDhR3-lkp@intel.com/
Signed-off-by: Yin Li <yin.li@oss.qualcomm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
---
 drivers/resctrl/mpam_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 05f785328dc2..bea231dac7e6 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2506,7 +2506,7 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 			dev_err_once(dev, "Failed to map MSC base address\n");
 			return ERR_CAST(io);
 		}
-		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
+		msc->mapped_hwpage_sz = resource_size(msc_res);
 		msc->mapped_hwpage = io;
 	} else if (msc->iface == MPAM_IFACE_PCC) {
 		u32 mpam_fb_msc_id;

-- 
2.34.1

