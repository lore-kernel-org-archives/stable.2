Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437839;
	b=DXlqAtj5oOW89pnXDWDippBgBiA+ebPIrjmQivf7b/w2kHQyP/weFN1j8kCDJOZyCCOr
	 7BYgqIDyWPHQkUmMzaT38vd1y2LYX5dHMTTXE01CulsDXEF+Ofv9qrorp35GmaBPLSOXf
	 Hhli8ZRC2gsNhdN2kaQKic4Ugepr5YAuPUouUOaZiU+SoIqrNA2AoH/8DqfO5g5V4aUzA
	 CcQBzAXqVQ3blAwScbIzzyf0j1bIta4VkWe6NKoCG0Pnvkeqmt1Sx5NYvjcsCX9PsxDaC
	 SaON0gCB1q91O9Vk+b8JxBmOxoXl+45eciVGWWpvN7bIBMxYxSuvCIKr+FrejQdGSvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437839;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=5mnfgvT8zDKrs9lwYAztCT3HXSYhGYY7tbHNuk3ABB8=;
	b=I9PIi+wUvfgDIOEksAGRc9wIRuKAM8iucUICY/D4DjfwEPidXsApAjgJL54ssXE+pv+n
	 u5KWfQ/U4cqtnWvZWQIuMPlNzUVCIH5T+B8z5gSJUey3BWzPUI7KTTbCaf6aagNlqWFsT
	 +c1GUshROknEfYXl7YakxrbtjbTIgKIPPqAyYTIwHXaXwvpd7G9TfNliZT/97kyDl/7/r
	 yCByGLadKCs2ma9vbqix4L8UD1bSubcwLjPKu1VlK1p+bDA1aHHqqQC2bHio8NHYiqNsP
	 cyo/myka9HH09zPPE3Q+VFK2Db1wVO/zBuHmYefhTcZS5o2DAkjAE1AXrgnBmoyJ17w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IZZbUuBK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C548D606A326;
	Wed, 11 Nov 2026 22:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C548D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IZZbUuBK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88131153B;
	Wed, 11 Nov 2026 14:57:13 -0800 (PST)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DF713F673;
	Wed, 11 Nov 2026 14:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794437836; bh=1Bszywrh8kxNWtqksE6W1nJw34lGPEZHi388691QkMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZZbUuBK5T6vqLzLFvjVq/NhCQm7F3/Y2triF6X4DJc6/uuxViUcb0hvEyR666mL1
	 98XdimpnEnDuHul+eHZf6areafHsL4to4Kd5WluHEPLr0/kLhGvsfh/n5+Hdy3+sDP
	 IEXTlMoR2LJmtfwRGBPqk5GAsRv77luC4Htj876s=
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64/suspend: Save more registers over suspend
Date: Wed, 11 Nov 2026 22:57:06 +0000
Message-ID: <179443782601.2846601.5634691195882176337.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
References: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
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

On Thu, 05 Nov 2026 16:05:03 +0000, Mark Brown wrote:
> While reviewing beeec0404622 (arm64: suspend: Save and restore
> TPIDR2_EL0 across CPU suspend) I noticed some more registers that we
> need to save over suspend, fix this.

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: suspend: Save POR_EL0 over suspend
      https://git.kernel.org/arm64/c/2386c3dcf13e
[2/2] arm64: suspend: Save GCS state over suspend
      https://git.kernel.org/arm64/c/7ca488055c69
