Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4D4DD6C7
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003338; cv=none; b=U0YEIfcyx2KGUnFLVh/d26nMZ16dLSTKj2IatSgme7u5xD+AA+BtRPVFPAJJyCp6CFQhRy5Uoss/l3F8QoynWUgBATjwT/DbauVPnbu3dvDZSG4WVYouOsTvsZwJ55mUNe91piwTSLZQ/YlaSGtQJDhW8K/RaTkbEcW/AY08Q50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003338; c=relaxed/simple;
	bh=X0v+pdLm4eebtmxzuL0FkfVIdaQI1Wejo7pvA1CttEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+HE88U3nSZ4lEeuHOXjl5NaYtXBd42/M4HHF7kQpn43jZqYMv0fTT846gZahwruo06V5ThrKosqXcQioEavNNZ5ANcaRjLiOMyFwYzZmgStoXbC/sJtHyNymtgUI2qIKjk7BaXa4UoL38ZylhRcDpA24uBqxSODBTbY7FzN02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOQ+Gw4T; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOQ+Gw4T"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e51d3d83cso97176585a.2
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783003336; x=1783608136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGhCyTuFsY4MtVQ5mlREfznmev5FlA4r6HKXtDURUQ4=;
        b=BOQ+Gw4T6VuP4d8As9vdFIGDln+onQ/Vtw/QYaTbcQAcCOVkqcTn1dFbbKjbfCMtYP
         yCtbiSbm2k8/kIx9XQNKZv5bhAbJXekHrfBhOYFB4v0W7Jr6dyf/rRBRP3vf/4jE/vKn
         rlY7Rqlb+gaaI5dcL2GdO9qDqzXwEZFG3+eJC5R1Vt9pu3gdfRVPwL0p/rspz+mbi2u/
         A54BxtEmLnBBjCIH+tZd5dFe4PmZseEfNKBCoR2eHBzmw+3oYNzWN/yMyjb2SuHflvqT
         oxnK4c5Wqx563Dlwfh9v4kYh4eY21QfiBMmPNm/HMKakooyOpm4SNRMlcps55uhFKGgC
         R8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003336; x=1783608136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGhCyTuFsY4MtVQ5mlREfznmev5FlA4r6HKXtDURUQ4=;
        b=FfTeXP2PMwCYl2diXObENPvzsVp46SRF3OS0Wb+ycUQ3cBdvYwVWp+g5F42CVexbke
         P79mAAsnlXEFjzN55aCVQHT+WgWUE4wlnOd0cZ8+iHVXv3sXxmjWXW0dhlBkX4mrPJJ7
         iAhJP55GNZayzz43TLhS1U+wQyobK+PIIB7MAmYXPxeCM4FE4BPr6F95mvN9WoTDnorN
         IsSINy6DVOxmFNopLZMz2bk15x/inOqAz8CuabqlChiX4r7HxZyrRNvB4mfmeDRMSwse
         4QuIWw4WCd/3OuGDy/etYYFAlBVqWTKUeG1JEMfsYXYY8O/WpsBec4E9JCO5yv7HYeER
         pSIw==
X-Gm-Message-State: AOJu0YzSyq0lLt5wOJJio4yPOPA1nqSFCmLGHctg2epF9quRMdgaQPK7
	wsbbxYCSWXi/TagCXGVmPGYp2Znj1unyImd3xgWHWcftrcBWoVWS9fmJPnB/X/cEoGQ=
X-Gm-Gg: AfdE7ckjcNgLgMjlwmyPOidJvbz7a6c1teO5PNsCtdtsAFUTgCldnBBTQtMlQm9IiR3
	TreZ+vxSEDYJ6QRRKzM8QNBE6Fonn5DxFwJPlN4PAPqkIfkcJf4QFlzsz8aFYPBfCKcR6sjEXg+
	ezJwsk/ciu7siB3z+YB9h24Ogde7EWMMJ+Ouc465n4tQArxIawSpPAHKvu3mQH3oqCdcQ1XmMCJ
	oVh85/Ji5sm4n3IMb7aQkKbzcxsEmlqhMDwj+WIsEXh1dg3/CCzINgFNdOPkZO/X8jP2D02kC73
	wJFWdDhff3VBJK9NH8ZMnnAfmT/kGqzoKNUw0I3y3WD5YphRgb5gVzIb5SbI423VUJJj3k44GNf
	r+Yj6oSQ3yjHlHtGj9knPkQH9xS657ArLUBVBnv6iMU+g2IHg99FwU/vOSlJizEziM45GJl9NCx
	UpXK71q2XrEQ+Veub3j/Mor5kEjG0Zy0Ckulzy0zruX8IKXFv7cnLKxra9SzLau7MBia90tenP+
	yIcDNiXfJghypBqkptjNaCcsjFQUpZlRV6I
X-Received: by 2002:a05:620a:44d0:b0:92b:6805:eae0 with SMTP id af79cd13be357-92e784e92fbmr829858785a.61.1783003336249;
        Thu, 02 Jul 2026 07:42:16 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e800146acsm236934785a.13.2026.07.02.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:42:15 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Erazo <mendozayt13@gmail.com>
Subject: [PATCH 0/2] Bluetooth: ISO: backport missed OOB write fix to 6.6.y and 6.1.y
Date: Thu,  2 Jul 2026 14:42:05 +0000
Message-ID: <20260702144207.320421-1-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, Luiz,

Following the guidance Greg gave on my earlier report to security@kernel.org
(subject: "Bluetooth ISO: unbounded memcpy in iso_connect_ind still in stable
LTS", 2026-07-02) - that this is a stable backport miss rather than a new
security bug - here are the two backports.

Root cause: upstream commit f4da3ee15de99e ("Bluetooth: ISO: Copy BASE if
service data matches EIR_BAA_SERVICE_UUID", 2023-09-28, mainline v6.7)
addressed the OOB write in iso_connect_ind() but landed without a Fixes: tag,
so the stable autoselect bot never picked it up. linux-6.6.y (v6.6.143) and
linux-6.1.y (v6.1.176) both still ship the pre-fix code where ev3->length,
a __u8 in [0, 255], drives memcpy() directly into iso_pi(sk)->base[248].
Values in [249, 255] overflow 1 to 7 bytes into adjacent fields of struct
iso_pinfo, including the low bytes of iso_pi(sk)->conn.  FORTIFY_SOURCE
flags the write but does not block it.

Affected branch matrix (as of today, 2026-07-02):

  * linux-6.6.y  (v6.6.143)  vulnerable  - patch 1/2
  * linux-6.1.y  (v6.1.176)  vulnerable  - patch 2/2
  * linux-5.15.y            NOT affected  - iso_connect_ind PA-report handling
                                            was introduced by commit 9c0826310bfb
                                            in v6.5, after 5.15.y branched.
                                            My earlier email to security@kernel.org
                                            listed 5.15.y in error; please disregard.

Both patches are straight backports of f4da3ee15de99e:

  * 1/2 (6.6.y): applies cleanly.  eir_get_service_data(),
    EIR_BAA_SERVICE_UUID, and the eir.h include are already present in the
    tree, so this is a plain "git apply" of the upstream diff on iso.c.

  * 2/2 (6.1.y): needs a small mechanical adjustment - iso.c in 6.1.y does
    not #include "eir.h" and does not define EIR_BAA_SERVICE_UUID; both are
    added here to match the upstream commit.  eir_get_service_data() itself
    is already declared in net/bluetooth/eir.h on 6.1.y, so no other files
    are touched.  The put_user() correction that upstream f4da3ee15de99e
    also folded into iso_sock_getsockopt() is intentionally omitted; that
    hunk is an unrelated getsockopt correctness fix and dropping it keeps
    the backport minimal and focused on the OOB write.

Reachability of the underlying bug: any host with an ISO listening socket
bound as a broadcast sink (LE Audio / Auracast use case).  No pairing
required, single HCI_EV_LE_PER_ADV_REPORT event within BLE radio range.

Build verification: net/bluetooth/iso.o builds cleanly in both trees with
BT + BT_LE + BT_HCIVHCI enabled on x86_64 defconfig.  No new checkpatch
errors; the two warnings reported are "unknown commit id" (shallow clone)
and one long line in the backport-note paragraph.

I did not include a reproducer or PoC in this series because the fix is
the one Luiz/Claudia already landed upstream and there is no dispute about
the OOB write - the point of the series is only to carry the same fix into
the two LTS branches that missed it.  A userspace reproducer against
/dev/vhci exists locally and is available on request if the maintainers
want to confirm on their side.

Jeremy Erazo (2):
  Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
  Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

 net/bluetooth/iso.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

--
2.47.3

