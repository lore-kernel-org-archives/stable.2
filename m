Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846328;
	b=QqDGHMifAePhkeqquAULTr2b287wvS4/0mMfJ7GgEYNoymMuJ77QHhtTgVvPI1L6ElAs
	 jtij7rbUKoaPiJURKTgu7M61VC3HNqCt3OW0+JNpWg9wXmmSSoAIoMLKaIdaR/7e/tFrn
	 hubn87DIjMja8vk164oawgIxFocBVnJ+5TtFCn3c2OEf/2kPmIYsXfifFxkvpRtSNWVy+
	 gHFBzsjH1KBgiNOY+fWFUaHGu5yfXsI9OfFxMbcqFL9CdkJ8E6Heo4pmNb1OlrHcHzho7
	 1xTQU9o+T1jILYMRCi5JDZoJ8AX0EuVNW14B4AWuLMIz79cNQW+CyQvIQevJ7htIK2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846328;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=nfAo8gKwyjLZUCgQEZBMJt0Gv/Zr7/LHlFcOJKb/c4E=;
	b=4Zkik83cOIvnGa4LKevpYshEJ2C//4kXI/4nfF27rA+dJEUS686yEJUZCmaAGAaG2ru8
	 73rz9ethvjHdCxflpaTCWmu5FsQBSjpAaZqU4kaoPys6te/gHj5dhLHA5cMrYzkI7rqZB
	 DDyqVE9zQi8G3KjX51i4FI4kyRwb8b5OxCtkyW0qpJGte2LqrPbrHUCCAt0mmw3+vXNKb
	 hCvI1XnWxPV27QDAUR/R1+lyDtNwGapkjn0h7XccZaykgI2m1/RaCI9vl6cSeL6k6WwRx
	 y9+7Wx+Bt9xBLNnrn1Q9iz16+cX9XB0fgvqKL/m1WlHlV/ANf4/BauH7MZfvXupkbnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="I8mG/tut";
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA55606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DA55606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=I8mG/tut
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-ccca948203aso608838a12.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846327; x=1794451127;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nfAo8gKwyjLZUCgQEZBMJt0Gv/Zr7/LHlFcOJKb/c4E=;
        b=ARiwADwhS+ntq1AG7wRVLW6zq0ggo9rrE4sdioE5+sHmusdSBvjIuxsUifZNjn9qPw
         1jUsOJhlLMe4YYPQjfcFxhBDxbnvrMxLdfJY8bSKU1uD6cvw/hb3HEHG0HAskt5eKBIA
         a8nIDpWzJYVBQtgEzQ8PioT9jT+jg/3+tCfNWfXD9v23V5fHKGXCU5C1aK7L7O2Ew9Cl
         gIB1XDaVUz5wuLE19uPmuf6Y05mpPWY6nHpX9SR1Heqy97VFLSkecCvIoWavgim3yMSB
         4BnWrIUpX6K/aA/cH4ALOu0G2yfvRg13VgjpMvXZ8sha+3LURVuN9693dhTB70R2M6qz
         c4Ew==
X-Forwarded-Encrypted: i=1; AKwUvBzdbuQ/Aposozx3Y7m6i1QaRUGXdHaqv/2S+PIVFCIE9+hs1OAFwFIilsAiVxmsZE1SnwK/fkU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SV0rIYKX37FaUNeiNeVsIYS9zHV044PX6IgPPvNys7c9YUZ+A
	E/o4S/HpTeZhf+LqmQUBe/hmBOfoEHqngKjBLpiUPN4I9VgAlQ01YiVzCEvyjbu8EoIf6ZRgQZ6
	kC+/DZz1zQAbtdTpO4waTWqO1EO2U5KKMHOQaj8hFnni7KlDMn2CbIebytW5Cyeu3oqmayqhGsV
	Pvg/BGDTl6GbNQD0JWKbXWLO1epSpJ5vzWvQLG5EffqWLlc1x1sd+VBh5lMw7GJ+YHHxiGt25PL
	TuBJ8z4teB3D/Pw
X-Gm-Gg: AYBFou3/WEXoNDN7/zIEL6Q0TsbN3mpS1y5ss8Lu2Ryk4LitubXUi0xW5hk+IKRggMq
	Miq+abVeogBgRGnWo5bM0tnZ9JAhs+vHtCHsjRmyJryKVHjA+1lXomOhD415TvmpT9QiZNUDvQQ
	njpQH/EVnAiEdRbEuLK4StR/1/mcIileNws1DjVrLohgYWX4AS+UfUFSzN6yeCI/NZw7HTjXJoG
	T8C8HPAmsX2AC+gPLQ753MDQkbPjnYXhvOxuuGUX4Zq7vKYn+PWYMS6m7WFMqD3qPJM50O1a00L
	Ui+uXuSBA/nQNMnHTBh4us5WJiiR/K+2suB/esA2nvMIwgen1hIsVek5E/kKI0sak02xDo1ZDuG
	yrc1goFgEfWP0qgBjjkPquTKBqdRU+US5BZO0qJOYmxF9zTEdYZflfnCMioDzajGG63bG6laww/
	IL2DpMBCp2f8qenkBYdG/YXe8H0W2vgpik7jG2SHqy
X-Received: by 2002:a17:90b:3b51:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3ae897dc967mr14754765a91.53.1793846327309;
        Wed, 04 Nov 2026 18:38:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b096bd2672sm1121251a91.2.2026.11.04.18.38.46
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:38:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3552883bd19so882480eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793846325; x=1794451125; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nfAo8gKwyjLZUCgQEZBMJt0Gv/Zr7/LHlFcOJKb/c4E=;
        b=I8mG/tutevJzTuMVlLvMDU5GZfrFPe88h9U4mGbJgDnO3lVLsXgBWBMYOGm/66nyqf
         ssY+jJM/IZRIPqcdQDvJZVWvFb6ozvjUjG7NlL92lem+5rzUS5SfyR2bHya64RGg9Jjz
         6UIru2ioKFJNKuy4xuVSx8pDvXytj1SEWRBBQ=
X-Forwarded-Encrypted: i=1; AKwUvBxfboSYQVni/wD7WYWeQi9jzvSz/rCzZEud0je03fLqr6ZFLqywk7TBX1Q2SxJGYXJbTELrJic=@vger.kernel.org
X-Received: by 2002:a05:701b:4515:20b0:1a7:78a3:bda8 with SMTP id a92af1059eb24-1ac5b5ee671mr26473766c88.27.1793846325062;
        Wed, 04 Nov 2026 18:38:45 -0800 (PST)
X-Received: by 2002:a05:701b:4515:20b0:1a7:78a3:bda8 with SMTP id a92af1059eb24-1ac5b5ee671mr26473730c88.27.1793846324249;
        Wed, 04 Nov 2026 18:38:44 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm11813857c88.8.2026.11.04.18.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:38:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:40:04 -0800
Message-Id: <DMMXH9KG5DJ6.UTFIEPC9BAQO@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6/6] drm/vmwgfx: reserve cursor MOBs before unpinning
 them
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-7-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-7-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

