Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BA386426
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338902; cv=none; b=n1tY7KmlbeV8wGfVrhNMEtQRClMEeJdVSJtV49bqw7yNGKyXliJ7K+2374jZKaJxDhCvEfx6KDzJsEwBnSkGDF6ZveDpxWNmUYHkj7hRfktH09EQc9ql1/bL+8tr8rp+HmuMR2lVBWSP2zFxaUqpKP3ZSLWz4oyl5WXLhdOSt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338902; c=relaxed/simple;
	bh=SQxCngObR8KBtqLGRNpSyk6dNhZ/ydUYY5KK6iJ5UqI=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=eKBMIeAeaqparRl6MxtS4xqzTPxBhBCzJD/cBQuBHFdyuEcOia3SY+s48we/jXNpA5ry6EO4NS4cUP5vli2utef7zAUxspuxqISKLAfHuKWfIdmyfPisuPeFcrYPNrfRg+8FUOWTxc5wQIHaaMSJmbKDPWwRworV028IynBUawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Dd0Q5L5q; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dd0Q5L5q"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hjjlM2RWnzMlG1
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789338895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=BclUxZEHyVQGq7M+mFZVqVtX3r7+eTAId9fBXuhvRbA=;
	b=Dd0Q5L5q5EmU5iVScRkrEgIcqX7fslduvFfGwsCvJXWP63IU73M9m98LnonB83lftkbIyo
	DCBetqPeGld+HZLsSV7cb/2ZcIITE+VKgTBPj5JIhjBk2NFlE++2BtERC2Bvdrk0ZXEDA/
	DmCIOLVcTOeEW1FTb98PeCw2DwSS4zYeOybsciXZm+IrE4vtpK6tsZpKpZZQ48C7o2XYPE
	qOYOyUQTTtN6Aw3x27m4DTHu1UN1dr0gB9bvuL27un1mhDuKs3OuoUNln8sNLkPxMrWN8X
	ED5gUb2AS+2nYtcKSgVnXWbxjZ8heMGUZpbciFm/DmFL2ydkkmkYyDxFVzgNGw==
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Rainer Fiebig <jrf@mailbox.org>
Subject: 6.18.51, bisected: standby/hibernate problems; rtc_cmos error-message
 during boot
Autocrypt: addr=jrf@mailbox.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8f2a6bee-9357-57e8-22ee-fd04637494a5@mailbox.org>
Date: Mon, 14 Sep 2026 00:34:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: shy5gbmqfunh18qzbzf15iet69t7a4hi
X-MBO-RS-ID: d7de4add3260845e563

With 6.18.51 standby and hibernate can no longer be effected via
keyboard-shortcuts on an AMD 5700G system.  In addition, automatic
hybrid-hibernate doesn't work anymore.

During system-start this message comes up, here from sys.log:

Sep 13 23:20:40 LUX kernel: [    0.533984] rtc_cmos PNP0B00:00: error
-ENXIO: IRQ index 0 not found

Bisecting between 6.18.50/51 produced this:

ec2d81115485de3f604f86edc4d9119a213a59bf is the first bad commit
commit ec2d81115485de3f604f86edc4d9119a213a59bf
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Tue Sep 8 08:20:01 2026 -0400

    ACPI: x86: cmos_rtc: Create a CMOS RTC platform device

    [ Upstream commit 1ae2f435350ec05224a39995c3a680aa6fdae5a5 ]

    Make the CMOS RTC ACPI scan handler create a platform device that
will be used subsequently by rtc-cmos for driver binding on x86 systems
with ACPI and update add_rtc_cmos() to skip registering a fallback
platform device for the CMOS RTC when the above one has been registered.

    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # x86
    Link: https://patch.msgid.link/1962427.tdWV9SEqCh@rafael.j.wysocki
    Stable-dep-of: a3df8bbe0a70 ("ACPI: TAD: Add locking around AML
evaluations")
    Signed-off-by: Sasha Levin <sashal@kernel.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 arch/x86/kernel/rtc.c       | 4 ++++
 drivers/acpi/x86/cmos_rtc.c | 8 ++++++++
 include/linux/acpi.h        | 4 ++++
 3 files changed, 16 insertions(+)


Let me know if you need more info about the system's hardware.  Thanks.

Rainer


-- 
The truth always turns out to be simpler than you thought.
Richard Feynman
