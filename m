Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE0337688
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734111; cv=none; b=mjw6Qs0BTA/b14o/w0LoVpZdMUdVQxvNlgXFv9u6Z7QOUCHym1eJbXpO13dvJcUM8gjEiQ8nc7J4lpvgrdCbP1/SXDZ9pAKIVpK0t9vgSxi+z9z9gQfEHlM8F3eNjMOxvW9aQDFjfKy/3gyM1e7zblLUzKGEwp/MRyb/9K8p3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734111; c=relaxed/simple;
	bh=wht2xhdursra1DqKCuzlOsUUwuTyyTmE9hTf79owqPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Imbq5wwBIaH7EPKOilpqcJHfzoR86dBTNRqlXMDxmbmTrtzoIlEDnfNhTKmKs9Gr56aRVH76sJ3GlCHg1Vqp5+001croVy5qYgueG4skWlzy8eBbLjQu6wkY1yxOBiyOv+3GXl3doVsX646PkJ7bRB0Cw7OjMAIzQI7TyDuv+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMMew5rK; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMMew5rK"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e94120192dso299655e0c.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791734107; x=1792338907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wht2xhdursra1DqKCuzlOsUUwuTyyTmE9hTf79owqPA=;
        b=oMMew5rK84YNXcyWFdANcltK5g/jvkpetqBkO85YunfyfUa3aRwXg3Lu+VkBE7TA4G
         1DmaFSHxzc0sFWNSPRmKYWgmRmGq7PFOlTYQLQpmA7qKXUu6Mj51QQKQdtqMob4wSnZJ
         eJaEtmmX35Cf512KAEbEkR0wQEhouW5FsCF1zUq9U9Q0L/LlQpm2BCuMkLiw2we0pTMC
         KbHAmfDKtsIi+iw4L4jDbp6fkNiOpJwEDDB7w8e9ObgVnw9tWPn10ATZ040HW7ZrcDE/
         Hq2zmaSgItbu0LTn1MDMfE2Wvrh5+g2zfZY9IVAR2IDbtnstYbMOOlRdZEOy9vEYhrnZ
         il8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791734107; x=1792338907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wht2xhdursra1DqKCuzlOsUUwuTyyTmE9hTf79owqPA=;
        b=Z+ZuoYC+bVKBPrzE0pA9Nndh0/yaniN+AwlPmKbjTFbvJRpm/6w4n4Lz2VfqDijQFW
         pzugtijC007U9be5m6vsMaX2k6FLh+3AavuKvAbv1qZZzxz9NeEn5iJyNPJjLsSY09+k
         qpYLj82jeTa8tt9xdYvAxBEKp6U5dgXtg9KrfqLFXHw3ElzK9j7cB1eETjbhAebvBnAG
         usKfr7jcXR9gGtXdAkBXVq9p4uxEmwsnf70SU6MQZaqrjse19V0EYyLEvKRJTZMvTafh
         3iCkDPM78QpzQrC0w/AEQXEg+cTV59cutGi9Y/UCnb9E+Suv0urR1q+TZE9nMmbrCM3x
         cxyg==
X-Forwarded-Encrypted: i=1; AKwUvByaGykOxeEY/UCuR+gG3tsiuQlI3GqeewxfCogOA5UlXuwWIgldNKxuYoWZxJmpxAqOca6U8hQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJB22hy+uQqgRssuCjlWNPrNKrRf6uYrdcrtYqkFLXC6R9mVKIx
	cx2fug3/7qRZHNDtAvMKgjeZUw1mRW3C0HrM2Ug1fRt7OmSUafMfUK4M
X-Gm-Gg: AYBFou0dR/Tnm8J6BwjdMxtHG6l5GOdEheTGRC46I5PtzEv9RCp40/GN7hfeIezhW5L
	uuO7o1LYkKrabNLxcytG3Rhlnq8jLOA2ru+Rup3wXVFibtluyRGQbsmbRsiLergh0tvA1aQv0Gt
	PJvz9a4VxWB+E1qKMdGkQSvyv2W6JRWjweOU3ao5EpWOzKx1tglw+lSBO3CkRT7fYjbJ6wb/gay
	n1rT3Gj27RV0SFXD68oCF0+kuJJm7XalJ3bLd2eF1QcP3rbEyERiv94Pye0gEBhOPtiwkXR8NGp
	rbgY3ZauynkDSE9FFR8ViJEYUdiIZkV54aRYwfGKGo7dAkwr/z/cY2nJkLvVi4E8ZdfCUUqAfRX
	EWvNsuFeiS3M6YHTpWiP048j7BjuVzTbu1c6JkCW/wZi7u8oY+mL+Og8mOrhyt6fNVfTMHAduTE
	s6p4mJOXO/p8Mpm+qgTxpbRczlogN61hOrOY12c/4UUoD/x5PQyk+oOW2yA8Ut+KE=
X-Received: by 2002:a05:6102:4bca:b0:7c3:fcb7:8c8c with SMTP id ada2fe7eead31-7cb3738b509mr1700102137.29.1791734107383;
        Sun, 11 Oct 2026 08:55:07 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003ae1577sm5130367241.0.2026.10.11.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 08:55:06 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org
Cc: khtsai@google.com,
	ivo.g.dimitrov.75@gmail.com,
	faqiang.zhu@nxp.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Fix NULL pointer deref in debug logging
Date: Sun, 11 Oct 2026 12:54:59 -0300
Message-ID: <20261011155459.1196100-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026101116-shortlist-trend-5e9d@gregkh>
References: <2026101116-shortlist-trend-5e9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

You're right. I spent a good while checking macro call sites,
tracing dev->net lifetime, and verifying scope, then used an
LLM to help draft the writeup. Clearly I'm better at reading
code than writing about it :) I'll keep it shorter next time.

The patch looks correct to me as-is.

Thanks,
Aldo
