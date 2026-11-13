Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567809;
	b=H27ias0vrybOnTwc6UoujCi8Y5OgJtXu6ndjqhaiGY8/MhLGmR4sO4oWdopfXxIU/rRy
	 FFeSVF0a7ZHvcCUyhEAIIB1oYndh0lJy9AxQvCbCWILmb4yuwGY4egGQk52HyrkBG3O8D
	 GCv0G0DRoooe32cVwvX6LTKDhe1SZ9cR0bDwbVaxwR6qj+XRUSvFvsGDBya4qzIhjFQgO
	 yiqMnWAJQhdxhMWrIjnc5bZD3nIkKDF5+Rxtbal6uk4S1lZT7jC8vYV8UC3jCg8p9OGiI
	 MP3+/M0qSlQ7VhNV76EqIW0nvXRodZpN3uunJifCoMMtN3iIJIn6trsmmXNIgZ9tWGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567809;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=JkgcBvHLw8XuW8lXs8VPQO5ok/ct2EC2baRzv8N75107DNyR8RlEkFkpyBYu3dvMVQD0
	 XSkyQcYSYRLDFZeyA0NxdY3WaGuH/TnTk4oWMToo6q4XQ3mZk1s6Rv07Cx3D+F8Sjo3Nd
	 NfQE37+SqBYO8CJO42hwPE+v22ArZy9bMebpmP2F9DWhA0UysD58RN/JnhqVRq09HSWeR
	 Hvfar+Hyo9dTyn/RPmjMpC2nVIDu1xZ74C1h7OIClSWlqZpaXKkHNOtTmcz7emZbf8A49
	 GV0PJD1FYlOauobivHRi82jre1bY3cOQj21WLplgLEgbdjFgqCCDRUARrpr8x+bvjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOJotKJN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559E606A331;
	Fri, 13 Nov 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOJotKJN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B87A1F000CA;
	Fri, 13 Nov 2026 11:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567809;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOJotKJNM0NKD61qcP3wy6h4ZFy3nfecxTTzqxrrvpo8JEhjT+9xJELRreKFj5g+n
	 Jar6SBPZknEnYlVxXfpeQshnwky1vfwycx3I4XPf3CN6G9+8c0YSk+G5q/bp39eHrE
	 FCcafHeVdHdrZHKNUGfaXnjI4A73RNJ4YbFDRUmbvAV64j/r+xOg2VrZI1i5RqxJP1
	 13W7Kr4v7hanyZI7YLaxXJ27ssK5r75A4Mh77roFf9ppcijqjfWYdEyUk+l05DsEUt
	 maIxAB/geMsRV+AiKbVj3qg6+QS4XnO5NKsu5Dd6gIsJ1rjwbITXgwgj1iWI3D45Go
	 +QqO6RfU1KTwQ==
From: netdev-bot+sinfo@kernel.org
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
Date: Fri, 13 Nov 2026 11:03:28 +0000
Message-ID: <179456780803.2168702.14752754098228150172@kernel.org>
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
