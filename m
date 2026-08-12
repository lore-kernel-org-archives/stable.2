Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC1448D02;
	Wed, 12 Aug 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552018; cv=none; b=cV/ji3jqjKP38tVUSVMG6DOaCwjrc40IGB4e7mT/dgGZ6O4lwtwyxfZmdmEyYVWvzGCTGpD1/JSQHVTjk064/qCzc5u8/WfxucUbmsewDfD/m2uciMDMsTmeT1xxBLkAMwh4P6HpgaULxCxOEMktciRCWqk6LGGL7dlnHFgN/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552018; c=relaxed/simple;
	bh=4TpOL4YEVvC7WBAQ7LxBikCCUsJZnFp2ltFmg2b2QVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMp0xVNaYqSOG+/jjr7LbRTkHXweemRdNcLtDjrJFAqPUNH1Jyi6Ty1YbAMoJyi3T2q99LLiSMkRDAt1B/soxXi1ZIdi1Ok/8+ZJDrOjGs7rCFNKIv+9G3/BVhymX40wncQiPMK/OAoFaACF4dERGGt0VU9FD7+v4OX0fkGcevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaWw00Zm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaWw00Zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C531F00A3E;
	Wed, 12 Aug 2026 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552015;
	bh=62hpdRPwD5/DxV0+aI7TfAo9YYaU/JuUvqD5jme+6fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NaWw00ZmC7D0qTt0ipZZNAXCoMomxti40FWQazjwJgOASZYHZFNKnWQgDGC/S7pim
	 F6lYVlRki3bAPEwUf8+H1KyYOKFw5oyCyiDtl3JIQvFAi1Ha3TbbNBmih/Km/g/EoX
	 +BCyyHq36Fcwhc5LHLJXaeM+4w45g8PIIja1gZHj+n66A1YhoHtF0g/jRVdYSdULi+
	 IP/i/U2HGsWfu7q9wYgOHAQfamV/opgzkfTM5vH9G8i4eHUUIDjLn3Xjy+IHVQ0ieb
	 E6HigZi0Ewle6utf2LeKu8bKa4tK8M7DR+oPFofIF+uXiovi+lu0OB6Ve1Anyc2f6d
	 4BkOFq1h88UOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
Date: Wed, 12 Aug 2026 12:26:42 -0400
Message-ID: <20260812161500.10005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810141437.2805389-1-mehmet.fide@gmail.com>
References: <20260810141437.2805389-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 10, 2026 at 04:14:37PM +0200, Mehmet Fide wrote:
> Please consider commit cac7e5054115 ("spi: spi-fsl-dspi: Avoid setup_accel
> logic for DMA transfers") for 6.12.y.

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
