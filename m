Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73937B41B;
	Sat, 10 Oct 2026 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791612974; cv=none; b=lvGqaYT0/A5YZmEds/m9yX2bvqw8q9redVrOrhWZKoXwwosBTDNWzLqbm6uGxC8iksdUpGd1rkGGQKXNdvSvhA06af96qR/v0agW+F6ivA/NjgxbdxXVXc6BWbJkctlxYVQQFYnBpR+ysPIdS00/Tdcd66bIkQfSxSaEMZg2OjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791612974; c=relaxed/simple;
	bh=jN/NZnSAuixYojm0NEwEUqLxz9MnsTNPus0rrTgpP0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlV7Ao7KLbXG1oJj7vwx4xXgwf8rUCXXPNzw4o8K0uFqowZGkJjam0yRl8chjtpLms1iFnZx/nvEU5r+2AaTBfYQd6HurUEqN4Y1kDQ49WZvmV3/0/G76V6yydsOAyUc2v7JKCSzP4ralNRqHFU4Vhvtd4izf5QZGtbuylCsC1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLpj5mRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLpj5mRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E839E1F000FF;
	Sat, 10 Oct 2026 06:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791612972;
	bh=oiuMH7HJW7pUIDP2dypKQpiG1IOqW77KjdCceXFbTmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLpj5mREnDQiGrUmE9cmH/hDrlO5ciZ1nhK3Q9/fiKjGmYVDNq/zp25ojo8/nsVPG
	 T/OMagsjWhSyxWWxo5s21igqts6ttGXFj2Tf9Dfp6BnGzDkHfgtWoWzrfZh/PIgV0D
	 SVFbfItuC3IaunElBGpOXTJbdcIHSeExoD1aJvJvGTZ0OvsMovi3rt2pnNNutHqE11
	 0UGfp4U6SmFsacB5BEguUg+1Fo6P0/M/XSxnoATwfJiMJh8JT3Kh0IBi2hc4y00O/U
	 c1EMWs3A6WU5wqGBUWEq45b35exTQYZRV4m7qJlfR81Nlgl0oy6XhkZaGOYl2vYaKe
	 1OgQ2j3Gyi6NA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>
Subject: Re: [PATCH] serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on uninitialised ports
Date: Sat, 10 Oct 2026 02:16:06 -0400
Message-ID: <20261010021227-rc-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010034616.3915864-1-hengyul@cs.unc.edu>
References: <20261010034616.3915864-1-hengyul@cs.unc.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 09, 2026 at 11:46:16PM -0400, Hengyu Liang wrote:
> Commit 8ca59f7baee7 ("serial: fix ioctl hangup race") made
> uart_set_info() and uart_do_autoconfig() return -EIO when TTY_IO_ERROR
> is set, so that they do not run on a port that has been hung up.

Dropped 8ca59f7baee7 from the 7.2 queue along with the following dependency:
  - serial: abort TIOCMIWAIT on hangup (eb35b73e1336), which needs it

6.18 had already dropped both of them.

We will pick 8ca59f7baee7 back up together with your fix once that is in
mainline.

Thanks for the report.

-- 
Thanks,
Sasha
