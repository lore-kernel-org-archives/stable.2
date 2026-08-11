Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10241A4E8
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437455; cv=none; b=jD5y4K0o/2VtuPn2/FIBoJqe6YNMRcJsfo8sqIP9ltbvanY1QX/eWLQqlEcPijVbHSZKoVmUlpc4LF79oEripcM0ecOtBiWJO4CEDSUqjtoWWvueFiwj+uKHjr9aFFUCHcIudNmmCN0uwGDXLyehZWbiKVNbeyRaFNMu0BC/mWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437455; c=relaxed/simple;
	bh=cr/NcxcTn4m2cOVGIkk87IdfX5HLlJu10qgZsLser0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keHQoMYoXfvzy7LtlwyWQCXmpgaDvDMKAu2RYcQN78+MSjkoVQvSbrRc+vxZxrS8KhQM5JWbiTdJi07As5GV/NKhGnimaEi/DwALKT0jvmOnsNroKaLic/3JJ1sPw5hZ3Blu/sCtVZYQBhud7ulLvQdYNwb0kJYiDOp/0jHooZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4xqD0bz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jSJmsEcu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4xqD0bz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jSJmsEcu"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B7KbDa2939784
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eET8pt8EIz4eve4XOzAwqLJEC4iYOR3jpk2
	dxLkAo7w=; b=E4xqD0bz6wBy6j8vgjjgI1brE/rIUbGL+FzeRpjqUJWOhfJOfP1
	Zn3KIV9MZxRqFly5lRtvLoVCbSpnZ+Kv56vtDZy+c5Dp3P319R0HfYQ6Vx1PydBW
	W7t/LMWg6S1amvlJP9Hd6Y13zNUle8lWgNS16xODq6BasDr3gkGqpiECZ6KBoUUP
	1H8m8or65SYlfcjWESubfhcAP7sNtDb6whAE2hNeOaPaktjKp2TMMG8U4mQISj9X
	NIZolv1jzBrkheBWHBG6Jlv3KA+2pcUgVxgGck6jraofU/Mwbnhg8CI918tfb9/j
	pjtOJoY1BzvmAKvIacFTYi3rmDfqog5rEFQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv35j6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:37:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so35118061cf.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786437452; x=1787042252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eET8pt8EIz4eve4XOzAwqLJEC4iYOR3jpk2dxLkAo7w=;
        b=jSJmsEcuFc3ipvTNzFu+xDC8eVU/h3OlfdMi8LOgd9pMl0n14fCExEKrXsncVqD4Zn
         k/InLfdo/PbVU+DS/PajNAAT5JagENUu6U+27OG9S2cfLCAYI7d4vfnRiGv0pfIZXkRN
         g/P3bqiMFoIEflS4/N2nFrVQhjxq91bWf51zeJTzxAar1i9WJa9jarclcy04diDViYJU
         2DyKg3mJynXPOWjCnMCeQnE3L3QjL5k/ZtBrdmI7iQUxA0Do8jut2PL6RAqdphgHJp62
         yRXNTFNUuWeeQjGyjDtBooogUwKYSXYRaescPHXLdQaqyUmQ23jhRp8bUd6HlcuehcXz
         iJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437452; x=1787042252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eET8pt8EIz4eve4XOzAwqLJEC4iYOR3jpk2dxLkAo7w=;
        b=dYesTz/IyN8OFc7v6a8FzncCSnpAra8dAgk6+ipugCl0njgUXcs8fFb3wafSZTPtIO
         /edn5ydiW9rinHEW68Tkh/5w3uMvHJT1cwfuHCC+EKXaPxhl9n+TIg4Xrqj5k2HxR5Fq
         nWoOBEOtyAjDUtbsl2dRAXR440DslJMi8lR10FJ4rtlmrRdcubffW8ahKMDKRBVrdhIS
         QKq28FmANt9Q8SoNt4mIRCCf5DD6W+6oac8CBXhs0NsntmBMOOR0Z7cQfLUE6XLgLa4k
         Rcskyrqq9nGtDHRH+FbIdXTzWMuU9ctYSMo8+UVThV1rb7lZLPWSbW3DFNji9wV4OxLp
         LIrA==
X-Forwarded-Encrypted: i=1; AHgh+RpVu/FBh8lXlBqyIF6DjkGYw/Wf6+lG4smLLtfG7RhbTpYYSwkMTyOZX11wpdkoHfzMKu33iWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd6tx5DgK5/S/UDSgrQ72whFKcBUEYwsPRsTTZYY7l6Lrhw9d8
	VJ7m2FJhqPmyIb30dhKj6k7o2wTfcXuIvDdQ5Yz/kq2FFr00Ob/5MM5bAoUXq5+qlXECNxm6dGi
	UVaeG+/nhUvu4tipfL4wQ1iov2BkKmguH4E7Vu5OpMgEUIjoxi8fw9V2Va7PlNRoyo7g=
X-Gm-Gg: AR+sD10x7FA0s5b7pD+Nay5AYNHP3TGwFek3FmCDMVzLTUbzm6ft1wTdRCHgo/GUTMZ
	oLIuben20NQrYJwN/NswbYcvjI7+b8wIw7yed/f9CiXx8Ol7bQ6+EfDzOJCHORKCH0g/38Mjrjp
	vXY/OhuRRuxyUzLn38I/okMKVcCMbnP+0dBD6J1f7TSL1p6RDZiFzU6HtdUaXycf18zQSqqMvKc
	EyUJfEFf4RUNVRnlrK9/1ngW6RyoYt4Idnt3CAFOBdCsfuHL4aE+C69RaauHwvK3ZjTFY28Mupx
	RFvLqjuk91awce3bcwWFhlO7MARgnTuX0N+Xd8kw6KRrYgYbRTsHM3UiALpGOne53E6usnOu6KF
	2oM+XZ+fO7OuVfkshdJCf7Q/0RF+DOHSK9J0ewECUK7klqaKdhF+AdRIulJHtQqL5J7ZHDvZP1x
	2hMRTXvNVJ3NJRkOk=
X-Received: by 2002:a05:622a:c06:b0:528:3d62:16c8 with SMTP id d75a77b69052e-52d586748b5mr12709721cf.31.1786437452257;
        Tue, 11 Aug 2026 01:37:32 -0700 (PDT)
X-Received: by 2002:a05:622a:c06:b0:528:3d62:16c8 with SMTP id d75a77b69052e-52d586748b5mr12709491cf.31.1786437451782;
        Tue, 11 Aug 2026 01:37:31 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a362eeb727sm357208a12.24.2026.08.11.01.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:37:30 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request
Date: Tue, 11 Aug 2026 10:37:29 +0200
Message-ID: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfX+mKst6K2Ukxy
 7rv8pJ/EJHFlNii1lz3rht3YTb5j4nLW4Zq7VaBEQCwGLl+wyqTXlcVM/maaGmiMM94e87Vr7/2
 dtGi9kdQzhrck5WSB3AqctvgE8ogaDh2+SUq8gzfkBa0TfD3JqKdYJOvDEuPkz8zrPWU1xQ9uTf
 iWkgoe4ivKQP08sEjHQZmoreVE8O0uVpm+jpYWpBzP/gfQDO0iGLMyDuLfn5lmEBW4vhEtO1KV9
 VyWJEbNPqO0y/g+VgFov5q1zQJPhkdmK+61GuT0uVfmtWrCDvkxkyAcVUo+UYVINWC7dCBIeyg8
 Pbej2EV9LxP2SNTyHZSl10bwNBoY6N2Nz8mQECKlOYou4y+vGvEA6rcP+YG4S52dv8hdHqrK3J5
 rPHjZ06zXOR8Sqxatltgm6G0hkWH8jafjk1T50xiWZCfOiKmpUzjEH9W668DTyc1FF8XADXRWni
 tnKWEqwMTBYUSlMk7kA==
X-Proofpoint-ORIG-GUID: Lt4Bjcej-yOr-VXQcHCetSevxSXaoJvq
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7adf4c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=K8nJeBO14j-BIrTqJngA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Lt4Bjcej-yOr-VXQcHCetSevxSXaoJvq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfX/p/pdCXLggtw
 uL+9fTSymxswnE1rIS928vzJviEPbJRVJ/emjqFJoPNd3kBZVeUF8wxJ9IkQKHipbBdBCr6cdUa
 vQcQPh0tct9Gm84CZbbuwYyEmdLGIPg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110070

From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>

A synchronous HCI command that never receives a response leaves
HCI_CMD_PENDING set: hci_req_cmd_complete() is the only place that clears
it, and it only runs when a response matching the last command sent
arrives.

hci_send_cmd_sync() populates hdev->req_skb only when the flag transitions
from clear to set, while hci_dev_open_sync() and hci_dev_close_sync() drop
req_skb without clearing the flag. After a timeout followed by either, the
two disagree: the flag claims a request is outstanding while req_skb is
NULL. Subsequent synchronous commands are then sent with no req_skb, so
hci_event_packet() has nothing to match an arriving event against, and the
caller times out even though the controller answered.

Commands answered by Command Complete recover on their own, since
hci_req_cmd_complete() clears the flag as a side effect. Drivers using
__hci_cmd_sync_ev() with a custom event do not, because a vendor event
never reaches that path. On a WCN3988 (hci_qca over UART) this makes a
controller firmware hang unrecoverable: the driver injects a hardware
error and re-runs qca_setup(), qca_read_soc_version() waits for
HCI_EV_VENDOR, the reply arrives within 4 ms and is discarded, and every
retry fails the same way. The adapter is left down until the driver is
unbound and rebound, or power is removed.

Clear the flag wherever the last request is dropped, restoring the
invariant that req_skb is non-NULL exactly when HCI_CMD_PENDING is set.
Verified on hardware by forcing a command timeout: without this change
setup fails on every attempt, with it setup succeeds on the first.

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 net/bluetooth/hci_sync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 532534bc601c..33ee71c56480 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5302,6 +5302,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		if (hdev->req_skb) {
 			kfree_skb(hdev->req_skb);
 			hdev->req_skb = NULL;
+			hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
 		}
 
 		clear_bit(HCI_RUNNING, &hdev->flags);
@@ -5486,6 +5487,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	if (hdev->req_skb) {
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = NULL;
+		hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
 	}
 
 	clear_bit(HCI_RUNNING, &hdev->flags);
-- 
2.55.0

