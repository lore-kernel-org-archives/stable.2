Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068226;
	b=C3i6b0lR1gisTZjton/9eIeVDhKPXkwuu4cjYDJ/QilOuua09fCyOAFI1jSbr7zNpuh7
	 vzpDKezGHLMbqxIYKAVVFq63unD/Ud4S2Jvox8/c4bJKLkLn3cMlAgbtxDv9b1c3zeJ5Q
	 PJdmB/DRAjRZqqU/Hx+3JPGezN7lIm3sOtxnTMKpdOuzgwIa4fq54Io+z2H6msTctVCtC
	 sgX3ztLndB0PLPiZDSXNJ8so4vA4tRCvI2CpAiI9IVhinwpczYqdB+gCMqECbx0ZUQKVN
	 SNxzSqi5PfhzjOXU3Z7OmGwjYbVKC0pMj+ti4S1OTfQS5gLXoR+jRpUd+XG3zRRitTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=injL/0Nt+o+8Nf6SGEU7kdyKividSNLGZXFhmJ9vPMc=;
	b=Q+HmN4uDyvQfn0BsnmRgnFXKaV2CttILqxeSvCH/Hqse6MsFqwZF2QDwKYlLWMGfj+WD
	 cSJqPfbcacdoHF+HPv5DNFTM2YsEm3cVYFrD8iVQ4IqR8jnzIGVJs68AJObUBXvhYxfay
	 pVV7bhfyJYdmgMdrLNbljvPAikIm7sm1SMHfATNyHUs0myvsL2vs1/vOnG+Spgpx7QOpO
	 fWwpgOo1WavCG8+2zLkyTpvRWqHl5GQhNM+7KZ1Om1YdKM3M2wBN23ca+tk7RKjilmRrB
	 PH5sajybSDWm7w8gwepewNB0o9qqUykGlwXdijHj4OOiPV9EKy0LxV7lBgcDHd2Vxnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZjfVg5Iy;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC184606D3DE
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC184606D3DE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZjfVg5Iy
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb681db419so126567a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068225; x=1794673025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=injL/0Nt+o+8Nf6SGEU7kdyKividSNLGZXFhmJ9vPMc=;
        b=ZjfVg5IyRVRCq6JPTyhIWpDSdbW5AxgpHzvbnR4gyGKoowzF7r5Asr6+I+3pe0LsNv
         0xLsE4dQlgL4Lb2NXLzEkrTGd6fevGqGNI0rCwaNGg8GtF0Se2dMLHTtgPI0vnoCOT6L
         9XepuF8O1YxACUU0bPaVTxX0cpufhwrDbfXTZxzYdC7vKZrUuaN47WpnTiavwhtd341P
         IrO5+wRcqA4R8jeu6uBzrfBpjwHtvRVucST3Sc5thdvWaOiQ5jIceu4vOqWPGDgmZ3n7
         WwjVe0LCnuAPz5nsr84WPqxihvIFlkwyqPikuZ266TrVplBcQjSAg7BSFFmjjyMO/OBy
         DQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068225; x=1794673025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=injL/0Nt+o+8Nf6SGEU7kdyKividSNLGZXFhmJ9vPMc=;
        b=oDDLBjHDctsGyN7bmG153r8EqiMpQ+6muwWw8O7nAoPA3mClVGQkupRdh3zY/JU46i
         31pt+d2AHp+plFtjsL8ifwJjuUrIpg08K3No1QOgO0ICOyX3+QurXDc2jbIwBR3Y/rqC
         4zBfErqOu60w2BRkN8wKjpkKgjzcZonmMnmuSDvALHzoON84cZCrAS1Vgk2H2pBBGGNR
         0db1uBsSoDg2cArEx1nEq+PpMXoHGBeV50s4a1Mv8qJma0jqgd2ehpUjtYKEgqhmLgEA
         Ehle2SWoBjKdDBUkENP15CqjfbrstDGrX+6GOqBK+BlUT751DFjPiusja1Fr/039+iFH
         27WQ==
X-Gm-Message-State: APuU4Z+4Ee4Cp76SIKAFtrI69oueXe5yGo7ML4bri2XWgk6I4akYMo4Y
	bc0rMD+Y2yJvdOFlZF1gPBryzgFwp565/gs5hk1VyjVzU39DR28uKk/sBkfXFLHEmDtpcG/eadg
	SYz9/MMA=
X-Gm-Gg: AYBFou0AFY/vC4+KNfKqvk227lKDd979Pcm2WMMVU4kZGK5BlmM66f7RYlk1QFOvylo
	Jk8jJqBcVzw9CsgwaWwQavgMwJAGJIcCJWFW7w0I85AcFyhKnacyLvDGo4a9MwREuO+klCN9C+s
	BXCc2xqrjxlVsKPqpjAKDwWEzoxRk4VlpF49WaMAjPAqQEVkRowqG8JlJFnDbhNqdR19LOY9KUX
	kdqGXNNFgg2Bfi2+h6sDCo2jeE00zNhZNGNkenXnCNjRozH5ggKyWLg+GU2s77GxHyXXd/T/RQH
	jeNjcaAOShzpwo/qegtk6o3kS774HD9MqdY+m+4TK1q+PdDcg9beAF7Inu/Ir5ebpYBYz2GAFrB
	14hkZ6lWOP6Co2laAaUKpXfWIgGP+HuOuD2LdZXBPke7JI/i3G/OjveYiW3ob3KEgOJsudtHDV2
	VQ8LJADVkpOBGA173owhIhTecBvm2IkI0dKjn7vlm35g2YhHR1erEfTj/Wd+0TRndYDkgBcKeNP
	OQ5xY4DM30cI/AIfiZG2nhoSaDnVVrwM/mlmz4I5y/419gfGjrsr0kzT17Gh5qPo7NuHnv/PCkt
	MJ76Jo3kD+c1X7fRs8d+jseuFjNnrxfFciOA/Adhq+1RBgu62Epx2h46LwknzffZrtvxKc24rKB
	al7kh02QT+XBH8pTzoTu7
X-Received: by 2002:a17:90b:2f4e:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b1065a4d96mr1522208a91.38.1794068225098;
        Sat, 07 Nov 2026 08:17:05 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.17.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 4/9] io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread
Date: Sat,  7 Nov 2026 09:16:51 -0700
Message-ID: <20261107161656.2500790-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161656.2500790-1-axboe@kernel.dk>
References: <20261107161656.2500790-1-axboe@kernel.dk>
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
index e86658ede44b..d387488db2de 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -349,6 +349,18 @@ static int io_sq_thread(void *data)
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
 			int ret;
-- 
2.56.0

