Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D82433031
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892178; cv=none; b=dF0p8CsSLp6huErKDXp0OkAq+QnQY8lPJoEpzF/vdNvcyG0yWiL/GHc+w8X74RylMPhkn0orJr7iAfmklB4SyNJPEO5Utl5yXnRay1pNNuz18ZTnmeBejtgdP89GLqlSdxTnRukNC7MkVS/BJQhG1g9CDxyIdzg2VNvjo+rfuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892178; c=relaxed/simple;
	bh=isQ/DTs1wrXPn5ukxxeV12InceUd0aBlalIVVwfckJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojOzqfn5TG0ZxwPGI5ewS67GXfN9cMxI/VxSt3oW7eV1zx7+8FC3bcjxAKrmm2oNMUc7Mc+qDOkQ0HpRhwoqDE/oOsAd1axTl6HH0PiNtjGoQbFDZv9KYsyD2f8D5Spwj1S2kyR4D4uVDnEqEsRYDn1Dfm7oz/7JrVjLyJra9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs8uu2v0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs8uu2v0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EDE1F00ACA;
	Fri, 24 Jul 2026 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892177;
	bh=b2ChDeTWk9k1gotyBZYVXeXrVcn397IPBVrQvrYL3PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vs8uu2v0NQpBnc76WaSKYGmfcR/ik/PjOUw9SccZFpz3xXZ55KqJ8vRacI83CwpTF
	 qOtGR7U3ejaAMx2qdt2kpigCdHfwc77lYh8douRTe8BJYNQHoWJNAi5teFd5E98///
	 pe9G58qAXeLyY3IjXKwOIzeU1wCSzJPhyvhhwsqYGEjC7qtm9mgtY9jWgt/empc5wz
	 uwv6C5ABKYoE9cfKm8Ef3Bmfnxr05b2jIap8/H2Ehh7iKAETUD529ytAVEccqnT1VO
	 5EENsfGslvsWou3VJXKyjxbWXrnDklg23lzvOQ0GbkO4/8fqt/JDZOY3/WOxre5HN8
	 VTAywGvRYnM+Q==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	include@grrlz.net
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 5.10.y] cpu: hotplug: Bound hotplug states sysfs output
Date: Fri, 24 Jul 2026 07:22:42 -0400
Message-ID: <20260724105500.stable-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87pl0ekgxw.ffs@fw13>
References: <87pl0ekgxw.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> states_show() adds CPU hotplug state names into a single sysfs buffer
> using sprintf(). With enough registered states, this can write past the
> end of the PAGE_SIZE buffer.
>
> Use sysfs_emit_at() so output is bounded.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
