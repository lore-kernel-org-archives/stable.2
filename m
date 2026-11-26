Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691802;
	b=kcbtiEz4hKbdl2CnDrxyoztr4alszrGalGxJnNFbHZoCBYIEUDj4zKF35/UQD6Lncbbh
	 H+j4UiPX1WHX947X01ynRBy/no5RlAuwO5R/utoS9F9RkR4PCQPh7txF0W7xO3pDK8lyZ
	 V3HTzS9JkeDPc37N2/GYSKQufWy7EWj/GuVEAacj+xFQpKAFT3jfsj7rRUzLmvFI97Akz
	 5JFmptzWRSVHmiYwWBNuYSTYYi/loZ82GAgSUl10YnP7nxWKdUKAO/eWoAdaiJfghWqjC
	 kiO5kfrS97iW/Bfxk2IykH9vIIwZNMCAmAaKC4WdYVAQoXnF+F1nKAIdDLUaaGY/bqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691802;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1B+nCK7IVGBh795a0Rgcb1AZQ4kSvKVLL9SmHcTIfKA=;
	b=ME9WNVKpy/2908cj+gkYuQVV03pZ4IE28YiwmCpOUgtMFAGBsgCFdUzMxHuJxaneByOI
	 IWaJvodRXCJz5OvtDSfx5381ZmZXTJ65EcvY1n9VpyL6M3gaXDAbrNB8v4hbOK8lumla/
	 dJDzxs84DP810d63V/I2eVs57KcrtuYtN01juphbWLPTEtnP8yURDpLF1IvWkr6dGDJSD
	 sbysz7WugkGfaoWsPkVQU6Is2wkqAZipTB8Txr6KxwAbQaFqQhaagLw4Jv3BnM/4mJoeG
	 u94mw3dlvv7v2Xs2Y6mf3hNdDbjxuU4X20HS91oWHT4tb6hKF+orKTQS1MXC2qyaw2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Yw5cxfDQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F76E606A31C;
	Thu, 26 Nov 2026 11:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F76E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Yw5cxfDQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3A521BB0;
	Thu, 26 Nov 2026 03:16:38 -0800 (PST)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C9603F632;
	Thu, 26 Nov 2026 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795691801; bh=iAEd6xa9eOJeWCX84Erk4niZaFNGjwfaBPHspobCjOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yw5cxfDQLcdBCOTH8ZBtmILoVYfEkhTiO/dk2oCkdh/zSrgbbB76UGjl/5HDak7L2
	 8U9K5hsJBVYLMPWOXvzI3uFN0gNWT4ivianMNbzzYWUyOZ8PJ2OIpNyVod+DCGgNse
	 73aO3rD9AiioBwfXdLTCfLP//wYWX1bFlRLhXPFY=
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	ying.huang@linux.alibaba.com,
	Yadong Qi <yadong.qi@linux.alibaba.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	robh@kernel.org,
	gregkh@linuxfoundation.org,
	ptg-linux-kernel@linux.alibaba.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] arm64: fixmap: fix missing break-before-make in __set_fixmap()
Date: Thu, 26 Nov 2026 11:15:52 +0000
Message-ID: <179569175258.1940346.15175112800352133.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126022227.1618-1-yadong.qi@linux.alibaba.com>
References: <20261126022227.1618-1-yadong.qi@linux.alibaba.com>
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

On Thu, 26 Nov 2026 10:22:27 +0800, Yadong Qi wrote:
> __set_fixmap() installs a new PTE with __set_pte() but never invalidates
> the TLB; only the clear path calls flush_tlb_kernel_range(). The
> dsb(ishst)/isb that __set_pte() emits makes the new PTE visible to the
> table walker but does not invalidate stale TLB entries. Overwriting a
> still-valid slot therefore leaves the old translation cached and
> violates break-before-make: accesses may keep hitting the old output
> address, and changing the attributes of a cached entry can trigger TLB
> conflict aborts or CONSTRAINED UNPREDICTABLE behaviour.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: fixmap: fix missing break-before-make in __set_fixmap()
      https://git.kernel.org/arm64/c/18817028301d
