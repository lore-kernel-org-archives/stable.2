Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6178419FCC
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270025; cv=none; b=W/vQiYATlFRt2YVgZu1BQOcLSyYCbO2TtffUmUz2F5C+oQPpkBp/wWo+40XQK7s/rIHICXSvJYkBjKRB7oH4WfqbMpwzWYew9gGppu/8/maCkQ8er63/vrJybjjNwoLcFcAO5whOwE5ydcIfnHzDtvnxAoqkRZBwIU0K0DrGVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270025; c=relaxed/simple;
	bh=UMiRIdkkvByXIsej7YtohS1owkRrHoaJZF5o0iUSbqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baPPZpeHn6A3FfK7O8bN3TqAzvguB7dbtW8axTSjTMEd4ArBiX9RTj+AiAfrO/DXBCxfS4pHQ+ejm55NiH8TijArIpoyD/dqv9sndAzuSE1b0IbtrJK+0jL78fNrjioa1rsREga30ud1G45z9L04eMzrRuI2DSjBa2e6hOAUFZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2aXXueC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2aXXueC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D56C1F00899;
	Thu, 24 Sep 2026 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270024;
	bh=m1CYQj51jmg+SkzOzX5FztoEtR86JjxUuimwyUkOGSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2aXXueCmiBxzA+X+CDcxjEXeAV1l9JrAycO2TsbCrSAOMLLqYMOVdiFWucnJlhfS
	 wLwDpo5q0Mib9VyiWBkKVl2wzn27VeZk4TTCNuMJ87CFNVrQjQoaxDzBHX4eoPK6Sy
	 F2NmnHHe6h6QjX+/XPBVWf4Lm6cN4w0bveuHn6Zn8QkirV2spFve+RhHxsx0vMNZc3
	 ZmnoPcS00sGEtFyO3ddrLelkzBD8ANKzDup/7mdZhSnSHR0L8bUQGPDkqs8TYzMtIB
	 ho2pBA4HUnHJTjSDQ2HwMcEQY+HCsU5xV3doGfBkQBXMp05sERXoSq23u8rh1Pvcv8
	 RZgJkZyPXQBfg==
From: Sasha Levin <sashal@kernel.org>
To: Itai Handler <itai.handler@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5.10.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Thu, 24 Sep 2026 13:13:29 -0400
Message-ID: <2026-09-24-daily-reply-0010-re-spi-zynqmp-gqspi-shutdown-5-10-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFpOueS2DVM-8JT+tZTtrJtWZ0ddz5ehuOHR1YKPK81P5NU_3g@mail.gmail.com>
References: <20260922140318.668429-1-itai.handler@gmail.com> <2026-09-23-daily-reply-0008-re-spi-zynqmp-gqspi-shutdown-5-10@kernel.org> <CAFpOueS2DVM-8JT+tZTtrJtWZ0ddz5ehuOHR1YKPK81P5NU_3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I suggest dropping this backport for now and first fixing the runtime-PM
> logic in the 5.10 tree. Once that is fixed, we can revisit the GQSPI
> shutdown patch and backport it with the same runtime-PM logic as
> upstream.

Agreed. 5.10 stays without it for now.

-- 
Thanks,
Sasha
