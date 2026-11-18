Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967674;
	b=KrEUAKBJTiYPkrcE6iXvYSj6bvVJRnKmyIv8CkG0iIyjK4DDjL0qkrwIGqaO78iZ/OYI
	 uTKfPeXzXyATFzuU4Qd0QOQRDXbub3hR5Kzf5L0/wPgJudkjGciUuyucsRcgDtB9LJU2v
	 UjUXlRbm8OKCkwgNSOF1+PPTi59RBeJLXQIIzkRH9VzcV7se0c9mHurW303wvwmm0ii7X
	 SpllzinW6Z/RftWsSqXGcjoabfWgncZFS1Xkldn3tf7sxCvtesmuzVntcMsWc+Ae0iHrP
	 5VMkWV5RcvO6HIzN/6HJP5RUCgPc/qmDZ5+oh0m/DRkrmuELUh+lwF9ZWF1Bp0LQt8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ecuacG42mOJlCKP+Xm2vtenahXDM0oGaAEC/qmvo8Ow=;
	b=PfEL5cA0gt2wiRhAteJpSlfHJKMwNkFz0Qw9igaJHUNzHo3RfkTKCeuvb/ZEmOkmEFVR
	 mpA+zzhjnkrdYsojufGqo3qZee37KhPsYOQcclcu7S37E3nTUBJeKuyNgnvsavJLTbIR+
	 fW+z+WjP7yBnKzAlMpun8kDEbahynOn8vv/ZgKplNamavrOk1sUiJBmRbVzk3EO7mcuUn
	 12g0wcY02RkfcKw9tIGm0dvu4iORud+GvMIUvJdc3J9aYGmjxieSobxV456kUM8IefTaD
	 cw/6xwwBfrtunMwrTKbbjsIZ4vX66TXyOVu6kQJ/QpJt3S0n9LD6J8+A9z9p5x4bN9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o7ik5JLV;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA8606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5AA8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o7ik5JLV
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bb5afa736so4387eec.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794967673; x=1795572473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ecuacG42mOJlCKP+Xm2vtenahXDM0oGaAEC/qmvo8Ow=;
        b=o7ik5JLVSbK5jaXU70vsqzLCjPaJRtT6RTbnLyn6TrHFa4gaSUzlLeTqy8sKLwm4KM
         Qj75NgS3SRsg9NHJdBOh2cUupSjEROItqNNOL4vcS2x+StuV2WI0wF8qXiQ5jCLcItkk
         FCg5kl+jlHBaYVC3WyXCorciDqOqcB1ZvNdsm4vMj6kxQ8r2taVyZRWNBoaE3aqN99Ti
         UvK/xRe0mnf0E54iK+YJaEOd3K7SZ2/GQcGsbmurPUC2NgzEu1lD/0sIo2mwReqPXzw2
         /hsj29APHi+OYo0LLFFbOdf7DbgbelGmSnI60F48W7epQS2RBVuW+QoT60CcmiiJ5vjS
         4dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794967673; x=1795572473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ecuacG42mOJlCKP+Xm2vtenahXDM0oGaAEC/qmvo8Ow=;
        b=EH0M0keg873nWD7q/RS3t6IlpanX/hlEFy1Vl4GQ4en4broj0r9MHaPySMT6cHqzp8
         Qx+LC/K2UQPkFfSXtgF0Vn75lX6/hVPVwsMvfx2evTwt8XrbkYamc76uHHh/Jo+ycqDL
         +AC/1Ui59Cuylqk1j58/MkPVq+DEHwz5DIHYgTvSwDa1jmlg4sgU9aSwOMMZA9TAeUm3
         jpfzIh3UfXP9HI4eGNUhuaQG1bhkYPLLu42I92IlG9cdUhGJb7ZhyzwA1PkTkzX3MMU9
         IBBN9hZUnIZYgaafNoOZHfBOfFruJ8wMsiw4wBFfn5k9Gn9q65abnNQ4jsddCvx954pt
         O92Q==
X-Forwarded-Encrypted: i=1; AL+hErFwKmmxUZ2dJ2d2iCSTGVcPAwdRnJMPs1TXeeCnWiCotqRiK24EQhaK1bFX+hTv+90HTRFg/zE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7S1AwRidfHycpPNETYpBwqE68mDHGFVatyoSrwmlxdz6ixYjq
	qw7fTaRWXaMcEe8Evb8v4UJ0InvxWPYe4exeTGhab8jfbdKtWARsoKpO
X-Gm-Gg: AYBFou0sGIE9w1k/UgVDFt1GEsdDuAcYNQCHhdD4IGu/cv+TT8lBs5H/Rz+Gok7zN/P
	n/vEf0hSD+5gKFKRu5fI5yYcSSHnbl7Si/jBYGvP328z6p/F0HZ/OvHIuwCYkwsdx2betM587pT
	UVb5bUwWJxeEtTsMvTuzYxqXjitIprSESfsXtfbDTs0CwrLkCUufuRa6x/BG/4v+/BqVN8zYS56
	lzPg7fDQPmBPJXqOacIkdrNAn/B6kjXbzAzbUtcjhiLPGhwOZaVj4TM0YVMN31J4stFMDgB4mPn
	5yAfyQAV+y6CrJMyl5yI4twjomTc0iRz2WvYmNfFC/EXcEeIkHkcwvTuVYY0uCOvb4bmER9moxP
	MQ64eg6c0B+te0CBNWfBOPN5qfECBT+tB+bTkNCP5rbsiqTOckSYTD8ILZeE0xnIFRisTPciVWo
	biNReKZTjE9ESKLItrTDi/xcqWac16nTtzFiHMWNAmG3O0Oof43GU2K6n6FMcKt0eyaUcFckUKE
	LH79r+kXXSEa2FZ61Wc/tif4pfOSyqtnBPViSPyjAuMnT7QIfUYcj3zspQgz06E8ahpOa5FRozQ
	nVuBYzrhBTrJ6d+XJr2QV6++OZESSeTbsFd6WlKoNUYP0Q8bX5skDWUSV9p5PDGRKU8FIuDPdEI
	PSwZn9jte+KV4LFBpkp10LSHl+2Q6
X-Received: by 2002:a05:7022:e801:b0:146:ffa9:2117 with SMTP id a92af1059eb24-1b543b829c9mr1993620c88.1.1794967672916;
        Tue, 17 Nov 2026 18:07:52 -0800 (PST)
Received: from DESKTOP-CJ1L666.dankook.ac.kr ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b544784008sm2862327c88.5.2026.11.17.18.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:07:52 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Anna Maniscalco <anna.maniscalco2000@gmail.com>,
	Julius Bairaktaris <julius@bairaktaris.de>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 5/5] drm/msm: Put the VM_BIND queue last when freeing a VM_BIND job
Date: Wed, 18 Nov 2026 11:07:16 +0900
Message-ID: <20261118020716.1698-6-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020716.1698-1-arpe1618@gmail.com>
References: <20261118020716.1698-1-arpe1618@gmail.com>
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

vm_bind_job_free() puts the job's submitqueue and then wakes up
vm->prealloc_throttle.wait. The job does not hold a reference to the
VM of its own: the VM is kept alive by the context, which the queue
holds a reference to. When the job holds the last reference to the
queue, as it can once the file has been closed, for example when a
killed job is freed, the put can drop the last reference to the VM,
and the wakeup then uses a VM that msm_gem_vm_free() has released.

Since commit 01c8d1f385f7 ("drm/msm: RCU-free the scheduler-containing
ring and VM objects"), msm_gem_vm_free() frees the VM with kfree_rcu(),
but vm_bind_job_free() is not in an RCU read-side critical section, so
a grace period can still end before the wakeup, e.g. if the task is
preempted in between. Before that commit, the VM was freed right away.

Put the queue only after the last use of the VM.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: b74fae5492d1 ("drm/msm: Add VM_BIND throttling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index c526409f451d..3e9657982291 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -904,7 +904,6 @@ vm_bind_job_free(struct msm_vm_bind_job *job)
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
-	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
 	/* In error paths, we could have unexecuted ops: */
@@ -921,6 +920,12 @@ vm_bind_job_free(struct msm_vm_bind_job *job)
 
 	wake_up(&vm->prealloc_throttle.wait);
 
+	/*
+	 * The queue may hold the last reference to the context, and so to the
+	 * VM, so put it only once we are done with the VM.
+	 */
+	msm_submitqueue_put(job->queue);
+
 	kfree(job);
 }
 
-- 
2.43.0

