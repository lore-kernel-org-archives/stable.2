Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68951472F99
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056108; cv=none; b=rlRCAI+mQ79aleD8FintsYJVfqJbFdqJyBzF3HiDM/4eU4RkZdXCs2DzybxNhAP4TwLZcSTXBzWU26s20sxMG2FgCTBEO5YPV3TxzPFnThcMZ9+H2SDrsSyPuIqU9YnpCYW+TqydnNaFAq+A6WStImXMEDZqdoF1rMNlHRq1Oz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056108; c=relaxed/simple;
	bh=eZFaY1BIWpVfZ1tIZcvPLZUtC7SI6Wv64YTWoPjqQNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQSwjOX2Pp5DPzt6BJ2kkboJ+t3ZEvnUGQzo+J2qvDx3Yek//3YrYrIYRa0QzIUm/703as/ZescUkR19Xeu7PB1zIg6Dtg5BwTbY0pbv84E7UhWXF+xtE9wZlQNShzr5vz6mMw2TgLeRg0eUZUD5owESgL9ZG3S+RlHaGC8rIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cCRSsWZC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AlsHZ1TM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cCRSsWZC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AlsHZ1TM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABUQj515203
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MjJ1zqQliwzDjauMxfqUWywTg2iCdsplnTn
	CF3Oo39s=; b=cCRSsWZCxozlrqntdFvFJ83+geknQ8Lwcmbktve7zKdEANITwv+
	45dQzit1nafMX90wNC5KuhV87EUM71iUSJXrzpbmjvo42JrUyWlxTx02EWwetNUu
	3ucr77j9YHEwgJtLCvilr3dZLu2WSpGpns2PI+qYeQRkBOa3TXMlvD+4wiPsXHoG
	PjkbW+f3mt/wV1ODj+yU+7eeM3z628Xc4//DHloI0pcJDBisFh4n7QdBjGsCDJtn
	jfjRaQHddnFGUn4YIeF3+hUaMH7iDnSYA9ScFQX5fPxH2DGx8DjpOnDfUd7f3zeC
	6cTT1fdu5uN57cMpD91Ab5rgjxx3gIJ0YAg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2jewq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:28:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9309af14fd7so384800385a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787056104; x=1787660904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MjJ1zqQliwzDjauMxfqUWywTg2iCdsplnTnCF3Oo39s=;
        b=AlsHZ1TMrbyNbG+AekrbQpdEnmrkEWoe/I1kJqnaZBftQjUFrCp/0myPB8V+MPS+0Z
         STWvLmUPeat+nOq0P4vwEQ3vlGYdQpBNXupkJgTPO3vzWyFwzeH4XnpyqnXr9t6L5lqR
         OTrx0QNGExUbbwQ3t0Mx+fHbI702q/4dJ8fBXAb47+UgXWcxVyezJ/9cffeKpFrj+FJS
         MuBh5SgbqvbMSJaQaO2vbCDdFhduS8xibJ1X+Z412DuW0KxV1bh1CnGDfdik1gEfQUoA
         KGPm357AY/69hUD0md64F5zMgtaQr2q25n9o7WTVD/4PFQCkI5NMnf9Zcxr5NIGQGLy9
         Pu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787056104; x=1787660904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MjJ1zqQliwzDjauMxfqUWywTg2iCdsplnTnCF3Oo39s=;
        b=l9nKtoJgWm6itwha1Epm2YkM5T3U+Po+DwhXmdXSi+af87Xi0+LfK8k8NDAraslz/h
         V23QOoxYK+rm4/gIu//TRXE48bWO7tAV/cpXrpZyJqpgvqlq1vmyEOH6GSWv/QXzWWzm
         p69E8IUrPf/c+VCNFp2yejNin91MiPF85cgAFIyTj5Uzc7PT8hCGN0i/AO/sY4lCCOla
         M7tcJMWJbgciIpn/V03YFqyc1/CRvg/wVUdw6icMJGgVL3QY4TUAnuqfUglGfYpQQFml
         F1fXjRnq93Jtf77xHki2QbiKbQWlhh8Cl3rp1WIN5U3USOclRzdW1l53xyk2tB8qtpS2
         9vtw==
X-Forwarded-Encrypted: i=1; AHgh+RpbmWUv6fEmc9lW4mivfhxx5HsZ0XIJ1Id0z1G/MRof28NkAybHuPjpefVqY8cdRQP7xo/+1e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLzPkPhfjJg33B3BMUK/EGPSAgWm8wwYvFxmU92WEmU6Ste4nA
	0Hbev1j3mxcpFwymGomdrZpfgkPL0rDt6Hav7AjcB6/hXylYRUFCfTZlHfuTLIhUzmONNpFiLzb
	3gelOYolagnkSCBZk2cPtPx06nNphTAPNNa1lL8Af9FFfu6zQAQbEJWWtmw8=
X-Gm-Gg: AR+sD12jsq6+L8+bJ+4/fM2uhQyx2ZvvB5Gr7okdNvj9BNv9dlJbT5FbJkaOSwCiqHP
	R74G2Sc3xR0UBtWvW/vFKQHThFd1GulyrvRb68GZLuGgt2VgzS5BEi70CDU8+43SVo2LHVxuon9
	Yg7lcSkR4pKsrBuwUMXfQY7u0uvKNSrhqhb3QBtbH1mcbY27Pjg6gACof1WfWVUQ2BDnDZdbenJ
	5sMYHY5lEEAhOjoriTtWxaV4bz3Qp68Adj1SwbCiz+EKca589ewUwBQPac6+PMXfcfwALUtn9ng
	R1KSHkuhSsA4RdQ7TygJnOijmwmHwggwTWylqwY4hLohOhv80DIZWh4CcTCMQ4Yh3TwvAcNKBpC
	sMJdGsBl5vF3LdNy/J3q3Q3tdwiMTOHfLLqDISPqIVCSI/kWU5tWAY+/VYZwg4SMVa+o+P7yBbk
	tWr92gySSNR9k6A1U=
X-Received: by 2002:a05:620a:a2c5:20b0:930:fbdd:c242 with SMTP id af79cd13be357-936d234d96dmr2496474685a.29.1787056103991;
        Tue, 18 Aug 2026 05:28:23 -0700 (PDT)
X-Received: by 2002:a05:620a:a2c5:20b0:930:fbdd:c242 with SMTP id af79cd13be357-936d234d96dmr2496470585a.29.1787056103474;
        Tue, 18 Aug 2026 05:28:23 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fecb5basm174486066b.24.2026.08.18.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:28:22 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
        James Alexander <opensource@inspiredexperts.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] platform/x86: int3472: Increase handshake GPIO delay to 200 ms
Date: Tue, 18 Aug 2026 14:28:21 +0200
Message-ID: <20260818122821.165541-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MiBTYWx0ZWRfX9mu1nwx23p1U
 yzXFwJlEI8pDgYzy6sZGYlNig14iWVYBh5HrRA194b97Q8313A/9hQna6Q1611/RDDyB7d5xtP0
 rJ5nI5Iz5B6mD6RaS6YCn04+YKG55hxBLfSd9BzTm/vHfcnq/7jrMF61SOeKrknLCPfpCAg3GoO
 vW6+FgnDqn95+6QdxgTmzAGu6WQist9j15OWp57CYf4fhXCKC27HyEkD96pAgJMlW3CfBI/4lTK
 t+wP+iefohCl/6HaVGxjHDXj5dZhcyZJIDJ340YwGBxAKsk2bf7IMPJjtSTE2PMPXoxjltd9H4C
 fmaiIeQLyedtU5x9rviR6/Tbq6/SLh44OnknKpCnk8TUpZ+RARV3FxESoBQLkFEPeu/5JM+yenR
 Yfe1jF3UD3aMkTUiIGIOPWsdPUdDz4B5EgFrl4XsXYKrkStwayrvWr4Fse/NtqMD1B0sHnzJp1r
 x+ydvKqHbjGYkOjtCoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MiBTYWx0ZWRfX/ydg+tOowF1T
 hAiU0sD0JW4cPAy7hMpUh3KFbGj3f8moWm2KFmFX2l3pgKLVpdzSod+Rg3Sm8NTKQp7T+kRh04h
 sfzOKpRw89CllX0G2lmzxTLlt/8CEg4=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a844fe9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=BEWJZVgQAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=NkGqlDX_d_C5XZyMslwA:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=r2lMSnxMdfrVB7dy-wwo:22
X-Proofpoint-ORIG-GUID: a978363xuHByyI-Z5crA5PV5W-vqAlnM
X-Proofpoint-GUID: a978363xuHByyI-Z5crA5PV5W-vqAlnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180092

There have been several reports of the sensor not properly powering on,
on laptops where an INT3472 handshake GPIO is used. Both with ov08x40 and
hi556 sensors.

Testing has shown that a delay of 200 ms is necessary in some cases.
The handshake GPIO is typically used to signal an extra bridge or other IC
with that IC running the full sensor power sequence based on the handshake
signal and also possible controlling I2C pass-through.

It seems that in some cases that extra IC takes up to 200 ms to before
the sensor is fully powered up and ready for I2C communication.

With the default handshake signal delay increased to 200 ms the quirk to
increase it to 45 ms for the ov08x40 is no longer necessary and is actually
undesirable since some ov08x40 setups also need the longer delay, drop it.

Fixes: 30359c239ba8 ("platform/x86: int3472: Increase ov08x40 handshake GPIO delay to 45 ms")
Closes: https://lore.kernel.org/platform-driver-x86/20260816204247.2844986-1-opensource@inspiredexperts.com/
Reported-by: James Alexander <opensource@inspiredexperts.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333331
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333647
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Rebase on top of media-committers/next
---
 drivers/platform/x86/intel/int3472/discrete.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 6c729fcfce5d..f24add37fd36 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -15,6 +15,7 @@
 #include <linux/platform_data/x86/int3472.h>
 #include <linux/platform_device.h>
 #include <linux/string_choices.h>
+#include <linux/time64.h>
 #include <linux/uuid.h>
 
 /*
@@ -178,13 +179,6 @@ static const struct int3472_gpio_map int3472_gpio_map[] = {
 		.type_to = INT3472_GPIO_TYPE_RESET,
 		.con_id = "enable",
 	},
-	{	/* ov08x40's handshake pin needs a 45 ms delay on some HP laptops */
-		.hids = (const char * const[]) { "OVTI08F4", NULL },
-		.type_from = INT3472_GPIO_TYPE_HANDSHAKE,
-		.type_to = INT3472_GPIO_TYPE_HANDSHAKE,
-		.con_id = "dvdd",
-		.enable_time_us = 45 * USEC_PER_MSEC,
-	},
 	{	/* Sensors which expect "vana" as con_id for power enable */
 		.hids = power_enable_hids_vana,
 		.type_from = INT3472_GPIO_TYPE_POWER_ENABLE,
@@ -273,8 +267,8 @@ static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3
 	case INT3472_GPIO_TYPE_HANDSHAKE:
 		*con_id = "dvdd";
 		*gpio_flags = GPIO_ACTIVE_HIGH;
-		/* Setups using a handshake pin need 25 ms enable delay */
-		*enable_time_us = 25 * USEC_PER_MSEC;
+		/* Powering up the sensor through the handshake pin takes up to 200 ms */
+		*enable_time_us = 200 * USEC_PER_MSEC;
 		break;
 	default:
 		*con_id = "unknown";
-- 
2.55.0

