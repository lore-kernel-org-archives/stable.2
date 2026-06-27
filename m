Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4C2C21F0
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782559582; cv=none; b=kX9lTU2Rci6gF60Oy83ZikYrEyT93u/og413NtCrRfrOLH81hB8j0JTUShK06P67uMNzKqusmN/PUKRS7dgJkqwZE2mYT7NV89FLSQearXvaG2t0hAAHDyZ8e0gAz/wBvXvJIiL8r3B1/tvkuMXJTyo1/IOMTI8UC5SQFxXQL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782559582; c=relaxed/simple;
	bh=5RB+9jzTPZpewwSxcSkM8uNEhb/obFPOuP3WMNT2PYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuAVNdfu7GqIy8PKLBuH15abrJTonKCd1FcvYZtUyYIzKU1xEB3hhphsHpmmogs8dadQNdJhLLKLwcVcKKMJh+gr91ITR0J2Z1ckPez4wPKqbqkUSjkNtidtAjtWcTakjNtQfCAMXdzwA4uLpX/sHQ+lyLfKKe20q85o3OE493Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ67QVI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ67QVI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB3B1F000E9;
	Sat, 27 Jun 2026 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782559581;
	bh=zUs6dy7C3Ey1u+hFvlQjq3YzPcIeTGOik68VOFqqA1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQ67QVI8pU+QryUfKRhl2v8WMXprSpNt+etDLqNyMn+Xp1psSn0TytKKlF1UZLQ/M
	 rp4PtKHZnjK1LIVUgJA2vyfXP31B1hqAtFfhGyJNxWcH7nerGR+KbxZKSC2QB8c1yu
	 zox2lRFZrBFen30vhBNaygqK3BvMpWIOlFz56FGpXivEn4JA1ImGwt77nStlr8wziS
	 Ek2UsSjMnk2wVGmAqUA6Ubt3DF5FIzTWJKlmfnamJWyq86i3Q7bsvIVcG0iFvfkgy1
	 mzwkNEcTVUSqGW6+4VfMC7Iuql2sa+WT7wBKN2uwe+S+f6Gkz1Am2O8Q0fhx0EQhHa
	 VCDidhlXtUccg==
From: Sasha Levin <sashal@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10 10/23] batman-adv: prevent ELP transmission interval underflow
Date: Sat, 27 Jun 2026 07:26:17 -0400
Message-ID: <stable-reply-item015-batman-adv-elp-p10-20260627@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626160952.123713-11-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org> <20260626160952.123713-11-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sven,

> @@ -939,7 +939,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
>  #ifdef CONFIG_BATMAN_ADV_BATMAN_V
>  
>  	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
> +		u32 elp_interval;
> +
>  		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
> +		elp_interval = nla_get_u32(attr);
> +
> +		elp_interval = min_t(u32, elp_interval, INT_MAX);
> +		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
>  
>  		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
>  	}

The backport computes the clamped elp_interval but then stores the raw
nla_get_u32(attr) again, so the min_t()/max_t() clamping is dead code and
the underflow this patch is meant to prevent is still reachable. The store
should use the clamped local, matching the sibling orig_interval block just
above it in the same function:

		atomic_set(&hard_iface->bat_v.elp_interval, elp_interval);

-- 
Thanks,
Sasha
