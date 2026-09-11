Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9845D93F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125712; cv=none; b=eHSnmN33sEa5Gc21qohbKGmMoPeqsmxfZ3c90pfYdGcVmJar7PKmDKu5MmEazrZW9i3gEee2gwedA6fNSO+c+LzADRkyJQUCxfYH7WadfoxAgeCbdqN/oCZAY+BzPkWoapS/zaFNvCTD3JDVoBtfur6ezVQPog8DpJ9LcXooCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125712; c=relaxed/simple;
	bh=sdZ4cppu7uRxfHhFMSyX5nDYUTKDYUt92S2bt3KI7o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1WelTLcMPRCOeazAPRETXbd1IznK/t4QacZBZxWV9Juf5jvYodbwRonc96g2+lCuWtA2w2pErau1MvAQPePpfqNs0rTXZxZLa7ilwYUr3USyrUBApmllMVGBZ/eANB+xhokKsATOuGySk/pCVyeL1gIJECJjSBQqYeErHwgsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W75Dtn9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W75Dtn9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2E51F00899;
	Fri, 11 Sep 2026 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125703;
	bh=zaTf682oTGDei3Yihlo8BAefcy2u70k3i5Ry44tt+tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W75Dtn9GOlPCtRJkDcKJneynIdH2fc6bmXiPOpvpCHMEh8o2Ni2tNzgVJkaN4KtJZ
	 ZFxLi3icOR3+jchNqjWTSNWBwmzGqTjd/CKjg+E1kjRiHn07N9kBYAhanncE3UAL7D
	 DT1dt+ZHGHQungu11x0HTtehwANxXanf7TNHVSytjxZbLoNXgVFK5mBFIFOViDngZe
	 UQhs/g5yiEjohyp0ngXwKrFJBmLS+J3wQY82//UTtXe1k1Ya1HQN0ga4N5dPkzw/UA
	 VDZy4pbxD/zdRpnuko9sEiT+rjc0hydEmgalSmoWDRTrfbN+tUgME2VJdxkDuNq2X0
	 GEAJYXonmxRtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	boddah8794@gmail.com,
	heikki.krogerus@linux.intel.com,
	Huang Wei <huangwei@kylinos.cn>
Subject: Re: [PATCH 6.6.y] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion
Date: Fri, 11 Sep 2026 07:21:04 -0400
Message-ID: <daily-reply-0045-re-usb-ucsi-timeout-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910013650.2945842-1-huangwei@kylinos.cn>
References: <20260910013650.2945842-1-huangwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit eb4573cf2fd860b20adfae050c3f6ec6ddc3abdb upstream.
>
> The synchronous command completion path in ucsi_acpi_sync_write()
> hardcodes a 5 second (5 * HZ) timeout when waiting for the PPM to
> signal command completion via ACPI notification.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
