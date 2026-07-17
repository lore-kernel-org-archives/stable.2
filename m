Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007A30B521;
	Fri, 17 Jul 2026 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252274; cv=none; b=hn6u58IaF24H4qXWfwSel/InOXmPWOT4tO/9Q54debFUdxbl6OM7C6qsD9F9glP+x80U6rGUwnK/4EigJf34iXwFZxnJzSWN4+h3WpdUXZEQ70M+jT40jxhVcl0uadxvh+jqtig06iRiQ41euyv/Vs108LYn9f4Ni2NoCI2qivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252274; c=relaxed/simple;
	bh=rGN0VQxZ3TqjKiCYbTfxduH7jbrsa6Wr07+Wo8t5k18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS21tFLTAM5r9Zs7EOOly28Hegmv9figj61sYnbK4VneAOEVI6Aiyvykupp87GJvlS+WbJh1Li2hc3Q0qYwDjZTDzCOeYeZAw+o97i+nfZlOAhtqzt4HAPHgZt4YKwPcP2urJYaekS4Fa+stZIDK0K1EEao2+6rcCK+YoPQuGG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgXq5ZA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgXq5ZA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1881F00A3F;
	Fri, 17 Jul 2026 01:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252273;
	bh=feJ0HPBZTu2PuHDib8T6yytq1r2lUpywampWhM/VSfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kgXq5ZA0Cw+4xaE7UgKTqJnp1/dIO/rFszTUVVIdZOfPuokIjzxSB3MJTjrtbNVCO
	 6q62lmxxgsolcEsEgYfT1kSQeIDvWNWxHLbGNW/wSOfpN5Cx3fh+gplRSP+tvr/ac+
	 SQRxISBUjG5MO+JakmcwJJnTOOHasJYXFZb3lAwCrpcbaBJQQ5PzjEiHGlhusTGAjE
	 Y2EBQslY/Hm2xdmBjMQONZws8va9+qifyWE5qIUearyHaebP/bFrG/MZvCIAErAHpx
	 k8NcCRGrfD3lf99jWKjiq8IP0w/0bH1MIh9bAQGNB3zvNsgYwWvNGRiBvG/GGP0fI8
	 ukYrut+GUX8PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Adrian Bunk <bunk@stusta.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Konstantin Andreev <andreev@swemel.ru>
Subject: Re: [PATCH 6.12.y] iommu/vt-d: Clear Present bit before tearing down context entry
Date: Thu, 16 Jul 2026 21:37:32 -0400
Message-ID: <20260716232340.0005-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714222124.1906678-1-andreev@swemel.ru>
References: <20260714222124.1906678-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026 at 01:21:23AM +0300, Konstantin Andreev wrote:
> When tearing down a context entry, the current implementation zeros the
> entire 128-bit entry using multiple 64-bit writes. This creates a window
> where the hardware can fetch a "torn" entry — where some fields are
> already zeroed while the 'Present' bit is still set — leading to
> unpredictable behavior or spurious faults.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
