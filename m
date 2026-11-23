Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474360;
	b=GZuqs8PyXQl341XKHJQo/G0HKatSgp026ng8d5DC80kImPuxZ5z4VnHs+yASrL1psdZ6
	 BZ3t9mRZEyxgTF1hVSG54KNPfy9VFnh2+dH1C0KXM1Xcib858UdzkEUQxpi2ap+Mih/TY
	 uTkU2CQoV8u/Wff2yhDvWVtHicBhBwR8jFsyKrYj+Ina1++50nIjZ+x6tLz47OXJaGb4l
	 YVnfZa48xk5XGkbrUgFzRJNuJnO6Z8uQagsJmbsZROa4sQl5BYg/0w6jNatRYxMTZkbRx
	 92uhT9NjLD0GpjHnTIeqHUDpKw+hR9q9w5RNaKoo+U8DDreFbjYfhBhmamh5ePG4Waw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=RI0AtgIIgYmtt4Ma9wBNFrtD04UI1YpHvkXQ3fFrXjE=;
	b=hJz2GMYXsaYQV+tgOA2UMS+b+8ni8JRPMIcu+k6USeqO+PaTe1MObhLWkDsm3V2JWM5W
	 U6+FTMsRuv6fzR34APxEbPPm5xiVPbVHk9CgrMkRQ82ZBmii+3pgPZxEwOOgJZCDgIsmt
	 CNOcfwneO1h5VbkCLIFMaiZvw5VHYX/on4Uz1xEKChqVbrQqxIQ7SAKxn618J3LfG+JZy
	 sTrsepCPEYCzikJ5oSNXsnAr6YX4nWyx/0aEIspDO7IYbvN7GXfD7AScTAU35hAXUFcf0
	 4YVZd06B038d2i9STnDnxU5P56XxxY+vF3YvCW2vbfhUf3zUN5X7J3C/HY57pp+wuYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QJbnfzdo;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55EB606A32D
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E55EB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QJbnfzdo
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b26d8d2498so4358286b6e.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795474359; x=1796079159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RI0AtgIIgYmtt4Ma9wBNFrtD04UI1YpHvkXQ3fFrXjE=;
        b=QJbnfzdo+dOVtDHdBjdRE/bxi+HuVKnhQQGaCRKLLYNUMoz8qskc81xHC4xFq7A/n/
         88VwdEky07fQhkl88C/iBNQj2srO+LtM1YgWCbujyxguGPATn0JV9viUfgpfPILBICMk
         nZbN14+BMcLzuYfc+S2NeTyyzlvI19c8bVAj7r1+Kj5C/YqP0OJAQpp/mvbOkqzvghGa
         2NSLeLoJM1/wt8pWhXgdj5V7o7KSFbf15P8H+2CuyCPaEZXZfVAMPiC1iAfoX5JFeshF
         ee50HgopWUKAPkViI6kmn+qEJP8A8NB8tFYWWPvMGzeiEFbW81BmQn1nPHIwemxYSLUc
         Bmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795474359; x=1796079159;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RI0AtgIIgYmtt4Ma9wBNFrtD04UI1YpHvkXQ3fFrXjE=;
        b=CwNGrpV8x1MPsUb+PIqu6A0IIlN9OQJCJOpPdF7SWSSfjmhmKD4ds69R0i4B5A70s9
         AhN4ka53KkDpOGDVdPjQR5BYUNT/2GBLIIv9CY6+AIaL9jjREjZmOFG+K/u9of4kRmxs
         USPF1alaMwIH9GgDAYdfo6a2yVWl/IqCXo93tGWAtfri/1XU7aQI5q/gbRc/kPoecuEs
         aIorW0iqBrvWVX95QOrqyBB67TUg6pL6LO0rGPuXsNlN1vTKLOBWD/7ETlyg4TsrSO+M
         v7ng2lFsAE2U3x6Hm8w/WUT9bTuPR8BuEIdwnidyDcbmVJSG2HGq/tuAzfhNPuKV8o7t
         EjLA==
X-Forwarded-Encrypted: i=1; AL+hErGESP8Gr5K1H9WrGRPjHvy/4cDjpF82ibyr0z//lRIb4Bv6i0JlYkRXL89QhXW+zYkf12q1sF4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fFIZOVSOBcoXu2djcjCrLBPr09HjTds80EHiIVAUA57WySI7g
	jofVYYex+mhmogmzX2qViGM06EHp1BnHp+2fCgzAJMH6RToEnz1BibHSzrat+ed8UasNRvaG24R
	4TyW1swBexK0lZI5ngxw+d/iCTloNOQ==
X-Received: from ila11-n1.prod.google.com ([2002:a05:6e02:520b:10b0:51b:fd41:6806])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f4b:b0:571:9bab:e8b7 with SMTP id 5614622812f47-57a025e82f4mr15535524b6e.0.1795474358503;
 Mon, 23 Nov 2026 14:52:38 -0800 (PST)
Date: Mon, 23 Nov 2026 22:52:28 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123225228.1652446-1-zhenwenliang@google.com>
Subject: [PATCH] autofs: set wait queue status before releasing waiters
From: Zhenwen Liang <zhenwenliang@google.com>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

autofs_wait() waits without a lock for wq->name.name to become NULL and
then reads wq->status:

	wait_event_killable(wq->queue, wq->name.name == NULL);
	status = wq->status;

autofs_wait_release() clears wq->name.name before it stores the status:

	wq->name.name = NULL;	/* Do not wait on this queue */
	wq->status = status;
	wake_up(&wq->queue);

wait_event_killable() tests the condition before it sleeps. A waiter
that gets there after wq->name.name was cleared but before wq->status
was stored does not sleep, and returns the initial status -EINTR even
though the daemon reported success. The lookup then fails with EINTR.
On weakly ordered CPUs nothing orders the two stores for the lockless
reader either.

Store the status first, publish wq->name.name = NULL with
smp_store_release(), and read it with smp_load_acquire() in
autofs_wait(). autofs_catatonic_mode_locked() already stores the status
first; use smp_store_release() there too.

Reproduced on v7.4-rc4 in QEMU with a debug-only patch, not part of
this change, that delays the waiter before its first check and delays
autofs_wait_release() between the two stores. A stat() that triggers a
mount failed with EINTR in 5 of 5 runs, although the daemon
answered AUTOFS_IOC_READY with status 0. With this patch stat()
succeeded in 5 of 5 runs. Without the delays (one control run)
we did not see the failure.

The problem was found with a Lean-based formal model of the code and
AI-assisted analysis. The patch and this description were written with
AI assistance; a human checked them against the source.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
autofs_wait_release() clears wq->name.name before it stores
wq->status (fs/autofs/waitq.c:518-519 in v7.4-rc4), while autofs_wait()
tests wq->name.name without a lock and then reads wq->status
(453-454). A waiter that checks in between does not sleep and returns
the initial -EINTR (line 413), although the daemon reported success.
The same order is in next-20261123 and the stable branches we checked
(5.10.y, 5.15.y, 6.1.y, 6.6.y, 6.12.y, 6.18.y, 7.3.y); it dates back
to fs/autofs4.

Effect: a path walk that triggers a mount fails with EINTR. Any
process can hit it by timing; no privilege boundary is involved.

Reproduced on v7.4-rc4 in QEMU (x86_64 TCG, 4 vCPUs) with a debug-only
patch that adds mdelay() before the waiter's first check and between
the two stores. A test program acts as the daemon (mounts a tmpfs,
answers AUTOFS_IOC_READY with status 0) while a child stat()s the
trigger path:

  v7.4-rc4 + delays:          stat() -> EINTR in 5 of 5 runs
  + this patch:               stat() OK in 5 of 5 runs
  no delays (1 control run):  stat() OK

Without the delays we did not see it, and we did not test a weakly
ordered architecture. The debug patch, test program and logs are
available on request.

syzbot's open "KCSAN: data-race in autofs_wait / autofs_wait"
(extid c6d286fd51860df64d9a) concerns the global token counter, not
these fields, as far as we can tell.

Found by a formal code verification tool under development (Lean-based),
with AI-assisted analysis; verified by the reproduction above and human
review. The patch and this text were written with AI assistance and
reviewed by a human. Point of contact: Zhenwen Liang
<zhenwenliang@google.com>.

A search of public list archives, git history and syzbot found no
earlier report. Related, different race: the pending patch "autofs:
serialize allocation of global wait queue tokens" (Zhu Jun,
2026-11-11).

 fs/autofs/waitq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 92c0bbbf452b..2496786a463e 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -29,7 +29,8 @@ static void autofs_catatonic_mode_locked(struct autofs_sb_info *sbi)
 		nwq = wq->next;
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name - wq->offset);
-		wq->name.name = NULL;
+		/* Pairs with smp_load_acquire() in autofs_wait() */
+		smp_store_release(&wq->name.name, NULL);
 		wake_up(&wq->queue);
 		if (!--wq->wait_ctr)
 			kfree(wq);
@@ -450,7 +451,8 @@ int autofs_wait(struct autofs_sb_info *sbi,
 	 * wq->name.name is NULL iff the lock is already released
 	 * or the mount has been made catatonic.
 	 */
-	wait_event_killable(wq->queue, wq->name.name == NULL);
+	/* Pairs with smp_store_release() in autofs_wait_release() */
+	wait_event_killable(wq->queue, !smp_load_acquire(&wq->name.name));
 	status = wq->status;
 
 	/*
@@ -515,8 +517,9 @@ int autofs_wait_release(struct autofs_sb_info *sbi,
 
 	*wql = wq->next;	/* Unlink from chain */
 	kfree(wq->name.name - wq->offset);
-	wq->name.name = NULL;	/* Do not wait on this queue */
 	wq->status = status;
+	/* Do not wait on this queue; pairs with autofs_wait() */
+	smp_store_release(&wq->name.name, NULL);
 	wake_up(&wq->queue);
 	if (!--wq->wait_ctr)
 		kfree(wq);
-- 
2.56.1.809.ga0b61035b5-goog

