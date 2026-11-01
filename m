Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554452;
	b=jWbPCLsJ5UppDP9d7B67tDjusVywCiH2wMniHcF13WxZaIzmHJSapOi6gR8lkZKtRQQl
	 fcO1a7+yTyDBYdNZGbor+vilzp68pQ423+14BAKc40If1j9ECbTo57DKGt0NXFrZOL2+z
	 YHHMDXyrREJHj8Q6h/Ohbu30iAZ+8uzeMGB7h7PBHFM6F9x4wl9VL8zNz4hrJRPDgieOF
	 TOnsXYtXZSqgXjXAUYf5SrdIc2wsBXLK5w1PphwdQEBwkaHQqdZVbT8iL2GvfORFJt5V2
	 rL1cGnbCkSPXcr8AJ9PBAVMKPoff89OofXsZeVwpKjm+8r6ppLeN1aqWn5AeOBRZYdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lmd+Bfr1rJqL0FKWrja5+jS/JqBB9NNsNwZHwDcZMno=;
	b=XiV3mEQhJEXpExNt387v3Atj4sq7BlLee+ZYNFNtP6eQ9+kNIPbuZCQIodmFAjToWv+8
	 eYKrJOSkM8bVhBvZeTzid7goFPUIi/pPlCVoqA/mPxUHK9Jx+lQi3BBYne7UqfYEiXqTo
	 1ifoYKuVjwhH0konw2sHKKPcGBQLbb/EaBAX2qCQrw3RqWDZUBYX2LwyTATR3O8akadpr
	 7Ufs/UAArPZQXti5Y4+q33AkxYxIVpY7PF/xQ1q/2PoWdDJv6xLWyozxQI47XshwOyc97
	 VEoVGymAljEWaMquuBgAeUjiIElwnBhxIneL/9Oz67pkVciiRxnpp4y3zEn0oT2BCDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nS9UAmCC;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B020606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 17:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B020606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nS9UAmCC
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2946995eec.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793554451; x=1794159251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lmd+Bfr1rJqL0FKWrja5+jS/JqBB9NNsNwZHwDcZMno=;
        b=nS9UAmCCPVKaXggZ7I/eFnSDV78227cyoHTcGnzTnCsW49gl+F1w0szeVMJoJopXiv
         +dZc3YbJlxYLUg6U+MTvrhLd+w4O0zgBpbd3ni1PsDNqIEmaofrBDwjOTYT3Tibxjoc6
         yq9OKf0YolegBlevwfe8TGmqQvZLH60f3CQTC//hz+NRqonCWyx68Sd8uXdzBRL6dGi+
         ofT05lwjU/PhAnihNR7jfdwl30dtb4ab1gfcp8nlDnkMeA8o5qJpjAfaml6LUs44lkP3
         XN8CIWxDr1Uxa6vyYkfDgBSm9ELQQ45C6vE5rUNlGNRiIz2bAvbYGuxw0zjMqATtIFlT
         WkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793554451; x=1794159251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lmd+Bfr1rJqL0FKWrja5+jS/JqBB9NNsNwZHwDcZMno=;
        b=B2mlg/fK0mWroU5tg++izswp6pPw7JCfB+kD/qZjmWU04ToEIrd/ZpTB3hZIemwFUd
         QcVGJ/lro21BBWYnmebja6WnBfT61S+ei6UTgGSXelOO9de63/UyWjjY9mb5svpa/EZf
         TrKTj1YjHfoxpMIEeb/jv0nU9bOLWQDpDD7gW/eExE+bcKMgGnlDA9a+65WxBIZRe2WE
         KJTtT/pmfj22nPiyPUpOtHzLLGBHsy6O2/rXBM9RottnFN6eJrV2AfzILgwdOvG8mZTk
         d8F9TH8txt9xCsWfODkuW5t9+Te4o54266fjmvfW16cqz0oT77yO4xaBSzgjdIDx5NWV
         lTQw==
X-Forwarded-Encrypted: i=1; AKwUvByivgdAzRNg5KorgLwKQY6ysNpzgPjvDWinKhMbfS5Ob+UTR2IufgwZ5gsLAu5yPVPVXSd77qk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q1tVS2v6SbC/jDi/QHuYFRrxxcnv2gdXtF8uZtf3uxai3nQdO
	jA6MEFpXx57cmyioYrAV26K2EtjPZUgtZZe2dxB8BLIoBpawNmBKJ7LF
X-Gm-Gg: AYBFou0M8tf/AVRFIrX4lF8zBLUiNbi1HEoaMYJ/8jrR+JK0fkVXXVwQ8fAHK1HJD6p
	VAtGkJUEt7Qshw36za/GE4YoXwbxznMfU7BcF6NYwoPKaOJ6LBM6BCkjBnzJRm365YQ2+muu7/L
	ZETOXhLA7+XrKiTwCjm7V29WxF/046BJloCZnDdgQR4Dyr+8UJINLSK2nZbJxJcjz/BljB1Q3X0
	oBfVXLi6OHHn3tNtc5vuLfxABHQYPWelsxfY6uvn8h/79eRbuQK+m0C2YECySOzbBVSlbk17lkV
	BMIGl+KddwwzwlpzvOz5mx7ds/dC8iuEgLh8k/C/lE1wat8hk9dy+7mpRg2k8bgHcI71aSoSsur
	/684UoYahSwUK3Hk5pcGICwygzpe4n81JG4kjGOdBO0iGJZTCNoyZ3jAsZ76SJhRFQRnTD6xuI2
	2f9B0W7jNI2jil7kGc4MKPD1+84NVrjkfYXUaeZr6CuB2fVy+MO9Xm2mzOPFrMCE864HukxQvXR
	AYUBHsLBMyxhP9b+dlyIu09hbfbc91cHmlRRlC9eY3jVl49lTOc8dhdwKu42H/k7BHpS5h6FVAN
	iyNF/Br5P2yR7VJqz8TBQhCVBDgKCSjxpzFmxjdK6PCsxE4Yeb5V+GMlcrxKPuHFtw==
X-Received: by 2002:a05:7301:6194:10b0:369:f937:9a7a with SMTP id 5a478bee46e88-36a42437876mr12357251eec.34.1793554450978;
        Sun, 01 Nov 2026 09:34:10 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:50b9:9b10:1e19:1f0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm25450066eec.5.2026.11.01.09.34.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 09:34:10 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: john.garry@linux.dev,
	nilay@linux.ibm.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nvme: Do not drop the cdev reference twice when cdev_device_add() fails
Date: Mon,  2 Nov 2026 01:34:00 +0800
Message-ID: <20261101173400.98931-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Since commit 9952f3882ecb ("nvme: fix cdev lifetime"),
nvme_add_ns_cdev() and nvme_add_ns_head_cdev() take a reference to the
namespace (or namespace head) before calling nvme_cdev_add(), to be
dropped by the char device's release, nvme_cdev_rel(), and drop it
themselves when nvme_cdev_add() fails.  But when cdev_device_add()
fails, nvme_cdev_add() has already put the device, and nvme_cdev_rel()
has already dropped that reference: the caller drops it a second time.

The namespace (or head) is then freed while it is still in use.  With
one allocation failure injected into cdev_device_add() for a namespace
on an NVMe over loop controller, deleting the controller gives, with
native multipath:

  BUG: KASAN: slab-use-after-free in nvme_put_ns_head+0x21/0x140
  Write of size 4 at addr ff1100000a4ea078 by task init/1
   nvme_put_ns_head
   nvme_put_ns
   nvme_remove_namespaces
   nvme_do_delete_ctrl
   nvme_delete_ctrl_sync
   nvme_sysfs_delete
  Freed by task 1:
   kfree
   nvme_ns_remove
   nvme_remove_namespaces
  refcount_t: underflow; use-after-free.

and without it, a use-after-free of the namespace in
nvme_mpath_clear_ctrl_paths(), the namespace having been freed by the
last close of its block device, followed by a general protection fault.

Take the reference in nvme_cdev_add() instead, right before
cdev_device_add(), so that it is held exactly while the device can be
released, and let the callers neither take nor drop it.  The earlier
failures in nvme_cdev_add(), ida_alloc() and dev_set_name(), return
before the device is initialized and so before the reference is taken.

The problem was found with kbound, a static analysis prototype that
checks whether callers rely on an object after a callee returns a value
for which the callee may have released it, on v7.2.12; it is present
in mainline.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings.  Run-tested on QEMU (x86_64, KVM) with KASAN: a loop target
exporting a null_blk device, connected through /dev/nvme-fabrics, with
failslab failing each allocation under nvme_cdev_add() in turn, with
nvme_core.multipath=N and Y.  Before this patch, every failure in
cdev_device_add() (7 of 7 with each setting) gives the reports above;
with it nothing is reported, also with lockdep and kmemleak, which
finds no leak either.  A failure in dev_set_name() gives no report,
before and after.

Fixes: 9952f3882ecb ("nvme: fix cdev lifetime")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described above.
    
    The runs were on next-20261030; the code this patch touches is the same
    there and in mainline, which it is based on.

 drivers/nvme/host/core.c      | 13 +++++++++++--
 drivers/nvme/host/multipath.c |  2 --
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af71d02b8476..f9d23e9d35ec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3978,6 +3978,17 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 	device_initialize(cdev_device);
 	cdev_init(cdev, fops);
 	cdev->owner = owner;
+	/*
+	 * Held for the lifetime of the cdev and dropped in nvme_cdev_rel(),
+	 * which also runs when cdev_device_add() fails.
+	 */
+	if (cdev_device->parent->class == &nvme_class)
+		nvme_get_ns(container_of(cdev_device, struct nvme_ns,
+					 cdev_device));
+	else
+		nvme_get_ns_head(container_of(cdev_device,
+					      struct nvme_ns_head,
+					      cdev_device));
 	ret = cdev_device_add(cdev, cdev_device);
 	if (ret)
 		put_device(cdev_device);
@@ -4010,13 +4021,11 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
 {
 	ns->cdev_device.parent = ns->ctrl->device;
 
-	nvme_get_ns(ns); /* Undone in nvme_cdev_rel() */
 	if (nvme_cdev_add(&ns->cdev, &ns->cdev_device,
 			&nvme_ns_chr_fops, ns->ctrl->ops->module,
 			ns->ctrl->instance, ns->head->instance)) {
 		dev_err(ns->ctrl->device, "Unable to create the ng%dn%d device\n",
 			ns->ctrl->instance, ns->head->instance);
-		nvme_put_ns(ns);
 		return;
 	}
 	set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9e0a0fd77c56..ae8059366b57 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -681,14 +681,12 @@ static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 {
 	head->cdev_device.parent = &head->subsys->dev;
 
-	nvme_get_ns_head(head); /* Undone in nvme_cdev_rel() */
 	if (nvme_cdev_add(&head->cdev, &head->cdev_device,
 			&nvme_ns_head_chr_fops, THIS_MODULE,
 			head->subsys->instance, head->instance)) {
 		dev_err(disk_to_dev(head->disk),
 			"Unable to create the ng%dn%d device\n",
 			head->subsys->instance, head->instance);
-		nvme_put_ns_head(head);
 		return;
 	}
 	set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.53.0

