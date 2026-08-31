Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5DC33B6F4;
	Mon, 31 Aug 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176619; cv=none; b=VazG00Hz9Ko50bcUPNFOnbj9BEz708R/OgMek1AY7LR4N1Lr1l2sLYXZ3+c5j/UlmjthMCv8GiqdnqU/jG+9oRrMJCyIsyJO2gk5wovShbytTiE7qKB75eM1eL3s4EahUlbxJ0M5HR5D1ED61G6MWVOeu44i49Gqv2boeIN6TLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176619; c=relaxed/simple;
	bh=eRmGFqQhNZJrwpJfXQD0DqODrtGYYbk45RD7WOz/Wvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/J+XRV9l+6tyDJ/zyxl5GVK+0EknUYDONs6ykVyck6IpVelGfB/vDAlfIi4GxpMaCZRO3+WcIasBWLtpvqjpA6sR3OVSMp/cirBMI5VSQ/BoLKnEIJF7pGwJwLN/DXkseCR62mIuta2dAAxrxymDvfp7F8HQ3TlPVBiPI87Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ce97ZOnP; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ce97ZOnP"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bf55f638;
	Mon, 31 Aug 2026 19:38:18 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Keke Li <keke.li@amlogic.com>
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: platform: c3-isp: Register IRQ after video state init
Date: Mon, 31 Aug 2026 19:38:10 +0800
Message-Id: <20260831113810.2945667-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f3592219-2634-47b3-ba39-d1fb1a8bd2a2@amlogic.com>
References: <20260830143945.2700038-1-runyu.xiao@seu.edu.cn> <f3592219-2634-47b3-ba39-d1fb1a8bd2a2@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0579cf28f03a1kunm10ab55af13357d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTk1DVkgaT01NSxlKHhhMT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=ce97ZOnPq2WBC2ZeS9l4iRS0+ZIWiNm/9IZi4pHnwramVmjHJBRCtdZcXLaldE4Vsz1atb2LX4KdHppfh3WJmn6hcVNi9o8drg/LxIgtbB3J0pVc53SNf8CO1nEqBG0BMUMM3VehbJFEslqHaRZUdXpdv2mPn0d5aPhM+eOmljU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=eRmGFqQhNZJrwpJfXQD0DqODrtGYYbk45RD7WOz/Wvc=;
	h=date:mime-version:subject:message-id:from;

Hi Keke,

Thanks for reviewing this.

On Mon, 31 Aug 2026 10:44:18 +0800, Keke Li wrote:
> No nee to reorder c3_isp_videos_register and devm_request_irq.
>
> The ISP is inactive during probe, so there are no spurious interrpts.

You are right. Since the C3 ISP is inactive during probe, the interrupt
race described in the patch is not reachable, and reordering
c3_isp_videos_register() and devm_request_irq() is unnecessary.

Please consider this patch withdrawn. I will not send a v2.

Thanks,
Runyu
