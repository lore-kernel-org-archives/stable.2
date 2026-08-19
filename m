Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FA259C80;
	Wed, 19 Aug 2026 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147614; cv=none; b=MA04JEDhiVG5CqFA1qZRbISKlU094MN8IujlT86xU2S0nKWy9wy4oK6WTz7uKkqi+ZsQNJVWD4a/SKUworXXID3fLy0ptGVPVi9fUK7ZIBGyvtYYArmaWYCJcRTdWHHpds1JBHxBWHI9qZIak9KHSQ6RjtW0PyW60nb4dOipCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147614; c=relaxed/simple;
	bh=MgSOGMbPpcltn1MvfVvua4LgrIWcm7tRg2vSRwzbHeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDBfq/XLcL1Vl4Lt4eiFOBaF+UFxHljL1XSw+5b/BvNxJ76CHRB7cPm5rm+ECoRYoPMTNQUMWnxtKHuOBbIVjdwWs9bMq9Gj2LtZlCL+NJDJRyHE2/ETs1SsYU+djWc/TL9eUwFy6aiP7DYVPmUnb/JpdC/Ui/HMHTnpXWWiMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imB+ROKr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imB+ROKr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JDLmwG399317;
	Wed, 19 Aug 2026 13:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=W5/qxmNdB6JBQGCzEnnzDohiy7W0/xv9Nz3
	+jT5xC7s=; b=imB+ROKrsy5FRMvgUevBio7u3vrjIqb7fhUAIUABZlPZCmE9xEL
	sOuV8JBPoAz+jXzL48RiP+i5iOpe4ix0N357CVheaiai6eKtrwYUuBX91tGSMJlJ
	55+ycvXJ3cG+OitaJkbUcBF3P7U2pXH2++4KrSk0MoatmV/XevmeOtrrwgu46wPk
	zhn6pJypNTUJ4bALNdeHLk+q2662rvcdVp0JQnkuQx8JB5FRq7t3cxJSpBAQPYiT
	czb1GoaIOlY3WFI2qtboB7vxF68/l4eD6xzU2Rhk0+Go1M4qfs/N8xH90fTPdCo8
	uRd5jWA8j0D5SDYN4qJ5nCltcXsIOLvOiow==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa04mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 13:53:27 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JDrPsI026230;
	Wed, 19 Aug 2026 13:53:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4g2h6k8716-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 13:53:25 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67JDrPW3026177;
	Wed, 19 Aug 2026 13:53:25 GMT
Received: from bt-iot-sh05-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 67JDrPe0026125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 13:53:25 +0000 (GMT)
Received: by bt-iot-sh05-lnx.qualcomm.com (Postfix, from userid 4260555)
	id 604BF4102F; Wed, 19 Aug 2026 21:53:24 +0800 (CST)
From: Xin Chen <xin.chen2@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_chejiang@quicinc.com, liulzhao@qti.qualcomm.com,
        cxin@qti.qualcomm.com, Xin Chen <xin.chen2@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb
Date: Wed, 19 Aug 2026 21:53:21 +0800
Message-ID: <20260819135321.1444185-1-xin.chen2@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a85b558 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=E1UeJpGd7Wo9bEfcEYsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FX52RfHdLYCVxuiRvdA87Ag8w3RWag01
X-Proofpoint-ORIG-GUID: FX52RfHdLYCVxuiRvdA87Ag8w3RWag01
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwOCBTYWx0ZWRfXwe0m4HAYvVu4
 5RBP2I7vYwA2hQ1j2mUcZlEqexU592f176Gx2vUmUje4I6En51a9vCyW89wggKBo/d97TBd6BNT
 kdI0LOvxpeBenxhb+vBE9Le2G1y7Nfo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwOCBTYWx0ZWRfX0zjAta/4OV6R
 FIh0sVIV+v9YorktGNC6AcpB4/dUwb4p/sOSUH1aIoTa8wZTYmGksDpccbcNj9S3TNFQ5Q5NjnD
 TGzuqBGFCNXn0NxvV67ZWxQM2Meu4hR2CyRo1IEqSTNeN3Vc6Q1AalCwuoQKhFOpYTKneI6g+mY
 vvLILywbm9NqwIxCiIzAKg+rtdnXw9idO2XAzGcXCpnkh+2nfmMPnIu4XIzxisJazvG5+/laTVY
 WwaQhb0+6J9LYXhIh0KqJUjxqyp0KclLqluDLzm8CujJkt/MqQlj6cIuJV44MQ/xbhv+5Hke4M6
 05C7WGs5qMN3E8hHLYFPn0Qq1hfd2I2A+tm/RwNi/OchbJagtlDpuIEUL5deXSoMf/AYP+2Lscl
 iAjKSM84Vps0VW6RrKarSL4AcyPQNkOtazcg6qi4qDLxSJoe0r5hg2sEADmpLYuB+vmQsqqpEYK
 LxJRkhyy3Z/SAO1GIbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190108

BT enable fails intermittently with -ETIMEDOUT (-110).  The kernel log
shows the HCI Read Local Version command was sent and the firmware
replied with status 0x00 (logged by hci_req_cmd_complete() BT_DBG),
but the waiter in __hci_cmd_sync_sk() never woke up and timed out
after 10 s:

  bluetooth hci0: Opcode 0xfc00              // __hci_cmd_sync_sk
  bluetooth hci0: opcode 0xfc00 plen 1       // hci_cmd_sync_add
  bluetooth hci0: skb len 4                  // hci_cmd_sync_alloc
  bluetooth hci0: length 1                   // hci_req_sync_run
  Bluetooth: hci0 cmd_cnt 1 cmd queued 1     // hci_cmd_work
  Bluetooth: hci0 type 1 len 4               // hci_send_frame
  Bluetooth: opcode 0xfc00 status 0x00       // hci_req_cmd_complete
  <-- req_skb NULL: req_complete_skb not set,
      hci_cmd_sync_complete() never called,
      req_status stays HCI_REQ_PEND            -->
  <-- 10 s later: wait_event_interruptible_timeout expires -->
  bluetooth hci0: end: err -110              // __hci_cmd_sync_sk

The root cause is that hci_send_cmd_sync() clones the sent command
into hdev->req_skb so that hci_req_cmd_complete() can locate the
registered completion callback.  Under memory pressure this
skb_clone() fails, leaving hdev->req_skb NULL.  The firmware reply
is received and processed, but hci_req_cmd_complete() finds NULL
req_skb, so hci_cmd_sync_complete() is never called, req_status
stays HCI_REQ_PEND, and the waiter times out with -ETIMEDOUT.

req_skb is only used to read bt_cb(skb)->hci callbacks and opcode --
it is never modified.  Replace skb_clone() with skb_get(), which
simply increments the reference count of hdev->sent_cmd without
allocating new memory and therefore cannot fail.

This issue was first observed as a use-after-free in ttyport_close()
when ttyport_open() failed, which was investigated in an earlier
patch series [1].  That investigation led to the discovery of the
true root cause described above.

[1] https://lore.kernel.org/all/20250430111617.1151390-1-quic_cxin@quicinc.com/

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Cc: stable@vger.kernel.org
Signed-off-by: Xin Chen <xin.chen2@oss.qualcomm.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 509c820a693d..35a1be57e386 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4093,7 +4093,7 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
-		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
+		hdev->req_skb = skb_get(hdev->sent_cmd);
 	}
 
 	return err;
-- 
2.43.0

