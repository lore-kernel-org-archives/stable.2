Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296671;
	b=l3nBWNSRle9p9CFcfcA6PZ69E2AFm78J/o7dH43DmZMxGWTQ8UgfFxpkAbTJ3q3fHmea
	 yIzKC8lw4bLAj53xza2fPoJit3c8vvvabzX2jEg5tmjBSOIthvzixGpmwOvOrs31OhdYE
	 j3+77lTFxRjvCCPnlIRxMEvvwQPcb0jCGruGItR85oAq0yoP5mfMzM9TPRJeneArO/d8Y
	 rOsxtWO4Q+hcooR/uCKajX5EO+ZZ9+gCFg/QrvVamivneUN6curQSGVqq+ypGojE6JclN
	 24Gryf0b/KAZ3f23sFdY3eNhewiqdQ69T4CKtFT++3LcVi5ckwOW/4CnO+89Vlpb8DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oXZvIM1c/vGmRHDnixm6Uwh2sWA5STwD0PDsc5bGI+E=;
	b=ENYFi0eD2YVU3h29PU9nkeEtSJDVrYTfkGhfKQOfw8ce+FXfMKpO6inus4LwpEnRCc5i
	 iPfmiHG9YXt++puoBKqxfmNpesxAH95zbWf8/lN8zm2jGFRwURQQG7ZU9+WuZjk9Em7Ya
	 iDgpD5NziIsA7ggkvpQQAhD5U87eIaSLy2l2DXcqPcF/J7C5P6Op8rWgUr1YDXyseg6ES
	 1Gh3vZiCoa0WC2iTrkG6z19tZRBIMRR8tGcbc5tGyQsrN67g/CQdpC/AC20W57Q0n7uCJ
	 076/jep0/dbsnYpEdD1l7vBDVF+0z2fT+iWA8iEmItcBdRBwkXUVv7gNN/eWqAjLOSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=brPczO15;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1C606A699
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA1C606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=brPczO15
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-70b875f6f1fso1700307eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296670; x=1795901470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oXZvIM1c/vGmRHDnixm6Uwh2sWA5STwD0PDsc5bGI+E=;
        b=brPczO15SqIgffqbJPKgmRzoVQUZAZbkROw+cHbZ42zxpiTH9ulR7BrQ2cjQpqDb8X
         JMelOadTyVmuvN8NRF74T7iddaBkvWOVZPudxYhhHKfJTTN6jfum6th5onMO2vXH/Iin
         yVwgkP98eplhFZXUd+CvjbzKeFf4Cw6O5qN7JC2vUQk9g+rfUU7Xb9mULnwTBeDKctYG
         Zhvlwm46NDc9TfYHY3ZDnvFIhQtBmf0NyFLsn9ZA939kn5SCRCakyURaPaNBMRaIMSmd
         S5vJ96Rtrzv5MfoNHr2OPO9R5teEIBi9neex6kWdOUpX0pI7nJrClQhNWZZvAIAr2wgt
         fDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296670; x=1795901470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oXZvIM1c/vGmRHDnixm6Uwh2sWA5STwD0PDsc5bGI+E=;
        b=DI1KI6y5upr5AWqWaiJJvqgqiL4BfPimVPvAPeE4XCZDlcghLHK7ugLEfqOZecm8F1
         bONNuhRzA0Bz1hfZ3WvHA6jA4tD4b2rZX3TEA7av7rCYz2r66k9eSgLhzjkVZFqZq7Qm
         QrdGpwn7dvVqr5hDvEHLECVMpd2Y8p1f+zjyY5eHA4iUWkVyXYI2AI64KT9YWLP1xjPk
         I8VJBZWgF9P4yDCMeaZalEcoq96Q1WUgMdWPHkhmk0aMLpu9J2AoUfV3lQT4fXmc3s/9
         CjBMpMy75hrrg5Vf9YB+/KsQp9dXN8a68fa0K2egnjs8YolbfxCtrIukktTb7lsHXq3o
         eIpA==
X-Gm-Message-State: APuU4Z+aFbKA2f2TySxAk1oIAL25iA9QL5SykggWsPAQ4emZUQjNJCu3
	FxAeSJUGiyPC/MfkqR/pJkw+bnrNvNhNXfuMK/qszRXqg1GXQFOBLEV+ARHM45gJcfJeZxdmAli
	KGwmT0fs=
X-Gm-Gg: AZFdTZdGPrZptpr3XkuBF0LklfvD/Y0x31AJFucHczs+2ohSi/t7sh95UYFsnacnIbe
	Hcyu5t9niK2k1d2j4TvvbrVHRPH7JVAakcRs01UK1Y5D8ueb6SsCxFDE4u3GvCw6A4yS4Yn1X6o
	HiE71fOlaerWIRLsYakrJBkuA5GpDI73IE6b9wVlTeoKmKZw2XaQQARB/IvOfzOTmc3b8fIat8E
	+L4mgtyQEvfP/sm2Vyy3djkDi5BeQuno3iR0pHFesqbeI21wpTg9WWzWPucP1+VKC+lpQ8S8Zqg
	1L6/dpEIpb0mgPfK1HmDYcs773IxxPU7lChUvKrOex2g6Hyj2TPKsAFC7GkaoF0Q2FDiZGU2rPG
	4LU2aSkkfROiBTwkWfQZEKJu6pWYCrKcTKVYNfBiCQuNO4calcknZiGAwYhY6ieJwtKrm5CtAud
	euROymB183ziaB0rWzTJy30/DDmf60ffTZP/7tFwGmiN27mM7NLT9KH+85IYmytQ+OjlM8M0fRp
	zQdG5s6MI/AH2cdcBnAzIj82/e/NXo/ZpC8mtO9I8lGm+5+8tG+Q5Ob8rIPdzCWIq1qOTONsXuK
	T91kwtVT7s4aPq13F2ks/P4Of5QnURLyu5PnXf53xzcYFaHpt8s8jJgolOEtN51/D0Bo/7btY9F
	dP9mrgpykHTa4bic/2zi/CkmOAnHif95DRNOKQE/iQe+L+PYrAjkppI30SQ==
X-Received: by 2002:a05:6820:c0cf:20b0:6f8:51f5:b9b8 with SMTP id 006d021491bc7-71b3920fc6fmr4342792eaf.7.1795296669780;
        Sat, 21 Nov 2026 13:31:09 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 14/19] io_uring/sqpoll: ensure task state is TASK_RUNNING when running task_work
Date: Sat, 21 Nov 2026 21:30:44 +0000
Message-ID: <20261121213049.1788332-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

Commit 8f7033aa4089fbaf7a33995f0f2ee6c9d7b9ca1b upstream.

When the sqpoll is exiting and cancels pending work items, it may need
to run task_work. If this happens from within io_uring_cancel_generic(),
then it may be under waiting for the io_uring_task waitqueue. This
results in the below splat from the scheduler, as the ring mutex may be
attempted grabbed while in a TASK_INTERRUPTIBLE state.

Ensure that the task state is set appropriately for that, just like what
is done for the other cases in io_run_task_work().

do not call blocking ops when !TASK_RUNNING; state=1 set at [<0000000029387fd2>] prepare_to_wait+0x88/0x2fc
WARNING: CPU: 6 PID: 59939 at kernel/sched/core.c:8561 __might_sleep+0xf4/0x140
Modules linked in:
CPU: 6 UID: 0 PID: 59939 Comm: iou-sqp-59938 Not tainted 6.12.0-rc3-00113-g8d020023b155 #7456
Hardware name: linux,dummy-virt (DT)
pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __might_sleep+0xf4/0x140
lr : __might_sleep+0xf4/0x140
sp : ffff80008c5e7830
x29: ffff80008c5e7830 x28: ffff0000d93088c0 x27: ffff60001c2d7230
x26: dfff800000000000 x25: ffff0000e16b9180 x24: ffff80008c5e7a50
x23: 1ffff000118bcf4a x22: ffff0000e16b9180 x21: ffff0000e16b9180
x20: 000000000000011b x19: ffff80008310fac0 x18: 1ffff000118bcd90
x17: 30303c5b20746120 x16: 74657320313d6574 x15: 0720072007200720
x14: 0720072007200720 x13: 0720072007200720 x12: ffff600036c64f0b
x11: 1fffe00036c64f0a x10: ffff600036c64f0a x9 : dfff800000000000
x8 : 00009fffc939b0f6 x7 : ffff0001b6327853 x6 : 0000000000000001
x5 : ffff0001b6327850 x4 : ffff600036c64f0b x3 : ffff8000803c35bc
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000e16b9180
Call trace:
 __might_sleep+0xf4/0x140
 mutex_lock+0x84/0x124
 io_handle_tw_list+0xf4/0x260
 tctx_task_work_run+0x94/0x340
 io_run_task_work+0x1ec/0x3c0
 io_uring_cancel_generic+0x364/0x524
 io_sq_thread+0x820/0x124c
 ret_from_fork+0x10/0x20

Cc: stable@vger.kernel.org
Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 0d749588ab21..cdb35cb651da 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -361,6 +361,7 @@ static inline int io_run_task_work(void)
 		if (current->io_uring) {
 			unsigned int count = 0;
 
+			__set_current_state(TASK_RUNNING);
 			tctx_task_work_run(current->io_uring, UINT_MAX, &count);
 			if (count)
 				ret = true;
-- 
2.55.0

