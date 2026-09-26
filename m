Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78F47DFAA;
	Sat, 26 Sep 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432681; cv=none; b=RWR5nMyh3lqFJARzTKa+wzrYf2w4bKJG/y5ine2PwI+KXl9DQgRssewOmVL/Ev/H4qGjbA82T5etB5wTOZ8IDeovQ4ABes1LPGg5mvHFMctbJBASffqBiUlnp+694NExIgbfkHI1iGYyxAQ762X/dvwe7zywQtqCVvChUsjKJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432681; c=relaxed/simple;
	bh=I2kRED7Ex9hGK6RVw+r2WGj0oY7Lljw2I3UvRXkGIIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxaiv5mNyYRN1deq2/Z6C3zVArTS741nUUWxrMCjW+EFH5hd74shJOlimM+aO8us7bdgC2JpBO+RdLqEryDhKJZNWRy89ZR+HQwhbQSiVYEZKZAT3exh3IYElpuv/2cSCMEBeSSFWsjFpyznNuQu24sckl1P+5AT6V1Y/rS6pu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LXOCmzQS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LXOCmzQS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=JW51wsFy1A0rbfcAOKBAwrs5VuLl6snxykqG+tyAoyk=; b=LXOCmzQStatVVm7/KmsiT+oSUC
	ZkQaGdkNnVK+QMYNg4aN3cqoOgW7A7u48GYntMuatc0weYNYMwLwd1LBxGYC3ygjh1uUlJYnbkoHx
	SgkWl6zts2zt8bWhFqLexn75cDCmbV3v8hLOiZXGFvOD8ZdW7hIkJeDDzDjEVRjwC61UNnYoy/IJc
	+4gNR8mYa2C9CGG1YQqitkG/v8eWcTeeRYVA0Xs81AO0jxGOvCaAFj4vEvD1aOKYxBjEOzInWf0fj
	NcF0l1pJ/CkThyU4Gi654c99Fylq8b848BjP0a+JSSxrj6AeReKpdYK7KWmsH1ZsgpoBXspqzsUrd
	jeFz7yZw==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xATKB-007dEi-2p; Sat, 26 Sep 2026 16:24:23 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: airlied@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	dave.stevenson@raspberrypi.com,
	dri-devel@lists.freedesktop.org,
	javierm@redhat.com,
	kernel-list@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
Date: Sat, 26 Sep 2026 11:23:40 -0300
Message-ID: <179043261253.642825.11543928631039908274.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916154015.2056797-1-vulab@iscas.ac.cn>
References: <20260916154015.2056797-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Sep 2026 15:40:15 +0000, Wentao Liang wrote:
> The firmware reference obtained via rpi_firmware_get() is leaked when
> aperture_remove_all_conflicting_devices() fails, as the error label
> returns without putting it. This happens before the firmware is
> consumed and put further down in the function.
> 
> Put the firmware reference before jumping to err.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
      commit: b816da5d5df1461446a0a5f3fe2b4948a659a790

Best regards,
- Maíra
