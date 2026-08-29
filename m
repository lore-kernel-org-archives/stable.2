Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832B3515EC
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787988880; cv=none; b=nxq+tuYWSWb1v7IGDuHt1D2V5uekkfk6T4LKZ8Igd/nsP/FBpF1+rHXpUMqSnxvPweONWE/dVWz0KwccAj2xeCuKUsV4p1c2p9oKpQVJrZVeHrhra8AGkYVZOOQg1LCtnnWUtQd1hL9JSwPLwBVZn2bVExznZ/4K9+KToPLSWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787988880; c=relaxed/simple;
	bh=Q9A4HLLOLJ4VZXp2cZoje9vbqTGlzIJq57FlolcxsN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY78Y3BRve2mNwBbBh+iQR3mygfqQ8sEsnHZbaRhHINg0J5KsUEpcdqRkQ95bp0PLb8o/s5fTA97PDGLB6ZWdDk295WUn+Zv2JYkSjHaYYuywi3hKyBQgn4RYo+Osytk4kp3tGQ4dWl6tDBc169oc7J0wU9+Km6/2N/887Eew3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdSe0/bJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdSe0/bJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d71ae3455aso26379075ad.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787988878; x=1788593678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4s3+xh6Th5r06sJ9n1pY67GE12kX/ek/r1hd+DmHod0=;
        b=NdSe0/bJ/l6qQxnYTCnoHNeijgFnGd0WhYquBENMPWDZ+lH6EN20MIZOPwHsaGj6H/
         nTRXGYKsh2Q4nAZaJHQOO6HSSe6tq3EJU/l+I1JXMoRjfd3g6hySrpVQjuRdlPA/uQgd
         oQh+tCGnQ6KJYOW8kcmOYDt53BaD8OoUZvkPWMG5J4yMwt8QGe4zvz7xx/2Uqabqqb6A
         vwPDmWXWSW4NqbLa1EJENuw7H4/LJTM8wA8ZGU5eIGr3+G41xvREVbHb0Yqqt8VE4fQo
         6Kb6XFrTplAjFWKAyAlAjPiRgvzbkxfFQAajeVW59PH2xn66W2QsS/YYf7ixqTd2VvL8
         e8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787988878; x=1788593678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4s3+xh6Th5r06sJ9n1pY67GE12kX/ek/r1hd+DmHod0=;
        b=oqut8xxNUXkv33aYMmF3WbWwEdgEs57PRY2LAUhUkAL0FkvOZSy8Y4h8iXspFF2+oU
         tNf2OGcAat3wN1te7krMlgL2Y2a/Vpm/Jh4lgNxI7hmnlHRNoD8bExSN8mz18R0cVMo7
         DYDh1Kt7yp/Imvh7QjijCbLwgADI63Qv7HMCxqL/1/O7PuhoPau5M+MjNU0xhNrI4gBG
         uWuC75+zPQB7+8/uoKAn+hLSeanPF0NEz5DLYlgYrodJvn6LX0pNBKCRtN41iMmb8AZX
         chz5wSNNV+hXNfoIssTWMdsIdRqusXUv8PZZ7O78dHA6rT3Ng7qkwceTUOhPh3vU3q8G
         fz+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxEW2GsFVTEXKBM9gXSc7YhiXuQqDwbB9u0BjGzibQaIebOTR+yqe3sk2+0ytswrq+MxTBqOQE=@vger.kernel.org
X-Gm-Message-State: AFuF++lfDQm1ovqbOE+2UUgRSBau8laqXKKiI/QEytB/kuj88jQOOVSH
	7fgV1Eoqlmr5TdIXWVHn7Q3WojbDQyWttdP+16ZIaQRoWrsQ7fy/dpwN
X-Gm-Gg: AR+sD13zaqF/yYmDnZs0W+BPSmIYn47UmfYrUvCAgtjbxpzRfj4uVvvjUoKmkmE5PFN
	ua+/BRvywdVkoR3HnT5ibrmo6trnJi4begW1rsxlYaxy3htT+UZjG+UkTO8QXpUti5U9798B3oS
	/oNjy0HiFE0zUA3cIzumm/q+7BZeEoZrWi1s+GNndyHbawPrQOyMzuDfZdPJaYvlRp/AptSPVbZ
	DEJ/Fj8QYynRbzidcemIKfhivgRbB7BH15HBqXdNJtbHWVLmNikBqpEWcB5ntT9NYiiwbXZ0FdV
	lCHc/9WozpHHPUHcvGwMiyClntVXE7SrXPGBbRmmdfKhgzR58rC8az2gSoBfwgGYUx4AKkBLxfH
	gtx0kXMm1pj24o9vjDNkQli1QbHGT0XaRLxLMwQYBKAzVWzLQZD4H/No3kUb0ZKmBdmkoD7Mwl3
	8n+UkZy+sUD7WsrQbl0r1/uOrPSTtIr5X4cM1OQQgSnOD7/k6c+HNqTQo9Ct+8Ayb9/L9z3K7yg
	Xxq6ABqdt55OSX2EzxG4B0MxJKWh+pC+kcIbugdyjfMeT7sPhi0G35AEsXIDhjOGiVzbD7tPITK
	WxiC/Rbj6kHazAJVPBtyLYBN+g==
X-Received: by 2002:a17:902:f54e:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d74def63d7mr207522675ad.13.1787988878335;
        Sat, 29 Aug 2026 00:34:38 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm12510169eec.27.2026.08.29.00.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 00:34:37 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: aduggan@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] HID: rmi: fix OOB access with undersized RMI reports
Date: Sat, 29 Aug 2026 15:34:26 +0800
Message-ID: <20260829073426.16390-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825103117.12180-1-98lawweijie@gmail.com>
References: <20260825103117.12180-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Impact information for this patch, in case it is useful for prioritising
it. No change to the patch is required.

I have a working local privilege escalation on this bug. An
attacker-controlled USB device plus an unprivileged process on the target
gives root. Both halves are needed -- it is not remote, and not
device-only.

The disclosure half needs is via USB-only. The initial commit 
already explains the vulnerable path.

Reproduced to a root shell on three kernels. All with KASLR, 
SLAB_FREELIST_RANDOM, SLAB_FREELIST_HARDENED, 
INIT_ON_ALLOC_DEFAULT_ON and HARDENED_USERCOPY
on, and no debug options or debug allocator:

  6.12.69+                  own config     RKC=n    root
  v6.12.105                 own config     RKC=n    root
  v6.12.105                 Ubuntu config  RKC=n    root
  Ubuntu 7.0.0-28-generic   stock          RKC=y    disclosure only

RKC is CONFIG_RANDOM_KMALLOC_CACHES, =y on current Ubuntu, n upstream.
The last two rows are a controlled pair: Ubuntu's own config, rebuilt on
v6.12.105 with that one option off and nothing else changed. With it off
the victim object is adjacent on the first plug and the chain completes;
with it on the device saw no usable neighbour in eight plugs. So on
Ubuntu that option is what stops the write. It does not stop the
disclosure -- KASLR still falls there.

Unsure if CONFIG_RANDOM_KMALLOC_CACHES=y will stop the write every
time or only most of the time as per-boot seed is fixed, and I have
only tested a single boot.

The bug still exists in LTS 6.12.y, as well as mainline. The
code dates to 9fb6bf02e3ad, so this reaches every supported tree.

I have not published the PoC and will not before this is merged. 
If it will be useful for review, do let me know and I will send it
privately to any of you who requests.

Thanks,
Wei Jie Law
