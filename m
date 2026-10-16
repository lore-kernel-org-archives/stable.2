Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34583282F34;
	Fri, 16 Oct 2026 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139312; cv=none; b=PfoeAgLk5xvaJLTY5lldhCv5Tbqk1tjChViapJqVTSccP9VluvYUAT17E9BujogRUP1XQ90QOHKZaVXHraU1mq+/aKEG/zfv6xHGVy5rn+oCCzmj6DcPR7oIs8p3IyT/m4wz2EjK3W7wpbeHUiZu3EVf16pjN3XPQAbuWthvAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139312; c=relaxed/simple;
	bh=3wMVz18CvrpRNpz+OHMctqlWDO8P3IjqRkVEctI1b8U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gW6FhOkkPlHVbjizic1vWAjP/iu11amV5TcQkT0asUdtzWXFPQiNHUyMAl6b+CHLibsGFF/biJHWgJIA8zDdzCVt+KmXoJhMwP/AQwjsLN5XAaaeoJ1U/6/+muB51qiunQg0Z6ox0paEQCtx89PWv9Dz8TBRqVUTEk5WU0aUWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAoJ9rbA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAoJ9rbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A49B1F000C4;
	Fri, 16 Oct 2026 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792139309;
	bh=7WDR+rdKTl59Dod7usiiWa4AJjr/kGpBwC1IgsMYd3U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=IAoJ9rbA2BdTq0GWzOTVilGUqG2NP4pRQchlWbOAPr+VPfPEmZ7RIGTeZvXw1URWK
	 f3GIVjWVD0p97hfOTG+DOwlrLMiP5CjYIJkjQTFKrCA8mbADoxk2hcs73ZNHl+HFEl
	 J7e4oiow5Y0TKAUF94dS74qk0MgSsplOz6f4j3yiP5j1MNtbiY5xCFsLmUJm66dnKf
	 JgMqxQSJNJyfVIs2eCPnTwi8sZfCmwD2UO49uKREclf35cz3WZxtOkvageA+Of0aTR
	 NB3qfGH+ZVGr0qtylZyFenhXC9cEj6rPpAwV3sjHWc4IF8UFk1o8IS3rIf5dig2Nq0
	 14E0JR6RcrmBg==
Date: Fri, 16 Oct 2026 10:28:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
cc: lee@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
    stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>
Subject: Re: [PATCH 1/2 RESEND] HID: wacom: Write shared touch initial status
 only once
In-Reply-To: <20261007220027.6449-1-ping.cheng@wacom.com>
Message-ID: <0600r14r-s811-2s61-46np-97r1973qp1n7@xreary.bet>
References: <20261007220027.6449-1-ping.cheng@wacom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 Oct 2026, Ping Cheng wrote:

> From: Ping Cheng <ping.cheng@wacom.com>
> 
> For consistency with how the shared has_mute_touch_switch is handled
> during registration, let's apply WRITE_ONCE to is_touch_on too.
> 
> Cc: stable@vger.kernel.org
> Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
> Reviewed-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
> Note: no code change. Just commit comments and code comments change to the existing patchset

I have applied both patches to hid.git#for-7.4/wacom, thanks.

Please, for upcoming submissions, fix your workflow -- 1/2 and 2/2 have 
been sent completely separately without being properly threaded (no 
References: nor In-Reply-To: header).

Thanks,

-- 
Jiri Kosina
SUSE Labs

