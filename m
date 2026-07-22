Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8972701BB
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681653; cv=none; b=TPGiopdFmEhpCOoKY89bXzTe9L+4s+TI906R+hq4CUornLi4XcvumJYGWUN8vCKC/1pfccKheKj/LlJVuXAQSyxN1wWSYmENJxh81bBC2s0REY2gohyXKdx6B+2Xpa+t7l63Tx6RsRFT8HiTHShpxqJ5kthKdekgpE3LmqO/T2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681653; c=relaxed/simple;
	bh=4rjzCf5SQTrB6MFQBsyt9leXfYGat/rJi1DgXc44nE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X33nTaazZhKvl9D7g6Z4NxvJBCioooI3pi2g22jnkURvWFV0wvDcAAcIoMSWS7f+2t9Bi/rEoWvBQ2LVWLZG/NZ8rdU3t3UKRZc8evSvV8eXOJigfYHRSDiGTWr3LSuNogWb22OuehHs7RvAn4xlX3SabcGA8raM1oVxs9PGgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbYp3AiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbYp3AiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22BE1F00A3E;
	Wed, 22 Jul 2026 00:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681648;
	bh=6nf9C+uVw5CobUsB5NQ23s1R6opOqq6onDUjcJOqYq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UbYp3AiDx0+9qOfrnfiZAEpU6a8r8ySMcS4JZQDA6lhyPa2W8MjJuN9hZj0/j9ast
	 R9ZEkpMYU9lVpSLWQ80j5/XqXNGXeo6aGge6rCwr9RoBEIkEQrn9haNv6xT7E60FnB
	 tFiSg3Ek2V5I6p1io+VFw6RJ/VkRScVEncbv0MoEPhWS4PxEVh49ZJkBfhKyjq4St+
	 ekBAbuNmOVrkHQXowt7YkD7vrnaaFpaGUJ/lk2W766dndVSs6P2o3ah6o9oYKXCey/
	 EvEajwtcI2UoAHSvplXGSvYkSmrq/2WT3qIVYo8iYrCx5eNiZNXsCxoGWZbFL7ovPt
	 sCdOw3XCqn93Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 6.6.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Date: Tue, 21 Jul 2026 20:53:54 -0400
Message-ID: <20260721201114.0007-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721150727.46546-2-weiguixiong@bytedance.com>
References: <20260721150727.46546-2-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 6b63520ed14b17bbe9c2103debbd2152dde1fba3 upstream.
>
> When the last CPU of a legacy uncore die goes offline,
> uncore_freq_remove_die_entry() clears control_cpu. During CPU hotplug
> re-add, uncore_freq_add_entry() still populates sysfs attributes before
> assigning the new control CPU.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
