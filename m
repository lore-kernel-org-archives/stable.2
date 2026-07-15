Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4A3242D4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083563; cv=none; b=o2hSTzZsfqYWo7OngXgu65T2UlJ+dJ1FHFS48grVp3DkRWdMVlYAexAUBeM5R3SvvwvL2VQoViKB48c8VFpSQK63BmNdgn1jQ2M7pAt9+UrVQyAcabdSBIZQb34jtG7Pr6odFEG55LvluQJyjd9aDIH92d/bL7x0QGqzgHYMu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083563; c=relaxed/simple;
	bh=pvDRaQk7uFqHb3J77A0fVydUs3M1eNXg4fu3mGbJx8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU+V2w3cUqpU3JG5UKqZix4b34YYRMBXsWoPJCzNVbkNGLzrVHQOr212JdDRY+4yv27g3A6lAEzfIBjmKBbJnjAkfOHH4NMgiMEIpAFNuncj2COJbJjJzUHvrXZveAaIFdB5rJPOPVVWYqMTBABzSt9j4Oy7DuDmg2R9gZllnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJobmXU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJobmXU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DBE1F00A3D;
	Wed, 15 Jul 2026 02:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083562;
	bh=LFHrz29O27dVAcX3UEv5JGvP7e/qg+uGtGFYbsQyMPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OJobmXU8HY7TYo5qF1bTRxWI3f/NuJvimpVI0H4NwaCBnEKU7jJoh6lUa3lDO5tBy
	 970G2MvKVUOvA/QDkuNrR2TzmqGat8qbHW/uEYTskEyEQKcdoLAym+0rj0TjL1V2+i
	 Z0iU0//xXcxAqjQP8Uxjd76/R2D/uUOAkLCxRXv3scxas+otqCDrwvQA97lK0cdPjB
	 FdPPaXT/su5qA7HLWT1Ykn0vME0jzrYmkXSkcLqXsRh7g0JSUylWWTxDiTyDvG/5j+
	 UayyIEHtRAq93FR1lP11/hAVcsSVOeyAnqFAODyEYlwx9bjQF9WuVkVyMH0Qi4VSzH
	 pFV++lka7qtuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] PCI: Free saved list without holding pci_bus_sem
Date: Tue, 14 Jul 2026 22:45:55 -0400
Message-ID: <20260715024559.106836-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024559.106836-1-sashal@kernel.org>
References: <2026071309-opal-shaking-a4ea@gregkh>
 <20260715024559.106836-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 1d8a0506f69895b7cfd9d5c4546761c508231a8a ]

Freeing the saved list does not require holding pci_bus_sem, so the
critical section can be made shorter.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-6-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 066d4dd2fc1e89..9e8d37720ef67f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2326,8 +2326,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		pci_claim_resource(bridge, i);
 		pci_setup_bridge(bridge->subordinate);
 	}
-	free_list(&saved);
 	up_read(&pci_bus_sem);
+	free_list(&saved);
 
 	return ret;
 }
-- 
2.53.0

