Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CF284B4F
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250550; cv=none; b=ilkHI4jel8Vc6w5RGe0xbQywLPjwcArgP97SP9iIt7c3S9SDW3Wh3fYHYhhd/FLLLf1Clq2kE4Fx2z4qOAMojN8EzwJ8fZN5NpDAKrLOC8MS30Ud3HtS/ivDAKgFArJeglpkwHP6lqqIujGELTyKkFrVSsfwqKCg0Q+m4pHi/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250550; c=relaxed/simple;
	bh=OcsDKXTJZfmq0qIGGKf9E+bKmE4xgkEDDiDzEYV2m/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFLYZHB+KYUQ8q6f5CCz1lj+2itgi6M2h75ce8ASxnGrSl4XxofDTnSUibkm5mwoPeqtbwM9oadlhumw+1yhQxv02fw1m9F97o+3azy7EdnotGya4Ph/f4MfcCBSf2RIgItBhV6UnLuYHSBkzeIwQ71eDlCK73FR59gWGGsl5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuCCpQ5E; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuCCpQ5E"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso1398297a91.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790250549; x=1790855349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lZ3igjwc2yFqwfsFsDo7+TnGLNfpdbFLRcAS++D8X0=;
        b=iuCCpQ5EaEfmLzEFZQ0XLujL966DSVoElM03JhzA3klvxReFwBWDu5+sr6HKFayk2g
         qInomg5FDKbFoJmnCn7sbMxYlyqWIw+zbg3f9FZEjmvWwDUxcjCRKyh+2faEQbOWq4bS
         AaG9t8KJkJ65FuRkgb/+8F6UixUWF8BOfE1w135tPqq2PrtmX2htnmET41f6C4QoDUJ0
         RdMIdoyzHVEkIA31XEJ3KZvpFysOjiyxJqpkFaN14kt4v0LaXk3ol/M6NRMiDipk/rgP
         MQyTt3hOJOI0ej8IO2oVPQk/fIkpwNaCu/rLrzG2+IMVXXe3CLiCEkQeqiRm1gtThwme
         /E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790250549; x=1790855349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lZ3igjwc2yFqwfsFsDo7+TnGLNfpdbFLRcAS++D8X0=;
        b=kvYz1V/izHJfPJTSPzBwc+98L04E2EG+2Ec8AnK9T2iVAMWU1ANXVrqplx5umyApMM
         CHf262SjUK8MLUIr/9NubBGiB00C2R094C/3ij1Q3Q2t8Uxcq56UIG6i4iNxk9XcW+np
         2I4WroT1LFa/7OHRyBwqScg2OtHagL6C0O8/dd5DJE1PP/sSjCnMlFyjZiF+RMhkMcg5
         S0VJMvu5tX80HUqYtenIqx3YIwIaq+iGlaQ+j4YAfxtXYL2B/eO0Tw0aprDTghH8XJTR
         NfHdQAo3cfoH0Al2uo32pyvU1VZlNuEB93boO8y2ghvOhCs8gBeK3QF1Hh5B3SA2htbS
         2nuQ==
X-Gm-Message-State: AFuF++ndR0WTkiApnbKOsWPI6R02v/s1a9dI4klTa5a8eKr5a7M/17I9
	fcatpVXwbJ2gMPeJnu+QbLpINuBdw9XzXU764hbQPL15wLaoVeMuNBtN
X-Gm-Gg: AYBFou3M8v0Suqwky/NpYC+ntXkUdg6BixdVrNXsDsmCtwED0QWo5gd8U7ll7oYpVYD
	lpjw4zqkOAnE0ZZlIPIfVKs0jllYxZeVwEHbNaALwcS8mHfbndFn7e+PVuY8Dt7IdU5BiJu9KHa
	mUKVUD4gIWsos3jc1uEZOZD+8nG9UIwOWYAWAZHjfhnub/BkSs5xSZSKd95w/tXWnychzgUjokL
	BndL4DChCfYFfarlvoNeWYggkYrQPGLbj495AbDwZ5BwfGLRPy2kcaFHarEuUlj7smQYYM1BvTY
	wX0ddMdlHawNO31MzduKY1Y6SqzE0gwTRVPr6eb1g5r+Jpgv3OvyKqV36ODvvVVghE7VUHXnTPF
	iKw5yRXogf5hKP+0PbdRM1eAAQ8jfX4QBvM/Z1ERNbvy4kzQPPRmHD3jU7Wch4+6EWwgRptimzE
	A6Oo5rwDjvaRQjyI2ivlyM3Msyzxtf7ESFRMYnuHnGw24iigtP24aHrA==
X-Received: by 2002:a17:90b:4acb:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-3a098d43e23mr1937592a91.9.1790250548551;
        Thu, 24 Sep 2026 04:49:08 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a096b8753csm4771097a91.0.2026.09.24.04.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:49:08 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] dca: fix provider device memory leak on domain allocation failure
Date: Thu, 24 Sep 2026 19:49:02 +0800
Message-ID: <20260924114902.1577261-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_dca_provider() calls dca_sysfs_add_provider() before looking up
or allocating a DCA domain. If dca_allocate_domain() fails, it returns
-ENODEV without the matching dca_sysfs_remove_provider(), leaving the
dca%d class device registered and the corresponding IDR entry present.

Route the dca_allocate_domain() failure through a common
err_remove_provider path that calls dca_sysfs_remove_provider(), and
reuse it for the existing dca_providers_blocked cleanup.

The issue was identified by a static analysis tool and confirmed by
manual code inspection.

Fixes: 1a5aeeecd550 ("dca: registering requesters in multiple dca domains")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Use a common error path for dca_sysfs_remove_provider() cleanup, as
    suggested by Markus Elfring.

 drivers/dca/dca-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
index 583510850fad..1acfae12d689 100644
--- a/drivers/dca/dca-core.c
+++ b/drivers/dca/dca-core.c
@@ -360,16 +360,15 @@ int register_dca_provider(struct dca_provider *dca, struct device *dev)
 
 		if (dca_providers_blocked) {
 			raw_spin_unlock_irqrestore(&dca_lock, flags);
-			dca_sysfs_remove_provider(dca);
 			unregister_dca_providers();
-			return -ENODEV;
+			goto err_remove_provider;
 		}
 
 		raw_spin_unlock_irqrestore(&dca_lock, flags);
 		rc = dca_pci_rc_from_dev(dev);
 		newdomain = dca_allocate_domain(rc);
 		if (!newdomain)
-			return -ENODEV;
+			goto err_remove_provider;
 		raw_spin_lock_irqsave(&dca_lock, flags);
 		/* Recheck, we might have raced after dropping the lock */
 		domain = dca_get_domain(dev);
@@ -386,6 +385,10 @@ int register_dca_provider(struct dca_provider *dca, struct device *dev)
 				     DCA_PROVIDER_ADD, NULL);
 	kfree(newdomain);
 	return 0;
+
+err_remove_provider:
+	dca_sysfs_remove_provider(dca);
+	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(register_dca_provider);
 
-- 
2.43.0

