Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD39221FD4;
	Sat, 15 Aug 2026 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761221; cv=none; b=Yfwvoxdy96afQu73WOtSpv13NC9GG8pGoJy2KH/V4gNCBadZKCEf1EAn2cXpsJq1iojCJ4pWY+v8T3d9r29NihP3VgO5odX/CiWVWmGBWOZnLVT5fnkC6f6kjUxESNeDfbZIq0KNjJLiUOJtvtOKWx7HXffSbGpIMtIWWSC+hu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761221; c=relaxed/simple;
	bh=BLRNLFSi+8eiB+PQYoVcuQLBnHPCjuKiXNR2nHkmMQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsXPU8qMVkenkA/qPo2PWwRYDy0zG3eFIWS2RS5REfl1KvJBIOQYMAToKJqq0/TwBW089/dmlNe38V3Pp0vWqHSMb3q2321unW3ShFDqxbE1AnWGKBMm1lZf4lZKRnXsIDItsTDNHQ3M6kqPV999GH+CJgyk0QNb4DkrxQHGvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cijBRYoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cijBRYoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A7F1F00A3A;
	Sat, 15 Aug 2026 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761220;
	bh=2FmaatKkMyzUBE64aHQdNqraDzLaDpP/Nw9aqEgQk3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cijBRYoHJPCkz+58rURhfjOb+osKKC3AC0bG2fqH1rdUz1pQvyHmvhV2/rdVG4cxa
	 Q062AJVr8X+LZDJwaB5oPG94UKs7a/yEKWQflLKdTNlP2Ojezv43UbEg7lR8I/VlmM
	 SA8ZbgxQwcg+AId3c5FWIVDFNbQxBirsAdLeHIM/ir4AyLsN5oLgCEUwG4pNGINima
	 4TeQS10wXnh/sHkRlf+9dqReXw4ifZNoTJWFRzgoLaVmnCcyX1Q8wzbjU9k9oYrUTV
	 PnQF/WHzvXzXwEueYOizstf5uh0BBwZAjc46wN0IgzRaOmYMGp0rjDOtf/scB6zdlU
	 flfBUTf0Kiipg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	=?utf-8?b?5ZC05rab?= <rpwtsama@gmail.com>,
	Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: Re: [REGRESSION] Panther Lake 8086:b082 internal eDP black after xe takeover since 7.1.6, still present in 7.1.8
Date: Fri, 14 Aug 2026 22:33:13 -0400
Message-ID: <20260814193000.13@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAF38RzLOUW1ZB1f+Q2f9mhnYs+t4R2+UQA1PCihz_FKEu-nSew@mail.gmail.com>
References: <CAF38RzLOUW1ZB1f+Q2f9mhnYs+t4R2+UQA1PCihz_FKEu-nSew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Known good: 7.1.5-arch1-2
> First known bad: 7.1.6-arch1-1
> Latest tested bad: 7.1.8
>
> When the xe driver takes over from the firmware framebuffer, the
> internal panel becomes completely black.
> Close and reopen the laptop lid.
> The internal panel starts working normally.

Thanks for the report. I believe the culprit is 2ee8dbd880b1 ("drm/i915/cdclk:
Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable"), which is in 7.1.6.

Mainline is affected in exactly the same way and there is no fix upstream yet,
so there is nothing for me to pick up.

-- 
Thanks,
Sasha
