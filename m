Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7B44AB81;
	Mon, 31 Aug 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186464; cv=none; b=kEvrf72S6AznfegWA19tXukKiqEszKBmTuJGSMloKNNE7sZulQJgtiilfggbBickd9dixJidWj09BHmql8IdaD5/J9QtLXbJf4slUaYttzfuMP3AxoAj9Dh+X7DNLgTLNr0nhP6LcsUPly9KCENBd0qruVD3E0EBnDD18DK/iQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186464; c=relaxed/simple;
	bh=N7ntS6/a1BJleRWibV0tA5ZsQcTNaVz31IVjeKiAO1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICPQP6wcpP3N+whtvjIYR2AhXhkS43/VbOT5EI8OG6Jfk9MoMjPQxbeOTKFPK793sLvUTKeqZgkI/2KNVWA4oHbG61/kamFdXkbNrFFiJIzQ1k3WvNHXa0XRF7N76mEspYD5kv9myOiNwsknorp116oTR066dAbdlJVcSkVxWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXzVQERp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXzVQERp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0EF1F00A3D;
	Mon, 31 Aug 2026 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186463;
	bh=DBrEplS9tEm0O1i1zVQFrY1jf2Qns4axU8H/tgkbP1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JXzVQERpNVxdm7PtnwuTnkFebaCOX7e2iKTx7n282+kD3Us9ZkSfBQqf1i3nCROVI
	 IpRx4NRRSMw0BBsoh9dFvsSzRFrd75IBQTDF+01gwDQ2vYs4JWJbv2MaZXAGyVyThi
	 OY05JiXqGzluqsUW89DO1J8EGQKZO5kEUW6XOk/GH/BZRFm6728K/4zfit+TW3wmM0
	 vs1jOjnW8VZWlg8WaGsOEx0lDsxI84WKy/BZ42bhPgta88vSoX9N1AyHZEL5oXqv4e
	 6evDUGp2qty08QQHhYjmimJzY1bcY+pe1d84thcVk2dZkhW0VpGc11CTfVmcj6iVS0
	 UsVFe6ptQ0/SA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org,
	Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	Pali Rohar <pali@kernel.org>,
	stable@vger.kernel.org,
	risc4all@yahoo.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: ahci: work around lost interrupts on Marvell 88SE61xx
Date: Mon, 31 Aug 2026 16:27:24 +0200
Message-ID: <178818641418.216562.3155723702033731494.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831124303.920391-1-hajo-linux-ide@noerenberg.de>
References: <20260831124303.920391-1-hajo-linux-ide@noerenberg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=cassel@kernel.org; h=from:subject:message-id; bh=N7ntS6/a1BJleRWibV0tA5ZsQcTNaVz31IVjeKiAO1A=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKm9vt2L5qwX/XqliOvtmb5HmyYyt/zes217dzTt7r6l W7Yc3o6Q0cpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAmsuw3wz8t66b++88//eHL X5Dt/dQmw1PGvGOf0pWWGerfNp/9ctmY4Z8an8iOoqIXP+bt5Nuw6HzUyt/MM+dazZHV+lB2T3n hj/ucAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 14:43:03 +0200, Hajo Noerenberg wrote:
> ahci_single_level_irq_intr() services the ports first and clears the
> global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
> 10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
> for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
> PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
> looked at again, and the command in flight only ends in a timeout.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: ahci: work around lost interrupts on Marvell 88SE61xx
      https://git.kernel.org/libata/linux/c/22f2ba34

Kind regards,
Niklas
