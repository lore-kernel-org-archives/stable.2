Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876B353A71;
	Fri, 11 Sep 2026 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100603; cv=none; b=MT+YPRvnqwM9IrzLAoPk0LEQF+YQdcoMxpVGerc6AFKHSgthM5wBPRKNv7o/AXM5uP10o9CYGnYqVioJa05JQTIMbuX3wP/06yvPA4hWo1YadGDhOxnl15m+Erzn7Yj0D5C4x1kuBXTZk51NThbI/lZTEZYiWyd5K5UuEEi75zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100603; c=relaxed/simple;
	bh=sKVKSex627hxWxJA8nn64IZCvyv5klu0dSNOYkY2EjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuGSH3FssDJE9iPXk6yPJ5xBBm/SNFWVWwuVP24iPK2J/84pq2ZP+WqUhlc2j25Egjz+MB3+mxLMcfb4iZ3ISTbXzTtVIRCZkQ2uPNcablzpZ4KZ7UNDM+Ys6E0kBOsY8Tf9Xt98eDpIYWrPy/UhFowfkfbNnD1uVpHIDldUyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KtI9L1bC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KtI9L1bC"
Received: from UbuntuVM-22.efytirfs5hsengjwslc1ligxab.xx.internal.cloudapp.net (unknown [20.112.67.58])
	by linux.microsoft.com (Postfix) with ESMTPSA id D3AFA20B7166;
	Thu, 10 Sep 2026 21:22:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3AFA20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789100559;
	bh=sKVKSex627hxWxJA8nn64IZCvyv5klu0dSNOYkY2EjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtI9L1bC1SsZSS2FWqU1sTRBg5ehGOgyfoh2Z5hk6bXf/TFS2XQA1GIo1cMj0ofVv
	 xQvGmMQwVDiFnF2smVL1O9Ykf3E5tbkILJmcay1UiO+j3g+Md36mCrLoz2SERjRSTC
	 e0YZFsy3XHRKneUqKqRzxiYzU/0XuKQQe3hcl6xo=
From: Hardik Garg <hargar@linux.microsoft.com>
To: namjain@linux.microsoft.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	rahul.tanwar@linux.intel.com,
	ricardo.neri-calderon@linux.intel.com,
	stable@vger.kernel.org,
	tglx@kernel.org,
	x86@kernel.org,
	yunhong.jiang@linux.intel.com
Subject: Re: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
Date: Fri, 11 Sep 2026 04:23:12 +0000
Message-Id: <20260911042312.981642-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831082528.1623843-1-namjain@linux.microsoft.com>
References: <20260831082528.1623843-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Hardik Garg <hargar@linux.microsoft.com>
