Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137234;
	b=A5lKKioRhNUiPrh9S6ZRnVwvJiBEShxX8m6bjx92QAtpUI+eJTz6kZ8Nu8kNhHYSmutP
	 +tNTqLAjRKkXCPu54Mpp1BGJiIhbVFhiRFkwI2vUwuKM26ZtIe0QGrUQZuRsTJiWoGfZC
	 2F+Ietx6OHup2cA7PavPZUaiv2Jdat/fqAEhLedKSLOVBHA4bCdXyXczSboyQq8c8pv1u
	 rlkl/IW7G14lx9YuZmva4JI9oa5m51aCn+y+m9N7CcpyxAACJFtJK8qWrJjzn+3AmGF+b
	 9hLa8fJ3t2KSZP1HxfnfZ1MuhK2G6wEGeqWixnfa2WNDCTaeIBkuGNNnPGihr5vrpkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137234;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=I/nvNUj/Q2cUZIDmRGIHQAfv+Wz5BVB7kmGL7swDwCs=;
	b=qrqIUMsJoUyKjJY+zKwNT2TxUDs0z/bTLoHvkia2mwd886mGX52k4eEhKoHQRYspsKjx
	 qcuM41HBehsSNeh30BA3JvbGn/nvwXkhWCgh9D3eWEn5HKQKHlMyakFpkjO+l6X0L9NWX
	 pk02BxQ7bWlaXn8fIp77qnLJRJ3t8J0jaQr0NEP6MZOsouUAHldYSGp4iM+bLEgctkZXT
	 z3c0Olf0BtRLt64Bm3ZD2Pc2XHCqmjSy4BkyvvspHcy9WPY+yRarPMIwQPRTSii3OmId9
	 88h0ODVab3H1hbC/evSYmdpk0Fbpx7GXL4ZEFwZivqdk8wFRe4E9QBq0k8XcGFVLNDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="rIkPee/U";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD65606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD65606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rIkPee/U
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB77C15A1;
	Sun,  8 Nov 2026 03:27:09 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E87ED3F632;
	Sun,  8 Nov 2026 03:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137233; bh=PvJxS2/exqc0hKeYUhnI30GFRCe0H2IAwiAnjTEImwY=;
	h=From:To:Cc:Subject:Date:From;
	b=rIkPee/Ul5YeZD1RuflC90xIDKSzYq/WHU6yX6V5+OpXCobI8GrLMujSdn4NQ22nD
	 TuiTE9Y7ITfnGYm/uslcZXhshZUtlojbiLboKGJD/2iuTiOPZ+G6TKrwlk0iBgZ9i9
	 qEi6vJDtdJ7RMGQeKsl+xdNYxdzttwuADxgBhga0=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.6 0/3] CPPC stable backports
Date: Sun,  8 Nov 2026 11:26:45 +0000
Message-Id: <20261108112648.2565681-1-christian.loehle@arm.com>
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

Please apply these CPPC backports to 6.6.y.

Base: 5139929c698c273e07cb0635732f6a918a7b8e78 (linux-6.6.y)

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
