Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513119;
	b=xdgO9orFTx7TDPIIGD6gx0LHl6U1MEhR91SSj9SziaFuyHTyR4VD043+PdXOR8R/272E
	 GN/dFa+UzoA1GKNs5D7Fy4u4PfXLoDQgeKcbuKeOaQS0rjTBsBOaZ7OuZw7Bc+haWMoia
	 AWOYETLyVUE83eC7MC3TfLtTGdyyEfLQkLTDf6Rl5uLM1BlEXjGeFNapHFTk0Zub5xYqN
	 hvy16eKCPVsGjG8dNL0WVUWZEwAU9vI+hm1rqBnfl66cEbwOvVZL06wj/bXyiFQw2oj/i
	 XuXz8kB++dRULxTwfQoFKREEocbbQ/indz0rymP6pRskABSk+m4KHiWYDXffuuTE5Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513119;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=j7QUpc5QEE9kBpCKZyh0iyL6xxgGtTTl37sbWRN+Zw4=;
	b=Eurww+G+f/um7UGeWPs2aenHboOSqHsS/coIhFGLXvEsUnH6SJIcy8IVTxZJ+vHh4i1x
	 gAkt3zwNZbPYW6TA5eyCN+9bgG8BlaKaMz4mAu6XsNdR7vc6FL8hL0u6Y7hkCpHjctKJm
	 cJUa3hX38WavEnQfqlqnxs1kkXBhg1pBf1jNKypJuVjdfYOCvrSOA5Rf51OOhebqGVZSS
	 /6lovap3ejcd5rHQcUc6zmjrUO5qgFdzYKUrHWdIxB3Nl/WgD0xU1Qp+bBzQnrb4IPiR4
	 jqslxukM7qG1iGNDCbalnQCUQpTOk3PcZS6zDaGsui2ixOhz0lG5dhK10dLhdG1J6Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=O8mbTamL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B40606A327;
	Thu, 12 Nov 2026 19:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B40606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=O8mbTamL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E6FB143D;
	Thu, 12 Nov 2026 11:51:55 -0800 (PST)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1180A3F632;
	Thu, 12 Nov 2026 11:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794513118; bh=DQuepZdvb97HHTMPODLKmAYIFhr3Z/1G4UK+ckClajs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8mbTamLisORL88fsLmFTt2aRZhz1miWAsT+CLuTMSMVY6pXAFFnQkgQLXuxEy+JA
	 pbWFbK5fKVmTncFtO6SNMds8Z25XwvT5DSn90RIcATtf8ZRj4FOVOgaN6uLqp95vdN
	 0f73Fi50k6g49hHehJUEH/pGrnRHnyOuWIoysuBA=
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] arm64/gcs: Store the GCSCRE0_EL1 register value not userspace mode
Date: Thu, 12 Nov 2026 19:51:49 +0000
Message-ID: <179451296803.3304937.17452903421973790393.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-arm64-gcs-store-gcscre0-v2-0-954d5bffd69f@kernel.org>
References: <20261105-arm64-gcs-store-gcscre0-v2-0-954d5bffd69f@kernel.org>
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

On Thu, 05 Nov 2026 13:00:11 +0000, Mark Brown wrote:
> At present we store the userspace GCS mode for a task using the prctl()
> value set by userspace rather than the mode configuration written to
> GCSCRE0_EL1 which means the register value needs to be generated on each
> task switch when the new task uses GCS.  Since the mapping between the
> two is easily reversable switch things around and store the value that
> we need in the context switch path.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/3] arm64/gcs: Ignore attempts to change GCS mode during signal return
      https://git.kernel.org/arm64/c/d395db3dcd4c
