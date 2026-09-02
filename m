Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282C2C0F8C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378797; cv=none; b=s61zshtx8cFQJxAccKVXfjZp2Hdgh63rtlz3tYA9RiknlVJ/PGj0yeNwzrzJ+gXbZQYWOcsRlx99nCCuwvTQ9gAp8GD4gkfcCPUk7EwdqvGL0PEX+9O+9/C6llXxAgLH0XhMGdk0gcE3wZB+o+TzIuyVEYnAphoaPbNbDHqvd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378797; c=relaxed/simple;
	bh=vr6W5zFpVz8w0VHMme/yDcx9OPftCRNIo4AFcnhZPtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md0CErJaWTKZjJBYwSLnD0vZ8q+biDt9Ga9GkX7SOTu1XQv0gJwHV6AYSPxZhZ7+Vptv+yUEwzzKzyay5VTGrQUVx6rRkmzWSIG90VC3uffUZfl0V8XtwTa7+Jftgb+ZZKsu5xajv46mF+m1ViM2mqh/qBE/RD28lNRWWS8WJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpD1KkVR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpD1KkVR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so1052553f8f.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788378786; x=1788983586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uw/w31b9K+Bo5B9bJ2pBdij1/BOB3D6uwkiUGcYBOoc=;
        b=FpD1KkVRQ6ip1P1cfhHQc+TUFKZorOz2rEkEJiN9sxbO9abeWr+Az0MR3bKe5yvYhK
         /EE/ylsBdQQNYDD1Gzc0jGRixN6E1DGHSETBJrJDRbtuVrfMiMDAkXv4WHiB8wYNuksq
         i8SlVEHcxoaB5oLHpSgTCVPLlnaVQyUZOZTF2t3hN3riC+VrcxUpeNq5zQ5i2pXf8n95
         /brTAPQtOCJyQQzoYUcpvTRMjCLzusxniEzvBg2Mlw5Fp87X8v77I8AeDBmiiLz2blUo
         Tq46VgPNvyPVrg5yJjcE+GEyPSNeZ/Cxs2wTevFXD2s/0YZWZ9PjIDvlHkuXA6xjLVVC
         +O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378786; x=1788983586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uw/w31b9K+Bo5B9bJ2pBdij1/BOB3D6uwkiUGcYBOoc=;
        b=OSvduHzGnZTHvK/jw/WJUNYCynSoLBonBDFYxQFLEu53kE6VCY+KNEkszW/KgQMOtp
         PC+0nLHCVyr9VD/7eeuPgD6yEswEuwZnd05sU8VVd0htS23vvs/+i/AFZjW3w/DufVeM
         eyIIOSI4ec26PfGokyw9pWoLsTky/CXMtcmFceuCHP+QMFmLr35G4ddKkcOvcMR9XL8V
         Cp4e4SZ3bcuQqMoi+9hI7qnJjXHGkuvFQkGGhErJXbPcJpRoj9JhwFoavfckOIEOMcK7
         ldEWXjZcxXg/UGHA7V56rbVpQYlFfBN0S9uSV/kNQ8PelcOOp6QGXBtJEgw9xIWxJW4c
         ZEyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO34Y6cv8h2Y/bazcU8qUboy0/ri6M65RI9nNIKRvAhFLJeJum7ela3WmbBcHbLsEcnNSexOY=@vger.kernel.org
X-Gm-Message-State: AFuF++mb3gfSahWkeiGLAoNCYhF0jtE9vvtr+k9wmN+23EbxmJdDe2hW
	P8d5RRVKvUO2FRr9jH+U7gPPWQkz2WPJjqLZ1/PHCUkrO8Kh0cZ9khLYh+OYSg9W
X-Gm-Gg: AYBFou0GPhieJXjs7Gpeat3I4W55bPoe0aXA8VvWrnWffj0dEneEmxky8nCNDVdYMsx
	eXeXkkBks7gKWE9CanA+yUrzNxj8KbYs48JsXp5E+DU0JIRhc8RJ667ly3Bn8RGo2Kker+iwvH5
	SYPdvXjDmgMRQSJosLB5p4evlln4+5BWRCvndLGrZ+dO7GRNUx1vIAB1CrRUJ5StvTo5DVicbRF
	DDKow0ny3QQ5DeZJCyvzx8fl3N03Rh1iHKf2xikhxZbNmajHBI7Y87wj2nMgVYeRuhYeGxDGTIo
	JlLgMwCsD1GeplCBIPKp1PNoARaKDPGzs0hSLYwAf6vlIRnzM0ox4biTV6lDPb/BYU1BpRwWdjr
	WmgjZQm/J3VX5Ef1U1BUZIXKCVFCyk70EoZqyCsqdj5I2nmLAT29L/5Gq5C9Lt+HY7VVmO6wxgo
	hNFkxukXu9370sxDHUQpyaSr8SDY6CsNZ2+1JqQ2d7c/oxR0IuHEqlpsKbjNMjZSE=
X-Received: by 2002:a05:6000:701:b0:484:3600:35b2 with SMTP id ffacd0b85a97d-48488f00a25mr11965360f8f.5.1788378785721;
        Wed, 02 Sep 2026 12:53:05 -0700 (PDT)
Received: from gentoo ([45.150.111.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed30c0sm8552779f8f.24.2026.09.02.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:53:04 -0700 (PDT)
From: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	aconole@redhat.com,
	sbrivio@redhat.com,
	gnault@redhat.com,
	laikabcprice@gmail.com,
	rough.rock3059@datachamp.fr,
	stable@vger.kernel.org,
	Yaroslav Dudkov <aroslavdudkov622@gmail.com>
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error for PMTUD
Date: Wed,  2 Sep 2026 19:50:10 +0000
Message-ID: <20260902195012.265628-1-aroslavdudkov622@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com>
References: <20260902190112.4126199-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 02, 2026 at 07:01:12PM +0000, Ido Schimmel wrote:
> Fix this by making sure that the ICMP error packet does not have a valid
> dst entry, thereby forcing the IP layer to perform a route lookup.

Tested on net with this patch applied:

- pmtu.sh: all 16 bridged and all 16 OVS subtests pass, both with and
  without br_netfilter loaded. Without the patch, loading br_netfilter
  makes all 16 bridged subtests fail (the reply gets delivered and exits
  with the old -w 1 failure).

- The forwarded-sender reproducer from my earlier mail goes from
  10 tx / 0 rx / no errors to 10 tx / 8 rx / +1 error, the error being
  "From 192.168.4.1 icmp_seq=1 Frag needed and DF set (mtu = 3950)" --
  the tunnel's PTB reaching the sender.

Tested-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
