Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3B37DAAE
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110358; cv=none; b=bMVmbM5o7ZXqkrFDFbr4GcORS9tb4X+R7Olss4tYeqiUlocZ0sjUXlMW5nefnXMDXGu5ebW1xDJoRgBzeAcXXNJhhTOp7jBZpMWXe+dRc1sQ0rkEZFOmpSuwZkeFS6gB7yezjuZtCRmsETPJylJeT5G/s/WGBxus3xfwRfRSilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110358; c=relaxed/simple;
	bh=4tVNtaXAgkHbeUifPdQDfIuPAT5YtqVy4aNMfRH1lGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBTQ1ZAgoekQ8pBfvN3jF2EDudK/eK5pvGCxmlR3koHyxm2PwnguQakKCTaW5tPeY15kqlfuIIHOYcX/YUfKKK/wjCzaTlibJQ0JyBJYDrG0NEuQNLBMHcG99ByY00haNIda/dTfolFJ+ky6OEy0nsfbKK4LT4b8sg/tnqZhgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8LxrgSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8LxrgSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A351F000E9;
	Wed, 19 Aug 2026 03:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110357;
	bh=KvbMNQBze8kO8fOPvwV7nXBKASE3oqjIk5XsCO2mASU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8LxrgSQj+rTOPsywROp4dhiyPpFpiC0TwEwEct9fMYiQJZUb9y80j9h++q7rDeHB
	 5WivZ4wpaweq9yVjz2TTAYShSlo0W8+2tKgq2K0X4wZk9Dg2GWWxvnSYeZJ0RvyLf9
	 vFSCoGm082eB1arA99CwMd2uwdqJS5T5pUQhMDiM6eWngB15Xr+q2ldEIa7WIPsUbb
	 OfCWb4iUT5+jtD2YfQrzuJXYPHrlznvNtgqO/+bktBPYXK7Lg65oNCHVmET47ka5vR
	 7qhx72BdPyl4/EWoUIv9QXnRkHHXXFTeXJYgrmlg2U8+4radsm6Kk80G/yfwgsm5sc
	 aw7Qn2cRwWM9g==
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
Subject: Re: [PATCH 6.6.y] f2fs: fix UAF issue in f2fs_merge_page_bio()
Date: Tue, 18 Aug 2026 23:32:19 -0400
Message-ID: <20260818220420.5@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818-origin-linux-6-6-y-v1-1-c110e632c7c4@amlogic.com>
References: <20260818-origin-linux-6-6-y-v1-1-c110e632c7c4@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 07:28:34PM +0800, Jiucheng Xu wrote:
> [PATCH 6.6.y] f2fs: fix UAF issue in f2fs_merge_page_bio()

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
