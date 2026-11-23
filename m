Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477576;
	b=mkW3bCiHcdGU2mlS2l+WH1suwMFsDxhcZZ+bSyiyWVr7Keg+fFYliWKs+aftxwFVPmx+
	 w6yYbl0fN8/QI7AVYEEldJr3IN6DIFbdx7xG1KpDaw6U2bsksYCEN8cUn307Vy0sXDSgG
	 HYLzImvVS1395n+OYKvqEplCBRDhI9j54bvL8XOS0tTE8vb6lVPjTlvmq7gY6tys/Krax
	 HY8zbIeFvuCbgPFGfnAob96sqfcXsAtuuwQHQ9ztDfiauqOwP1QVvJgll6StvLMqIi2ho
	 UZEuiZwJ135hSlq1+lPMji/l8TsRVCkwftSO6MPUx/olHfjNCtJzLMZJfbn7LREgKxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477576;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=qBTU+kkUjDqgzTLWgD8ieRhpDmXZZKfl3HC+UBTKcf4=;
	b=ixSoKvslVEisKEs0d16TNBwQms8VPsAchgtm0U4KXkzWqcV9JZtlS9a0rTRX1niOwAj8
	 0zkmQ3plS+sBQsGTyqg2Muwmey0Rpa1e9wwn4IXYy1cQn1nPkB0brz4ht++QCYZ1huHVx
	 qQ2/DWrbkBBKZVx4Z4n/b/jT/0Sj5L/uBXDM6iznuI1+GDbsC35agqbQ43hWGdFvst0tI
	 1HrMUp7cQ+QSi2BSJklpcOKAM6EqzVynEgTmtx7UcBFFA48SvrR7qgatuES1YGD9UEpJ0
	 ys9Nu657TfT+OopUBeg6FajY71h9U2RGuXsjc+Zo3C0aBpxEsLhYRqaeHN+9+kC2uDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Y06fz40G;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10208606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10208606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Y06fz40G
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso1584038a12.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477575; x=1796082375;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qBTU+kkUjDqgzTLWgD8ieRhpDmXZZKfl3HC+UBTKcf4=;
        b=WsT823c9XA6H50ycpeEV9uRf094B/0NO4uF2Ft6eKq9TMVIg7R3n90tPWrrfL9N12K
         t3iO8EN/fa6FUdIplxnVhDN9oofChw3zy6H3IYv+wH1LGCYLMSwZq9qaBhWlZcjdWWzD
         sid8ZainxvzjcVe862lbt85IDJoDrXUU2kxRP1NmeFgsDpGqLM2684sMALtTiK6U8CYa
         gV/7nJylRY3ZhRFG1XX9wN/QhQ0cFLxwZp31JIzbNn2DG0M3fuKHIBBZvB13JQYdls2Q
         9HO4g8l8Y/WK5XTtFz2HyVh74lf+AHrSGsp3PtGAF2XNVsSerdbYBGG8N6DaRPDwZmob
         ND1Q==
X-Forwarded-Encrypted: i=1; AL+hErGgvEjJl3r1s7GGMrlBwS0/Ba71Vc29ULDB/CfvDj8DjtahdbaKdo9V2/wJTioAedzZFii47S0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ytYQ6Iuo36F9LPuYIYVbqJCbQQrFzNrcaKtnULBLHKN+J06PK
	cfPAtYiXs8QSWyNqTBuobJJ36Qs8o8DHQ0r3fxm1GMOrIHac2nYvaWUTPjLIGtiqg8td182xh97
	pZQvXr/MNK0PwlgXeDMxjen4KaHdQicsVcnx4xGluFmtyURqOYffgOJzcEsV1MXcbtApUfPPpkd
	yZLJEGFkDwgm3w6VYBCs3vvXLB+HVibDnaaRmli6sqq9MJxzXn9o6lyl8/XViq7b2ICa354Fh1u
	6kBr9p9Qv6kM5AM+JwC
X-Gm-Gg: AZFdTZehSMXJ5by9n99NetqbjkC4ju5apceFnzd1hpTIhE48c/iZYo4fG5dnIuWOWyJ
	Amgd9VnoYxIR4+63ib9Z++0M92yz51shv8Za6F1CjoJyo3jP0+39sbrecaWl67eQva5aK/nA/kg
	vUl378+geQX6dMUOUumYC75jE6Y4EOLvX/j2iQRxJsJlpM2A1+u2c3neeKxll3xc9s6+9AJ+ahP
	40ANEA/aSoX2wY8R97KbHHVKTSf9Shv/bZXB+HB5yMjtXKJe0iuL6eFkN2mz3oW39WyfLztKkgj
	4mKalkLijQbCLX3Q3vM4ZXHJ1KOQQR91FdiVHxrBWfP2HiqmV9Aqg+JagyPQ83rlRbvYFlsPOuf
	sMOSnlVPceyDQo5DCuvyQkmIZDE+3ayMj4An51t8EcVHPKTt5SyGlJoHRunfU84jEzgTTBVhq6c
	TT/jzXDmUvmrbcJsTHUqoUQ374F5Iw3aK76IiENhewD+nrxGg=
X-Received: by 2002:a17:90b:1d03:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3b41c8ff729mr12407722a91.14.1795477575226;
        Mon, 23 Nov 2026 15:46:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41d245549sm4982772a91.2.2026.11.23.15.46.14
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2026 15:46:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7d2ecff433dso2594631137.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795477574; x=1796082374; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBTU+kkUjDqgzTLWgD8ieRhpDmXZZKfl3HC+UBTKcf4=;
        b=Y06fz40G6XT4Gavy3gmL5DRaxwnn20iRRjvOtLi277HuBfgEzzmRbKBusxU4PQw8ll
         6V3L1e1Gi2hiI3SbeZxPmM31v+dIFmcSx0L5XGM+HND2uDSQvcA85lcSzT7mdvM208cf
         JUh6wC33F91r9W9ubuuV1i6DVVmxZCyA6GyH0=
X-Forwarded-Encrypted: i=1; AL+hErE1UwdmesOzaGbdr7CxwJu5eThkuPgoTgqhkQrCWA9+Vavai8m62To9CpxufgIR25PaokSsYc4=@vger.kernel.org
X-Received: by 2002:a05:6102:1610:b0:7d2:8dd0:2eb with SMTP id ada2fe7eead31-7d7393ff1d8mr5969332137.8.1795477574039;
        Mon, 23 Nov 2026 15:46:14 -0800 (PST)
X-Received: by 2002:a05:6102:1610:b0:7d2:8dd0:2eb with SMTP id
 ada2fe7eead31-7d7393ff1d8mr5969322137.8.1795477573649; Mon, 23 Nov 2026
 15:46:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org> <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
From: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Date: Mon, 23 Nov 2026 15:45:47 -0800
X-Gm-Features: Aa3M54o9To1m2Mt4frhSqoy_chjBpgWQHpG9-FBy-A8uiNdhJvZ87Cw0sfMLCGk
Message-ID: <CACKNADXLUOdqtJLWdqy1OPEeEmj+XnPk8usqRHcssOYjt+8yeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vmw_balloon: account 2 MiB pages in NR_BALLOON_PAGES
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nico Pache <nico.pache@linux.dev>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000046faa0660fa33fc"

--000000000000046faa0660fa33fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:34=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> vmw_balloon keeps 2 MiB balloon-inflated pages on its own list, not
> using balloon core that takes otherwise care of updating NR_BALLOON_PAGES
> for base pages.
>
> So far we didn't account 2 MiB pages under the "Balloon" counters, so
> /proc/meminfo etc. would not reflect them.
>
> Fix it by updating NR_BALLOON_PAGES when enqueuing and dequeuing for
> these pages manually.
>
> This has low urgency.
>
> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES sta=
te")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  drivers/misc/vmw_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>

--000000000000046faa0660fa33fc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGczCCBFug
AwIBAgIMP8k3oYr9dy0fawOFMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDc1N1oXDTI2MTEyOTA2NDc1N1owgbcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEcMBoGA1UEAxMTSmVycmluIFNoYWppIEdlb3Jn
ZTEvMC0GCSqGSIb3DQEJARYgamVycmluLnNoYWppLWdlb3JnZUBicm9hZGNvbS5jb20wggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC97H4mZ7IND/iMuoaowZaUcFWQmAEUROR90vJqkzU3
4ljaKHGMed2anb74NFJ+ij38btvWCdWlqUCs4umStciFyeOshWgBWlZO3bpE9BkonLzG9DGwSz5v
Ve2coDRxUIjXbcXgys1z+HiIaZVEBEtpGgBz/Y6KeJr6HHOLq3+1VA6HZ887DMaJ0BygdtOm/g/o
6d185nbusa6X1Si3WqQQEGq9/dHdVg/ScOBl4Hu/sEyY5dYEtIS6+wJOfeWq7PnJwK/ebKrmDXRl
CPyPFwCghdN64vwTIJ+z21krDj9mv3w4e/ow2NiOI82oVpFYCmR7NQAYn+zR+9ZMebTTtUR/AgMB
AAGjggHhMIIB3TAOBgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAC
hjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMu
Y3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVj
YTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQw
MgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1Ud
EwQCMAAwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCsGA1UdEQQkMCKBIGplcnJpbi5zaGFqaS1nZW9yZ2VAYnJvYWRjb20u
Y29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCS
MB0GA1UdDgQWBBRPHRKFeJNRjFAKjHRo2iVVbhmbHzANBgkqhkiG9w0BAQsFAAOCAgEAZ1qrS6Fb
dv9hzcer2Yv+uU29P/iOOBMMIkRHYE2il+wClTPJMmcqRAmTu8S2az2h8XpMkKoWDTHwcj2KUfaQ
UlkMc5m9wMxAVDrklB1uE25jWKnE2X3NQn62oxIMbATya2F6ev8p59kLh2xo0GVxotVnapnbuAaH
2D6xevthNq3e2akPKltISCI38CVOcC7rWuBZrLgdR8dEDLyZW6UMPwJLk7v4ZPyn8E5pMKc0fI5V
ZaWzs68PnkVmKNbpx1cECaQjsrBrXo/HNOQ/DGhHXNIF2k71laGetuCwhewrSdiLQZ3g+oAAvfKU
/FZV1kxiUVet5SmPA02BCW5yz80uHPemLT8KW8un9H15UXd+axLYqKEgr0nzl9stxbsC3vC4pbXQ
688Xqj7ZDCj3LGVbFWcdQ6bPAcxDwLm2z6A7PJdV4xDPTYhsK4io5/ZfaHOC8DqKT3klVZIo+Heg
5NMaydZ2ZiuKonE1AwMVn0KLV7r+vs/l8mIxwHLrNuWu501u2FYtMLcau6ZT0KbjwCKmMVqpvqMk
Wybe9jF+aZWzjNutxjSJGP5oSmrUpNP3UzAio93FKeLiweQ6L7E6GTBIrWNKHEog46OpVY865QPD
v1r5jLUYELDXa/NsznnUxWljMsYK9Qa4a9MUkQn+FF0b1xE5XuFm3mncJgGAsbZeN8kxggJXMIIC
UwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQD
Ex9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgw/yTehiv13LR9rA4UwDQYJYIZIAWUD
BAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHHwhlLmK+lPSjnvL0KJHTVkI4kBzkdH2IHR6pHEdN9L
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MTEyMzIzNDYxNFow
XAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAK
BggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJXc
BfmrWXFo69xOCkcKAonrEpIu5YNuIdsEaxRC5r7BR21kWFGz6i7JUyYx5bfAjtjl8OfdVzh9kxMH
kBw2aGvpq2DZgbbXRDf1A2JoH07VhvbtaWnsCxpoM9vGreNMdwJZQvgieBUAfrFjwVH5XrFkK3UZ
UXn8TNNq/xPBDvrNRVUvq44ZS5LDXikxAs5LZwtb9Pyo2vve6N0Glo+UuPlH46UaFKTXxQ/m8XWP
Hyi4L0pE3AfjHT1r6uA++/IjuklgTR8WwKFp40O7USavYut9YyFI/DKwdFMTaHIPAMgtq8GCCM+v
+lRG/dDMsLbHxK8FR1f9/VzdsLRaGZoIkUs=
--000000000000046faa0660fa33fc--
