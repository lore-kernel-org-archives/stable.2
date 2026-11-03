Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701959;
	b=GvTHKbUWB5cBXfRKn6yIk8ZkYxrMbf9XeO7TkvNphkISO1riPczaITUQ4OExvzu2LgxW
	 hRG+zZ1We3l1+b2SQKKxuY350pnE9dGrsnvPs+gZ0A6qBgYV3ra9JxkU90MwpHMzkbU+9
	 j6U7ByoulcYH3VZ92IgXJ3cSABFihJ7Hi7WsUNnI+Sc515Iww7PGWgG0xRDdtOEICs8pE
	 kUiuBiddf/iBCYC0kWdgsCRzNW6m9O1EAGmZCu9q4P8wHL5rr1MEaCFa++An0ISI6T+Yi
	 OXWbKJubbow2N9AMDYjVe8juz+JSxyaFINPXk4GQOxaqz1vcuCiopxTX5rzCrpRX2jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
	b=fSWgUOfnWYMUz5A3ERocMPTUlxLHOzbYoxuezrERlb0jMk6y/6tsmGM+hrvB3BH42MAB
	 zWka8Eu7duMgW+Yy+xHrfHTpEaKDnOk8jgdVWPfK6mReaDnMVNhhhNlKu1zxtgVErMg+c
	 wXaHr/c6QOIk4XoUnS1wpu+bfIs4zB1LvajcCNoMTOc40XNW4pswq7kHYB75rA2zGWPFm
	 V8ZIw/OQEU/cM31QHj5VzISYi3JgLdUAR6aKSSd46zz7Lc0pkjbr7KpAIaRE0G6d5YJB0
	 p9Eu4SfoCVem1z+osKxAzIB+ClZRqFd7GfHDTlJ77g43aTqB+UgY3sY5IommkRpQbVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="oUoSKOU/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hb2xmngy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2F606B13A
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F2F606B13A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oUoSKOU/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hb2xmngy
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AA4aZ3577902
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 10:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9OTHugQliWNMFHV9r9MfN3
	kHQpTez4X3FtLgUfekNy4=; b=oUoSKOU/WSY8TyBJ7fYAgtZ2ukVbmoEFhacU/E
	pFUbBsoA0DUyxE2U7gz6X9Uz/XUlt3MtOEIN5Z5KZWYjWq+FCNx94Lt5JwbFqFDf
	+vpHiQ+FtlrT4kBi52kyFiIx/IHtXXuquhpalp5tzk55E0J22GMxhYQbNMeC//Uq
	F47yyh2MQrOv92J+g0PrwkbXwbBVDAu8qR0cpJaZG7va3P3jqDL/M8QJ857S4foS
	6Lnzkbf5iAAfgtfv9GKxKFyC/+FKvSDp3Adk/qg6A21MGXyA7ka+a/aeyrNzcLq2
	xQRuDDSs8dZUxLdcOwEVCGmsPGxPMEkLLreWgkMQ/dNCcOBA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76d9p79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:32:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so2295946a12.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793701957; x=1794306757; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
        b=Hb2xmngyhlLSIVdAk6SLafRLebLIo4wfzrKXn6/RQJTRXODvaQWhTybUalRBhqzjzv
         OIZeroiz+VRs/Nf0tNdQXzXjyUHBEgEHJPDMixp8Lg4HKhGVAlX3jfW63T1CmDnznT+3
         VvzNFp43+grWZ/OiTRfW00K3W6bTAGoLXCHL8dqC94zGHRO2kD/Ui3XWDG2fvJAE4513
         GK+ugQBxl+j3Vj+hNmgKQ5AZ28aWK2YBQDh81yxdNdETgRa25fc52SvrlsfrESi3WLpo
         rTCKH/H3mRPhJUmBKJ3OzwY9LoSdno/xfNaMbIiDRRvFAnG2ykcIhhs+IEHLiYH1c2QT
         ROsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701957; x=1794306757;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
        b=Bej1pHIVgHtcD9x5K9tDiRFh069C/oy6SVClBHflQpC5coH0fCSfX6C4SNCJ3jyFvi
         3aVjgBoERGlOWzMviKMyfgV15VgSzaWrtBAEzMfBZeeRFL9yXZp8zKXBFWYXMo3S+neS
         n11ia3qMOB8RiKFCl5tEglFqpc5G36AFo/QVBnta5g+adLZc9A4qe/8gk23FceWr92+k
         saSm0gfQ3ejw8MYSMDVGKKC8smYK3fijVLYgBVyv9gF9MpBJaQHPnBlG2xZiCvbk1EpN
         ggCPTQpcQHtikNrOdBYzoZboAshV+vslWMoApZReslQ2FXqmhnnvbOmBl/2yXl9CFeFJ
         M5gA==
X-Forwarded-Encrypted: i=1; AKwUvBx1sgSLGQqkBAdVjnGoN/F33fhG19iRvUPeCnw8bn/K+DwJ418pmxjqxWnSe2wa93d/IrNLnLw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j4qvd1sepg95GyNizIOyvOXywx2IvAsgvD8Gp40wI8VxoozEy
	cv/LQP2D8E+tqCIq9vyzDExCNw2iEvqqBV8Luqt2KHNcyvpKwHqj6gw7sBq42LI3jEUBZ9FnGed
	vHTnGgcxxshlu/VEOJNS3W6V7qVS4/0AFMq3UDuzblBakLIpRR9dso0Cczm0=
X-Gm-Gg: AYBFou3Eq8uZylUDKdzGyISTKotCG5JjuFqZ6xn6FnNNVHkpUXI1YnzDlSNYVKqra+C
	wtKKECEFZWSuhmp6WrN1tLo5FKRMph+2vRl99w4IQyrobBNzybsEG00K4naTObuBOheTYIZ2iP7
	dC/iXSXGXgnvTZuq9GgpgL+VQrzxrxRIu201NGTo5aFQTMJEllAYxzXsYNDBqJOH+1abpfGcIpq
	5aQFRQ+n1cBas3nVyNfamE0IaGfV1AGM15ydXMJ2pCkpM6q2fhJEupMZZK+AWLDOy18Sjo6i08d
	GXOYmMynXMMoQbqbJ2YQQG4fuoESjuOs1JzE+mmxTWv4yzfqINQILkCFVqtJY5plC7a7N5B/nbR
	0bJIu26t+Pzz4OfA2FrmdTsq7t2NvndiSNue2ZRdp4z/Tr8ujTz5CeJn+BBNKuY9BVlLA19G6ch
	jx
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ae89536bffmr9604451a91.6.1793701957182;
        Tue, 03 Nov 2026 02:32:37 -0800 (PST)
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ae89536bffmr9604430a91.6.1793701956680;
        Tue, 03 Nov 2026 02:32:36 -0800 (PST)
Received: from congzhan02.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8329afsm3740814a91.8.2026.11.03.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:32:36 -0800 (PST)
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 18:32:21 +0800
Subject: [PATCH RESEND v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
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
Message-Id: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Eugenio Perez <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cong Zhang <cong.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-38bf1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793701952; l=2531;
 i=cong.zhang@oss.qualcomm.com; s=20250926; h=from:subject:message-id;
 bh=GA7vQS8Tiz0/LgX66p7Nd9+W/EfJ3aiCYcUb5tpLGpQ=;
 b=LbXB6Q5QCzunltowh2X7OUgrJOoa7ZCDRcYJximUm767xh12vRbVj9yQba6diwAiYryTaRG+W
 eTQIzHhKcO8DAINJrvgq0uE8bVDzdsSuasQJVRd2EDSj9cg1dYIik2U
X-Developer-Key: i=cong.zhang@oss.qualcomm.com; a=ed25519;
 pk=8SBh3ey5igz2nlW+UFC6khFvaNPgG7MmbWtAeO2s6n8=
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9b845 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=kkXLOB11zRU5SlhL2XgA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0MSBTYWx0ZWRfX5VAoFlcZfiXY
 AQbAxv5O7dEdvSwbgmyz9jQ93SXv4xci6hvREwaQhpFPnn90j98qafdU7NzCQQR8F/u2IPXTJmT
 Fb/U4rRFoMxq651QjRlxU+i1MLjjsg0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0MSBTYWx0ZWRfXyY8QeTl9u8b6
 RAI+jpPjTwk200B40fZzvQJEBm1eliRwRjPZVkZrTDKBZjZ7Kj641e9CuEA8irCbxNEBkGAJWqY
 TUu8hFqv5diFD6nlJFiYIPVhGiQ3vyMEVW/rtDX4RFYPANBkUgAjeDgGMT2Cry47EkAl57vFC6K
 piOdKpql/91glNXlOIoNIHYXDfwdwOzrhehhIt1soORXwq8/bHC4lY+dLA0gtK/0Y+vl+Nd6k4n
 dSHCYxQnUipBUkT1ioJdc8C3/yh/5oAkYPjJzFR6zuIcTUN/AOqloaCywZ1T+VcJtBMupApUgnv
 dJQBeInyHb9A/MwVtjSn2/ScHMVsI+9yJAr/RztyywsWPyvqaCYYo5NZ4dnLbCbku+4jAVIJBXl
 jWi8pcjIhuBjM9c5FA5pmzaCdH3aU8jw4iT7yHoBrwoeaNAFpXctfdWrva+N2rtS6Evk1rq4e8+
 AXSapwoMjxp71MgWJ4Q==
X-Proofpoint-GUID: 1whboEkYMaRUvkjIhDMTNR35yDuxOCz1
X-Proofpoint-ORIG-GUID: 1whboEkYMaRUvkjIhDMTNR35yDuxOCz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030041

blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
while the flag is clear. It can then be preempted before it gets a
request. At that time, it has no queue usage reference, so
blk_mq_freeze_queue() does not wait for it.

virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
blk_mq_unfreeze_queue(). A new request can enter the queue. The old
dispatcher can run again, use its old flag check, get the new request,
and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
reset the device, delete the virtqueues, and free vblk->vqs. The old
dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
kernel can crash.

Fix this by using blk_mq_quiesce_queue(), which waits for dispatch code
that was already running. Keep the existing freeze and unfreeze order.
The queue remains quiesced until virtblk_restore_priv() calls
blk_mq_unquiesce_queue().

Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
Cc: stable@vger.kernel.org
Acked-by: Jason Wang <jasowangio@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
---
Changes in v3:
- Move the race description into the commit log.
- Remove the blank line between tags.
- Add Cc: stable@vger.kernel.org to the commit trailers.
- Link to v2: https://lore.kernel.org/20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com

Changes in v2:
- Cc stable@vger.kernel.org.
- Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..7a570591e040 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	memflags = blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
 
 	/* Ensure we don't receive any more interrupts */

---
base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416

Best regards,
--
Cong Zhang <cong.zhang@oss.qualcomm.com>
-- 
Cong Zhang <cong.zhang@oss.qualcomm.com>

