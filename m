Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E57395AC0
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519066; cv=pass; b=TA7jH2Pk9vlNA7HhvSP41AGBCLxwb5tDhvUGISy3xs5IVeBrZFKu5XPh14q0RrLt7BaozI67uAExd8BL5aMQsOhUwlBDjcV6ZeYLjYYLtArJusRBot29Xxf65Tdiupl+GsBvdL/yoiOzOOmlG/h5q5qzydPK7D2tyUJycbIHass=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519066; c=relaxed/simple;
	bh=KXs9zfC+23H7lDQGGpLfOo2NqRcK84T+KR+QuKtVD8k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=csI+IB4CtBzOqPMLoMfso+31JTFYbp6ExV6V4J9GC0Rz+7VhaimgfpzxEcQ/6mi8qktxqEYrZ8J3IoeLUnBwNm26Am13GzEW/igQ+Liry9Yb50UVK5ifzqrtOp5v5shQRO++DBljeCXN4o4cAWl8mI7+cXN48soMtQ+34N2jpUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=z1k.dev; spf=pass smtp.mailfrom=blahgeek.com; dkim=pass (2048-bit key) header.d=z1k.dev header.i=@z1k.dev header.b=expZAJXV; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=z1k.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blahgeek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=z1k.dev header.i=@z1k.dev header.b="expZAJXV"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c21495722so68590261cf.3
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 20:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784519063; cv=none;
        d=google.com; s=arc-20260327;
        b=CJL79IZ9VPZ+1tw6jCsoT4J5NRl/xdRX4GxhYa57EOjnu88KxyALEKssxnoP6++C57
         FF5IFQbl0Htq2oEow6Yi2jxCsp3bsNwhB5NN7UhIuC2HjakOp73SDEwosgZwvH+j57Te
         QQQ0k6+UD5EpA3iwpbseoQg0mVtuFjZyGv/qmeETeqyLdMbPAoGieCG3jljx2Fcqp5PI
         aGZFpc4EF1X2aVc5dNu3ne8qj7tCY4WW4bOAczjx/dG75gFQEDM751AG97nWc7V+6MJr
         7+KNksB1HJN2KOf/TX2sNaXv1pqutLOsp+TNSPlT7njI0SmFhlwo5lKnF0cTXhybAh2G
         YKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KXs9zfC+23H7lDQGGpLfOo2NqRcK84T+KR+QuKtVD8k=;
        fh=yamhqS73F4BctIXk8PhRoYWpHxhU2wpVWcItvz3iZ9U=;
        b=WlFFlzijv069KiROvMzSsU9vUltZNB3BsVgGwQSm0/jk1SrMZJo06x8hUnK6v5SFT9
         ugHVekpSt3s2Q3hpm3UFImrImA0RFZtQoPv8IsNFp3tzS78uCgvEj9AgFy7jRiNzhru9
         A7ymiwuytPPLanC/CB8hFlXrlsPl3IGKNkz+QqUwE4Hw9c1fbt9WrVWNtw7xDiliEDQL
         sshvhQMLvlOe7cuo89g7JUo8QztHRhFTlYuN/TZq2NBxZ56Hel3j6+11v+cxThUz/65o
         ilFmGIM43gQIv7nc2CR3LWK5xWbS6Y/adyvrWoxjBoyCAoOBKqzPchpPD9DPjJRBSHuD
         ZMeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=z1k.dev; s=google; t=1784519063; x=1785123863; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KXs9zfC+23H7lDQGGpLfOo2NqRcK84T+KR+QuKtVD8k=;
        b=expZAJXVSSZDU4x1spY08dEeadxNPYZylwrWzZDrYVkgXInTuqNAix7kyO5kYu4GYZ
         4kvFHokLXPLLiiicuoUfuymOhHYIEo99ew95aIM/oNif6+GuDJejxw2Eiv3nZbmGoHD/
         9XRr92NXJ0XtlgRV5V1lGvgYvwA+X3iA/qBNZIeYegPI+pbq/niGtiRONFlQ8m7OK+r9
         PzlufEpeHfO0NMguTDIU2wnFQHxFg7u9UBckPigq4vzghTH6K9WPLMdYagu/tLe8e2jr
         daiIsAi3QmxYIW4UhVeqp4nV+GD5zmUTFE4LDOmNHu6wPFz6PSBA/vwS6xGZkEOZflwf
         cbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784519063; x=1785123863;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KXs9zfC+23H7lDQGGpLfOo2NqRcK84T+KR+QuKtVD8k=;
        b=GgbAX4Z9ZPw2yDXQR25vjzVKg/gPduz0nQoN/VWFRujJfCs9KevYm0VWaI90meP7Yx
         7BmsEH9Mlay2c/5wEQUh16fhi5CzE0BrsYqmVQsJNUJdBTcX4srBLNp7SVuIobOH1esD
         FgceXF25HTgx4OgjQ3ttveS9alTD715XXMgnqgU9cvCp4LbiHN68aNSbv+2zUkoFIK+b
         FBEdmbhO440TfdGOwGF9BlBTd3vMHlbheAuBa/MmUPflUwEc9UoLyL/1KlYXcA6DN0A3
         NMJloDz+BXjXpcbLa5v4pOLcYyoR2aMJaPnD3OilOPSgtCHXTs/+TDIrlnN4IuLw64Gg
         J91Q==
X-Gm-Message-State: AOJu0Yy1+B6vhypIbW5OYQJXzEi8jDgODyQR5d4o1ipdKmnBSssKLX/G
	D/is3vZdAQnNUAgxtHuAJvHrODy8OyrHyS39p767sFGR6Ct5jCZgRY31Na5nB+SDyicxrEyzdWH
	wZmKXYI0O0b3PO3PMmyXhTi/sFU07rjmYXcpZyQLvoqOF9CGxhGIUCpJkjPMgAfA=
X-Gm-Gg: AfdE7cmiUqWRMWVXgGMsd/+P+uIrq6y0d982lR8yBt1/rfboabRiehv2hLTEhsqGgV/
	DewkwFa+kDNwqMCSEyh56gu+iJ3+1si0JknyUmkRqM4BbTwGF+d0ukiQF07VLMtKqvohUTGnGHy
	l2p7EavFjpBNJg4qsyfdRpQJgZPMfwWf9TSU8Vrcxjv2zj7vfNkAnYMZLLuYJqvLg3Zmq2B1hCc
	IZuhCmxRjZxxfjNQMLiX88W9NU495uZT7T9hgAwrAIa6p7jUgUjWFQvZ0g9SNHv+BZwlxA=
X-Received: by 2002:a05:622a:588b:b0:51c:e14:87ae with SMTP id
 d75a77b69052e-5213c7e69e7mr108999461cf.34.1784519063160; Sun, 19 Jul 2026
 20:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yikai Zhao <yikai@z1k.dev>
Date: Mon, 20 Jul 2026 11:44:12 +0800
X-Gm-Features: AUfX_mxzeO-q-G3exRKIA8DMaaWGNPUFSHS7biBJtNMmBpl8rRmYB57QnRn-D70
Message-ID: <CANMyjpgq5n0Ekt4dgyLRHGb89_Ew0aOMZ3j32V_w0GjHkqH1FQ@mail.gmail.com>
Subject: [6.1.176 regression] damon_reclaim.enabled broken
To: stable@vger.kernel.org
Cc: aethernet65535@gmail.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernel maintainers,

(Newbie here)

I found out that in 6.1.177, booting with cmdline
`damon_reclaim.enabled=Y` does not work anymore,
`/sys/module/damon_reclaim/parameters/enabled` is still `N` after
booting.

6.1.175 works OK. Apparently it's introduced in commit 2f54908fae21.


Thanks,
Yikai
