Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136843;
	b=mIpsh1MIHRjxDPsvL7J5NFmu+4M5BhOM33zV1MhRGuMzvOz3igKMsGNAU2aTvo3YW71q
	 2sICH5QNhhXdBWu/zN7H9DONhnyy62sfhTq0CAnl4KRBgbWsK+3ZGk0P2X1JI/M5Ikz4U
	 5qz+FdyTN1RRGavkqze33Esd8ot9yip//njRuWjsGdekTdGL1Qee2EI4P68Y7H3KJzgbA
	 0SDtYKxCCT/E+mAdzqBoj/1JUwxNd5ILm7jCqhKSr4bFaZqwVw9ulOc07LtxfXOcMSlt9
	 WfXIdJRKmjRcSVLtUIp8UsWuROq/HzIMkad1e2EC/jMaw0Z+24iotAFAqkmcYnmydsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136843;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6JsqQ8oTWPph1T8Ag7Uz2z2JmAGfNs5a324p7SX1AyY=;
	b=0I0HPNMurvT8wXdvoCCyEZ/m0GG0HL1QwNPn5iOYBLzcC7MjPdrqHl5u/z0Re7TEsofg
	 XMTK4dHGAm7uMu00EvdoY5Uc8Xxq1+mhjae9NHiv+A5CR9W7iBLFCfOywXsQnU5PtlvZy
	 alER3oiKCJDds1OqK03+l1jamziNIC2+qWaqRawA6GsYCnCrBwsStcQ52L58GYdrjUus6
	 riCv04YRKQS6t0LpvNOac4Xw7qhEuXc2pUDVbhfxmp1zqixNOwlFa/UWeRXfF5Z8DI/UA
	 idVCQHM7DfDrclM+Xep/AM5VXzzYMgYc7/sAXursndWWn+A8SaLEZyWTtZSIiNj+Org==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fk1XzEzt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443E606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7443E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fk1XzEzt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43BA015A1;
	Sun,  8 Nov 2026 03:20:37 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40FD43F632;
	Sun,  8 Nov 2026 03:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794136840; bh=BvWzWDFL+ZRKKF02XzxIlsylw2LzvmpEoaz+pwgvPhE=;
	h=From:To:Cc:Subject:Date:From;
	b=fk1XzEzt4sKtdgo5/irj75S8a3RKVmoi2qkMBz8FS5Yjc3WH0C0bUGDP657zKV4u3
	 gzxKr1Ve8SaGB8qd9WynutQjg2hKR6ktdIWcTRRwCjk8qa6Ieqdj4SZu83WwV48gfz
	 zg4GzU9O24impZZ5YKKLRVir8DFCF589hd423PZ4=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 5.15 0/2] CPPC stable backports
Date: Sun,  8 Nov 2026 11:20:26 +0000
Message-Id: <20261108112028.2561026-1-christian.loehle@arm.com>
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

Please apply these CPPC backports to 5.15.y. They address the failed
backport notifications from November 7. Apply the patches in the order
shown; each carries the full upstream commit ID.

Base: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58 (linux-5.15.y)

The final series passed plain git am onto this base, affected-code builds,
full native builds and boot/runtime tests on Blackview AMD and Orion
arm64. Runtime coverage included FFH validation, feedback counters,
governor and limit writes, and CPU hotplug. Extracted-function tests
covered malformed fields and error paths.

Orion 5.15 emitted SMMU events and a pre-test invalid-wait-context warning
in hrtimer/debug-object allocation. An unpatched build with the same
config reproduced those diagnostic classes, with a different caller for
the lockdep warning. The exact RCU caller was not reproduced. CPPC runtime
checks passed; debug-object disablement limits debug coverage on these
boots.

Christian

Christian Loehle (2):
  ACPI: CPPC: Validate FFH register fields before hardware access
  ACPI: CPPC: Propagate errors from cross-CPU FFH calls
