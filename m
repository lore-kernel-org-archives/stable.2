Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A041D202;
	Wed, 16 Sep 2026 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586965; cv=none; b=EsEiBUiWy511+vvXsdKiTN4sfCa58DLYv99dIrukKGcq1mCHUYpgFx+faHqnak2W8xEnrx83mXv0tt8ANBxNLxydUPosL8mbeV15QXLa/RRDXiRwVfYzraHu3Gbmy200htCkNdPQI5U4m8AoiaeKi0Cmty6ixkAivfiMfFdSk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586965; c=relaxed/simple;
	bh=yG0Cm/V/grf86TMwpbOVWg7S7XA47jIj27JirMa5NDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cerwpiwNfX75DR5YBtBpdb26DHXTLeaSY/VnRjIogpmrSp5KJCfDrhis2CHyVeTLZfkHvgWLdXwItHuYxO6ZMPckuPXqKlqAozoLZMlXLt22yDfaaHiCaHklLIEHf3bwKMsQJB2OE9NVT03vrKvAMCBSwxnC6snkgWdfweYAqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KePp5etf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KePp5etf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6341F008BF;
	Wed, 16 Sep 2026 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586941;
	bh=EKcLKBF7udcuQS69C7kksKs0wpPnH5+LGaowzafr4wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KePp5etfp5D7M52iJpqHN4zxFC/itUwyFhuf+JRClOouPpoQ/mySD9hWqkLS2DMDZ
	 UMnlsBTyqBFKjS0csoZvzXcxTlBVnVj9EsbnZC2bFR5fk9ZEytfsk7+S3E3f1cftTa
	 cr17DDyGHaiGg/SPmEWGM/4AFnkh/EsfFcYx49DnNVsIi3UtsOlfRcJgfjrhHfzmYs
	 QqO39xXYBvjt6kufGdpnF1gUUXUw75pITPiB2ibUT2OK56vtX/tlaaOI1cOa7SybfZ
	 wl57QPE8Jg/sxmIZiIPvI9HP6is2mYnKpTxkrIef2A3aVbcxTwXPGxGv+1+W0ZBK8f
	 pwgY2aepINOUw==
From: Sasha Levin <sashal@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
	Angel J <iamanaws@httpd.dev>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid bridge configuration
Date: Wed, 16 Sep 2026 15:28:19 -0400
Message-ID: <daily-reply-20260916-0029-re-pci-dynamic-of-node@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <Tav3crct3HpgoRPBGOe-bfkBEORVT1RkvRbP8B7IXhRvEbUTAi-G6RiSnynkgV2rJ1dOIbCxm-mHUcm1e0MyQG52qswzpxURe4KFJoddhGg=@httpd.dev>
References: <Tav3crct3HpgoRPBGOe-bfkBEORVT1RkvRbP8B7IXhRvEbUTAi-G6RiSnynkgV2rJ1dOIbCxm-mHUcm1e0MyQG52qswzpxURe4KFJoddhGg=@httpd.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The v2 patch is already in the thread. Is there anything you'd like me
> to change?

From the stable side, 6.18 is the only active tree that exposes this hang,
and I would rather carry the real fix than a stable only patch for it. Once
your v2 is merged, please tag it Cc: stable and it will reach 6.18 through
the normal queue.

-- 
Thanks,
Sasha
