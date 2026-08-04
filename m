Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0E456DF7
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849722; cv=none; b=ulfxN1xF44hxqzQQD3kBcgqF7t+tPXv7dkM2tR49HN+eYz+oI4OVyGP37OYyCAza8Do/YQWT9RD51/H4s5zMt5hdloRlNajM7hRgSX9tc/QNpLZifHERd9zbG1d2C5x4LInPzTPP7sOxKz7IaM0t5a/TTwa0A1nyFeT/fnhRqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849722; c=relaxed/simple;
	bh=F1Ns0YPbju+5JU6TaXtv4zBd5RxYGzvG2uXQRqInw8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MgQdn235cIIJoX5J74sm0J0AxgC8qyrE7MiQdQxVcAqSzrIpq2rOAcEXPtZsn+V0/cktN2eprBPZgu2BJ12r6PWWUfSY7hOwge0H6bIxqEPFTf789h9uQPYS550WQVLRZ5Iq2XJfFUd7FeSNtLlQCwARgzDp3MrlBhDiT19tQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=CIv1N6Tz; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="CIv1N6Tz"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6acc74fee76so1842611eaf.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785849719; x=1786454519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKaJVZUyE8L3YDu9jVIaa21DRhvEs53FJAhqoPHjpPQ=;
        b=CIv1N6TzY1RjDCYKzZREb1qHFJo3RNAlX6y6md0JsIgnej9aPbOEKkKluC19WwHhgO
         iNgDKS4zHLhTOK3+tQ6qKxuhx0v/a70dRjtWiejopNUIM5HEetwEDKmkUUj1QQpiwRTF
         vJ3NSx8V4+jDG7Fy/uMNAsm+tkKXoQXyJd90BvcEAUjEkaLF11B57lp0PfVavOvJu8XS
         PPq8U89Ban06nlavzIYfzo+fZLMaVGOoB1KtakmPIsr+LuMENPrKwwlQ2Qg5oQbEAmfx
         mlbIOmiH0O+8h+qUmUCa2ESzS/JZVKQQ2pv+YGFdn8n1+KXSQCtSdZfv4YGq4SnRX5fs
         k0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849719; x=1786454519;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKaJVZUyE8L3YDu9jVIaa21DRhvEs53FJAhqoPHjpPQ=;
        b=bJA/zo3/XGQoNRmwhvDt6c/QFadrBcS84ViFoPO2sVEyO5nKcuiPijQAJnn9m2r3kF
         msz8zXPQWoZVHFeioQ5NA7sZF/Q4u8kKxmfAvn8NAEU8lYH582E0mnZ+N1SIcHYBc+71
         vOBQBzSBX49edYINU355z/KRskGBtJ7k4KnTn+2fo+INjqEkpmUqk1gzkWVl64dzKd94
         hlCusFW1UdCocWKEEkF3FKswlLJS8GP34p166JRxvx1c/fMrZ/cuyxsGCs9Rz5+1RwFC
         LlPC9vmoidDeQcF4yMKLfkpcAwADb/mcCn0RWjQiJTi2JvAOwcKRp9ZzOyqNHIQ5Vi0j
         YUVA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3cuUBSveNInoV2Eh1Go1YazFBiB6IVDsmyrrVNwq28+2T1/Rimz1kcJ7+aGBicWuP/eTYL5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlKr3FRmrxoib0pm+QxlvVP5v5De/eWyp5gxNiKpn3xm46Rtw
	07xLeEZPorp3SHWpIPf9p1e36N7voHkKe7esLhqCUl1qUkZErL/sVlqg4lU2tBjcJiQ=
X-Gm-Gg: AR+sD11A+M3Jpbw2BprzAU4XL7AI/LwzfGZeEPmpdG6AjY51/UYhAn6ieHA39qtvFz7
	W8DQndLiHxRDyHQouXXqJ5yOmE8xhThjh/sTT9IilkTp7q0KS5YraVlGQp2BwAnT/3TEZ8gB108
	86sBdkI/htQ90tJNezFuS5e4oZUHm5AZ3Dn4bjd3zjZgZy7HvL4rnRHxSQGQ2xolMXfFksfu7+b
	CeCCXdEy5iPnomhpLq9cDLeDmdgJvOmhOIOP4oU2RxpIr63DXChB5dJr/NhmUFJZVBDWUaHBi2f
	Sumt0lRQea4ezMJb1J+rbPrmwT2PDbOipoXLCLn9ae8UHGaunRN9ZTTEOpqF9YD91mLS/6F4uXk
	jrR9koNwjYp2JYxhwKsiHiuOm4FydcRNFodVrK3zqZj/pj5/k6FIpzGyuUnPGpzcZvKcNtmXHud
	3p35NXt7QD7YoHxsJKaLY9UA2Tla72dQAe2sZ/usIWOUTSvnVGPRc9REE62FfmOyqxw3QVyGz1M
	HmeG1M884c4nmXRGv0zE/DUUnKsYCmcxpdkvYuFgw==
X-Received: by 2002:a05:6820:61a:b0:6a3:da23:505f with SMTP id 006d021491bc7-6ae432ee256mr17769203eaf.23.1785849718728;
        Tue, 04 Aug 2026 06:21:58 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f6764087sm11957112fac.17.2026.08.04.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:21:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, raoxu <raoxu@uniontech.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <4659F8F0C6C328EA+20260804052942.1186727-1-raoxu@uniontech.com>
References: <4659F8F0C6C328EA+20260804052942.1186727-1-raoxu@uniontech.com>
Subject: Re: [PATCH v3] Documentation: block: zloop: clarify capacity
 alignment
Message-Id: <178584971685.948879.5527639409751781985.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:21:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 13:29:41 +0800, raoxu wrote:
> zloop divides the requested capacity by the zone size to determine the
> number of zones. Since it uses one zone size for all zones, a smaller last
> zone is not supported and an unaligned capacity is rounded down.
> 
> The capacity_mb description incorrectly states that the capacity is rounded
> up. Correct it to document the actual behavior.
> 
> [...]

Applied, thanks!

[1/1] Documentation: block: zloop: clarify capacity alignment
      commit: d73b5b0690e36b2a9e6022f6712e9fa7fd338632

Best regards,
-- 
Jens Axboe



