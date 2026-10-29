Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306016;
	b=ixqKGZVE0G2H9pGfu0spDtJgDfxvRKOvmdwxu8DqNuY4togeyIsBYL1IxIZ5P04AcpiO
	 Mj67a6sL5EvPrGe3jvpHKrOl3suq8JdjnbTdDHWWwsoRjj3+vm/+vibjG8TjED16cPJok
	 B3boGcduEUEvDD607LDvKE2g/AyEWz2MepTNITlAb6P/E8pGKMGu37luxu9zP0YWKEs7S
	 rTZkVh9Edjr4CEo8FM5SKHUtCqhw3WhhTLadmDh+gjT8C9O174tozvMoceDFxX2XJhwZl
	 Ad08hvoWg2H6SiuiryvN1MlPnPcw9rLbYXuxDltK7G1Hx03DXguhh9WbIZabB0PTvGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=z179Ocr4JquFIIJEs4efAQ+NRuf5uFGDrSodVviqc40=;
	b=bXwRf4UXrgnYtdYPIEF++QrPkf27AnYkow+R3XazmkuS3zaMdSCwFhCK7Nyezk8KsUQc
	 TVsSnLnmiTU5fQAurC7WknIzM4kGD5W0Ut+lyhOG7V4RllKrMty0eil4gMP0oPnoiB3He
	 RopZ3TrUnhMYoMCDFR8ZDzNVB+9zR8uS9u9VaIys0CD9wocyJk3DF1CXZWQzukDdkiJ/V
	 XkGvDm9FkO0SRi6WJm2jM7S5VLEXutPrktQFY+cntxZtT+cIpZ22PpfuKj/XpbUkvRFsM
	 X048oBrKskSeLPbut967tsmm5Kmr9E0jDqZcX8sG0Dg4lMxrn3WR6HCTJ3M3exleERw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="k/h7ENib";
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556160A261D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D556160A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k/h7ENib
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so2653230a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793306010; x=1793910810; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z179Ocr4JquFIIJEs4efAQ+NRuf5uFGDrSodVviqc40=;
        b=k/h7ENibaZ/MHveOfXZbn8cGvIsxFR9IpAxNtw3uxjW2EEVPpBpgKySaDvjVCOtLkC
         PFPyV6kU+sS1sl2BXzQphOCHkjj+1XhYVzhLPwFeoiTBp7QrtAWXIyKORrt0HLt2Olmk
         Rqdjd4bcgIe+aXaCPfjfbV/wcB4KhVhth/FMBH1Acc5y1M8qHyXaae0FputJ9WIt6wK1
         ELuMFTyxid2zLMBN1WdTMSsV0IJlaGuE6o9f9XdTN1mbpnf9AuQhHazzCUy2IuoW9u+H
         J/t1k11ZqkQ7EmxV54ne+n3n5zMIwVgbZONmDDp7KmG2yiiZclWh5sL1Bogt4zPnEBoG
         yBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306010; x=1793910810;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z179Ocr4JquFIIJEs4efAQ+NRuf5uFGDrSodVviqc40=;
        b=ziSs6jmt5Dz3ye82Jvydl/pdWx39e0qhWeGsAg4bwIA6A/E5bVsaEgpRA8K5p4Q/9k
         z51Xb+lRBMhRiYlkMDlDDKdN15OGbVO4A5BnAQ3JLjfzi2IuTz59C611EEw/d20DUy1k
         2WQAm8jJQ375dg4mj7DYZDxW+a+MhouKtr+TXbveBon8+whlO9Ei/zRoAVrdU5BUsUD8
         yA6sqOHTpVJztIpLvZh6egJmYJNHisOS08OvQ10aYm3wer005mXn3xcBzwIyQDJiOeh2
         u9DOs0rqjGOEUziWe3r0yrTU8YtCThEYSh/ewPYKLfBiY7QXGDAcQC5ILLb24fvLXlTk
         cQKQ==
X-Forwarded-Encrypted: i=1; AKwUvByB4vpwgMqpfar3uYFowEBatsIpAP+Doe0FcQQQFCcOpn8szJfZjQB7EQA/842GcFQNdQRaT6s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIez3ECEkCCXtKSnWAZglKx+GA0wR7aFleZSZG55qXFa2nJfy3J
	5lfGs5rM3tWwjtNKdkvGh5k9DFYVOlrtfkEYcdLDBg0DB5TjWPhY1ivR6VPFXpr45/Pet5mF7lx
	SQK1liGQlF7/e6g==
X-Received: from pgdo12-n2.prod.google.com ([2002:a05:6a02:620c:20b0:cd6:1fc4:6199])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7741:b0:3e2:30c1:fe01 with SMTP id adf61e73a8af0-3e928e3f9c8mr297152637.69.1793306009847;
 Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:33:23 +0000
In-Reply-To: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029203324.1637772-5-dmatlack@google.com>
Subject: [PATCH 4/5] vfio: selftests: Add sysfs_kernel_warn_count_get()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a helper to read /sys/kernel/warn_count, which counts the number of
warnings (e.g. WARN(), KASAN, and UBSAN reports) the kernel has
encountered since boot. Return a negative value if the file does not
exist, e.g. on kernels that predate it.

Factor the code to read an integer from a sysfs file out of
sysfs_val_get_int() so that it can be shared by both helpers.

This will be used in a subsequent commit to detect kernel warnings
triggered by tests.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/sysfs.h          |  7 +++++++
 tools/testing/selftests/vfio/lib/sysfs.c      | 19 +++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
index c9ab1ea8f5a9..1b9711d1bf90 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
@@ -9,4 +9,11 @@ char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i);
 int sysfs_iommu_group_get(const char *bdf);
 char *sysfs_driver_get(const char *bdf);
 
+/*
+ * Return the number of warnings the kernel has encountered since boot (e.g.
+ * WARN(), KASAN, and UBSAN reports), or a negative value if the kernel does
+ * not support /sys/kernel/warn_count.
+ */
+int sysfs_kernel_warn_count_get(void);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H */
diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index d88e348a1e0d..71470196f092 100644
--- a/tools/testing/selftests/vfio/lib/sysfs.c
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -33,15 +33,12 @@ static void readlink_base(const char *path, const char *data_fmt, void *out_data
 	VFIO_ASSERT_EQ(ret, 1);
 }
 
-static int sysfs_val_get_int(const char *component, const char *name,
-			     const char *file)
+static int sysfs_path_get_int(const char *path)
 {
-	char path[PATH_MAX];
 	char buf[32];
 	int ret;
 	int fd;
 
-	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return fd;
@@ -56,6 +53,15 @@ static int sysfs_val_get_int(const char *component, const char *name,
 	return ret;
 }
 
+static int sysfs_val_get_int(const char *component, const char *name,
+			     const char *file)
+{
+	char path[PATH_MAX];
+
+	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
+	return sysfs_path_get_int(path);
+}
+
 static void sysfs_val_set(const char *component, const char *name,
 			  const char *file, const char *val)
 {
@@ -148,3 +154,8 @@ char *sysfs_driver_get(const char *bdf)
 
 	return out_driver;
 }
+
+int sysfs_kernel_warn_count_get(void)
+{
+	return sysfs_path_get_int("/sys/kernel/warn_count");
+}
-- 
2.56.0.317.g454f8302e1-goog

