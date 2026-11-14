Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670598;
	b=yQEnuAriFob3itQEUNkRHpXoBmMbM3xbMomfDWU1y2/cg+BlylWomf2CVhx8wiEfptWq
	 y8A3AYG9mL8+kB3XTkh0ahvWDlt/h98xIPa0VONhL5W3AN8bp48BQGHQzDdbOrzJFw9GI
	 8b6AMXrn34Dflare9wV56aQ8a+XuPC2KWq/ASnjZh6GGSilXQdL45igYhpoE810reHqCy
	 JtZFAsgUMQLvR2vIwf/ZDK1AWeJG8rt8/UqXdOPtXPI+Un5P1/6Hn1iqRBx0Y/w4p75ea
	 eBJ7A0014PmipaTLgebMkNIP7bxp7l2gpBWG/JjwbAgMjYOqspalF7M6voV3FNZAPFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dcf1VprQ5tReiauPDZRL2T+Bt75/dPprqyKIItbhiW4=;
	b=KaKKA4YcHWm7mDt9XbWKf0MrWLL0tg6OlqjIoO4k1R01n3YByJG3DkjUO2o2wNu826x4
	 xtEthTDkgOD3tA9Cpsf5EjPr0R/X4kDVecZuTy2Ejx5NiunitGa/ZjBGFCy0Ldrab3+aO
	 DY4el8u76hSPj1cN+zmPJ1p33M7xJ41Z1SrWzB+K8d+jKhMDFXqEnx70bd1Er2UKsmGcg
	 4U2NHjLDl/x8dGdzIfIceP61qaRFQLgYpF0Szsh2SQsn07H1v2S2Xe1Ns97uBdtwlDejy
	 okLNFu011IMHXwpCceeDFAo7ScyFvpkc8VveTiaCrql2C0fLvdx8tG2SLg8tZa4+WYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kLaBAw7w;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64F606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E64F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kLaBAw7w
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36ecc11bd26so250089eec.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794670597; x=1795275397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dcf1VprQ5tReiauPDZRL2T+Bt75/dPprqyKIItbhiW4=;
        b=kLaBAw7wyQvWZ1O6H9Z8EVRT4c99eFtSlk56PDSgX/V6PzrRUop9EQDiwhc82HP0Ro
         vZjCaqh3rTP6wYrvWhgrfd1ai4cSFfSfR0e6sPGVmiS+4OMduJvG/HxiCXWz9Ynwxty4
         eXB0yDpJR/j8cHEcV/ihE5tg2mMIDcso6aprXMWAhQGuS4FTxJvWCIeflnTdJ63ZhHNw
         KUgN5CTvm54ELruJCnCxb89I3myrjv/UoP91i5EWajaojOjSS1X8aryBt0VcXgWfsdnj
         yocOp9imlaUMah/UTOksDTx6uWjPD1ClSeF9qf4+8I8L3ALSaUM8Qwv2f5ulRnPcVybA
         BqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794670597; x=1795275397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dcf1VprQ5tReiauPDZRL2T+Bt75/dPprqyKIItbhiW4=;
        b=cQCmn5Z6X2qhNujJpZniy8TKQtMSirYOweOOapq0emJtADiXEci8el+O1GoMIf28FY
         C0vfS6+3RURzpTgQ8X0n67d8XWvwG23stuFG2LNO8l4Uf5d8ADVOWHW0aYj4aKlB8hQK
         /017vDVvAMUHTpeW5aT1wg+IKsJMe0RXs+8FQuASV/XlKnX4FFDq7e0lzMpxTLXjZ6oU
         MQhJTsDypryeFAGwD1PqJ8D6Eii2zvYltUnG7tlpzkpAQfWQghFA8p6K55THrzcgh8C8
         pRBonEDUo1ndtJ0u9aEzq/5STJrsa7mZQxDkUMwkC2jLX9/90a1ys4ZGbsPtD4c9HeHf
         9hAQ==
X-Forwarded-Encrypted: i=1; AL+hErH9nyLQvETgPYmdxsvm0xlC2be8+PQ/9eH0+tjGfoP122H5KjoKiNdITBwHznsx8nAs/s2UNUg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8i9xR4a5tWxHYyLdUP3NRWa957oetuSv+6kOCOCpIAygCuC8PH
	AjzlPNuBiwWrCFi5U1nBgxmWCWonTm+J28MZep9nHroXbn/S1/ih/Nqx
X-Gm-Gg: AYBFou3cy5ZpL2qxhYkVNsCk+fAbL/ZThaFTzSrScJ0MFuFxJu9WVWyQRmGCNelJIwE
	GHH0mFW+HMO/KOTjC6mPFHG4hrbufe8dMxwsUkZspRTAvKfJ46TGAXKPk0oSduJf5CA3NMjLj+4
	L/5et9y1HsgDGGeZTkdXvXkNHtiFqNPAakAQn2DEJv0HSF04hRFHBDVPI+ejGD6FTPQ1szOLigt
	hkc0DhsTne6SHOm6XkkUkVuH0IR6XmiWeo+C8jD3Lj99Sgh+CZ+A+U6ea+L/NVaDrPMg/zPzW2X
	p8ttegkA4hXe8ToD0WmiAIqAekVk/RjuxovB3RLN/PYh6EdicoyZZALLw8wRx76P9qjknx8qerm
	0MJ68kB3NtQtsbYQ0dLfwpdpyuaxPQMHl93m8eR+DWA2rybI8H1eE0f+3/L/vLN5BnNMZEG2AJN
	ilAucCQzXqa2wveqdUxDm4W6rkTofiZCLouFh74mPGpDmZclnAskyrSPI+0wHW5IWwHesZHtnJh
	WBGdlS8nhIYYQvOrG/tsP6GBIIYopzYrVUJyMhAqkNKwJupucL0IGZR2lRt4y+s6CHBhhkZERgc
	zR3XBgZ5q9JTdG1CkLzV5WVYgU1sHVKsxdfTyacvVIAbtDQEEQg7tBYlLdsconKM90jcdoWc47C
	RxqM=
X-Received: by 2002:a05:693c:20cd:10b0:36a:13fd:b5c with SMTP id 5a478bee46e88-379652f16f8mr8568423eec.2.1794670596552;
        Sat, 14 Nov 2026 07:36:36 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379508762a5sm17527126eec.0.2026.11.14.07.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 07:36:35 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Anna Maniscalco <anna.maniscalco2000@gmail.com>,
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
Subject: Re: [PATCH v2 0/3] drm/msm: Fix VM_BIND job, queue and entity lifetimes
Date: Sun, 15 Nov 2026 00:36:22 +0900
Message-ID: <20261114153622.148125-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACSVV02fCwbFXVjE+XHCo68xMxYUHovJ9ZHRYd98L74N1T14Hw@mail.gmail.com>
References: <CACSVV02fCwbFXVjE+XHCo68xMxYUHovJ9ZHRYd98L74N1T14Hw@mail.gmail.com>
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

On Sat, Nov 14, 2026 at 7:03 AM Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> msm_gem_vm_close() waits on vm->last_fence which will be signaled
> after msm_vma_job_run() returns.

vm->last_fence only collects the fences of GEM_SUBMIT jobs, in
submit_attach_object_fences(). VM_BIND jobs don't add theirs, so
msm_gem_vm_close() waits for a VM_BIND job only if a submit depends
on it.

> My expectation is that if thread A is in midst of a VM_BIND ioctl,
> perhaps not having created/updated last_fence yet, while thread B is
> racing it closing the device fd, that file_operations::release will be
> called after thread A's ioctl call returns.  Is this not the case?

It is the case. (The vm_bind_closed check in patch 2 is only for
MSM_SUBMITQUEUE_CLOSE, which can race with a VM_BIND ioctl on the same
queue in another thread.)

The problem is a job that the ioctl has already pushed and that is
still waiting for its in-fence, e.g. one from another device or
drm_file, when the file is released:

- If the queue was closed with MSM_SUBMITQUEUE_CLOSE first,
  msm_submitqueue_close() no longer sees it, and nothing waits for the
  job. Otherwise drm_sched_entity_flush() waits at most
  MAX_WAIT_SCHED_ENTITY_Q_EMPTY for an exiting task, and kills the
  remaining jobs only on SIGKILL. Either way, the job's reference
  keeps the queue, and so the entity in it, alive.
- msm_gem_vm_close() then calls drm_sched_fini() on vm->sched, which
  frees the run queue that the entity still points to.
- When the in-fence signals, drm_sched_entity_wakeup(), which the
  scheduler registered on it, uses entity->rq->sched;
  drm_sched_entity_kill() leaves that callback in place. A killed job
  is freed then too, and the final put of the queue calls
  drm_sched_entity_destroy(), whose flush reads entity->rq->sched
  again.

Patch 2 destroys a VM_BIND queue's entity when the queue is closed,
by MSM_SUBMITQUEUE_CLOSE or on file close, so always before
msm_gem_vm_close() tears the scheduler down.

This comes from code review (see the note in the patches), and I have
not reproduced it.

v3 is at
https://lore.kernel.org/r/20261114141851.134290-1-arpe1618@gmail.com
and its patch 2 is unchanged from v2.

Separately, Sashiko's review of v3 found an ordering problem that
predates this series: the VM_BIND queues of a VM update the VM's VMAs
at ioctl time, but their pgtable updates are not ordered across
queues, so an unmap can reach the pgtables before the map it undoes.
That does not need a queue to be closed, but v3 patch 1 adds another
way to get there: the unmaps it applies when freeing a killed job are
not ordered against other queues either. (Its other point, that a
killed job's fence signals before those unmaps are applied, I'll
address in v4 as well.)

For v4 I would make a job that unmaps a VMA wait for the job that maps
it. The other way round, a map that overtakes an unmap of the same
range fails or gets undone, which breaks that VM but doesn't leave
freed pages mapped. Ordering all VM_BIND jobs of a VM would be
simpler, but turnip uses one VM_BIND queue per device plus one per
Vulkan queue. Would that be the right direction?

Thanks,
Jiwoo Kim
