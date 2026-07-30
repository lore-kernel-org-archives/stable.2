Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5E37703B;
	Thu, 30 Jul 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379235; cv=none; b=nn6Wcl3qorATXzhIFEOBo6dIyQ+ivNgvfGGQfGjJWs+T6rUUMD24E1F/KzMR45WyXpjb2oc8epkD8YAexS6k5ETHX7uSbdnP8XW+Lj0lfKJUiuCGTakpVglngK+UR6/4a/VQQDFYppP/c3T2ZrBp44qqbP1UD35NWiP4xmTtB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379235; c=relaxed/simple;
	bh=u8GBCjCiD9YckN/s/6GC4/vbPGgZcEUGEFOp92FLB/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnx+S5CNTx6ue4RbRYRZ3GE0H0r5QE2WKjIOxX68AtM+PQroRvwXysDiGkAiq3dF+Tj172LQOpe6ZXkcvHD2ovFCjYjRJ7pCUpcQP9y3dkYUQUmk9mDQdJHnF64ysdMJkaBCFbFPOE17G/5qxu4FMjZBOT1fA+e9JA8Ekqgx2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2IB/JoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2IB/JoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50B11F00A3E;
	Thu, 30 Jul 2026 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379233;
	bh=kc+XxKedbPVstCg9/MXqF99eV6HwEUSAW+te9CYDSOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a2IB/JoJ+R1V4PxAp/D5dX9Sob1buUCSCf0RmjtdbIBW2Jj15owgVmzI270Erh8qx
	 HEd80YZKS1MFF1bUHh+P3yMCL9omRcTj4UVwbUeAbSF73x9vJNj7lftgZvejTb8MfX
	 6uBmnOVMV5XdGcMUjnVeVEZseE14G4aZsGU458VFadcBWCq0fIGgdrrCVL54taEOB8
	 hRScgrbUxeIajhGnFR1wAtKdDvQ4YBeMO5lomtFIhiLU8vwFpYEGQzXrcOhYtCq0kQ
	 WRcOQxBBX1efLnA2EBfnHFAw3hUcj0WjFm/+3C4IS3/a/+dkb8ufwCU+1SwsDIPmep
	 E3od5zRjiaKYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>
Subject: Re: Patch "selftests: net: test PPPoE packets in gro.sh" has been added to the 7.1-stable tree
Date: Wed, 29 Jul 2026 22:40:00 -0400
Message-ID: <20260729223316.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <edf7b946-ca71-4c3f-b942-5e80454d47fe@linux.dev>
References: <edf7b946-ca71-4c3f-b942-5e80454d47fe@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> PPPoE GRO is not supported by kernel version 7.1, so this test will 
> always fail. Please instead rebase the dep commit.

Dropped 6160ec9d03d7 ("selftests: net: test PPPoE packets in gro.sh") from
the 7.1 queue, and re-applied c25dd7439f84 ("selftests: drv-net: add
missing kconfig for psp.py") on its own using Matthieu's resolution
(CONFIG_NET_SCH_INGRESS=y after CONFIG_NET_SCH_FQ=m).

Thanks to you both for catching it.

-- 
Thanks,
Sasha
