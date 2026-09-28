Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823D4A689E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595124; cv=none; b=tiGOPkSqdJWEYHdL1qISk7SNK6yR19dtoh0suQj7nuxCNXGilrke3xC5iDeILRfEu2sVOhTg0IjMQmamysCFWpP92I9xYJtZl7Ws16mzQBubeUDx08aMgkrpLLXx0EfrUCRBUNbSG/p01VB4D7hoOB2Hp2/Qo0cu0Eqqi6fkgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595124; c=relaxed/simple;
	bh=6n8VlIQR4RxEU97JfR+BbO3o2h4EONnXlUmRE2Ejn+c=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gslETWKOn55fRQNzzJtEhyk+CPV3Q6vaFVers1fPL4i0AyForONVAk2Aq3i8rpXpeHNkNJ6BuCK3cZA9vvzj9rYhagYd89Dvz/sbtgg1BKJsoKDkkx8sf58baQcd7hvct6VtSR3qTWgERPEerjkpSTlMCvlK9iU5LvqPpwII5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=oCdFRTBQ; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="oCdFRTBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1790595113; x=1790854313;
	bh=6n8VlIQR4RxEU97JfR+BbO3o2h4EONnXlUmRE2Ejn+c=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oCdFRTBQ4Dhz6vhV05iatfi1Y8IgjBIbZH0S0sTAxm8cbn6z9co9jrPC3niduZZP9
	 dvlrEnA0GwglrdyBd4Zz6C1H+TXSNVGwvWQl+BRxEf2V3OYtGXqmR9pCLIfHRwCTny
	 lAMr97LIchUr1w7vHJfcXVvn75oxGO7LMnopOY/p6DOVeQvBGORjIx92m4Uhu+Whbz
	 gDVwAZGwaI5GiKgBk3S2FVkFqZXe6HwYO5VOll4oga+G+Ltia1oyrdJnTu8rR2N8E3
	 iCY55UvirRN5Le1Ue8ng7KBLEUoAywf8k3L4w4bYFJgUhgoauDqbWBofq4lkLXL0Ig
	 zeat1KhJZBYAg==
Date: Mon, 28 Sep 2026 11:31:50 +0000
From: adisveletanlic <adisveletanlic@proton.me>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Adis Veletanlic <adisveletanlic@proton.me>
Subject: Re: [PATCH wireless] wifi: iwlwifi: mvm: fix self-deadlock in WoWLAN key programming
Message-ID: <7iFmIPid2uOGjWVohSqEyxjzfMI735hdqbZHZ2A5Ba80dkouT1t2tn5vLG4QULDQ5YUYXMqvB0pgrKHJZBSvyN0VC2LoUTNOmc79PPNv_QE=@proton.me>
In-Reply-To: <20260927-main-v1-1-0d59a25f0373@proton.me>
References: <20260927-main-v1-1-0d59a25f0373@proton.me>
Feedback-ID: 138116827:user:proton
X-Pm-Message-ID: ce3f491479aec2f5af5631f0be6be783f9ddb2fc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Please disregard this copy. I resent it a few minutes later with the
iwlwifi maintainer in To:

https://lore.kernel.org/linux-wireless/20260927-main-v1-1-660ffbc9837c@prot=
on.me/

Sorry for the noise.

Regards,
Adis Veletanlic
