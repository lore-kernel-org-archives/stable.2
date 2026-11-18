Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028166;
	b=CnHPMiwR7dW8hR0dQTaGj+gf3TR8t8P0aIUEqrAaKyhpg1fBJDgxJkN9+v3edXx4mjbQ
	 Ay1sos7iGv5w7231OTL6exxRtKJq9Uzl3bcZYnDrb24X6kqr5/7NXzPlUGb3VitS9Ju5I
	 cg58FWiaFMr7sDDBZxrO/+zJNywsXzp7zIyGmS552MtfmpmtT8v3nFyUxZQOHoibjA4h0
	 E5wURufn+oUIl/1SXbNkuH+cVFLAULO8obHnJzPGDbBIlLyRByDBpyUfFLhEPwx7mIqE/
	 x4tMslFT5AaODPMM0Dg2gEdJpZwaM/q8GPJ328OJMDQWfKXLo5i/7Pm0kz3WKRbzsXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028166;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=TKABY20CGx31dZRPzohkZ6qZS6v3n8fKazWnw5gyeC0=;
	b=LuOwvBVChkbHTp2Dc5OS8iFAWQUsD5k7+d+CDZQNPoh4D4Zr5uRsZcq/h0zTe4oEnv0d
	 pHSjjxkauoHp6wu6W4A2//QnYdgs3/d5MXiXUwrsaE4x/vbkw+lZhbqgfd8K3sHOKTvm4
	 Sf3HlvmGT8xQYBlcXU/eN3Bj60JLqbMbHr66+BOhcFFXRHbIHvinEXxpC76qX8RyGMAXo
	 Qa/Z1j0GaqJwj+9ekzRjfxeS6By8SeOsA1ePV429GvtUf50wKDwdVjvktsfpZn08Muy17
	 jHhvsl3gmNQX+Hbm4iTv2bohRTk0HnDHCRFoecvLfj7EvON76jAWNRQLXfwmVfAAz6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bcKCj6Zy;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57AE60A260B
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B57AE60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bcKCj6Zy
DKIM2-Signature:  i=1; m=1; t=1795028163;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:k5uWX24VY6UVM+hliUpBqPPsLIsR
   lZggn2j1fhPFG3GGrviajLwKE6me7GXJjIkGcc+a+I6zY/mJrBaDf17bogCc2vc8b3xPdE6HfbD
   Ce/8Q8jPAK5KbgPGrPyjI9LIJ6qMdJElW5bV2PUyzdI2srk7EA48HY/78dVIpNtP/tgZJAeZs5W
   vgNsVO7Otyelm4F7s0fhK8eCMH42OMEhdNRQjXj2PX0CZiNF7aVhBdnLb4rtIt+HfWnRcB4kpzz
   AlNfnNHqkK1Plru3yJjxh44ZeSsbIRF7cy9bNDPetAQrYOqvVZpm01OWYmwoA3NiWxB7pUEhffZ
   drNhQbVnmTAFjQ==;
Message-Instance:  m=1;
 h=sha256:
   oiolM2cqr/WOdK655F7tR4B+4LlowHofxjbtz6JsQWQ=:
   b+/UiGiJlK8FmnwZNuP/byofAOXz2FG+EzGm1HFBs9A=,
  sha512:
   nnmk6a2N+RvV1DeN/26eHIKr5KEAXyOC/T34TIknPkcRohvMSGaYC8z5l8TjQFe/jWaDs7dE7KXtOePKCelxhQ==:
   LH3zVN+ORpXVDkWTguryrsfzijSCqd7D+bZnl54bQMz6S6GwM/TcJmTnsk+CzacyI0jDZMU1DtzCsBdxs2Gd1A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795028146; x=1795632946; i=deller@gmx.de;
	bh=TKABY20CGx31dZRPzohkZ6qZS6v3n8fKazWnw5gyeC0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bcKCj6Zyfts/DLeo7BTg3wibKrqmYLrc+ePSw0jLxjzCZtrgZARyRzatoBNqLZT9
	 7jaUwYaPwTSvDF3gH4gJbjItpDo1TVqEF9e5X2p3ly4jigCm/8+bIHagCR8ZSf2JY
	 dySLvk3BBI7vicnd//cU4Rz2JdeA/H2WhXnFzuSvucNEQ9JO1FQZe6Jx+F5MbSMBf
	 3YpeFFjGk4FTTNC434yGB6TGwprlvudp32/fcGaoq5/JipCmg7u4RVsFW/TxfLE8M
	 fILhWU9HmE1vA87RTs/7Ui8mLXlfZhWNd+k9fJhYDtqTj/kgzaWWqba+4OrqrDUoP
	 niRlQqKMszWYWuSkoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1wtrls2suk-00hOsg; Wed, 18
 Nov 2026 19:55:46 +0100
Message-ID: <24df7648-5126-46f7-862d-9279b9523be4@gmx.de>
Date: Wed, 18 Nov 2026 19:55:44 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: sstfb: Error out if pixclock equals zero
To: Xue Haolin <xuehaolin@uniontech.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261117022031.252357-1-xuehaolin@uniontech.com>
 <20261117031714.259053-1-xuehaolin@uniontech.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261117031714.259053-1-xuehaolin@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WGsZ0vL+nomveJmA7WaURhuSR0LE0Dv8+1n4AF5KlGF7c798Hzw
 4fZLOWzfevRYWEzHjQM9JJWB+gF36tgADdM2/d1EYmj/t56jPKXVAK5rrt28h/clSErGC+w
 N02Yjva/YBcn62CXE0s5QHm3m1yR57o1rM9JZW1+KqAOpRI0a9Y0kYyAW7H2UrodaOhokbT
 Sg2GR49fSrWeUILHC3oSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GUMrTjNpLA4=;EEn5+8qtI7NCVEVQLhrTbKMKyAm
 YSryev4zKBDcjLkSUnB5Zp46AyyGCrUKAePgEm2JM/3ByWRkU90vdFRV5hE4oevCH7SILEFSo
 36vWScs30G7YcEIuI+i+6Z93L9vIqPNqyamp7Hh41Lj9jvapnNi1RxK/zZYbhwNA61AgHPJnj
 c8ytLdIBnRw/PNkJ2i8alHMahuhabtrCbnQLfhMaYZT5woJXnCog3bIlg1CK7ztgMRyhx6BYH
 rsJu3GnfF0VxBCxPITfYJTt4zFQXgSJVjEL0fDI4kpxfw0m7NafpOUgJ/huNhVGoJnt0gVig8
 NdCVYZThrQDYmQAK8Kasus5aLzNNLdz7fBhPQ3T+yM6qLDps9tZiqnM9feRbRM/0SV+SPMPz9
 F2TGE9a1wbSkXETSwa82baHq3IF+GyTrCArge77Z3WoC9op4mNl1fDpm+2/vFF5+1NbMRU79X
 48nbpZSryufml0N7LUpdGQq+f+2Vibe/nORXuMgsBNdU/asBI8CNFt7gmpjkDoQWuRDuXHmgY
 zteJEWSXc2hn8SnwgHTdL7kSgKrBDD7uJNGJckH0THzmKs4AN19C3+qDx78EQEpBhmpmX6rwi
 hO5WlnKNGkYDryg0lKcXUpASII0Ugjt0F+UMLIvsPHY1ls4Qk10i1WXsbGeQHnVAs906jZ1q1
 WmJgk06jA4Vgq9Sy0roNsz8Ud3uru22FMtufPi3xWyf29kUloAb02K1nYNKlB+5ZWRXZwgnvi
 AJ1tl+APCVIhPbIbZzL0WNVOM9XfHx+/pQK7i8Jgsn4kvODogvk6uOnHFoFXP/rmHjHKIYy5G
 HxrN9NcAwIOmbg5Ta2+7wvixEITLbAkVLSyEWwG/GuI6a524DPLcYhfXeLgvjSldOay4abAjq
 2K6F7jFEWg0+ddO3OJbrMWhTxAelWW9zKDLKpOdryXaK4Pr/HarvubJTjehhYyQeTcI0FFRhW
 DuLMCc9m7R53pi4PbcH3kJrRdQAX9i6dA0ZLGJ2blj8U13z/suzWdNFzrJqap3SFIK/dHgWue
 gYn1ChFXICzPE/IelHjoHScSqrZ6wk7u6lKDAtEaVIoDaPFkI/06m524jtBskXWfYpfbWUZqk
 MEjHQ0avxlHKxh9g/HkuUy16zgusAT4zcn45HvMeXCSDO92rpxYhEmqqPzs6e38de8mdNkw4R
 SPKjpbBCMShprBoOYAYjyVlJ1IC7+768qOnVHRfTO/4fHqDIDIH0Y1u79SYTkj3XkklHbxV8d
 LI1pL3Mi8wrrQ0VzmhtAJjTZ/6uRsJL/oS1wYpP6wpb95eBB0c0pDChe3e2NN7uXp1+zzNK0V
 TUq4bDQvXWzNyc6FnyyVpz6EHPk8RDoyrc11pIFNoPkqkQdKfcChiGcvlcqmGJbQ8P3tFxuw/
 mpKJkjkpkrO3fRXDD1ccampdjRZsDSKwU1u5q3Aor79i7gTnRpemyIoybzmB77ouJ8/YXj0lT
 70gmdbM1zRkA17fawrzmaCjHh8DeZP75Kx7JLR2bw9h0wptW8pXMDtc9AOugOaa5aZLyGZDDW
 5MLj/cdtTF5jQdFnPtORlPiDrXq979F3rr70+g4Sfe7FCTD5Uan2r4czbPJOKEx59Ykp6/8Kh
 QgBUd/fQA9JNyYTxnPhDwkPdCa1gzf5jy5iuZcrDzN2vQLr8E7uRPePotdHE6i6zt4lkKMVCO
 ho+lNT59uLuKwwgjgQI+sfSFVgaw3RJDosiA+9zHaAkRjptppUOHGugHut4V/kuIQS2SMZXKN
 Xxa61tDb0xf4yK1z/ZQQNZ/81mkF6uIH4nuBSUnxQf9mOERklIOOkvqxsN30cV9z//r0XNqUB
 5XAGEMEYG1d45vBjpuX14+jnjOh6LzNke7wKzhJoobCznKhE5Mf3XJs351Mdv00HejKZZfc/P
 2X0zDtJgZqkdIGDQREMZ1uhOlPxAHBQyqqFakXTDyRuMK29a2/24XUCXpJjD45USZdjCh4wGA
 V2aa2OT0crKhR0xaAofCO3zS1qos0NtEeewWv5sqfw3sEZ+Gy4zPR1xUIxZT8b8MDKYoMLpZ3
 KqWAX/PDXzMVhyyPGVfiaCJ4QN+nS+e3Ku5jb1JLkddFzlid0TQD/P052zEYm61OFI5ZmZGBf
 cEoPnfxStYZhxN9ABEsHc23BglelHoolbQaYQ2QrLv6G/ShQ4EXAMdBd45Cwk8vGfmVX5hNHS
 CZTbnYmh9k+Bk/kD6iGXHSC7WGWsogZdZoTxnVpbW1roE+jotltcfGxXVnMxGomOgBENllUzx
 8AQzuBt7O+Nz/CUDHkCnO1FQcmyMNbsxhOj5KaBXZklT8ciInH1jCM5g8n7bPSWHG8Ec2ttGM
 2cvcb6fGg9SJGSNk5w9UehfCIv0t4WEMxGsl4w7NDcAvyo/uqjDfH+Ffs9gnUKkhVEYLXmuV4
 5Pm8/PGrA0P+LDxA8PJ1EQh7Duiy1x83GXye79idOAaBacr2uD66FMHkXggDCuD5CxcGmm/i+
 Ulu4EGG7V5aLT/7Vv/17i1JU+IR6aJrrhuDUUHg38MytBilfjX/qgsi7HFURvhRU2dGnQTwl/
 6u/35fQ0DAztYtB57yHPuwaF1tFJ3YizF0ug7V3IEFGm2JZjPsVc7/YGLMwhG00s92c3NvgzV
 owDdvPJFxj7u/TiNZNjAYhfYTH8LnTXPJwkUHDfQ0n7zNeiFJ+BaqxgUe80G/p35Xda7meUB4
 ZEvVNvaZALPaoSWYY6Qh4JFsYk6nogNG3Mkq5PCiPnIh916nxWXNe/d4v7RY/bySuDVFlUO8n
 R8NvN9SuqIdP2uR5a1V7VX6RKkf+Z+UJe7+TQSDnp/lHsdJz3tg1kAE+Vtb51I5hHtLNwryVh
 fG24/sQ3zJrjKES2G22+eEcstNfhqOWF4v24Zje5Ec3yWtWsjye6uWjm+oNC9wAQ/FpANquMT
 9MDvXccZMVopOpkGTDsIVJ+FauAzBunw+zl/ItAKrZ3VYga++rASme/Ke2Lfatav5YJWncpUt
 iXLg97/Anoi/DCrqY68CVDNiumiIziUCVsql4SGtRCzjHs4FNvWMM2lePpdf5IDDif+DUtcFt
 IjwgG8pJNqfTheUbuwfnDYB8U/PuazBSRAKhmQaKNlmRmaowQ7ywDYeKuo1lcRd64T2KcEOiS
 UVsGNn9LS4ZLCISvNmBEM+fprN2rJ69Stxli8dHoOtLqQ/PTcT2CYeBEvBqn8UpK8+fqjOrMC
 N0Xg6EhTX1/EF5dNAorw1O+lnXcEWdfOmq4f2+Sp5edPFjiBXNs2+4VzffcDQlzqYukwmu2ej
 XXQtEFmQx+4sY+jU3OvL3V4ILLOfuiok1BEzaUrbu84hk96kgoh9BO2BmNA4ZoDLxWEUnyCUb
 lU3NEfiGUHGS+9kpIowKi9ugr9WIbDShmQ26jyWdFuQ2oQBOC16tPXq4ZlaegisaD4sA+qqiI
 YfgY5xr6rv+5CiudOl9j9LzfPhZuR4IvnxL2+jDhtKwJ0r7ybIwOYn6csjLjL/nrU2V03sxRt
 XOWE6e1oPV+TVvCghxwKiTAVP5JgW9PfIh5OAj2lFwmm3olsMMtnwbqMOD0jsQ2sItjTCSJ7e
 NWGZHTativtU1YJ0xm2Jjqk0m48ogT93XFunwY3B6U/OXGsOUrDN9MmIDZ8Rx3isBdS7g6oBM
 RqSMFtpx+95ZhtMXTvBjpICgJ1Lh/fX4w2MVC2bj5d8QU8+E0Gi2VJcdreJuIAJGvi/uQ8A/K
 iOsay801Ngv+hn9MPzKA9ksaUVyzkqOKOa1kkQgIobijr5SzJxahO+wPCBoQIJ7nVEF4jotvO
 a8bIC/zl8pSkDmQGjZWXxKvrR5sxEAS0D3JWBu3fUklxT+xWSz2BA+AttIsA+lKu0w6d/zxac
 apGVyum0Mk/d2HXjkG6GrFbxOIppFagYsCM2awVtLZmZcU4KK9KIVRjlIs10SQW3yWVaxrQ7O
 8hoX92FT9+AlNVhgnfceneFbux4WV/B1Kta08WE3F+7ybKittRUHJWp/Gv2kZKv7xjojpZC2H
 smbl00NRrmAwYbRpzOOM0g4ie2IA81EDzZ9bL2dPd/7GHXojMZ7HYNcAnaqIl+N13ncPQFIS8
 4Tb+cbjZgeFQrM0dMfmoIxhZQr5DFZPStwajWrVYqlR/M0udN0uKc4Cwm9cRqaKrGz8SU9adU
 G+RiT+WVeWeCXyJPm5pGDHnfxKe1pNJYI7G34OgS+A4pPBvdgROf/8kMywS6XD18+2fM4f84h
 fTfwpkhOSjc/hykvwao/hQiYI09oK7W1SRwG0WDSNtV3FcDcNfqPhu0s2ZwwAVOLdFypW92Jt
 rrO24tz6DSIWLQEeXd61kVAQ2EPybZ/1a/kEmShZoGBmJ+ZLJcMKplBIRw5mWJlqL8jmVRf4V
 ooprwkfdIpYTvDtFFHl/p4c/v1LslhJqcVCQY6HRiP0/B1ZZ/AlyTgNd44Or4dIs0lKEjZVXx
 jjBuA1dEBMC8uvNi4WcMhDa3uQBVOmxCKynHNUCwaVjHRU2czFJ/O9pW9Ij4hOkSt4sJtIj1z
 N2p4gaRjngKRSbYTWOq3ECVjwf4v9g7udAH8JPg9b63X4bUjRYjz0hbzCSl8rl2S5idDvfqf3
 BeErWK4r9cP/668ugaBWj1O4mgtyLzmcKCmLWdI4k5+BW/KQyb2j4NU4vbgjnDkUS9oHOz5uL
 hbLTRyg5dy0H1OIPfM70Rxan2tYbZj+1KyX1DU8yGXp3SeRDWFTejtsdmELk+8fy5vd2vcaJn
 zLsGsUNPeLsHuuia6yQhJzNGBaPzD6XMEJ5EtceGDglnj5N6pRTUP7wbRt0NfkDCTR8Nc8gMF
 4UErBKcWQutusY//w5IomdG3LhtIddpE3Pk/qCIScBW6ZPxaM0pvP0fw6n42BqDuVBSAX+LdM
 BDt5JYl0SGSfX87LX36QZASXR9yNOU1fWRRsQbBNDnFT4wprcKE4VVG/dV5M+byZwi8nl9mH1
 Pu8MljRyPUYIm3dQfetUbYYd6ScYGh5jfPSCteZEjiTV4DNHGaM8tRSx/XXeqCgBncdgYAWOT
 WKjEuIeFAsFpG4pY6RcjfMNCJW1YSawFnk3ECfpBQOMTqbvMcbQaGSL3c2oSoPofosPMxhAzZ
 NolC/pZiiA9HC/+v9/75q+OPJGD0kcEfBQRofU+5qWiIJBG4wCH0TMB4HEfiDQq9UbbA/PJ9z
 x7lp5f8+21xdks7bnUrRj5ZFhD6/WlwwPGqGcoBK6h+1Es7oVp2jjgO4xlX9Zoj+4iQI3GzY1
 HnU3ssfGZcjq6pc854Fv88uRsjsc9o8P7h5DLiCoBIKVrmNDlISAKM/mzMmUCV67XRO9UmCtN
 1bJwLRZ2g2XNGfW8SA7/wjQs+w7lQlVdKRfaUT7C/JeunnDWkDh7TULWbChoqrV52RvIaJSha
 mSVBGthwm2PZJYh5HG1va8CULZw9tpRxhvlHIn6MOsXtLPde7wpyWXH96LbdDmE1oxHVOHSUu
 9MAiWz5J0RqTwf7uQGe9HcxRVG+j3gmaouBnN0DE4kCoV8Z6WOxuJALN4Hd6w/UA3+eZ6OyZ4
 VSXtfbzYa+wAYQkp1oeq8Piv8qrWDPSmWI7YE1poVUGV0sUrOQmYdNxeVMtCp3TYP3YKr3MEc
 dSQOtsSL44XSXwMQr9LnikdJ6wKi3jcq9JtLRqDF10GcnJbAo6evyfJnVsj1ggsoaaxQudCq/
 yKylERC8jwosUHv9I2WgUbftYdV9w8FTb/RXl1be1EvVvx5tq1L3ep7/w/WKPHfRFFwmvA0vv
 W32hXLlWTl0V/3yz7FoBUbEavyLjZTI8IWzf9tqIITGqI4wLYnxETT25c9/HyePnOY8+/i7Ey
 MIDeVsWIFIA7Av0sN08i4/dIhfrVSTDRLLYEfP5Ijs34rSTnAPRf5gg19w/Ws0UrVzv/eFpgl
 UF2zVD9lfiKHFTtqzN2VwokVmnC+syKlnXxaRtZeIhT86/tmhLgvAc5TSvIAnKrxUx7qgqwBd
 jgGvnRWAoV7hTshqWGSCZYDgb9izS21BVraOjKrHpE0s28eEwj10RCB2wlTucm9JUaYTlRqnq
 b668y01vIwTlkPlUqSMl4ZUs4sapR9ed69kgb8nRCQddb6oJEJpIUGJcjgTbm7AwHF1SyBYxC
 ghwyTwL4mqj8IJ+JW9dr7N/bHnku7Sc+6ROpk+qeh7yV8qxXZUYEXe0SI8U6CQo2djUDoPMm4
 mpg2BuULXcKqz4wzFkj0b4FesIFA/ArB1nl0nVe6wnbrMxptWno47bSmNLGq5jElZ3UD+/srP
 mdjuPpYgJ1BYo5iFywIUYTpQNtg2aL3+HYswy8xJNiq/mWj7iYHvmdiLPABAmov3dP51zFqay
 /jneBL88KA+GtXxswx1KK3aMB0CAxLi85CiGM9skAYglkgNhMJiswCCu2foxjClILSYg+Fs0c
 XKNKWkSKBTM5DVj4Dt/577gAgUmytnsfZDi1hGP22yD8ro2s2R8/IEFI5VYr1xwuykmaInEX3
 wE8q11tOvYOWsegw0OaY42KtpegXNzDiPvctCfq3S74zpucEWzvbZjs87JtEtLr2O56gQY+ab
 IDYFLkTb8tTOIvvse3pPKKrN/tXUQskYnriVMLewR2flSVGAulY8+rdFB/Wax/e9RDyS2vYrJ
 jw1EZ5UiP2MKfyslJHCXjEmDyGOW52+BM1J+s9/fjm+YorGlUGmsnA3gpuQDg5/yQxRde8P4x
 cIv/cKloFi2N05LKJNFjvruAZf9Bqf/vQllhNhUrOk1ISV4PvvVsfczmR8F65nxnyEdRhf2rJ
 gO0zGdD8sP3vFj5RdMItgIjNgTe9YaSYorAygfg5CanHvYr8n915G9rlETQhg8MYlBZ6zZhqn
 UB7TyOxLpQx1M1u2lt/d/nosbHodWY+f5SQYLTM37J4g7iLMkqEOeUFz9X1xUTWlM2tzT1MJg
 nqfpgia1oP02u3ZmL10GnMufJdypI/a2IcQ4gSLO/1g1L9lPmkxbZdAGYI/xKzSILlTOXd+Zl
 zdbMbF0+Yk/z4DqyI91e96Yj0DQgG57ZMKK7x2MUC9QpeUtJtVv0ZJwxEBd2ePUaHjBBw

On 11/17/26 04:17, Xue Haolin wrote:
> The userspace program could pass any values to the driver through
> ioctl() interface. If the driver doesn't check the value of pixclock,
> it may cause divide-by-zero error.
>=20
> sstfb_check_var() calls PICOS2KHZ(var->pixclock) which expands to
> 1000000000UL / var->pixclock. If var->pixclock is zero, this causes
> a divide-by-zero exception.
>=20
> Fix this by checking whether pixclock is zero at the beginning of
> sstfb_check_var(), before it is used as a divisor.
>=20
> This is similar to CVE-2022-3061 in i740fb which was fixed by
> commit 15cf0b82271b ("video: fbdev: i740fb: Error out if
> 'pixclock' equals zero"), and the fix in savagefb by
> commit 04e5eac8f3ab ("fbdev: savage: Error out if pixclock equals zero")=
.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xue Haolin <xuehaolin@uniontech.com>
> ---
> Changes in v2:
> - Fix sign-off to use real name "Xue Haolin" to satisfy DCO.
>=20
>   drivers/video/fbdev/sstfb.c | 3 +++
>   1 file changed, 3 insertions(+)

applied.

Thanks!
Helge

