Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF73403F8
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176701; cv=none; b=Ei1Ai0rVvKMabJaqLl78bXmLsM74fK4ViSwHisM0okde31Fxo4tp6XZDVPOr/j6pbXlv3Y3KO9Pw+/MyWIjGmo+rhfdijMOlj9ABkcF63qXrRG7YrlHkDb1CVmzySVmns4tzuHmDkqQVZoYkxUQ4ESZyZqeWoaUlGG0Ksyu1HRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176701; c=relaxed/simple;
	bh=jOEkL57D7GmVGcg4MCm8P07NV255ENdXsrLq28X4Qow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIjda8OTs/Nkjvq0+JaKmxfgqhl1CmEa+Dypi5LQV7PCrCgBZjWuPjMLMrEvOEdk3TCp8Fld5pTUVNJ5jNa9KuDCPSeT4EbOdJgZnlROuNXSaD8jqva8ctG1C4R4mYWkY3fVJUGSMSltPCGJ93ptYyCJg2G9HUnw/rHPpeIZBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=lNetTemS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YIRfOz19; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lNetTemS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YIRfOz19"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 303F01D0013D;
	Mon, 31 Aug 2026 07:44:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 07:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788176699; x=1788263099; bh=qIU6KNpBMJ
	WZpOGA9f3fyl/Lievn/MCLs7IQyiqycj8=; b=lNetTemS1EaaovYKWQOj+zIyvU
	ubqfExndddux+DN6M4hn4hpwriMWrfgMyjjTtNmaaeb2Pc59KWW0duyL07dEyera
	yE3xhk8Ifg5AafDE16ZNpeRCxOervavajd8nvQTb53xA8QSRZYTWi+fO0JZ0yXjB
	EeeTps3Ww+WBPi01itXLiMF0/i7uKbG/EufINSltTb6B0OLOHRGORnR6fe3PsSo/
	eCqlBxbPLMqjVN1FRg9jC+oYo6sGFvfvX83X4VeEXixPTaHxtZ8G+wBsfrMPpAOS
	TDn+DxbKAwkpm95i2x+swtx/hHQF+fCJtcnvbYDxQ44rsW48V+TNRqtv05WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788176699; x=1788263099; bh=qIU6KNpBMJWZpOGA9f3fyl/Lievn/MCLs7I
	Qyiqycj8=; b=YIRfOz19wJsx8PjKlPzAqhOvYev2+pMxV+HLTuj1hvKoIw/F9Gp
	QkqSOmc6URiKEThU7XB4ytJotTd4CqFcnE5whrsJJfDk5OkgJuPrLCv/7lYOu8Kl
	gAH+Qm4Cc9hJRdgz5mgR2587D7JRoPny32syklik9+rRg5pQSmsZmDJvRkbvXwqL
	7BadW6ip6yFB9SzLhPQVAnXdD33fHw5owptehw8FCarSnCMNqCyBtbKFUVhhofZx
	EquOyetl+OowuCfV7m9pRX9KgkMIFKsYdsSucN4cAfQO30fY9nFC4fCZGoklhAwD
	dWCFBmvc65U24rxuqst77RnIAk8RWwquUSw==
X-ME-Sender: <xms:OmmVai_Gb0_5sZhmeJinOhnRy9mGHVCcmGOYM0BMJ9koZcVthx7p3A>
    <xme:OmmVasu54ij5utfTN8Kt3k0yowi_DQjjIxtf9uNMA8kXHk2qFcK_8kvlsBvH5Q6UF
    i4drxyyi4Ted8pQx6m5LJs-QGGuCeGICG0lm0X3uZV7VkHGDLA>
X-ME-Received: <xmr:OmmVauoL2JQ-WGlB64dqDoVNh_NtErX6SG7PAKo8YyuLvE5ZjckWB9hWG_2BUUzi9eJZK1VoSsdK3BQPngBVwTRyC63fwd4OtSFIBapiqF4>
X-ME-Proxy-Cause: dmFkZTEYQTCJO2JWq+U125EA5/WeNZaDY5W1/ZVofuEuwx7HAiDKthyiWwf6+EQ0mmiqsi
    ubLjR9hjMNCmez42+EkNy4LyqMmlco8CCoZ/+lw7OzSf3b9ncX7eCed7drOeQE6NRn/kYG
    8mWP4m3Y34I4HtAV9SBzr29khSDINmwt9T7kWvXQSGHChJsJuW648ArjBWLyLHwjLinMXV
    +wDRTHHrj3KnSjDLRVjHRsV7F2FXMGch4KwAqzpCsukuYnbeqwh44sulqDdEeY3nqFFr7W
    mEWDTO4+pVluMb3+dVOAXw8fLlHiGxP8TZfhKNlkuSLG0LCKUTtFBqlv8I7ieUlTHqQWHp
    nqvqHmoa04sox24FO4wM929xkt8d2/2ddfL8FVWuKhe6Nbo5JWEQd+KdcvcVNJe8tctMLi
    cJLzfdIn66ugHQCsC2ZClv9ZGrRSUVxBgfFQzLDNxZuWW+MOZnl2e21lHFEnObdYFzCG0O
    im8bO219MPQve+3rw05/tOz/HdLhlxGxuApn+srtpD+UwlHGjurMlxbWmLciOW/9EVwco1
    YlAwaOxU1YO4chPK5dpVGjiEv4zqgbVVgY8xzwqZvl8u8e04VwYZnVYnTTDkw27uplpCFT
    xyYMX6uk2HUzDqJG77Jjr1lE7Z05DPZ83XKOqP7jWyNYZ34dZPAoVhmaeI4g
X-ME-Proxy: <xmx:OmmVaopMIUOQmTv_gbmEWiEhJANDG1PCewCq5Q_BvUYLX0LkNWQFSw>
    <xmx:OmmValbj7D0jEyW7cPLxXZzguNaH1Qiskfbil_dSHUArErGli66CBQ>
    <xmx:OmmVau_vF4zMvvQGqa38eSABDPjXUouurhSG_SlguTMErOz-CBI7lg>
    <xmx:OmmVarm3MyEhCkLjTNORD5KCGQuLG2WNwtYo3yats8NruMWCJgkLxQ>
    <xmx:O2mVajfCEtRSsX8Up0YwFmkrLlmPtUa0E7y5kROdnxiDdvH5jt0FK_JV>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 07:44:58 -0400 (EDT)
Date: Mon, 31 Aug 2026 13:44:55 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Lucas Zampieri <lcasmz54@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 6.18.y 2/3] HID: input: Introduce struct hid_battery and
 refactor battery code
Message-ID: <2026083135-exchange-unengaged-14e1@gregkh>
References: <2026082541-tightwad-rinsing-012b@gregkh>
 <20260826171414.2246040-1-sashal@kernel.org>
 <20260826171414.2246040-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826171414.2246040-2-sashal@kernel.org>

On Wed, Aug 26, 2026 at 01:14:13PM -0400, Sasha Levin wrote:
> From: Lucas Zampieri <lcasmz54@gmail.com>
> 
> [ Upstream commit 7a3ac62473f2bd213557e41aaab7a8f144037dfd ]
> 
> Introduce struct hid_battery to encapsulate individual battery state,
> preparing for future multi-battery support.
> 
> The new structure contains all battery-related fields previously stored
> directly in hid_device (capacity, min, max, report_type, report_id,
> charge_status, etc.). The hid_device->battery pointer type changes from
> struct power_supply* to struct hid_battery*, and all battery functions
> are refactored accordingly.
> 
> A hid_get_battery() helper is added for external drivers, with
> hid-apple.c and hid-magicmouse.c updated to use the new API. The
> hid-input-test.c KUnit tests are also updated for the new structure.
> 
> No functional changes for single-battery devices.
> 
> Signed-off-by: Lucas Zampieri <lcasmz54@gmail.com>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> Stable-dep-of: d07644524b65 ("HID: input: read battery capacity from its actual report offset")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Does not apply :(
