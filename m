Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396641;
	b=vV42XVrVY6IKI9jCYcRsOdx31wIJHXDI0NtWiXM+klNrmkTClp1gty4VUJKXGT0fnHLg
	 IUza7Z2JzVRKmrJm16dsW3hwJqvqt8Xt94xuDQZzCSeN3126IxiVNno6TUqbznQUUiR/O
	 aCtLVAk/vOrA49KCOwBeSTHBD/+2+k4f5BH/WBofX+dtg8b+oP89T1pmMQn9RX57mY+Sa
	 dOhzk/bm92sz0UhOXSyzcjet+hWCMZi2XqOashbiv0ofPHafBx56/UB7bkSa//9Z1nfUj
	 Cr0b1sbhd+YqXv2LReEuoYCkUxVzSakGywMbdlr4sW1ENIJYJ5pKhCm6dH/cnmBxq1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BR3C7X5L79A8iSQFZKFRMc0cQ3J+KtB6+sTRGC/NFlE=;
	b=t3oybYs4seNj2AAMRZug3GE5c5Adw/Q+D1ls9zxFKfVfp4acov+qHFUF3m7nNxankaD9
	 9xRQIcB6Cto/otGkWT3ui2ILdHvR4x8Kt6XSeleEbuv7P4u5NVsTROTaGndW22Aprw4Y5
	 4uXWmmMpUQQP9/eurFxIc/bhWWhaERpvJFCPrtb5xvfV3ONiKYzPD6kDntn/9/ClL4d98
	 VdXJ8tgKQDogNMUt3iK5gbDjOGcJcUEQjSXRl2ojRH1tWc4EpqCDv/YqNdHTtaXyjGp+w
	 YGi0XTO8X9Mk9adKFpXJAK0bOOJFeZdAN+Q62J02NOXkL5QJEEyIWyvFHlpH5zLemIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=ZkHo62if;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4FB606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC4FB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=ZkHo62if
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49134c8509fso2525567f8f.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794396639; x=1795001439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BR3C7X5L79A8iSQFZKFRMc0cQ3J+KtB6+sTRGC/NFlE=;
        b=ZkHo62ifmcuJUtylp4XDkQj48Cq1eIVrNjJUmhzuVRZI4EFKmh6+AdJD4N8fLb4I+q
         QA3oNat9Tf0IX75M0A2qeE3AR8lDGbA+EQ0RTcnfnSJDIJ70j1nQkn7EDfB9LwG+M7hO
         vZQKHWCD+phtyXlyEjrxGdJ/SK3TOrBf+WeKNN+3FwqReLFqU9Ge3AIUFS/rc3nUb7gj
         R0RAwO5jQBasn+CyCpgzeZzF0M5xtUiPtH7QBH+n4qeJhpEkZKtWsEfUPVW5df9JZv13
         vESRig50GhfUGkjaB4Wqh73fFh9wiMsc6wpBP4P+4lw7FbAKVjOKMKcaJir9KBwh9KtD
         jjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396639; x=1795001439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BR3C7X5L79A8iSQFZKFRMc0cQ3J+KtB6+sTRGC/NFlE=;
        b=ekK2d8tfXNWRArYIfXYPdA4ytUB6raQ0PN5x7BlEWr9I2EXUwjv9pT6gXH8vQxMaPd
         VDoofKQAFdyTxRPcO+Z0WyUJHQTQ0sLVIh3LNTXM1b0Ih47TDV1i4vlSV8qSLfHqmom5
         4kexbX/uLOSPraogF2ePLgXAMWK86UOvmrQ8D3A6WbHn5ZqbEarPZsux7X9RIN5JtPn4
         0sXhWiOrOUaVjLPyLgvTttOCPU0US+6w548VcuuEonYmMOVou5RA8hUFr46xgQcMzKV4
         1JB1eNsieGmKX3lZ2kq7aPR5+pRJzr/uWSouV/VhuqHWMFRAGC78qo9vktDN1MJfpsI0
         Ki2Q==
X-Forwarded-Encrypted: i=1; AL+hErHQk1b/ghIqAAj4HGZyqlIDx5gaOlR/Ie6iawlHkooDlLktD5rK+Sx1ugGmJHOvETSFZgmBTAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UbSVFAGDpVBIua0lqxLzscHl7xuVVcZ8a681H50/YKx2UrTiV
	r49oEaCLmytIewJ4Y9hj40cMD8t2ww/cWwJ7LZXFF5iRmjCuotoHF0oX4AGSOwnz0x0=
X-Gm-Gg: AYBFou3HWn/JqI5lSYXOuCIhzfSVUBkDXnJC8EjFhl9AbFIqJu4wrypf+lZpjkGD8M3
	dv7JHb7KKiVK9EmkUC7dt4y82dmdYUz4M/jguN4SeMzCGQi3we0SE3WUbrEYVAQPVDSCqEgP6ND
	8GDTgYD/BnNZTwKbf+OJgwRWc37YoJ6YdIRpDnfxMGtiCNmLOxOqnoN3Gk9mjG7k6OBSoKckAAe
	gp+7LWGzavHonAp+lp1CuzPi9eDz5zBDEE2bW87q+WhbzuR0RCVUeJTSWMTBtE5fe2YQVmTq3GN
	BDrd0qFbIBrUSd0KuZxl9FVgTuYRKNdCZj3QoezBWdzw4vxrc+8G9yqm+kG0YloovpM5soRRlX8
	z+cwfaad+U3e3RUG7VokQAavXWm77+XweBuXwndfsZKi98YypcZ3wbecLKbxracuKz6DGIMfr2g
	yDvQQsbTKSn98yQid3hrdHL/WjW/+JYAAFpQBOzlPwRVaiChCl699P+XAdGngWLvEEjx3NRIR7y
	fYZk2cpj+6kVbbmCi/Z5AlZXIABNbvedlTpuRJ3Z48Jmvn51pCWaqOBEzZGDxPhXy/5RyEMRyd6
	IblpAnXHv9gwSKZpl968bK+v5fWaqSfOG/R1NYBvFbgeHzzl2S+myzcYxrwgNg/EEGoqf3uB+8X
	g9KaskO4r81MUzl+tM2vzlFRQBH65ch8=
X-Received: by 2002:a05:6000:4008:b0:48e:fdd:41d9 with SMTP id ffacd0b85a97d-499c6e979camr3766412f8f.31.1794396638819;
        Wed, 11 Nov 2026 03:30:38 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498357648f0sm10959991f8f.12.2026.11.11.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:30:38 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix d_lock leak in debugfs mdsc_show()
Date: Wed, 11 Nov 2026 12:30:29 +0100
Message-ID: <20261111113029.959595-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
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

mdsc_show() walks the request tree under `mdsc->mutex` and prints the
request's dentries like this:

  spin_lock(&req->r_old_dentry->d_lock);
  seq_printf(...);
  spin_unlock(&req->r_old_dentry->d_lock);

(same for `r_dentry`).  The pointer is loaded again for the
unlock, but ceph_fill_trace() can change it in the meantime:
ceph_fill_trace() runs with req->r_fill_mutex held, but not
mdsc->mutex, and:

- after d_move() for a rename, it swaps `r_dentry` and `r_old_dentry`
- splice_dentry() replaces `r_dentry` with the spliced alias and drops
  the request's reference to the old dentry
- a lookup without a locked parent assigns a new `r_dentry`

If an unsafe rename reply is being processed while mdsc_show() is
between spin_lock() and spin_unlock(), mdsc_show() unlocks the other
dentry, and the `d_lock` of the one it locked is never released.  The
next attempt to lock it spins forever.  I have seen this on a
production server, where our monitoring reads the debugfs "mdsc" file
periodically:

 watchdog: BUG: soft lockup - CPU#67 stuck for 48s! [kworker/67:2:3746175]
 Workqueue: ceph-msgr ceph_con_workfn
 RIP: 0010:queued_spin_lock_slowpath+0x4a/0x240
 Call Trace:
  <TASK>
  ceph_fill_trace+0x7a4/0x910
  mds_dispatch+0x9f4/0x1ac0
  ceph_con_process_message+0x66/0x80
  ceph_con_v1_try_read+0x392/0x17e0
  ceph_con_workfn+0x329/0x590
  process_one_work+0x146/0x2b0
  worker_thread+0x182/0x2f0
  kthread+0xe4/0x1d0

 watchdog: BUG: soft lockup - CPU#55 stuck for 49s! [cm4all-kernel-e:16346]
 RIP: 0010:queued_spin_lock_slowpath+0x1a2/0x240
 Call Trace:
  <TASK>
  lockref_get+0x47/0x60
  ceph_mdsc_build_path.part.0+0x85/0x2a0
  mdsc_show+0x239/0x3e0
  seq_read_iter+0x11f/0x480
  seq_read+0xfd/0x130
  full_proxy_read+0x50/0x80
  vfs_read+0xa4/0x340

Both CPUs were waiting for the `d_lock` of the same dentry, which
nobody is locked but nobody will unlock it.  The first CPU was in
update_dentry_lease(), called after the rename swap.  The second one
was the next read of the debugfs file.  Since the ceph-msgr worker was
blocked, all requests to that MDS hung.

Replacing `r_dentry` with a spliced alias also means mdsc_show() can
call dget() on a dentry whose last reference has just been dropped.

Fix this by holding `r_fill_mutex` while mdsc_show() uses `r_dentry`
and `r_old_dentry`.  Taking r_fill_mutex with mdsc->mutex held is the
established lock order; __do_request(), handle_forward(),
ceph_mdsc_wait_request() and ceph_lock_wait_for_completion() do the
same.

Fixes: 76aa844d5b2f ("ceph: debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 6a9a5551d9d7..83506d9207fa 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -109,6 +109,14 @@ static int mdsc_show(struct seq_file *s, void *p)
 		else
 			seq_puts(s, "\t");
 
+		/*
+		 * ceph_fill_trace() may replace r_dentry (dropping the
+		 * request's reference to the old one) or swap r_dentry
+		 * and r_old_dentry; it does so while holding
+		 * r_fill_mutex, so hold it while using them.
+		 */
+		mutex_lock(&req->r_fill_mutex);
+
 		if (req->r_inode) {
 			seq_printf(s, " #%llx", ceph_ino(req->r_inode));
 		} else if (req->r_dentry) {
@@ -151,6 +159,8 @@ static int mdsc_show(struct seq_file *s, void *p)
 				seq_printf(s, " %s", req->r_path2);
 		}
 
+		mutex_unlock(&req->r_fill_mutex);
+
 		seq_puts(s, "\n");
 	}
 	mutex_unlock(&mdsc->mutex);
-- 
2.53.0

