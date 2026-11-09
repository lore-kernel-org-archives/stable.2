Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239634;
	b=IUWJiWk8wx9gl4lqNzVd06IeXflGJzB67Zx1oBSLJuVRXpYs8dyjM7CwetLsofgQvxRC
	 t1DBM8/4lpT769rw7fCTyyj+8zFvAmTlejTPEcHjuSdzbpO2IZdezQaXe3gm0snBl+i9e
	 O82vf8QipeLE1VtQFE4jOV+Ad7+R02X0IyMmNfxLiYlv3agr2dOa4hhiONLQAH6upWQCu
	 PDZryPXB8UBjmKN7zpmREk0PRkKnMsAWH4SBdUbR+aKbnWD31nHz/82oHABXRNOUoZsDp
	 Q4HJ9Ym32wu5++44UcjwVAzfI7DvQAOAaWn0ek+L4r379NVt7xDoSnWX6Z69FCm5bXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XnLx/Qlx7u7a7vMMV/KyUdGoxmG7ztqnTPAnuSWO/SY=;
	b=ZPIxZ6Ih4JwmXvL7covgUsfysE2rlMLkCTbDZf272rRSunaz+zL6H1GuJDOpheD9i3Bh
	 2EjouIIuNqvwgNvsQ2csxkjN0I2EkzPZKi3ND1Rh87gUJ/XswO1KX/Lfh1MWhfRdEAHCq
	 ALe3h1hiyZnotemBgc7CBcO6oNZYwQNEvpp3p9yRPkWdJdMmjk1IDgwOsm5CDlH/RssYq
	 G21t8PWRAE9ouWcifYNCBlnP0f8EgPkmBGM356KDI68WncA1DDLAiwyftQDUtULqcHsuX
	 BJf73o0ICaNiGGU4QPPMUAkwtmJAeBduyJ0+4nFMZzJone8eYF216HNP09q9itQPMpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcC3wVFH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0D606EE93
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcC3wVFH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B118D1F008A1;
	Mon,  9 Nov 2026 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239634;
	bh=XnLx/Qlx7u7a7vMMV/KyUdGoxmG7ztqnTPAnuSWO/SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EcC3wVFHUwA5txLEiXOHs/XjWoyFOjD+Qcu/lGIv8C8ouaN7CN1LFnNKF9X3sa0Zf
	 F0G75Y7m96kXojLINCFpCfJRbms2FoGTATFCvVgn3SIS4lc4GgzqxuRfaBj5TEJbLS
	 TrY2mMAl3r6zqbkHsEcpBfYY9T69kBsUhkn6/ANi6/fpzuOOv0UV9oTboR6NXYYBDU
	 TRs/apyRprQum9wB7Io0TznSK7Ls2hHbiqRd7jjsVzrjaQptpm6Ml6f29ZIULPywx4
	 8Lg1KadP9gFWC1U+9m6yrtnvs6+eX5nX6MnGKbJzKJN42ljVUJ0EefMUODaZOphSsw
	 TrvlBxN2YYwPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Sean Baggaley <me@drinkybird.net>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
Date: Mon,  9 Nov 2026 10:53:10 -0500
Message-ID: <2026-11-09-1-daily-reply-0028-uvc-gc515-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109093309.2401998-1-ribalda@chromium.org>
References: <20261109093309.2401998-1-ribalda@chromium.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
