Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238742BC48
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074373; cv=none; b=KgwQB8izqT4OnjWkmd+gZPlbIxATq0vixK1BkpZj66QhaROTXQNyEByC9mWGi7/6FxYGofDFpBexVe8WxT9qkWyMbdGdIpdrxapTAtZN9bYDJ55lTokakVKuUM/4s3O12wr1TB9WUNHWinXALcX3FB9KTfwD8ybDj4WOTPusYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074373; c=relaxed/simple;
	bh=n4Ekerv6SdJQbYQSuW0KmBkOOZ37I8x/SFXdKhsEdHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7vOqo0mgm5RW9aEDDMmoRg6VT7urynxXJHRmCPAOV8tpNp9HhrCLnTBGkuT/MvJ6roWmblUOMoHys/dG0JG9EnrPe9ipD0/HLHgeyoIXVoxMqBrOl4Ihrw1Gm8CyrcniUOD6Yz2sBhQO//OJHFypSj4k+Igbii2RNLXfoZdI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yat/kOHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yat/kOHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732381F00A3E;
	Wed, 15 Jul 2026 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074372;
	bh=Hsw4LO4/Ge7HJDdrhIGWxxwGd+XcFY0tj4W0k18Cayc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yat/kOHb+jO9VhSkyFY3UpFvAzW8VsKSke5eRb6jIRp0ZY99D6wvCDW3ekOYBFh8Q
	 8LHTAu5c6XEbp+LuHqTbzQ4gmFh8T/VNuTuikCxWgHZXNcht+dUXnDm1dck3Wtu9ig
	 iy9D2kl5KCwaC9z3wHEohfiCwWCDQomaTHYq5/i7ckI/BZHGvnMER8HfYW4eIZ2/fw
	 dN+HBppbZV5wHYCQuEcL82oEeJeEPRWAYzYLDVsCO9qnLnGTLWXdEtXSvrVYgJwApQ
	 akKDPN/v2LkMh6H62JLwAUJ/fwn8flHmrKI50RgeTksH9RDq5vf8ElVV+/wYDQu/IE
	 LbYytD5inws9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5.10.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Tue, 14 Jul 2026 20:12:36 -0400
Message-ID: <20260714200600.stable0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713151613.93022-1-liviu.stan@analog.com>
References: <20260713151613.93022-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Initialize n_wires = 2 to match the binding default and ensure the
> rotation check fires correctly when the property is absent.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
