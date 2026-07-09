Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA053C0624
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592021; cv=none; b=koGdRGnFW10Z9N3FEKG6tbkucvXnvsaED+pGYVxa3ZleTQ1T2NOG9WTaovZqjrZVwehWfE/pKBjfJS2LWPgVv4DHIkWxijATFzJBaZFTtQtqbeMgLKxXov1CpzvIsiNxP7TQy97bjl+fb/hM4Zg3we29tiiTp46tDjLj6e9ZnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592021; c=relaxed/simple;
	bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUzwwkhm78xmq+l6/sdIg9JVYWrgOdjaohRdXZU+bfuZPOsQsa4cK0AuXY+GY4tW9AxABAA31YNoN9aNEqbXWxltgCpdnUh7HmBdED0qr8f0QKnC2rQGPcI128698hPanKoSXIyESCQ1yxecFZ08Q6KaN5h+c26rOHJYtN6Ltt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1tQ9V74; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1tQ9V74"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3811e59df58so1103809a91.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783592019; x=1784196819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
        b=a1tQ9V74DAsM5NBDHGa2IFBd6HkM2fDLdkXmM1gSeVz7Pd3B7GPOvmIuPzneR4R70I
         1vkjaGVHGrUpho4k840zDoL5UKT1F6CQn3ztONvHaKoBGmqoq8zV0RFLoLJgdhj74sBH
         iLF2PfOdMKEoKrfOigOWORRhaZqxORbcO/AwaQwBEU+ZTtMo8wl9Im6pt86qBkFfnnvG
         jnQkYwqEozQ8D8iZ7Fc7AQVhD4PO/G7sIAEyj7MU9+hVkal1AJQ1zBIy3bpcaz3QbFx3
         woJ2D5ndDgOwcIDnrlHYUeQIMCr/96eXoFbnqYkCR62Tkw8FT8GMmJr2Lbq+DG9LuIO8
         V52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592019; x=1784196819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
        b=r9qUNlQEgafpgEz8Q/62t8L9k9Hi1ElChHCmGnTbj4OFMvyeVTl2Y0iyOfS2u45Zqf
         vepD6MqZ42VsPcTbIdgtK64PwcscDk/KQxoYM/xxEPQify8x4Uw/GXslhvR9Zi0M0saR
         oTsZVhBr2ZhwUn7pVsCo1t4NqFjdzZzQUlBimPWnEQi8j5NNmMT18aEIl/4oWSl4QLzZ
         hR4bKFM2CM3Usdl4/5qVZAmfmEK+Wl5V2KDkuqboKz3+lqx+O6UfMk17IrBSkKkumOL5
         OCrv2T0QnY3Zx5uMfFQ+D2oP8Bwgyj2ia4YOZ/0A4NdfeDFWL0NXZRFzfsAC9GbLj2bo
         2psw==
X-Gm-Message-State: AOJu0YynWD4dUZ5BQX5MGnrzCixIHuvk/poXK7YBarw0rF53tQeOV+5Y
	OF7y2ktEzehd9CC5otlNyTTo8Zu7Hq/Gv0ZPCQOxrFHYO+i0vKo3Qnrb1P3vbID0PN0=
X-Gm-Gg: AfdE7cmXNaWMEpRdsirwkF8K4GN7PikW4CQM9xpuMrruBpVnB5lSOXVbosasu/7RJvm
	/3bUQFLezY7k7bRn6i+XdO1XlbZQOkQJTnRks6v2xpnIiADk450fFRSyQEIUetuIpy38Kydpg+1
	NwDJ9QxCfw3A8AW3zf7eU/i+kUy4Bxn81u1IkVT5+v8Zf8RvVj9kY75LxCXb5QWzHnbRUntuZcq
	raG4P0q7xKaMALvOMcluC+5Cu7wpe1m6WEmiTRzQkbV9Ny5YTAJKMkGjWlzLja7uRP8qvoNI2gd
	Tg1bsgTraRqcVLiBbb73eWrQz1JIADbYD+97e0zfpp2wjBFW+AWn6SywTL1LcbEHfAEImB8GBII
	yumjDNpVkfMA2wJIft5ZJkhBDh17rdS4W1AN4ycJ5Et+1zUKstTUyel6iJ5U4mPhlgp6CiiHMaY
	cbtSnu135Ur6iieVwcmb7avrw/LR1izYoKcRWW9Q==
X-Received: by 2002:a17:90b:3849:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-389402490c1mr6834337a91.10.1783592018896;
        Thu, 09 Jul 2026 03:13:38 -0700 (PDT)
Received: from DESKTOP-82PPU4A.www.groyaloy.local ([202.8.116.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm32071423eec.31.2026.07.09.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:13:38 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: Linux Stable <stable@vger.kernel.org>,
	Greg KH <greg@kroah.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Please backport bridge multicast exponential field encoding fix series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
Date: Thu,  9 Jul 2026 10:13:27 +0000
Message-ID: <20260709101327.9508-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Please consider backporting the following bridge multicast fix series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.

726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation")
12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
e51560f4220a ("ipv6: mld: encode multicast exponential fields")
529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")

This series was merged via: db314398f618 ("net: bridge: mcast: support
exponential field encoding")

I checked that the above upstream commits cherry-picked cleanly onto the following stable branches:

linux-7.0.y
linux-6.18.y
linux-6.12.y
linux-6.6.y
linux-6.1.y

Thanks,
Ujjal
