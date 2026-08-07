Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118D3AFCF2;
	Fri,  7 Aug 2026 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087072; cv=none; b=m7PZZl/2MomQ0u6LbhbqFU1a1vSrKjG1q4AApfv0UZ4gH43dQ1MREe8SJ0nINKCGBriAq6TEnF84Fgc+ORZsWTe4WCXkqDu9ZZeXvHjkqct0eIKHMN9Ki7yLgVf0GBNXgPfTmju+BHHSSPBkowZMvVEBkzdMClM+3YnkUxb5+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087072; c=relaxed/simple;
	bh=kGLaynbVs0max8n25l5hHvF3hSwFmzk6hhHHal/wTLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QVmBwzgd+Tcy1N7RvUNPIhNm4wTlWJHc9KTl2rMeh1OnyLjKtlDjGMDLSvqgYa1umHLVBvZRQoj6wGRm64Wwy0xuSU3hFT2J6Bmi3tUCwHjPh8XnQndgDTHeHMNfH9dN5oYutPlw+rl9/B39QQZCgbxcV3uNjBnMLURF2KllYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g3jqUiMz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g3jqUiMz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kGLaynbVs0max8n25l5hHvF3hSwFmzk6hhHHal/wTLw=;
	t=1786087068; x=1787296668; b=g3jqUiMzAEpoCtkDo1EL3IAGnXq/bZNSiJNBMdxFFPczHd0
	IPjqzKBQ9FiIQdFDvHHDiD0QMkEy5Ou9WCWhQj/Po6nkpEAaDcUZsbh8yRxmap2b2g8q/67nyC69r
	mVr2pkSME3AayazRGU2CaTon6+qjeDMKOAD8jUJBpnI8xZguuMBBDU7QqB72rL86S8onGLs919e3F
	Yb9J9T3DQl3C6jREPUxfqt4lW+AoydFZ/pP8MVXxoPIP+Hvg8Xc5jll+fnX5ZU9ctDoDv6qMn1qkc
	AbwPQkryyDEf7jxfFBBTMJrbjCdThDWou+wi9NwKWJygFPr1f1EMNx2SVpUqBcAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wsEpr-0000000GxLq-0VQi;
	Fri, 07 Aug 2026 09:17:43 +0200
Message-ID: <ec0e5426914e9a10466f870f464cab349ca9b6e0.camel@sipsolutions.net>
Subject: Re: [PATCH v5] wifi: brcmfmac: cyw: pass PMKID to firmware if
 present
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Bogdan Nicolae
	 <bogdan.nicolae@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 07 Aug 2026 09:17:42 +0200
In-Reply-To: <ca791519-5967-4d30-919b-146158432990@broadcom.com> (sfid-20260807_084714_855076_FDABF219)
References: <20260807032209.447044-1-bogdan.nicolae@gmail.com>
	 <ca791519-5967-4d30-919b-146158432990@broadcom.com>
	 (sfid-20260807_084714_855076_FDABF219)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-08-07 at 08:47 +0200, Arend van Spriel wrote:
>=20
> It looks like you hand edited the patch but now the number of line is 9=
=20
> and not 8. Not sure if Johannes wants to hand edit that, but it does=20
> apply once fixed.

Nope. Please send patches that apply, that way also the nipa bot can
compile test them etc.

johannes
