Received: from mail-108-mta197.mxroute.com (mail-108-mta197.mxroute.com [136.175.108.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD82E764D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 04:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742621; cv=none; b=p2PqHoMSgq1Hfo4jmo9+fzjDQBvgdNLVPJ3msqPBJ0IujqAZEa3aAZ7vXnAw26q9Enp8JmCjpj0hYZronZhJbTgdqhHJBjdGQ/EnoRkmp49oBGdpVdq/711gcs1An2Vp84eMjAOSJoezMf6ayep7KrOJ2tX/u/PWAkmdWNbeuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742621; c=relaxed/simple;
	bh=8a6Nd2BP8tdgqPGtiKuTPSDEdvr2//3RiAZ4eXytnf0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cchfY0o8Z96x4Rb7JXNJ3hYUA26LHHz9k5rVxlXHo1IfHc3al7pezg7Up38KpTooiWkRuzKpDi+HUqNf5lkLy9JnD/36d6WruuaqgqL8DMeMqubDnB+ENiM2hxyEmcTf7dL/EL3VlJySN78iyzOlipuhGKP2PfI3aFYZnS8hwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pepdata.pt; spf=pass smtp.mailfrom=pepdata.pt; dkim=fail (0-bit key) header.d=pepdata.pt header.i=@pepdata.pt header.b=N+n+XHnk reason="key not found in DNS"; arc=none smtp.client-ip=136.175.108.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pepdata.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pepdata.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=pepdata.pt header.i=@pepdata.pt header.b="N+n+XHnk"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta197.mxroute.com (ZoneMTA) with ESMTPSA id 1a0f08f22f500028b2.009
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 30 Sep 2026 04:25:07 +0000
X-Zone-Loop: 4c52d12afdd262fa96af0f0f36e6e7873287ed3ab044
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pepdata.pt;
	s=x; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:MIME-Version
	:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=Q3rqBbYafqKOzi82dlVrf5nDhBNnr4qzwYl6NBphMIo=; b=N
	+n+XHnkvl57tkgr+1lh3zD7TEDjnLAuYf0qV13TcacOExVK/0eksiilJeByEW6j/Zj0JV7OMwVKbA
	jKfFi7c1As1IndqZrZxVsgRP7vOqJDuMUPDKQXTNzy9pBREU16zPCV1FKOHP5I9lVuPirT3T04clJ
	u3hoSm/5cBHDt+HRwYzQ82Ef3kDl/sIzT/vAZHtS+vVqT0UArtloWME1wJHzU4SoqmKoUAv2FiwWd
	lPdXMC/jXG0ZUa/A3vihBtOa16ZQlHL8sxS0wPZ6rHRNQIP8c3whe94K6uMIR3nT6QsNGvBTm183u
	nxtdpQ9rEIsx9dovb6NxtGF8IvMevcUnw==;
Message-ID: <14ed23dd-b171-4ffb-b368-5c717f56188c@pepdata.pt>
Date: Wed, 30 Sep 2026 05:24:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-input@vger.kernel.org, regressions@lists.linux.dev
From: =?UTF-8?Q?Andr=C3=A9_Pinheiro?= <andre@pepdata.pt>
Subject: [REGRESSION] 6.18.y: HID: asus: ROG keyboard 0b05:19b6 stops working
 after 56d1b33e644c backport; missing buffer size fix e82ae34af29e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andre@pepdata.pt

Hi,

Since 6.18.49, the internal keyboard of ASUS ROG Zephyrus G16 GU605MV
(USB 0b05:19b6, ITE Device(8910), bcdDevice 0.03) can stop sending input
events. 6.18.42 works. 6.18.51 is broken. I did not test 6.18.49/6.18.50.

Cause: the backport of 56d1b33e644c ("HID: asus: simplify RGB init
sequence") made asus_kbd_get_functions() run for QUIRK_ROG_NKEY_KEYBOARD
devices too. That function reads feature report 0x5A into a buffer of
FEATURE_KBD_REPORT_SIZE = 16 bytes. This device answers with 63 bytes, so
the transfer fails with EOVERFLOW. The buffer size fix is in mainline as
e82ae34af29e ("HID: asus: fortify keyboard handshake", 
FEATURE_KBD_REPORT_SIZE
16 -> 64; its message says "Since the response is more than 16 bytes,
increase the buffer size to 64 as well to avoid overflow errors"). It is in
the same series as 56d1b33e644c but was not backported. v7.0 has the value
64 (checked in the source, not booted on this machine).

Symptom (6.18.51):
   asus 0003:0B05:19B6.0001: Asus failed to request functions: -75
   asus 0003:0B05:19B6.0001: Failed to initialize backlight.
usbmon:
   S Ci:1:002:0 s a1 01 035a 0000 0010 16 <
   C Ci:1:002:0 -75 0

The HID report descriptor (1102 bytes, from sysfs) declares Feature report
0x5A as 62 data bytes plus the report ID (63). The device matches its own
descriptor; the driver buffer is too small.

Evidence. Same physical device and USB host controller (xhci on 6.18.42) in
both runs, only the guest kernel driving the HID device changes; bytes read
from the evdev node while typing:
   guest 6.18.42: 16776 bytes in 12 s
   guest 6.18.51: -75 as above, 0 bytes in 12 s

Requests sent by hand on 6.18.42 through hidraw (HIDIOCGFEATURE on report
0x5A), device re-enumerated before each case, bytes in 5 s windows:
   GET 16, no SET before:  7488 -> EOVERFLOW -> 0
   GET 32, no SET before:  7776 -> EOVERFLOW -> 0
   GET 64, no SET before:  8208 -> ok, 63 bytes returned -> 8568
   SET 5a 05 20 31 00 08, then GET 64: 8496 -> ok, 63 bytes -> 7920
   SET, then GET 16:       7848 -> EOVERFLOW -> 7056 (did not silence 
this run)
   (an earlier run of SET, GET 16: 2736 -> 6984 after SET -> 0 after GET)
With a 64-byte buffer byte 6 of the reply is 0x83, i.e. 
SUPPORT_KBD_BACKLIGHT
is set. So with the fix the driver would register the backlight instead of
failing. One or two runs per case, only this device tested.

Request: please backport e82ae34af29e (or at least the 
FEATURE_KBD_REPORT_SIZE
16 -> 64 change) to 6.18.y, and to any other stable branch that received
56d1b33e644c. Alternatively drop 56d1b33e644c there.

Thanks,
André

