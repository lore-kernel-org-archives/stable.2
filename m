Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3140912B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571567; cv=pass; b=WAQ9ye4Ago4qRwTSRXx717HcwucXuk7msiCloaTFPC26DwtxXwh0JuAP5LhqcJUvQoXHfuVsnUUAiU3c4ItqDDE6N6oQRV/yCtFIczNLo4nH05PNoYVttG9L1/4bqwyUafdphbsByyU8lBXpHkceBqiSuBaEwTEEEs7pBqiytWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571567; c=relaxed/simple;
	bh=IyHVcCjbrLsnikGSohgZ0HEcX226iRTLlWG+U7qEqvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIfLmFZa0Trw4O5SWKIi6Lqh/bpcY6+Ej75AKGRwsXD71ixW3uVqcWrEQ04dm9AwXcJ4GpW6TrvG5CnlLUwK/Zo/8Y1KDoEATjwTnND/iQAzx/RDFMA8Mcx4zQ/MZotV3rJt8N5ATR2YhJVetKIs3u/KUhN0k9uiJU/HxW34ieY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9rTIKCb; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9rTIKCb"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf49dc28ccso4824915ad.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571565; cv=none;
        d=google.com; s=arc-20260327;
        b=bVil1iPNoee5YjbB8/R666WX2MVAcESYP/I8ld63IUo47LaqgbybhOyPtAJ7hkmXtJ
         1Vj9iy8IJKwtVOlEw3aIdiXq4hs6swrRbliZX73vKCSL5TJwf5rwTVkSkfDqmNIqy+O+
         2JzSczlQxbWIZ1YO5+nydPz1XKFhSpF0T3EbwAn9pKLiWq4VRRrp+1OzrWTwbfX2VZ9q
         fSQIYenY6HZniRhxgtz+Z5IDzZem9+DTuyE7dI0NSzkMNvTHuVGXFTRlBrk1cPCSVqpm
         cENFcF13EUXXvZ4Jws8EGxQxSVnBy6+WP36OpD2peAe1TtLyoDIOSq3hnEUE1W/70Nmc
         CEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IyHVcCjbrLsnikGSohgZ0HEcX226iRTLlWG+U7qEqvg=;
        fh=x5E6MiUP9JXDiFL+hFvrbqRrkIyt+Dfdk317nOjOMjw=;
        b=NoKVi/Z5KIbmwsi5UlNIZdZIEL2FpwWWFx8NNkBYYC0YSf4ODyt2n3qS+esT9Tbi3r
         Fko0lPSljCzOxdwxdb8hn97xN2O5E0omoV7uTsU5ctJxGKJ6xo6zE0dg0gUioNKcyZGO
         cI9XoO7Qnw6jAy2qPNmmgkoV0n1SJi38V88ga27M5t3UtBiA4Np5NLB534KWZ647qaBP
         OtnT6BvxGf0ZosFwnvmBh0FYcrThxeSD+yqGmifbapryFNyuyt0z3MadAEJN1GOUql5N
         k4giIFtkCqrbObH2tSalbMzoaGhQCsR5QtCvwDyUaz4UmWATypLfUd31F48pLijAPY7m
         L9uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571565; x=1788176365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IyHVcCjbrLsnikGSohgZ0HEcX226iRTLlWG+U7qEqvg=;
        b=E9rTIKCbiUja8Rm2ds9mmHC6jiJmoLXzhHNYSY9fKwC5g3aRjhjgMIWxtn7h5mtSSB
         7u/O+yPrlJatNt7z9Vs0wPLACBxR1vUMWf04AXN3GM5Smk8oiw8IMz4r5CNiDf56sBdG
         2UTgOMXih+MvJffWJ6rpVokQRVDk/C13WCKS75gY9P5s7sY3VwJTHzUUbaLtQQEQvpEh
         OnYDcxT9xPl7Dn8yXyaYpqVmeHzymUSClV6xksSPzCIlvEpBMS19olb45fqrGdvvlwJY
         JvWGf/8enAqjCofCbsYtdZEezgmtUi/fPa3biGUUOu9QB2szjBuCFkkKqlUZrGn9kH4T
         w7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571565; x=1788176365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IyHVcCjbrLsnikGSohgZ0HEcX226iRTLlWG+U7qEqvg=;
        b=Udg7n0bufYLW+gu6twpTiiqDVstkhKNXx6icGEm+Z1DV2Je8rEZsoVUvvfBUxxWfTs
         CocnwgKdFLIJ0lP5wILASgORDq7TtbWqkQU5HLITzEWfy3UXXnI1G2oGwjLYfPTStR/q
         RMTiQgIQvtA4TU9wBrCo16zmWfhsbQHzkog9YhA4ndyI3Du2prkZqbgs/QoTL5cuUyBU
         TVB/e4TsjZzRhPiNLSrZ1XW15ranRiH2Q+LsPvFkVGI6GtcWt0qrcZV9Tyzlu1XMd8ll
         AxtOXJknlWz3Y6iVIG84aNfalLoRI3sh0LvtiVI4MWhrwTdQ36aNsKD+qIs2NCROwM/k
         r9Tw==
X-Forwarded-Encrypted: i=1; AHgh+RrzAUNFXqrbWmtjRhrKnF3rAVomN7/lYK3qGXuCuK/tXNJGYiC1h39KdtjL5sNUzN4RUFZXaFs=@vger.kernel.org
X-Gm-Message-State: AFuF++mMWIxEnqTBxXVYKrKLIY0TLRY2FcSrBhlYMYc2YPAJ/fPFslxM
	j6zHSuEzLvzA2ZAlWtJVyi/RdAOCHA/mPrTYDNH3/npSRCKgy5Y6fvkDUgJuxzSCsKHqwFZGbOs
	V/sIf4RpR4uEV9lb3zDDhSs5yii+aWWA=
X-Gm-Gg: AR+sD11ifSL96xpnjIHk+Y1HGz7sWS8Dv07sq3IfBUx9X3QJ9QSMeC0pq1ULV4lyFrI
	T2Ww0fU6jPxTxO30ySP4LY0ZUfhz3rXTvlg/+MvydV2ZoaOGadDuOtsRJrMH/0IumK+MQYf6ve7
	CQzZGmbHElXMuyJh6wqA97POKcKEpZnBPAih4A7a5nCIALhGESMuUJIUvYvYSWi8wLTknFa4glQ
	92M3vVUB7T3xq9efKPL30UFsTY4Q0vFyKxH+HPMfCsVZ9YS6LZsb9u00r2m7lFVd9DGC8SyPgNJ
	d2/HOxOOdgzFK5SS8bPq+yWySmD049ljE2rKFB4fByOPTVFfiKBD8D8/94zNQ2aSRUEH9+1bmMW
	BFb86rgll/qJhSXhVK6ud1ZhMGYMnyG5B/5PLVP0+EG/vzCWIkiCaBW4m6nwdcw==
X-Received: by 2002:a17:902:f709:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d64b047823mr241046625ad.2.1787571565146; Mon, 24 Aug 2026
 04:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824111227.742645-1-springbreeze@stu.pku.edu.cn>
In-Reply-To: <20260824111227.742645-1-springbreeze@stu.pku.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:39:10 +0200
X-Gm-Features: AcwNN1V9wg3yKVAh9_mN_zlYKlheXes7kkLSKf2mSnLOgXogC2B09BSq1Bgm5ns
Message-ID: <CANiq72nArSN90SWmPiKxYvnQUxuebJ-W8OiYqXmq2SZEfJnGGg@mail.gmail.com>
Subject: Re: [PATCH net v2] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Chunfeng Song <springbreeze@stu.pku.edu.cn>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	fujita.tomonori@gmail.com, ojeda@kernel.org, boqun@kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:12=E2=80=AFPM Chunfeng Song
<springbreeze@stu.pku.edu.cn> wrote:
>
> Link: https://lore.kernel.org/netdev/20231123050412.1012252-1-fujita.tomo=
nori@gmail.com/ # v8 cover letter
> Link: https://lore.kernel.org/rust-for-linux/20260823103644.342849-1-spri=
ngbreeze@stu.pku.edu.cn/ # v1

Not sure why the cover letter is linked (if there is a good reason,
please keep it), but at least for the second line above: we don't
usually link to previous versions within the commit message unless
there is a good reason.

i.e. if it is just for changelog purposes (which is good!), then it
should be placed alongside the changelog between versions after the
`---` line.

I hope that clarifies!

Cheers,
Miguel
