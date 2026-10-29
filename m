Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306010;
	b=unS2IL1FZZydG55eGcHsHOWfHqut0KbNxtlP3Ar8FAU9ONt+XqdjwMy/vnX5O9O1QGl+
	 804raFjqFAvl1ld30TnIXVFlh6kseagqeTO69f11ueMPoXlMYvyc9txK6bv5r2b0W6cyO
	 XRqmr/DzVMzspH79F0dOgkNFupzOrpS1IZAfd/gvUttv8q+uWXlyIOuhaNQnWEgYsrajH
	 BVT3JKiKUc+RIisacA+TFbLjS4n2LbEV/9o/YOkTAxfuE0fLk8LEu58tjoeVfGuXoJKpQ
	 W9OV3ShtG3s5ws2bSVbswgP71wJAGFu/GpVh6pTomwT49pv7j1r0okaAIpzEwjVpv8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tDfMnHPOVxE98+9TE/nBvfLsdX5oZKXJTQxV9ofrPB8=;
	b=uViyYYbF4dXlQJHOFS/M+gOEgdLDWGtAbSomjJVWdYDSfTS94Yo+8PHbFzejd1lx9l3F
	 6mM5Y+MjcGLAaPTbNhGJ2nwxahZXPEdNmXiW8onBWH3YV6h3uhP09ifsvt0lYtKLPdxua
	 wFROCaO54223wyMFGAem3XWOt5MVespXE5mhrtjcxEerKFI7cKzNNCCiEn68SpO60zF6l
	 LUK3fC4yYndgPXqiXuj7AwB+EWcX8K24LDWfZrnNDgnCQMjOwVW0kVSuKO8N7Mdu/ERho
	 BTxpY1PUOmWsjx/fHOvFAs9aZoDg+P4E4PNJADuBArNu0p++sBWtCAzDzI9TB95061A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jVFy5+f3;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0660A2600
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2B0660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jVFy5+f3
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad7030e886so15514a91.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793306009; x=1793910809; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDfMnHPOVxE98+9TE/nBvfLsdX5oZKXJTQxV9ofrPB8=;
        b=jVFy5+f39q99V15VIlErwgQ/W4JaK3puuVFnmWxDh5qTYdzYTJm/i5S26DvU74eokY
         dEBszj0wP7s60Ia5DwLR246rhtEnlUJLcrW89C+l/iTHE05Mgyua3tJU2eIIVEn7QGa2
         1tP7NcSxuZN+unp/iskwvxXQ1DN9j+EpgKQftNQ1WYbq/mOK4Q7833DHO/d3tcd2rg0y
         yHshEZmt8XPPm7p82kjx5mH6lZZMkBSmHaAzogxKryBwnvlU4dmXHUnd+h4jJyPAeX6i
         g1KvAV2uq3R4Ybl9rxrMFMQwuWvdlwGlpZPDprdmvJXJM0Tq5Na/aG/AruA+chpCVvcC
         oqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306009; x=1793910809;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDfMnHPOVxE98+9TE/nBvfLsdX5oZKXJTQxV9ofrPB8=;
        b=pLB1jXCHYOgQDJqdmb41CkcqnA4pxbj7MTKRC3dvERSeQwvKFiJJbC9umXhBW6kga0
         JhlpjWY6RsGp9A+jvScgMLdRb0XslfUpbquAHigTU3W9BRaV0bjHVL+LJn7js4hVMUUu
         tCjJAQsPL54zkbai45xG5nKUe9pWgVnqCD5J1IPZ1lAN0p1vxR4vU9Ng3Okw4oF09Dod
         weA4IZwmB63wT4mkwTgW2/XvNRPJz4lMPQa0wHw+gt8LepOwMej3nXAxp2WVYM/epLqA
         MX/aIxmMDGGua/chJzg/ZrXtrPpfK/KMgqocWYpwMeDsWbE/A27Bu2/1SMt+n8OJ8YrO
         XUyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiuOI/YSl+DueTno6qcP1OiV+ynKUBYnaL15bBQzubpvwmKwmgYzFDUuX+szxx9h0mUeupQCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeDAFNGPzw0TJE26viP5OH4c35aupdQmuubL1b7cLLPtiI2UiU
	rjffioHcXKNjlpC/mAyHLPGNMvD8Tgic4LAdsNLlIpXjcDgZYpSH37h4OygZdpNtQIwU+4m+dM+
	+uvFC1yUZM283yA==
X-Received: from pjff12.prod.google.com ([2002:a17:90b:562c:b0:3a6:daac:15d1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3812:b0:3ad:183f:5e3a with SMTP id 98e67ed59e1d1-3ae89574cc8mr139687a91.4.1793306009170;
 Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:33:22 +0000
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
Message-ID: <20261029203324.1637772-4-dmatlack@google.com>
Subject: [PATCH 3/5] vfio: selftests: Add vfio_pci_find_capability()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a helper to find the config space offset of a capability in a
device's standard capability list, mirroring the kernel's
pci_find_capability(). Return 0 if the device does not have the
capability.

This will be used in a subsequent commit to locate the PM capability.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  7 ++++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 25 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 007adc322c1e..1839e95cc792 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -79,6 +79,13 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
 #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
 
+/*
+ * Return the config space offset of the first capability with the given ID
+ * (PCI_CAP_ID_*) in the device's standard capability list, or 0 if the device
+ * does not have the capability.
+ */
+u8 vfio_pci_find_capability(struct vfio_pci_device *device, u8 cap_id);
+
 static inline void vfio_pci_cmd_set(struct vfio_pci_device *device, u16 bits)
 {
 	u16 cmd = vfio_pci_config_readw(device, PCI_COMMAND);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4063a0e2b3df..2afbc465d30c 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -260,6 +260,31 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 		       write ? "write to" : "read from", config);
 }
 
+/* Bound the capability list walk in case the list contains a loop. */
+#define PCI_FIND_CAP_TTL 48
+
+u8 vfio_pci_find_capability(struct vfio_pci_device *device, u8 cap_id)
+{
+	int ttl = PCI_FIND_CAP_TTL;
+	u8 pos;
+
+	if (!(vfio_pci_config_readw(device, PCI_STATUS) & PCI_STATUS_CAP_LIST))
+		return 0;
+
+	pos = vfio_pci_config_readb(device, PCI_CAPABILITY_LIST);
+
+	while (pos >= PCI_STD_HEADER_SIZEOF && ttl--) {
+		pos &= ~3;
+
+		if (vfio_pci_config_readb(device, pos + PCI_CAP_LIST_ID) == cap_id)
+			return pos;
+
+		pos = vfio_pci_config_readb(device, pos + PCI_CAP_LIST_NEXT);
+	}
+
+	return 0;
+}
+
 int __vfio_pci_device_reset(struct vfio_pci_device *device)
 {
 	if (ioctl(device->fd, VFIO_DEVICE_RESET, NULL))
-- 
2.56.0.317.g454f8302e1-goog

