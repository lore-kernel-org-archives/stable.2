Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3D37E5E9
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501919; cv=none; b=LD1d+ezrIjM9TtJ34WQUhjae163bMKW7JrBReI9h+YyCJ9lrnqCLh7/dHhxspso+XK2NuHsZ7VWwojp4PQUGbtIb+e3z0+ZALA1N8NnIaS/+E7Lq/OErqzic9RWRP6ZAgi/ZEw3cUz6tzJyTv1yIDWNNMmAGlhXbRuhY4jj36I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501919; c=relaxed/simple;
	bh=bKVl5EPxdtpk2JfngniCgZ1c/53BvJXdrA/23hblqTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lI4NYffEVbOgkYSD8OgtHIo4lPn7Frrr484WA2+35SF9XsplyV9nxbB6XJWnMpk8RF6HaFKguOTCV/GcQODdWVE3bcOZM2pefBU1VJlzqXrFdlsvKYT1NVZgPAbqL3LJs0J19aw5dcxTuLBY5Scuu12yFOEBaxLwNobmSOQsClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmOnCern; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmOnCern"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e529da9so48871e0c.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789501917; x=1790106717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bKVl5EPxdtpk2JfngniCgZ1c/53BvJXdrA/23hblqTU=;
        b=EmOnCernvjuloBz9pl+YCk+s8O+IcFX1DXmV2IYgYK5Z1i7TohuVUeGAwO2MiSlYnp
         fLQBx5wsJ5BbMI/8f9YFg1dXfaP2Y3tpYpwgxaSGLmUiNkIaTI+XJDadReFjIf6EgZc7
         73rsbQtoOMK/jdRVLjfzhJoX83N4ZbHtDQcGFItjWGr8S288c/oj77w/h89Z3BKMC2A7
         JU+siw+8vBw1i3uXxnX2YdFqBP51nOZL3MZsnprRlr944MIehv+odD2fYac5rlDOIoqC
         BdVpBZf5NbSNEL7YGqyC7BYnYlQHiqUdxzNv9+fNWPys6LQK0sjpnLhRrk3r0t1YvO5p
         lr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501917; x=1790106717;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKVl5EPxdtpk2JfngniCgZ1c/53BvJXdrA/23hblqTU=;
        b=QWRLN0yT4mRVlESHYAd3KaZGiuM8vvCMte3DrjnDtuNxwCbyS4J4p7Sy23RawcvVYm
         94AExTXDweVK8Ipexe2Ehzz/yl7oJq9XUOVp7R1gXAEAGH5RJoxyEgx59fCP1Xal5UyC
         7sKaPCdyqTNfNgmTJgQ2XNhNUwyB/uc8pq6nTnqdOk0yKzZd7AN+jHgVtY1Bd8+m6nEr
         UXz3YT0oaFHA3UuV2tk/iWZEt2RCdoSKR86afJc31ZKcMRQ7YMay5K+2posF05o4KpGB
         tsmhI5RYgAicfOwg3mtqWnSpApQ6W5uI547B379TtbX1xL8hLW+kNvs3BoHaddR6UZvf
         /jdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyDVkdFAP9pnMa9/UDwXPsp4yCwxKzpex5yBFjBAiwtF5FbLlv6X92pNoSS/ogtmJBPPp6K7s=@vger.kernel.org
X-Gm-Message-State: AFuF++kDvgJUXul3VGtV69JLcxcnw3/pMqBVv5kRQUHFx3pksoa2SK8o
	dd7z/ulYCptuUyVLDJLkGT3SbuTUxvlOBCoyJXqCOKPiG9bxUlXiWevL
X-Gm-Gg: AYBFou1DGqdQQxjUPo+EAZ6Uvns4m+PqtRrj42UZYBDlHauT9GOFFNBHmCI5V18EiPw
	Cca66K/XkKZMyN8gL3YoBlNmypJK76IlkYpo2ukU8ZIr8oEZuPKfIWqYG+9NuJjxogNmLVDCTZR
	TeiB6FqaljtG72x9JrJ8Ny6L22gAuuVGsDF6fEixOvGIM5FpcD7hvn0im1GQGOseb2tiZFY6+zc
	JoeBKabo8wBXkBVhD0sPMdwaOaUnfkZKjCzcreOcnjnWY2M8ZyAkmbwAcws1/NCnrcKaQcnp3CZ
	h1ajuaZjksOda3IkL9+WZ8upfHrir8uVszVsoozdML/d0tHobLmQa7NEZyAyFahxnXUNWCE6619
	z5WbnPV6MyY4Kx2VLad66qJ07yOnNtTAYQe/yreZ62F9bhJcqxpNq1HB7t0aSP7KuOUEF5POS5q
	82/Hd9DbPH2ftRso0Z1ZJ9yImyhTciHou9OpqDjxCgpChybYtzM8EBOqX8nzbS/acP
X-Received: by 2002:a05:6122:8d5:b0:5bd:b2e1:e1f5 with SMTP id 71dfb90a1353d-5c981a8a2f5mr5665227e0c.2.1789501916850;
        Tue, 15 Sep 2026 12:51:56 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c998a65a83sm564826e0c.10.2026.09.15.12.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:51:56 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH] nilfs2: validate segment number in nilfs_sufile_get_suinfo()
Date: Tue, 15 Sep 2026 16:51:38 -0300
Message-ID: <20260915195138.3331490-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <MSG-ID-sufile-v1>
References: <MSG-ID-sufile-v1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

Good catch, no need for a separate variable. I'll reuse nsegs in v2.

Aldo
