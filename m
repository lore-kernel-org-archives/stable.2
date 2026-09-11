Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822C32824B;
	Fri, 11 Sep 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135482; cv=none; b=uUBC+TANGLK0z2154ub/hDvlQ38x1toJIa21KQx5YscV2FRb+mqvUH1LroSohN6Ony9NjXQYLJaAZee9GSwXNLgWliHfRtj6UzMtC77wdzyMr1EWEL0IHlkyHk4ZHzWWo4pXi4MuvqTfpkmVRl2wtz4dPsnvRwLmL9CUPMGAjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135482; c=relaxed/simple;
	bh=q02BnkdO2sJh/ZuZC/YhgRkZFmAF8Ri3Yezw+KMdQis=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h0h/ekTNMoGxKK2jNH+0rbxVAkL2Qest/YCtKhQB6wEeP4Q2bHh9Ia2ETVbwafFWUgWM+lPlvneOi85NDdMi6lmpw1g1dmGBCTPvF8aJBq/e2Pj97DjTkv3kyJiht4CPOirMH2fonLDcfAucLa8tYqV4suaBA/59lGLJBeBOCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIuFda5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIuFda5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B39B1F000FF;
	Fri, 11 Sep 2026 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135479;
	bh=LcihR+7fa3+RNgDoK8hekhRM6EZ1Upp/g6TmCKw6W6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=VIuFda5XsswclV0akZUYoWQ5Uil3X1Su6revQjWIAI28Ui6lLMXa6JNDTxHsS56b3
	 dh5qnrqapTkFWN+qW3w8/VcvrVVAOO+BaGLb+P5dT3harEz2q298zO8Os0s4FYJGut
	 0lcvQXcDYF08B/TvxCeP0xhegNZ9IHptw0YqelUWYWv//dEvqO7Fy2aWAHvAbFVx6E
	 KCOmu2sK/yUHb+C0l/UiN1hpr8sTP7XRL6jRbQVPUxWyjbPi+bGc1nWfTuCOkrwU5a
	 cjAIqUHODtjFF2ki/U0vKMQ3fl8VgHmle+GXeKgZDG1QOt4kYf5lImDuBAfbYT8LqU
	 EhSZmfkUKSa4g==
Date: Fri, 11 Sep 2026 16:04:37 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Aaron Skomra <aaron.skomra@wacom.com>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v10 1/5] HID: wacom: Use hdev->product in
 wacom_setup_touch_input_capabilities
In-Reply-To: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
Message-ID: <04rr7548-rq65-487p-10o5-1n148rnq0or3@xreary.bet>
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Sep 2026, Lee Jones wrote:

> Replace the lookup-dependent 'wacom_wac->shared->touch->product' references
> with 'hdev->product' inside wacom_setup_touch_input_capabilities() since
> 'hdev' is already available (via container_of) and represents the touch
> device itself.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

