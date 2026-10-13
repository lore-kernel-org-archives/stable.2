Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C715226BF;
	Tue, 13 Oct 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925590; cv=none; b=nkDm0Ch3O3AlV7mWov+UJBTrKBvZelt3oYta9VebNqBJGF+25vlEqq+6keKNPddRNYb3W+j30D+ou67pni3IvbyMvjhXZjX3p+LYNuGRn4AxD3fgHdJbVwCDZQkKsTbkR9txERJsKWwhspN5EB4FHhXFCV26e94/q+RGcATbf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925590; c=relaxed/simple;
	bh=lguRaaN9wSWOrjgxJHTfY2l8mq80mzCq7Acup6K/BjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5kenfkhlSIQgPn5yL++IhSJ4WTMpilTCjRQ+qRiM8KVkgz+iyRJDjbnRv8ES0lNI3yHHlVhQjFk371dPbuRhzDj3lHY+q+swXlpkywOXEF1PQDnzJSsptx2ricZXDr1iYi6wfgN2N11VwelsnFGIFDDcGGnKknwYBGFXoUQYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=j8Z6UnWd; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="j8Z6UnWd"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5AE4180542;
	Tue, 13 Oct 2026 23:06:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UgHFUZWsDOwE; Tue, 13 Oct 2026 23:06:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791925579; bh=lguRaaN9wSWOrjgxJHTfY2l8mq80mzCq7Acup6K/BjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j8Z6UnWd9830nqGRO1Vnx6812mLdmdoyY4b6kepJQmRJ/abpT8dNAu8jSmJq4VXnk
	 xV2739Gn9nkXq1/Uk+nYJQJowiaVHNy698Cf2E6MTqi6SvtSFdHBbgk3SF99cyQ3lV
	 6Czb/4BQFocpkJZRGDNdwfEetCrcs35FLJSGG2NM5Fmw+zRlXpornMtXB+bxSuitaV
	 YEvCanMA2ttGiaoo15ZbndnFYdV9wjKEWVEZ1wvrRqiEr99l6SprkWLP3tZWIGLKyN
	 IWoYUZo6rzqGG6JVsNcC3QXKeGdw/EuF6a3O8jFD3GJZJrYujw5EXhnbNUVq+dT80M
	 TGyfP+mUJJjlQ==
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
Date: Wed, 14 Oct 2026 00:05:46 +0300
Message-ID: <20261013210609.8117-1-aliamemis@disroot.org>
In-Reply-To: <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me> <20261012225141.13683-1-aliamemis@disroot.org> <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com> <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com> <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com> <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 07:20:55PM +0200, Rafael J. Wysocki (Intel) wrote:
> Also, we don't actually know how many "bad" cases there are and so far
> we have identified a few.

I wrote a script that extracts the ACPI tables from all 208 BIOS
packages in Lenovo's ThinkPad catalog (370 models) and flags methods
that switch the EC page selector (HIID) without BATM while other methods
use it under BATM, and checked the flagged ones by hand.  Two BIOSes do
it both with \GTST from _TMP: P1 Gen2 / X1 Extreme Gen2 and P53 / P73.
Apart from those, NVPS on T450 / T450s does it from the NVIDIA GPS
_DSM, which only the out-of-tree NVIDIA driver evaluates.  This doesn't
cover races like the UCSI one in bko221065.

FWIW, the exclusive variant is done.  With it the emulated \GTST breaks
neither _BIX after resume nor _BST at run time (0 of 5 and 0 of 1074),
and with only the _TMP side converted both still break (5 of 5 and 421
of 424).
