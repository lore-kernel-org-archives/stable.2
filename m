Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CE37EFFC;
	Thu, 23 Jul 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848409; cv=none; b=jOo+dAZrWgpHRDPNzovF6MEnMjSqeFqUwqnVVkYdJP4W0kIiPq+Ku9KAwbrtj/wezLMGvYHTlqDV2GnduN8xMsj/DKpabU6vlddb940EgjCA9tW1B5S74aqykQqVDvMZ3KtHjIlwoV4iiBkCcOL21P1PiMBEZ4om4KjAC3gKXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848409; c=relaxed/simple;
	bh=pZwWGi2mspd5xynOaJ0HSWcGmq3U9XgUJSjkP/Es1O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6uuyaQmrkssweH0F7K9wE0ntmlJG6RDxzGeSytZbHOoObd2016w0oszdo6Drm++zorqdx2dGKjKmO1/pINCtQpZszAmG5S5J/yAwSecaUnL/Ik1AG/DEwhjy5Eoum5D4NWTrn51xOu3uthayvK+NZwnoAO2AT/YnfzNK59ldrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rm7v2Vbq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rm7v2Vbq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=GuabusJUCwReDf/oB0m+9ls13Guj7z4MS8hlsidlBTE=; b=rm7v2VbqDi29hZ65tECuqvfIgG
	5H+oVLU2WhfLhDEGSgfrTd/5wg7Ane/CNvH500ZSCCwqTvAFyWYaOdT2PcvspEkbeWAyn4OLZaqvT
	7ccpunjlJGCcZsDy2YPo5LXTHcAvnlSemDfoyM3hetpfEvVxZ4OYNcAT/ayr9SSQchacFEMeOTD32
	IMi5KjY2cCG4TRe9y2am3D9b4yZS+sxfOgiyP7McNGhi2VGUMOUyQY6po7OsayDR+drnAG+RJYLMv
	TlQxvK4XmaA5w6tAxLtnTGRqfFoGHp5rjVo7hjchOt6Ab86KH9l0On1bYZSJt7sCmGselpNQNT8h/
	ITpJa6NQ==;
Received: from [187.36.208.132] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wn2bF-003dqX-03; Fri, 24 Jul 2026 01:13:09 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Linmao Li <lilinmao@kylinos.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Eric Anholt <eric@anholt.net>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Shut down BO cache timer before teardown
Date: Thu, 23 Jul 2026 20:12:41 -0300
Message-ID: <178484835832.1636116.12347863223467970899.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720084426.1632508-1-lilinmao@kylinos.cn>
References: <20260720084426.1632508-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 20 Jul 2026 16:44:26 +0800, Linmao Li wrote:
> The BO cache timer callback schedules time_work, and time_work can rearm
> the timer through vc4_bo_cache_free_old().
> 
> vc4_bo_cache_destroy() deletes the timer and then cancels the work, which
> does not break that cycle: the work being cancelled can rearm the timer,
> and the timer then queues work again after teardown.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Shut down BO cache timer before teardown
      commit: 6273dd3ffb54ec581855b82ae77331b66028249c

Best regards,
- Maíra
