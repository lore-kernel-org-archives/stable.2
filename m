Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFA4071CA;
	Fri,  5 Jun 2026 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688262; cv=none; b=C3qc73QZk9kg5WgHGzS92o9sxGtGJ/M5D66u6a1zqaNLhrP0eyU5KaHKCGFa3EvsrdLvsvKNb4J2sleGFqgm+mJDppWlQ1B7bk5X3lwXbMJdH5B8P/VrRYlQHZZxyxx5JxUZD/hylJ8f5r51y6clhkMPugolxH8NuOTJRz9BS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688262; c=relaxed/simple;
	bh=NLhWP60H0zsmKTwGweEq5AmV2FkY28Im9xbKoYjcdXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWb2Bg2SSz7p2f1pLq3ShEkyJ0HaaDLV+De4b4kSHeu2k91/9A1dJIUqOzBFcfg4Rj4xkQQyNQR0cm7svRHR692CCjf0y3KnVxjkDypPqz9eSXAyKPSVFDdadPyUCBpAM7djjo7/x5VuKaiw2JSvedqlg1Yr3m3/y3962ICFlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItFq8cco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItFq8cco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D937E1F00899;
	Fri,  5 Jun 2026 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688261;
	bh=H57hTL7cicJxLbyAuR8jC+VpeYQ3rhrMDw5nCOGDdBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ItFq8ccoQ1KPs/vFdyuKadGIlyepcmoviQUFW2wgQ7du0zoDh0WLTXBNA4x4cWNJA
	 kw4WxGzshpAn/PcjqtOlAh2qlpsC+mhBwTQ1sQM/Cz/clXbb28lj6wqlRhlOOJoJS6
	 zg3LM4XCWIXyfnC8SaNwG4e83xTwDsoS5LaDpgYuJlOeopXtYr6cEY2OmcIzopOzem
	 ccM2SdYXxArychBvCPRPDFSvygkHRIMhhgVtLe/B0oS3MBQ8oFJ9FbjClzkQT5tUNg
	 PSmk8LKPNt+rbofBNkFJ+zW1xfDdHyT8PncCif6VqZP5Asv9uBVi9YV+9pt4sb49mz
	 vxBgUu/O5yY+w==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
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
Subject: Re: [linux-6.1.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Fri,  5 Jun 2026 15:37:13 -0400
Message-ID: <20260605-stable-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603163022.3301081-1-lee@kernel.org>
References: <20260603163022.3301081-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [linux-6.1.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc

Whole series queued for 6.1.y, thanks.

-- 
Thanks,
Sasha
