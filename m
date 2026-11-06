Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980424;
	b=h2MvlIGDJ7tF/UpcHkTRK5TxkFfBl0zhnmbTRjmztJLgq8plY6ARo3w10PZZbUfWYnmd
	 AqcqnCr1KneQhK13hbGDsWKcidQ9yDeaW4FbQIlzBTaO2WpTn2K6jBQBR7EdDPOc4QWcB
	 vbAhFa8Oi0qigMpKangKVkjf6GhhdS8R+9Fi4YX6jT8nmvQX3ekvDcPwI1ioYjMre8xVe
	 moBVN6RWupJ7K5BFHSn6JqMx1VBoKGz15M3dKDoFkxL2WbU8O2B+J7ELMpTnuviYislJx
	 AymKKN3lJ4AM+fZLmuUud4ov42bQ+XNWXzfFmP+6tqZ6MRkCci1TdFr9eTz3EEo6ygA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980424;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=lospR7RBEPbknyhbJlG75vO9FqI6EbinXMw9WPvqCLU=;
	b=u86aG22z3+jHRcAQZm0iQlc5mupeahqf71eBihLIgBnjWQYqBlIqsP+Pu2OQVF/jIyh1
	 M1+2iV6B5NAIokjNkP7g4LsdgYr31cFxm1pkYmmzIoJTH+tFsL0hTIP9U7uQjfeq+3wiJ
	 Dl7Wik0aKYRqdOnAoiXUs0O+1sXrUQEDBt/SSlWMCMhHzO7a7YAYIb8guE1NIO3FW8K0k
	 9ova6tCPJiAigaGhcrB4ku5bwqaF/mM7xvyS0zhcOWYkcd4WHLfJTbdmVDIui+qw5OTIi
	 lKMUeq7oeokg1CH7jIgJ32bWFBADdi9obIRs+rceWmmgoTlJW/6S4+GrRjvSs7CQ0rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mcJk47gg;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A19606A32E;
	Fri,  6 Nov 2026 15:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A19606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mcJk47gg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=lospR7RBEPbknyhbJlG75vO9FqI6EbinXMw9WPvqCLU=;
	t=1793980423; x=2109340423; b=mcJk47gg49gTxR/LSwkPyZCTDGPDPGgEVXmLVHJCYz4MmXi
	SOULsOHSqzQB2QInHPBHaqpE+MhV7IkpUHqgIIlckN8QnE8sBvfocR8dt4/kdhzTB56Rk/8tMl6ie
	/Nrx3Ysd1PsHb3Zt1tw6Zn8E5wMXFe05LkAFJLxsRQvsBp3XMG67s7tZ3AViKLuNh2zXtlbrzGiBL
	d2Xg5ILnfbeFPRrfK44fAPZHbHnR2YmFIsNLkRSeizSy2i1QRZjCkWBuApLD9OTwDOvD608FLhiDR
	BGRinwBA+tElexNfIs41Ousz3J2RJ8akQsAbicUY7JI0uDPmjnBzoYJ6sl5B8maw==;
Received: from bl16-24-61.dsl.telepac.pt ([188.81.24.61] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xPMG2-004YbS-9Z; Fri, 06 Nov 2026 16:53:38 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: luis@igalia.com,
	mszeredi@redhat.com,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	stable@vger.kernel.org
Subject: [PATCH v2] fuse: fix 'inval_wq' parameter setting during module initialisation
Date: Fri,  6 Nov 2026 15:55:12 +0000
Message-ID: <20261106155512.24801-1-luis@igalia.com>
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

If the fuse module is loaded with a 'inval_wq' parameter the inval_wq_set()
function will schedule work into dentry_tree_work.  However this worked is
not initialised at this point because fuse_dentry_tree_init() will not have
been executed yet.

This can be fixed by delaying the work scheduling until later if the module
is still being initialised.

While there, also simplify the sched/cancel by using mod_delayed_work()
instead of schedule_delayed_work().  This will result in having the period
being changed immediately instead of waiting for the next reschedule.

Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate expired dentries")
Cc: stable@vger.kernel.org
Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi!

So, here's a different approach that tries to address sashiko comments:
instead of checking the module state and going through all sort of races,
simply define a new state variable and use it instead.  Simpler.  I hope.

 fs/fuse/dir.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index da23ccd8685c..32e052dac2f1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -35,6 +35,7 @@ struct dentry_bucket {
 #define FUSE_HASH_SIZE	(1 << FUSE_HASH_BITS)
 static struct dentry_bucket dentry_hash[FUSE_HASH_SIZE];
 static struct delayed_work dentry_tree_work;
+static bool dentry_tree_is_initialised __read_mostly;
 
 /* Minimum invalidation work queue frequency */
 #define FUSE_DENTRY_INVAL_FREQ_MIN 5
@@ -43,7 +44,6 @@ unsigned __read_mostly inval_wq;
 static int inval_wq_set(const char *val, const struct kernel_param *kp)
 {
 	unsigned int num;
-	unsigned int old = inval_wq;
 	int ret;
 
 	if (!val)
@@ -62,11 +62,13 @@ static int inval_wq_set(const char *val, const struct kernel_param *kp)
 
 	*((unsigned int *)kp->arg) = num;
 
-	if (num && !old)
-		schedule_delayed_work(&dentry_tree_work,
-				      secs_to_jiffies(num));
-	else if (!num && old)
-		cancel_delayed_work_sync(&dentry_tree_work);
+	if (READ_ONCE(dentry_tree_is_initialised)) {
+		if (num)
+			mod_delayed_work(system_percpu_wq, &dentry_tree_work,
+					 secs_to_jiffies(num));
+		else
+			cancel_delayed_work_sync(&dentry_tree_work);
+	}
 
 	return 0;
 }
@@ -217,6 +219,7 @@ void fuse_epoch_work(struct work_struct *work)
 
 void fuse_dentry_tree_init(void)
 {
+	unsigned int delay;
 	int i;
 
 	for (i = 0; i < FUSE_HASH_SIZE; i++) {
@@ -224,6 +227,14 @@ void fuse_dentry_tree_init(void)
 		dentry_hash[i].tree = RB_ROOT;
 	}
 	INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
+
+	/* Start workqueue immediately if 'inval_wq' is already set */
+	delay = inval_wq;
+	if (delay)
+		schedule_delayed_work(&dentry_tree_work,
+				      secs_to_jiffies(delay));
+
+	WRITE_ONCE(dentry_tree_is_initialised, true);
 }
 
 void fuse_dentry_tree_cleanup(void)
