Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063545561F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125705; cv=none; b=Cz+nLnZEshM9r5XJO6KEmrFwa/P+h7uZ0mLL/Ybon6d/U2g4lyHNJYO6kAVjg5EBd4195oZyZhLW0g1sL44/FcGBmmSqhShCiuyIgDabjwuGmk7S08L79D0gimtHpcfzqXzYYy+I7ZdoQQGKRt+eJyKuvuuutq5cboh/HGqNx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125705; c=relaxed/simple;
	bh=cS08EBl3x8qBdkRNOCURwSys5au5ugA8SKT9I39pjDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3t5lyv3UrhPebrQlrhQKuWiHgRcF0OZggNeq3yHnsfI8eKmlJpxArG45WVEj6wILeeLa7iyjUIAwuiFZwbbxMeNwQT+ExVQ2KDgBOrYr9v6D5jzBayu9b3DnS0TmB3Tn39bWMii8M3ZJyu4KkedwusgzKId+dudr9+ON/blbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaeUVIx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaeUVIx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB29A1F0089E;
	Fri, 11 Sep 2026 11:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125692;
	bh=8XDMnyUmoPxzFs0KDbpvtdyvol8xfdQdSsxVWCm3ZR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aaeUVIx1xO1DM5m4PLwQlG0K2urXU8SGwnNoLN9DOl5ffZ2L6wjhdz6OnCqSrugbj
	 7IK6pdSmFZVrXBAvRx4aVAh9kkG5ZaMiNq/2jAxx1RQgpoVZ3YYUdPZZU6pZRT7ip/
	 8EauHuUBQ7ipMSHNsD8GyT8KratAks7IWWotm1BaUt/MD52ib0OyRjeJbMKiFnh8Ia
	 SThHNJyAiEq75iFvFyzxiQ7tP6Ial0M/XQzhMoLoqcNQIYKlq7Cceuhm/z2w687AJh
	 tFrD7TFEbd52v9/syuTgOT4qw6QH7bdtloSUpqs4KlhWI8nknvPX2LWUAfeB2M8Quj
	 IRMLM2f4+G1aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 5.10.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Fri, 11 Sep 2026 07:20:53 -0400
Message-ID: <daily-reply-0034-re-clk-meson-gxbb-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910072814.334323-1-jbrunet@baylibre.com>
References: <20260910072814.334323-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The following out-of-bounds read has been observed by Christian on a
> GXBB WeTek Hub:

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
