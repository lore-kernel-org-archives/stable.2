Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949430D3EF
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780626323; cv=none; b=Jf2tzieSyMibwCdPbtQP/0Y/ZFcyyPdd0Dm31Ap48XvdVd8av90IksDI1OLRr/w+Wv35mIvU3XPC7yN0922c31bJwUn6r/eTVFiEueoFHX+NeHsrqES/dhurPq+qlKe8KGEieiECNLT3cvMjOOdBqkYZLVrhxN2BDy8gZ4Vh2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780626323; c=relaxed/simple;
	bh=HB+SlFM/oJ6M/YFvB3bNQR4gXUPq98BNBncESdeIh+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SstCibqjezoM5P1LjRWF6sXv6rNBxj6TVT3jqDYXNGp9qJRrxBjJaOiktsCj5wohDsTMRickt+I4X66Pz7RLr5P0tKC4OUxQdB//LMYMGaj9x8RQSaO4LXVvAnGHbOg9WMhKlEmvthUWBxqPrm1ghgB5jZUljIgsMLmNo+4Amyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=c1tEntho; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=qOJphIPz; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="c1tEntho";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="qOJphIPz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1780626314; x=1812162314;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:x-gm-gg:sender:
   from:x-google-original-from:to:cc:subject:date:message-id:
   x-mailer:mime-version:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=HB+SlFM/oJ6M/YFvB3bNQR4gXUPq98BNBncESdeIh+g=;
  b=c1tEnthoPHHm2xlO4enyrUFhYTMs11YL8uflUqCSIVTXF8vcZnH5X9ps
   oBddab6aKJWhwUkjS/PqbtMLy7tumi3T94WBVEsDvYo7oNBoL1tuY0SiA
   rI69ZsZflBg6E9i9aaYvPpDweFLGDAqT4sCT2yQtO6DPWfyWOebJ6+Kz8
   2hiCMaqtLIm0mg+mS76oZv91TXxMLU3wI7bVwcEg14ErcOVzDEKf2EAFS
   W+mJccEmdeepfIqPCzjCgAonCQEAMxv9MS44ozHofR9Ts38exOF7yOgvs
   W+7jS4BupBnpx8rjOZwgyBUZI5DaGpnznpYuzKD17VeHicolAhGj2d+DO
   g==;
X-CSE-ConnectionGUID: X0dEihnmTceNXH0esDtFpg==
X-CSE-MsgGUID: tGmIrZRJQ/+jdMmgUkMc6g==
Received: from mail-dl1-f70.google.com ([74.125.82.70])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Jun 2026 19:24:05 -0700
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-137f81004cbso6117084c88.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 19:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1780626244; x=1781231044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TIf9sTw+x6lKIuHB991sq2okHhHs+jRnVDS2tTofi30=;
        b=qOJphIPzSS/Wqx6CyomsEq47+pow43UNhFBD1GXWEx+1Ojkn0/2Q90Qbb3rLo3ECMo
         /9PN1Ha53ehv9qZH+wxoxfUItY+wQcMxAVj3mvrmg5ibH1J3ZMhRF1X81hm2rdG6mQFA
         6VYjNbvXLLr6y1ayzGzSSHGbq6hiSiz8MMIl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780626244; x=1781231044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIf9sTw+x6lKIuHB991sq2okHhHs+jRnVDS2tTofi30=;
        b=nQI96CR5u8bUFw7Ppn9TEyM8QCE3lAV5hLajVai4lYsdxPP2//3t8QFhvMs6vJJ8ej
         eoFwy1D0c6i6uQOKRwksQW6IK06FQBVQeDKKXUrOb0d5UtNT5VFNWRJ2GW8YO9+EzMCc
         qApI1MmY8jzzQKFDSgO4BQdUIHTdXWHYx4G+r3XEwSmFbbsn216jlMr4G42/TO0ryWQR
         xdTgs5aDGLGQty40O8TXEIfufeEGWtxTHFPQMHIe07MPHFatQ9f+8U/KjFEUF7BYUQqk
         XTfHs3WoZX2dsE/JGqUqgVdHECvrb3sH/AK90UuuLfJ2MszJtfd8caEoKD7zusEw+kce
         CcXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mExpmTU1y59wJybMzEiCcOoLHSuZ/ExI9a/CGFMB6+o2s8p0QX+ZWdI0YIF9sdY6H77TyXbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0HfMUNzpn6X+IjiDVaHmC4OuAPM9kCfFqBeG1tbBK061f6I5
	XkVcrB32Kh7SavN61ge6CIJ1gsHZEFfeV8tNVrJ/qVeGcIiudF/GvVutv46yIMoJAZzeBoVbMqe
	hprgGdDOGlmDhgLi/JAUC89MlwhYLHfncFBhFLjCbIOYsfCr6F/37sPS7GK0=
X-Gm-Gg: Acq92OHqMVY8hEv6khXSafZ/uBUyEXk85UBRM7Du2OA0c7X3ZkxqqvUEreO5jwQ3MjP
	8HqadbcMetCjp8Sqb5zbwQNcvQW50X+1XlRxTpwUghTK8bN0gjSNm2BKW98eigyAjnFJmhpjWDY
	PRrFHxQAKXHkYvA8z1LhflpVjMvksYeVkg5ohRtz/qdMJVneuCBUy6ZTzxwScwttlmgFj6fo9pq
	8iXZopXez9wGujGKFSCEhX29CsrU+eJCkicgy74LtYEcYizEpTBYepmetAYilX+RKamJGhk8teE
	/OdXOUFDU3DSnkYN9A1D7XiJEkS+FRGmighBTzUO1smjSSHRzJR3q8j2vrTTuymNF3IjWI7cchv
	aahP5/de0Z+SLjiszlbevTrGVocD0ZY+xiuxFch7PudPaRSOh4HIE/f8qTBpjYhOrHPumBoRGbD
	FJ9/5xtGMUz0cDpA0UcjVOkxZjE/nlDcW7KzC4lZsMq8QRm0qq30Hx7k1LygxQR2Pf/mxHV6+Ry
	HdmjF3AnLqyTMZkAIIzUGADTV4=
X-Received: by 2002:a05:7022:e985:b0:137:ec47:8fd7 with SMTP id a92af1059eb24-138066bd84cmr695727c88.9.1780626244242;
        Thu, 04 Jun 2026 19:24:04 -0700 (PDT)
X-Received: by 2002:a05:7022:e985:b0:137:ec47:8fd7 with SMTP id a92af1059eb24-138066bd84cmr695713c88.9.1780626243789;
        Thu, 04 Jun 2026 19:24:03 -0700 (PDT)
Received: from ucr-secure-48-10-13-243-195.wnet.ucr.edu.net (ftd-border-nat-ucr-secure-v348.ucr.edu. [169.235.95.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f549bbefsm5178518c88.4.2026.06.04.19.24.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 19:24:03 -0700 (PDT)
Sender: Yuan Tan <ytan089@ucr.edu>
From: Yuan Tan <yuan.tan1@email.ucr.edu>
X-Google-Original-From: Yuan Tan <kentertan12138@outlook.com>
To: ojeda@kernel.org,
	gary@garyguo.net,
	rust-for-linux@vger.kernel.org
Cc: peterz@infradead.org,
	zhiyunq@cs.ucr.edu,
	ardalan@uci.edu,
	pgovind2@uci.edu,
	dzueck@uci.edu,
	Yuan Tan <ytan089@ucr.edu>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] rust: sync: avoid leaking the lock lifetime from Guard::lock_ref
Date: Thu,  4 Jun 2026 19:24:00 -0700
Message-ID: <20260605022400.31489-1-kentertan12138@outlook.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuan Tan <ytan089@ucr.edu>

Guard::lock_ref() returns the Lock stored in a Guard. Returning that
reference with the guard's internal lifetime lets safe code keep an &Lock
obtained from a shared borrow of the Guard after that borrow ends.

That is unsound for T that is Sync but not Send. Guard is Sync when T is
Sync, so a shared reference to a Guard may be used from another thread.
However, Lock<T, B> is Sync only when T is Send, because a shared &Lock
lets that other thread acquire the lock and obtain mutable access to T.
Leaking an &Lock<T, B> from &Guard would therefore let safe code share a
Lock whose Sync requirements are not met.

Tie the returned reference to the borrow of the Guard instead of the
guard's internal lifetime, so callers cannot keep the &Lock after the Guard
borrow ends. Also require Lock<T, B>: Sync before exposing the lock
reference at all, so Guard<T: Sync + !Send> remains Sync only for accessing
the protected data through the guard, not for sharing the underlying Lock.
Make the guard fields private as well, so crate-local code cannot bypass
the accessor and recover the longer internal lifetime directly.

Fixes: 8f65291dae0e ("rust: sync: Add accessor for the lock behind a given guard")
Cc: stable@vger.kernel.org
Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>
Reported-by: Dylan Zueck <dzueck@uci.edu>
Signed-off-by: Yuan Tan <ytan089@ucr.edu>
---
 rust/kernel/sync/lock.rs | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 10b6b5e9b024..6c4ebe7c6072 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -199,12 +199,14 @@ pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
 /// protected by the lock.
 #[must_use = "the lock unlocks immediately when the guard is unused"]
 pub struct Guard<'a, T: ?Sized, B: Backend> {
-    pub(crate) lock: &'a Lock<T, B>,
-    pub(crate) state: B::GuardState,
+    lock: &'a Lock<T, B>,
+    state: B::GuardState,
     _not_send: NotThreadSafe,
 }
 
-// SAFETY: `Guard` is sync when the data protected by the lock is also sync.
+// SAFETY: `Guard` is sync when the data protected by the lock is also sync. The lock reference
+// returned by `lock_ref` cannot outlive the guard borrow, and `lock_ref` is only available when
+// `Lock` itself is `Sync`.
 unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
 impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
@@ -219,7 +221,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// # use kernel::{new_spinlock, sync::lock::{Backend, Guard, Lock}};
     /// # use pin_init::stack_pin_init;
     ///
-    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
+    /// fn assert_held<T: Send, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
     ///     // Address-equal means the same lock.
     ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
     /// }
@@ -234,7 +236,10 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// // `g` originates from `l`.
     /// assert_held(&g, &l);
     /// ```
-    pub fn lock_ref(&self) -> &'a Lock<T, B> {
+    pub fn lock_ref(&self) -> &Lock<T, B>
+    where
+        Lock<T, B>: Sync,
+    {
         self.lock
     }
 
-- 
2.43.2

