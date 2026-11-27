Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774968;
	b=jwqkrXd+n9KMnkwAbca3s2mi6/dlYecuIY8Bj3dAa8bTwvEh5Fj2vY33EMA00jkiG/n4
	 tFRdDVQ5x69A/Db6JSgDohpXFJBt6wBRmpkdnEt8aFpQM/1CsjReClnUP+x4jOdrC7XxA
	 69VB8PfTKdgAaES+49R4clKxstGF8awSh9STwBz5614R8RZB+gvvkqq85JoobM82NiX9z
	 Ss1iSZO6gngckwyl6iMxigqc0rLdIzuue9irMSUVOckSrmx6nHHmEOceHLsMq1zu2K4xB
	 aTpjUTPBA5D2e6m9A5JLwNivkwSDcjDN/yyey/sTe1DNOtelSSp4igZhGIxLEs0A20Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6/jX12W92VjHvQwsqs/WyP2fOtVu/lPYryGB5gVljG0=;
	b=nxWsHpeJQib8AGv1khh/+SdgpRaIgXOcL/D7LVF9QoCKU16o2UfF28fvPC0ZSnurRwm6
	 Ml+ypsw0Bk9osjIvUP48ERuKyeaoBFypjPQV/rQaZdqfzBBzHZhXs/l9g+wFoHFYJY+YF
	 OmPAqwjf9Ni0DdroG1Mdn6qxKhbeuhrvwNL5AX64Bqp1T93kMuc9TSaKogoX0Ws7CasCU
	 ZkSoX8ziTiIk7Mne/8u/dwqTNaxhtzWe0FbYidl+fob/27SLvQxSi02irJsJMh74cWN2x
	 wZlZniAJh2I1/TA6xVcrEvEOjG87kBhZhEMiUA8bAHkqfQBvu7Hek4H0B1v9cOoqVrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vd8ozl5M;
	arc=none smtp.remote-ip=74.125.82.66
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC25606A69B
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBC25606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vd8ozl5M
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1b24f4b15c4so3717651c88.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774962; x=1796379762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/jX12W92VjHvQwsqs/WyP2fOtVu/lPYryGB5gVljG0=;
        b=Vd8ozl5MitepFsW7Er+FwXLuVm0MJdJtqddltqXG5nWpwZu4iiIRch7xRVi0DpSGmC
         yHapwfJ73TnQdklxw7yM+rr67SCp9hMcyOwm2B9t7rr6JytBt0PvoiAEvdtCKFKJDkR9
         /R8nLbmT1RHyOzlbtJE+dCjGnXAjkDCXscPthCTj7XqAgL5ey6o69GrP4kEjy9FTEHVK
         EaRPGP7T8msETD1V0+8n7QFF8boJnrZKgOb4Nknv7gYO2kTzHnbHCNs2q1TKnb93dz+g
         5O/ECvJHbXKcqwzLs4FFxG9mebxwWB+FYTvalltaw3FKgJxrK4kYerHX9xsB/0/e1i58
         zmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774962; x=1796379762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/jX12W92VjHvQwsqs/WyP2fOtVu/lPYryGB5gVljG0=;
        b=LTPDgBdaaV+Mr/eMu0gRBM7yj2B9dbRlg6RBouPzvW4bzcFKsOlQ0QT6/1aBsmlUl5
         i3U0Hean1E4jvTNQchyXJqDiIS0/qt6WzG8LeahEpAtTDWNQa3xyyPhDQ9hxStzAckxm
         xQzdW8sF8pxJrqK41i9YK93nH1z3eS0VcE8zWCV6qqKj0USTnHrzAN58u8DqA566WcJs
         WHfI7CDOgUf69CH8DACk2hy3TdCMgd2sHNKPWiJtHqsv+vK8ymo5eLwQR9GAV5wt8y2F
         rYgkJb92bRdLUb1awaNRwb8TCnNn6G1K4uyC8AYPLaAlzrVh+0VoR5Py8o/U7e4SXkg0
         +ouQ==
X-Forwarded-Encrypted: i=1; AL+hErHSTa5SIOgmQRceK8MAaYHLz5+AXXPxY7XTLpJ/cG1zyhk28RAAGfl3Eu8gDjQUEVoO1+jhGE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IHGdd7EGk+PfhJLyvPaqMH/XAHAkqoYhhHD2LUNguA5ZBT+bN
	5eSfO6x1fcqf3LmQxGYXUyFEVMkfhwTKIEyCU8Q3TD/QsRoCejdlqscg
X-Gm-Gg: AZFdTZckv+pLguzpF+700q/yrrWWz1bAdRe5eN4BTFDS+YeKsrjgLarKcYzwM1ZtG8/
	rMysKZIp8SIUX6nUa0Dk0P7hAJe/dRRzUu2WgMclgkBfJG8YGXPnnzCa68EmIlCiH62rAqAB3/T
	Dcp9LyZjChTSBxSzRCpQw3Ns6h9FJ3qh7mqxJC6iDeBAQ8Zi2dmHT4/7TFknUuvwHLXH4Kao/v/
	RAali9eGCnFYvvNkRqbbjktHbg/QOd5Mvst75eL2upsBy0L+FESH0TDyiPfGYwY1oHKPi2rnBI/
	dTun/Tzg38aUHHhctRFu5z7swtc8/+MQn/sMUq9mgaJAf9cBqwWzI13wyECCtmDbmx+SrQ3l5QA
	7DiyQ8iQZ9AmCh8mU2JjbVcdGeeeR6iPcKhFQhRvXT+y/TQNk5ChE3jU5Bdz2CskkbDTyVjE4M4
	3B08nsp7ZlYbFpheZj9Bi4m+5sYRNY71sy/ft4PgPMPLXadIeeqp9RJ3BoPI2Pl3htoPm08CnYg
	I4bhlBneOqFfa64/cUvc2wCIqlILYX2KHtnHGX4eZQ4qOTFnLpZFz3F2TbTXQRZMVroE4dXBLqp
	6fyVOU2Kbe2GL3s8zQp6Bqs1V3RYkCaDCCSqkHQ=
X-Received: by 2002:a05:7022:3f0d:b0:1b5:32d6:6784 with SMTP id a92af1059eb24-1b5525f1012mr24325367c88.20.1795774961922;
        Fri, 27 Nov 2026 02:22:41 -0800 (PST)
Received: from WannaCry ([2405:201:a418:c1d0:90a2:f39d:9eab:aa4d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm62987251c88.13.2026.11.27.02.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:22:41 -0800 (PST)
From: Adhyansh Verma <adhyanshverma2010@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>
Cc: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Adhyansh Verma <adhyanshverma2010@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rust_binder: retry ready threads or fallback to proc queue on dead thread
Date: Fri, 27 Nov 2026 15:52:32 +0530
Message-ID: <20261127102232.74796-1-adhyanshverma2010@gmail.com>
X-Mailer: git-send-email 2.56.1
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

When ProcessInner::push_work() attempts to deliver work to a waiting
thread from ready_threads, it previously checked only the first thread
with an 'if let'. If that thread has exited while waiting in the pool,
thread.push_work_inner() returns PushWorkRes::FailedDead(work).

Matching on FailedDead immediately returned Err(BinderError::new_dead()),
aborting the delivery and dropping the work item. This incorrectly
treated the entire process as dead, even though the process itself was
alive, other live worker threads might be available in ready_threads,
and the process work queue (self.work) was ready to accept the work.

Change the lookup to a 'while let' loop so that if a popped thread is
dead, push_work() continues checking any remaining ready threads. If no
ready threads remain, fall back to queuing the work on self.work, only
returning an error if self.is_dead is actually true.

Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Cc: stable@vger.kernel.org
---
 drivers/android/binder/process.rs | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 1f4cb43f1de..b7b53b99689 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -184,23 +184,27 @@ fn new() -> Self {
     pub(crate) fn push_work(
         &mut self,
         proc: &Process,
-        work: DLArc<dyn DeliverToRead>,
+        mut work: DLArc<dyn DeliverToRead>,
     ) -> Result<(), (BinderError, DLArc<dyn DeliverToRead>)> {
         let sync = work.should_sync_wakeup();
 
         // Try to find a ready thread to which to push the work.
-        if let Some(thread) = self.ready_threads.pop_front() {
+        while let Some(thread) = self.ready_threads.pop_front() {
             // Push to thread while holding state lock. This prevents the thread from giving up
             // (for example, because of a signal) when we're about to deliver work.
             match thread.push_work_inner(work, sync) {
-                PushWorkRes::Ok => Ok(()),
+                PushWorkRes::Ok => return Ok(()),
                 PushWorkRes::OkNotifyPoll => {
                     proc.notify_poll(sync);
-                    Ok(())
+                    return Ok(());
+                }
+                PushWorkRes::FailedDead(dead_work) => {
+                    work = dead_work;
                 }
-                PushWorkRes::FailedDead(work) => Err((BinderError::new_dead(), work)),
             }
-        } else if self.is_dead {
+        }
+
+        if self.is_dead {
             Err((BinderError::new_dead(), work))
         } else {
             // Didn't find a thread waiting for proc work; this can happen
-- 
2.56.1

