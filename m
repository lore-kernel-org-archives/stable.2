Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C746DFEA
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016213; cv=none; b=CHUIQG9wxBU0jAD9D+7Mx9P9CkLi0u6W3Krcoq2ckKcMf59o+gzkH1KQgaElJRUzd/yYHOt8otk5bMQ1Oy4HVll6Y25r+NIAPICe9cy/Tt5kJtC7orcwssaSVsJKVqnlx5b3b9aQffWcQbngk6qulyMNtJi+grtWhTyuYlvV0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016213; c=relaxed/simple;
	bh=XjOFsG7i0RG/9CcPbUeTXbDK3GhrjSKCK8JlzzkDcK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K63mjSYY3dx9RXAHt5zIIZX1PERxeMFbw41zuBuRBWFdm28Oe8XdbZRriIwEOzPIi6AcsV54xBoD2XJztLIuV13D503mdcspiIrBrOSQ5iC52jKA8a2Z7DJjlSy6YZxDfaglVYAh26ffpZ4gk+h++oQMcWjM5sdrfcu//h/zkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWwh0MeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWwh0MeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F7D1F00ADB;
	Thu,  6 Aug 2026 11:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016195;
	bh=oD1rfj38xbUazSnNmwhfqCwT2upOAgzZ96pD1+wtRiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VWwh0MeLVHdWTkEgI/FPSzTyMvDogBvVQR82owuFKbI/wH0wsrcWAXgN87CjCydsM
	 PS4Il36A29WQUJo5z/iyiWvjMtsLLvtDJbW3vn0SBxYPv55riPD0yhcN8/QZEZedMA
	 tNL8NuAunSvJSQy7n3c3cGrdNdfDN1+uBY26Y4r47HFnPY70jrI6evyNlXLgKKVHV6
	 2F3f+BOmuWbsb6xdmiitrZBHFTPV1/cxCpuFlx6rKXS106jwh4mdfrFlL+fnLVMIgW
	 ibXpCzkIzeqb2E5yMEUWbaNyLCG6kFthD1SNAVVg8Hn0X8ueDh0JgKi1jD+rjO326U
	 X4FK5tNihfA5w==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 6.18.y v3 0/8] Backport fixes for handshake
Date: Thu,  6 Aug 2026 07:36:06 -0400
Message-ID: <20260806021809.0013-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805173958.660310-1-guanwentao@uniontech.com>
References: <20260805173958.660310-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 01:39:50AM +0800, Wentao Guan wrote:
> changelog v3:
> Add ("net/handshake: Drain pending requests at net namespace exit") as it also
> a fix now has been applyed in v7.0.12 in same serie. Build tested in my config.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
