Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22873B8D76;
	Fri,  7 Aug 2026 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087211; cv=none; b=nYlfLxMPxjV2ANrKhpZ6AUBIeElg4IMQlrOZb/fdoIZPSw3u+1DE31thPddpqLUcKg+EEn66SXoEPsKWAFHU2kk0JDnGypStn2uuAbmrKXJQX8VDV4VoXM6EU6srzHlsYY7JugDqVUyzuC2Tz7FP8bpdskv+pAWReVrfxjpsNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087211; c=relaxed/simple;
	bh=09FxRqYvAJ+jCowdoPG6nKLl0vJVRvMT3zYvdMBxi70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKsyP+wT8mDlN+XyBWzXbyt27Qn34gncpA46QAWHVo7IkV1efL2UoW3uZBh5cuMfDViobCEkkalE+yPtfV+ID+Ty2ldkF/lq+fFhrqE3jHWjnytNOg74vcsiVfntCzxNRElX1wgq0RJsSbDBGX0gJHUaTo23158Q+U1HCCH3JBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AVBKHKkX; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AVBKHKkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4k
	4eYf9bOPqnAHVpQmp8wdukJyoXQOWZpKAZndTwb5Q=; b=AVBKHKkXtcruXVqvLY
	ySP4TgDZZv1v9G6o47UerlbIFDdM+UUCYTDgo+uQEImEqPE0kZumpaJiz0e72AlJ
	V9OpNDcpOTX+p1lmsDs3fH2PtfqPJ3YCNrPJOtcCkt0Ejpz6/rL6b8guPyTqoK9F
	GKxI0K+zDDRuj6Hf+qFS4lh0A=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBncb0Ih3VqqOGZOQ--.50948S2;
	Fri, 07 Aug 2026 15:19:37 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn,
	stable@vger.kernel.org
Subject: [PATCH] KVM: Remove the kvm debugfs directory if kvm_init() fails
Date: Fri,  7 Aug 2026 15:19:34 +0800
Message-Id: <20260807071934.786879-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBncb0Ih3VqqOGZOQ--.50948S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1ktFW3Jw1rAr18Cr4xCrg_yoW8Ww48pa
	n8Grs5KrZYyr42ya4vkFn5ur18GrZ7Ga1fX3W8Zr15JryDKrsYvry0qrWY9FWDWF4kt3WY
	vFy0qFyUAw1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnZ23UUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwAnbl2p1hwlMMQAA3p

From: zengchi <zengchi@kylinos.cn>

kvm_init_debug() creates the "kvm" debugfs directory along with all of
the VM/vCPU stat files, but none of kvm_init()'s error paths removes it.
If kvm_vfio_ops_init(), kvm_gmem_init(), kvm_init_virtualization() or
misc_register() fails, the directory is leaked, and none of kvm_init()'s
callers invokes kvm_exit() on failure, i.e. nothing papers over the
leak.

The stale /sys/kernel/debug/kvm directory isn't just cosmetic: a
subsequent attempt to load KVM makes debugfs_create_dir() fail with
-EEXIST, after which kvm_debugfs_dir holds an ERR_PTR and all stat
files are silently never created again.  Worse, the leaked stat files
reference file_operations and stat data that live in the KVM module; if
the module is unloaded after the failed initialization, reading the
stale files is a use-after-free.

Remove the debugfs directory in the error path, mirroring kvm_exit().

Fixes: 2b0128127373 ("KVM: Register /dev/kvm as the _very_ last thing during initialization")
Cc: stable@vger.kernel.org
Signed-off-by: zengchi <zengchi@kylinos.cn>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..8a503ac1adbd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6553,6 +6553,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_gmem:
 	kvm_vfio_ops_exit();
 err_vfio:
+	debugfs_remove_recursive(kvm_debugfs_dir);
 	kvm_async_pf_deinit();
 err_async_pf:
 	kvm_irqfd_exit();
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

