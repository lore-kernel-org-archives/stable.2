Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCE4FDA5F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664892; cv=none; b=Wu6Sav7NTRUfOumA3pds8xCLuHU2EsZs6GlD17yxZPx5iJIoY1ht+aBrX3mhrGxoJGYxkAhrr+Qv4u+hDJpuXe3BcQphHOVt/HzEVVfGYp8YlEfEx/QjG5fKGuF2Ud4rYmqn8PLOI1fPTYwZr0YYFxkO1zCJ+j3nLDqGwdP1aYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664892; c=relaxed/simple;
	bh=bWkFqhcxRzjwJio2bUVTGTf72jyWIZPzjQrvTOKs1HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNhbEqtUh2ufI2NdLwbYcTZjwZT6L8EKL9loEKyp/pwTlXHpdRHlZxOiDp+B0swfikzr6hOqruMGBMoV4F9gdQ57lqk+n5A8bqh01dkKqO8V3Pgp1pLyxZ9q2dj+psDQyqyv+2c0fG8y4zwPL1uxs/QXsJliHaejVgZe7fZMT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJIiSV8e; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJIiSV8e"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso11803455ad.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664890; x=1790269690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bWkFqhcxRzjwJio2bUVTGTf72jyWIZPzjQrvTOKs1HU=;
        b=eJIiSV8e3yNGX3Mxj5Wtu/us4/FYfxrR6SWvCqsHfwrYXMTkfAmUinHbzcdUHrsxw9
         vhGmX2L4sK+Ur5TG9+rn7bK0k3VAOZD1jmc0lv1n8DhXdaOkktDLODuRys1BTHCDuhEH
         7/jzUoO1pvg8OUcFw+9LkkEpLfWhQGxH7kHBbCneHrO7hK6ePGZUrkNBmX2QwEPSijWv
         ZeJi2BFFGO5MmeDkgurD/6cXQgdNdroFyRCXeK2AyRpKXRrsBmrd0BBsg8chcP4N2Spe
         7MX1F0NS6IiHpuk6RwsR2cHSM6eSZmpJ/wEA3UbBqgv+08JwFC1lyg9IU4fSjvHM2GQu
         /Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664890; x=1790269690;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWkFqhcxRzjwJio2bUVTGTf72jyWIZPzjQrvTOKs1HU=;
        b=JzYorspc5Xgfvfz8iHNeRVNY2qdBzvJu7Y12o05YXB14fiqaNzfDIiOaixt8J0k9U/
         mtwULnQRL7zW8PyOuhbvFAjMrAGk6Fa4WoCHAlC+ZqeQs0HALHKuW+PTdoLHtHturifB
         Fb+AhobrhJKJoyJLBBkWl/9mlDUtqDqoXYIkepcVyS5ykZXmycEVbbQcnNiNve5PEjZz
         PFyhkzqbDvLK1grO9Oaj4MBcFjMUsI0ezCTL0jfe+F7iTHeE1quEhO+qj6nVReLRxpwy
         JrZ14sw9LloN5+Vyy9IftHu+9PpXTtPR2J6j/6NKUFPnRKbnjsIOyXLdTzHe33mGTd4P
         AI8g==
X-Forwarded-Encrypted: i=1; AKwUvBxm00zXqlecxkkcAArDddfUEGZxTFYkx/CYzewgQkD77tBxaNfP5ictOM99hUe8wTnkUAqOlns=@vger.kernel.org
X-Gm-Message-State: AFuF++moEE0cC3EbI+SzGR58Ux5jUk5Z762dC3crvVLKpv945TEWkap0
	3f+tXCmJ6EoqGkBTb5M8YQjsTW5n6j3EPwLG9ZN6ccx6RNbbk+mTgVgy
X-Gm-Gg: AYBFou07/aGdETRfby0x0nH3yR9QOD82iWIHXpK2Dc0wsWbGgXISE7AstCYmTZssyvb
	mXRoyAA/VA7cTVc2aSAhliiYISgBQ5BRIiuQJC0XFIKgT8fUffLx2mxE9nFWWiTETpa945GhJD5
	soxRgHvlfQG7INnxeBOj40qM9V9GxB4kijEHkK9utx6P/V0HbRBnzHsLvEftvpF6gE5PPgOvKA0
	7amh4wfvWf54vViVOcNNuky6BMN7elBCaqgQDuQNLzpXS7i0HwgUsVPanvupO/xVyhhmsJZgo2y
	pdvx0DYdC4lIyLr7/1tnoeg8hIWGZBJ2Huu8WtQUkAVdB+N/+FfF3rndNy6mQ0bXHpnAxF0DqrJ
	O1AA8Z1uNevrBm/jMFtxgeclzFAkTsWRTlkSd3ysdsO0Tlg7ZXSwq97T25P+E5K9Kn+RGDgBKeE
	Zpy658IaNbVU2JvHdruxEX8gmx4wo9F32cD3BXkmle9agkmkto5MtM0idJkswiI3HLJfqLvQAj
X-Received: by 2002:a17:903:1b63:b0:2dd:ad74:ac1d with SMTP id d9443c01a7336-2ddad74ad63mr17538865ad.24.1789664889696;
        Thu, 17 Sep 2026 10:08:09 -0700 (PDT)
Received: from archlinux ([2402:e280:411b:ec:aa93:b1ec:5a6b:5fce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd90c7b215sm28274645ad.72.2026.09.17.10.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:08:09 -0700 (PDT)
From: Adarsh Das <adarshdas950@gmail.com>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kobject: fix uevent socket use-after-free on net namespace delete
Date: Thu, 17 Sep 2026 22:38:04 +0530
Message-ID: <20260917170804.102139-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917144206.85836-1-adarshdas950@gmail.com>
References: <20260917144206.85836-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

v2 adds Assisted-by and Tested-by tags as requested.

Local testing: syzbot C repro on unfixed master with -smp 4 (parallel
runs) reproduced the KASAN UAF. With patch applied, no KASAN.

Syzbot testing: #syz test with patch on upstream — Result OK
https://syzkaller.appspot.com/bug?extid=4393dfdddf166f2de2b0

Adarsh
