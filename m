Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7544C67C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125713; cv=none; b=NTDXMEiRTaC1hmWpQIlnSlr2TYUmovx/9UlSDUraxrLUADaRp6KagTwN7lqnyCwkhzem/L4ljOpgVXaRr09gq4/Yd9K7ZWcaUWzoFFkV+qcS/Lu75uZj1ZwNQ1EmyUFUcWmTFK3B8O9F+cyDTuDyTp2JJshkrfwLwh47cSrP/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125713; c=relaxed/simple;
	bh=0QY7iQLdmGIYAhtI12gRI1/gqN3POLEG/rFYacf4htg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDVb5aZoUZpp6nYAEouxY/x6laQgHM8QM+FPBV2qUv2QYL9G/RZnCD4KTFFhZBZHE58wrJjP3aYx7/9eap2KkbT4mg55vNpiLkJj6LMJKILse9o2zRiWFL2/tN9PnN0ZZ51oHqaugO5cranhTIWGjAVd9qlk/PIlqqVzYHiZldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWpPKJn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWpPKJn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC501F0089D;
	Fri, 11 Sep 2026 11:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125701;
	bh=MceJ8b+DU1N6Y8pBINf9tJ4WlHXA7FMN51UBMlEObrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWpPKJn4agbr7W2rS0OHaJfQrf1Hz7lc0HoSDKJiCmrcklrd2ghb06F3lVwjXXXZU
	 u1US/K8Z9kydTXz/Ad3JFMb2YK7VW2dX53smdPAAMuTLweaEpAFir5vMevMmJ7oj9s
	 fyztpXwIUM/bWLf8KCQnoz/zbPko82CccgdnQf8UWWMOkB0N8+WODi/3yoBSBIEFBY
	 ogwOs46WAebe/EC7cT6xM9wk+hbRnaC9bvT2CrJT6zwizBAqaxDHJXpyVwUouph3ca
	 ugVN0NB8jC9V7fKpCspauAxRprfUIolrcYqe2i/qOrUvKDZOH3C7szrC4NTVulBmjc
	 wBR82lUQrmaxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	alexander.deucher@amd.com,
	mario.limonciello@amd.com,
	superm1@kernel.org,
	Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: Re: [PATCH 7.2.y] drm/amd/display: Scale custom brightness curve from full range
Date: Fri, 11 Sep 2026 07:21:01 -0400
Message-ID: <daily-reply-0042-re-amd-display-curve-scale-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909152520.83763-1-zhitaevakh@gmail.com>
References: <20260909152520.83763-1-zhitaevakh@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Custom brightness curves use an 8-bit input signal.  After exporting
> the full PWM range to userspace, the curve normalizer still divides
> requests by the physical PWM span.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
