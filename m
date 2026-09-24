Received: from mail-wr2-f32.google.com (mail-wr2-f32.google.com [74.125.225.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130F349B19
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258371; cv=none; b=NjE/3eIVVgVfkm4GG52HEhBDL6KGYxq4WysnEpngOYM1bhU2qk440w++TzXrgHmzYdFSQ41PJAqEXNix2awUr+CyaG2H361I7cB/b+6zd3nwDRRTN7qcPsHcjNa2Kywg/IxFBmDVeRIZgIsCWcnwejirMdj2z52oGXSLdnM9xKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258371; c=relaxed/simple;
	bh=JpqOeur7GpbN7ezXANNXc+iz0nVAxCGXy8kfPhgmAqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o178nrhIkBeK9EL6U3leA5i041b4Zoe81W/ineH0EYe9Ctm3G7AJhVXJOweZMwZj2NpFjEuFCgHjBdRGkBzrb3IS6FmnsloopDfd57MDTE5hdUesCXGN6p+2f6UnCdM0C8xGxMBqAxtrxEtgI078fBy4zdZ38bXvJQA/hqRJO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkylD8iy; arc=none smtp.client-ip=74.125.225.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkylD8iy"
Received: by mail-wr2-f32.google.com with SMTP id ffacd0b85a97d-482f6350f91so1342460f8f.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790258368; x=1790863168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRDlFyxUk3KppsRNFoYPmaT40+fQeOq7faNwXvSK4kA=;
        b=xkylD8iy+rfMATOyklNh+KekcA/IpTEDD0jhfZWX3dDtgSLyMYN+wt/DGsIiLPJelP
         1RmaS7GVLF+rzxKhCYBvAKj6UqMaLkY2ZP0fveenlk/tmzbl/yXt67lTvj7tkXiG0u0L
         ZmtZFHpeXHwey/G6XHgvCZdinJLyoZfEu8DM6HZgHNhmtDd6kzBVTZuqhacbYCK1plIK
         7P3S0fNOtT5xLMjqjJn9rsCX1i3wi5Pb707SvSlQz5OnItYanyEvW9fdYOAgv8DBEMxg
         y0UrQpR7+FDrMT547mpVSseDYhpTbaLBeRFDdaXL0O2lrP/11Ct1mKrtrv6KKSwomMMk
         uZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258368; x=1790863168;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRDlFyxUk3KppsRNFoYPmaT40+fQeOq7faNwXvSK4kA=;
        b=Jc8l00SZWAUoM1bSyxDko6/YumHpaAqVnJ01MI8FLa/9UdD9X+7ycrxU1bWX2nV0+Y
         1+Oussj8AFjdlDhKBy+0hEHqFQGr040qnYOIqqfczuVGWkLMTwEFpODnDl5gWp5K9yXr
         2iat0H8NqZSBZpFGK5G40aItMUPp3Do5yhx64p0ZHHY6g+aT9hh31Dx2nfkzziVdNwiy
         OVQKzKstVUK6ukHqHILrWlIpAHTugsPuWEkPNFkfCV4vhrn+0EGRpSXXVykzYEp6mIXB
         n27I3xdCgSmv3Z3e5TS4U7CNKu6gOuogAoNbRXJkhD7HhVnG3Q8NSGRo/Nl81KY5ek1r
         Hg7w==
X-Forwarded-Encrypted: i=1; AKwUvBziTu1vHoEOTbZYVKq1O/zp+7NFCs+U0ndvG+gjdgCKRGwRLkjdbYGWvA5Ij00HqX/z/L4IqKM=@vger.kernel.org
X-Gm-Message-State: AFuF++nvve0e3BQ4PgB3i7Z56xal0UmfwX1pm7CVPiJe3zT4lXHPHTlU
	5nhhx24/hKMhRsUv4onQyso+2m52L9izTcvND48YqejZJhtYB0/R4Fif4yfAkgfgWMM=
X-Gm-Gg: AYBFou1TCRVibIjCBMrLTD2PHY+X8TGkips57Sr93NkYZ/iW4urenxTMXRbNPW8K23g
	SGxxQIRuoKoKMg3IfgCCEh6fXS6we1v26G50oCGGbDjXTgWCPDE4zYvPlsJD9u6y6Vbu7X4JBty
	tp4ScN3A1FSaB5IWg0ZbtT1P6CuC4++ZKwDqexFI9wHsPiWzGUKF0YZBrLwLvfl4oJwHRwFTOR3
	kFUHrNttcCBxKQmu6/RJqGNe2KULAr1YBKAeRCmy3HvakYIyps218UxILXdc3qvmpbLW/7FiOfP
	X8qFN8hLbAZzygdGkFrR5LXkb7zMqTEdA61BIDb9sfCLY17WrPJgMfq/0vdAWlj2qcU65rJpfHs
	h58Teu6yWUloDnA/0j6TYdntIUBphMpALoZYRopq2Lpk5qfHySeMf0n18m3Kw9ror/Rm3U/1YPr
	BnJXQslSl2GqPACg/zUYGzgQGKQYxH/eCAZ1h96WwEqTT5HS+cgkycSwXFsYRnHES4F3K1TOEuj
	VqL3CDtEzKR09KGreNr
X-Received: by 2002:a05:600c:a00d:b0:49f:ce73:7ab with SMTP id 5b1f17b1804b1-49fe6708b23mr50754095e9.34.1790258367671;
        Thu, 24 Sep 2026 06:59:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c500sm15799213f8f.19.2026.09.24.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:59:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Joel Selvaraj <foss@joelselvaraj.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Linus Walleij <linusw@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>, 
 stable@vger.kernel.org
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
Subject: Re: [PATCH v2 0/3] Xiaomi Poco F1 (ebbg display variant) fixes
Message-Id: <179025836659.3234093.17562514637378483936.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:59:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1

Hi,

On Tue, 08 Sep 2026 14:45:01 +0200, David Heidelberg wrote:
> Been broken in mainline for some time.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c
[2/3] drm/panel: ebbg-ft8719: Fix the MODULE_LICENSE() string
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b1885bd1c985999b8a5393f2e23eea8dde3109a9
[3/3] drm/panel: ebbg-ft8719: Split initialization into enable/disable fn
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/012dc8a8e5b6bca57ef7bb62d6015faff7690e0a

-- 
Neil

