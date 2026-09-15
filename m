Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC43D1CB0
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437831; cv=none; b=mc7GbaNqOo29nVnMB/eBD+qk3QZlz3f4swDcmM2IK0yJ5cmBMlhnFx8XQqz9W4kx+NFqLB86aR7KF37rPbEUSPw6raplvKYTGjNAPqXtEmQDJ8/9HOKQMfhXyvadIK7fPNyPcDBUbMS5EXg8EaHMXa7EjYhuS+XMu+/mxTFhZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437831; c=relaxed/simple;
	bh=WOZSbR7t3xq9lZvNQNRKllJu9VSvQkF2wvX+zt24eHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckvy6jvWMV0u9N6gurNjios5VpmxywewLMfeVXzZljoAbJ6Y6uLLdywq+G8+gR+//TwejQfPK+cOPz+X220wHBENFI4tKc2Y1PIEnzzSizjZ8wNylbgGDfD173Te8AS+trwjmB/kq3Jj9rCCJ6lTkjfnx2wtIZ5gqRH6PzHzC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJMHeIP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJMHeIP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B68F1F00893;
	Tue, 15 Sep 2026 02:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437830;
	bh=ugKhROXtqN46cWUD7MPMMYkJ5vmwHkr7W0HWw6nEXes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GJMHeIP1LW40Hdxx+VKpUKAn1UoI8I9JS6c7o7DIMK74veHmogYARQXT92Ab4kQsS
	 2Zi8Z2ma0vo9Emd8GX0tkgzJYmyrWT8tf9fccSS0Ms3AS4J/z1ozhJspvMGDFxX0yI
	 3tSkxGD7wqh7B4b/lYKe/uWiwiFZnnCGVLMcSodKSGwbt5pa4fayilhjF+92htnyEP
	 pMjkEfP3CG0kPrjt6JhfKyQzd0Exgs/BnmEnVwWpt7Rmnwh0fv+gAMjCHyD4dYqjPo
	 ZFa/105+kUirdAR5TJNpZlMzrV9d5jghkWa5HL4jpbnpRMKJmz9INsnes/FdIg9563
	 T/fTutBeg1q/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: Please consider post-v7.1 CVE fixes for 6.1.y, 6.6.y, 6.12.y, and 6.18.y
Date: Mon, 14 Sep 2026 22:03:27 -0400
Message-ID: <daily-reply-0011-re-cve-batch-post-v7-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914055341.86197-1-artem@trailofbits.com>
References: <20260914055341.86197-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please queue these commits for the trees shown?

Queued for 6.18, 6.12, 6.6 and 6.1 as requested, with one exception.

7dc3680b7ffe ("drm/vc4: hvs/v3d: Fix null dereference in unbind") is queued for
6.18 and 6.12 but not for 6.6 or 6.1. The NULL it guards against only appears
once 013d382d11a2 ("drm/vc4: Call drm_atomic_helper_shutdown() at shutdown
time") is in the tree, and that one is absent from both. On 6.6 and 6.1
dev_get_drvdata(master) equals data on every path, so the patch changes nothing
there.

Everything else on the list is queued.

-- 
Thanks,
Sasha
