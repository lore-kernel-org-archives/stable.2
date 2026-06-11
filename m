Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E541519B4;
	Thu, 11 Jun 2026 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138746; cv=none; b=cGal/bj4vR29Hbs2dmeydTgbhH0MaQUcuCcNdpCIZpqHCaFg0LthVULbUHUqWXgD++XD+CgMEKpnjncadknYq2ITDvqt8QQtYSZErcK21ltrEux57TVNTQBYPGTXFUvbccyKLR3ByhafCGyou/Wml97i1FvClH/pkf5CGdk4w2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138746; c=relaxed/simple;
	bh=lTAxjqD2ptN6Nytpf7j8GNCCjkya1kMoimCQC87flzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/E+M26Vr04U35a2SyZzho8rHvtWUScHZV3Y1diRc/kf+EN+pIXoe/ovINmaQ5M3w+ywwD3Z0yjcK4/Z5BgDN+u/jeVBsD+Aui2MbpnJflU3zeC2DEHsDAd2+sTB/oCOhbGOygnZ7rCX/s4rkvmLzh9eet7zzVJ+0A+mT98f10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+/A4ZE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+/A4ZE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A851F0089A;
	Thu, 11 Jun 2026 00:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138745;
	bh=lTAxjqD2ptN6Nytpf7j8GNCCjkya1kMoimCQC87flzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+/A4ZE56l6Pfm7lGyz4H6+jKBFDShNu22o7NhZqMicwC4iFgSQ/a6vmf00nQLty9
	 rPrSNk4FqbPzSsE38L3RHqA+MwgmEBzCPoZ54Oz6ULFeQDBHYo5oInUBAQHU1Pp+jD
	 SdCqakzWEaPuy7QRIw5tpovn4oORxvXDf/wbq53wL9MDenyw3satNCEALLTAmVcGxe
	 xLExiUEsadcLBEjdQXDZdB7k1nA5Z4jydP/T3gN/VDhMABxpa0oNVB7Ch/XLQuXk0q
	 yJknVGOPFgjepPa4GXt0M4XL1O68bxHPSXyTYRhubEt9d6Sv6LWW4A2bhsf+WfGYB7
	 VO1vyD1ZGDaHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dhruva Gole <d-gole@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] spi: cadence-quadspi: fix unclocked access on unbind
Date: Wed, 10 Jun 2026 20:45:26 -0400
Message-ID: <20260610-stable-reply-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610020809.2695490-1-rob_garcia@163.com>
References: <20260610020809.2695490-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 10, 2026 at 10:08:09AM +0800, Robert Garcia wrote:
> [PATCH 6.12.y] spi: cadence-quadspi: fix unclocked access on unbind

I can't take this into 6.12 on its own. We don't backport a fix to an
older tree while it's missing from a newer one, and 233db2cb14db isn't
in 6.18.y yet.

If you can send a 6.18.y backport as well (adapted to the older
cqspi_remove() there), I'll queue both together; the 6.12 patch itself
looks fine.

--
Thanks,
Sasha
