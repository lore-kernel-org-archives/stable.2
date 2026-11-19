Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046521;
	b=lLLPMUyuZGOwx/acHxJDB+2FdJ13MUvFt7QjA9TwfY2xoVD8EEYZGvIjZlEniu4TxpGC
	 MgIVoRyCxi6QXUBaC/bOQveYk/Vk/0R/dBpjVh0jmn6czojCyB8+MLRghBiSZyV3kQFwq
	 2NxnOgyq0sfdN3pZeXbBeAPZ1eph/kYIf4ILn4x/Pw97E2eW+3X2PqWtceKgAJFDy6m4v
	 cH3/5GJOQX2rSFP/ZaBoXEUBS979bFUCp1CYukhnixnqz9BatM8Nw1vLLFWhV2XoCC38d
	 bQrhIygFnc3IR62VhLnvyBZ2iLJajrY8m+aft3xrSADOL1vUL0Sy4HDi70KWd/kSMyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EaUSE7jvtdzLMdDkeb9svQ5+R7D1nly9NFuvzqZAt94=;
	b=aImFsI+lU0uPuK0UhDgHM2Dkuxo8qYObG7LqD7axT0YIaCml5CzCUyBd/KaQXGj1DPzs
	 WI0Y/HY+niJMZxIXhLZx4GSVwf19UWYCnqGRiZPSo2M0l8NHxNkl9DAu29P6+d8ecirwz
	 nHRrcFLyYUN+TgX8frCjMQRf0uURGlRPpBD0HMEVGohNbUaQl3bgXfNoZWiqmEua16oqP
	 sR34myXqYylETg17MFG/GLgnZZWuMvl3lCfNeMH3dVSZwJRJymeLOBbUW+4WyepC+DPxz
	 WadgBShhbDg5OjMbqzV8em+HQSLUCDaDlupGH3Q6l2UL5cXNT8XGPS5XPLl79JgrNxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iWDSr3r3;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370960A2631
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D370960A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iWDSr3r3
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4eb0b989f0eso533746b6e.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046520; x=1795651320; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EaUSE7jvtdzLMdDkeb9svQ5+R7D1nly9NFuvzqZAt94=;
        b=iWDSr3r3l8iiwx3aQDbddIuzkifAiT8/3KYkPrxFNoIE8SejRtC1nqQmRojagrY+16
         jKsn3RRgZJn1zn8OVpvoLI8NzTOUE/oiDBX9Kcu7i6fOtY6JhjqsoCO+OFqFvg3OZ9kz
         z5SNSHIfcpOnwHy5U2HVMeHwM6fRlqFIpJz9LQo78LlP8fSBKHany1pJwd733jm1kVO9
         0v0sJtOsjVPuOK44LMyPy9nfHHV7rtv8jfBqfb/CQYfYhobSp6S64EuKLyWlBu+Nsari
         itubvXc5Cw/jf697xN5jLJpqg4m+s7SQuEWjAhBIhGxMvbLWN5Uvaxl/1iaZtI5SgeWE
         FERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046520; x=1795651320;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EaUSE7jvtdzLMdDkeb9svQ5+R7D1nly9NFuvzqZAt94=;
        b=c8ykBEZJsFTISZY8CYshhkaKmJeKNyGh+26G4t8/8lUJG0J5veI7EL2ZCHV7O0V848
         BOzqxBxyDkK/wFjJoqTqFLIaOCCmVcqyz5PEQRa2KuElKGXWyB0gtYeTgPDlJVeRK2Qr
         gLBJYExBRKldp+Ane9aEUsxZ+W2XoXfjw/a4d62eWpWgpyVWN6WRVWIFlKRtI7TpOeEt
         K0evkt9fsZiP44ZGcIk+g12oKbK6H/MRJK47Vw7rJv2ts3IMfFthj01hSrknNXhB1Tzw
         v1BSccooac3gFckmswYh5Gk2ybuhXMOXQqlEM2yo4gbYIRqTCm79PXO8WE4E5zfuMBee
         OgTg==
X-Forwarded-Encrypted: i=1; AL+hErGCtEHcssBuMVOn3fbx2s4ApSiOW2uckc5oJJrVhyMoZNnjNuFQycrVonnBJPb/DdE7QsXZD5k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pPsGwjsxgBGDszKQ06J58ODN0j9RZkKUADsQwc/VA68TXvWQP
	RskJnbTfYaSlb9uuQRhQbmSwjTcdrBFARa+IR3NZns0zu44yYghqFFuLEdX2A2vn93wcuEV22p8
	BgQUeGXQZpPEwew==
X-Received: from oibmo11-n1.prod.google.com ([2002:a05:6809:70b:10b0:4bf:8346:d667])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2f08:b0:55b:f88d:6e8e with SMTP id 5614622812f47-5790436e90amr291024b6e.11.1795046519323;
 Wed, 18 Nov 2026 16:01:59 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:45 +0000
In-Reply-To: <20261119000151.442543-1-dmatlack@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119000151.442543-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119000151.442543-4-dmatlack@google.com>
Subject: [PATCH v2 3/8] vfio: selftests: Add __sysfs_sriov_numvfs_set()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add __sysfs_sriov_numvfs_set(), which returns the error from writing to
a PF's sriov_numvfs file instead of asserting that the write succeeds,
and implement sysfs_sriov_numvfs_set() on top of it.

This will be used in subsequent commits to skip SR-IOV tests when the
kernel returns -ENOENT, which means SR-IOV cannot be configured on the
PF, e.g. because vfio-pci's enable_sriov module parameter is not set.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/sysfs.h          |  1 +
 tools/testing/selftests/vfio/lib/sysfs.c      | 38 +++++++++++++++----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
index c9ab1ea8f5a9..ede114181cf8 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
@@ -4,6 +4,7 @@
 
 int sysfs_sriov_totalvfs_get(const char *bdf);
 int sysfs_sriov_numvfs_get(const char *bdf);
+int __sysfs_sriov_numvfs_set(const char *bdf, int numvfs);
 void sysfs_sriov_numvfs_set(const char *bdf, int numvfs);
 char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i);
 int sysfs_iommu_group_get(const char *bdf);
diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index d88e348a1e0d..308da0526543 100644
--- a/tools/testing/selftests/vfio/lib/sysfs.c
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -56,17 +56,24 @@ static int sysfs_val_get_int(const char *component, const char *name,
 	return ret;
 }
 
-static void sysfs_val_set(const char *component, const char *name,
-			  const char *file, const char *val)
+static int sysfs_val_set(const char *component, const char *name,
+			 const char *file, const char *val)
 {
 	char path[PATH_MAX];
+	ssize_t ret;
 	int fd;
 
 	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
 	VFIO_ASSERT_GT(fd = open(path, O_WRONLY), 0);
 
-	VFIO_ASSERT_EQ(write(fd, val, strlen(val)), strlen(val));
+	ret = write(fd, val, strlen(val));
+	if (ret < 0)
+		ret = -errno;
+	else
+		VFIO_ASSERT_EQ(ret, strlen(val));
+
 	VFIO_ASSERT_EQ(close(fd), 0);
+	return ret < 0 ? ret : 0;
 }
 
 static int sysfs_device_val_get(const char *bdf, const char *file)
@@ -74,17 +81,17 @@ static int sysfs_device_val_get(const char *bdf, const char *file)
 	return sysfs_val_get_int("devices", bdf, file);
 }
 
-static void sysfs_device_val_set(const char *bdf, const char *file, const char *val)
+static int sysfs_device_val_set(const char *bdf, const char *file, const char *val)
 {
-	sysfs_val_set("devices", bdf, file, val);
+	return sysfs_val_set("devices", bdf, file, val);
 }
 
-static void sysfs_device_val_set_int(const char *bdf, const char *file, int val)
+static int sysfs_device_val_set_int(const char *bdf, const char *file, int val)
 {
 	char val_str[32];
 
 	snprintf_assert(val_str, sizeof(val_str), "%d", val);
-	sysfs_device_val_set(bdf, file, val_str);
+	return sysfs_device_val_set(bdf, file, val_str);
 }
 
 int sysfs_sriov_totalvfs_get(const char *bdf)
@@ -97,9 +104,24 @@ int sysfs_sriov_numvfs_get(const char *bdf)
 	return sysfs_device_val_get(bdf, "sriov_numvfs");
 }
 
+/**
+ * __sysfs_sriov_numvfs_set() - Set the number of VFs enabled on a PF
+ * @bdf: BDF of the PF.
+ * @numvfs: Number of VFs to enable, or 0 to disable SR-IOV.
+ *
+ * Return: 0 on success, or a negative errno on failure. The kernel returns
+ * -ENOENT if SR-IOV cannot be configured on the PF, e.g. because its driver
+ * does not support configuring SR-IOV or has it disabled (vfio-pci unless its
+ * enable_sriov module parameter is set).
+ */
+int __sysfs_sriov_numvfs_set(const char *bdf, int numvfs)
+{
+	return sysfs_device_val_set_int(bdf, "sriov_numvfs", numvfs);
+}
+
 void sysfs_sriov_numvfs_set(const char *bdf, int numvfs)
 {
-	sysfs_device_val_set_int(bdf, "sriov_numvfs", numvfs);
+	VFIO_ASSERT_EQ(__sysfs_sriov_numvfs_set(bdf, numvfs), 0);
 }
 
 char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
-- 
2.56.1.708.g77570a6a1d-goog

