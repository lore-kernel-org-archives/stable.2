Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556343;
	b=iAjXN0QHS1GCEsY/quuEoSWz4HydNoq+ZFiprNSerLIW0tReC+t9WFrvLq94YFSWwQAB
	 SVhiXOA9OcQtJhBv883Mb45aXuJYRR1V3/OZX81lgFv0sS/6kwzJi/JYlD5fRfcMMuZOD
	 oWw8dRMn3FMbZD5O06lDD28IYgeymPGB4Kbx6SfhimMem8U24v2NBKTiCpu61IPsfNtFT
	 zJ18BMuh1fqPgDNT8YaEl9dY4wCOqrq6YEWwqZq3K/IjYqimY+56UwWIqY1RQAL/relxs
	 ydj3b08aWP3iDgoqNp3JCbikqmurAQSGvj2iz8CYHB4uVaVUD9/pAJO62wIwbzDmppA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xkS6xbmE+ewGMYaLKZHzgOXG3y/RT/Y6ukuGmQk4oP0=;
	b=pYLo524Y1XvE7ex2FUS6KC7RmGSvcQhXy6BAbf+chZLK81dCk6eNmyAooEZ7Bnvw5y8x
	 nWXviEp7Bm/0Bk7F3sBQ3ndJW9g0sFzLQ4jQPMD3WR88nDo+ATj0+7B8Jj9W0J7EWUzRW
	 gRN5r3SUVuZ+s1S80ZDDvWH7DnmU1XrY5Z8DTcP+j7+dk2d4LL3iobL9d46Y0LBfFoyLo
	 RxbZQS/sJoI+NkDutE/q9QsxCQP1PXndbDFy+WHXSlRz6Qrh/sNQEPaSZsVi5pNs8U2uK
	 bEpnEogwIRn+DNqAILya40LYbE42opes2gXG7a96fQnmeIgJ75DxgwSptgHtRiv1lnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bidSSP03;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5A606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 18:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73A5A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bidSSP03
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so1548119b3a.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 10:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793556343; x=1794161143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xkS6xbmE+ewGMYaLKZHzgOXG3y/RT/Y6ukuGmQk4oP0=;
        b=bidSSP03obNuDoC07GZcasZYOz1qc2TFNIOGi8OCFFs6elFzrTRBTNpDPm3/wlcwq+
         ZjhG83xHea7YSiCuBjODLd0bFgDHwRsmYj1fkQgM9Rkzfn9oKrJFQchAECzLAVZmO3dn
         KCUo1b8GanmcWIQoccM8tD1WYT0iXhJ+MpKeCLlXkgQ6JBs32SahI4R7EHDMvyWTFWZx
         jFWaLW/OMpUFRZxlwl/EnS7p6Xzydd7ps2lXQsdC9X5vIMYXSF1AjyKlmsknBykm/2Cn
         3ieR0TfANAnWHIiHG/2vjKF/r/oKwa0XR4W69fPhi8t9nC0/1NhLc4ZjFlKXh6ZDC0gR
         V7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793556343; x=1794161143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xkS6xbmE+ewGMYaLKZHzgOXG3y/RT/Y6ukuGmQk4oP0=;
        b=oIdZeXpcQ7zOKGAKvbC3pFUMZpWQcSmYAolRg25ASwmPrUf36pXHqjkrFQEha87WFl
         sEmuBRlqE3C7OwOq3xgucXB7grTxzAT17mcR88SQhRVTZkPU0cAHiJB2AOzvucDMuxZh
         Z80tt4AMhEypw5NyTmwghMJCEfKO5WH13Jl4hL5+wMkK8aCk7ZXEbjWCfWsu8IUAHhH3
         eCh/9s+A3bHvZ+smq4YShDJWcvVFxlyD3aBo1jhKQCzyFgrz5hC7ijoWt6oOnfRbC1EL
         pO34q3JSTa7VV9bZpMOR95ROHTczwtjVrmd966Wd1bpGiGBhyVSvZRSXt9jtvVlCp1Jo
         91qQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKOU/1zk9lszfzgrklgFIcZe0iwEzf9MKb2d1ZrA1wZZiaPLZiXEHKVkbuhmu6a159BH32XV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYISTZ8lRmFQnlKZRCWC+Zz9ywSagCNLkmK1xBYnM3DWh8OJWz8f
	qrKNsnRosZVJiq5ddV3OX24TIzxOWJwkvDcaAs4OlgANQgNX002Il3Sx
X-Gm-Gg: AYBFou1TdBxvU1G90oMdYVmC85/J2nMmymfR2I5EWCOeBfx5GyoWgAQV3rQj92vZBLD
	djFJnHZ4qLmimK5rBBFZTloTeCQ4uK7zlWBCi2TQEjKilICsL9xlxCO22WmD+Fpd+2494eUwNQG
	Fy+ZbpKjk1kopuV8WbsJmueh82HoOdluCrUblYQTUP3ScRKkFDHN3qSKT2tgtTPzPOgG5ASFzTb
	YBHd8OpbS64mZzpE2KyomUkkVvdcv66eIgk5mx+VZa/rRHouyUQNZp50LkyUv3SDLlbIHZlytqq
	xc1+Inz7VH0K8ddGnLZiOfrahHWXnVcRk/fDYIsxv1Mxp3O3JjLEW2BpmzOEPDwraGfSlyICLo9
	j9RRDHZLPQMAmNwz6ZIBHfkqtt+S0K1o/dCjQxi1rufQjaODROe9wDLfqq4IBMy8gioSH+6n2Rr
	TfONmvfgX2otj69VFHFMWiH00yvcOyjOdNmItdja9WXyLvaNgqKt+H0T6R77VGw9ZsFle94neaT
	WeZXrSwDaWf01pa3siQRemmCJkQZlWJ4eA1aQ6VCVUJFANq+Sn+slA1y1OhzgXLXlAWBH6T24BK
	vxkz24182XLS6QKyTUTFDZY=
X-Received: by 2002:a05:6a00:181b:b0:89d:eb23:4e83 with SMTP id d2e1a72fcca58-8a9beb67de4mr6450461b3a.30.1793556342787;
        Sun, 01 Nov 2026 10:05:42 -0800 (PST)
Received: from tabby-boi ([2a09:bac5:4fad:e6::17:370])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8ac269b8805sm446544b3a.44.2026.11.01.10.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 10:05:42 -0800 (PST)
From: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sean Paul <sean@poorly.run>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Connor Abbott <cwabbott0@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] drm/msm: serialize devcoredump reads of the crash state
Date: Mon,  2 Nov 2026 02:05:08 +0800
Message-ID: <20261101180508.66598-2-nicoangelodelacruz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
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

adreno_show_object() converts each captured buffer to ascii85 the
first time the crash state is shown, in place: it checks *encoded,
replaces *ptr with the encoded copy and kvfree()s the raw buffer.
msm_gpu_devcoredump_read() only takes gpu->lock around the reference
get, and every read() of the devcoredump renders the whole state
again, so two processes reading the same devcoredump at once can both
see *encoded == false and both free the same buffer, or print a
buffer the other one just freed:

  WARNING: mm/slub.c:6733 at free_large_kmalloc+0xb0/0xf8
   kvfree+0x44/0x60
   adreno_show_object+0x190/0x240
   adreno_show+0x1d0/0x438
   a6xx_show+0x68/0xbd0
   msm_gpu_devcoredump_read+0x144/0x1f8
   devcd_data_read+0x34/0x48
  page dumped because: Not a kmalloc allocation

The dump also changes length between reads, so a reader can get a
short copy that ends at a page boundary.

Seen on an Adreno 830 with IGT's msm_recovery reading the devcoredump
while a udev helper copied it out: 16 such warnings in one boot, none
with this patch.

Add a mutex to struct msm_gpu and hold it while the state is
rendered. Only one crash state exists at a time, so a per-GPU lock is
enough. gpu->lock isn't used because a devcoredump reader would then
hold up recovery and fault capture for as long as it takes to render
the dump. The new lock is taken after msm_gpu_crashstate_get() and
dropped before msm_gpu_crashstate_put(), so it never nests with
gpu->lock, and it is taken interruptibly so a reader waiting behind
a slow render can be killed.

Fixes: 1df4289d5b23 ("drm/msm: Optimize adreno_show_object()")
Cc: stable@vger.kernel.org
Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 10 ++++++++++
 drivers/gpu/drm/msm/msm_gpu.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index fded78fdb..428dc9666 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -191,11 +191,18 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 	struct drm_print_iterator iter;
 	struct drm_printer p;
 	struct msm_gpu_state *state;
+	int ret;
 
 	state = msm_gpu_crashstate_get(gpu);
 	if (!state)
 		return 0;
 
+	ret = mutex_lock_interruptible(&gpu->crashstate_show_lock);
+	if (ret) {
+		msm_gpu_crashstate_put(gpu);
+		return ret;
+	}
+
 	iter.data = buffer;
 	iter.offset = 0;
 	iter.start = offset;
@@ -214,6 +221,8 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 
 	gpu->funcs->show(gpu, state, &p);
 
+	mutex_unlock(&gpu->crashstate_show_lock);
+
 	msm_gpu_crashstate_put(gpu);
 
 	return count - iter.remain;
@@ -914,6 +923,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->funcs = funcs;
 	gpu->name = name;
 	INIT_WORK(&gpu->crashstate_free_work, msm_gpu_crashstate_free_worker);
+	mutex_init(&gpu->crashstate_show_lock);
 
 	gpu->worker = kthread_run_worker(0, "gpu-worker");
 	if (IS_ERR(gpu->worker)) {
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index db9e11e7f..9b683973b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -264,6 +264,14 @@ struct msm_gpu {
 	 */
 	struct work_struct crashstate_free_work;
 
+	/**
+	 * @crashstate_show_lock: serializes rendering of @crashstate for the
+	 * devcoredump.  The show functions convert captured buffers to ascii85
+	 * in place on first use (see adreno_show_object()), so concurrent
+	 * readers of the same dump must not render it at the same time.
+	 */
+	struct mutex crashstate_show_lock;
+
 	/**
 	 * @recovery_in_progress: true while recover_worker() holds @lock, so
 	 * that fault capture and GMU waits don't wait on a fault devcoredump
-- 
2.53.0

