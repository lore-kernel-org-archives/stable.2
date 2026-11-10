Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343557;
	b=it72p5kFFIGWrecsJgIYV2iYleWFAxUoFIEzkQjcd0ipBIR3jop+GraOw9fgybBm0hKX
	 sbAKRVRXJg/2uSLH176Cgz8f08WCYfcQisGbaBqgIXyxlKytQgOqZrWBrXu7hqqblxlvp
	 Zz+9tf0JDbKi0zXcGcHfkdrTCMu7QMjPAshyP2pybk6TawarBeGXzvy9vt4lwyKh1FMXD
	 QZ9x+cjZvXrAO/epDyMpevX7MvAW4GeN+neEpOqQlh1vBkBMu4BtESs+1bIT5NpL4kaGG
	 gYaVOJSPyeMydIVlq+9CeeRYYb2gV2/ajrh2BU9fI6wMKWveDOzpQHZbn5jvDHWgOdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343557;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=CuppdRTtKTDc0kj9BPcB/tmHqk2RmCkorw1WGlouRFA=;
	b=Tp3dtbgCsPFGxHgOhY7a7ekseJe06E+1MSFL1oHBj5z4Z5BQxcF+tkqVnRBqwR5TNZFC
	 kr7kmxUGJac9Mz0NYtZsi00wmI8PihEXAkAEtgLP30NueIT6hq9FlJR0/xroDblh2fPI+
	 lUt2UYLhp6BbtDzH9c0No0piKfjyDa7oFbbgyfcRUiIBLZofmY84QR6FuktWEr3jALP14
	 ri+lNVMiIKYnIkKo4NT4NL9p9ZFSNkB6TIbR3iMc8EM1ppugxPMOZ4gAKU/u2Bm6u3MHy
	 oD8d6P2NlhgQ/yWQs/Ou9sfb7lOpOxNCI5JYFHCFKavGH8Ngm/bV72vKxPIKmDD6uhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqlFydK2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9C606A325;
	Tue, 10 Nov 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqlFydK2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494BE1F0089F;
	Tue, 10 Nov 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343557;
	bh=CuppdRTtKTDc0kj9BPcB/tmHqk2RmCkorw1WGlouRFA=;
	h=From:Subject:Date:To:Cc;
	b=LqlFydK2h3IQE1wObYptOnb6YZh9152rj6NCxzzmbzwr/Drp4Pxk6kvdMu1q5x2H8
	 nNMUTMMVUfPmMt5orgqPkEm4tGTRRqM48ssWR+4G+/Cjn5sNWyUN43vLXc/t9JozJ1
	 wE4d5NLg2zrHO/5no0qGZpkbBYuYn4P7QNT7pcIlmk/ARtcM94gxZ/qii8xMDhQkks
	 l3/bOTh9B9telEAcGbnlXqn2sjRQRao6CnLH6maX16o390IwJzcpRl3QedHd8M830L
	 kR46XeK3R8F0xh1llYvsNY8Ah1A1aDIKaBfG8kZ7iquzaWBtLwN8GGOqiPoNfyEfVP
	 FrrObr8Y67S0g==
From: Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v2 0/2] PCI/PM: Disable bridge D3 on a few devices
Date: Tue, 10 Nov 2026 14:45:44 -0600
Message-Id: <20261110-superm1-kbz-222179-v2-0-5605e6ce6454@kernel.org>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4V07Zh2wqO44j8MiwIDVBTIFIhK+
 HcLbF2e5N5zVuGILTlxC1bBtFhnh94DXgJRtqZvCGzlWaDEWEnU4OaR+KWgK76AiCpJIdSpjsL
 EVLWWwh9Hptq+D+k9P9nNxYPKaTfti9a6aeDPUV3UvjsDvvAvsCiQUKbKxHFYGIxU1hH39LwO3
 Ih827Yf/yaAkccAAAA=
X-Change-ID: 20261028-superm1-kbz-222179-4898547adf80
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kerenl.org, 
 linux-kernel@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, 
 Joshua Perry <josh@6bit.com>, stable@vger.kernel.org, 
 Tony Murray <murraytony@gmail.com>
X-Mailer: b4 0.16.0

A few devices have been reported over the past few cycles
to have problems with bridges at D3. This series adds them
to the block list for the feature.  See individual patches
for details.

Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Changes in v2:
- Pick up tags (Rafael)
- Correct URL in comment (Sashiko)
- Rebase on v7.4-rc2
- Link to v1: https://patch.msgid.link/20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org

---
Mario Limonciello (2):
      PCI/PM: Disable bridge D3 on Lenovo ThinkCentre M90n-1
      PCI/PM: Avoid D3cold for HP Spectre x360 Convertible 15-ch0xx PCIe Ports

 drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261028-superm1-kbz-222179-4898547adf80

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

