Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835672;
	b=Mj7qDd1JrHOrlr2VYKEa2PSCmFxq2Jx2pxS5w+OX2XKYkIjfKFLZ4VHu7O2Yj3+xWAkx
	 xWGSCTaY2VOY6wktEW02/uimgAWsTCYobrxeDe/O/FlZ6yag0TcYWsWYbIVX7dew42WTP
	 f1MKAPcLM4LcJJJKRTPgCwzCv3NSRHyuQY75pTNwRt18vu4r/vdUx0Wq1APLt/jw9VDFH
	 hrXl0CgYRgn8t0O9GeZksHsgoKoMs08nfkN/mdkrEY9XmNoUSAi2LJEbAlyE5jRctg5/Y
	 1co38huIoBRS+P1WLt6rkjimqTIlwotd4ZrPIXM06qIKMsvk1vc4UQV7kTx80THFTxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835672;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yB4vhmX8LJqMQXdmvmg7Cv+GYdpTkKp1iqoONUm0PhQ=;
	b=dP5HoGIaahaT0TWZI5nufV74pKIG41ywM5yE1hmkCdLym9i/jrmUg8PaIxtd1NDR22zi
	 mPB5hC05nOb1VgRilMoNtQ5KST+yKhdF0wZabjWfKtWjq3rL9FWQPBeE/enZqrSvC/MZt
	 XQOJWQZ6lYPjIG26Am0SWyXagEMoMVypVjdVqy8o4VZH0bLym1lPSnszQ3vUgdUP4f5y3
	 rpS/Pj4YIAiTd7xuWrz0ziGkJKJo+0tiNz5y3KGL9MZqWL/L2DhmvDIzG5woFMsac+tyU
	 iv/XTNrfQ0pvl0/dKW/YBosfZvWP8cg9oIyDXKUqw9kTca4GBzh3WBBNxXOsUGBt4VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PQJ8cY6I;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fv4BcrXx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9A606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE9A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PQJ8cY6I;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fv4BcrXx
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC13x22472868
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yB4vhmX8LJqMQXdmvmg7Cv+GYdpTkKp1iqoONUm0PhQ=; b=PQJ8cY6IVFPUisdL
	3hEH2ASZpISmi62fScxpd9wwN2bM0hIreX+tjRrVyv55GzKOfCnB3D4XqloukzNJ
	U5yDPoqGzeNX7LIApoSPR/01kxD59fWjFq8KK4zaFamwQ2rbit/leEr2nVxtI70/
	NiIAc7+RZUCg6RGuvQkL8JAtrsS/oD7Ijvyk6GVZWlDyeBLVIlxjWrRb6FLOCTM8
	WTO23OU9h/+bcyAvVE+B8qyEPVbS7MmGt+qqFL+Sij86ro/10bFbK+N0Y5/Rt1UI
	qJNFsKklQxeAwT0nBK/rDNnub3mepxS9x3PjCmsvGnxWB5ipN7kUJIkj4lcZVkGc
	Ba2fqw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdxjqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:51 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8520e83f715so3927857a34.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794835670; x=1795440470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yB4vhmX8LJqMQXdmvmg7Cv+GYdpTkKp1iqoONUm0PhQ=;
        b=fv4BcrXxvRpzQRUofQ3Z7uBe5A5z/e+1yQhRQQQimDIw4uEzIi7gGY7LejEgEfXa7Z
         NlqmFKFioHUpc9TX2ft5D7dqAb8I/fqY2ldCFHrE59M6DQcXg42H57LE22J24jOUA6vn
         cuezz9/tvv91lm58/23SbrYICIBsw8+KYHbNwn1xsLX1shEVHRPL7WDpAkoI0Uupy6wU
         wXt+XPIvrIIJYnqN6EQhXwoQkihknMkq/kJiQrOS9T31FX7cDvXCWg+vXrdeWcy8gaVM
         70YGtSbNO05ejXm3R8JDezOgCI5agXXEhoCj7ac3yhLZwskHKM6/Igmd86H52Nx5DiVB
         6O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835670; x=1795440470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yB4vhmX8LJqMQXdmvmg7Cv+GYdpTkKp1iqoONUm0PhQ=;
        b=kU1+v/6F5LIRmXtvQGQc4pYFSrQQj/Vdji7qOWFfVQ03tQUrLukc/wY7GraV4V8FqP
         PSkdkrjALHf6LC+J/Na6raeTx6fhk9WrrirqTl02nOUGVBYH33SlJLWiWCyhls4W4PTm
         60Xyon3PJhn/EFXZ+GTdVq71qcbSd4KblZ1v2J6f84KYJAbXfFMP6Nn9RyVfdMqJMp7z
         ObGUPZjAhKIhiBEEZi5+TT6bWvwhU9ThVmLvioOoos6oLXSiFxQ7irNPxmLTlqkQny+q
         +322XuQvCivjGZwSLcpamyV5a8yIyzO0UirL3Iq/rSi1U92GzHvPKAyvQLskaGhEPpf5
         OfIQ==
X-Forwarded-Encrypted: i=1; AL+hErHjFaLnsaK3vTzCIC3sEEHbOS1jf7qmzYUtjRkB/cQZ0aggSpbM4SPOZOvUT28cyAR+9ZRaPEY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JXDmVYXkry3ZUT12fnPJlVuhraZ050Jq+mDrAdLfTZ/bzAdQq
	j5b0PPuIniXxAmFJGyEbfpJU7u/1umzu2x3ly+P8lMqb0baC1tyIyBB7e56j6JvGlgCJKlQPw/+
	4Kn71tOpYcy4+C48dSZXUCr7cFoChDOCwxmpMxaAZEBKZKFXAF+65RppRp6DPIgcUifY=
X-Gm-Gg: AYBFou2MRmWFla4LXIoKUPUGlubkeqJitBSXIjt6TkZPpi6l7OWcGrIAuz4scoy7Xsw
	XFK/66Dh2zIQbAvKvYx8AlDN/V3ind1I9FuRtua/PYj24TyeI8wYeWZrg2Wd9Ndfe3+LCx5vwu3
	Kjx1k7AedVXHn+csAkON9xfiwMtSgdPcEQ+1GV7sZ2GyaC0DBKNb9uguF2CHuFsJ73y1gvuknEZ
	1+5oeXv9F0f7tSd3tUblXy7EpW6CdtjfieZn72btj0M4tqPoCFxIfiHYpq+mXLA3/bNLLwFM6L3
	/oBjFtI8LIYCWA/bRm16LDNUPhei3L0gyIQyiCSWitGksdLDp/4xvuavV/leslLatjuss9Q30S/
	mlGVeKjtv05Ymf+c6VPeA+XgywMdXmJ9B3yNmKhtxSpwXxuZAiVB6nKYN7SStkJ/XA19RsZnwcF
	zGyvHpoJY=
X-Received: by 2002:a05:6830:230c:b0:822:a034:551f with SMTP id 46e09a7af769-86289738d61mr13675514a34.2.1794835670211;
        Mon, 16 Nov 2026 05:27:50 -0800 (PST)
X-Received: by 2002:a05:6830:230c:b0:822:a034:551f with SMTP id 46e09a7af769-86289738d61mr13675482a34.2.1794835669778;
        Mon, 16 Nov 2026 05:27:49 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628813346esm10012527a34.17.2026.11.16.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:27:49 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:57:31 +0530
Subject: [PATCH v3 2/2] misc: fastrpc: fix init ordering race in rpmsg
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
Message-Id: <20261116-fastrpc-probe-fixes-v3-2-3cd56d9d9a93@oss.qualcomm.com>
References: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
In-Reply-To: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835655; l=7239;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=mOJ7uI/VgM/jFRF26pl7PPi21PfhoBVe9lFM4JnZ1wk=;
 b=TUVxdvAh6Qs1NQINSZTFShL3QR/eYlqzMRrD9L484wiSa5fYRDh3NLH40GPwMtKRkzvme0hmB
 KRBtbp1HU6sCJ+D4RVz9lr+UEbh65sdfnagAyW73vHQmfk0gS4lLXbT
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afb04d7 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RafEaDNIwz_KoXd2q0MA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX/m0JBjscRFTD
 5uDshxBoloLNToWVf836D4gvWysypQphWH+X6HK+mvI877byARBmWFAZ2QzzsI1thlnAQ0un/zj
 gyB5lO7E1Gq2BwO825EWYxtygBNZgCc=
X-Proofpoint-ORIG-GUID: Qltujc1XiiM8QZBdO_GsUuoiY1NjQEii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX1+pkipF0l00h
 KHtpaYxAQmkVcR2uA11X/hv6JGQLYe75866r/dsWtkzRkxSmId32W/GE2fBhdvNEEHyeVd+fgTf
 B/tUW5cQlXOKtbx252rBWWYjkIE0Dx3cAIRDwhbjgrUu+29Dm1gmjjgXQpVgGzaPDKyUBvKOs0n
 yScJlbLN8epDbptvqBWOVWLdLonLTLco3AEBnZTfiWqudaU117MQWtvhKseXWJqi07BC2VHBnVA
 OwcVO61gbFGYaN8FaayoME5LAqp0CmbQr3TZaTExERWdJONZp94e6at0Swhe9VnNkhYx1siCk/H
 zl0LPTTih65hCEihoCAL4gxpknfHyhZWFlzp3qBFRMG1ZcQGio0LOrYNF6G9rzl2LiKy520PBl7
 wY00B6xLyMLnAFa2v7MzxXSnrJ2fIb4OfTE6zHWrHZZ0wQkGNiQ0GQ4fv98Yk3BwJaYQ+h45Tjy
 Lh3bC1b3ehb1Q2ImnFw==
X-Proofpoint-GUID: Qltujc1XiiM8QZBdO_GsUuoiY1NjQEii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160053

fastrpc_device_register() calls misc_register() which makes the device
node visible to userspace. However, kref_init(), spin_lock_init(),
INIT_LIST_HEAD(), dev_set_drvdata() and of_platform_populate()
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

Additionally, of_platform_populate() not having run means
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
of_platform_populate() before fastrpc_device_register(), ensuring
the struct is fully ready before the device node is visible to
userspace.

Add err_depopulate label in the error path since
of_platform_populate() now runs before misc_register(); a
fastrpc_device_register() failure must call of_platform_depopulate()
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

Fixes: 965602eabb57 ("misc: fastrpc: separate fastrpc device from channel context")
Cc: stable@vger.kernel.org
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 82 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index da0b2333a3ca..0bbc1e00001c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2542,6 +2542,18 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
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
@@ -2551,6 +2563,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	bool secure_dsp;
 	unsigned int vmids[FASTRPC_MAX_VMIDS];
 	const struct fastrpc_soc_data *soc_data;
+	struct fastrpc_user *user;
+	unsigned long flags;
 
 	soc_data = device_get_match_data(rdev);
 
@@ -2599,6 +2613,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
+	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	if (err)
+		goto err_free_data;
+
 	switch (domain_id) {
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
@@ -2607,7 +2638,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 		break;
 	case CDSP_DOMAIN_ID:
 	case GDSP_DOMAIN_ID:
@@ -2615,7 +2646,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 
 		err = fastrpc_device_register(rdev, data, false, domain);
 		if (err)
@@ -2623,26 +2654,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
-	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
-	if (err)
-		goto err_deregister_fdev;
-
 	return 0;
 
 err_deregister_fdev:
@@ -2651,23 +2665,27 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
+	of_platform_depopulate(rdev);
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

