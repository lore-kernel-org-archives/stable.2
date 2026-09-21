Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CF4772A8
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987268; cv=none; b=Zej611vCATCjjwYcryewXezeEqHiXcGylvS1jVVbJzM4/LbXoMAJ8+GGf7tES6OO5ns78y1s2zJNJWO8fYx86CNkAxDhbhYdO7+udxNHk1baIi0TA9oF7+QjVjDSEB34wvJzyzM3VElOUJRIS6PrjHLFkVOMWCyOZiPGQLSVKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987268; c=relaxed/simple;
	bh=jV3rXd+gLIZ1kbXj0TODJowVFnqZ1XVvvGYuSJ4XS/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGwloGCco9f6RZjntVoO6WNvNlGj9WB7cRK+bdQMZl8NjTnfEmPOeRt4Nf17UwAGY2imEDATw5v4aKwJUmC3CUwwOEJbS4ixG7vijBJrS821dJ7MfSqn7bgORfBOohJdeCpj9zXqsfcsQz6D+c5vRlwh0sQM9EGfvHi+aHUrPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcTzRJ/s; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcTzRJ/s"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso1848345a12.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789987266; x=1790592066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=71o9YI6lTkfQsxMzDOfAZ9YQ4Htmj8t9P5fvi3r60mo=;
        b=qcTzRJ/sG/fjZg3emICi7ZJQzBBdW7himeajs3KzKrcLVaX3jWO4JroIqxpcT18nEm
         xWgHjKn0zK6DFL2quh6RCtlyOq1TwvykSO5av3z91A58AZiLNvif3XRijZtluoVsPz+O
         8lMpuc0awKA7PzjU5IZSfGOwmCr+h3As30klyTOAnMyF3mlExWyIGkgaV1trrvkbrcu/
         Z2p2ZgDt3FOhjiYJE1RmIj2vaA+kJnG5Cloi//RbkHMvhUBmigjmRaoVL0FUD0Q5NIib
         +FzpN5PwAKBIwmXShjG7Dj3ahIumVMu692fJll7LQLh4fUnmnmd+mGXfxfJSa/7vqcRO
         CYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789987266; x=1790592066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71o9YI6lTkfQsxMzDOfAZ9YQ4Htmj8t9P5fvi3r60mo=;
        b=pOr6Q8tDHv9sZdMyPiCrIU7W3orO+rU4YzXzCKJkvt6BvToHN54Y2lG8R2Iw7RxJBn
         +BH7HfNWyaC592atWyXkopYOwGR8byTW2MeZTsDdBs0gXUlrhf27VKtp4yy956NhrfIM
         pW7u99RQdT0h8LIvL8gArmxIkItDuqFgZmi+NetujyJirTdgtYe9oKcmiHUbI7kXCND8
         iPEkUfd3CG+ZN3QczwUP9buxpTyCzu74NLZWB4StEzO5XDZfcQNYA+HaqwK3vk6kxxa5
         Lyu0dW7LOf/ntcf+0Lh/dbTAElxvGAz/gx4q9VIsAbOExna3jdNTjH9o66pM1zGdQ/dN
         m1xg==
X-Forwarded-Encrypted: i=1; AKwUvBwVLz0oRekxpW4kz/X5/zd237AKbiahyPe0vVnmoxhu97LvjZe10P6qCu9LsiiCpOmC07hBK8U=@vger.kernel.org
X-Gm-Message-State: AFuF++nRkEALd3WGrERurQRg0PsaWoo/vgoFuOyjq9HuoFqDRddKbrFl
	s5UBWEy+DS9AKKIBuqF3+e1Waa0+WYtruHMeW22jKD5JA7rWYyKsPUl9
X-Gm-Gg: AYBFou0ksMEE0/bsr/JcZGLfsalIMd/TbOzP4GrHNn02P66aCwcKLsbtcAGadsRdmaL
	+E+fWm9hztLmRhud2Y3/9cK83FRy/y5n0u58o6linX7cIgqvciwZjHfJOouuVy+DcHVkMpYs0pF
	AfYa0f0Fgw/cxk1BaEZZVxtvMWaNBVDwYdaEBa5VHY7mhJsGIFiAbGxglFWqjxAL0pFyd4HKzE7
	BhEZHAeAc30f/etivuEr0UG4slHRyoKQRZSTWAXwvfcK3/Pgjg/0Kw76gYKdctQSyJhf0sbLvKu
	1hIXhUYZVRjLAfBTIf4wzWM0EddC1h06FTS3vQ0+nFt7vdvwDs8tRVYMWdq8u0gzRqlyiaQrU/q
	jswX2Biwuq52+Qel7T/LgNrSyDgkZ4ZdV1bnB+JNIgaM8aIllTdAVAEGjQPdIaaOdfDm0s8juVA
	EBvf+ZdkL4gBYWrxCqX0F6T6rV5WNCloPiBlfsID+wtYjhecdfYZNSN/3NAX5Jr8jK
X-Received: by 2002:a17:90b:57d0:b0:39e:6c69:f479 with SMTP id 98e67ed59e1d1-39e6c69f5acmr10028531a91.56.1789987266133;
        Mon, 21 Sep 2026 03:41:06 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a03ab822b6sm7600102a91.5.2026.09.21.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:41:05 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: intel-lpss: fix iDMA device leak on probe failure
Date: Mon, 21 Sep 2026 18:40:58 +0800
Message-ID: <20260921104058.353748-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_lpss_probe() may register an iDMA MFD child before registering
the main controller cell. If the iDMA child is registered successfully
but the subsequent mfd_add_devices() call for the main cell fails, the
probe error path returns without removing the already registered iDMA
device.

Since the normal remove callback is not called after a failed probe,
the iDMA platform device remains registered and is never released.

Call mfd_remove_devices() on the probe error path to remove any MFD
children that were successfully registered before the main cell
registration failed.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
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
2.43.0

