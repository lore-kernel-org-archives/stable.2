Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87D244667;
	Tue,  9 Jun 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966330; cv=none; b=rsKIvIfPo1LEh2Uzk1v8aNqOm0fLXhmFTDTVifsi41EHp5N3SWMsQHO1jzraSztqu6HW/UBVJkhh3JmqZ0LD5gmFL5U+UQxBiDtOJr/5qUovMI9V/0p2qaolKzlFWAiSIuviFMxIqKtqmuH5VrA5bMRDG9yGAiUm8yAJdwRyIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966330; c=relaxed/simple;
	bh=AbC1Os04RepBBGA9/+97KeZpEtlWpGcLAskcgsY0LUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F61kYZ3+XV0pjKDRmvFNqenT+lP0j7z+ekrY8iUYUt/0r3AAgS91CVfovi+CUNDSu16nb1haJutqAArwISDcwNHbLYfOTDuJnTaSM5pnIObTV7mGcR0gcNN9tQhUjgUpLHb4adkLZ1VjgWyT2cr8y6/aSJkpnkZphpwKGKFwY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnHb4HEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnHb4HEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE11F00893;
	Tue,  9 Jun 2026 00:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966329;
	bh=AbC1Os04RepBBGA9/+97KeZpEtlWpGcLAskcgsY0LUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VnHb4HEbpeYop2++BVhPZ2cEwb2uDwy2BvNTQmDttICoRXBwLySE5hVCno0hVBHCL
	 yF436ulK3n6fxAihqgHC9+JkDsSeRxlmBk7EXrNxEpnXZhIDHbY6sp7E3N1tkyG2UL
	 xiv0642RtsMOI04CAc0TDoSAlWSpWI4jbUY3Hj/eDwB0bmKC5ZICIxymxiH0stTMo1
	 46x/N5P6Io5ee38RzBvVsrPFNEmt02RNyszL7NJ4wIfIfBkQYpnDMxy7ntCSTSYD7g
	 HMoj9RvhSDxIAN/r2LEQCrAP9s7jCvbmvVoHaIYSgv8WqGPJnQr0To1txlvM5JBGNR
	 aEhy4UFWq2Rhw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [linux-5.10.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Mon,  8 Jun 2026 20:51:48 -0400
Message-ID: <20260608-stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608100236.2781796-1-lee@kernel.org>
References: <20260608100236.2781796-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [linux-5.10.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
> [linux-5.10.y 2/3] HID: pass the buffer size to hid_report_raw_event
> [linux-5.10.y 3/3] HID: core: Fix size_t specifier in hid_report_raw_event()

Whole series queued for 5.10, thanks.

--
Thanks,
Sasha
