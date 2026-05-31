Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234C5474F
	for <stable@vger.kernel.org>; Sun, 31 May 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780234172; cv=none; b=YXaszpXU5vzn41F88eIl/0Mj6X2gtxCxgMYKZKSLc+MwxmRd+010CbauXTun2a1KVgexYGWEUYUnyvYa9PsRAAEr9P/lPJUmOS4wpugY/Eccp/YnoTEycioE3wLLfpELuy5JYajmOCtqJmhsU6j2KKX2lvOaTC59VW7ucd6+m5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780234172; c=relaxed/simple;
	bh=0qrAIbvC63IS8BEjtZEusW7k5lHdMo7Dalz14xMeN2A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eyHTxnnO0glH3nhnxcYzVN4GCtKz8iF7UQ8TaxoUQkqIIrJWWxJ3kIT/Kkq4FILxx1yIj8DUJzZMOY/e9ixrwD0NIl3pp+khFPidjyFpL1olKLNkr/rf9J2Zo6ZGbyZowMqeG7lj54NQ63VVbLo2fklqnKoFTdhPx6d8+0wEz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTuxJuzc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTuxJuzc"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36d9f91a336so182055a91.0
        for <stable@vger.kernel.org>; Sun, 31 May 2026 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780234170; x=1780838970; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuDSgqRRHkSSjLap3TemoZOIyfRnlWdOQPsLTnhdd8k=;
        b=dTuxJuzcUVaycmZ7W8Lh45z3SsNU81ThBGIDEfMcbSVIxyGLMRiLiO7O3LqhF5cC88
         7f6fXNHUXL+DDYKFVxc8+f3V1HPZisCZCA46YzKtlzZDYEkF7XIVgmPbCbNAH6RGblUX
         QU9NuiXkR0HZFiISpwybk9WQYtwT93uWiRt4f/uIxrzmvbHKn0B7hW51ejoc6BsnafGz
         xXzNwWKUByQVUr13+Aa6kDi9948CwdIg7ySgX8lTq9JNzMLX46YeiZsIZsqaeifdVlji
         1eLXJQCVz9p0dzD919rtDbq0Xgp0Jx5iY+M7SuJoYyJbMDWV/9nvmA4ayaeR/i1kq6Yp
         WryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780234170; x=1780838970;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuDSgqRRHkSSjLap3TemoZOIyfRnlWdOQPsLTnhdd8k=;
        b=rWHKn9z0Mz8Wb79FlwLkeYLU4tCXlqSQicYH5n0/l2kFYVp/vE/eavtjta8otMutcI
         ZTMab5CeSUhEQ0N31Pc/obYTp6cT8u0Xm1xTa+sRXyLz8J6hmlYcbGZn1+YXoufou/Fm
         JSihKV075RrNqRe4SC3Qw7xhzJroPpkEMZnc8vabCUNPQaPYVfg4hCuQxER4YK7vzxb9
         R7vlUNufjrEmwZIIgGrjB/ENnIiXUKbR0ipZr36fLYUcGvSusJ6c80ilNlrvjtIGdf7X
         LP+3yhmBcqsNR9TH57sX06ksnowOnBgU3b19xFokf73K0BqOf3UMk7p7N7/vJ/Srjz7l
         cxCg==
X-Forwarded-Encrypted: i=1; AFNElJ/P/4Spr4/iElQflUW61MiWFG4tRL1H07+QV0PFdTM3hdy0m6QNevy0qcBIQarYHt7mSp83CcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaJXoZwZNjchwAschVOQQmVsqd5Du2X/XYlao1saH5p5OlDEA
	UqV0WGdBbdDmtzUlWeQ9zeMInYraURkEs3x3dJmg89lVnoD06L1cDMUe
X-Gm-Gg: Acq92OHRHyKqTSsDvoibdXzGZ3WAW232fWNVPywX/NzTa0oCD1YuxYWA6NTp7jvHYPi
	I/q9wWFuIqOIAAnwVckpnpZhtJ9kv4OF34Ey8tIfzAuqNaM8GovIa8wXvVKDEXb5xeNyniEfoIL
	6zFOskfYckZ53bJvkntfIrH2piXc4IVNrKk9b8U/fNijlg0wAh6n3fsPOvPZ5XdQhCy6uN5yFgw
	iv9QrHPt85JMTDKbOR3lZ8PlxPJUUJymV6qwK+Fb1xmr/ukhEB8gVVZGpwYrxQA8yg6hl7Lu2TC
	kRoynwUgfvYcjzXKX0V0P4/EUrtZK1VL5cO+Xripnk3718/1yK6zGDQFNsHkyABAADGczSCEo73
	ma+Kmz5cMrrjadOoCYJaOwqctbTYOWF544EHlap3s/nRhwMNlpX4uKqi1czQ1P76fDw4GTTwyjf
	aiQmhuqjbtY24bIv/PGK0YlcE7CQnKXQkVDUnfaprAjiB5ZZVEGj0nQw==
X-Received: by 2002:a17:90b:1981:b0:36d:86a5:5b8 with SMTP id 98e67ed59e1d1-36d86a50739mr2020494a91.11.1780234170380;
        Sun, 31 May 2026 06:29:30 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdd1a855sm3477044a91.6.2026.05.31.06.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 06:29:29 -0700 (PDT)
Date: Sun, 31 May 2026 22:29:24 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	brauner@kernel.org, cmllamas@google.com, aliceryhl@google.com,
	mo@sdhn.cc, wedsonaf@gmail.com, Liam.Howlett@oracle.com
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v2] rust_binder: use a u64 stride when cleaning up the
 offsets array
Message-ID: <ahw3tFhLz9bMMJAO@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Allocation's Drop walks the offsets array (binder_size_t = u64 entries),
cleaning up the objects, but it used usize instead of u64 for both the
stride and the per-entry read.

On 64-bit kernels (usize == u64) this is harmless, but on 32-bit kernels
it walks the 8-byte entries in 4-byte steps, iterating an N-entry array
2N times, and reads the always-zero high word as offset 0, cleaning up
the object at offset 0 N extra times. As a result the referenced node or
handle ends up with a lower reference count than it actually has (a
refcount over-decrement), and binder's reference accounting is corrupted;
for example, the owner can be notified of a strong reference release
(BR_RELEASE) even though references still remain.

Change the stride to u64, and read each entry as a u64, narrowing it to
usize with try_into().

On 32-bit ARM, when this over-decrement would drive a count below zero,
the driver's existing refcount guard refuses it and fires:

  rust_binder: Failure: refcount underflow!

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- reformat to satisfy rustfmt, as pointed out by the kernel test robot
- v1: https://lore.kernel.org/all/ahjpn-3WQTywTdyj@v4bel/
---
 drivers/android/binder/allocation.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
index b7b05e72970a..ea5846e4da16 100644
--- a/drivers/android/binder/allocation.rs
+++ b/drivers/android/binder/allocation.rs
@@ -259,7 +259,7 @@ fn drop(&mut self) {
 
             if let Some(offsets) = info.offsets.clone() {
                 let view = AllocationView::new(self, offsets.start);
-                for i in offsets.step_by(size_of::<usize>()) {
+                for i in offsets.step_by(size_of::<u64>()) {
                     if view.cleanup_object(i).is_err() {
                         pr_warn!("Error cleaning up object at offset {}\n", i)
                     }
@@ -420,7 +420,8 @@ pub(crate) fn transfer_binder_object(
     }
 
     fn cleanup_object(&self, index_offset: usize) -> Result {
-        let offset = self.alloc.read(index_offset)?;
+        let offset = self.alloc.read::<u64>(index_offset)?;
+        let offset: usize = offset.try_into().map_err(|_| EINVAL)?;
         let header = self.read::<BinderObjectHeader>(offset)?;
         match header.type_ {
             BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
-- 
2.43.0

