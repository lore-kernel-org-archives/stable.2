Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA832D0E3;
	Tue, 18 Aug 2026 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036616; cv=none; b=H9TCBca6sn3CgZaMHS75LqjxmeTFOreJmtZzhFgqRbGiKC9+dwj9ovnpVe3fa2A6JTC5EmNzQOjdyjhdmaphgUu90dkiztIys9fU62enuwdEBxSz8HCbiG5vzFuuZLGH9T5e7xv9InH6E3RSMTjj09mCWQNcQWBYJbaU59ttEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036616; c=relaxed/simple;
	bh=xPbGZ+20GhS3qXmS5aaJdRFXoueMC06l+JLQJG8+JsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E79of2jd4ehJNY0ddDMKOtLuhR1GMb8hM6akOqcmp6PANQjART8s8CKKGlJJgE/5QRf4WHm6VHg9an9DGvSo45TgdVV3hPAB64sVaoJLwekMMgNrirYcwxXmekOXTQl7wKxDbL3v4oZsjiGVMrlDsaEPF1UmGRprJqO7axji/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjbJYMrQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjbJYMrQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I73GbS157142;
	Tue, 18 Aug 2026 07:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=D+DHMQxUIp5
	pUb7v8H2EexvplVqDb4F7I5Gv77r08Ss=; b=RjbJYMrQC5IsTmvtRNEcp/g275A
	QyZk+9wEZSbcHXydQs+JnXoGQ5S4UbHTS7z89YeAe5OzxKpUuDTEp5HJbeJs34Rn
	2rGZyabS1wa3n09317npiF/uw2y8eRs/zVmXkplf6XXijeeSaFT0cLTIXLH11m+V
	QTuyBkgKRydPD/czPIqnWuTYnlahK0L0t0EJSiQK8CKMNAc2FF9PE1Dt4LOkp3wR
	cQvSI+0v8TbouFz9n8RhU6lLjE97fohr1wJ5XwlzP16mkzYsAz/mskd1Mcd0TZfb
	Ficb3ITNHYr17AIu+ZuYtHRfV51Zr7G2JV4G1VuKmO4EC7YfcoFfT92Otpg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fba8wv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:03:31 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I73TFW002704;
	Tue, 18 Aug 2026 07:03:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g2h6hvejj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:03:29 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67I73TqF002699;
	Tue, 18 Aug 2026 07:03:29 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 67I73StN002696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:03:29 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4260555)
	id 3EAD722AA0; Tue, 18 Aug 2026 15:03:28 +0800 (CST)
From: Xin Chen <xin.chen2@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org, liulzhao@qti.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com,
        Xin Chen <xin.chen2@oss.qualcomm.com>
Subject: [PATCH v2] tty: n_tty: use kvzalloc/kvfree for line discipline data
Date: Tue, 18 Aug 2026 15:03:24 +0800
Message-Id: <20260818070324.136726-1-xin.chen2@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1MSBTYWx0ZWRfX7RaedIN1viOp
 09v5htVwKrDumJ8j5z8DeydLEYHJ3j6g/HNFQkapsqkS288451U48iNCt5yWwccFOh60nEbVUn+
 J33NuKe6BkJZEbKxQB5YEuxj/YGlIgA=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a8403c3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uj50DkyrN9VKJnPK0UEA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rNzhTEyy3AJwWXD4obePB8iDR8NRZH_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1MSBTYWx0ZWRfX+CrSz0hpavV3
 GZt6h8dHrxPTBooVRXrJo/lDFx+IhkKyG+kazvu48iVaTNFK1+2AnId8MB6QUR7jzKP38mBfClZ
 SH7HSXPlOOFI60J+KUMJ0p+/JBRbkeSgzVLcmgHGWfV8ysjB0PtviiDu5R5hd7dfRgsJGK/dn+J
 uG+iUC9WxHTZs3l3Lr/OdL55MHTsmZ/nQ/xzh6/XYbF4npAe2jPbiVXYhUeqOrwps2Xeyx60ZxG
 3oK0xCKNBYO1lsKiKQX/NiVrSAOVZJn58ksi2ko20ATZPFAfO+KR7ksGatquy35uGpvrAF5cEef
 4N5zdAb7mW2frnzdc83YUnOptNB/88POd3UHSAY4TZZQpDj3uHnESp7EY+kJ1Bn9Pxa5DYVZYd4
 Pd3HFD9RcPgrxsjkLClads6hSqPTAV2+jBXREMoj5Ue+J0pwZaQlPBSrIJE1siFasYRYLkq0tr8
 dGpI8AVqBxsVK1BNk1g==
X-Proofpoint-GUID: rNzhTEyy3AJwWXD4obePB8iDR8NRZH_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180051

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

The memory pressure is caused by n_tty_open().  When a BT UART
transport is opened, serdev_device_open() may be called multiple
times in quick succession, each triggering n_tty_open().  n_tty_open()
uses vzalloc() for the ~10 KB n_tty_data structure, which always
allocates page-by-page from the buddy order-0 free list.  Repeated
vzalloc() calls drain enough order-0 pages that the subsequent
skb_clone(GFP_KERNEL) in hci_send_cmd_sync() cannot get a page.

Replace vzalloc/vfree with kvzalloc_obj/kvfree.  kvzalloc_obj() tries
kmalloc first and falls back to vmalloc only on failure.  The
~10 KB n_tty_data is served from the kmalloc-16384 slab (backed
by an order-2 compound page), leaving the order-0 free list intact
for the subsequent skb_clone() calls.

This issue was first observed as a use-after-free in ttyport_close()
when ttyport_open() failed, which was investigated in an earlier
patch series [1].  That investigation led to the discovery of the
true root cause described above.

[1] https://lore.kernel.org/all/20250430111617.1151390-1-quic_cxin@quicinc.com/

Fixes: 20bafb3d23d1 ("n_tty: Move buffers into n_tty_data")
Cc: stable@vger.kernel.org
Signed-off-by: Xin Chen <xin.chen2@oss.qualcomm.com>
---
Changes in v2:
- Add Fixes: tag pointing to 20bafb3d23d1
- Add Cc: stable@vger.kernel.org
- Drop the Note paragraph about kvzalloc_obj
- Use kvzalloc_obj() instead of kvzalloc(sizeof(*ldata), GFP_KERNEL)

 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40d0a..81baef6110c0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1870,7 +1870,7 @@ static void n_tty_close(struct tty_struct *tty)
 		n_tty_packet_mode_flush(tty);
 
 	guard(rwsem_write)(&tty->termios_rwsem);
-	vfree(ldata);
+	kvfree(ldata);
 	tty->disc_data = NULL;
 }
 
@@ -1887,7 +1887,7 @@ static int n_tty_open(struct tty_struct *tty)
 	struct n_tty_data *ldata;
 
 	/* Currently a malloc failure here can panic */
-	ldata = vzalloc(sizeof(*ldata));
+	ldata = kvzalloc_obj(ldata);
 	if (!ldata)
 		return -ENOMEM;
 
-- 
2.43.0

