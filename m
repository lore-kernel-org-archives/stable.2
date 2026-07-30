Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10237F014;
	Thu, 30 Jul 2026 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379244; cv=none; b=tvgmbffB7xic+VTgGIrse675EFiQfxZNjNjS6YPuvo3M3Zl3VRJGNrEKy+UFufdZFI4eidDnmfyQfd+uEvGfUpS6zz8ele1sSbTKsezXVlk8sg7Y4XnSKUlpo4LpPaF5DDdzAphQ7i/Pme2OML6MVAkkPeZCj4cHBCmmlo3m9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379244; c=relaxed/simple;
	bh=iZ4i1C6uUwV+C34A9sGYW9x2Udnqdm8+Su35PlyXc2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocQjYpx+Ta96JT9QzIVCrnCMur+1vv7kYSX3/ky9bD+Vjy0GMiF+UIC/WbyVH3BfCBKvSznQiYNrpAOMYMh/lNYTgh6QfvlNcVpno6OZ6ie9Xt425U9GXq02CLv6u1EZ3q1MWAfUJweHEZPmRzgSVrO2CUjrLSAKHO3M26uGKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URsoI3yF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URsoI3yF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840341F00A3D;
	Thu, 30 Jul 2026 02:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379243;
	bh=dzoT9gG0Oufflql7q3J5NxX1H8I/XEfNZi99389MRAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=URsoI3yF6+jdFne5hv6DwFJVlVU9tTpZK9BjU7sM1gfb10Un8332NGUs71/4MunPP
	 vwGMHgg152LbXOrvJPVKjHc++LTyQPP3aOic5qh0CtcnL1vmmV+Y5TMAGfkwHFBQRx
	 YlZDYkgGFA0jENd3Ay5JzvvYUXReiQx/NQ2TzlKQlYZTaVVoCStNUDoC6ru+1Ke+hY
	 5b06ewy+GMtEHTzVUWKihG6taHkCIzDJROckPmXp2/qYo7fpbx5oWLQHTawYUArRIy
	 Fpq3JQcJyQfRFXkpZug1fGnnapPhVl1AuoT4g1HNVexfjZ1bsVjQo0QPM0uRzkjyVZ
	 Dh7YASIPSFhfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	George Salisbury <gsalisbury@apnic.net>
Subject: Re: [PATCH 6.18.y] ublk: wait on ublk_dev_ready() instead of ub->completion
Date: Wed, 29 Jul 2026 22:40:08 -0400
Message-ID: <20260729223316.stable-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729144826.2214402-1-tom.leiming@gmail.com>
References: <20260729144826.2214402-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] ublk: wait on ublk_dev_ready() instead of ub->completion

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
