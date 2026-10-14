Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D95328DB;
	Wed, 14 Oct 2026 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984759; cv=none; b=RhSyaLdnXS6jJlkc72ZuHHQDfpixOGGNJaiqx84+Bp6OcecJaJUMivbBF0gn7/phUAKJH30aradBiy12tHFhBYisyXxudWgOqxejoAncSPvhsZpHbm7UbM+JSzpLe4VdOfAwi9m9jNWXT+1OzhYxlDcg4b7o1ZqaCJ0pVqfIW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984759; c=relaxed/simple;
	bh=zH455MKZRTlj6L4mNnWaOW11k6KUIJMJWLD+NkJjmSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnN+E2lOwO3LMBvwSfWhcO6RKtvi3BVuDtkNIMwfvDYHFe2JFBzGpNfU7Jd8nam769nTjYMSHQF2N1VsJGg61Hi6Oy/QaAXubgv0aCiSTLNzQtTuawizjVq5SGmcxGOd2pXKFEKx+GdpGRF8UQLGUXO+0BTVWEMsXUV00tLX2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Wp1LnsJX; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Wp1LnsJX"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D6EBC80B77;
	Wed, 14 Oct 2026 15:32:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CCztpOJC4oGS; Wed, 14 Oct 2026 15:32:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791984748; bh=zH455MKZRTlj6L4mNnWaOW11k6KUIJMJWLD+NkJjmSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wp1LnsJXSO+JMaZNJe6O2e1pHn9/9N2v+Q472A/okQq7cFF6wOVuucX2TRZtfWptl
	 kpFz/tawIqilxLOU3rct2xzP/0E1JigEJ9QKdf2p0FfM48Jyq2kF1pMB/qRv7QQNhX
	 4y9fJM6jDEuCDuSdpZHbCO+OpqX/p/MwpYE+YyCKse7FsrHdlTlLujdMFon8bzb7rc
	 uMn3FcRWPHW52RGOHeiMhxo3u/dnjR9YbK/EiM03lwVXf73Jf99N7B2DH7nZLwTpcj
	 edk6q/JLXk7olsx3zL7mAWD82nY20ydkSFZVInMlNcioA7+us+gGmnKu7ydAwIebwV
	 k8c3zmGeRkIdw==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: johannes.goede@oss.qualcomm.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
Date: Wed, 14 Oct 2026 16:32:14 +0300
Message-ID: <20261014133218.94357-1-aliamemis@disroot.org>
In-Reply-To: <ab5c5ae1-1bfd-4fe4-adef-fb64b5b3dfbb@oss.qualcomm.com>
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me> <20261012225141.13683-1-aliamemis@disroot.org> <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com> <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com> <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com> <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com> <20261013210609.8117-1-aliamemis@disroot.org> <ab5c5ae1-1bfd-4fe4-adef-fb64b5b3dfbb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 12:01:55PM +0200, johannes.goede@oss.qualcomm.com wrote:
> Can you post a patch series for the code you've for this now ?

Posted: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.org/

> Note I guess you're using LLM to help you with this, that is fine,
> but can you please manually shorten the commit messages of the patches
> a bit if they were written by LLM?

No LLM used here, I just thought the race needed some explanation.  I
kept the series short.
