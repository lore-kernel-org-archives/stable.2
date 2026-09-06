Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CCA3603D3
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701607; cv=none; b=uIOhmCuRERBX45yWUwBMeONCvFUZht5eoQl8mbpE1iJM+L7IGYrMkX7t9hXLmQaLYEJK5UJLwqGaQJeULNI8qYdHDl7zdI6T3JoxdYjnfEYCsndPXdXi0FoDN8XMn5L06WQavQJKrqh9kPlGOorbH7eEEYTYbm5P+ywsghj2Ao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701607; c=relaxed/simple;
	bh=cOs8/NOoRvXbIxS78c3xYjfHsEYBCmhw3FG1x55cmew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXttP1rZX9YFRHvy/xIttOXatwxZewrSHeVKofxh1v4rEiz5wTIta1Jb3RuhI9FZ3Mg2Q5QeUBjkzDH3zz3rFIu8HqpGiUUAJX1r56FqhpZK8FwBi9cM1HME4AQuG8/VYfxCOBhkGi/oZLxIrG+Ezxu4qEZGCwsCD9OnZo++Dyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfamMpCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfamMpCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7319C1F00A3A;
	Sun,  6 Sep 2026 13:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701606;
	bh=+HnOf04lAg34+y2nbEAaUwVSTqN24QXw4EKTvbN+wCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WfamMpCNnM7T9JvVx7cuXhna7YK54cDyO/kzQovDNfFhKeibOD7PxAg3D9/boGyK7
	 45bEHtb6u/UNwrz1z2HHad+sNKIey+soegFRVbaViaCGNB3JJ91OtAsYo8Xj9e7RJD
	 QxMqrLOiYAuofiybJItFPGJHckkimv6L1dTqFF9dY2+VwkmFO6GmSAjWmAVWmydK+n
	 +FUVSm8k7hpeivwfkFKQVRrsAU05LHpm7Y0MyfPd4rRKFXqCxRxUNYoMkgDWz/a7Wl
	 9QF9njRwUyZRJ00puoH1eQ/LriU4ZdFqEkRjL6sH/tgCmtRjvIW712ryqzSEV8eJTr
	 ZFTcmv2TFGf8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sonali Pradhan <sonalipradhan@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.10.y] usb: gadget: u_audio: Fix use-after-free on sound card disconnect
Date: Sun,  6 Sep 2026 09:32:31 -0400
Message-ID: <2026-09-05-daily-reply-0001-usb-gadget-uaudio-uaf-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904094052.592539-1-sonalipradhan@google.com>
References: <20260904094052.592539-1-sonalipradhan@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> g_audio_cleanup() invokes snd_card_free_when_closed() to initiate sound
> card teardown and immediately frees the underlying struct snd_uac_chip
> context. However, snd_card_free_when_closed() returns asynchronously
> while ALSA control elements (kctls) remain open in userspace.
>
> When userspace control applications access or close these open file

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
