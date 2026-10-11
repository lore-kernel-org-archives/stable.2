Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE72C08D0;
	Sun, 11 Oct 2026 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737327; cv=none; b=ZjSEWW+DGOtpp/V9daQOYFpa0LS7I/25r3pXAmhRXIu46HYPcM+7JFxiSRYgdYph2v1J5gJRoKEKrLenrdmCNw7K5vZTzQGxdMGt3RXWmoMGopdIC/zLYc9uJBKMl+i2txOL/zpR/1ITruSVWxUHIo8bM2Gdb8Pwkm/GCltjSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737327; c=relaxed/simple;
	bh=6M943Zyjqp3tlty3iCnM1Aj6QjSsHFayXxNvDzTc+g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d48wV3AkoMHDXfX4VMJWnHgI+eyMPLFlyWGjAEXoO1z3bGYi9gR/YDt0ritFZxI6Pk13ecOeJX6DlM6q8i5FyBtLK5Bpof4a7fvN+u/jEgcc9+20Ggd1mWj6qLjqS4YGLawcVLOSVY+vSM51uCI378Y0dDX8MfFgsSI/n+pL/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahs1FBLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahs1FBLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC39F1F0089C;
	Sun, 11 Oct 2026 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737326;
	bh=xGegb5Ng499wgNrgppeFLcY2MCpJ7L6+lwe0tFDn820=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ahs1FBLyoneKSrrJ6vYNs97stm5nGQauk5SV8oFSjrNB4sxzVgOlwSP4uK3nC1uYk
	 NHTJGp0u3STa9nftpXWMTRew8mrOhd8/FNIPJlkWW5vZY1b5HcwIgw6w5Q1GNyY74g
	 ndya6MeDhlsYUeOgu4G+3qHxJ4sa+cNZb/vyspT4HrSGIsDQ5apMGGikq5vNKSY/2+
	 d1FpuFwf8NgC7hbGsRNulxaLZGcMZ3Fs0MZ3HNnAlkbNsWRFCso4e+CmC+PGTcTT9w
	 F8czswMEGMpwTjUlUwncpIqGErryS+GfiM15OLufvvEAOB7+FMQxa6UhTQ//ii7mgO
	 Sfg2E7UD5WefQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.12.y] wifi: ath12k: fix reusing m3 memory
Date: Sun, 11 Oct 2026 12:48:22 -0400
Message-ID: <2026-10-11-1-daily-reply-0015-ath12k-m3-reuse-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010051129.14918-1-artem@trailofbits.com>
References: <20261010051129.14918-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> During firmware recovery or suspend/resume, m3 memory could be reused if
> the size of the new m3 binary is equal to or less than that of the
> existing memory. There will be issues for the latter case, since

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
