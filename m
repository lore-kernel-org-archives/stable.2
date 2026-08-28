Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F23BBFD5;
	Fri, 28 Aug 2026 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899292; cv=none; b=B6zmAhoRwSVGpWJ4us8+SQr0t6EFmdQ3mIa16QKXIWSRZ+UkdZrXjHO0alev/4+fzRnFBY4izJBTq/AbJoKGaQxxSSJ/XCoh+7SXIiMXL999rle3bu/hPsbOJZl6GqtgqjNbEOdX3GqGHd/LBaAXt4odQYhHGX9xKOU1/tBsSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899292; c=relaxed/simple;
	bh=zMnPNn4Hc4KINM99e8qivNlT2h4/NeqNfOYIVzuLNTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQbs316Soo08FeqxTelqE4n8lMBGxqAqsVHFmyiflt48z21ovAoCAoL/UeJAPbE9dBqgqgFg7YfL3u3So7hRRoLYvl2CNUmuleXeiHlLgyxOxXERS/RpzRFL/k1LlNbnZNSSybj3lgCUKqJr+IvHfYYtXSBYKodDGaGG+68gH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4baa740a5;
	Fri, 28 Aug 2026 14:41:25 +0800 (GMT+08:00)
From: Haoming Gao <Naixumogu@whut.edu.cn>
To: Greg KH <greg@kroah.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] accel/rocket: Validate BO handle counts on job submission
Date: Fri, 28 Aug 2026 14:41:13 +0800
Message-ID: <20260828064113.37390-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082816-regular-doze-e442@gregkh>
References: <20260828061916.20405-1-Naixumogu@whut.edu.cn> <20260828061916.20405-2-Naixumogu@whut.edu.cn> <2026082816-regular-doze-e442@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0471a0f7203a1kunm5a7f65548c238
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEwdVh1MQ0hJQx8YSR5PQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
	pVSktLVUtZBg++

Thanks for pointing this out.

My real name is Haoming Gao. I have corrected the author identity and
Signed-off-by tags and will resend the series as v5.

Regards,
Haoming Gao
