Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137255;
	b=GH1MTsMBG+Eo97ucZbwXfaA2M0b7HuiJORxwyTrIhTen0N2MWz8ATWN7q+iW3ysVU2Tw
	 es5l02cdQOyHmxKIurkr4JkvUgAxukdQVGNA5/UgzHyAjZeEOrFECaJoGwApE6JYR32oJ
	 EnxQDsdOUb8VyBDczj77K1SpzwwuVwy+zQgq+n1EcxBO67WgJfr7tuKyQfvC5V9Q23aga
	 bePvgBmi0Yc//gi3yJGCdCy3ZRMavtx5TXphNUuAtqPAN+bblXaAGIQg4l3R826yeG/ZA
	 nunLywc7pUgdFuIjABMxCJOK1IZS5QK+9AYu4XXMuy3EOPOVP2vadoJ8B+Td5IOc/1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137255;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+/XEcHHI7bZ1kBO/vtGnv55N00igvwyJ7c+zBmLC1lM=;
	b=z8Gc9R0oSO+WiXdONJLgraO1gwZKTd8uEhFFkERVwAS8sYyGjMQAjktAVPpiWPC2n39x
	 L5LY/wYYaHs8lCFg3+nSqSODWNAvimux4XQ+M0v0+yUOoLmkCgX8Fts31FNIxC6DNBLtx
	 L42cTH2HHAeOOlSRvrL6WVAeBRNExqwoDiDIr0vdBQqXYGxWZPkS9hwX/JSudrNprJtBe
	 tWyXJK6Bo/Jflzc2Lf28v4571qlgPunI5lyTUBpH29Gpyf1uGpK6YwOTCMPk5DOGFb4r7
	 +QdzictOoo32xylcbWHXsq+Qi03XVOckTd1mJd0hsj6bsaXV+EZrCEK9RV+GW5cu5XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TvuOgjkl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338A606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A338A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TvuOgjkl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6A815A1;
	Sun,  8 Nov 2026 03:27:31 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03D353F632;
	Sun,  8 Nov 2026 03:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137254; bh=Z6cgYfYC9yPSgc/uWa7j0i9046znoNXs7u2I1Jl1kys=;
	h=From:To:Cc:Subject:Date:From;
	b=TvuOgjklU67SQn7qbYtcTCfWUKg/4sI3fhJNE2dws+CkFBrbmY6xN4r7JV8Q8LaHz
	 rTOiyANbsCeW933szguS+tKJRngymz4RS86SRMf/trqLAqDkkqtzAeKwusZHtLWj2X
	 bRPOcSGBQMNAT6mRAq4+S9GDyUUMWyvWWU02u5EQ=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.18 0/3] CPPC stable backports
Date: Sun,  8 Nov 2026 11:27:25 +0000
Message-Id: <20261108112728.2565950-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha, Greg,

Please apply these CPPC backports to 6.18.y.

Base: c3f63d70f236bb7685e6d11d1d9b5b351552e600 (linux-6.18.y)

The final series passed plain git am onto this base, affected-code builds,
full native builds and boot/runtime tests on AMD Ryzen 5 7430U and Orion
arm64. Runtime coverage included FFH validation, feedback counters,
governor and limit writes, and CPU hotplug. Extracted-function tests
covered malformed fields and error paths.

Christian

Christian Loehle (3):
  ACPI: CPPC: Validate FFH register fields before hardware access
  ACPI: CPPC: Propagate errors from cross-CPU FFH calls
  ACPI: CPPC: Accept requests to retain immutable autonomous selection
