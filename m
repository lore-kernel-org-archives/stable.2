Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661584;
	b=k0alQCtXTV25c5hP9ClWrNs1cD6fer6RglwwXAEPrdqOsLeNm5POPZNCYb35O5iQ16/J
	 RGcjAHYb4jwdSHc7bSfbji5L43ICsc/3eFnCw4CIQ16sO9zQaw0fyEe18k12CA9tXHmDk
	 kWrbhPTPy3+Q5uA20VVoaiiiE6cT0eK1TImIhdmpGgARHg9Dn8Ls4QQmQLapn2EsOsXIN
	 /BeSLwSViF7nF3fQ39chpTt+OYkOSCAD7Ks2bzsopP20f6P7EGpehuApL8rHhP6SkVpPz
	 wSZIaJqEK8Tut/H7/a8Byk3zhD8+e3Qyi/ert+obh/OrqAU9wM1Mwk+lin8ARmuwsrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661584;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=MNO86/vPNqNj1ipvoo0nLkf4S6QTI8ifhfqmHv8QTLc=;
	b=RnKAW4WsNJPsZ/L6//4h9hVZ18+gZA7Z7aeZII10A1R0udnmg7Fq50c4Z2+fRkztVGQk
	 6PfV554WWZRQ5L/mbd3xC3EX/02dNk2x0pnH56CZfD4bDOfk6077EA/gNzDrbINCCvXPh
	 SjESOP1iSrNYNeuMlEkWI4b1bbYZF9nDc5orCNThVcSk/BTyT83QiZx55n1EX1ZS4H/aN
	 cPO8/SH9tGWI6AzCiBd6NBdmuH4vH2//zulvtaIOkfYeY1+l7sqCB3Y3zc3z3++Cznpoa
	 805sg3CdiAa/OLuUEkIcxEt9nmNRGfLth7FLWMu/AWVHnSnnKT8iaBW+qnnPDJDaUhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=X0XWt5ef;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A93606A319;
	Thu, 22 Oct 2026 09:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A93606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=X0XWt5ef
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1792661527;
	bh=MNO86/vPNqNj1ipvoo0nLkf4S6QTI8ifhfqmHv8QTLc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=X0XWt5efgrf16/36sevCEXi6yunRWAcucw825CKt1LPupt3ONBsTaYTaBeFVr46nF
	 89oAuMdGdmfpwPnIHopjLBnWitATyAS260kcxADP7y1gA5HD7hpfTzF+oz3b2hO+8g
	 EdOdBwcH6yUeyPJ/sArS0EdCAyGoVpZAn94dfhtU=
X-QQ-mid: zesmtpsz4t1792661521tf8c4d186
X-QQ-Originating-IP: dPy+WkuC9bdncRwOP6S9bDiBeHuFCmOE3cM24EOhmeQ=
Received: from SW-U22IC-015.dc.com ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 Oct 2026 17:31:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12619411188459355194
EX-QQ-RecipientCnt: 8
From: Peixin Xie <peixin.xie@linux.spacemit.com>
To: sashal@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	peixin.xie@linux.spacemit.com,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] ACPI: scan: Defer device power initialization
Date: Thu, 22 Oct 2026 17:31:58 +0800
Message-Id: <20261022093158.739937-1-peixin.xie@linux.spacemit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019135441.1420968-273-sashal@kernel.org>
References: <20261019135441.1420968-273-sashal@kernel.org>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OC9B+nDkeCKkI9jAP7HbmnP3PO7SHXtCwDR6cXqg+/YW6pEM8g68anKk
	qROa5eHOEw7NRGKKuv/m0MV3VtfWAFoMKlmUl/HJsbP8XncOLyGbF7WjJbyVFZREGVMe6yj
	SZuO1kO9EzfjiPwyVZlFA5eXV+UZL5zjhldM2YSB2LPfRI2J6a16VokQEH78aDS2kw6CWIY
	QFfnwVgVDVmj7nKjnoWVHOVpW0notiuM1spT2Wgi6rwuva+VnHNcJkGgkmPii661KwtGdWX
	uGjW+3RZ3kUTrQ+X2RxrtNX1Dj9HlnRTHB3XvHJD+zfsThqLuI5wR4vNa3cxyS8Vq04HUQp
	/cUhz9ocmLC5O5p7B47t6v6rmpCZVobZ+1HLAyNgltFHBRp4HMyNpiPN5oHZSVoglrt7KGf
	1XafMpJ1LzYe5fRspSkHyYj4jckuWAFiKNdFlzydI+H1AAvgoHHvwfcjVLL+NG3LfuWEVuV
	/kzSod1Fgvk7Y19zxUjcyGF2xIe2w+S43wdIP6rgv994bj/oPmBaeW74KsN3IEh03oadhZb
	I/jKr9PzcrYDIIz84mwvyLUnKbKguloTzGGrfCF9vumk0V2TEBvTcSfaMfrUFaqRo0OZ56O
	+4W+1OUV7DnR+3Ye3CeAAXCY/BkImD6y/+LwSognyx4v7EEclMnW5RKQfXl3Vmmdd/jxxcq
	bjZK0vtcL5LbbtkzmkNBZ8JMFtw4xpmyYdpFAP7orowQ+E1IIDv82LGYyWmurxK8UDZ1lSF
	LcdyeW95WnqP5VHBpgKcVKUmtZgR1+Px99S/jIc+JVyDSxD01b3v3DxK3V81UiERDVETS+r
	M/YvfNlIV6YOqMGc7hzuQXFVEadHCOg1YHSlb/N6NgDSvGCWfQysWrQIyGJr3snhO9/8u64
	IU9RoDCXbBs3HWU45GNhH/Fyho/PYgf1+pwUOyOEsJoe4m2aOsVOID9ee88VijECXX+PWUN
	SvLQUg0qIUjZOpsJ8UehPzhNygYIUlDe3MXWLFvnS+Dq3BoC1p3yGcFHuFD9o755U8zWISj
	xlxzdFiSZ/FoNVV6BZGgBEdGwbQOjHpHvGO0Uy2VTkdC04cQSH+uUs6wFmoRN3dsROqf9hh
	6+rNZb8M/jp
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Hi Sasha,

Please drop this from AUTOSEL for all targeted stable branches.

This patch has been reverted. And Rafael has started a new thread to
discuss a replacement fix.

Link:
https://lore.kernel.org/lkml/6029658.DvuYhMxLoT@rafael.j.wysocki/
https://lore.kernel.org/lkml/6044499.DvuYhMxLoT@rafael.j.wysocki/

Thanks,
Peixin
