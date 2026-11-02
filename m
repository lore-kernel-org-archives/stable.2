Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591579;
	b=5sodlM6TKFJ5tOWs927SWsZaLUmkhibutdE/H4/6w80nqPK38xdqXGXB48zgFc9hADQ+
	 oC1iGy54XJfApmb8YDr9e44bjJL2jPlzF3NU5nGAD23FAUmYuY/4Ix24dCPGAkoS9rEKu
	 zflxQF83p10zAn+8FHCKssTLM23RR1BoyIXfNW9b6c9lg30AsZ8SjoG6t8AEUrVVd8aMy
	 xq+Gsbjr40gFrZg1RskDnMIykNUe+O0u2+Pwq/AElXbXOcm45+stogPb86e6LkME/uAAM
	 97nJEZazjxQSVe0B4Yi6VI9AUNSTH0C3ItW0iizbi/aymZs8NI4SzjQs5Lu6fRJEezw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GEgLVAromPaUrH1jitVPbv7vIRjTpekHb9MijwFJEpQ=;
	b=k0bpfLUyLW7Pbq0AdKJtlrj5AYYYl6pzZw0T8xBsOjL2kEHzoXPIV1N7uaswxd77SNN4
	 EKj/c6jvuDBMFPf3KjWhMouFDm9q2Y6mwhefaHyTrTsIKKaUPaEK8+iytfsHjWsDOZIu0
	 MTNoGP4Gs3s9ueSA/QgJrcbxWQUfgru4GB8QfGvxYybu62zOEJ9pZjO/nVMAvz79KafA6
	 YC372f8QY+DUvC478WfggRozP0Fd2dsUVdD05yuI3oK7hEwe0VfFPKhc2IXDBHJLgFqo+
	 mxSytrCRTDuPeVh6dmkwq1vuMadaf3NuTwjmsrGac47I+b9lcRF7pWEcIbwVxyhTPow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MWK818G;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CE606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 03:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 907CE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MWK818G
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so58756a12.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 19:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793591578; x=1794196378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GEgLVAromPaUrH1jitVPbv7vIRjTpekHb9MijwFJEpQ=;
        b=0MWK818Gv28nmlTZO12RnNRMhWyi8fhmOjVscQpXx2kRVjMDCPCCYP3SdiYSpuC5nS
         TdyNkGi10iE0/mH9ZaUN7V9IC+2sGF92ZZn2ClOlgB3IwitEfOVVu6Wq+Brh8QW35R15
         iEObQv7eQbKWb/IhUaQ7/TPyavQJodNOn1emrXPgD1XL1P7vJcD8ZQSyhlgH7mOJtwrq
         7ukFqIHqtIzvhT1GN+a3/5yefuvLScma8vNQV9B9X7FrWItWXfdYc+Y1nvDTSVvUKQgz
         JPNZrPZAGwZqavUPdIbenu0Oc33XFW9s4PVxNkmDxWrT2vhnI24F8iRPWdg+DOhMYZVs
         EcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793591578; x=1794196378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GEgLVAromPaUrH1jitVPbv7vIRjTpekHb9MijwFJEpQ=;
        b=aoPoc+vQdRir85bcXOyxUHCNNbBxfcmH9H59So1hVbgeXFaWNFkicI0s5IhohLzSlz
         mvUZWCvpSyq1EgyxRER4xnONU7zmmk9goFni2ggDwsHlH0ozyOx7bsQtV7yVcOe6YBn9
         TmC3vZRaCNXZarbyNz8DHevRhY4WcnSntzXrVumySHk/4Ux/9QZ07bW+oaMm1ySAjePI
         fwDl9v52NLFfb0G1CXvgFNKNXrWl74sGtbiKKAnmHygsbtpnc9uwZ0rt5qRZvJWgJJ5W
         TpmXHLN6Rap/q9LHcJNJneYKWYW8pQZbF7Md4620m+W5KrEiQa1L/wpKxZasv8HyAzSq
         +hNg==
X-Forwarded-Encrypted: i=1; AKwUvBzYf08aPI0uqe87alP85JO4bIc8QBc4YzrbkhGcGS1cV2Qru5Ikag73VxY5mpA9Z5IHOfEAaaY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PDlF1S3iqaC24hjtNKDdGUWxy82Zg8KYQpRAM3u5Z1+6NyEoz
	ytv/jsxunOVrXTykJXnHnetRGGG1w6U6hdZcbBhiax7IdttZEkRxlDpz
X-Gm-Gg: AYBFou3+I0qV4w1P9BZIbriwfi8Bx/UsACQ0hZgb//K5W9BioW7UukjrHJpDux19vf8
	jwtJZu6U/xN+wnACp1G1KIdEJ8nQJa//5bYGWIot65Zo8kGte77e21G2D1FUqxcBLmok4tCt0pU
	MeYzj55xjX+GFv+qarDLHnXbyfOsyo/nlOyYQ+ZGFWqb6UQFb2Qdc5BfwXqYDJIwomuFH2FQa9B
	udI7SaM6RJaxCFuzutnKiUCXMtWhOCiyVDFmiFZDMO0AS0v7jsLO7oV59uQaAS9VnEe8gkXyTJG
	vccgg6OK0qLUaERjrWStC4CT4GrMiEqH1b++OduSbre83myy54K8/iVGhExuA+jWrtxaIhYI5IX
	MLqZcm2rxSWVJwGy2l3MtUj6J12M6LAGGEV7DF5JlaWVgXU6ebvh6DWT0T8bB0jvsFmOvKRsg2X
	aMg2I30ryuO6oKxtcpZIXgAGPhW0lCTkHNqU0K6kbla60duttk3xSHHR946oqFiwfcIm0nHmPSw
	jDbs4vFY7AZozqAAwR+lenC8fR2AP8O00pfpXUZOv5HGI2ENaD93KdiWQQsWlMxU/lz6gpIetLJ
	TLGkmm6vzfTiz1paByCK4y9u2xm3hyUcjPD8mvEnBrqBoZ9LubyOcdCn1PM7lXWGVAc=
X-Received: by 2002:a17:90b:580d:b0:3ad:25f6:1dd0 with SMTP id 98e67ed59e1d1-3ae8970e5e9mr6935025a91.11.1793591577770;
        Sun, 01 Nov 2026 19:52:57 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:50b9:9b10:1e19:1f0a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae880b1f71sm6998814a91.4.2026.11.01.19.52.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 19:52:57 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: wesley.cheng@oss.qualcomm.com,
	raoxu@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: qcom: Check the return value of qmi_handle_init()
Date: Mon,  2 Nov 2026 11:52:37 +0800
Message-ID: <20261102035237.56253-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qc_usb_audio_probe() overwrites the return value of qmi_handle_init()
with that of qmi_add_server() without checking it. When
qmi_handle_init() fails, it has already freed the receive buffer and
destroyed the workqueue, and qmi->sock may hold an error pointer. If
QRTR is not available, qmi_handle_init() returns -EPROBE_DEFER and
qmi->sock is ERR_PTR(-EAFNOSUPPORT), so qmi_add_server() passes it to
kernel_sendmsg():

  BUG: unable to handle page fault for address: ffffffffffffffb7
  RIP: 0010:selinux_socket_sendmsg+0xa0/0x590
  Call Trace:
   security_socket_sendmsg+0x29/0x50
   __sock_sendmsg+0x43/0x150
   kernel_sendmsg+0xd6/0x180
   qmi_send_new_server+0x1b8/0x2b0
   qmi_add_server+0x165/0x200
   qc_usb_audio_probe+0xf4/0x2e0
   really_probe+0x2b4/0x850

Had the probe gone on, the error and remove paths would call
qmi_handle_release() on the half-initialized handle, which destroys the
workqueue and frees the receive buffer a second time.

Return the error from qmi_handle_init(), so that -EPROBE_DEFER defers
the probe, and check qmi_add_server() as well.

The bug was found with kbound, a static analysis prototype for
ownership mismatches at kernel interfaces, on v7.2.12; it is present in
mainline.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings. Run-tested on QEMU (x86_64, KVM) with KASAN and kmemleak, with
the driver built in and a test module that registers the
q6usb.qc-usb-audio-offload auxiliary device. Without QRTR, the probe
crashes as above without this patch; with it the device is deferred and
removing it again reports nothing. With QRTR the probe succeeds, and
removal reports nothing either.

Fixes: 326bbc348298 ("ALSA: usb-audio: qcom: Introduce QC USB SND offloading support")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described above.
    
    The runs were on mainline d135ab453a74; the code this patch touches is
    the same there and in sound for-linus, which it is based on.

 sound/usb/qcom/qc_audio_offload.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index e4bfd43a2488..5ee568e0454c 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1969,8 +1969,13 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
 			      QMI_UAUDIO_STREAM_REQ_MSG_V01_MAX_MSG_LEN,
 			      &uaudio_svc_ops_options,
 			      &uaudio_stream_req_handlers);
+	if (ret)
+		goto free_qmi_hdl;
+
 	ret = qmi_add_server(svc->uaudio_svc_hdl, UAUDIO_STREAM_SERVICE_ID_V01,
 			     UAUDIO_STREAM_SERVICE_VERS_V01, 0);
+	if (ret)
+		goto release_qmi_hdl;
 
 	uaudio_svc = svc;
 
@@ -1987,7 +1992,9 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
 
 release_qmi:
 	qc_usb_audio_cleanup_qmi_dev();
+release_qmi_hdl:
 	qmi_handle_release(svc->uaudio_svc_hdl);
+free_qmi_hdl:
 	kfree(svc->uaudio_svc_hdl);
 free_svc:
 	kfree(svc);

base-commit: 56abaa599bbbee5500e166ddb0b5241a00c1f763
-- 
2.53.0

