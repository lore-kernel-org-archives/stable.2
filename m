Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13663546FC
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354114; cv=none; b=TN7LEBLDOsi9kwZvWE+EPPVt+xv0f4Gxel+j1GZV6GiZTPk5M643TvW+lOY1w2kf5PZT2HkNa8cBFPqKIHCAtOhNp8UQEYrxRMwz+9KWaDBKiTFN+a496ucky5m3JTqM+U+XVvlpO5dumxN4HI+dy7aVj3isyP7lIfWOY8yooN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354114; c=relaxed/simple;
	bh=1IpiDcXZO6cmR758XcfRBABk089RXsqbT8ncmzLrEmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR7/8UwclV43mydG5DhghARyqE7MssVcc9QS79n/KWc+xAIlQ1yasqN35vamKWXU0RcTekYUcg/1F5Sc9wnr4/oYxA6DAPpqND3zzzMsIYK8ceXlKFgUeppCZpgJfkE4Tpsx8lV8GlBw2Ly98Pk+jTMKStb5whelH0DJLswWnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEu4/1z/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEu4/1z/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so23771965e9.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791354111; x=1791958911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1IpiDcXZO6cmR758XcfRBABk089RXsqbT8ncmzLrEmk=;
        b=BEu4/1z/NCGqgGz0z1Zaca0lOyYHOQsGsBeu9SAh4exFmlQGGo0hJ1O+ZdgREqh8Zr
         6P0Df1Or5DsopF7X7WehU8lhGwvEDgnFA9ZdTrPgPf3zHLvo/+7YcCbI/MX8b6Oc6XAq
         ax22oG7MrQjwfu1OARv9M4B+6rR3cGNHA+GPwbletEZZPZCTsSLyuJeO0ysR57M1No3g
         CERiayGJH1Z5U+D6UMJR0fuHNPHyGvzI7of0g/PylYEtTwjduhxP0F90Lvd4Ms9uA6KF
         rheX0ziOY7vMohEMrTPj1x3OXG1IT2NywPex0701UYEENfo+CL0MG1S3Of959an6+AOp
         LjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791354111; x=1791958911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1IpiDcXZO6cmR758XcfRBABk089RXsqbT8ncmzLrEmk=;
        b=GWjOFVxBu2ZNhHB+7wdiLz9Cp8AEDCWj3ovrwfKWDckB1oc7uPedyR6Mm83DUdn8Gz
         wj+2mgtAmUPHSlWJqyW+aOGbdmqiw5WOBD62PcUVxUMUDampt24g4BWShgqJHwsiVCa/
         4hLRQB3zJQ/ifZkULhC4uhkQtuYs3TKBXYuTdEagoKIsyxjMxwQv35+MNXdVme0A2j7Y
         44MtHuW+0zasp4F6aDNjAJW0ELWhe9kCounvjD+T9/RZYj7ANrEJ6cN9BOpJeZWe0fpn
         8ehJyeYl1HxJA2fTIm3/xTgtRGaD7sG0Hyx/PtOEFPyY/iNNIVRnU4w7i8C+hSmnKb+c
         CiFg==
X-Gm-Message-State: AFuF++k56nPlSgQ7zyQDxQVQ0JMxFlYVmWYIdgNfYvDWVzw3QMsXFPBI
	T7HzhYGQsddzHb/h9msHqnnr5UEiacanx9vMPDJke4G1/b2VmX0iDOSL
X-Gm-Gg: AYBFou1Kq7LCADZquEFn0JBfnPkSDRWH218kVSqxjMAOeNCKLdNFyUTWmsL7dpUyEtg
	tAk7fnWeXw2J4lWZ0FdUpJRWCMExnjeWKKXIsRvbTvJyMXkTryjE3P084DpyAhr3QE4SDKXFISb
	qNZGaboenDYCyq3XO3qM5k0Of7LHdAGDcRpG0vncesraBxk+iPQ58ZsIkv+DkGRu79lq8JP45lY
	kHaKoaIGfIUGfy8gaNkcW7Mo3FyIEiid2hYNetnc2HVRVUpubu2b1EDrnEmMKzAwwLHQX07q+4z
	flRBlSN6it7dkdmwfNovDUjP7ngiQrueM3OHtz/pALdvQrWpKUOfqdtSF7qnexWJhTN1dIDsPxe
	52WeaYzMjLqG10KPi9pr8leNvX8mXwnw4Np8ZKP/bJxMrB1jTFTQSFHxoZHKyjVTX8d7+6FvlfK
	82eNCD1HHl0Uceab3c77LlaRYBS3kHwwHR797Twe3jPpTKTybcUACN8qGQGej7TA96Cz8ZLwAsZ
	8ARuWbdCVdfcOc=
X-Received: by 2002:a05:600c:530e:b0:49f:ffd0:4039 with SMTP id 5b1f17b1804b1-4a1806504fdmr14110665e9.32.1791354110998;
        Tue, 06 Oct 2026 23:21:50 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f795f29sm37438205e9.11.2026.10.06.23.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:21:50 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: Re: Please apply 13221be72034 ("wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()") to 6.6.y and 6.12.y
Date: Wed,  7 Oct 2026 08:21:49 +0200
Message-ID: <20261007062149.2086871-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026-10-06-1-daily-reply-0002-rtw88-c2h-adaptivity@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha,

On 2026-10-06 Sasha Levin wrote:
> Could you send the full trace, and say whether your kernel carries that
> conversion or other local rtw88 changes? We will take the patch if it
> reproduces on unmodified stable.

You are right, and sorry for the noise: our 6.12 tree carries a backport
of 3e3aa566dd18 ("wifi: rtw88: usb: Preallocate and reuse the RX skbs"),
so the RX work runs on a BH workqueue there. The splat is the missing
follow-up to our own backport, not a problem of stock 6.12.y or 6.6.y.
Please drop the request.

Thanks,
Mehmet
