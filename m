Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247093;
	b=ZbTuu85Q6zpfoAv59HOv6zFoSeP8R/HrJsI17LFQQU0VpGmwHe//qpnKMjEX1g62Z2Kz
	 QLvsGwQAL346a6fi78D+GuoQAkiX+3LZcXj4RdH7HXRWym1/zoAG/wnu6By8m5DfIR2dC
	 GOHzAKPoI+SJ4J4qhVwgtSXVD3MEgoM4/lehZ4DZ+4lrhhK/TWVoYMGvLsUMZRpi12Wqj
	 j8QwxKLLXzFLxe3tMHAQ6uaTtbDbkhI34evQi2uNZqQE/QvKjP3a/lzFdNgfEWR2++DFV
	 jvdwp6JdTYqYn624vzQ/V5k9MdpuuMNnwkUMq+A25QeRH6iUsKISfH52CGcAikYd6uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NQFcBegZVinznGcGamAVLxh2DaKy3WmcCJmY9lmdZkM=;
	b=iMapCH928LghstQhJndUmNAOwJUs13Tj/I3LB56xqYMFPjt9wKLAwRdZYEjDySTgn4rr
	 oJfwtIdObEvWit4VsNF2XMf1qWe4oOoQa+plSVeeIVM6Ktty2SmjvdHsKKNhwUfOrSx2t
	 nW8ThWI6YiUbXknjkVhz7h1Kfp3qqjU63D8UKy5iGJ8MdpTkbrVUH7h1KS70cXTHdL+IV
	 XeJNLfZnT8QAaAxFXtbbEClFkd334f5Bktun6lOXZpciRwLCKPa9gsalF5bQwMWM/0WUr
	 pHUozOXLvUNhED/oBDrjTJFRpMl4TwE3Z3j5P/wY4A5173I/AUeOsKA/f4XIYbsj3hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=hVX0AILp;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69300606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69300606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=hVX0AILp
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e47347279so784662f8f.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1794247092; x=1794851892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQFcBegZVinznGcGamAVLxh2DaKy3WmcCJmY9lmdZkM=;
        b=hVX0AILpInoPfFisEkn/YXDFkZzXheGdiSemxWWm0t5cmFv4OFi+6aXEbTUaM3mJox
         h1bQ5xmMku7mNUGnqOyBK+rA6jXs5x3sUZ/+0OACH3kuy/E+2694CldtctlFo2kkqDJf
         ivyCrJT7ZVn5StfQfVydFKmVHapg05QbPWTzE5ywJs/VQz9zrW/CgHt2asoB6yH0zyz4
         2+MYYPO7SJMum3X7wnYJ0iC7cR/2xhKqXfm5J49tinJTqSF5Vn+M40KNXAfs6mcGb42w
         bVK1e7wZrrEYzb3K4jkpGiWL6Bo/kQHZir/pi6QCuwtr3wLOqxIUIUb+u+fgdeCorrgF
         2ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247092; x=1794851892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQFcBegZVinznGcGamAVLxh2DaKy3WmcCJmY9lmdZkM=;
        b=niuwG/sh49MuJS16F978dCbLRw1TEqqPXqhW5PukM+p2d59SMDgRJ7WXhIztTK9V6y
         H3wZeb+QbikpLBKo9h0iBn/HDdOEjrnXRCFQrWKcmnXW7o2I5bO0EWQ2xYaRUCwOwdg2
         ECkd+A73aJcmiuC4knK/6KCx8ua0gKIgfgM7DigYnWbpnnG8GZrfvWvyjTsnJDYxX7FB
         hZKFSF14B3g86QwNsGgWjil86PupXd7HpvQjhl0n0Gnln+mMFjePjTWnecaq12GWCISm
         /iVtyOuKtwW0g08/jiT3xj+EC1q+s/V8AwP8PDm2D8OTdqED3Yr5nbqwwyraI57dIXMY
         FIxA==
X-Forwarded-Encrypted: i=1; AL+hErGmHkWqHZbPJCVXauDOESB8CX4Fj1qvQhrehgzZuIiqgGweQbVneOsT13aZHqYxhbH4hzo83nk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/l+aKOiqxVfxt1xYcFQlpoQpHVl/7z0jRkQrY/jC15c6vRizBm
	4Frzn4CCd1XgEEcxUQhlWYlBW2uROt0zlJYp8P3yh2Sxb/afF+/cQYNkh2LDNp/LXhU=
X-Gm-Gg: AYBFou1ybF8iWZFE6ATb4IVHtMmmNYNVvr8bXUIaitrHOzXrnjxXp97lxTOElswKLlL
	jc7sYzqgpalhm17K+E8j+714thSNKnIa6aJjbPGinveJrQ40coF2uMVMaBNZGoY7QBwCAJX+CZb
	mjtEoJEZO331CtjVdF/gxlxlPPMDaHxsq3JOy79MVmd8+u/GvV22VEwJRi+NB3kgH7rWLpFs6Hi
	56MggZDyYbwKqyHCUFTPMvS43mG0JduT1eldMfgtqXdOLhjy/HAzQVJKqnJwNgF4qcbfP+2lePE
	1j/vh0br8C32wowIO2qPrHlmHHlNBH9HaBYxAT7PIkBVI/OJpg8/TEllG9x/oPluMmJlCDIIZdb
	l+85/8GyRXH3X71JzYM0O7ATkceyuysXKnbkdIFxCoT9QMP29ub0rXA98j8eHQ9UBqrDYaf5t0y
	XH/TBL0w7UrIRw0e3fkQv8kC+DCViGZ57mtku3IZM+9Iknt5b8On5M6wKJZsXpTNh3bNPFnBB02
	yzihdw0+v4QIa4gcF6AwUwcAdheQqL9K4jRi6831l7B6MMWClK1U/MfzP7fWE+hxfHfyxRnlQ/Q
	O4A5NkAS6esN4ScXz2rfic1kg/ugzddywVjZUeD/kVUNki4OrAciyhOOGuk0Ne4KddNDeA==
X-Received: by 2002:a05:6000:29c9:b0:490:a481:7ac8 with SMTP id ffacd0b85a97d-4982eedfb1cmr255737f8f.29.1794247091597;
        Mon, 09 Nov 2026 09:58:11 -0800 (PST)
Received: from JureBuildPC (46-150-36-237.static.telemach.net. [46.150.36.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835e20327sm238110f8f.26.2026.11.09.09.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:58:10 -0800 (PST)
From: Jure Rebernik <jure.rebernik@luxonis.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: konrad.dybcio@oss.qualcomm.com,
	mukesh.ojha@oss.qualcomm.com,
	linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jure Rebernik <jure.rebernik@luxonis.com>,
	stable@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: pas: Request stop before tearing down GLINK and SMD
Date: Mon,  9 Nov 2026 18:57:52 +0100
Message-ID: <20261109175752.793130-1-jure.rebernik@luxonis.com>
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

A crash of the ADSP that the host reports, for example through the
remoteproc debugfs crash file, can reset the whole SoC on QCS8550
instead of restarting the ADSP. The reset was most frequent shortly
after the ADSP had started: on two QCS8550-based boards, crashing it
about 4.5 seconds after it was started reset the SoC in 19 of 42
tries. The serial console showed that the system stopped right after
the recovery started. Nothing more was logged, and the SoC was reset 6
to 7 seconds later.

Since commit 0ea50486978f ("remoteproc: qcom: q6v5: Request shutdown if
crash is triggered host-side"), qcom_q6v5_request_stop() also sets the
SMP2P stop bit for a crash that the host reports, so that the firmware
takes part in its shutdown. The stop is requested from qcom_pas_stop(),
which rproc_stop() calls only after all subdevices have stopped. By
then the GLINK and SMD edges to the DSP have been unregistered and
their client devices, such as FastRPC, torn down. On QCS8550 the ADSP
firmware treats the stop bit as a fatal error and runs its error
handler after these links have gone away.

Add a subdevice whose .stop callback requests the stop, and add it
before sysmon. Subdevices stop in the reverse order of addition, so the
callback runs after the SSR BEFORE_SHUTDOWN notification and
sysmon_stop(), and before SMD and GLINK are torn down. The firmware
then handles the stop request while its GLINK and SMD edges are still
registered. qcom_q6v5_request_stop() still skips the request when
sysmon got a shutdown ack, or when the firmware reported the crash
itself and the fatal or watchdog interrupt has cleared the running
flag. It also clears the running flag, so the call in qcom_pas_stop()
now only sends a request when the subdevices were not started.

With this change, none of 104 host-reported crashes on the same boards
reset the SoC: 40 ADSP crashes at 4.5 seconds, 20 at 4 to 15 seconds,
20 while the ADSP was streaming IMU sensor data and 24 CDSP crashes.
The ADSP or CDSP restarted each time.

The problem was found, and this change was written and tested, with
the help of an AI coding assistant (Claude Code, by Anthropic). I
reviewed the change and the test results.

Fixes: 0ea50486978f ("remoteproc: qcom: q6v5: Request shutdown if crash is triggered host-side")
Cc: stable@vger.kernel.org
Signed-off-by: Jure Rebernik <jure.rebernik@luxonis.com>
---

Notes:
    Tested on Luxonis OAK4-S boards (QCS8550), ADSP and CDSP, with a kernel
    based on v7.2.6, which has 0ea50486978f as stable commit 0dc9e289bbb5.
    The crashes were triggered through the debugfs crash file. To see when
    the system stopped, a test script wrote a kernel log line to the serial
    console 20 times a second. A crash that the firmware reports could not
    be injected.
    
    Graceful stops through sysfs also reset these boards occasionally, with
    and without this patch (2 of 300 stops with it, 2 of about 290 without
    it). That problem is unrelated to this patch, and I am looking into it
    separately. This patch does not change that case: the firmware
    acknowledged the sysmon shutdown request, so no stop request was sent.
    
    qcom_q6v5_adsp and qcom_q6v5_mss also call qcom_q6v5_request_stop()
    from their .stop callbacks, after the subdevices have stopped, and
    qcom_q6v5_wcss does when requires_force_stop is set. I have no hardware
    for them and left them unchanged. If the approach is acceptable, they
    could get the same change.
    
    Built for arm64 (defconfig, drivers/remoteproc/, W=1) on rproc-next
    672126dce63c and on v7.4-rc1, without warnings. Not done: sparse and
    runtime tests with lockdep and the other debug options.
    
    Tool use: I asked Claude Code to make our QCS8550 image stable, to
    stress it on our test boards and to find why a simulated ADSP crash
    reset the board. It ran the tests, found the ordering problem and wrote
    a first fix that skipped the stop request for a crashed DSP. I asked
    for the stop request to be sent before the teardown instead, which is
    this patch. It wrote the code and this changelog and ran the tests
    above with the debugfs crash file, the serial console log and a test
    script on the boards. I reviewed the code and the results.

 drivers/remoteproc/qcom_q6v5_pas.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 57a111a0d..ddbffe45d 100644
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

base-commit: 672126dce63c94e7897867e4c0e681806c49cf02
-- 
2.56.0

