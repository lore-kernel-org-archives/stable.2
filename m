Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E313845D8;
	Tue, 23 Jun 2026 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177771; cv=none; b=bQSoiS11pQAxjvYvEX8/+P4MqzmFLGc3t7KuLiXPl5Vz9TTSQZ6DtuCjAPRpvtD7tBV0RjYifB0W9bTI4GdAFzbXP4toJkoNpqNbEYV5r3++KVyFjTUrOGfX03VFOX71ESougEvfnqwOPCwD+murEQdYRRyHgAOPdHaPUCVxHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177771; c=relaxed/simple;
	bh=2gMFkMAQrW/BA7+IwQktlX2qUqcrPQKdzGus9HDyqWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+UN/fS030SGUULf41Q8CplfofB+zHD+bv97Wwj0vCPUQbxxRUa3FOuONpRakpB2xwYncRSFtKNk+1BErRNegGHM0JFYOHSw7bwRyB2vUCc1E2yUHyhqlKEXk+MvOoC54hiXxs5buXd3/KKPwzYd7/QFDGvoMI8quDHWzbO3GJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGfbgCFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGfbgCFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12171F00A3A;
	Tue, 23 Jun 2026 01:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782177769;
	bh=wiKhmTj/5RgoNGcYgTQIYqio1KFyNm5e6m1cvBDw4eQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MGfbgCFzZKk4plutnehTRFn0PHmkUOWb3N/O6uMWHJVQK4yGunLCWvO9MSNiJuPlf
	 fBub8iueFHDtghORpRJx/x78iQbGP3eAhSrLsKCJO/bf/DvIRmwEQ8oxmk9EY8Cude
	 JAjZa47yXa1Xvv0IDXPoDJbvWNYVlvvam8AQQWd8ys0BT+sO6WGsQC9oFI+HJTrINY
	 z+ar4D+ef6qOUHvGun8Yv7wQmoryMKstJvaudrEQsB2NpZE6NPDq4+33QslYdWIzsk
	 f5OmV8gMIh8CCIv/p1L0bMgl2wJFDLzWsS/+TMlFvjkjmMJQNQQPcU4yhPdo847m4s
	 S1e7mL8f+nihQ==
Date: Mon, 22 Jun 2026 18:22:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Shiraz Saleem <shirazsaleem@microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, Long Li <longli@microsoft.com>, Yury Norov
 <yury.norov@gmail.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Paul Rosswurm
 <paulros@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 net] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <20260622182248.5bfc49ce@kernel.org>
In-Reply-To: <20260619073338.481035-1-shradhagupta@linux.microsoft.com>
References: <20260619073338.481035-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 00:33:35 -0700 Shradha Gupta wrote:
> Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> Cc: stable@vger.kernel.org

If you want this to be a fix -- could you please rewrite the commit
message? What matters most is the comparison before the bad commit,
the bad commit, and then with this fix applied. Perhaps the three
cases you list is that but it's not immediately obvious..
-- 
pw-bot: cr
