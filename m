Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137207;
	b=ZtfjnXsmQ8t8HBwGrO1rbWfU7qQCUga+XYbtfEswlcpX96uyIoof/Q4E1zajLX9/XlaM
	 RtatMyf6evqwx+EieGDoXdogmY69uWjLU0aMVkTta7djwwIVQ7ZsV8mZjEnU39UVHSwjq
	 KjX8Hy39Vj7Gjn4816ocX4z7K948+fDILCZNDs1nXLFEaFlEw6lsh0MtyKLjv8iYRZp1j
	 5PsaI98XrSdxy6spKXFhcT4gGFwnnRpDGmD8NTKn7qciSXD8VzjD0gVzoZ3dAmCLnfdTm
	 97UrTwhIeXrTOl22Ukx+A7Ohwl8olnBqwWd8SE9OAGoULJwn68DaejiCRgVFFqCdpJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137207;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2oe7GBVuPnUpDyViEpGGtGXV90wrnp5zNJZBsy5iKN8=;
	b=wljjKQc/cwCN6YHuXXRMdV5q0hw07MIJNCFGgjukO/bUO9sX4XWQ0fEOZ+THZ8UstE3a
	 cvjPGqn/FF8k1gInZ/EcKNr4a7y/jdcA2CJjA9/+2yIjQ6slqD8YFDf1zaf9ztCp4WHb+
	 gfgSaUmOtvq2gk0bCzZSH3i4mrBuNIC73/kK927W2aqcJvLTGpCYV3iedAmqZA1sz+Vbp
	 RqhPGi3hP4ivFfVnX35KkJ/kqDUvQ5KeSVQOIn33qoDeNkMJG2TQ4aK+/dn68QnabkJk9
	 Mbsm4uZ6ku8DfphOg+6svQb/OvFzoo8Kr/TMiK1FlsC4Ulj7uj9u8NwNAl3RPPHVZMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ih+wnwF8;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD63606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ih+wnwF8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9F9B15A1;
	Sun,  8 Nov 2026 03:26:41 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7F603F632;
	Sun,  8 Nov 2026 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137205; bh=I6PkHZ1qWdass9WI7B8nJpIU/2rcTR8caaePFt1a8iU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ih+wnwF8Y71X60wntprkFsRcYfOhPHzUC44rEX+zEeHkZEIoXHCHZR/zkbr78I6TC
	 WzGvHfcNwGf33mOJiA+BALtxsSnh/pRz6JsC1B1OYjQXuPxgj7Z8HJljwvV4Obs5VY
	 boXyVaAAGxZBUiWOGMxBX6Y5z9w1Ic1WTWGAfUaY=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.1 0/2] CPPC stable backports
Date: Sun,  8 Nov 2026 11:26:34 +0000
Message-Id: <20261108112636.2565600-1-christian.loehle@arm.com>
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

Please apply these CPPC backports to 6.1.y.

Base: c75b0cf0982c00cddfd88d1acf3872f79b40980c (linux-6.1.y)

The final series passed plain git am onto this base, affected-code builds,
full native builds and boot/runtime tests on AMD Ryzen 5 7430U and Orion
arm64. Runtime coverage included FFH validation, feedback counters,
governor and limit writes, and CPU hotplug. Extracted-function tests
covered malformed fields and error paths.

Christian

Christian Loehle (2):
  ACPI: CPPC: Validate FFH register fields before hardware access
  ACPI: CPPC: Propagate errors from cross-CPU FFH calls
