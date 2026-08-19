Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE937DAAE
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110359; cv=none; b=iMRNy/cwpsI2t6dcFd05kLqLAAXORekLa9rTvbmcvxllSHqU2wwmYn8l//5LaoFR/AHas5KDZokNj6ZyhM2mpU+1EEB5milsrdlwjoHpd/9roWflK5YCuZ1mgzrSm2h1sTfVzcGa+Mr51L9IcmZ9rSYHgFLYrbwlyfqaa9e6e2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110359; c=relaxed/simple;
	bh=w4I/EaB0wP/EtoxsVEyikD+reWRh+7r7Mz2oH2hQt1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB7EWAuo/35T+Er4CO8TbT4OnmmR/QEwgZZBn3Nf/NiUBFB4BgF+/BlyCknGBhkR08Jr0UsBfdUjU8kkBMboULjsDRg4Y7JeBbkGjezlG2iZ7SqCbTGZlDGJOr7fl93DvmnRD4R9jiFt6wj94NBGCmWSVOm/rkUmYni48GM0Dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHlXsgLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHlXsgLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673F51F00A3D;
	Wed, 19 Aug 2026 03:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110358;
	bh=tp0it+XWiaZ6w3eQJ9fgoLXEtR7RSnkmQ7yewturaj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHlXsgLWZGUUSj/IZ4a7do6QOWkksP6E1dGwHwCtq3YkuvLKvcju43UeCzHPNzAE7
	 XgnKwrOPFKJcC7CdUVsk4AYLTzRdrQuUHPUmiB87sGQBZNsiqjR/Vd6/5vk+i5bNV0
	 QxxzW2npFJVj6s4pAe2CMde6y5YEIEktJxHeZ11GEFzHk+J5sPoAN9g9TG3b60OTG1
	 Po/y/YnPcXnnSSJMJGWRhnQPJnY2s91IWCArBbej0iD+9vvitu9QHT2dpjb3l6/pdq
	 hOtJlr/U0nCJScO1vLkeHJkOnH7t4GUIhOQS7owzC6J/coFfv9B0Wkb0uhVORp1vv3
	 wP2O0okfAkXmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	jianxin.pan@amlogic.com,
	tuan.zhang@amlogic.com,
	JY <JY.Ho@mediatek.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Subject: Re: [PATCH 6.1.y] f2fs: fix UAF issue in f2fs_merge_page_bio()
Date: Tue, 18 Aug 2026 23:32:20 -0400
Message-ID: <20260818220420.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818-origin-linux-6-1-y-v1-1-95a5d1026e99@amlogic.com>
References: <20260818-origin-linux-6-1-y-v1-1-95a5d1026e99@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 07:36:33PM +0800, Jiucheng Xu wrote:
> [PATCH 6.1.y] f2fs: fix UAF issue in f2fs_merge_page_bio()

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
