Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B7408034
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157184; cv=none; b=txw8XsOWD/P4tMAlIte/vyoZ43l6WxZX465emhh+ZmS05/zXvrK9Dcvyd7tSG2rFQZx3Ei63b7F0sd/EhJJxUNGwJCgaTT+pROfvfWHn3DCV+W9h7idyDhG7uh4YH/tV/cI1Kde8aoDBoGzYfz4rzRcMe/7dUJJdyIoCik5FB/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157184; c=relaxed/simple;
	bh=hFgTbWZ2T1eOWywSvxcDyVgVzbRIiGWe9YqxFXoTrn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlfxQ0jzJKYqov2Vlu2jb2jJNdFYfc7QXsPNnBHuWcTdo2R1L6MnurdznQuWVgZBMzTRRPV0i7bUVb/OzaTyfAO6g54+i4YgE2ivuKkj7qLcN9q2pvqsGjK9Qc/fmBB68P12pQgYlPsCFS0gYFODEXbJKT2HGUDCVvJ5T+R8VGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdPf0kBQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdPf0kBQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d004f135b1so4945595ad.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785157182; x=1785761982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hFgTbWZ2T1eOWywSvxcDyVgVzbRIiGWe9YqxFXoTrn8=;
        b=gdPf0kBQbg/UK700QJILbP9RrvrcGptZv4bQEPPAToKHbwBr2h3IXVN1DyAC4cz/7I
         AqEEBd9OXJMUd5if+xi+WMBOa4E0VjNcbrb7iHdlgjGqUhmHcOn5sQH2m2xmbySauPG6
         nFlNHQt6nZ86irVlT+3DIG7+qI3ioqG2oQPD8qcgEPF5154DnnRAesb6dxDKMjkp2xag
         HQOKDjDxW8L5LhJyhiGYUdEYdhaw+OOT6Qx7AseotOk97XbozAdxsVbzRqDqQ8ct0UbQ
         tEJrUUjniz1ZPyL6/JFmHUcQy6hL3rdy2CsDevtkCntPYOtoX26v7hBelbeT9e18Gthx
         WIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157182; x=1785761982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hFgTbWZ2T1eOWywSvxcDyVgVzbRIiGWe9YqxFXoTrn8=;
        b=j+y8/xJ/JpiJl6q5GeMcOGhdAP/kJEUiGnI0P09jcrnVhBLKakzUZpksB7q28AExdf
         RhON+bfMb61hjEfDLP71GUxU/6RIa3PTKL7GuH1Ckuk3o762WD7GVipsFf08n6oSZKmE
         yaBMain7DCJwmPenKrqSrYuSwjsfD+srsajXS7VDwQeZ5Y+eNIB/gdZDebI/alLiX1Bd
         u4LBrovv/lkOIlUlcpL+YdIwFWSNImBAzFwVk1D/LoRVRqMY3PoMyUyD5lBkYpNBVrhX
         UmVuWCKbv1K1kJlUh3/VfMKKmuB5yOENGtnXSrDnRp1BJNcaT0z1bL+uYc/eT/RfQy9Y
         dwAg==
X-Forwarded-Encrypted: i=1; AHgh+RqE0eQnpKm0ZJ0BCXD4CAZcj7V/+6Sg9mLUt8hsAl2TwWXOPyCbJGbwFOXdS4K9TWu7K4UYudc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuXYvhIR0l5T3t2tCq2sxxjFhnTGGtVmW9DbX+atwyff/v/XOZ
	/MJiJTk19CTxCdHNO2YaAxsIUKwtCM6G6LyCKb/en5sCkvuJQuymNQiu
X-Gm-Gg: AR+sD10oSRUOfDdGHCGqvW1pm0JT1Vo4CZK+PlAmV1/PrVVojPsKBp44S4z/XB4ED0I
	HFOX1TbGmdvUB/3MNGYhPh5fx5iU5PufrtqNPik7aJJkVhQykSO9bjtsK/EdHWkb3nDdEEtIl3B
	YsJLZOIwuHj7vVjEMHzlQ26M5hjXmqnmnDi0bUhr43TUdZTDD4d7Y1/tK1XiDEi6WOk7KPhcuqd
	ZrkRM14vUmW7A0cofjWcOsjQEQcIcAohDBTVeueW2x3XJk/0RbdarpKFLmru/ezf8dwhHYs/Gw0
	zvxRoErIuPdQsAwtRLBOm3JlaJYYYAvOwlBrCsCvKQL1TRwMRwfEiLzM7U7lPS3BDrgBy6tjzbX
	FNaz9qrx5ZfekJqSPONDNj1sF3ceaLfjo3xtK3SggzOuzJuBvAgyAt04pc4+mruy6tWvML4rQCv
	9ds/kXVzKeKanmI8e+ZcnJw58htNW9f3nqaGtNpFtNrGTEnJ8=
X-Received: by 2002:a17:902:c943:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2d0089fbaccmr6098045ad.20.1785157182069;
        Mon, 27 Jul 2026 05:59:42 -0700 (PDT)
Received: from anna.. ([114.70.9.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7ee3b1sm34404955ad.62.2026.07.27.05.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:59:41 -0700 (PDT)
From: chanyoung <ppoo1220@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	chanyoung <ppoo1220@gmail.com>
Subject: Re: [PATCH net 1/2] tls: don't over-fill the plaintext sk_msg ring in tls_sw_sendmsg_splice()
Date: Mon, 27 Jul 2026 21:58:04 +0900
Message-ID: <20260727125804.2889161-1-ppoo1220@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <amczWCEaLMVQWZp8@krikkit>
References: <amczWCEaLMVQWZp8@krikkit>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

2026-07-27, 12:30:48 +0200, Sabrina Dubroca wrote:
> This should never happen. We need to fix whatever path leads to that
> invalid condition.

Your diff is right. Tested on net (53658c6f3682), stock config: without it
the test in 2/2 oopses in the AEAD walk, with it applied there is no oops
and no regression in the tls selftests.

Agreed, my patch was treating the symptom.

Sorry about the verbosity of v1.

Happy to send a v2 with your diff if you'd like me to carry it, or leave
it to you. Should Fixes: stay at fe1e81d4f73b?

Thanks,
chanyoung
