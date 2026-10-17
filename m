Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250018D62A
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273251; cv=none; b=AgpD8UsCVj4mNcqB0tqeKYHLYBwijxT97boAJK6cCc6ti2XWzc58CO42WWbNjWY7W2bYY8Dn6zv5hlnX6jAfUdKcZUiSaPyowwxtWY4mw8/r67Bibb17bOjjDiSxOX1LHGrEmtiGE4NIe0bN6hqIh/aTFT5f+LVZILTTSUCjKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273251; c=relaxed/simple;
	bh=pKJj/9Wwtc4TG4Knbq09oNmo8hoqs+7fYuFsxQmFjxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=md+LG5BBJJsACXldH2VIVWnvrMpxmep4HUlgY3KmmoDnmhIh18ZewZSYLae0ZdsIVGx6/49Odxb8x1TuhJJI5zwyxxHyDgWrsqG1BkJRKGoGgFRXcKj5VYPqHPS4J1E6S6sRsvy0+nTGu7VVEkg3vPgFzxNokOuBsoc5vgw0d1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nilk.net; spf=none smtp.mailfrom=nilk.net; dkim=pass (1024-bit key) header.d=nilk.net header.i=@nilk.net header.b=AiGQCGYz; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nilk.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nilk.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nilk.net header.i=@nilk.net header.b="AiGQCGYz"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6c8f6a53fabso1990084eaf.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nilk.net; s=nilk; t=1792273248; x=1792878048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pKJj/9Wwtc4TG4Knbq09oNmo8hoqs+7fYuFsxQmFjxU=;
        b=AiGQCGYzw+m72q4Vz08BsR1KPD7/BsdBs04MY3EjSVVbd770bqCr5ceRdGRtFYkBXk
         pJdegYF62jHwo1C9i3NhOPOaTp5GXOpZ4q4mRCtmmmrcS2sfDKMMXtUqLbfNPw4IZ5FT
         wfzls4OPcekmyvCLFHmaSwADsV25CyXYMY8NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273248; x=1792878048;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKJj/9Wwtc4TG4Knbq09oNmo8hoqs+7fYuFsxQmFjxU=;
        b=VhDfo0k06FhWMxXu/YUdfyFJBFW4vSSAdyIrLxI3JNPihjFym9WmSV930xkIXza6cm
         oTFe3nvZaPsZGvE8kvLEn9OKzhyMfwuqIvnusYN3b2KWKVRyfr5Vy2odCuO+xIJBbRWm
         2hSy+GQ25RFUCMB2szT9UcxrC2WF3rJ+oUiSFvcd9uvmV8gTN+YxeGMhjiTvup+LswpU
         QfVMhLqP2rLCYWRbL8yiPmwrPKomTOd0zkCqgGKwNsy0/JRlhFMnVcgmXKu1uh7huBja
         paer1ENFdxoQ5rX6p/XxqU2KSdIS3Ri0OfdsUCApL2pCsYp8lkBP0QPMz7HobbHD1gqc
         eI3w==
X-Forwarded-Encrypted: i=1; AKwUvBy/1dH0O5NGNFf3g/hzSazIiUfGjYVMGqUmeDxelEYWrbRyUgE9trsAiWrdNgEvw0Xe8m09D3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKv3jcQDcsltvySGCBzicdR7xnfAUb7Cz/jFJNPCylbNIohj2b+
	T/OuJ467gY/+DrHNSLiFncstaaIQgpSIP+XbVGGEpKQpOCBtyM9MtTNKC0nSyD+mfQ==
X-Gm-Gg: AYBFou2WnvoV27SIPgYMmbcvriyfR5VfdmHpRxGDsJ1boSwQb9FPVZrMi4eDEvOrGaF
	tfwro8fDd9XG/o4ORlJZRbFtEKLt08NJefk6NTeLdiikWbQhmCjcn+sQVASw/7sSk2/s2kw1Z2e
	AgWbSQ821BT4H1el6ly1x6eNvyhlaJrGQ1ADt37Tj06lsCXspH5Lntc5nTidxj5yWCrpW2DD59g
	3ZqgCIIkUH60thg93ElACpY9fQfcD0QATrfUWcrgoWlB+eaWlAobFYrR4MaAdEtvZPwxLE4FbTh
	kfgGv2FIB9y4DStCj36ovBbCDqN7nIhXZb7/P6hF+pAw6hxiNJFT+qUXvxGOC2TxkGPsom++Qw+
	fvDtitmIsksN4xISLXHyZo3K71h3VzJ1JqEm6C1zMWLM/c40pPlY5B6xa1Sg9dz/zU0V/EsDc3D
	6hTcRfuJmMm8+s4a1bW9k6LkA/tP4ErTuVhAk5Sw3V66/PC4Lia2FQ0CYBOJVXApT15ZO/tq0as
	k/S+Q2y56Plet8JFUhUZbUvOXcGvOnRiCg/RVz/HeHqJwobK7cc1PNAuQZ7/2gNnnvAHDIPiJKw
	wa1bOdbYLDGFrUhf5qUKxhEhfCLdshEoXQQW78K5k8yaiKcp1gWayUHhil4rRDjKJOC8rq9x1+T
	Slh0aUwOvsiWubf3/CU3JZyjMSYjhjGBG1DeTQb/fO7hkn+s9dOk=
X-Received: by 2002:a05:6820:4df8:b0:6f5:a844:b12 with SMTP id 006d021491bc7-70116e4a975mr3984515eaf.57.1792273248461;
        Sat, 17 Oct 2026 14:40:48 -0700 (PDT)
Received: from [192.168.0.114] ([187.14.252.51])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6e12e06sm5109596a34.22.2026.10.17.14.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 14:40:47 -0700 (PDT)
Message-ID: <02feb114-960b-46e4-a126-9b8659fc4394@nilk.net>
Date: Sat, 17 Oct 2026 15:40:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: i2c: dw9719: power down on detection errors
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>, Daniel Scally <dan.scally@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20260913041828.28430-1-mhun512@gmail.com>
Content-Language: en-US
From: Chris Simpson <chris@nilk.net>
In-Reply-To: <20260913041828.28430-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 00:18:28 -0400, Myeonghun Pak wrote:
> Moving chip detection into dw9719_power_up() introduced direct returns
> after the regulator has been enabled. An INFO register read failure or
> an unrecognized ID bypasses the power-down path, while probe only
> cleans up the media entity and controls after a power-up error.

I found the same leak independently while adding DW9800W support for
the Surface Pro 9, and wrote the same change.

I tested both error paths on a Surface Pro 9 (DW9800W, ACPI, a 7.2.11
distro kernel with the linux-surface patches), forcing them with a
test-only hook: an unknown INFO id, and a failed INFO read. Without your
patch, each failed probe hit the WARN_ON(regulator->enable_count) in
_regulator_put(), reported as regulator_put() because it is inlined
there, and the (dummy) supply's num_users stayed one higher. With your
patch, neither happened. An equivalent change in my tree also runs fine
through the normal path, including runtime and system suspend.

Reviewed-by: Chris Simpson <chris@nilk.net>
Tested-by: Chris Simpson <chris@nilk.net>

The patch still applies cleanly to the media-committers next branch.

Thanks,
Chris

Made with AI assistance. Written by Claude Opus 5.5 (drafting), with
review by Claude Fable 5.1 and testing by Claude Opus 5.5, under the
direction of Chris Simpson <chris@nilk.net>, who reviewed and approved
it.
