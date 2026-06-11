Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4C199949;
	Thu, 11 Jun 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138737; cv=none; b=GVpZWLX10OF56TFt1Y6wSdNVGZJk5cfdp+oiGXH4XL8WZqfd0ekqj7CoYKsQBTEvmJQwh0hBldQJ5f3recjFVfho99io1sy2ijFMp7BkYjXkMLwa48E2HcZo/CwxRo96y1a8PbgkvyCmm+a6VMIf+y2+Drc+80btKCsEfY9H3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138737; c=relaxed/simple;
	bh=PR3Oqi5TQM5S1MD49NNzRGEphF4xa22xv9/BSaUvkl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMVHe58ypBoelgV7ktm8/6mh/rWMWafdqertwCVFs3bfocTKXs6vi45rB4KzlSUXYCaWHdRlRHXLMhaf17ADAlwlTn8GTfWcqh+c+rDEoxknMuZBngWqVIVdn0ad+lCgz/KiFRYdjfkLsFj4SNILPsvE+3p1elckLKkBuju2A9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIUbwOar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIUbwOar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A521F00898;
	Thu, 11 Jun 2026 00:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138736;
	bh=PR3Oqi5TQM5S1MD49NNzRGEphF4xa22xv9/BSaUvkl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIUbwOaribefmXn7gOJFOR0McmBexb33G0oQ16M+ASyEaVTNblI2gz+2jbaYDlC12
	 ovJX6agyAluiXIC6UgPmz/bWUiA2fAq58r9SNnFFTOokeEumiMHxb3wCoaKMHw/4FJ
	 oGPOQmcCLu42UVJgwoTy+EvivxTBu2JZ4MIAXUMoJuawrfga2corqtgHO+AqKmJM0b
	 AJ5kW0h+Oznl+u+BNt0/odOJF6Es8KIvW/Xq4EX1EEapoBh9vx/F6rEBEK9s7Nnd8x
	 O3Uhw31JMT8ChhBlHko62Namk0QPDf6Poj0abg00TJ95oHlvhicEy17GLdhk/9qz+O
	 5UUOBF7TPJX5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Veaceslav Falico <vfalico@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	lvc-project@linuxtesting.org,
	syzbot+9c081b17773615f24672@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.10] bonding: limit BOND_MODE_8023AD to Ethernet devices
Date: Wed, 10 Jun 2026 20:45:20 -0400
Message-ID: <20260610-stable-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609164835.32573-1-apanov@astralinux.ru>
References: <20260609164835.32573-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 09, 2026 at 07:48:35PM +0300, Alexey Panov wrote:
> [PATCH 5.10] bonding: limit BOND_MODE_8023AD to Ethernet devices

Queued for 5.10, thanks.

--
Thanks,
Sasha
