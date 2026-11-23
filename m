Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422078;
	b=YvzNYaaZyoSCL9Kt0/T46f4D1BfKEav3KFhPz8tKjw9Z+W4PtkKGSbc6uCcG9z5GT01u
	 43vT/+cwk9A8aU4oTQqep9hSEM6wFB6QCsaK+cAT4hhf5rpWX/+f6qjFxSIGLrbEQ9X3d
	 XJ11YzBeLA2Mx6U4z6PNSnJPp0nN1zZdkx3Um/0XTey9fAnLEnEqEnFy5C+17GIWujroj
	 lTGS1Fw73d0X4eYFFdgyavlQXkdhxT0NeMW5RXNxsdUep1ppgpkZ1jAswICdOU0iLN2QU
	 WoDPDPAbrBh5HoVEBUp3JClZoiNEU5qz3Ob4xWLHzwKEEUxscgviGvjK+3R/IpxwEMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422078;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=urV9PEPwEvrHK4qayGYwaVV8yhJ/QEoLReqAK4fiRYQ=;
	b=J4dw1juh9S+e1Dd1OGC6IvGzqsBD+qP1MzDRhSRAkdGJ6TrzcCSVxVwFWqAeMub6R7hv
	 ymdCvrfefuTZdJazSBjpbdVl8afJqImQbBs/l/Y08LI3xsINYRHwcfTN9hOMEDzRU28PY
	 CPaHM+bnfO3KJIsffvdNsoXLNC9/Gz+waSTqQ5XhZbandGCWj9Wc3Iv0XvN14vnXdoClV
	 5MxMO2LIOh36xeCTIKFd46UUFWyrzcjHWaxw/hZ/eGU/qxiI4KiN6NxX+uNo56ubXhiLy
	 vZyMVABDgoCKJZ6AwpR9o1tpaGR1bUNl85xPW9jc/0QLEMAhHU5BGpYe8L00ze7iaug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FAC606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8FAC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so2218882e0c.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795422077; x=1796026877;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=urV9PEPwEvrHK4qayGYwaVV8yhJ/QEoLReqAK4fiRYQ=;
        b=DQzemFmkRcYNdI16R+sxh0CeHIPDV3OjC4DNskhPbV0Awe3ULVGiy7lmJvAOec1+rh
         PnxpbLvSZsLv4fJBCicY5+eaA4IwssWlF6PLgt7tOA/5Y0P97kWedUvANiROC0EPx249
         cMjCltHTs6R/Fom8n7/7x3BKqZH2wHLRbn2irzDfvpnOsTbiTCBVeWGg0TsHzSWOAyJw
         QOd7kxjhV/nNGn8uWz2xJExJu0U5XPeZpO3SFG20MoGKpMvyVuP3lih9NbhcVrVHSylS
         RFwrCoYpBK/xRQKXjBH14YzizVlrFZ8637IMpuUp2wySZ8IwXqO+gWB2jPVBohmp1LK3
         w0/A==
X-Forwarded-Encrypted: i=1; AL+hErEF0OFb2Ma4+w3y/u7vxEF3Jcq0f4+ZUhVCzGggrqOlKPUW+0Uz2vE5MorfPrlBhS/v7An89RU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8A1Avc19aMtf/YFoGjILvO8hS5YO5HsbqMq7DFgR5SLyH3cl4r
	9jimfONAUvrihIKLHZgCL4nPKEsT7JumigCUR0LyHYIWLTaHhgcQKRPW8p3Tgkfg
X-Gm-Gg: AZFdTZc+XUqXh8waab8MIbBJVsE2sTcCms5oJzwzZYs4k3dWOK45NVD+H1i16J9jWJW
	J1FvQOlMlAp5Dh4/rnbjiHVXeGZ42cRt4QyRFZ9A8NneEFbCCZEXSIuNyos9Eww/n8HxQFeAVG9
	I121C8peTcc7jr9rAQj6z5J0hMys9tyDRXMWYaif0hK+7+7vhNOONa20/iBMF549F+TO/DXdrvi
	RyJwsQvHstpnppqV2QEzekHm3LYXgKeervqFlWX3lLKBy19/A+LqWX7UsSHPD2t4TqviYR5/W6f
	HvGJ2WnprMEogdM/mtZKv5hZYW96y9wPEoZ9a7DfIB5meAKX4G+Sex505+pe0coZ1JtGYvgwh27
	NgeE7blG3E7dtgOFOkCHLs01LMgFUY6dQ/0yTvWL6Rc4w0jif+mpjK/t+TynL1xISO0htoelxeB
	gsag4xd/gmx37u1NCq0mK/49Hjx076ojwM0IWN2FR39eEPZH6wdbKtWS+5FjtJvv+B9m7R05DnE
	WvRlEGJSlv4sZ2n8k4OY3s+xvDmI7FO/QiqiokavFZ4TazriwkftlqDTi1FQtUuCMnX36RlAKdK
	ma7FwZJILMoFWejKlBkg3YSKZ5Mf9ererCYV34PBcg5s7zb7tgiP/RYnx9DHh8Yy7vY=
X-Received: by 2002:a05:6122:421c:b0:5ec:bdfa:8f56 with SMTP id 71dfb90a1353d-5ee8aecd19cmr4815940e0c.11.1795422076713;
        Mon, 23 Nov 2026 00:21:16 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee91a4e0cfsm8503215e0c.13.2026.11.23.00.21.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 00:21:16 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso1680216241.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:21:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGQPX7AFAxaRwiptYjhx+QQw/tCkd5TxiwmlS+O0YQYXQ3TPB7oD3Cusifnompj2+RaOWq9GcA=@vger.kernel.org
X-Received: by 2002:a05:6102:84cc:20b0:7d8:869e:8e54 with SMTP id
 ada2fe7eead31-7d8869e8ec4mr1539357137.7.1795422075752; Mon, 23 Nov 2026
 00:21:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122160447.519889-1-zihengw03@163.com>
In-Reply-To: <20261122160447.519889-1-zihengw03@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Nov 2026 09:21:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWxC7LNy3MTNYE62AoWBB6sHm9jKAsYKRjrZ+LfHjArtQ@mail.gmail.com>
X-Gm-Features: Aa3M54oDJAacN4ZgRznlESFwii2fz_UdwV-FQBJ6wD20kL1ynEn2pjnzqtgO3U0
Message-ID: <CAMuHMdWxC7LNy3MTNYE62AoWBB6sHm9jKAsYKRjrZ+LfHjArtQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: 53c700: fix invalid frees in m68k driver remove paths
To: Ziheng Wei <zihengw03@163.com>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Kars de Jong <jongk@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

CC Kars

On Sun, 22 Nov 2026 at 17:05, Ziheng Wei <zihengw03@163.com> wrote:
> NCR_700_detect() stores the allocated host parameters in
> host->hostdata[0]. The m68k remove paths instead use shost_priv(host),
> which returns the address of the pointer slot and causes an interior free.
>
> Free the pointer stored in host->hostdata[0], as the other 53c700 drivers
> do.
>
> Found by LLM-assisted static analysis. Cross-compiled for m68k; no
> runtime test on the affected hardware.
>
> Fixes: a16efc1cbf0a ("[SCSI] 53c700: Amiga 4000T NCR53c710 SCSI")
> Fixes: 8276b58af4dd ("[SCSI] 53c700: m68k BVME6000 NCR53C710 SCSI")
> Fixes: 506c7bbcd9bc ("[SCSI] 53c700: m68k MVME16x NCR53C710 SCSI")
> Fixes: 45804fbb00ee ("[SCSI] 53c700: Amiga Zorro NCR53c710 SCSI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziheng Wei <zihengw03@163.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
