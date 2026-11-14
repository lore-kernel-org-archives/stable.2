Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637556;
	b=0+VKCcAU8UnvRrJgE7e/L7UX5Fl2Urv7fm3dBpo7B/QyN0Y+75XlF9YjqYadg+z50Fos
	 HJNAnAZYZGR/gOz8sHgfzIbA0SSN4RbHU/YtGxnkH5ytd56JPuW9PN6hcWb95eobe5jTA
	 qBWf0zfd1GhpjF0wybEIt4voqjT0JbV4V6DoDGyueCWP72OetQtVm4bK4Zl3Ypj89hfX0
	 HToJDcXckukOpdbC5W5Stlj8Z3vEjwCwVn4ZNfYi2N6H4OIqahPbY90LS4BrEuEf2xBL5
	 B59CXmVpGXsLkrsd9yHWJdQ72NjP8fNHawkqCbf3/7/jIcpIZkEZzdQBe3DcspCmDrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2G/wlgst0b3QmNrVuRQ50SldBGJC/pdF4BObZ2EI5Ls=;
	b=Ton+AAS3HyITBDxf7O0gfLuXfAHT0vAizLxkyNQ0CwTtelFtapkHzuz+A4VRMfavxyj6
	 UzEqxTAnHWbc/fH1UVekEACIZhYJVTKJsvi3Ig4JLzckqCGIFp7XT6ysZA/P2B2Gdm6mS
	 bJNTN2skS8LI415mC4XjVZNoFb90ejqJpN+01SfHUvjmn3qjfCtuT5rHvhuaN3wKguwzk
	 ts5UPRf3Q+KzDjPFxruUz4xt6OTJA8t0vH+9N52/zSIm+DGpILUzqws174WC2no7xNH61
	 4sJNYFZvttiSb2Ldncvpw4vcIocEx7rGhBU1hh2phfURcfKgKH/ZxCcSF5sCUCdeSTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJ6HP7tQ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC5606A331
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10AC5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJ6HP7tQ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33c10faf6easo223746eec.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794637555; x=1795242355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2G/wlgst0b3QmNrVuRQ50SldBGJC/pdF4BObZ2EI5Ls=;
        b=PJ6HP7tQeeuDG4zzlhNDMmZ7tS0LVez9oRI3SvJOvGfzY2SI/mcYzl7mD81NFnCOFs
         L0AZNWqY/+L3PXXnKBewPmcAWRCrXFHvXXi6gJydDne3MwTHhp2hO5F1ygjsbxOgNtey
         ZGYI4TFAx9WjHOmrqEv18kPAXdgodpvqlB3wFVttrPawXvLwSvIUfC8r/oa2G9iue4LM
         3oDqlxy8ixl2rpabpUzi9L3Iw5tNN4EmG8hYkLJt8H1wGA7TvKcpsp9OZxq6g1anlcLV
         4Vrbh1rJEpAi/SGFsZqyRNt87/IAt/3j8ODaqCEnURDSxJq+w2qM0p7CSfCqF3IRhpeI
         fmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794637555; x=1795242355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2G/wlgst0b3QmNrVuRQ50SldBGJC/pdF4BObZ2EI5Ls=;
        b=wehoejaZW2v96Oa3MxbOeSmnX0r1NUEcXRPo4k3K2eBdzuv1CCJHFF3rbgd3A4WSW9
         fpne4XPlIYlIidhdwoHr2+t9Pk/93Tc37w4I64MdLd/aDEHzCWiRDMXcAbUw5qtdPbh6
         iOoN/2KkrniXQF+qyhlLWZhZNUJxK3nzAfIxp6I+ro+qxbY+qCppp/2JtSRokxO34Za1
         E5PWJGe269en7rRAb8sSXD04rX5a/o0Zs39cR9KIeCpXmIE3YkVzY8c+zF1vcH4mP1CO
         iytPG9h+vTIhdGP3RGIc/s2MVqYTcdZxhB+tuVvugBZH+GNEcxph3F3HAzVBzTWu2QVn
         OXGA==
X-Forwarded-Encrypted: i=1; AL+hErHke00XmzsekewOQoGCR8TPq/0uzGiV6RNPCtDPI5DBwujiEPZQrbessVDyeKPhDJCYmFBPpNg=@vger.kernel.org
X-Gm-Message-State: APuU4Z91Xj7tEWfJUddK7bB6Hvb0CtDKDIh3vcDWb9K3o7mjs9mDDvry
	9IV2ZgQJ1VGsCxWg01+DMg8xF0A/ET090qOBa9nycG2TTO0JkB04w/ECBbc9okForr8=
X-Gm-Gg: AYBFou2+mcE3RBx3ulPDXTSofOFZ3O+6WQGjiurKNvJStwA739S0f4JPc97aI8tUwjY
	SwexqEkO4vvuYh8Cpu9+yeo5zXvjKfvHZE6HiNB4R1OvKtybBGlrxhfuZg0ZTQLque+b6rvzsC3
	en8+4GUP/SVfUAS/YtrjNAyh+bSMKt0x7WbpEYh1JJfI7+5YU7bLp93jnTLlCwcyuZDBqIeMDSH
	u283UQ8NExfOdMOW4gS54NXLedCNQQAghNd5eIhVJNbsdeydTSeYdfawuxVUEmXiaVTGIFfy907
	iXwbd28iPI9X8Dvu3ltc/yUC/X0mN4qKyTOJkykhoMqEci8mR9sxckcWhyJunwd50OY4T3KgR2b
	Fn1p6/OgU2vsL2UVQOcOOtICDqgwY2rQ2zx0kmPb2Kq1eVUAW3F8WhcCyCus0g+SN2IOv7J5dzC
	S6C0HGqLaP+09M68f7o+MXmLCgMaX4uAzXtIMz5z6TWpm35GH7ENbUQn35xDSAmp3TyvZy77zQZ
	2P9Dpni4K4VUSOopeQ5VVoCmnGWfWjKLGuEPJBjQHZ3Bbw5mIkshQV6qXIJUWj+IVIpdM241wu4
	5BCzLspZYQeV9eU2ioY6gwU5zCQ98Wh8Dd5yY1WQJeKcwI4mkju1a/8nt0dZhgDt/DtrR5FPzic
	BTDg=
X-Received: by 2002:a05:693c:881c:10b0:36d:5fbc:8c8d with SMTP id 5a478bee46e88-379655d503emr6618386eec.2.1794637555183;
        Fri, 13 Nov 2026 22:25:55 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795591f4f8sm13537585eec.13.2026.11.13.22.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:25:54 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Antonino Maniscalco <antomani103@gmail.com>,
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
Subject: [PATCH 2/2] drm/msm: Put the VM_BIND queue last in msm_vma_job_free()
Date: Sat, 14 Nov 2026 15:25:41 +0900
Message-ID: <20261114062541.2001-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114062541.2001-1-arpe1618@gmail.com>
References: <20261114062541.2001-1-arpe1618@gmail.com>
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

msm_vma_job_free() puts the job's submitqueue and then wakes up
vm->prealloc_throttle.wait. The job does not hold a reference to the
VM of its own: the VM is kept alive by the context, which the queue
holds a reference to. When the job holds the last reference to the
queue, as it can once the file has been closed, for example when a
cancelled job is freed, the put can drop the last reference to the VM,
and the wakeup then uses a VM that msm_gem_vm_free() has released.

Since commit 01c8d1f385f7 ("drm/msm: RCU-free the scheduler-containing
ring and VM objects"), msm_gem_vm_free() frees the VM with kfree_rcu(),
but msm_vma_job_free() is not in an RCU read-side critical section, so
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
Independent of 1/2.

 drivers/gpu/drm/msm/msm_gem_vma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 0cf518420656..b4b284ca5b38 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -775,7 +775,6 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
-	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
 	/* In error paths, we could have unexecuted ops: */
@@ -788,6 +787,12 @@ msm_vma_job_free(struct drm_sched_job *_job)
 
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

