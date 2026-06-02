Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D98391844
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424508; cv=none; b=hvsXPZe9BolywTkLFoxZb3RCDpHxHfoc2qVsOzOR8yzSxhPZUbmwk+BpMMFiZRE45qXRtehxEbDPxrDsoMCneqtRxVa31h4KbBrKVhGa6Ci3bdqpmmryBDHsd0QOXX/LcNakuTAKs/3DxL1apvVIPUXt3XCD7CjVB9nTpxj7uyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424508; c=relaxed/simple;
	bh=sqdMMtbY/26Ox2S6GXMK2cy1LPLrxXhmCSEHrefBhbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsmLma9Uk1PfhSrUgzFIiRMyZZAFy20EpIC0OR7CbnwkHcruJ9IERZAji4guXF+59s4ocB3HEbQsHu1pj4QAhYXa039ndIZQYhSz8ZQXYtRkFtTcTHZvEDL1+SyEvLZ1U8ACPrXs6gNhGOScj8GAesQYJNzLEhTHuj4Uzm8tUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofujh7yz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofujh7yz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AFF1F0089A;
	Tue,  2 Jun 2026 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424504;
	bh=79x/bdmRuLluYzncV824n3s3KlSyYxd6NcKkgpckguA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofujh7yzAqQnwZXJPK237kfZ/iQSy5ISS4hIYMFe3/dFSkcshdg+eiAmomanS/OA5
	 6hZXvUzIurueNNxTGAnZeHvmyCLSjyzIKBneFqGUNnbBThyinU9xI13FFOWMQo1KXQ
	 proHp1KNPl1MmzqmFm1x7xnIJTMZmXCS0rpnHFiJZe/Rw3pGaJoS05CN1VBng6wysL
	 A0yTKMxIj5fVMyKDpKNpZ87lia/yuGNqQIRRHhqdYj0VAKfSedMAEp5F7KEk3MNdi8
	 wp0RGn8MSB/eJZDnEqjzJmFepSRUcrMz8K+m0Jnu70XV3/xR/CblYzqxZMwS9sWuv9
	 yj5UfWJsVFdoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Iago Toral Quiroga <itoral@igalia.com>,
	kernel-dev@igalia.com
Subject: Re: [PATCH 6.12.y 1/2] drm/v3d: Fix use-after-free of CPU job query arrays on error path
Date: Tue,  2 Jun 2026 14:21:22 -0400
Message-ID: <20260602180900.drm-v3d-uaf-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531210323.1637818-1-mcanal@igalia.com>
References: <20260531210323.1637818-1-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, May 31, 2026 at 06:02:01PM -0300, Maíra Canal wrote:
> [PATCH 6.12.y 1/2] drm/v3d: Fix use-after-free of CPU job query arrays on error path
> [PATCH 6.12.y 2/2] drm/v3d: Release indirect CSD GEM reference on CPU job free

Both patches now applied to 6.12.y.

-- 
Thanks,
Sasha
