Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A7B25B0B3
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681653; cv=none; b=QxXszbZuqVATXh1ZvglUN0jzZVWErbyb1I59aOtwX4gl2Mdz6ILjxT2ziiefm0yWewOi7yQwkAZ+ifCNol0Q4W5u7C33IMW9JQZ5yo0GxZJAQPP3K4gJT2cGr57/i0OHmpCQ/uK/Pp1f38PmsuwqV3IP8hO5a3sFDqtBmWTI9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681653; c=relaxed/simple;
	bh=CluwFtEK3yIc/ZHCr9wIl/d5Pt+ctweIi7FmaiP2irU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMRqu1VbhtwP+RsOjNGszywk7medzf2utjwq816A5/hPMsJUpk8BwB04TCLFJpYou//TDfOrezNc/Ak8b4iXYq44PI87z0Szn3rp6HPmuZxtSGt9oeuZd8WPHeduIUtN9uXyUm3DOdpsXrT/vRL2guDtWN+tzGY71/VH+e8RL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRrwcTuU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRrwcTuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F04B1F00AC4;
	Wed, 22 Jul 2026 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681649;
	bh=+ucToEj62EiBk2+9qeeT9iSvoVEjHS6a8PRkDfqIo0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MRrwcTuUK1/vvMpc5o1brZdqS5CgZ3cmQzrvD+MZdOSQxaQk1ijm4u8KvM+7RpFSC
	 puHGWXLSLWn2jhwRdjoVPfdNhksO8WsA2vmA4YFszrkMjef5y3r1eC7K/xFWliUjxs
	 NKmBorAEel/0OjKHN7WcOIk+dpR1b18jrrOlLfCmRPHDMqUNwhw1FB7bmXljvKqKrD
	 YsGNmj8e65lczpQH70YVtrReIJXdSTnsqprNhR5chzmU17fU7PivOsa7B/E88vDiap
	 fUBghDYQCXJ9IR+bUt2g7+t+i8s7s5uLRPtgQ2TeeJiHkS73c1ehSAMw5MhVO/rba+
	 cBRMbXQC9dukQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 6.1.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Date: Tue, 21 Jul 2026 20:53:55 -0400
Message-ID: <20260721201114.0008-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721150714.46115-2-weiguixiong@bytedance.com>
References: <20260721150714.46115-2-weiguixiong@bytedance.com>
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

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
