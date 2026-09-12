Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BD47ACD7
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244396; cv=none; b=Bbv5U7+Xyb0zu0gTunsHvDQkbo0/bjZF858/A0JFS7TACNd2LinqXv3BCVqUboMgY2Fynr75vHRC14vLXh9p1XnTVU0KBPsXQgL43hoFskp5Y+kPUoX5gLj3tGdyfjN3SuZtYGUhIEJsfQVIdZFORMya2Owwz977S5J++wr7drw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244396; c=relaxed/simple;
	bh=txURU+K8mrxI98s4PbzewGVHcFWr+Th149VPC2FxOHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiJ/bhzmwlMjLI0z/aFLRX4iAQeEBAVzm8xhuerrKQAolKynAny/WIdAF7zFipaA5lpS5RerFZkvUEZYYC2N8RFetWanWuSCgF/d0h3WTg0zsNGVAmme5uKWx4MjXR2JYiln4mVYm0i1u3VA1+0ZhBQ80IeZeMm8PKXvhOCL/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJ0iX3HM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ0iX3HM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so22642355e9.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 13:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789244391; x=1789849191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=txURU+K8mrxI98s4PbzewGVHcFWr+Th149VPC2FxOHw=;
        b=rJ0iX3HMldwTFU/FeS623RlgP+7XPco6cKhgRbfd8iTZmnSql8zRmykXFUI9IAOqiN
         f25CCfCr52QEHXV4hT4tW6rNgJBjaHRt/W/PedUDBxzKOsi7hm1uV8VQuRsp9Qr6mpJD
         2NGCDEXQRE6f9Jr3/pC3TVrUdUlBcho2Azg+Gqu51jMc+ynyUjrJ2LSdMj6wP7OT2yRu
         7UilUp4TNNRAWRheekVCvf5rP0i7l56B3+F8AzqREevLyHE42F6Z9VFIwTGkZWCjyTJX
         noqA4t70aHjvNiz8r/XEgSEg7bAwZcoxMkfj4LmaNYdLBHZBfIZ+MU2crh+Ap4q7zaCB
         vCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789244391; x=1789849191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=txURU+K8mrxI98s4PbzewGVHcFWr+Th149VPC2FxOHw=;
        b=Syst9Ffb5TL2tvcweDfvR+2KYhsiyrf2VFC75u4dgFvYRnzFuBUrFFIUU2PKONCOEs
         AzGmfmm8aT3CwdzVsjZ3porNP8Fjnbj56m1P4cwiQEUuAjQOgcEQgRVe1/5iA3FE7SQe
         AMynh4DsJQ/4MRMgOeZc2CBmgg8MW0P+ixrZFT3vlfmloxjWpgtZapMwmNxztFoKC0vt
         jcEUIg07iltjIlMNVst6Gb+B4gyp8C2b+ydOufa8cFysgDo7JpnOL62ovtHbOIUXsPaJ
         JksXwaXqlkXvKhO6EZ20OQOnVeK3kFqhNuWYHS9U1nJ2N6w7QQnJBFlOoUYcvlwY4zg9
         l36Q==
X-Forwarded-Encrypted: i=1; AKwUvBw729LTNW+z9j/hp9CV+sPgb5kUEmceOAcvyX0No0lZTvx3mn4Xjx9A56L4V74BCXXNICMu07I=@vger.kernel.org
X-Gm-Message-State: AFuF++nM+QqhRD62m+6dB8fyUDrfDW6X9xXgsNNCtrz9LZawykXjdFgm
	4bXvqVfsuNJWRcosHlmaSDPPchaQXx38KK1KqKOO97ZT346z8IiyRkyD
X-Gm-Gg: AYBFou3tuS+W5I8ObInmNA67z5pPMAcOIuzt9ztB9Ank2CUDPgxxbRFDXJFsQsv0B29
	XOKuILws3NtV5M05FDffGRwlHlHSJ/XJ8z9F4fConmf09llBnsipBHiCQJnIOP4hjs4xgM/0GMZ
	YWrQlvExd6zzs9DMwvVm99JtBUJWNJDO3hHaj0DDzlQhTKOTj2S9O6gGT03esu9El3FIAmbTmzS
	AnrJGCti6nORGROgDimRQqod7zt34z7Rr6ziU9IfTSJsinsL8m9nKaDMzHcN+OSxMPcVLshjUz8
	3zFaF2unbgtwiiWNJ6lsXi9nnuFS5xzZFW8DAC3cOSBYoUBg9tWyiLKqE93m6948dQZaafuDw0u
	ZClxI35IaFrTGEgIU5eWYr7UpPApDIDdLMzOCNUk55zJF1qVW3NTzT0lKGvQahMhBfma3GfJqYH
	LpkLTMFE6sgogArOsW343FhxlZM7V/9PsexnqvqOXSQgzC4wMO3Fpk9uvbv8WYHDNWni7PyYdYc
	P3JVyzYdj9WNKA7qsg448sKeDfAYEBTk8O4IDuhrHkOIJIGv4tRO21HKP3Lr2VF4DW7bDIiRV+z
	Ws53Qq9XIOpxc7g7GhRjSVm7zHo4wje5gN97xuK5OIM1ImY0FWabUa/AbEmplQsyBJbfDaW1fRe
	O9lsmyAE=
X-Received: by 2002:a05:600c:8b41:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49e6198865dmr131747885e9.8.1789244391211;
        Sat, 12 Sep 2026 13:19:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a81943sm119571285e9.1.2026.09.12.13.19.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 13:19:50 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	tianshuo han <hantianshuo233@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 836/935] ksmbd: limit repeated connections from clients with the same IP
Date: Sat, 12 Sep 2026 22:19:46 +0200
Message-Id: <20260912201946.77500-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065545.998510042@linuxfoundation.org>
References: <20260912065526.833703348@linuxfoundation.org> <20260912065545.998510042@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless a 5.15 backport of upstream commit
98a5fd31cbf7 ("ksmbd: close accepted socket when per-IP limit rejects
connection") can also be included.

The new -EAGAIN path continues after kernel_accept() without releasing
client_sk.

I reproduced this on 5.15.221-rc1 in QEMU: with one connection
held open, five rejected connections from the same address left five
server-side port-445 sockets in CLOSE_WAIT and raised "sockets: used" from
4 to 9.

With only the applicable 98a5fd31cbf7 hunk applied, the same test
left no sockets in CLOSE_WAIT and the used count stayed at 4.

Thanks,
Karl
