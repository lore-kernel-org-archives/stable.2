Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584906;
	b=uUPsAG+cnID3JI3Qgn7TGRsMi7QJFY1HRF3lBrUglUIeUBK1cC6ci3phqwjgD5F9NC+w
	 ybOc3rUNA4IRe7l8gJC6IdMUJMu9z+BSAP/ljHhXfBYk2fYiskWONzD0NuAHBc2bpcDrB
	 2iWAYURKoHUKbgZ3VoSb5yAxdAw+cvcIVYtd0jUt3k7oiTp6ipYX82K1U/MYV7kDiKpS/
	 p8alM+pnaLCVBrfKKT/idiCM+hEK8VcBWiFpeMKVyA86l7lRm0cfeHcs/oYR5KGqlIeY0
	 OpKIdBtGkddoRuFuoFPJm/3/Hm1lP4jWBE1YHX9CEj8q9NV9i9RFIRIyDXDpXuUPviQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584906;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RcKMeHcYRx93IMDgfCPVEkBbpRlDXdFVk+SNslSZ6lI=;
	b=knG795FPYNx0z6yGGsfUXv4n4+5Xt0QpFsgrzL14yiOzLD7/7PYS8B42O0lCxIQjAVMT
	 0YOvQycFd8aKPp/ifhBnPKxFqjte5Dei6eW2AOxGKB2X0Dvknt1QqJVxz+4ZA84PHheGA
	 qTyV7LP580dd4mVbPJIxIUGH8MACJo89B/bjWj6CtWzRJyAjD8DxVNMLsNVYdBNpo2M1x
	 S+swvuxYWEKOt1t+tahXrbDxnDQHqDbpdvHUqx3Ln8Gcw00tnoQhog1S+DJKq+RoM23RG
	 g5dVZOfeOi2N36lXWDw5/75pUTbsAjIjfCJXpv3cV16XZoL30shaTazzdlxqlA6KAGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIH6Je2t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914560A4AD6;
	Wed, 21 Oct 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIH6Je2t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC291F000CA;
	Wed, 21 Oct 2026 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584905;
	bh=RcKMeHcYRx93IMDgfCPVEkBbpRlDXdFVk+SNslSZ6lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WIH6Je2tZeJpJ38F1nPdsDpjS51BfVsBi4/iCTwNcZN/3a+Ufc5Z1Q/6QC8jbYnhv
	 2Vx0E/igpEl+NSSU6wWPBpfH3dEnL5pZeSa9dS/fXzl5Y9sEoQYHMnleN3okf0XGRc
	 qwKyAVrBl/bnIHZMcGobFFTUx9qXNLyAfVtnhVMCwy30D7WPTMTDEozkL+JAY6pTCa
	 UWcPboVUnetD0AN1te+pcphKBZuR8IkrmBWiqsypcO/MpSiSQCL6U4za17dOkLecdz
	 +c4BGhxQERbKu4VS2PkgrClYkvH6bLtURcwo4KKQMSGU0WD78yl0M+xcbyyVgcaYbe
	 u3pguUDxM0Vew==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 11/28] mfd: intel-lpss: Remove registered MFD child devices on probe failure
Date: Wed, 21 Oct 2026 12:09:33 +0000
Message-ID: <20261021121245.3111563-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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

When intel_lpss_has_idma() is true, intel_lpss_probe() registers the
iDMA64 child device via mfd_add_devices() before registering the host
controller cell.  If the second mfd_add_devices() call fails, the
err_remove_ltr error path returns without calling mfd_remove_devices(),
leaving the iDMA64 child device registered after the parent's
device-managed resources are freed.

Call mfd_remove_devices() on the probe error path to clean up any
previously registered MFD child devices, matching intel_lpss_remove().

Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
Closes: https://sashiko.dev/#/bug/linux-b0ba1dea-0272-491a-a1aa-2fd27c5eb9b0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/intel-lpss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 63d6694f7145..657b1e3fb896 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -455,6 +455,7 @@ int intel_lpss_probe(struct device *dev,
 	return 0;
 
 err_remove_ltr:
+	mfd_remove_devices(dev);
 	intel_lpss_debugfs_remove(lpss);
 	intel_lpss_ltr_hide(lpss);
 	intel_lpss_unregister_clock(lpss);
-- 
2.56.0.218.g1ec904b173-goog

