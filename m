Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711181;
	b=ZL7uy+wT39raV0yqTcsdOZyblp4qnm37Dj3eCbMy9NEzvxNLVFORdxlHFoBA/Lp4LEJU
	 MCMWGBbOR9yyngXCudhEItSpQxu8bLOyGj8ob4Ew83PWzeDWkJbYZcGryu0M3ucr/EoAR
	 HbYze0etOfhnLqzFHdXhRoqivrtG2ihmYDJ1aptHEsjTXB8IbAlSfTz3b9c2UC/0dQ2OF
	 1JtvFPhCjjbQwzga59rBnB3rZqSZ1C/JrKtxuqYFbqLs1MsMQqWzLHZ5U6kwcs/yZmABw
	 crAFTaxxkRl/RAH0MZa/Uc8ynvQo5WnVQyqf3ggH1DgxGs+nm+qWnOF41Bz2hMm24rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711181;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:
	 X-SA-Exim-Mail-From:X-SA-Exim-Scanned;
	bh=jrvB2uhiOlJMrSsnK6E2dIxlOOfI+P99rLJr/kY+hxU=;
	b=zYcZAN6yQUZBaUDYQpdAbMOd1Tx5QT+GiSkurfqKNEhv73NjDImVT/EXT/TKYnqAUtWq
	 Se2w7T/yUrX0yvsoQd1chFq42tCtanl5OMjCsCGIyp6QqnEgNLyKBvhfqJy+/5JrWX+pp
	 Rfa3WE6UlV0wMZOUgRBKl9tqURe54vXo8MHZp46ZkYByGQZhmDLZ+TAbNgd/bpoD9t+9D
	 Ti3pWBnpntjQCzbcR3KXxygmq4T2T1CYEpEMOOx56ZG9jSbmDjBiKArIMKomDVmhH9LGX
	 k5EAXF0seddH8ncK/qEJZ/ceGCgnS0zN+bJA627w945y9KtHimlOg3nBVo0R+gk9pVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3NSq3n3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3E606A32F;
	Tue,  3 Nov 2026 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3NSq3n3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5221F00A20;
	Tue,  3 Nov 2026 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711180;
	bh=jrvB2uhiOlJMrSsnK6E2dIxlOOfI+P99rLJr/kY+hxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3NSq3n3lfS8W4VM0IM77JvlyxS3E3lkY/GvyHOFmBbyBf5FkSIdSv4wGMz+vZSIK
	 EcLghOEYATx8t/Nnyufi3hU9RLY0c7kHD6OJp4zgfw7zZz8ntFonkmKdt3d8V1dQeN
	 XdD21Ino2zH92767FVbwWzmh8eOZDZFSe1qJSJZTDoB+Er4NP29R+U2v6kZrMU1Eio
	 0Ui/24Tn1lJxyIUOuharQsOqvBdeeU2yomI/lla/TKpLVLhs6diPgI+FnkzzXMgpsV
	 oiA9tAHrlS4IyrDdykSb46tqYO9jtb9ui3d8g4GqcBdhRH5gZJq9rSCjrVvD8s/k/q
	 13Y29B9g9X+7w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xOEDT-0000000ATWs-0AHP;
	Tue, 03 Nov 2026 13:06:19 +0000
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Eric Auger <eauger@redhat.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Sebastian Ene <sebastianene@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: vgic-its: Update GITS_CTLR.Enabled under its_lock
Date: Tue,  3 Nov 2026 13:05:36 +0000
Message-ID: <179371111247.2844725.15148154363267227953.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102082933.2673799-1-fuad.tabba@linux.dev>
References: <20261102082933.2673799-1-fuad.tabba@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@kernel.org, fuad.tabba@linux.dev, imv4bel@gmail.com, eauger@redhat.com, joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org, sascha.bischoff@arm.com, sebastianene@google.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 02 Nov 2026 08:29:33 +0000, Fuad Tabba wrote:
> A GITS_CTLR write that disables the ITS clears its->enabled and
> invalidates the translation cache under cmd_lock, while an MSI
> injection tests the enable bit and populates the cache under its_lock.
> An injection that passed the test before the disable can cache its
> translation after the invalidation, and the cached path then injects
> the LPI from the disabled ITS on every later MSI for that event.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: vgic-its: Update GITS_CTLR.Enabled under its_lock
      commit: 61d4f8c3d02cf936cfb91f7b72516b17febf74d3

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


