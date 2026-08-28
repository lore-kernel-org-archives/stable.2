Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903C364942;
	Fri, 28 Aug 2026 05:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895194; cv=none; b=q/aP6SjAPLX3VIY1yzpQ4MpdzICaD141rPT73fPFi3tVDIagdGs2HZquWk43TCY1PrkFqL0x2hh37lEZImdbuemEtA7QhWTHqO6LoHjUKYadrVTMA2vKhp8RJRtPMbYojXQ8aOmN9mPQ5Xrt+ELaYw1/m095pCSrIIZlVYHKyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895194; c=relaxed/simple;
	bh=TNEI57j5yfn7kUiHWO2J1lhElVnPTJhu8Nr48AtDoj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4NIL83sgaZqDYkaWvC9uQOeCXFutgCd7zEVkgYLGez3cDb+NGFrY0CGYz7xjCzXAEkzcvZ7LBE8cRsu9uxM+Ud2e95uzaJcbg2W4rU1ul39C2lRtGC4P4xXN/WCJvpcLVC/cmNTyU8AmzObeJzWShsh8cyRPdoH05DNJqyEpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ba7c9837;
	Fri, 28 Aug 2026 13:33:06 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] accel/rocket: Validate BO handle counts on job submission
Date: Fri, 28 Aug 2026 13:32:33 +0800
Message-ID: <20260828053233.52725-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <apDpz4j2y2_8_pOd@rock-5b-plus>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn> <20260827170608.39511-2-Naixumogu@whut.edu.cn> <apDpz4j2y2_8_pOd@rock-5b-plus>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa046db832403a1kunmd795ce9a893f3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEhPVh8ZGk5NSh1OTkIZTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

Thanks, that makes sense.

The two individual checks still need to happen before
drm_gem_objects_lookup(), because its count argument is int. For the
combined count, changing bo_count in rocket_job_push() from u32 to int
makes check_add_overflow() reject sums above INT_MAX before the count is
passed to the reservation helpers.

I addressed this in v3:
https://lore.kernel.org/r/20260828050805.38548-2-Naixumogu@whut.edu.cn

Regards,
MoGGuU
