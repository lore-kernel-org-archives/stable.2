Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD374BB264
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493471; cv=none; b=XNZVmZ4kj9VdR4ZCdzASeeS1Yrio4XZcKjUKTOphmb2hIlNHa5Ny85uWmKrt8bbzA1KmB4rm9jkBe9bv9FZ2TWwkIx1u0cvMd7kQKs/05BxHmjB6raIgJwv2dTqsM/zYh8+aa2ec2hnmUtpyanCmHzj0i2m36n9Q4OQFtEFEX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493471; c=relaxed/simple;
	bh=1L41fDFcwJhnqwC3iHJYWgVyCIQZycnmy2yM9XthIjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezXCqZE/owoigrjzT9kT85ESzIwf12SlVr5OJQgbvwJyvMIXXMJhxE9qASNOrZAkpBdxNv8/c8gxRScmiHQ090a778pX10qQ4Oa/+njUiyjD9BziVM+zKrBDowAKUUAj8vlTG1r+98pFs9vtrAdXfU8YJvlqmPXoCjYWCq89RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxIAC1a+; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxIAC1a+"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982e8fa91d3so576932241.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493467; x=1790098267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RgblY6L8XKeLM/vcFnT7fWo1z7GUneU5Hum0ZMmOcJE=;
        b=oxIAC1a+UZ+J75VEHH2IzFKpwEeCcYfBwKmlierodh1vG/bMJaGH+qLXPFhFYmiuJM
         ldjoKSl5YcMqxQN5f9E8jr8po7mTnEeUBgAJsipixKbs1/vMqf9rdqyi3llik5emzIFa
         gqHDrXymdiU+9xxhfgTWBt6dqxfKZKvCU8mdH8v0pjdQPTLp1wTwj9xFiRpj1EBbOTnN
         vsnZQUv6mAFWE7KrasvC/EGfKCEm4VMT/yE3mZzpFCFlM8V0/2/aMP588NuVQm96o5L3
         zRU51FI79U4ZJTgO/B397rPcWlIXg+ide6sbGxB+1aJkNRVDwampwZ04P2IuMSFx6Nio
         HUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493467; x=1790098267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RgblY6L8XKeLM/vcFnT7fWo1z7GUneU5Hum0ZMmOcJE=;
        b=bj3oOedhUPe39v6m66dxo2++nZXaZHXdkI5FppClKokjv7faD2ibMKFPIfLMVJNFF8
         4MMl13rF1Cc4dNUrEDxAtVcxDTluXKIT3RwF0XX7lKN8xpfgmCY4WW0HLUoEoX4qPgfi
         +8PO+LZDGFZcZooTDXVJM+Tyo7a6kBYaZf24ZFOi+CYStSWe27aqDTDT8LzNutqw/H8M
         vLatw8haxeh0gM6YPEGI338L4bInF3PQrjVMjp0TAggQLO+AovjVyNrGtCv9mBUSWNJp
         SUzF4NjWWnCqGJDgWz4fYL9skjsHmTy4SdF6U3XMDExQiiyw37Cvc5jPRG/DVT9myWn9
         NRkA==
X-Forwarded-Encrypted: i=1; AKwUvByFX8JS3DNk/iZYi7vU5BQYONiEfaThE/BsiICt5/IUwL7O47vUsvOQeYtTviMgEqn2dLEbTQc=@vger.kernel.org
X-Gm-Message-State: AFuF++lnb3N0GMyem/QtgVofj/7Jpjfc0F7M7pl+KNHlzkQ/ZtTaj8aP
	KGav91uE40NkSMqG18f3F537ChI77gxNZlJVm17T+MMeSZTjnqfWe29Q
X-Gm-Gg: AYBFou0mbeUyK4MIGD7zZmjVCW2rdWk5Dmdf39I2H9q73MS0E6RcupM40UKqmlmZ3Pe
	SI1Lg0s06Pz/BKF4aMJUCzVdvVqCmNNC2brA2ZzmdR4dIcD+H4NB6e9GNVPllwJcGM1dxBLkCDp
	OTaO3Iy+GhSX/Z3Yb5z03G4w4f0zht07GVLP0CXklcyJ3SHkcD/58e1OyOa1YBP6aD9j/I4h+xw
	ZBqGI+mp6+IreQUGOOeu92lydodR0E2uhD+qiILIYaWka9oQ/Jvyvjylpib9jzX7HTL2OQri7tC
	C1HZ2pAf+GosYAhtq06i853S5vWs3XvRJnG+RM6JsSkj7/bZTCtuZqg6dqeAg64WluIMf7Y5czZ
	w8DMxql2/AEyWVSHQpYYlYXm3lAUj+g+3lnjdY4aRVV9DCCzqoADYBGC+j0hFthw9ov52z2QR5m
	8uFub+Zpzg4F7Mh/bm/RVjgGe0z7AzGYilMOXD6KNEBP6YWdaDtsmDqzg4hdB9sC5F
X-Received: by 2002:a05:6102:8687:10b0:799:f608:79e6 with SMTP id ada2fe7eead31-79d2319d752mr2295720137.1.1789493465871;
        Tue, 15 Sep 2026 10:31:05 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79fb104b2a6sm310677137.3.2026.09.15.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:31:05 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3] vsock: ignore empty child namespace mode writes
Date: Tue, 15 Sep 2026 14:30:50 -0300
Message-ID: <20260915173050.3176344-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vsock_net_mode_string() returns success without updating new_mode when
the transfer length is zero. Its caller then reads the uninitialized enum
and may permanently store a stack-derived value in the write-once child
mode.

Return before calling __vsock_net_mode_string() when *lenp is zero so
that the helper is never invoked with nothing to parse and new_mode is
never read uninitialized. This also prevents an empty write from
locking the current mode.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v3:
  - Move the !*lenp early return before __vsock_net_mode_string()
    instead of after it, as suggested by Stefano Garzarella.
  - Add missing maintainer CCs per get_maintainer.pl.
  - Add Luigi's Reviewed-by.

Changes in v2:
  - Return early instead of initializing new_mode to the current
    value, which would silently consume the write-once transition.

 net/vmw_vsock/af_vsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467..XXXXXXX 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,

 	net = container_of(table->data, struct net, vsock.child_ns_mode);

+	if (!*lenp)
+		return 0;
+
 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				      vsock_net_child_mode(net), &new_mode);
 	if (ret)

--
2.43.0
