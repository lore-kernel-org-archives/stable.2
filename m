Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137266;
	b=him5BPn7eA/X9h8WI2H/rWuaAQcTY7SsTetaL4AgwL+cYBLCWjrmS88kLObkuTpTvwjB
	 owbTiY+sdM+zm123KR5vYde5Ad3PlvnS1/9oMk0FEDMikOPQiGHdnlbP+hUEza5AFbcMj
	 5E8Cges69b5OVtqwSDPI/GzpNCXiIsONyOajWLzD27YFIpAPXOFzzmmj3Tu0l9bUr5KeW
	 qj6utTYX5uECNa5ea/R8/31sBCp7VyPgNPONSmk5gifahE6vv5GuxgBB/JmnKk4D67C3V
	 BNi20ifYip8KalIslhOTuhzWhWfJtTms4yJnAhYssuSuXWGUnjcpfGCOh/2XZgfmzSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137266;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6cNqG5YxhWu3t2tdOvG+kLJxbw8cfKvdGvIaH/qDy2s=;
	b=diLvpQHK6QLFxLjtKePvr7diY+GvuKs1a/UsbRMBzLQQAbllt7Sfr70qhgHM7j461+5q
	 8LKuHTtY4DKcBs1PB7w36+e8r/OAqC8VFaY0W5V3KyGfCiYTiGDpf0VmjOnLu4UstKZtM
	 ob1IBjypyFQKf4q1RYLISBTmpJ49yfnYrcLoho7Sl9dzsfY9C7SNmoUTqRIJhDeGKjUJw
	 jR8vd7FMhv816n/fk5usQX7TSWS1pgr6dNaWkLy9aXevXsi6tKtIkQxsQ5AibLQGR5k5y
	 2Sl2fWT0OmO3aUDuKOd6RFIUgG8OJt9Fx02I5PpHYr3pPREu6NbDO6RFuCTCG4mnLhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="mbrUE/Oy";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875DA606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875DA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mbrUE/Oy
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10AFA15A1;
	Sun,  8 Nov 2026 03:27:42 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F6013F632;
	Sun,  8 Nov 2026 03:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137265; bh=xf3imJaJmLkD5F4W16+QNsrpiakQ53bC5bWkeKy39vg=;
	h=From:To:Cc:Subject:Date:From;
	b=mbrUE/OyW7bVZXScBor/aaOZ6aXAk8O4d6wOuQQA9GP48HpZPn6rZoYDNObC/2XNt
	 Z77Q70Di1Um3LkWn+fcfiwPhIeADsxDX2nmkhUTCXTiZkCFWt2UmvAJ6tNZ1MWp1df
	 2yMuq/ZGgLsdFHZG1lXRe4uEsTIN3xnPn8N8Hdfo=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 7.3 0/3] CPPC stable backports
Date: Sun,  8 Nov 2026 11:27:35 +0000
Message-Id: <20261108112738.2566137-1-christian.loehle@arm.com>
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

Please apply these CPPC backports to 7.3.y.

Base: d50d994bffa3c7c6db2d8bc4c5f0c55e3f46b0cd (linux-7.3.y)

The final series passed plain git am onto this base, affected-code builds,
full native builds and boot/runtime tests on AMD Ryzen 5 7430U and Orion
arm64. Runtime coverage included FFH validation, feedback counters,
governor and limit writes, and CPU hotplug. Extracted-function tests
covered malformed fields and error paths.

Christian

Christian Loehle (3):
  ACPI: CPPC: Validate FFH register fields before hardware access
  cpufreq: CPPC: Select the frequency-invariance callback per CPU
  ACPI: CPPC: Accept requests to retain immutable autonomous selection
