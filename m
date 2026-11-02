Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627858;
	b=u3MXbNnpR3x5wdn8Jn4U74H9XzT6+pNwJ550Y9ET9q3KpASWzgX/KQZHgIFJrlYd+WBs
	 hMr4G2toUjT4zx+zVd6mQEYOOtT2KYJmqguHGyvK2nZkaLJiQkPjwMlEi0LLMt3BPNDk9
	 x4eD4RAA6GYIlaA+cD1U9HK2ulRgMgUqWYUw1ZZS0USvShG3qygl4TRI9jR4fLZ6PQp8O
	 hUFnPY0nr4qB6OyVy6nERic8I6M1Vnxn2ooRDSPwgvPl8s6eAC0D6M3SnjunwgLL2u40O
	 R9G5q3rRFntQUoH1WOiKudQ24laxf/TSd0vEkvUR5Y3oTyf8xpBG7Be/aDyhFdD9irg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627858;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=18HsE5hKjmGvSxzL4BnaMjuYw7GrkwEvlMrS27W5X/4=;
	b=DVDZ+vtFRNMSQAQb3fGOdLWIiRn63fYb+021f856j1iNirAX7VDnlIHtF8IT8ecDMt9m
	 GLv6uqrB0l80Mw2gyl5tg6XESP8igTN5Bv+FtKq4F88R4CrpFpFPn/bYnAm2gqePUiOUJ
	 TkKWAil6k9z225T4zQtpZU0HZsB8+forsGd99/uAy/1LNOwnEeixq1eSxOkrc+KHve3JP
	 tY2Lj7DotL+RVmDzrVglK9DSaNPW5qUVCDgVdfiPbkNyBRNftqs/FXdP3gk1u4Dx36ir1
	 MP/8g6KJqmx/QMSxHM/7YfIftZix8URMvNblnUOGnDPPV4N8LWd6Ua9qbvbWdw8cUWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gResnIYp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702E606A326;
	Mon,  2 Nov 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gResnIYp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA811F00A16;
	Mon,  2 Nov 2026 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627857;
	bh=18HsE5hKjmGvSxzL4BnaMjuYw7GrkwEvlMrS27W5X/4=;
	h=From:Subject:Date:To:Cc;
	b=gResnIYpqn13u4BLHfBQ6dUGc1ht0crDRLh/Hj+VjTB2xK3NmsE58MlYktpT+l1t6
	 YOrJcKQ3R/MSKU9M6lKnGI8ENMZ9HHX4JTeCIr96gfryMUrGnse4L19ZDpTR5NtEq5
	 6vaGDgDwAVrg/hZ4Q+XqQyWBl0UTt5yo7FgQmbWq4dKVvKGabLojtu65CFode4X3vk
	 yO2SlLIciyUCo6uAhhryj08XFhBYd8OQy2NyT7Og2coIMv3qbIBqgmFU8X8JN/vloa
	 leDb7FkxIR7bpBSr/4uHw88GaolRwYNGhs6ZohOvFC4W0Zx/IxPfUyZLoe4uByKAkF
	 f/lSZMFO7PHeA==
From: Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 0/2] PCI/PM: Disable bridge D3 on a few devices
Date: Mon, 02 Nov 2026 07:57:25 -0600
Message-Id: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDQAxA4atI1g3MBKujVyku/IkaS1UmWkrFu
 zvq8lu8t4GyF1bIow08f0VlGgPsI4K6L8eOUZpgIEOJNeRQ15n9x+K7+iMR2TTD2GXuGadl0zo
 DIZw9t/K7pq/itq7VwPVynmDfD8lflQh2AAAA
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
Mario Limonciello (2):
      PCI/PM: Disable bridge D3 on Lenovo ThinkCentre M90n-1
      PCI/PM: Avoid D3cold for HP Spectre x360 Convertible 15-ch0xx PCIe Ports

 drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261028-superm1-kbz-222179-4898547adf80

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

