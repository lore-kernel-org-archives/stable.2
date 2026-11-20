Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186816;
	b=qCc97kK1oltv13dn5N/2yqVuL891PGwQCIRyiP1NO+vTN4vvTR4RWztcoR2ytoGUqi2P
	 Cz993D23ElWKlZ541MYNKpioyKwFU7gcKwTkRMI9nEy2bHe8Ekx6hvyarfPB4hy5h/8oJ
	 UYyR1KEq/b3OVbYVV8IKAGyLTaKSn2X9gT8tXhoQ14RyrW/aAXa1wrHqLpUmqxGLc+tp8
	 zj2x90/0HMfmEMgNWO7Y13CjoXGZ/LtoR8RTrhoANx/L12mWMzvcbhYXqeZxwP4GtgKFG
	 EIZCg6rlcapjx5O8x/O2sRmyyCmW1iEpbbmcdqD+pHfoHn6DiiinTBag309NiYxwpKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NBH8Vk7x49WT+m8mgSOTracB/qDaBoM1+u+x062nujE=;
	b=WfpFK9sKaJl4nZhP2ojUk5vGYIvVsG1P+wP6wotm5L3GePYX1oOKrAM+6IsclcczFV+M
	 AUAeQC9z2EvwnLOEswqKKynfLC3BOVmr2q63oDZaOqmTBk8jjO+6qeIYv5tSWhxEwRdOR
	 Rg9sj4BMa7BQdc+gpxfzyC0zwXQYeXiJRfrASSL5sjjdaVWd6TPiwiZQqUzpBkYz+C2AO
	 9YsHMjhqAIqimeVZzT0V6PNepGEpNA8WdO4ju3RSiuYe7rbbt+9GAiK+cT/2n9wJGFIiK
	 +n2lfkhUhge6cwuu3oyfQfpHA2wt3DfP/V9EWeVzMZKR126lJQc1PuzLTsv3RnH+n6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OR6bZKRR;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B460A3810
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27B460A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OR6bZKRR
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2eff92780daso7181125ad.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795186815; x=1795791615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBH8Vk7x49WT+m8mgSOTracB/qDaBoM1+u+x062nujE=;
        b=OR6bZKRR6EkH90jRglR5Eedr3LK5EDTCpbXlvGoU1ycPAocvhZOBwtm239PcSVTXq9
         FeSZs6MvlcZAfV4WyMEZLjFAkx/02cNJhxxmZQfZk4dZVBnykGtzjtVF66DDmPmUR2eM
         CPHqRjGeVySPa4CqpWJ0XSPYq6PpP2rw6JJgsYMgaPltmZ6JH/lUC0kGaP3BfILooeAG
         i34YEkzP0oprcv3lWvJs0TP3fKJ/5D69fBvY4V6DGlwStVIGPX+MkAA7dO9HOeDwT3mA
         CVnQyOwBvQQ3QXRJTz2P4XFzTYb7rU/BSRW7ez2vKpktX8hO7ysP4rI/9g8szfypqYsj
         k4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186815; x=1795791615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBH8Vk7x49WT+m8mgSOTracB/qDaBoM1+u+x062nujE=;
        b=ablKMOnunrz1PDqah90jqyaU6DTfkqj2U3kCB3CLd5dqSv+kxwiMcE6TGCMZaWHgPb
         kqH0tl6HzI9Ph2ocKTJmjtUuLA3Y3ZpPiSMVpBeKfdk0DzYPcxYAY2rGWVDarstREaRK
         kY9RGuGlP10ogv0Epl5ia7rJPUdMDI5C8iHpUli+KUs2qTouejc7wnEzhbHigdwdD15w
         uRg1UgmmtuBhSB4RPMvkGw5uM6rxrS+Ph5sPV1j7qJimXZIuLwmG5Wjma9BP3BRBI3aC
         ERyWi7Ipl7+dY9Aw+KE/238lah2MSHfui0rYNPM63yKRkH9anP+En0nXDE5/gOExSZJq
         lDJQ==
X-Forwarded-Encrypted: i=1; AL+hErEhrUyqbZLzeoJFJfV87j/QZcOZCS7OlWU2ieoLHSRpDcjYsYuK5vBPW3LmeIWwIV6VDGHmXSY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uITDFthDkzeyRGsScRYaavFsdA/szjGOR+6aQm8WFTibTSlqt
	9L45es6XLlNwUiGw+dg/cqwCxSFXZq2LUTeUhtv8+mxVgNJVRRfZSuX6Ad530g==
X-Gm-Gg: AZFdTZcU1CC5Phw9kXPpu1fhoEQ07wg+V/1eqXRYi3RTakNThztBt8+jApG8U/Lck9z
	txLNiy7kZ5Tfy11VOGGB1ad94wbld7JOUi8aA/fjoXIi5B21yDRUVp7WPP5oEchUkOFsrQCPZYw
	+jkqtl/ByyrjMgdqjrqI4r3LeqmzsfPB3k5v9/z51MaK+B2zEoDx6OC0e2zrQRUq50rtDx21F5k
	89dq9Hk4D9OyULiCChubJTgroOKJJN2vjuc4p2c4dZuNVLLx/gzZfensvnLdRUzxX2tyiGfLXDv
	iIKxovNqd9cXg0Q8W8QytvEC0ooukhkvtg80PY8a39C6aw9ITM9oavHghdle/Z9bCmxURTNBK5J
	02PlL7ilnWmgETrKFqpYcJMvWBvwVrlaJa6SVDE6Qf+OwTr/J+M/VjPmCu+/uNdimaojAqFOc2K
	QDTtxJ/R7WathyhqF8oEp+a/PhKzR0Z/pMRqx9PFudTbiYvNv1O9LA9zFRQNvGv9cR4RdnsCkL5
	yfHbRqwDkpziZgc2K+KEiFY7Znynze37XlH3WrZvjvj5UhNoNSCwwJAoWtuUPJ2JGLua3TVKzLY
	mTNThNYw96CENH+zQvV2dJEmDiFyiq5lbybuMZ8/X+OYMaOdPWHg
X-Received: by 2002:a17:902:ea01:b0:2ed:1b26:2bf5 with SMTP id d9443c01a7336-2f03f21e92cmr31475695ad.44.1795186815085;
        Fri, 20 Nov 2026 07:00:15 -0800 (PST)
Received: from ubuntu ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120282sm15213005ad.59.2026.11.20.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:00:14 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] fuse: defer dentry_tree_work until fuse_dentry_tree_init()
Date: Sat, 21 Nov 2026 00:00:05 +0900
Message-ID: <20261120150008.1144420-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120150008.1144420-1-ekffu200098@gmail.com>
References: <20261120150008.1144420-1-ekffu200098@gmail.com>
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

inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.

But inval_wq_set() can be called at boot or module load before
fuse_dentry_tree_init() initializes the work, so __queue_delayed_work()
warns and the work never starts.

So defer scheduling the work until fuse_dentry_tree_init() sets it up.
Also hold kernel_param_lock() in fuse_dentry_tree_init(), because a
sysfs write can call inval_wq_set() at the same time.

Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate expired dentries")
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 fs/fuse/dir.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index da23ccd8685c..0d5d04df477b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -39,6 +39,7 @@ static struct delayed_work dentry_tree_work;
 /* Minimum invalidation work queue frequency */
 #define FUSE_DENTRY_INVAL_FREQ_MIN 5
 
+static bool inval_wq_ready;
 unsigned __read_mostly inval_wq;
 static int inval_wq_set(const char *val, const struct kernel_param *kp)
 {
@@ -62,6 +63,10 @@ static int inval_wq_set(const char *val, const struct kernel_param *kp)
 
 	*((unsigned int *)kp->arg) = num;
 
+	/* Defer the work until fuse_dentry_tree_init() sets it up. */
+	if (!inval_wq_ready)
+		return 0;
+
 	if (num && !old)
 		schedule_delayed_work(&dentry_tree_work,
 				      secs_to_jiffies(num));
@@ -224,6 +229,14 @@ void fuse_dentry_tree_init(void)
 		dentry_hash[i].tree = RB_ROOT;
 	}
 	INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
+
+	kernel_param_lock(THIS_MODULE);
+	inval_wq_ready = true;
+
+	if (inval_wq)
+		schedule_delayed_work(&dentry_tree_work,
+				      secs_to_jiffies(inval_wq));
+	kernel_param_unlock(THIS_MODULE);
 }
 
 void fuse_dentry_tree_cleanup(void)
-- 
2.53.0

