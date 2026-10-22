Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660180;
	b=gZzz9t7s8zo/UiuNuLdfBOdquOoMtnE+cHKE29SR9PIdfO9X6vU/KCcnROgStRFBNjCS
	 mbb6/7k9jGocyWrs7c/X3a5lOuLrw1IcOB+8hoe7k72bvxMQ3sV2B/y9Z8c407nBYxslT
	 zKgzdIJGCdnWb3oVKsajLYlnIJITxuxZrXfWdBVJZmoKpPypkK/q6Quxs8bnjTwXbJmsj
	 iCBqsEGlazoXgT7bJ2pGVeWBLQ11dUe16CulnPl4vRm7pvvhLEdHcznqLNKBSVQQnxFfe
	 7PjlsqZmLUZABbKUFO57lhN28ifcE3sTMEIrfJhRhQSZUmwdPBwNe09l6Ua6jkT10mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HjfWDRPzYl5PNTaWP9ttZL/Fu+3IQzVkWXRGbtuepsA=;
	b=13ZTN6qGpQA1RKfmRwnKbL3dANSX69q+0QTniThmLgxPCVtZ1+7BZPOZlb+ud3uVcC/W
	 ymGqo9OGPKG30cGq6U/289w99v6kPYMcT9HBB9FHDGuFT2My6S6Ejizzv3MqF/IHDRlM5
	 zAOUgduBcwhwa11U29SNC8SQs5VI5i+acl1w6X+hQus0+LFgVynazZvNxOV+WvDCuqbGj
	 6vtloh5ANBoZDJ2uHJISDWPbbRgud3VQwFBaoaJhgBOrdO8hvrammr9IT9fsKIpkK5y5a
	 8pP41KFWxb48h/0w1cvycPU0vF8MTJWfBIK7oWo1/zo2LiCzXhaSKPSXPZFvBypMn8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3ErXA3N;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NUSImDFz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6A60A2608
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F6A60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3ErXA3N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NUSImDFz
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M90sh33294751
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HjfWDRPzYl5PNTaWP9ttZL/Fu+3IQzVkWXRGbtuepsA=; b=b3ErXA3NK6BbgHoJ
	Xrfe5LF1YuKsQFI+mcFcBuqsTWz/ou9wj9dooSaVafC7BpmvW4I9DFPa9Uw3a9f4
	JxVWJvH9ss44Y5Zemv7KvroirpVXgx/eZ51LbiETmz/ejYQ7pX1GCyj4xikIw32k
	32s1r3XTUO+D0CR5iJK3jrJAYb/hxdPAMsOA1eYTZfS6juehv0NIySdmJwy4fudR
	I1SSRqc+TWc4TnOHwKkFm2IZAZ5Zl+ydlo4k8N5m6KvD5E8JVoQb2oJJMit7pSYA
	iGqXY13Py0+iZgzEQD2wKJ0LjhugBOmwKK6L/mUlqAVSShJHduUVqZJ1cRarOG3M
	KxFuhw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93asjjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:09:38 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-151ba226e1bso2936420c88.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792660178; x=1793264978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjfWDRPzYl5PNTaWP9ttZL/Fu+3IQzVkWXRGbtuepsA=;
        b=NUSImDFzb3kQx8acUDLVNMP6oF2AfsSZlkSMY8wQb/QoQUCDcdJrvVCf8CstpVW88+
         sEzxKcPZ2+oMZVikP1Gcz7FPu88E4fiKz5D5YLiiW76iZuy3PEfjcsnPWf+YM5l9EhN6
         mFIhZ7l4cfKjuu9KlS83g2RwwrCzMeD+gotdQwQ1WR6/giI+Q+6B3B082NxUhtvn2Eib
         OGBSrax1Jzm2ZL9QCYDO720l8xy1H2LAt2smMgFewhtA/NRtyHbDqWeonYKvAo5u1JQi
         KTFDCGY7sXiH+vkcelXfJ8jh8nEwUzmgZcPomCy8LyG8i8SSJbRx3Hj6Tl6esM3HHxsR
         68GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660178; x=1793264978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjfWDRPzYl5PNTaWP9ttZL/Fu+3IQzVkWXRGbtuepsA=;
        b=EMP/Dtw2P4fLUZP8WL++1kOeIMeta74mQqPf/ftRM0gQlqE23f+ZBfxIe+DErjvNfg
         txQWKqyBgXLktEE9+/bCx+9Qw/QZQhs7+bGlcstDO3qB0t1MEt+mDpIx7K9WE1RNGfzt
         xr7zcsloEncoopycRQOvobl79rePnEU93AB3Kl81KzZxiisL5fnDC+lWLHXfv/TzGRK1
         +CtFXnBKvGliVQ4nrSyv4YL0yp9A4pAry7xviqbz4DYwWjsAT+dCxPw7y3NT0PKI0+1R
         y6ObqH0yFVSnB61jHDZCzOSLtQ3jS/Khqw+oPS24+mNfFralYzKewkpXj8AmJgo8MXXq
         uDlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhlfoASqbA4s8o7e1seE1Qjo71653PK1/isWFI+azqxx988DRwvIMl8hG6hn4pJw15OggFbZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbYrjlwPDuv+m6uy0iTS8xxIRhJ1Yq0qUwTqZHbp/5yZ78M0CQ
	DKYhIjSbk1h8xLl+g70ZoH8euOcIiGdEYoBGUqvHokIPwSsEX54ucV5HTk8HNDESN+1EnDbgfNu
	a2bCqHZ5tEwcPFJ4vxpqbTyLcMW8oSIjdbup0zo4hBqVEmsm6bRYY6RfQQo0=
X-Gm-Gg: AYBFou3UI+nihSb6aO2rTLSIx6zt5c9++/DCr6Gv843bxR3kteSmb3szcoUXV16Fs/V
	iY5PiCeP0Q1Gnyss+2VahM2Eq4O2qNyx8gNsnkiIAHLTPCAuR8M0/p5y39Vb9TGF99LRCo9uSXq
	Bd5tODi5GPOT+wX29iiavqiIz7u0Nn79nk+QWL6oVo2tJNqnK+boX1kTAq8CVtT9T7+nDlHinUz
	Mke9/36AKRHwhzaw/SXXrZEPp5HMAzSfN6QhmdRyQJyAT661GxIMMrEDGzaaQxTqkePf5PONZKf
	zvpQ/UXL0LROCtT+HdKGmyhoGrePaUZDrdzS8oZWCvZh60O+s1EeqH1tsAkVfmlL22PZhGL+3gr
	fmcX9t5vP0YjgWTswVE8UJKt0NfP5GNiu
X-Received: by 2002:a05:7022:691:b0:149:d501:b990 with SMTP id a92af1059eb24-190a599a59fmr8274775c88.25.1792660177752;
        Thu, 22 Oct 2026 02:09:37 -0700 (PDT)
X-Received: by 2002:a05:7022:691:b0:149:d501:b990 with SMTP id a92af1059eb24-190a599a59fmr8274735c88.25.1792660177165;
        Thu, 22 Oct 2026 02:09:37 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180b9esm20475694c88.4.2026.10.22.02.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:09:36 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:38:48 +0530
Subject: [PATCH v2 2/2] misc: fastrpc: fix init ordering race in rpmsg
 probe
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
Message-Id: <20261022-fastrpc-probe-fixes-v2-2-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660163; l=7445;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=zUgEbnWLsDTknLyFxpzFJGnr20DIE7GXMRNqYKnIzjk=;
 b=rmpt0ZUKSJ5j1Ux8PcHksq0tkZILGFGnayKQum0+doGDcNPo84jXam4cm0VCiRZunLLFhVusl
 zEbfz+cg7LjDJUs7v9wtC9r9xYt6P8EdcjFRNLoXFHUlcz49rC15cb0
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX86sMuoySAH8T
 L/FiQi4GML3VSv4xuga0kf7jqc1Lsa+NCRv7q9RrhTKfVYFcbtALLr48PQ5KEyZdzamG0xbLW69
 sLYjHNG7mdQ0m5Vc/1af+RlLKtV6nhNbmMKJq5TU7u6YrI4b8dS620dP+vkUfNAAknCdpuzo8nL
 ifx8HoAZaRtVE42v3hTMunDmaqxkeMN8vOPtRngkDVaOE3pIEiv7EmFi/+AooJ/Ezp+22W7kqw2
 fw8WwOCo0bvmhdLYQIebejjh1tvu4+fT293yQrUcMA9lZgaStUGn9Be4PSfN1PzWcJtuHn+Fxfc
 OXJZs7ES3o/6luPGIaLrxM2E2NdkoX+m0VLxRJW3iLIFnbP8DWUBB2krLEaM/tom+K9If5zRYMc
 j3hd/R6+OAUqqKdgqZxOxd7zUHqXNZbylM+7i/pCA/AmsU7DGwaj2S1O5hbhlMN4OefW6zPhuKT
 hPFLZiDdWs5/wz2g4Mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX0LxbE69qSarr
 s1lrlp2YNYPSt59fSYPmoQ85vyqkuYihrjbFRf00DUW260I+SSaT6TJlOOLwS6hPviXxOXnZd9l
 i90fG2Yj4KPFzmFQEl02tijdAGOx8Tg=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ad9d2d2 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RafEaDNIwz_KoXd2q0MA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: ccP5CUczXjfcc3wHWl21_eI9VchPhKgR
X-Proofpoint-ORIG-GUID: ccP5CUczXjfcc3wHWl21_eI9VchPhKgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220036

fastrpc_device_register() calls misc_register() which makes the device
node visible to userspace. However, kref_init(), spin_lock_init(),
INIT_LIST_HEAD(), dev_set_drvdata() and fastrpc_cb_devices_create()
were all called after the switch/misc_register block, leaving a window
where userspace can open the device and call fastrpc_device_open() on
a partially initialised channel context.

On a concurrent open(), fastrpc_channel_ctx_get() calls kref_get() on
a kzalloc-zeroed, never kref_init()'d refcount of 0, triggering:

  refcount_t: addition on 0; use-after-free.
  Call trace:
   refcount_warn_saturate+0x120/0x148 (P)
   fastrpc_device_open+0x204/0x258 [fastrpc]
   misc_open+0xd8/0x1a0

Additionally, fastrpc_cb_devices_create() not having run means
sesscount is still 0, so fastrpc_session_alloc() returns NULL and
fastrpc_device_open() hits the error path which calls
fastrpc_channel_ctx_put() on the already-bogus refcount. This
triggers the free callback, kfree()-ing the channel context. A
subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
freed spinlock:

  Unable to handle kernel paging request at virtual address ffffcd5841510ca0
  Internal error: Oops: 0000000096000047 [#1] SMP
  Call trace:
   queued_spin_lock_slowpath+0x414/0x5e0 (P)
   _raw_spin_lock_irqsave+0x74/0x90
   fastrpc_rpmsg_callback+0x4c/0xf0 [fastrpc]
   qcom_glink_native_rx+0x6c4/0xf10
   qcom_glink_smem_intr+0x1c/0x38 [qcom_glink_smem]
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

Fix by moving all channel context initialisation (kref_init,
spin_lock_init, INIT_LIST_HEAD, idr_init, dev_set_drvdata) and
fastrpc_cb_devices_create() before fastrpc_device_register(), ensuring
the struct is fully ready before the device node is visible to
userspace.

Add err_depopulate label in the error path since
fastrpc_cb_devices_create() now runs before misc_register(); a
fastrpc_device_register() failure must call fastrpc_cb_devices_destroy()
to clean up the compute-cb children.

On CDSP/GDSP the secure node is registered before the non-secure one, so
an application may already have opened the first node and hold a channel
context reference when the second registration fails. Freeing the
context with kfree() there would leave that user with a dangling
pointer. Handle it like fastrpc_rpmsg_remove(): after the nodes are
deregistered, clear rpdev, wake pending invocations with -EPIPE and drop
only the probe reference with fastrpc_channel_ctx_put(), so the last
holder frees the context. Move fastrpc_notify_users() above probe so it
can be used there.

Fixes: 3abe3ab3cdab ("misc: fastrpc: add secure domain support")
Cc: stable@vger.kernel.org
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 83 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f280bff2edf0..fc09cd27af4b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2548,6 +2548,18 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
 				  cctx->vmperms, cctx->vmcount);
 }
 
+static void fastrpc_notify_users(struct fastrpc_user *user)
+{
+	struct fastrpc_invoke_ctx *ctx;
+
+	spin_lock(&user->lock);
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+	}
+	spin_unlock(&user->lock);
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2557,6 +2569,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	bool secure_dsp;
 	unsigned int vmids[FASTRPC_MAX_VMIDS];
 	const struct fastrpc_soc_data *soc_data;
+	struct fastrpc_user *user;
+	unsigned long flags;
 
 	soc_data = device_get_match_data(rdev);
 
@@ -2605,6 +2619,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->poll_mode_supported = soc_data->poll_mode_supported ||
 		of_machine_get_match(fastrpc_poll_supported_machines);
 
+	kref_init(&data->refcount);
+	atomic_set(&data->ctx_seq, 0);
+
+	rdev->dma_mask = &data->dma_mask;
+	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
+	INIT_LIST_HEAD(&data->users);
+	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
+	spin_lock_init(&data->lock);
+	idr_init(&data->ctx_idr);
+	data->domain_id = domain_id;
+	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
+
+	err = fastrpc_cb_devices_create(rpdev);
+	if (err)
+		goto err_free_data;
+
 	switch (domain_id) {
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
@@ -2613,7 +2644,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 		break;
 	case CDSP_DOMAIN_ID:
 	case GDSP_DOMAIN_ID:
@@ -2621,7 +2652,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 
 		err = fastrpc_device_register(rdev, data, false, domain);
 		if (err)
@@ -2629,30 +2660,12 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		break;
 	default:
 		err = -EINVAL;
-		goto err_free_data;
+		goto err_depopulate;
 	}
 
-	kref_init(&data->refcount);
-	atomic_set(&data->ctx_seq, 0);
-
-	rdev->dma_mask = &data->dma_mask;
-	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
-	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
-	spin_lock_init(&data->lock);
-	idr_init(&data->ctx_idr);
-	data->domain_id = domain_id;
-	data->rpdev = rpdev;
-	dev_set_drvdata(&rpdev->dev, data);
-
-	err = fastrpc_cb_devices_create(rpdev);
-	if (err)
-		goto err_deregister_fdev;
-
 	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
 		struct fastrpc_session_ctx *last_sess;
 		struct fastrpc_session_ctx *dup_sess;
-		unsigned long flags;
 
 		spin_lock_irqsave(&data->lock, flags);
 		last_sess = &data->session[data->sesscount - 1];
@@ -2673,23 +2686,27 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (data->secure_fdevice)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
+err_depopulate:
+	/*
+	 * A registered device node may already have been opened, so a user
+	 * can hold a cctx reference. Drop only our reference instead of
+	 * freeing the context directly.
+	 */
+	spin_lock_irqsave(&data->lock, flags);
+	data->rpdev = NULL;
+	list_for_each_entry(user, &data->users, user)
+		fastrpc_notify_users(user);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	fastrpc_cb_devices_destroy(rpdev);
+	fastrpc_channel_ctx_put(data);
+	return err;
+
 err_free_data:
 	kfree(data);
 	return err;
 }
 
-static void fastrpc_notify_users(struct fastrpc_user *user)
-{
-	struct fastrpc_invoke_ctx *ctx;
-
-	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node) {
-		ctx->retval = -EPIPE;
-		complete(&ctx->work);
-	}
-	spin_unlock(&user->lock);
-}
-
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);

-- 
2.34.1

