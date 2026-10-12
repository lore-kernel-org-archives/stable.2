Received: from mta1.migadu.com (out-94.mta1.migadu.com [95.215.58.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481E48CD55
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814751; cv=none; b=s64OYJD8JJFCBLTpEYYC1vgm1qqMmSdn1wOSF6bIBQUnkLZHihQNEKBZDb/t+zPwNuilymMBv0fEpZDuNVrueicJIBSyx/ndCb6nisT/+T329B8hcZtTGMkfxkOkLatuGtUL2H4GudqDYiVKbqk6dTq1ylkO7YKrRpm8LplVrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814751; c=relaxed/simple;
	bh=a9Lxp9FaV4JFLzr9Ab9brfnJxgFlHFGfCx6e2RO4akA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=b3T4kBrqT7Ene6KE6N586sxUBQfs9QD53LxwZHtkOjiLgley/RR7aNGn6orRpdZOqoRPn+WcppNjdy5HQeiQ0oxX6Euvz/Qfl8v9oVQ1uRuNtOjIkMyUlJHfbzTZou5qVthsQbBY8fSCDlP/IazMRuqEX0PoeFsneOjJeUujWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bdgf1hBg; arc=none smtp.client-ip=95.215.58.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bdgf1hBg"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=a9Lxp9FaV4JFLzr9Ab9brfnJxgFlHFGfCx6e2RO4akA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791814746; v=1; x=1792419546;
 b=bdgf1hBgzP14dCrA7q2lbjH9kmy+Os5rlYymEQwBtv/S7cezE/OLBQuCrsa6FCxIZ4BlHzUM
 hdQkeRMQgs4/HYzOBH0m1HII8mxJAJtoll/5wH1PJ3wUR8d8yX3HHqgBRefeR+p+oCDZxYVso7n
 ah0W2oT84sHqs634bp/U/v+k=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ad3dbfd57bfdc824;
	Mon, 12 Oct 2026 14:19:05 +0000
X-Mizu-Trace-ID: ad3dbfd57bfdc824
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 14:19:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <7e9af4f7528da1307cf62e53cf6b00fa9c4f674f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 5.10] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE
 loop
To: "Mikhail Dmitrichenko" <mdmitrichenko@astralinux.ru>,
 stable@vger.kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Mikhail Dmitrichenko" <mdmitrichenko@astralinux.ru>, "Sasha Levin"
 <sashal@kernel.org>, "Fabio Aiuto" <fabioaiuto83@gmail.com>, "Alexandru
 Hossu" <hossu.alexandru@gmail.com>, "Hans de Goede"
 <hdegoede@redhat.com>, "Navaneeth K" <knavaneeth786@gmail.com>, "Michael
 Straube" <straube.linux@gmail.com>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Dan Carpenter" <error27@gmail.com>,
 "Andrei Khomenkov" <khomenkov@mailbox.org>, "Dalvin-Ehinoma Noah
 Aiguobas" <fliegbert2@gmail.com>, "Michael Huang"
 <tehsiu.huang@gmail.com>, "Jinke Wu" <coolbeaner@126.com>, "Nikolay
 Kulikov" <nikolayof23@gmail.com>, "William Hansen-Baird"
 <william.hansen.baird@gmail.com>, "Serhat Kumral"
 <serhatkumral1@gmail.com>, "Nazar Kletskii" <nazar.kletskii@gmail.com>,
 "Jennifer Guo" <guojy.bj@gmail.com>, "Hans de Goede" <hansg@kernel.org>,
 lvc-project@linuxtesting.org, "stable" <stable@kernel.org>
In-Reply-To: <20261012140642.1076-1-mdmitrichenko@astralinux.ru>
References: <20261012140642.1076-1-mdmitrichenko@astralinux.ru>

October 12, 2026 at 4:06 PM, "Mikhail Dmitrichenko" <mdmitrichenko@astral=
inux.ru> wrote:


>=20
>=20From: Alexandru Hossu <hossu.alexandru@gmail.com>
>=20
>=20commit f9654207e92283e0acac5d64fe5f8835383b5a23 upstream.
>=20
>=20The IE parsing loop in OnAssocRsp() advances by (pIE->length + 2) eac=
h
> iteration but only guards on i < pkt_len. When a malicious AP sends an
> AssocResponse whose last IE has only one byte remaining in the frame
> (the element_id byte lands at pkt_len-1), the loop reads pIE->length
> from pframe[pkt_len], which is one byte past the allocated receive buff=
er.
>=20
>=20Additionally, even when the header bytes are in bounds, pIE->length
> itself can extend the data window beyond pkt_len, silently passing a
> truncated IE to the handler functions.
>=20
>=20Add two guards at the top of the loop body:
>  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
>  2. Break if the IE's declared data extends past pkt_len.
>=20
>=20Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Link: https://patch.msgid.link/20260522004531.1038924-6-hossu.alexandru=
@gmail.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[...]

Hi Mikhail,

It seems to me that this was sent by accident by running git format-patch=
 -1

You probably forgot to commit so git made last commit into a patch file.

Either way staging rtl8723bs is getting removed in linux 7.4 so any
further commits for rtl8723bs are discouraged.

Best regards,
Luka Gejak
