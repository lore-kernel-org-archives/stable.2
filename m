Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846350;
	b=D6cyBdD1ynzpoCZlHCTeJtY7sxJoDoROD1hhhYJrck3VY7LP7VnUrlpH01SouWMenjCQ
	 UZJs8jikV9Po7nE36Ak1SOcswhsp3YVvWfFAitHQT7SDPYrV1vzsekv0Bfdnq6G+ecu71
	 GY397881VGWdrgl8/BJ6wIz6XttrPcD7X2mfE7YLKN3QXsq+PbvrDNHqkTkBalfmtTneS
	 L1+1lpUNxx3pQbSK7RO/d/xJh6XkufnJbhWa7nAaFrZNQ1DcubEjC3Dw3GG2D0I5QAQuV
	 T2nuwYsk604tPGhbnlU3bYZgxRwxlYQfd3Z3bKVHYHzFWeN+s97THkQVTpEeqwg2uEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846350;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
	b=NkkBSXIlJk3H8Nq43xqizJHBpJ2XEgywRJLrsz3wsxDZO0csDNMLG/vKToLlMj0f5+QZ
	 Psy4W4TSDXA4/KAXGTV5oBvJ5cclVHxH/TaaRffknG6qzsZ3Bb+p4gpLR8cRytllErcPA
	 RebIS+MXJ06/SQ8F++TzwPHOppHoqVUFPycPDUhB0J3ZRRgaP3fVnInTh1SI8JWNZWWV4
	 nbJAe02O1RV+42xdHhV7+cuHoo7MsLPO5BXfunBfoK/hisyyTMhUdCOuCf9dxAow437Fw
	 BJ8Ss6LOxlXYdLvCX+n194qin/7On7JWX+b7S+KBYRwLjPv/7ZE830GI/tk30VlUw8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=S8RyTLky;
	arc=none smtp.remote-ip=74.125.82.100
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C2606A330
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F4C2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=S8RyTLky
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-1adbf62dd31so1949823c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846349; x=1794451149;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=KvBRKBoouOKEKl3JwW2OWal7A7lx8OHoJpNYabhg3Hkv1nmrfnPr/EQbdV+pJVGnpE
         dw/9A+1ABWaRY/iwt/sWQv7NELQxA6kOGpidTc0r3OtfzrFZzem7LAa13F+TEUiPEdQM
         lUuatHbTGzqEdpDrqAenwdUXmqQ/fIDzj4n0QxbmuDSz/ucUU49FCOAWy5PXLQeiwM7N
         RDQeYtIr2O4Xg7Vvi1pty+N8LWAYASDmyX27GC5GqJJiWF3N58LVZDO8FFUhDhZnc4KI
         bcfniBrICuEe4WH8ir4bMv0UkMToWpjI4mqwxcOjjUT8D2VHo8kqLXzGsYTpLTOo2D1N
         Bxww==
X-Forwarded-Encrypted: i=1; AKwUvByzBz2yE3QgraAlezsHKGt9vyhR4uRL67oDvD2xSmCwuwGrEMgdEcnnPlun4BNDnELj22hl7sk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TnncZDh9dCLUdhejZcvTCfxH5WuCEZl15b6MjaKrKyuo1UB9n
	M1C+jePyCBftOBUH11LfbDVpP5MOaptqrP8AJIGZPX8kKJ13Re6gmGsqiD/WoRrDiUhrGtf2Fgj
	bcKwLcbtubFGRGzVn24YlQiMauKLiVjrQES/ONZpw+CfvU2466YGdU8/bv76+cziCY8R6Mvv91i
	y8m386Al5Ir/g3N5bGJ6kluUBEFRVl4aF4yk58WyJ/Jhs8PQIBT0YBx6bVclgzKdwqvcXwwRKrg
	GZPu/S92QkpoTnV
X-Gm-Gg: AYBFou2cMaqL0qhH35nbu9DVQsnibINA2JQhm7HBlu0ckfveS67yys/MmWsegtxS/fV
	yMNY1Ouww3q7cZWUhyapIAwREKfyOUmKwe7GsBokK+0/rCMNL7TDZlF1uCJLMnAZ+7nix2MCc+Q
	mntRGep6kdR2JKgaiKw1QsmdlOMGLQ7KPt2zeErEGsoI3S9wfe2FGmV1UhBhZ+4esTApTBgCUEb
	9NsEOkLNzDNM4IEEUH1HQmsJSei7huEW5iLL9lTE1BmHJ2wQX6FRrYkFvMQ0lQ4/VCNkh35noeL
	oANQmtuO5fokLC5w4HepFK5yY/FqYI4CbHZZ+otNNZUtdJ4KFpQqi1sELHvybTrvuILuBw+8Ini
	azG9RS8DGgk4lt7Ypfv+0r8bLpGKe+aYgm/M5RPZqSlVMYIPphxezZcXeRV+X23OsldSNNRvSwc
	f8PDA+ZyfxJrA/7/2k9YNdyCGs6TX1b7t21d0qCS5Q
X-Received: by 2002:a05:701b:4213:20b0:195:866:aff1 with SMTP id a92af1059eb24-1ac5ceef6dbmr27624329c88.25.1793846348168;
        Wed, 04 Nov 2026 18:39:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1b245c9f13fsm29796c88.2.2026.11.04.18.39.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:39:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36d69ab3c2bso1182991eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793846346; x=1794451146; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=S8RyTLkyWZSFhZNAc7neZq4Y9bkFmSOVP6IgCkLQ7YMPkVx9icXFmD53Eexcbwenxu
         s68MdUcxojsM4xT+CxkvIltG4nu6+A0PH0zTEYvQJ1gkfe+bVDLDhw7e6OnPqLbInpD9
         CU2mJv6HxZJp96jGxmWZcaosxM6JNI+eHSIbE=
X-Forwarded-Encrypted: i=1; AKwUvBxWo2xrlNql3Z2N5KxGAhkvHOfNMOjwYu8/UH7ZLedYD3b6lT56jLj6SZ32UMxCZ8AZTB0FPx8=@vger.kernel.org
X-Received: by 2002:a05:701b:455a:20b0:1b2:42db:8a54 with SMTP id a92af1059eb24-1b242db8f29mr8049205c88.23.1793846345892;
        Wed, 04 Nov 2026 18:39:05 -0800 (PST)
X-Received: by 2002:a05:701b:455a:20b0:1b2:42db:8a54 with SMTP id a92af1059eb24-1b242db8f29mr8049166c88.23.1793846344913;
        Wed, 04 Nov 2026 18:39:04 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b87c4asm11608439c88.3.2026.11.04.18.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:39:04 -0800 (PST)
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
Date: Wed, 04 Nov 2026 18:40:25 -0800
Message-Id: <DMMXHJ7E33NS.3QACG0ZSMROU5@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/6] drm/vmwgfx: keep cursor mappings and pins with each
 plane state
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-2-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-2-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

