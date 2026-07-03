Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3643C3C11
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078032; cv=none; b=IkE0VJAXLnlCHxRElzQpKLxupKUI5sKsXqq7W+5nE7uJL7pxRaQSxOTYkFcJbMaazGvo3GSXM+vx8j+NHXHghS79xga6JqvYIJ8uSra1MYZikAEHELZ4nuHiig9cH+Z/lqSSoX53onj+QCbZZwUPjf6oJPyiI1h/DDhrmRERbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078032; c=relaxed/simple;
	bh=7TZzsqMFbtcgc+w5SoueN6NnlsZVcur7+/g0tDCWPXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOSJHAHp6AHanUeXJUzFmAjZML7we/MB5DBe3thO5RV/dGWDhjvmfNLUaeCTmNCVPTEoP+kDZpALNhGnU/Ew7uEXuCSeKxqQ4tkfu4WqmGHyruL6flUd2fL7fliRk5FAYrZop8yvRENvvu7ZiK5sJ9pU/3kqGE8/XuESFQNPS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lc5KWNez; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tRCoxWYP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc5KWNez";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tRCoxWYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783078023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=;
	b=Lc5KWNezU4qSsrVes0aXD4wfZQ+XbqsCTLrWcV3dWLt5lEMwj7HnqSzcMC72HsOgiggeBW
	jsEWjo9JbnRWjWFomTJR5ryMVCx4bpIs0AadeVeiL1TeqlOzoNHOBPENIHN4RKYofc6TWy
	kGWm8ejuT33eY4AYWqKRNWxch7E76QY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-2_h8oBiRMl2fRr-8hwDv6w-1; Fri, 03 Jul 2026 07:27:02 -0400
X-MC-Unique: 2_h8oBiRMl2fRr-8hwDv6w-1
X-Mimecast-MFC-AGG-ID: 2_h8oBiRMl2fRr-8hwDv6w_1783078021
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c9f0073e20so9141275ad.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783078021; x=1783682821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=;
        b=tRCoxWYPlE5d5t3BHjAFklAIa8tfB02OGSjJy/GcnowcQCE1Yj3e0O0H5+94VCtnGs
         LjPjJmykCdLRVJdztYqyylo2Gm1fME5qX1PECnp1G3HQjVs33E/2KmRlNAgl3xuka/YU
         FWuHE6tZxZh5MaKQ3PUMTSfqxmRGytqZRdmojqAIhKlB2Cn+tPmIElSi+yxeEqVFBTth
         vJ8gLSKe/7wtOlbgbPNItmqB1rYk4p6aIRXPsM5PUfMWhWgw0lhJgt2jHSrCl6g0FiGb
         O+MrWqlROYXrndBc1OYzOsbqj94DoMw2XKljRBxDzPBd4IBjbjjkgk2z2QEQCtwwYWkO
         jQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783078021; x=1783682821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dquujKaEWXj9SeOR2cw//kdvyk2bjQlGJyeh7Df3DyQ=;
        b=l7yCCq4plHaT86kah6SXXYGvFnj4AcHvd28ff/4Zr+7F6NaXaRK41kekPH66Aw7RP/
         M54srX4CnriKOLMFOqhMA8K/oVsMwx8gWyGP3KlNPGXJUMP7cGUl/6L1X1JLPd0kB+Ia
         PSn6nsgpF+G8ABxguinCFMqXFsgl8Omy1SY2uvlBpFEX95qFabNKC+gAiqNRkzEUiXjB
         ye6QJRMmQr5FnOsHnxV9YyuAWHAnkduQQCXIS4rjkDU+bSfhMgp3pbr/3V2/3kO46you
         mh8yAF+E5N6u5vGUFy+kToG/YuFnxoNN+C3jQPb/W+ntxT68bTttSKXW95z+cqiH/ta5
         eQXg==
X-Forwarded-Encrypted: i=1; AHgh+RoQ1gKSeIpED9PkanY7g5oCl2bNY8o9BOubLdD7beWYH0Y0Oi1nBDnM3w1qCWryHZmpkPy3sqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmKIqn1sLksTDY1xplcL/ghYejp5Go1cibFqfM43pwjI0ux2M
	/6obuniKi8HNu8jkiQKRZmsfbha3udOfOQOXeuIlS52TXlQSFIx80/VIQXSKVjhyGI0cK/KDIzF
	NfKdjkF/KcMAX4r6UqiIIPhMmhKac+W2zZvr9tpsa8AGnLyOOEJKBz1FFgw==
X-Gm-Gg: AfdE7ckocBvBNL36Z8J0tEoMU2YuCoZDkpXZ+VmVuIpxopHspugWgLEuocn5oj6rTgy
	HyfGcG5WKWuM170st+z6jIrL0MJLGvl/8SMl9JS6EjSNqmmxy9LLK3B7l6TbR5Vy8byzFGTHXD6
	oRCIRkriVMpKJRl03lffoy2c8yeIRfpp8+whucm250hV4KhVzr5KfG1tEWgP2wBY/87IykpNgAf
	6dReGW/FYJ3UF2n0dInnWQTA7KyyiDOJeDwBhfswudyb3QiH//ioYxgIYgFM9HpnOL8d0fIAyma
	qhaQxsqOUxzVzAWoyi1kBxikpaoo42/Rg68Mvdfk2opd2UacDB+PDP1KYu/PAmDIK9QFHmaopVN
	5DJvMzAbudd859jFR2sbh6EKnUC7evGrPavjbtltahphnsk10UQ==
X-Received: by 2002:a17:902:e54c:b0:2c9:adbb:5862 with SMTP id d9443c01a7336-2ca7e8b686fmr102173455ad.45.1783078021228;
        Fri, 03 Jul 2026 04:27:01 -0700 (PDT)
X-Received: by 2002:a17:902:e54c:b0:2c9:adbb:5862 with SMTP id d9443c01a7336-2ca7e8b686fmr102173215ad.45.1783078020656;
        Fri, 03 Jul 2026 04:27:00 -0700 (PDT)
Received: from localhost.localdomain (122-63-67-56.mobile.spark.co.nz. [122.63.67.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260acsm8227305ad.6.2026.07.03.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:27:00 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	bhe@redhat.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	pratyush@kernel.org,
	Markus.Elfring@web.de,
	kernel-janitors@vger.kernel.org,
	jarkko@kernel.org,
	Tao Liu <ltao@redhat.com>,
	stable@vger.kernel.org,
	Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v4] riscv: Prevent NULL pointer dereference in machine_kexec_prepare
Date: Fri,  3 Jul 2026 23:15:31 +1200
Message-ID: <20260703111530.91285-2-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare(),
where image->segment[i].buf might be NULL and copied unchecked.

The NULL buf comes from ima_add_kexec_buffer(), where kbuf is added by
kexec_add_buffer(), but kbuf.buffer is NULL, then it is copied without
a check in machine_kexec_prepare().

Relevant path:

  kexec_file_load
    -> kimage_file_alloc_init()
       -> kimage_file_prepare_segments()
          -> ima_add_kexec_buffer()
             -> kexec_add_buffer()
    -> machine_kexec_prepare()
       -> memcpy()

Address this by adding a check before the data copy attempt.

Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/kexec/CAO7dBbVftLUhd2qrh7hmijTB3PEPfZAhykCGqEfrPoOcSrrj-w@mail.gmail.com/
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
v4 -> v3: 1) Remove code comment.
          2) Replace (buf == NULL) to (!buf).
          3) Reword commit message.

link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
link to v3: https://lore.kernel.org/linux-riscv/20260701025732.66330-2-ltao@redhat.com/
---
 arch/riscv/kernel/machine_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2306ce3e5f22..738df176ff6f 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
 		if (image->segment[i].memsz <= sizeof(fdt))
 			continue;
 
+		if (!image->segment[i].buf)
+			continue;
+
 		if (image->file_mode)
 			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
 		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
-- 
2.54.0

