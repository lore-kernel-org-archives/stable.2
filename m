Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD03A16AE;
	Tue, 13 Oct 2026 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894673; cv=none; b=DMPJiPLehzc/L++AyV3DXZfP4U5UUr7yxPAVPeQcFbCibXCB5LK/UOSmY4N7DFCcegYuwliJfeSTGcCCUDdxlyIFfsTs9H1wtXuZZ6/wUoG+3oxyjuUiV8PVHe7f8ME1Puffd9iD3cYUYlvhPfxlg61fKjj5bZSf+V9K3xpF+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894673; c=relaxed/simple;
	bh=StQO+WhQWEUOezy/nce9AWZ+lPoybPZoOMXTtNPI3X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaSlf2AdcGZkbwout8YkDLXh6Rs/Kr/OUNFl93TbKVuzDcdXG6atqpFkoADInKyHFSk5Dv3oDEIcRnMqYvwnulrRRtzdrolIRzm9LFHReRs2uH50cev/kvpGg2727X7WReGPRQIuo/ZrY3OGH6uNiMi+5UTrV2UOgigDtlk9L90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CKiF6LU4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CKiF6LU4"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id EB02F80BD0;
	Tue, 13 Oct 2026 14:31:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K-TzazeVR3Rg; Tue, 13 Oct 2026 14:31:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791894668; bh=StQO+WhQWEUOezy/nce9AWZ+lPoybPZoOMXTtNPI3X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CKiF6LU4EMVYgXzGpq0qlS+CWwAKP6GVH71/cR2g9VdYTEOXbEtzyRxbgNYhziq5+
	 +C6nWt/bAUMdKNUUDF7p9BMHbObVdPBwXhDS75guUZ/P1RgJMDEqZRrI2By/2Okxz/
	 nIod/UBNsVk1qfLWuhwgxoHCQ9IK3xKy05Q/t3VgRs9SMplqoDlBMjQptuwoP5oeAf
	 kwH9T/HpcwiORC4snVfckbzEuIAjqyjWpuFiaVMr7+h6nlE6kGEaPn6A1QABF7fhwh
	 BKuK+2uc+LVLY9d63AqXVPLi6DaBpsDI0vYQZi8GxoeJDJxAHM81aGf/l0DlA+MrWk
	 Eh/ttJP7k2bog==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: johannes.goede@oss.qualcomm.com,
	Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Charis Stratakis <c.stratakis@proton.me>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	regressions@lists.linux.dev,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the complete callback
Date: Tue, 13 Oct 2026 15:30:52 +0300
Message-ID: <20261013123055.46306-1-aliamemis@disroot.org>
In-Reply-To: <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me> <20261012225141.13683-1-aliamemis@disroot.org> <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com> <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 01:58:15PM +0200, Rafael J. Wysocki (Intel) wrote:
> An alternative might be to introduce an "exclusive" variant of
> acpi_evaluate_object() with built-in locking and use it in the cases
> that are known-problematic.

An exclusive variant would have to be used on both sides here, for
_BIX/_BST and for the INT3403 _TMP, since it is \GTST in _TMP that
switches the page.  I can do that and test it the same way.

Should this patch still go in for the regression meanwhile?
