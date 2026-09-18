Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB01AA1D5;
	Fri, 18 Sep 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722998; cv=none; b=dK2jNfmhoTN4W7Wl6iWYkQVT4iXOX2KOi9LhLkz7QriKZtaPH9p3pqvNJSvCy7ZPkrMomtPkhY+QV51ZAr3GOiNugKIU3YZP9gBHEAkIk6OpMaPIFUCL0xig5DOIPa8yNj4jHSx46V7UNC8D3LI5THf6N2jkPRE4q6GN7e5uTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722998; c=relaxed/simple;
	bh=6Whwp4PCCSrdaf9ovni71s2JM8RT4iYDS9A+tyEds2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4eJ81VGpwA8h2ODVTe060eAjpI0Tp5B+Th+GfMyL4N3z7vrcZQgYmZiCrBnZHitQ2afz6qYp+s7tvFUieDMaLT3hAW4JbebIBBtdOouNVGay2DNePAdHD1Dh8g7wZQ8u71Np54vMm8c4g1x76JaKJWdXmeAom0gk1eRQ9cR3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eNByspGH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eNByspGH"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A5CD481191;
	Fri, 18 Sep 2026 11:16:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8V-LhdPYbjUy; Fri, 18 Sep 2026 11:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1789722987; bh=6Whwp4PCCSrdaf9ovni71s2JM8RT4iYDS9A+tyEds2M=;
	h=From:To:Cc:Subject:Date;
	b=eNByspGHv987imF3OdyJdhvq6JuDEuFMIt5cgV8+4/OPbwLs06Q90i1ZnSKTAfmVU
	 o9rBqM7tJg+jcceRFkpmjgbAYfh/fmEQtq+Gw4AhEwMnA4Fr5vZ3K8utkpkTjm/ekW
	 AOXetkK7TnW2UAYviT3lEk2QkKjF80484GJasKS6wYL2Sw/DOBZbs0flVpMMXJokjq
	 Llekv3wCz5Wh9bo7zF2Mc9FilUDLgx9vndMzZOZWL8OHVt7fO0hHcMjaX52cHkRiX1
	 8LBzS05SBolEx/XUY6rHJICFyZTLW59ktIc2iMy2OCibKg7SCe4Cq3xlyw1htuqSmS
	 YHEWK9RNr41GQ==
From: Marco Scardovi <scardracs@disroot.org>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Corentin Chary <corentin.chary@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 0/2] platform/x86: asus-wmi: Serialize WMI evaluations and drop redundant rfkill lock
Date: Fri, 18 Sep 2026 11:14:58 +0200
Message-ID: <cover.1789722252.git.scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASUS WMI management methods share a single firmware/EC mailbox that is
not re-entrant. Concurrent evaluations from ACPI notify, sysfs, HID
callers (hid-asus, asus-armoury) and debugfs can trigger nested SMIs or
corrupt the mailbox.

This series serializes every ASUS_WMI_MGMT_GUID evaluation through a
global mutex, then drops the old per-device wmi_lock that only covered
WLAN rfkill hotplug.

The mutex is static because asus_wmi_evaluate_method() is exported and
callers outside asus-wmi have no struct asus_wmi. Fixes points at the
original shared evaluate helper rather than the later export, so stable
backports are not limited to kernels that carry that export.

Patch 1 introduces asus_wmi_evaluate_method_locked() and routes method3,
method5, method_buf and show_call through it.

Patch 2 removes the now-redundant wmi_lock and the pass-through
asus_rfkill_wlan_ops.

Link: https://github.com/OpenGamingCollective/asusctl/issues/328

Marco Scardovi (2):
  platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex
  platform/x86: asus-wmi: Remove redundant per-device wmi_lock and
    duplicate rfkill ops

 drivers/platform/x86/asus-wmi.c | 67 +++++++++++----------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

-- 
2.55.0
