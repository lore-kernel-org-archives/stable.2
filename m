Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D935F5E7
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025357; cv=none; b=Wmy7HfanqOX3rp/bPRDFZlfrBC1pl+yu7yp3dee5mSAdesxc0t6mJaihHpb7OYiuSQX5ngEIn1MOVx7bU+/Z0z7wtNe9X5fQsHLBTQfKqBs1wDJSAd4Y7YGf2DM2sg9PyCrXF9J5yxQ2llEmfHczvKn9obD2+QbQvRpK4ZqUCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025357; c=relaxed/simple;
	bh=mNkktjIBhFvG2qkDlcIxBp61zg27Rct3yqZtnKnK+Xg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Lgh1EUVDncLDpeLJQMNWS/vv4xvgHpEM+kE8mydyM/5U39Wwr2mXyvqR2qN3HCjheb6BtEciuG++VYGGzOmNAekPB6TJDmsd59ap0DKkN7iOOUApmd3FnQ3wMzZzcJwP4CIwGknJ4xsyH7K2szNir/rtxZgNGvcyia0NAiS07g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahBWc7uH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahBWc7uH"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso4287788b3a.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787025356; x=1787630156; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bmnhuank32qRoTHhcSzetzlluMM3ogUWu7ffskHGsHU=;
        b=ahBWc7uHVZJticgiZBJCZhaO5sj1LQgUV5aMNpdKI6AGjwj8C2Imzs9BOJSY2HmhfF
         4b61ejCpuE1r/SAb9FvEUnxfHYdXxQ1QQGT3Eo+Wd9Nmgwt3K/xO36Z5Ppl3vWYwXBPH
         d2sHXWSKqRyY457iKmxj1OaFb6Cinh2N9D0kDxRvpyWshnHKBpIgq9WSMALL3aOSJBLJ
         RkqVIObvzlUzYYbEkvkaLhI56KetfZHuZ2u5OQFwyqrltBnqNao8NT0Kta2jIL/0k4wi
         SxKibKIjkhpqzimWfKnCwJGnenLQfTMaK/sbn9QjhdvRGtz3NicYBClTXIR1zDuKIhs+
         6mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787025356; x=1787630156;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bmnhuank32qRoTHhcSzetzlluMM3ogUWu7ffskHGsHU=;
        b=NPy/MufahMCLXx2yLmcQQ2DNjX1nQk0gkzyLO9Jeh2qeexAg75g74IQK8GKXrpu2o1
         ozTY/P0SJVm50cEzne5G/0u2rNm8mMSM9UMSJQLoYLQEPxDsx4R7m1s5vrANyqpmhYVE
         h3a5E6xsGEsw+iTNj2ZQkXVoUt/uOD8wjI8gSIRy9kx9xXG8cEyxGtMFBSEdRmb0hXhG
         pqPovBMlODTDeJaMoQzJnnjZXIn4gf3Viq/aJhtYjrzb+ha07bRI96QdqwGdxiYvV2BA
         8y9cDpDBBX2rmRfcFdL1EYUEUIrDqUEAJoFvB5dEMjqKbWuXHzBFdzhW7hSBKz+CuMyN
         34fQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvlQX4GwCFq/GBUmx1xU6z0a2H7c1Jk4bfPz8998xqLSBUYkH/WE+kAapLjHx3AMDm2EwDeXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqDEdjDf6conbxy2WMHvDaGympZFAc9tI66lhTSb3FiP1o8pz
	mgYzPCSj2/CTPUfRdnozGEKBPQoNYtosxyZM6/aC0Tsa0zQzqCZlMoOU
X-Gm-Gg: AR+sD12ZFAX1WutnglH8dNyHoHiKvKRfi17mrDA6H1FVxExO2QoDHB1dhVR6+WErwNM
	xFH9njBkpV/iXw7yWhwuP+8SL633kZj01gz78jDVh2c6umUdVWw6KcQTkMxLITC86osFcpQ8CJu
	k6tKMKDLR7oVxL86dvZHsj3DsgHk+jFxm+f7lk8SZ8N4+VHGk8n/hWsPsUPFb7mhPoNJrqokEQS
	4RgvnhWUAdBqUAkwZdgMz1ypGEafIXclG7a4rg87d9DLC2F0ceKDWKWbPD4MzwhHrUZw6xoniuV
	Sdu5EivyGDDDAhsuQ/aMNzW4Vwo2MYBULzNZ2ih8PSXLCZbd16PWVICo1RbyncpFH3ZDuGWNis/
	uX9aTIstBk8815e9NC0A6ZZJhLA4HBaz2A5gwHmhhxzWhfzd7YiLTUZzCO6f2C136ss+Y6FPSLI
	ewFZvkKwTtru+GQ7hCGebBVOfiBOpegravTgeI56A+4WykMbm0OZ1i6zLe97xUV/AjrOgJYxex/
	zo=
X-Received: by 2002:a05:6a00:a244:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-84fde15f198mr26681350b3a.9.1787025355533;
        Mon, 17 Aug 2026 20:55:55 -0700 (PDT)
Received: from smtpclient.apple ([212.87.194.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851c19fe5d3sm132340b3a.57.2026.08.17.20.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2026 20:55:55 -0700 (PDT)
From: Linfeng Sun <linfeng.sun.dev@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 7.1 065/271] vhost_iotlb: bound map allocation in
 add_range
Message-Id: <8C74607E-84F5-46BF-BE37-7F04B62D865E@gmail.com>
Date: Tue, 18 Aug 2026 11:55:21 +0800
Cc: linfeng.sun.dev@gamil.com,
 mst@redhat.com,
 patches@lists.linux.dev,
 sashal@kernel.org,
 stable@vger.kernel.org
To: gregkh@linuxfoundation.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi,
I'm not sure whether it is still possible to correct the domain of my 
email address here. For subsequent kernel commits, I have already 
requested the correction through .mailmap; the corresponding message is:
Message-ID: <20260810184837.ECC451F000E9@smtp.kernel.org>

However, as far as I understand, this does not seem to affect 7.1. If it 
is still possible to update the author information here, I would like it 
to be changed to:
Linfeng Sun <linfeng.sun.dev@gmail.com>

My edu address does not need to be corrected; only the Gmail address needs
to be updated.

I sincerely apologize for the trouble caused by my oversight, and I 
appreciate your help with this. If this cannot be changed at this stage, 
that's fine as well.

Thanks,
Linfeng Sun
