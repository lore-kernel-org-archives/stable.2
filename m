Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296677;
	b=VriieQO2+wd/KLM367vrMdBiHwYJJRdywXM38LPPSBQtp/jwMCQ7dvsntFoZUJ30NEnQ
	 zXya+BYIAFvtDeCm6HYYcKhNQ7XZn0E2sAjLTJM/28llK++mrtXTflE+nEHT+FZoUvXvT
	 3Q4H54usMTahyi7FsaOd4LOaj5wZJohQdgFMV25pqDXCi3izg0Mq2/HsVbxiHGtmlB9Hl
	 gcYua084De6cDi8cW2QrI5o16oAHB7K8clazlhkAvs/vDNY97AZer8MiWbFfJORsC4FF5
	 S2VVimShbC8WbITr2Tahkm+rNQaOdFcpzwEvSng7gdadbpdJP/5pkgnnGSbpANWUmFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PES7WQFSfnGS0bKHflvn3Tx8NVQZSxqZ0AePu085crw=;
	b=XZCxJSlbGgU30p72e/mt8/khOkpoM/gr1sVSlfFQ93H+BJg/e8S5RICOqGSvovtVVStQ
	 tVpxJMvQy1EwCyf7K2H2JzkjnIdLP4PnmmBbOeG0QmVd4Fq4YBzeoPNlFW6ePdJiZnEeH
	 IBvcGaHY3UDgQhJ7++qv9dp2PwS0GsfFI5JXeKmQPp7Su6zkFxrOvIHvOyK1XKmfS4FY9
	 eJZy2pe7XFabQ+QuzGMweQy6HYBaMeRz3cTiqzm7PdnXcDR8Wkc8CpHhv1NJ4BqpWL7PN
	 NGV7sowhZSIwDT4vB4sc1Hpvp4Z4bcKVQ0HEcFctNUdVJltIw9CLArv9gUgt2o9Um+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=EGsQ4CX7;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DF606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 713DF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=EGsQ4CX7
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71acdd32a53so850306eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296676; x=1795901476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PES7WQFSfnGS0bKHflvn3Tx8NVQZSxqZ0AePu085crw=;
        b=EGsQ4CX72iXKkcNpE+HIKKPlOtZmurhvd2/Oep/sf3D+QqW8hXUYFm/CKwGFmhmror
         ILv58YOrI+gjIrxXEw+FJ6xbeWOCTdeeUuYfcB3n8VtR1catsst0nDGiQTRfA1EfoN5J
         Ska1cob4peXJAwIjDTtM+BM7+SU7FEojSVSeTM5b2ycH2fngFhJPtmZqRq0gXZ+PlGNQ
         EFUC/XTMQQ0Lw1U/ETMZb46RqCBdvUoMrDQHYKqKvyc7hjPB6UKrB8yrcYXpxXNbrW5C
         ynN+EqwUYAZhC1RJkHv+UHp+jvEl331RyVFI2jYl/UYEcVgAMUDUhek639vmWSf3Opmi
         TahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296676; x=1795901476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PES7WQFSfnGS0bKHflvn3Tx8NVQZSxqZ0AePu085crw=;
        b=zle9ZqJHaCgYb+1a8DuUKjAopWXoFwiXNURHBkQ/3eOOOQKEFg5tWW0wLiF9es0oo6
         Yryw02tujcHJKa95e7PzsTdGVHF+DCvxDqeBkur9Y8j6nxkNiZMiDD0W/ZwdM5QJoqC7
         bEgBIjq1MCShBgwMjW9fcLsLO6Alz2Af6agTLbb2nZCr755Ga2TaZmrgYahSsdIxt7Hw
         ffq4qL5SRH2DqmlfH07E8IgQhmY/gXwo7NtO736EaKa9iYDRt0fT9/sqVkH/+UdKQHDS
         /1EhfZy5S2veBBumNdl3zJJPP55Dj8YE7xuocyIs4eAshfsLq28ExchvHIgH8GwmLqLt
         Yiag==
X-Gm-Message-State: APuU4Z/eTKiya6dbruqisqwnIZcpuZVgYSxCzsCeFzWkukwQKV+4QuDW
	ZYyIglf+xLWv0DcnsdJQuQ5LgdDf6waAKyTqDKLIsTL9i0rO2i6bitY2xRotkp5gFn+3uCZFAsw
	RBGbxkZY=
X-Gm-Gg: AZFdTZcd248PEHZemuwB1LJQkFgDLD5+rbeYNwCwOM8fQPeYPl1aXKcpzYqcJ3A3eve
	AvT0BzDTenVx9BMQKtxRqJ51vbpyhoqGBPHXH1ammVGamChZCH0wikEyK8htx5AQrzcVAQyTAKi
	KPJoX74/pi3hQvWTY5uJHV1sWRg93ME+scla864GiWKEJEkqdCJwsb0Xcl8XCS/hbwWXACK6HLd
	FRWivzmOcKm0yU+jdimla0m6YBMUxRM0qSbM7yh3RHvbchG5e2Ug9fCnqbVbGjFQao6UbVEfYx8
	F8I2FWJBrk2Gn5aRtWHrZW8V2Rybu5LSIkd6aXYPmdP/dQngqWcYPV9v7RcTkNDHV/fqEr5rgos
	hteojPSFIMOnf/22aNvBTZNvFuIrGyRjcPLaJsluzf3JRUCOnlvGpn+K0fgiCk+0mPavCDDR7LV
	bH22/N3V1gPxBJwp3FiZ+lncRzbrw6tLPIOtGlBv9TUUtp0g0/7WUdBmW2smMPTVF32wN32XuhW
	e+qOR9JMVDpfYkeGhEpCUy85+lLNIeb2neQ/wAvToONriLIr5iNoPyFS5m91hSMDnYBhc9FsjSL
	y4e+mB8sVKTOOOV5UWxLBVQhvBYLqB6BRtJh7dliwHaotUrszgGGUVNqUneptaBn7HMKLA1sPF2
	puaLUBhdcTMTStee6wO8p48GLF86/7qp8LM7E
X-Received: by 2002:a05:6820:614:b0:71a:f794:49c6 with SMTP id 006d021491bc7-71b39566d0cmr6012483eaf.69.1795296676318;
        Sat, 21 Nov 2026 13:31:16 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 19/19] io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread
Date: Sat, 21 Nov 2026 21:30:49 +0000
Message-ID: <20261121213049.1788332-20-axboe@kernel.dk>
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

From: Shakeel Butt <shakeel.butt@linux.dev>

Commit f013b695506491c5202a412a6568313549c81f50 upstream.

The SQPOLL thread never returns to userspace. io_sq_tw() runs its
task_work, but the rest of resume_user_mode_work(), like memory.high
reclaim and block cgroup throttling, only runs when the thread exits.
So memory.high reclaim only happens inside a charge, with sqd->lock and
ctx->uring_lock held, and not at all if the charges can't block.

This used to work. The loop called io_run_task_work(), which does this
work since commit b5d3ae202fbf ("io_uring: handle TIF_NOTIFY_RESUME
when checking for task_work"). Commit af5d68f8892f ("io_uring/sqpoll:
manage task_work privately") replaced that call with io_sq_tw().

Call resume_user_mode_work() at the top of the loop when
TIF_NOTIFY_RESUME is set, with sqd->lock dropped. It runs once per pass,
so a pass that charges two or more batches still reclaims inside the
charge, as before.

Tested in a VM with memory.high=64M and swap on zram. An SQPOLL ring
reads 256M from /dev/zero into untouched memory, 64K at a time. Before,
the thread made 337 calls to __mem_cgroup_handle_over_high(), all from
inside the charge. After, it makes 704, all from the top of the loop.
memory.peak stays at 64M. With 1M reads, 296 of its 385 calls still come
from inside the charge. Both runs take about 50% longer, and the extra
time is in the handler, which now runs more often. Without memory.high
pressure, the test never calls resume_user_mode_work() and the times
do not change. Lockdep showed no warnings, also with io_uring_register()
racing for sqd->lock.

Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Cc: stable@vger.kernel.org
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Link: https://patch.msgid.link/20261101022146.309201-1-shakeel.butt@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 3d0fbae80938..263da37d45ee 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -318,6 +318,18 @@ static int io_sq_thread(void *data)
 			timeout = jiffies + sqd->sq_thread_idle;
 		}
 
+		/*
+		 * The SQPOLL thread never returns to userspace, so do the
+		 * return-to-userspace work, like memory.high reclaim, here.
+		 * It can sleep for a long time, so drop sqd->lock.
+		 */
+		if (test_thread_flag(TIF_NOTIFY_RESUME)) {
+			mutex_unlock(&sqd->lock);
+			resume_user_mode_work(NULL);
+			mutex_lock(&sqd->lock);
+			sqd->sq_cpu = raw_smp_processor_id();
+		}
+
 		cap_entries = !list_is_singular(&sqd->ctx_list);
 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
 			int ret = __io_sq_thread(ctx, cap_entries);
-- 
2.55.0

