Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982969;
	b=cKBwOuvHOdfFit3KA1X9VpL/HvBbEWNH5mh5AbLItNlfphxYWzh3i4R9ewP8B3qbk2g6
	 aiP02zPfrZ8X2H1U3UEuiwR510v4LjSRCcf2PONRyV+RrXco0/4JDSNC+OjJFrA2UYDVN
	 6Ceby8+GAly0w1BMPJXMZwQ3D+MUCIoAz5ctETlSeUGt6EJY+VaGnu0JxzxU/QeX3Kl3Z
	 Rbh9+4nf2rIp2g/ooLfH4bQT5+0OcNNDiutP8hmocHhkBeXjLskMoz07naAhaLeA+TuGm
	 LN8e+hwYXjo3Nw7I0sQFCKTGymfaS6fQuoawyEHpaH47AIBochE9xA/r2EbOWKcsnXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U8pLwdBHjGgkVA5afjjneYz6Dlzd6Ty07xbMRu7DXxM=;
	b=FwIaHqi1PxtWWZpph+qVUPYZmfO7ySDsDPA7eTRIkE3PZoEdUYLcO31MbAXrxN1GIdT7
	 dZFWV3vNOT8TmYKCiyOX606QHfv2S93Fyo6yo6e3MuVPWoGmtcxuWAphkoP5CE8KFuXHX
	 ZmSc7CD2JN9q2VHYZGKH/U4RVm88R93n5djY+gTFrSkU7AgxYI6pbO49LXjW5eN+qmz9/
	 V3EvvVdCr/EvIvZveW9LiZiRojnxC5eiqJeOCUu02L5gJFsuezM0w1HmYtt6AVUYt6e9J
	 DPdOAwp6UyS5UxrLK1FSv7RzMPkZQtMHscNDUggwtqWj0DSP0yeFiww6tw6zDbneNtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6+7eQpk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6B606A338;
	Fri,  6 Nov 2026 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6+7eQpk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BFF1F008A1;
	Fri,  6 Nov 2026 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982969;
	bh=U8pLwdBHjGgkVA5afjjneYz6Dlzd6Ty07xbMRu7DXxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6+7eQpkHzA/GnqnyKReO9whEYykUdkCs3AH73zt4ZUOLuc5iVlfNgxZ/NWQVCIa4
	 J5iLkbyd6vANBrQ995+K9K9M4rK5XSAMn6+OVwonmb+a2zeiERPtCB6tIOQX3ql7Lj
	 EjzCvVI4Mw1gfWC0v3DScHjQaMQ3k9JWsBNKEJLh7aeb3Zx3YbHi5BOBxFMhLOLPTv
	 4ducG3pvGmHaZoGbtDjPl0Qia8Zbb9SUkIygCgsQOTmqclaFWNxAVNZXoODp8kiaDi
	 AiICLyitbqAfA/Mvf+6fxEFd+7yA/UwahK+I0Xq6IAJoWMtQDV71L09on5/uD+deLh
	 8y3mVPhdYUH9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Honglei Huang <honghuan@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Trace <tracekotae@gmail.com>
Subject: Re: [REGRESSION 6.18.y] Please backport 342981fff328 ("drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages")
Date: Fri,  6 Nov 2026 11:35:47 -0500
Message-ID: <2026-11-06-1-daily-reply-0012-amdgpu-hmm-retry@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105192503.228363-1-tracekotae@gmail.com>
References: <20261105192503.228363-1-tracekotae@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> please consider upstream commit 342981fff328 ("drm/amdgpu: drop retry loop
> in amdgpu_hmm_range_get_pages") for 6.18.y, 6.12.y and 6.6.y.

Queued for 6.18 and 6.12, thanks. 6.6 does not have the -EBUSY to -EAGAIN
translation in amdgpu_hmm_range_get_pages() and the surrounding code differs,
so it would need its own backport.

-- 
Thanks,
Sasha
