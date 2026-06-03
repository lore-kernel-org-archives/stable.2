Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5F3D16F0
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499699; cv=none; b=on+sO26UP34rQ1U3EXzZX7JUS++fA7/4WXB7pa895bnB1aywnPLqRP2LGAUCZDNCmLs1BF7Od+XVaC4oUb0CHvLNKH4dmCdy5L5TlMT/utEGqwoTA0Ve0sW2gLdUXloNVTXz9eGbaoWypsX4eGFUpK4cWTMFVl1NHzTd/DKKxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499699; c=relaxed/simple;
	bh=nmGuDndhrJHC1tBBSRkUzs1VRlHE/0D1x/0iu8ZZ7YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chPfIDN6/z/ZuAPuUHmzUun9Den4L7sAxw4l6DKQ18mdTV+GUH+ysovrH3ObPOfCgTlzxD1ps0ZnpEa4XuqZp5jg0XLN0VPZswH94mU2MU+EwC0IHlT/CnSXvHxxJnGGvVH6/xln/fgo9xSFW5h8rvbUklnoyFapNYzipg/QBh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSKFgMzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSKFgMzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E131F00893;
	Wed,  3 Jun 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499698;
	bh=cGCh73sD5XhczmoBgU0Na/+4pkgXrZL7jqTEQPxZqG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSKFgMzMrq8fv6XKZWGMur+2ITTmPH4dymM4YUehvia/SwBMCnVkqhj0J08+lEv8N
	 kwxsMU0oRpXCsw88CugY9+48eaie8vVAQRng9rWKvGTRekdrNVZ1WB7YXeObKtEreF
	 KILSV7K+CKvpq0bbRy3McrufdN6TTVxwK5aMEzfw1nTrk4gVAqoqQY8zOEBwJQUWvy
	 ggi1xxUlorgQOzA8ZZYgcCZXFh46I9yHH9BIy/0FPihZJY+/yv+CNpdpDSbhtYgxC+
	 1SCzx/MNkYjZ+OiXzpVLXwY7yTWVvO7DuvjAdrM2F0HwemTyL5Xz+BO+9ir8O5FaUt
	 uGptWY36FIiyA==
From: Sasha Levin <sashal@kernel.org>
To: Li Wang <li.wang@windriver.com>
Cc: Sasha Levin <sashal@kernel.org>,
	mikhail.v.gavrilov@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: clear page->private in free_pages_prepare()
Date: Wed,  3 Jun 2026 11:14:24 -0400
Message-ID: <20260603151458.2404783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529050231.1849697-1-li.wang@windriver.com>
References: <20260529050231.1849697-1-li.wang@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.12.y, 6.6.y, and 6.1.y, thanks.

-- 
Thanks,
Sasha
