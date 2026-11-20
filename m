Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208837;
	b=cmgo0Yv5tCaTDN7hN0/z5LhSpz6DjuhQsSiHGzGYJH4EUK1xOvkaAbxpm4U+XlfIxrhi
	 dbdI8MfxA1rlzKVA+Zn3oMkbLIr51mOyDuPFbKe8+8csPUA3hb/evOs2DP5DLeT741qte
	 CgmnJcatwsgHYZdRes3gDwLi+eoC6Ik/G19Ksk16XTCjU8pbYxtIRkCJ+iBZzoiCn33lQ
	 Qf33CnFcbcckn86gVtyRmW2Sc0s7bwdUjBr88xveImjkEFCCyDiu8T31Rfa4z5IaATwXJ
	 FMD977TPuHwW6VO0YgrDt/MSccvDVS87+WdhzVy4oTGZ/0UYtdeRMuFIjkXhLhSUFEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7jrrtoj6v0NCmCpB0Z88oB4a8HDSQG98zdWLNMlabu8=;
	b=dNuG33pVXVMh8+9dHO/RyeI3wFKfZ3zmj6iDo3+w1FbkiD7vq2oEruFiT5GD15EzpiCV
	 L7BWfMd4gd+bbTbvfvjPqvTv8GOkhXqfpCfRKLi4zutcVrcMJxowsHBTlrmdAnH9/y5W/
	 W4sUN0lfHgo63cRME6kH6x8ZTIQAI4wL1SwNCZsZiayZnajVyCDF++KEYCG3lDXOKnzpV
	 S/17y0lx7vlOmZIOAH1zLuUlMMQ84SEDMYQieutQoxDNG8BNEsCg/dneb+VWDSOG5cC25
	 s2LZ5OwEBoAUjkP46vxYfqpl4E8xVehIYsK5jANPSpXc7Cf3eFmtxtyIVyZjtaeeYsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GwVF4Jn9;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AA606A6BE
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 990AA606A6BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GwVF4Jn9
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38190551625so2279494eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208835; x=1795813635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7jrrtoj6v0NCmCpB0Z88oB4a8HDSQG98zdWLNMlabu8=;
        b=GwVF4Jn9eZO2wRAEn0rlpvXXCjH4SynS6Rs4Y1execPCOih144WClMxXEP51uMNjQD
         ZIJfSuOKfpql7V91LVjEVljkGN1+Xavx1ldMekNwrLuykliRCACF6NHgFUQsI5MThz+U
         Wq3KQQA26RNCl0362YFySpWZk9oPtqH1lHgW3iNYTbaf+geMqyrTxuwFFliQvhl7YQ1O
         DLPS0il4qQPwVgTPgO/5TV1Q0aqCrsDtN+57aJZEL9dmU/vM9hsDQEGfhiMwV173oBkx
         YawPjrGxY5zV0n7NKVtjS8vw7b9DK3oWwHGmQlWX0YUpBcYBd1mQVKJL13snXPDx3erY
         8XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208835; x=1795813635;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jrrtoj6v0NCmCpB0Z88oB4a8HDSQG98zdWLNMlabu8=;
        b=DFba+eFRcdBlazq1fka7ZJWPrHyt3Y+EtsI7NFsf848uW5ofr93a7Ypw0KaVR27JOG
         Sn7uK3I0wq93G2TtSkw9u7outj6zGi7spKXccmgTxKishJorJQhhzygN0u2lZT697hzM
         H6JaBRdBcgJ82DUX159vXBD4oP6X9hxqdFtDWdRJ/G2vImo7celPchBzO5akRqftz9uF
         uVt+hzGPCzci6NWNnPX67h3cfe4ZF05j2Kk53gXXdGYhl9kSlB80tLuIxfuV6AHGJAVF
         8ytNIIdkm1MuCcB9W3scEheFR6h0ImjU+gvkPBR3+glhWidSpDlStg9KbsyK8skn3s4D
         26rQ==
X-Forwarded-Encrypted: i=1; AL+hErHnywFKbqq44wEcOxnzmuW6eG0lQd8UyE6/IIFAbNc5OXuaq3H+3tf5g9LIv2sP595gGd/1JAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q6GouHuaaZv58nklY/UacTpR4uoB5gRO39iJlVPI1FLBWzF2i
	E50/Gbq1KOGC1HXRDocWqHIQV/huYrfFwud7TXs3mo0uxXIGAN25PeYz
X-Gm-Gg: AYBFou32nZ3F+gifX3OtIpwsvhBOune8Gt7bg4YbejY9uhrH+aT1hIQ3HwMIbPQ7Ebz
	W50SncITzIvpOZ93RJjXDzKhJY5SEAXHx+xxGeWlXhULqFPMDIySisi5ADLYR9iXg0DUjYWolym
	IVCFhkOxKJRFAW8Ww7mSBwnheEfwQf9+inHZoRk3A+xNUY7460zz2iaTS+yNFKEbjVPoH87EOQM
	5YGlUSlVx/EoanOdnjfWMG1yaDEIyU6+FfadSZxa1L+JCKI545yVQzFa10AzM7tRkpJ80UczmZr
	b25/kp9SAWcCuHch3vS5Nso2FZP5NFYoGKkqpoMkEQdnA/M4W2TnfRAzmyUtTIRMQVHr3t4U3b+
	7vyk2ibIWggqtxaemT8CmrBZ5jxqo0+7mxhTGYaXPO4LwlI5wF8EmR2m7RN3Ynr5XAu245v/iPl
	AruQzT2Soz7jZx2DkXcdRH2VSQgZFji8+GLG9dj6VPYYROSTG9GWXsoHEId4+whwyXFN42PuTCw
	o/Xf9WrC9+eVCnjiIK2Nvp8qEPi6oBinbTX0ZDby12KujlRRKwhe4fd0llYWn0bH+nNO23Ty74V
	ASbd9rTLXdJy2ZacZ32gnK5aVr2GNcQqZODsqv+jif7/Oa9XDUSGaO54mZiXZcs3JtyAwLKd2hb
	/RjmdBbpRqht1PnrP3Jgwdo+w
X-Received: by 2002:a05:701b:2083:10b0:164:4e36:f956 with SMTP id a92af1059eb24-1b5568b47a4mr4157620c88.16.1795208834608;
        Fri, 20 Nov 2026 13:07:14 -0800 (PST)
Received: from ehlo.thunderbird.net ([2a00:79e1:2e00:6c01:7cf7:3a98:7b9f:8575])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm8822424c88.10.2026.11.20.13.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 13:07:13 -0800 (PST)
Date: Fri, 20 Nov 2026 13:07:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <bentiss@kernel.org>,
 Gideon Heinz <gideonheinz02@gmail.com>,
 =?ISO-8859-1?Q?Filipe_La=EDns?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>,
 Edwin Velds <e.velds@gmail.com>,
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_04/14=5D_HID=3A_logitech-hidpp?=
 =?US-ASCII?Q?=3A_disable_works_before_stopping_transport?=
User-Agent: K-9 Mail for Android
In-Reply-To: <73r1s387-pn80-s74n-o50s-056r1pn8512n@xreary.bet>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com> <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com> <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet> <awCMOvYf64DZfuWF@google.com> <73r1s387-pn80-s74n-o50s-056r1pn8512n@xreary.bet>
Message-ID: <2F4EEC0F-5662-4FE4-B9A3-9FCB83B587B1@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 20, 2026 10:12:23 AM PST, Jiri Kosina <jikos@kernel=2Eorg> wrot=
e:
>On Fri, 20 Nov 2026, Dmitry Torokhov wrote:
>
>> Ah, yes, I un-exported it in my hidraw cleanup patch series that you
>> just applied=2E
>
>Hmm, but that cleanup is sitting in hid=2Egit#for-7=2E5/hidraw, while thi=
s=20
>build breakage occured in for-7=2E4/upstream-fixes, which is based on Lin=
us'=20
>tree and doesn't include that hidraw cleanup =2E=2E=2E

Doesn't next mix it all together?=20

>
>> Hoisted by my own petard ;)
>
>:))
>
>Thanks,
>


--=20
Dmitry
