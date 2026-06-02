Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2C39184C;
	Tue,  2 Jun 2026 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424504; cv=none; b=aTnoQu6t+zxRhsPMfiump0Z/IrR7rL1Qa3RvfatUL0GNVunA2mCQVhJ8fdZTlxDx1VskG3pvuiMvhEKnU4uilGdPa74bw8y64ohJzQ00ia81zVi+9znmFjPneeQooE+Y1TIIm2QJZhhcvk7Rweyob644hPZ0Rr8LF4MYco4hm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424504; c=relaxed/simple;
	bh=8ytOHlLqGjw8D/71xahC8oDz2wv2y5Lsxg55xpfbd6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn1aVK2RyfrXRJ2RC1HGHF1tPYEKMP9ZndSOv0rtWEIZpELupztSOphc40dODR1yUE7dduGqzM39sP6NvjsyP/MFu4y0AKA5OCLigYuCb9sY4pzNEoi/Mwgbu4jPqgUAaqoeVccXxwIxb8Mlf+Sj4BQB4el8L4HhYDzzwCBlXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MivB+XLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MivB+XLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30DD1F00899;
	Tue,  2 Jun 2026 18:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424502;
	bh=b+ThjlcJjpLxxMSne/TmFnpLJdJaPgKpkVosByRLWi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MivB+XLK5N4S55oTvZt5EaXMm2e2lVGBQFrevRgbEvHxpRHKSFNSZ1EdrD1tCxfnR
	 Ih0YZ0VmdFC3gn6eJ2OdrAkJB5G/j54Ecw0QmhROAiAd2KQeVwSc/zwmAI0x+hX9Ta
	 y5f+KocjaygiPBuwXRT58S+u1EsWR0P7QlCJ6Tm5CvgVHlL+dFOM7CVCalVVrNCSrB
	 hYitwVNDbKAtQMvrEHZBB3jDd2j+IE5800akRhjjoVQoz2paI+HeEB2poZCLYeIDLb
	 N0/IWiA7JzbOloauZSoc12CGcK3Iyl0K/BuVSFKsuWrW95CPakjdqVQx+ofcOyvsHI
	 eInCIM7xwCkiw==
From: Sasha Levin <sashal@kernel.org>
To: Nick <nick@kousu.ca>,
	John Veness <john-linux@pelago.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org,
	johannes.goede@oss.qualcomm.com,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
Date: Tue,  2 Jun 2026 14:21:20 -0400
Message-ID: <20260602180900.acpi-toshiba-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJZ5v0hR2b81+0FWAn3s_HJNWwweRSVk35KczPBKNabb-H91kg@mail.gmail.com>
References: <E2OXET.4X5GTP37VTNC3@kousu.ca> <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com> <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk> <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com> <75398536-2ca8-4205-9205-18afc5227397@pelago.org.uk> <eddc6acd74abcea6131f3cfc606bc596@kousu.ca> <CAJZ5v0hR2b81+0FWAn3s_HJNWwweRSVk35KczPBKNabb-H91kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 01, 2026 at 02:12:50PM +0200, Rafael J. Wysocki wrote:
> The patch is there in 7.1-rc6, so it should propagate to -stable kernels
> over time.

I've queued the fix for 7.0.y now rather than waiting:

  a004b8f0d3bc5d ("ACPI: button: Enable wakeup GPEs for ACPI buttons at probe time")

along with its prerequisite:

  fe80251152fed5 ("ACPI: button: Fix ACPI GPE handler leak during removal")

--
Thanks,
Sasha
