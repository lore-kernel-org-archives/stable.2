Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42CB34F474
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618619; cv=none; b=nGSyq3nXBfb2P8FcTk2CfyoqpST491Zk2LztsYiEdjAF4zgHGgCJ9vbOEOy4ojXQA+os5dFAKnCd4dQrunYUVMGUIbdMS9i8+dph367gkwoYdjNKfBe6+ta+pdtcuaFjrofWiEP3hid+CBpaKW2wirgVF9J+m31Rqu+6oaKaqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618619; c=relaxed/simple;
	bh=96Q8yKNN8XGpkAjZlgZOHeyyUhznQ7ap2d56v8/Z5xE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NWSAp4kizW+wObBoRZPcTkZZrJZFcPgsjl9eQcRtirFsG93mxa9G8D7CDMsXQ8IYeVbHbP6vmTkj1m9eupVrtLsrUrXgc90uw2ws4DV7a7OkhRbBSV6GQmeLiF2pyS36tg9+yql0vFyW6R7Udf3CHB1MTaekfXIbbBf+PyaThG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aZ6R/MYN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aZ6R/MYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74F81F000E9;
	Thu,  9 Jul 2026 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783618617;
	bh=2wWzsSYdr1oJw/D8bbw3o+wa/q6AGzUj/rjW0dR9cmY=;
	h=Subject:To:Cc:From:Date;
	b=aZ6R/MYNYhTvTgCoGSp1tqKnv/TEytSGFxufw57Pb5bGQ7nYfo8Mq6n/G7Kw1VtvB
	 jx5dc8kb4B2264VCnJVo4/qeodZcuO2eVYDpWk9A0KEDxIIxqhTGe5Jj+tWkD0N+vC
	 OAPDtcj12x3NuvmfgH4Hnb5zG1tlXwFb5K1B4wOI=
Subject: FAILED: patch "[PATCH] rust: block: fix GenDisk cleanup paths" failed to apply to 6.12-stable tree
To: royenheart@gmail.com,a.hindborg@kernel.org,axboe@kernel.dk,bird@lzu.edu.cn,n05ec@lzu.edu.cn,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 19:36:53 +0200
Message-ID: <2026070953-laurel-zeppelin-239b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2957771379fa335103a4b539db57bb2271e12142
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070953-laurel-zeppelin-239b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2957771379fa335103a4b539db57bb2271e12142 Mon Sep 17 00:00:00 2001
From: Haoze Xie <royenheart@gmail.com>
Date: Sat, 30 May 2026 14:11:54 +0800
Subject: [PATCH] rust: block: fix GenDisk cleanup paths

GenDiskBuilder::build() still has fallible work after
__blk_mq_alloc_disk(), but its error path only recovers the
foreign queue data. That leaks the temporary gendisk and
request_queue until later teardown. If the caller moved the last
Arc<TagSet<T>> into build(), the leaked queue can retain blk-mq
state after the tag set is dropped.

Fix the pre-registration failure path by dropping the temporary
gendisk reference with put_disk() before recovering queue_data,
so disk_release() can tear down the owned queue.

Also pair GenDisk::drop() with put_disk() after del_gendisk().
Once a Rust GenDisk has been added with device_add_disk(),
del_gendisk() only unregisters it; the final gendisk reference
still has to be dropped to complete the release path.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/b70aff9a920cc42110fe5cf454c3099561863519.1780063368.git.royenheart@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..fc97dd873974 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -150,6 +150,19 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
+        let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
+            // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
+            // has not been added to the VFS on this cleanup path.
+            unsafe { bindings::put_disk(gendisk) };
+            // SAFETY: `data` came from `into_foreign()` above and has not been
+            // converted back on this cleanup path.
+            drop(unsafe { T::QueueData::from_foreign(data) });
+        });
+
+        // The failure guard now owns both pieces of cleanup; the early guard
+        // must not run on this path anymore.
+        recover_data.dismiss();
+
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
@@ -172,7 +185,7 @@ pub fn build<T: Operations>(
             },
         )?;
 
-        recover_data.dismiss();
+        cleanup_failure.dismiss();
 
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
@@ -215,6 +228,11 @@ fn drop(&mut self) {
         // to the VFS.
         unsafe { bindings::del_gendisk(self.gendisk) };
 
+        // SAFETY: By type invariant, `self.gendisk` was added to the VFS, so
+        // `put_disk()` must follow `del_gendisk()` to drop the final gendisk
+        // reference and trigger the remaining release path.
+        unsafe { bindings::put_disk(self.gendisk) };
+
         // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
         // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
         // `ForeignOwnable::from_foreign` is only called here.

