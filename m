Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967647;
	b=XhGG3ZyXRxz3yIcsE2IegvaIiNI3T3+Hr4Zis+WbfKE/kbrOJmRCaYf4DKm16WNwzHP5
	 dHccu3NZA04Ai/BN0IVsrsEBYAkYaiX0Qx3FAuPnMuthYeDb4Pv0IEKXXwwFzr5aQjb6r
	 zG/uxRxmWV6j58SXMftrtHopHjhmFS0zxkYeXA9pwrjozhk3FOiAOVamBe0neOxfNMY2t
	 q5KtRLa17E1fSGmjGcKkDhODV1Qe8j3GEzgMv8uGgtCduZBLIWu1vLSpXHZUnHXySmc9+
	 lKTT7VqyhWHnpTL/xBzoCm97AyJ3qID9xanzamz4p6rYwfuB49TqgYy1HllF1BNsszw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i45bHZiP3wEgcVETQzoa65BO2wkAbHlegiGhDqMSTjc=;
	b=GXGMAi9eHPFkLeF8IQROK7dvwbyADCl2KUVZ4ByZNpPMXjXe6abLFWCJTJJlUA+HXT8Q
	 O3B7Ox0EACZrIhfrnRSZPP4uJxKuNUBYKPREFuQggj9DQUV9FrO3EBYnsG9F+a/nGuaFK
	 cmvmn2i4iCX1JB772mhYXxNfZyUUCLiSxlG+wqlufqvfNyXTgEibZGpnCYIj2XI7AybPZ
	 zSsLdwt/QnRsLmlaqjC+iIFwNJbRarcMlOAjb3v80pHMgDmoqGRkxYynvzJ0VJV/jLabc
	 5eDCam73Hcp2t4+fNP+39NPBjQSstS5QJCnH4Xir0PZMGZC7nZBhKmI9Z6e2pBx7cGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWzcJU8f;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CD606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 238CD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWzcJU8f
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-168de2167deso4791c88.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794967646; x=1795572446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i45bHZiP3wEgcVETQzoa65BO2wkAbHlegiGhDqMSTjc=;
        b=cWzcJU8f71qRXuXGab0DEdPLcwJztkCG7kZJaC6cbL19em4r3br54w30smE8pVof0X
         g/ciOffOuD17gLF1EJYrASn96dvF009LMvgC9J4zeHhlsc7KTbvF/TU5xIkhuHZbRjYq
         U85FO6tj31Q7nVIjpT11nnknwycWNw3VxmPtJSj4ZANiu9OPeZceii6W82s6z/XmO7Px
         4Qn2vRYFJd0uIJ+cCWYjTmvnPhb0yMlNEUhF7m8m41GJ0mUL8xTbqgqcaVA86NfzyzXn
         QpzEljDLoxt/E5UfIthfAXICGkZNQpHIhSCjxbhkl3VkxijZKBH3pdc12qGfX4+xGdiZ
         vNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794967646; x=1795572446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i45bHZiP3wEgcVETQzoa65BO2wkAbHlegiGhDqMSTjc=;
        b=uJOqmmX6lb4xEd8LUQUQF1kdTEXd5R2ZkTywBUKxwxHLZTQ1Wx03QK40wHm1M7UUyO
         MmJveeYfCDCG8zA3WxWRDfWV1fFSg1WiX1LFr2TkVkNEmVD/15v24LEtur7SgTAjDpqD
         Jy6PGhzTUTN4QMINWaTzeGZd23r/7KhO4l8OD8yTrVB6q+cm4V45oj3Gn0HKZoo90gpK
         b2wj05IXrGH38WbDbqCG/RVarXhhvDGQ+feq09kdqqhaHjmgQA7D1hZZkTDoNZrVT97d
         sDYN/rs/Ze1gK1N7w5ltY56egPZgWiNJdDHkUs3KdYhUDE/5Xbx27AGLygyk0neIL8nx
         vgOA==
X-Forwarded-Encrypted: i=1; AL+hErHCXeAzab+poyjhpgPJgPNbLlLFHgkK2SXodlWd/8Z0O4tqTQujYsaTAMNfWWUZMccX5zOlfoI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/Dk7KnJTgM9djsaW7ztzx22md1Uvv6dRzk036GG0MLoP/aL/y
	gowkPoBGyRuydT5ISK3+1cHgCs8O3h0NJ0ynRFr2SsAl0knw/2IubyDl
X-Gm-Gg: AYBFou2quPf8YV2KFZ1Wc3cnGdPm0+3r117zUv+5frUwgF4crCkWoa7gsHWmLigYJmC
	PsqJibTyDBsW8igPY9Y1YbkXCIIFGPiUwOMLiiFK7UEfEEUmurqrgg0fouMSCngd9NXLVVfGUnY
	n7N+1U1lbjR8Tc1wbpobRb5MCXSUt/cbg8d2IL6cG35tG2gGLMEvaVWgR76sqnbdhnEjFIlYZST
	kGBLrb4bFFzJ5qH6d2U7KzaqHoXQ3d66vbxHILqunngnFAJxmPp5Ght2OOzopZVZ8oKqA/tlAWX
	FLxCBRySz6z1smca3RgyWRqMcOxkDXdASqTEOS0cctygQoPkbxgCrI/zeleLuuuXIDHO21ddCZ0
	2A3CpgUpqJ3roViLDOuJ9AOqnJP7177ysYdT3EYl9Z2EiFwqOZHLirhhIj7lkLFOhq6aRRvVttQ
	y9ch27MCPX/WwHZiMXHbJV4zkCXtHsPqP7IjQJq79VJxwavancGt9lJ3NrWBUjyLQvfi1o8Q1FI
	iwMo122mMmaztOiJKo4MWDR42drBt0dDTKA2HVZ8SufFJ0KAwgu6Ie6ga1LjSMnmgwPMLutJx98
	pJdn4P2eIzp+jOXu3cPjJA9j3fcoggHoh8fHT7oztZ/HAdkATcqXqejVh/0WOo3j1iBjH20zNex
	XgED8zms=
X-Received: by 2002:a05:701a:cc8f:20b0:1b5:4596:8371 with SMTP id a92af1059eb24-1b54596847cmr617949c88.0.1794967645989;
        Tue, 17 Nov 2026 18:07:25 -0800 (PST)
Received: from DESKTOP-CJ1L666.dankook.ac.kr ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b544784008sm2862327c88.5.2026.11.17.18.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:07:25 -0800 (PST)
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
Subject: [PATCH v4 0/5] drm/msm: Fix VM_BIND job, queue and entity lifetimes
Date: Wed, 18 Nov 2026 11:07:11 +0900
Message-ID: <20261118020716.1698-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
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

These fix what happens to VM_BIND jobs, queues and entities when the
file or a VM_BIND queue is closed while jobs are still pending, and
make the VM unusable when VM_BIND jobs of different queues apply an
unmap before the map that it undoes.

Patch 1 makes msm_gem_vm_close() wait for VM_BIND jobs, as it does for
submits. Patch 2 handles an unmap that finds part of its range not
mapped, or that comes before the map it undoes, like a failed map.
Patch 3 makes a VM_BIND job that the scheduler kills before it runs
apply its queued unmaps before it drops its references to the unmapped
objects, release its BO pins, and mark the VM unusable.
Patch 4 destroys the VM_BIND entity when its queue is closed, instead
of on the final put, which can come after the VM's scheduler has been
torn down. Patch 5 puts the queue last when a job is freed, as the
queue may hold the last reference to the VM.

Changes in v4:
- New patch 1, as Rob suggested: VM_BIND jobs add their fences to
  vm->last_fence, keeping the previous fence if the merge fails. Patch
  4 is still needed for killed jobs, which the scheduler frees only
  after it has signalled their fences.
- New patch 2, for the ordering problem across VM_BIND queues that
  Sashiko found in v3 patch 2, and that v3 patch 1 also made reachable
  through killed jobs. Unmap errors are now handled like map errors, as
  Rob suggested, and so is an unmap that comes before the map it undoes.
  A job that fails in the ioctl after updating the VMAs now marks the
  VM unusable as well.
- Patch 3 (v3 patch 1): uses the checks of patch 2, and describes the
  window that Sashiko pointed out in v3, where a job that waits for a
  killed job applies its updates before the killed job's unmaps.
- Patch 4 (v3 patch 2): changelog updated for patch 1, and a second
  Fixes tag, for the commit that added VM_BIND jobs.

Changes in v3:
- Patch 1: only apply the queued ops of a job that the scheduler frees
  after killing it, once its dependencies and the previous job of its
  entity are done. The error path of msm_ioctl_vm_bind() frees the job
  right away, so v2 could apply its unmaps too early and out of order
  (Sashiko). That path is left as it is in mainline, and the title now
  says which jobs the patch is about.
- Patch 3: rebased on patch 1, title adjusted.

Changes in v2:
- New patch 1, for an issue that Sashiko reported on v1 patch 1, which
  that patch makes easier to hit.
- Patch 2: changelog refers to patch 1.

Review of v2 by Rob:
https://lore.kernel.org/r/CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com

v3: https://lore.kernel.org/r/20261114141851.134290-1-arpe1618@gmail.com
v2: https://lore.kernel.org/r/20261114081902.1669-1-arpe1618@gmail.com
v1: https://lore.kernel.org/r/20261114062541.2001-1-arpe1618@gmail.com

Jiwoo Kim (5):
  drm/msm: Wait for VM_BIND jobs in msm_gem_vm_close()
  drm/msm: Mark the VM unusable on out-of-order VM_BIND unmaps
  drm/msm: Release the pins and ops of a killed VM_BIND job
  drm/msm: Destroy the VM_BIND entity when its queue is closed
  drm/msm: Put the VM_BIND queue last when freeing a VM_BIND job

 drivers/gpu/drm/msm/msm_gem.h         |   7 +
 drivers/gpu/drm/msm/msm_gem_vma.c     | 242 ++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.h         |   6 +
 drivers/gpu/drm/msm/msm_submitqueue.c |  50 ++++--
 4 files changed, 272 insertions(+), 33 deletions(-)


base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.43.0

