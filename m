Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3CA560ADF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996812; cv=none; b=Vci+VSaiV1hcYc5s+UlEJ6xEniseQtzX5C6JZhVomKb6aIW5pEiUsTcgtgBPTpxetSBTPdFqHF2k6L0yiArFgs5cOxXNpr0YW7TR18HkT0aq3vF/drmjibCUdHuOXB4S7cEE4wnZnKG6cS98p8qjZMTuO+Kh0X5/y1PKIN8PbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996812; c=relaxed/simple;
	bh=1YzNU20o0kBiUEgd2gsMyK1rw0/RTh/v1XFFTEq/Bf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzEPr5aE1o6VZ8Is4ibIJcgesqQdu9rK0dHjIGlgqfd60LFViKNttSJdNxxUhyEI/SLxZzX0ijDMng3OBhzP/XI/ITDDBtRoTSMxDoCgZCTEAL4vuM1AGnwgRq1TAJyd5hx9r/QS26UfuDzl2dncy05fsrpEmQjUaThjW7KGcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9HJQeqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9HJQeqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B711F000C8;
	Wed, 14 Oct 2026 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996811;
	bh=+CWNQJpHQCJUSgMGRmMe5GH5iX2sc/PN0ZRPGva5dgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l9HJQeqjGNoGmkT2EqDzUmioriFt+HAchBcXbok4jM+QTc2koxsO9udVMKhYwOulR
	 iTvB+0/OsmH1RfQ9Zdz7owee5d1O3yi90Z0B5hvs2c59gif6RYZO8pAAXcTO1nOyA9
	 b7uDFKoRZV6TneJHwzH0RUBKHZf+f7sIPFZuF9Ulq1vWXBDjSWIbSxxWj8wNxVefbf
	 WYK7ytWRXeE41e55pgWZ/eOhpwK5Op478A5nat0rUMm1skZz5WyGXcyfGtwdMTqkE6
	 N2AYNG2lC5pwa/bS9IUogLSXjL+KVS5cij/54Ae9UHbqQaJxnzvokwNYj1vcK1lpnh
	 /TqjsKJrpbdxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lorenz Bauer <lorenz.bauer@antithesis.com>
Subject: Re: Request for backport: "drm/amd: Create a device link between APU display and XHCI devices" to 6.18.y
Date: Wed, 14 Oct 2026 12:53:13 -0400
Message-ID: <2026-10-14-1-daily-reply-0010-amdgpu-xhci-device-link-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANo-qm0u0NegPA7x_ymsLeC7f+v-nR8w9BEQTndvVbetYtUmUw@mail.gmail.com>
References: <CANo-qm0u0NegPA7x_ymsLeC7f+v-nR8w9BEQTndvVbetYtUmUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please backport
>
>    07c93d7eeb0d990bc1b8e3b1eafa464bc9feee97 ("drm/amd: Create a device
> link between APU display and XHCI devices")
>
> to 6.18.y.

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
