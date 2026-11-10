Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269030;
	b=hCsQMIHW8iXgP0A8yf9MBsaRsHFJ/A9r+Fcd1L925aHxa0MPMQ6oewfH5mJ/GL+qoibC
	 xq+BL90p83NMmznq70BnfVoPU5KaBKuXRMrCjqTL4/MXTX+h2qKAADclnj4D47O0Yf03P
	 SQcNXUC1VjdDQyQN8vIOGOSfQmTULaqEKXOYJpF1ofp3keyV0r+lkzP12RmfRdEIbHdU+
	 +wPRE2qnc9XVJcMpYrmOTuyG4dWJKzmu7RRFHtBtpxr31y86FIDc/bXqcdPq1UaxKIas7
	 Nw89TTVVDT5aQ1Et+pLSDxAP2roAyu8x6N98furxhGux2NHtWAwisIMSbylEctkV6gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269030;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=qje5ZRB8SldFm8mq0Yjsuios3RJj4d/jiM5HJdOzZuA=;
	b=MdOgY/viv4Fb6sjkaztjNf0b8+OZTTo7Y1pu1NrMWMZnoIHvfz3lrKo2rZNZ2/WNM0oz
	 oIloE8sc+7qqb/jbf49v7c9gfLtYt1AHYpHuxctlqetK+T+eX34NivFNVZgAGgeXJRRV9
	 HDUeoWnatjCY89Q7jYnObS4JtiC08sP7w4rt77f3nbYuIJrlqGE5aBCfmHscI9mjw/8eJ
	 ivD2nVqWZuxXJdnPitFHHPWjfrkek6yNQtFfqp2l3osKqgsO/KGVJOUl4wQmaBOVP5oO+
	 5EINrFsR7fEfOvET4bHgb9bGCet6bpxpw49crZxLrZqLCDGtkH3HS/X3IOZBfXaOy8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ust3UGCp;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA060A2613
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 00:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48FA060A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ust3UGCp
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so812725a91.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 16:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794269029; x=1794873829;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qje5ZRB8SldFm8mq0Yjsuios3RJj4d/jiM5HJdOzZuA=;
        b=0L1isg0hrwJgzxRLME+t9ejYRvBZw8aFjstIItkSC7QZhkPllE7DSH1jpqRHWPt4Tl
         xU52vEJ59kgbYMaPCOLA++ELswyR+KDzRyGFzxGD5e7gliDHylUqlJkRt5S9cwjwKawp
         UsjRMRo/4/1IR2rBQSx3XAroC6wLbqK0WgLkThg5wMXTDx25+nTImDscRLN6FrGqTCxi
         s7fIFzr5gyZIJsDBXD6L3H9kvLwkvh7bESN5EFWyfQttzgjLNCgMRD0VhMbKOeruXA6j
         Vw9zHyNYpnQf+VDUrPx8cS0OzRUPjKuRxhp/1DU4JoHTdPNGi8CDWgbeqKP7N2K07oMh
         SMng==
X-Forwarded-Encrypted: i=1; AL+hErGCkhxpR8/WMm11+XVQjNAK9IsgiKRdLwCw1y/ro5r9Tq4GlJrZHlLuBxUWVc9oa5+GsafvGak=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8VXWd4j501f37DqZmqNPdNTkg7TsUi2bxo+pyHVLZX6gCEpJS
	rMNQW1xoEtNJdeobnlge+CWSEay0VZxMGN9eeFBGGLG9Bzjv7fUCoz1/DPd7jJaia7PqQ5m3i9t
	ObOfp7l23j6tcIlk+SdwIRmkZKpPS2ebOrpSzQZUz2DbAddu1a2aiUcLig8YqCuxDAen6Lv++vz
	sbsCD2bUxUjKQA+X7BYmODPOhfaL0Irxg0XY6pi8xr1Lj2uY11XV4DDZ5rvmg9dah3LpkMWTmZR
	D8isTWaRWzIx2++
X-Gm-Gg: AYBFou03aQippiSDrUV1cZtxdWBqkjGCFzm9FcPeooSPTaESQTiV3voSl76jVX0gJc6
	UilaullLVn+5+sGsK1eC9AlXNydOYUZFoAljFLuX+RP7aEs7igHsXyRtV3qkscD/7r4/wG5evlT
	nldLh7hYwrcbVlc9JFTEkKpeUtWRZUoLB88AHHlek1dw2J2wy0OVRp29fsUJ0jDm3H2Rm5RY9/O
	nYkTmsB14jkFtm4XvNKPkHKko5uywDbm/6vOwh+f6TJa/Uovw49fzvVDjV4bNlLsjui7H7K2oxK
	VlTFI4GSYL//UX/1QrqO6lCyI/Lh5wdbiTSVcaAq4ai8VF1QQtIK4Gu6PKd/Jnomaa5kNOAtwPv
	R3nxF+eONfRxVBW5OmVPvQy0e34mNTh+a1bj64ezvuWkHC2gwzjoOub7Al42WQVAz1Uvjq+xVjF
	m/DCRY2IjAsfZrpFhtHMbbosHIypVcQDdaqYDZNuTR
X-Received: by 2002:a17:90b:3881:b0:3ab:2ad1:f10a with SMTP id 98e67ed59e1d1-3b1668e0619mr1142007a91.0.1794269029523;
        Mon, 09 Nov 2026 16:03:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b168b567ebsm235551a91.0.2026.11.09.16.03.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 16:03:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f5844e383so286173785a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 16:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794269028; x=1794873828; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qje5ZRB8SldFm8mq0Yjsuios3RJj4d/jiM5HJdOzZuA=;
        b=Ust3UGCp2IJQIoNDrL21pK6fGS6EzdAHAHeOa89mbUQc9IGCb1vjjWaXeuzIhLtPUO
         CCr5eTPQ0qjiWwbLmMTyugmiW7FDUH0KVQLZavFNRXbDGBf97NPx9DRU/ck5j7Ws2yzl
         KdjdvnainB7X8CGmTMRXlscxr1EX7Hdt4m7lI=
X-Forwarded-Encrypted: i=1; AL+hErGyvDFq8+rML8jeW0yoZSvmptElqsmioGr2C0VeevJvfK3s1AN9xV+VRMoasaJjLunVvSlZGOc=@vger.kernel.org
X-Received: by 2002:a05:620a:6602:b0:93f:4f87:4f5e with SMTP id af79cd13be357-9479f4296cdmr164147685a.72.1794269028279;
        Mon, 09 Nov 2026 16:03:48 -0800 (PST)
X-Received: by 2002:a05:620a:6602:b0:93f:4f87:4f5e with SMTP id af79cd13be357-9479f4296cdmr164144085a.72.1794269027731;
        Mon, 09 Nov 2026 16:03:47 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e61c150sm96207685a.2.2026.11.09.16.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 16:03:47 -0800 (PST)
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
Date: Mon, 09 Nov 2026 16:05:06 -0800
Message-Id: <DMR3BCBSPSMW.3EDXC4S26IC8F@broadcom.com>
Cc: <dri-devel@lists.freedesktop.org>,
 <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/6] drm/vmwgfx: validate GB-only cursor command limits
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-3-zack.rusin@broadcom.com>
 <DMMXFS0YGX39.56J0BV2Q2ZNA@broadcom.com>
 <CABQX2QMfQ2TS9Jg4=RewpYStMFOOn1YL1XV4caVnc_dgduWRFQ@mail.gmail.com>
In-Reply-To: <CABQX2QMfQ2TS9Jg4=RewpYStMFOOn1YL1XV4caVnc_dgduWRFQ@mail.gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Makes sense.

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

