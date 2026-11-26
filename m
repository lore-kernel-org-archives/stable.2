Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696939;
	b=mYuvAILDKX5OBLMTFfSk77gtZj//ZSejiR51061EFKvT+IcuTXkTji3RAtkZegnXncv4
	 JHV2y9z0uUeDMaySDsVz9V19gh1pHZ6o6scbpui704CNF5IrAFXkSiy5jV39Z3LZnfP7z
	 KhHNfutWZLGUzQEH5sev3HqhVHJIILja1e8wdGDSenSuKudxCmYVglkY3dCgk9RxbTsnH
	 H6pE/PuXHJlP4n5JsmoHoFiwWNOorkl3ZgGtMZnuBm/YSnqYDT5gZRVF+BzXlX2tIsCbp
	 HLAbnGxK3HzB4N52fI8i+CFo2faLsMUI1qZnNG9jqse3v/6Ry3uMA5NHqlFdi8J2u6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=buMeQQDfJsDcXVlRtFz7hMPHQNqj9L9yHfXuPxjS13o=;
	b=AQO2sTE25tFsFliAEgFXf7aUsE6o2385AEkW7NpJ5KB19SGxaYuut5GkQfq1allwtEvB
	 5aFInroB1r5rpJfvjCY4/nI4131+F1gPWIvSuhAJATKj4tvFuMsQyVE4x3Nh/M+Xn6scJ
	 uZqxxy4b/vnHxvEIjK69g4g7GK6WJ5mVuPXF8xDQ6Yz2z7OaUgy5ml5U9L9yGSIkAbmjo
	 a+XJy70ARrtWq9YyNX9h5x4d1Qtxj1clv65ovCagXaeZmLIkj4Re2DLk3T5cobyrbV7gu
	 m3z3f81UadE09bUK9JEjU6f3bhLV52zbQf3hME5IEjzFFyf4/EiRhGnxdiKQYOy/vGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=OL0iv+DM;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF66606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF66606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=OL0iv+DM
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so63026405e9.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1795696937; x=1796301737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=buMeQQDfJsDcXVlRtFz7hMPHQNqj9L9yHfXuPxjS13o=;
        b=OL0iv+DMJtRYNrKRLTgwyzvZiNBVu+BWNFIAfYe+IKgR0EZaoGmpN3LiYHfjG+tVMP
         jSe/aO5M7YDNLxTllDcGo3AvlABhGT2r3CmP3GaYqHf7/9O1T292d9sFhMlyZtOvCWjA
         YhLwEuOz176lrq7NvXEDNZqECY1LbeJGdSp7sRhu6XsbCOap1KtJBEJw6ckl90DtiuUO
         Ajn66NTPyTYn/7bBkivQ8az3R1aNAjhBOlZS3mVbhRyxdC1pm2mXdTuz/w11LXrxmsoa
         f/Wiqp2vGnSpDCOzYGdf2h9SEqtuLrwE5BLqfVd1QmpKmvxg1grJ1/2Jp2GhyjKJwo/c
         NZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795696937; x=1796301737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buMeQQDfJsDcXVlRtFz7hMPHQNqj9L9yHfXuPxjS13o=;
        b=xrvEkyqLRVi84qgMfu3QCJgNMAEMivzkpfNkkix9g1tNn/R5aCNvpU8UD2ZFhP72mZ
         oPuckwR0PrhsZ8M+1Ayec3PwUy2YEeEiCTTF7JAUb2DV7RgPRkp0oicJGgSTJXCZg0Cz
         IvEEz/wU7IB1iwjfjlBvei+/E8t/uW2SIPw1MeJJuile/KLAkpkzpguttTHYCaSX/lMw
         TVVpmp34hLlEFgenqYnQLCPkeg2TU65imxOszwhp+vA9uQRU6jW9VGN2OPs5ceudiKVd
         8WvIVKzXmFgn0HnhlljUfYM4IvMx4wJyt5kqvOnvhqLqM9sNu30ryjmFiLjvGNFFhG0Y
         OzGg==
X-Forwarded-Encrypted: i=1; AL+hErFr2QuGYaZvUHRQliOsC5KcuGwteI7WkkUscR0x+6/yd0UQp7GNOQ5oGsaQtbFdzGQygsWQ5lc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P9futhVy9yYGKdd4/QB/7W+gXcIfBXeqtI+35rQaD+7d2V/GZ
	p3NI6LgTJ7AHcY26+1X9ofNLgS1K+4xHMRBrhrtk2K827VnXQD+vOqFCxEOnHtEJr4s=
X-Gm-Gg: AZFdTZcwR30tbbITCileGH5qCig9GiprRJ6dMwDIaD6NHImj3cesEKk6+B6ayB2IxIr
	qjNZITw99hEFGOANDYxUFDwSxQTMT8DL5iiJ7PXK5cavenxwia0kM/hVHLA6629LSCmU+8vGCig
	05i1MjLEKhTuM0rxfJQPu8I7PtvTKlMlwVt0DPtNJ2Q0kcBi0BsZzA6Gxde7QrMqZGmslxZxBif
	AZr3WW+hso9brkMXGaoy616Ge1Fo1nphQRzBFLF1lF4tRiCp2zJbBDrcn88Aqkx/8gIqcOA24dg
	U5BIvTdehDL7zqBmt659Bx3GkvR/1MwGcv/cVh/3SQPy6an9OO8nMA1Y4a38Mp+FK71XAr+ZyOR
	BGtry9JUToF24MaTqT3oCHES9O1RDKaf+ygA/XYS6R2Kx62TX52NOGBelzVLArrn8dt738kAxXd
	+LT+X3JiCPw/3YiFJtQLV2oeukDr58Eq/Vu4VpKeaSqxAKjOOW/3ea3cDZw8JOIZch+2Vhke1L7
	f24DdC9/3f+GqDFGHt2YSOiB3HaXyWmzjMFuEpOKkuwZvdmn3s9SJ3x36I3rUecOsz1Zo88/Ffw
	7hk3F1ZF8u755wbZ3pN+Z3cmq8zdWcnKigwhdpUaQyquYArVRm4R/eu60W+S5lxtXQB0xQ==
X-Received: by 2002:a05:600c:64c8:b0:4bb:68e5:b952 with SMTP id 5b1f17b1804b1-4bb88819be1mr398470945e9.16.1795696936947;
        Thu, 26 Nov 2026 04:42:16 -0800 (PST)
Received: from JureBuildPC (46-150-36-237.static.telemach.net. [46.150.36.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm577708965e9.8.2026.11.26.04.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:42:16 -0800 (PST)
From: Jure Rebernik <jure.rebernik@luxonis.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: konrad.dybcio@oss.qualcomm.com,
	mukesh.ojha@oss.qualcomm.com,
	val@packett.cool,
	linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jure Rebernik <jure.rebernik@luxonis.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] remoteproc: qcom: pas: Request stop before tearing down GLINK and SMD
Date: Thu, 26 Nov 2026 13:42:07 +0100
Message-ID: <20261126124207.2665762-1-jure.rebernik@luxonis.com>
X-Mailer: git-send-email 2.56.0
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

On QCS8550, a crash of the ADSP that the host reports, for example
through the remoteproc debugfs crash file, can reset the whole SoC
instead of restarting the ADSP. On two QCS8550-based boards, crashing
the ADSP about 4.5 seconds after it had started reset the SoC in 19 of
42 tries. The system stopped right after the recovery started, nothing
more was logged, and the SoC was reset 6 to 7 seconds later.

Since commit 0ea50486978f ("remoteproc: qcom: q6v5: Request shutdown if
crash is triggered host-side"), qcom_q6v5_request_stop() sets the SMP2P
stop bit also for a crash that the host reports. It is called from
qcom_pas_stop(), which runs after rproc_stop() has stopped all
subdevices, so the GLINK and SMD edges to the DSP are already gone. The
QCS8550 ADSP firmware treats the stop bit as a fatal error and runs its
error handler without those links.

Request the stop from a new subdevice that is added before sysmon, so
that it stops after sysmon and before SMD and GLINK. The firmware then
handles the stop request while its edges are still registered. Crashes
that the firmware reports and graceful stops that sysmon completed are
not affected, as qcom_q6v5_request_stop() still skips the request for
them. The call in qcom_pas_stop() stays for a stop without subdevices.

With this change, none of 104 host-reported crashes on the same boards
reset the SoC, 24 of them CDSP crashes.

The problem was found and this change was written with the help of an
AI coding assistant. The change was tested on QCS8550 hardware, and I
reviewed it and the test results.

Fixes: 0ea50486978f ("remoteproc: qcom: q6v5: Request shutdown if crash is triggered host-side")
Cc: stable@vger.kernel.org
Signed-off-by: Jure Rebernik <jure.rebernik@luxonis.com>
---

Notes:
    Changes in v2:
    - Shorten the changelog and move the test details and the tool-use
      note below the --- (Val Packett).
    - Rebase on rproc-next f39ba58941ef. No code changes.
    
    v1: https://lore.kernel.org/r/20261109175752.793130-1-jure.rebernik@luxonis.com
    
    Testing: Luxonis OAK4-S boards (QCS8550) with a kernel based on v7.2.6,
    which has 0ea50486978f as stable commit 0dc9e289bbb5. Crashes were
    triggered through the debugfs crash file. Without this patch, 19 of 42
    ADSP crashes 4.5 s after start reset the SoC. With it, none of 104 did:
    40 ADSP crashes at 4.5 s, 20 at 4 to 15 s, 20 while the ADSP was
    streaming IMU sensor data, and 24 CDSP crashes. A crash that the
    firmware reports could not be injected.
    
    On v1, Val noted that a subdevice for the stop reads a bit oddly. The
    alternative is a hook in the remoteproc core that runs before
    rproc_stop() stops the subdevices. That changes the core for every
    driver, so I kept the change in the PAS driver, but I'm happy to rework
    it if you prefer the core hook.
    
    qcom_q6v5_adsp and qcom_q6v5_mss also call qcom_q6v5_request_stop()
    from their .stop callbacks, after the subdevices have stopped, and
    qcom_q6v5_wcss does when requires_force_stop is set. I have no hardware
    for them and left them unchanged.
    
    Built for arm64 (defconfig, drivers/remoteproc/, W=1) on rproc-next
    f39ba58941ef, without warnings. Not done: sparse and runtime tests with
    lockdep and the other debug options.
    
    Tool use: Claude Code (Anthropic) ran the investigation and the tests
    on our boards, found the ordering problem, and wrote the code and the
    changelog. Its first fix skipped the stop request for a crashed DSP; I
    asked for the request to be sent before the teardown instead, which is
    this patch. I reviewed the code and the results.

 drivers/remoteproc/qcom_q6v5_pas.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 57a111a0d7..ddbffe45d9 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -138,6 +138,7 @@ struct qcom_pas {
 	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
 	struct qcom_rproc_pdm pdm_subdev;
+	struct rproc_subdev stop_subdev;
 	struct qcom_rproc_ssr ssr_subdev;
 	struct qcom_sysmon *sysmon;
 	struct platform_device *bam_dmux;
@@ -429,6 +430,14 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
 	qcom_pas_pds_disable(pas, pas->proxy_pds, pas->proxy_pd_count);
 }
 
+static void qcom_pas_stop_subdev(struct rproc_subdev *subdev, bool crashed)
+{
+	struct qcom_pas *pas = container_of(subdev, struct qcom_pas, stop_subdev);
+
+	if (qcom_q6v5_request_stop(&pas->q6v5, pas->sysmon) == -ETIMEDOUT)
+		dev_err(pas->dev, "timed out on wait\n");
+}
+
 static int qcom_pas_stop(struct rproc *rproc)
 {
 	struct qcom_pas *pas = rproc->priv;
@@ -1012,6 +1021,15 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	qcom_add_glink_subdev(rproc, &pas->glink_subdev, desc->ssr_name);
 	qcom_add_smd_subdev(rproc, &pas->smd_subdev);
 	qcom_add_pdm_subdev(rproc, &pas->pdm_subdev);
+
+	/*
+	 * Subdevices stop in the reverse order of addition. Request the stop
+	 * after sysmon has asked for a graceful shutdown and before smd and
+	 * glink are torn down.
+	 */
+	pas->stop_subdev.stop = qcom_pas_stop_subdev;
+	rproc_add_subdev(rproc, &pas->stop_subdev);
+
 	pas->sysmon = qcom_add_sysmon_subdev(rproc, desc->sysmon_name, desc->ssctl_id);
 	if (IS_ERR(pas->sysmon)) {
 		ret = PTR_ERR(pas->sysmon);
@@ -1049,6 +1067,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	qcom_remove_ssr_subdev(rproc, &pas->ssr_subdev);
 	qcom_remove_sysmon_subdev(pas->sysmon);
 deinit_remove_pdm_smd_glink:
+	rproc_remove_subdev(rproc, &pas->stop_subdev);
 	qcom_remove_pdm_subdev(rproc, &pas->pdm_subdev);
 	qcom_remove_smd_subdev(rproc, &pas->smd_subdev);
 	qcom_remove_glink_subdev(rproc, &pas->glink_subdev);
@@ -1081,6 +1100,7 @@ static void qcom_pas_remove(struct platform_device *pdev)
 	qcom_remove_sysmon_subdev(pas->sysmon);
 	qcom_remove_smd_subdev(pas->rproc, &pas->smd_subdev);
 	qcom_remove_pdm_subdev(pas->rproc, &pas->pdm_subdev);
+	rproc_remove_subdev(pas->rproc, &pas->stop_subdev);
 	qcom_remove_ssr_subdev(pas->rproc, &pas->ssr_subdev);
 	qcom_pas_pds_detach(pas, pas->proxy_pds, pas->proxy_pd_count);
 	device_init_wakeup(pas->dev, false);

base-commit: f39ba58941efa63e6c7d10d53d183d6077524bdb
-- 
2.56.0

