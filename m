Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065897;
	b=k1dXoJuqBsC7z3Z55eup22/ttOlNgan4VQoOgvxn46r97cLHma6lXkbz28EhOjOexOnf
	 MFeP+OVYn+RnPuFjDjos4lE6TX1Y8sdPAmdZV3JYAhLV2nrFUD5Bg+8ea3HkLJzhd6lW6
	 eHvwfnSRxtpwcKxDdFHtu12DZuPo68wbi946mssv2sJUOKX7wk8M1RPJWMkpU94G85aAW
	 3uCXiyjFJRuUlN/QQV+CyMUMcaq2d5Ub2ZMq9yI3AZYNSN8+vlj081V7cNuVuS3Vh0iXN
	 pbE3h21v0+8JJGUk2pquU/UJKsIy+m52X5iUkDoxYMrEVWp+rObhJIGZFALdfzz/zEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065897;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HCa9XQJwSMKPzA0fB1HzzjRyJkdbwSuiZECSksNQJj0=;
	b=Zo114zOPmo7aw8u1Xov8ZMcdkSRT7DD+S+L7mFJjZl/bZB/gzPX6IVuX+t5gku6e6JT/
	 gjryINAgWQtwV7tRfOCFaMD9cqYjqtC3n+Iicrv7wb79pweDcNiiH7f9+042HgDn3lj9Z
	 u4n3t80s6+fiY3EC83ll2PH2iMrDaX2hzzeRhaJ6RgbYZ5fNW/uuiV0ylaZjyRTz6Guh7
	 Aj6cH1yqsKWPgRueulem/4q+7cLGlpcp/msDS9RJmdL1iQXUeDu5/jibx0F46koqxP641
	 yX70/Fg7bcshFhfgA7TOetdsihm2PpoL950LbEFWCE9qnBs0pmcrhVb29CSaWkHcryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AB606A31A;
	Tue, 27 Oct 2026 01:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e990beead1a811f19a56ed5b684f684d-20261027
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:19b3b936-5d1d-422a-a59b-4ec34f5a0b33,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:d7e19c3f558681996903985dad7d8eaa,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50|99
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e990beead1a811f19a56ed5b684f684d-20261027
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 37645137; Tue, 27 Oct 2026 09:51:22 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: Ihor Urazov <z0rc3r@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	huangwei@kylinos.cn
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14
Date: Tue, 27 Oct 2026 09:51:19 +0800
Message-Id: <20261027015119.3136930-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com>
References: <20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com>
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

Hi Ihor,

I had a look at this - the approach looks right, and it follows the
precedent that's already in the tree: ucsi_acer_read_version()
handles the exact same zero-version firmware behaviour on the Acer
Nitro ANV15-41 with the same read-then-substitute pattern, so this
is the second instance of a recurring problem class rather than a
one-off hack. Overriding read_version() is also the clean hook: it's
called from exactly one place in the core (ucsi_register()), so the
substitution fires once per probe, and passing non-zero versions
through unchanged means a later re-registration picks up the real
firmware value once the firmware has filled it in.

One small thing: the Fixes tag points at c1b0bc2dabfa, but the
failure mode being fixed - registration rejected with -ENODEV when
VERSION reads zero - only exists since bdc62f2bae8f ("usb: typec:
ucsi: Simplified registration and I/O API"), which introduced the
!version check. Might be worth pointing the Fixes tag there instead
for accurate attribution, though given the machine is new enough the
stable backport range is academic either way.

Reviewed-by: Huang Wei <huangwei@kylinos.cn>

Thanks,
Huang Wei
