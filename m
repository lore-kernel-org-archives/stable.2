Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF635B654
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635006; cv=none; b=IIJIgEZkqZlJg10o88iNbUm5C5UceIvn/QZk8xlznfHuYDhYL5d6+EA7ujiXAdQiDshtBXtV2h6yVeEWshYKWbdgo3NxezTjfWL/Yzsy/LpLmNTlZ2bKToclDZ8DXTDZ7WVxCrhcvXsoOgKG329U0xrObhVGxDlrVafuBy0U2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635006; c=relaxed/simple;
	bh=BvsfmQZGexTwt31Ke/qD4tBlI8apaQsexRSTnYusyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDQZefh58P1vhN7c8/ZjRHsz8AB4kO6w7Q9IkvQccdXd0DAcmbTECHekZfHdvrM7Wo3UX3yztpSYhbyrhp3ssmIyVGtJ/lwKFOffwpJTSHHlzwalgJjtHHpJmHV9VA1AiSZJ1z1kMwzx+OMylP+BWw5E/0NPEotTnJyG0BIrhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=C/bqkJfD; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=BHavKA/4; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="C/bqkJfD";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="BHavKA/4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1780635005; x=1812171005;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:x-gm-gg:from:to:
   cc:subject:date:message-id:x-mailer:in-reply-to:
   references:mime-version:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=BvsfmQZGexTwt31Ke/qD4tBlI8apaQsexRSTnYusyR0=;
  b=C/bqkJfDLICyf8DCTVm317fX0GwkV/1XikgnkQyQCavHug+sJTRc9Scg
   Prrw+qO6umjZZ2/AEQONqQ6BDaDW/JEl03XtHW6pr0qOF5nLyLhPfFLfH
   o/cYiMavwtawi/ptRK1ljt+zQLa2DsAhZtp+E78zpCaB68+A+nk/bGEWR
   a63L/FkyFDcKJK8Na5+LpIMoOgkrqZlwTyz8oBnk2VrRqkdNDpinT3V3s
   UKjN5GqSuqJMXuDXAZ+JPYDeWhMbxzsZMeArtuXGq4XprfdG7PJ13AsOk
   kAFr6GhqzIt8FQRr+4NHaVzfM58TTG6J04ml3VSd80v28Z/gCWad0JuLP
   w==;
X-CSE-ConnectionGUID: azWLsFr5ReWQYyMgZNjwXw==
X-CSE-MsgGUID: w7X5S8ZySu62I9EUj2YB9Q==
Received: from mail-dy1-f198.google.com ([74.125.82.198])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Jun 2026 21:50:04 -0700
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30762d67a64so2039526eec.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 21:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1780635004; x=1781239804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNqTnDpUXASOfx5K7wtm+COurinxRQS3wPHTzESWaQo=;
        b=BHavKA/4D8MeSXHIelZgaqUvCIwp1HQ506uv/JqSllorivBEtVXiOuruVaRntXtLil
         zW5JZC8HCP0UHr3qtndDyanlOkKw02GRJOwlCPYR/YZfpIK15ZNMLwdiPSJ1esrUT2rs
         andpRu9GzhvrhRoIrZyxHL0v1vv2aw9+eTA64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780635004; x=1781239804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vNqTnDpUXASOfx5K7wtm+COurinxRQS3wPHTzESWaQo=;
        b=gvAIFVdoAubvWfp5JDe7x30b+rehblE3qLb77XTApBnqh+7hH5vRk6MWIiBJRBCZba
         znrtkSz6chPdXyAwy13g+iku5+Xo/20WU/bDfgLkeIW4UHUAn06Ozb0bumdUAcq7GXuK
         jqStWg/WwXEIiTcJJA81dqyOrgVVZ2MmLu8tAcC1Ma5NVsSIn0wkHDuUKqoK24xa/Ije
         NuYUBHlvqiwVa+fKmf3rtxn7TLOAiZobPiNfQEqTOge2u9wBADwhZsfdA7eMxEKZTePp
         PFS+QvgV5GWElZbVt61SlMo0zyujH1F+U9rA1w0di0btsAErDGEg14AkdQwo1dlc4Cqq
         zsmw==
X-Forwarded-Encrypted: i=1; AFNElJ+vAjz0pQ2yEXCY0rxjZJsdg1UL/EvRh8fBwpMkUOh7FNn6I46wUX4v/X9nZf+zZa4WsVBJacw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWDcmO2NpSN3NebymKNmu+6YDUwXQIyV5cyN2o7usIYab3ikJp
	94m3jQoZuS9yK+QVLS0/tZF63ROtu1k7SlapumZhBfEnak2on3+dsqKo6z69KimoIGJEogBJVUC
	J41M8NR2NQ8qW/N2hvfji0mcp0H76EQOhsPcJTXh2pI2XJvseo6zUlgVIRsg=
X-Gm-Gg: Acq92OGuwnXN5qT99PFdvHlnxE+axeacIsxjk8v4wGLYuzQq0kepHofz7Y6JY10J3dG
	M+VYWHXnq77QWLrBDBb9X/a2pB6Nz5uXAg9JsZ2a8iZow7t+XIPVmgb6aNij2pHvDZT2Bkduggd
	0vBvCJS08NOqrbKTY/J9k807g0lmLaLTTM+y5J6A+cLJLBM0Mkp+mND6HVSs9PakF6rr/5QcFNi
	j2zxIu0JHtHajk1I7GJpz4UaAEk2oai13jDj2Mwq++CvPrUl4yvhnqmd4cFmXuiA65EKQjkbonS
	7e/9T+XicbWl++iwhFBf794iORKTnfQ8CW7s4EqM9a0cQ0lp5PPH4Al5FDxUOPEoAVqYr0iSHF9
	x4UHP8GTNTD094masKJI8XV/1RxVp7ycAZh0MkqJgkJMcSxJYE33ftEjQhnySEFOurh0IUWlYaJ
	9aPxi80ox7eIW+DXbCK3hWqbxJwzahb6aJBU86eFzy2pg1jbQ+p2he9NQaD8cmMI9MuRt5l0QSS
	qHmGxAy4q2S
X-Received: by 2002:a05:7022:111:b0:136:6230:5834 with SMTP id a92af1059eb24-138066fe7a4mr866374c88.31.1780635003589;
        Thu, 04 Jun 2026 21:50:03 -0700 (PDT)
X-Received: by 2002:a05:7022:111:b0:136:6230:5834 with SMTP id a92af1059eb24-138066fe7a4mr866362c88.31.1780635002935;
        Thu, 04 Jun 2026 21:50:02 -0700 (PDT)
Received: from ucr-secure-48-10-13-243-195.wnet.ucr.edu.net (ftd-border-nat-ucr-secure-v348.ucr.edu. [169.235.95.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13805ef12bbsm1056181c88.3.2026.06.04.21.50.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 21:50:02 -0700 (PDT)
From: Yuan Tan <ytan089@ucr.edu>
To: a.hindborg@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org
Cc: zhiyunq@cs.ucr.edu,
	ardalan@uci.edu,
	pgovind2@uci.edu,
	dzueck@uci.edu,
	Yuan Tan <ytan089@ucr.edu>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] rust: block: mq: make GenDisk Send impl sound
Date: Thu,  4 Jun 2026 21:49:56 -0700
Message-ID: <8839ddc5ff54bf454d508cde91d27d00fc3e2dd8.1780633578.git.ytan089@ucr.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780633578.git.ytan089@ucr.edu>
References: <cover.1780633578.git.ytan089@ucr.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GenDisk<T> has a manual Send implementation, but it stores an
Arc<TagSet<T>>. Since Arc<T> is Send only when T is both Send and Sync,
this relies on TagSet<T> being Sync.

TagSet<T> wraps struct blk_mq_tag_set in Opaque, which is based on
UnsafeCell and is therefore not Sync by default. This leaves the GenDisk<T>
Send implementation claiming that GenDisk can be moved across threads even
though one of the values it keeps alive does not satisfy the corresponding
thread-safety requirements.

Fix this by marking TagSet<T> as Send and Sync. TagSet<T> does not expose
safe Rust access to the interior fields of blk_mq_tag_set; the safe Rust
APIs only pass the opaque tag set pointer back to blk-mq, whose queue and
tag mutation paths provide their own locking, RCU, or SRCU synchronization.

Also make GenDisk<T>: Send depend on T::QueueData: Send instead of T: Send.
GenDisk<T> does not own a value of type T, but dropping it reclaims and
drops T::QueueData on the thread that drops the GenDisk.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Cc: stable@vger.kernel.org
Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>
Reported-by: Dylan Zueck <dzueck@uci.edu>
Signed-off-by: Yuan Tan <ytan089@ucr.edu>
---
 rust/kernel/block/mq/gen_disk.rs |  8 +++++---
 rust/kernel/block/mq/tag_set.rs  | 11 +++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..77f9327c0d4d 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -198,9 +198,11 @@ pub struct GenDisk<T: Operations> {
     gendisk: *mut bindings::gendisk,
 }
 
-// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
-// `TagSet` It is safe to send this to other threads as long as T is Send.
-unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
+// SAFETY: `GenDisk` owns a `struct gendisk` and keeps the associated `TagSet`
+// alive via the `Arc`; it does not own a value of type `T`. If a `GenDisk` is
+// dropped on another thread, `Drop::drop` reclaims `T::QueueData`, so
+// `T::QueueData` must be `Send`.
+unsafe impl<T: Operations> Send for GenDisk<T> where T::QueueData: Send {}
 
 impl<T: Operations> Drop for GenDisk<T> {
     fn drop(&mut self) {
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index dae9df408a86..2051f4305e6b 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -31,6 +31,17 @@ pub struct TagSet<T: Operations> {
     _p: PhantomData<T>,
 }
 
+// SAFETY: `TagSet` does not own a value of type `T`; `T` is only used to
+// select the blk-mq operations vtable. The wrapped `struct blk_mq_tag_set` is
+// only exposed to Rust as an opaque handle, and concurrent access to it is
+// synchronized by the blk-mq core.
+unsafe impl<T: Operations> Send for TagSet<T> {}
+
+// SAFETY: `TagSet` does not provide safe access to the interior of the wrapped
+// `struct blk_mq_tag_set`; concurrent access to it is synchronized by the
+// blk-mq core.
+unsafe impl<T: Operations> Sync for TagSet<T> {}
+
 impl<T: Operations> TagSet<T> {
     /// Try to create a new tag set
     pub fn new(
-- 
2.43.2

