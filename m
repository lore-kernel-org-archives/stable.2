Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3A2E7179
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782358312; cv=none; b=E9LBnI8l43tMY9F8NOZ6RShp3wALHT/FaBFlsAC2FHdYx5y7h0EMDT0mxGtjioWKxxphmUx4qqrT9y+igxA5kEfAXkObWcCGPRBWyDdTD02PBhyiti6KWGuwU1X3anRBU1QQ7prUrJSvY07WGCKLEppuunuiTjOQhEy6uIL5OvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782358312; c=relaxed/simple;
	bh=OVsa337kl6HutEKwoFAFR95PYhRLtWEWJVogpvG5w50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/9Ov0bv/hCHg5SuHMahF3TNutI4jLQ1SyUeZ3bcH3aJLe/MveqmDkKMoMlm26H8+Crs3DM8st0voMskhhbcsvaMxZpNBolKTS+rR8DHuOV/DV7ARn/n0bwVGs6sxNqmsf9GfZAKz/hloIF41vdNOf9XLXZB4XRTebNHbuQt7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=cYziI7LR; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="cYziI7LR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=9742; t=1782358263;
	x=1782963063; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Autocrypt:Organization:
	Disposition-Notification-To:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; z=Received:=20by=20auristor.com=20(20
	8.125.0.237)=20(MDaemon=20PRO=20v26.0.3)=20with=20ESMTPSA=20id=2
	0md5001005395154.msg=3B=20=0D=0A=09Wed,=2024=20Jun=202026=2023=3
	A31=3A02=20-0400|Message-ID:=20<4dc5ae26-ef2d-494b-afdd-c723de8b
	d059@auristor.com>|Date:=20Wed,=2024=20Jun=202026=2023=3A31=3A32
	=20-0400|MIME-Version:=201.0|User-Agent:=20Mozilla=20Thunderbird
	|Subject:=20Re=3A=20[PATCH=20net=20v3=2001/11]=20rxrpc=3A=20Fix=
	20ACKALL=20packet=20handling|To:=20David=20Howells=20<dhowells@r
	edhat.com>,=20netdev@vger.kernel.org|Cc:=20Marc=20Dionne=20<marc
	.dionne@auristor.com>,=20Jakub=20Kicinski=20<kuba@kernel.org>,=0
	D=0A=20"David=20S.=20Miller"=20<davem@davemloft.net>,=20Eric=20D
	umazet=20<edumazet@google.com>,=0D=0A=20Paolo=20Abeni=20<pabeni@
	redhat.com>,=20Simon=20Horman=20<horms@kernel.org>,=0D=0A=20linu
	x-afs@lists.infradead.org,=20linux-kernel@vger.kernel.org,=0D=0A
	=20Wyatt=20Feng=20<bronzed_45_vested@icloud.com>,=20Yuan=20Tan=2
	0<yuantan098@gmail.com>,=0D=0A=20Yifan=20Wu=20<yifanwucs@gmail.c
	om>,=20Juefei=20Pu=20<tomapufckgml@gmail.com>,=0D=0A=20Zhengchua
	n=20Liang=20<zcliangcn@gmail.com>,=20Xin=20Liu=20<bird@lzu.edu.c
	n>,=0D=0A=20Ren=20Wei=20<n05ec@lzu.edu.cn>,=20stable@vger.kernel
	.org|References:=20<20260624163819.3017002-1-dhowells@redhat.com
	>=0D=0A=20<20260624163819.3017002-2-dhowells@redhat.com>|Content
	-Language:=20en-US|From:=20Jeffrey=20E=20Altman=20<jaltman@auris
	tor.com>|Autocrypt:=20addr=3Djaltman@auristor.com=3B=20keydata=3
	D=0D=0A=20xsFNBEwLlO0BEACu6yWFkd1+qwsGg8ZzgslSkcAKhSegWt5j86DpaR
	L0W8fxg6YjxwEPvwoH=0D=0A=20BGa/rpSdBd1gkmzeYxD3hVZdj75r6nVS9f/mx
	NQzW+o1sW4vaeSxKgZSQz5RqHmwPDcqQP66=0D=0A=20+ZSnjV+G88MKwZ9DIzA9
	AwpJhNAAlAlj3OvsQVsxd1ipc6C4/U3qjHL7Ih22UbPBM71ltIZx=0D=0A=20kqc
	rAlXPnUTeraJXtfzYbq4mJFJ9JC6/o1NRSjsBvRD+ADxlG50+KccZN4SS5xxdGuh
	1tA9U=0D=0A=20TydYBQB3YtJbq7CYau2kIYt/3HnyLYGo1s6Ti6cuAJJ/40iIE1
	xkqhvMiIz/Q+1ztmksJbLQ=0D=0A=20aCtW8kF42nF8MpPdIPTSPr2uGvpRtCjRb
	h4lgMXgyNUx1wpCEY0X11xce++H8HySmFwryE2y=0D=0A=20kkxUQeMUjaaXZDHY
	USyQz7riChFiZ9ax9dmX0wUY/A05v0qcualglpk4wJ2kcsGKUEGkLvnV=0D=0A=2
	0wwvya8zifPwKOw5JlGPvzX8t2m7jB2GXKzvVAsImqOqnDBTKUXWQQZCW9Rqt7ac
	dE8bQ2vqr=0D=0A=20vP+3Ykf4SrPwcuNCDt6QSgjVbhc3hA3hCtE1iW/HhuBAzK
	iuzJ9era+q9QjTtLPIkQDHRpcC=0D=0A=20MMWvK0Y1uQ34Ql1BfKRA4gc8A7CuV
	UY6+Ga7PuJWd+FSglvmKQARAQABzTZKZWZmcmV5IEFs=0D=0A=20dG1hbiAoQXVy
	aVN0b3IsIEluYy4pIDxqYWx0bWFuQGF1cmlzdG9yLmNvbT7CwXkEEwECACMF=0D=
	0A=20AlY2YwgCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRD3enNVkra
	aBDdzD/0XQUDW=0D=0A=20UWXrpapHdvZaHzPHc3xobRi4PABWfLW1jfMK5Xy4DP
	/x7x3I2qAqTD6vv/OPFMx8gG6+Xeod=0D=0A=20Mj5vE7+7ZRd+J76J4DJH2qoaX
	X8qnUEABUJHZYDhw2/Ij5AQ6ZsuSwXuURGEMi0vu1ihBbP6=0D=0A=203bt4LRIa
	+F60ebDvCl9po+UB7TrjQCs+YV1r1YeCSv9hEHBly/W0u1OrnNCMWRcq7dmTCbZ0
	=0D=0A=20R5w6VJ/+QEio+T6paGGMjJmrNw2qUeuK+SxOOxOWS8lgdqzjcK3Nsfi
	ERrVbOWM83ZVy0/GN=0D=0A=20vpusjhI/3Q8lbV/p+IsJk/v1grkRzgU0frES2A
	NEPTpC4j2ggPOSMpsz3BZ8wIOg17rIWnK+=0D=0A=20gNLQe+XN7kvDwGu0jYhTI
	ZO10jcVsRSrAJGtgBNrYxOjEUhpnaSJDVcjapRvRPCQumA13Zkl=0D=0A=20nm4A
	Yjp7L2oOIeOGcKRZwbrGDakksa5iaSIoywpwECWh2l9V0W3SeynBgPtR4qpt4N8y
	KCcw=0D=0A=20suLCAKfBv9RcL641XZi/Fp9btSuTPUm5Lw3SIGr5U+Syezmhzlw
	sObIF9W624aorriWoXNf3=0D=0A=20GgH9ZH0Hkc6aS99pIZhh5USWRO/pS+lv5e
	NkEdf9LUBGX9b6ZMan0fpoEayqUejtZw3O2rgs=0D=0A=20zA+pTSA+/HobvtL6L
	3XtlPJ1NXlkgM7BTQRMC5TtARAA88hJdpgcg2RU/uAWfAL46XZHA59c=0D=0A=20
	VpPNNly1tPWCSbG6+ONH6nOG/NarmNVxX6Mb9YRkEU6wmrZS85inz3otdyz/zlyN
	SWma8qGN=0D=0A=20UlMbiwFQqfXWVBAPGoRC0a0aJrd4IayLuvv1UqEwx7Otp7y
	5RNHtRv35/kho0Z+UheYVdGm2=0D=0A=20I06xIc+aNKW2LO7R5BNtjpADPIG+NS
	dsVIeamhAWPvLrwbf6mUb//eA9pF0w0QixLVrH/cCo=0D=0A=20z+S27gCGJvY6z
	F22NgdhnkIqNz8E/LKt6S36ZI9Mw/ixpQTozqRmdNzVQNgTHUZClbJj4iq1=0D=0
	A=20EPHB7XqpxOv+awrxSxq2jt8GFD0rU+sAuzW+F7cBoIw434/IrxKYwcPHpHLE
	VQ1tLP7d3ZpZ=0D=0A=20R30p3oqoliGiLsWvHHxyXjuMBF4XJ6MRXmD65/qOhuo
	2DKduHMNlmxzgSzvWgXZeNJq+OcS8=0D=0A=20jQZDt2Na2pMKjWytau7xQu2ndm
	0FwS48ngMrDYRQMxzL1NfnBnT9BCwjiU+/6NBSwcNKIqye=0D=0A=20a9IpTwsVf
	kF4/iui7xD9+LtzqeUkBAe7q5jEJmJMZhAfh7usZGT8TGxXegCaF4Jwz2nxS4Fv=
	0D=0A=207VRza/yUAOJlc0daR11TPeiUNCQWY7PpL1AXO9vaSyjFuOzTnU8vzXvI
	9fGoxIxKGRQpKMU8=0D=0A=20PROIFw0AEQEAAcLBXwQYAQIACQUCTAuU7QIbDAA
	KCRD3enNVkraaBIxXD/4xlaBwW2TLFfMv=0D=0A=20lcY/2XDSm6NO4JaJG2Nzp3
	5xaaBVwMVzWvI+GgTgKNSFot9f4jiLBNQdnq3UKoEThR2ORKVL=0D=0A=200ZJS1
	QYR7yyrOo0MteDSy8ofU1FJ6xu4ND3ekOjP20BTrihDpqUdahir2uaRfMkwM+0im
	Olc=0D=0A=20utGMhJNF/LAjrhoDp9SeDMYBXZ1wfrbrEo/EEu0PbkGyzqPyEPqw
	N1iSJkcAnjuIA0rTf1jQ=0D=0A=20tJAaDov7yHsSRwUM+qTGsjOGQAN3wtYwjPp
	w7hI01sE+x0uq0pVeo4qeWTZ2TE4Vtp8FKXFA=0D=0A=20kqnP878q+kNk9Ve+DR
	s8UlRfa9Lgf5ETjXOTVGaT/UGxi9B4oo8k0lzvM/A1txexL/lLw8AU=0D=0A=20L
	hUeGtyS6D2X9vFi6azna+o918R9BV86uXPiDOf1nMwqKchNCxmgH9vd0aQm8TKCr
	WAW4kU1=0D=0A=20Ig6aMNuZiWloVZfKrmWizbgeGKE9rhNPNqxkqBaA4lrJ8L6b
	dKbhAOe3NQjO2vUAXB53Jphl=0D=0A=20F74GwEsh+85i9/yIbvwJVcsFYhdZz7f
	CAUOcnFkGnyrwIgkizQ3xXShPW8mqkgUk4kYMnucC=0D=0A=204kG/E7pI/4lke5
	X5X9vroXRHB7tkpAgT46SqSM/XTwCaseXG9orDgz3duRTUp6K0++S/qsqT=0D=0A
	=20akGVmjD5917A1HqWfMmiKA=3D=3D|Organization:=20AuriStor,=20Inc.
	|Disposition-Notification-To:=20Jeffrey=20E=20Altman=20<jaltman@
	auristor.com>|In-Reply-To:=20<20260624163819.3017002-2-dhowells@
	redhat.com>|Content-Type:=20text/plain=3B=20charset=3DUTF-8=3B=2
	0format=3Dflowed|Content-Transfer-Encoding:=207bit; bh=lBsoaxBCJ
	HhzOM+AWOoXnwOJChO51HzklwN0V6WOf7Y=; b=cYziI7LRfN23WiN4Kb22/hRLh
	9POCFIP5MOj27eJU9BdVQCJOnANQVQkbmIHAUKcxyUFZDSQaX9pX8CB0fNzyuuYN
	8NuIbJElaaGMktt7AvZ7L5+yutYlH5mcmjFKSEMhKRnNha3eobUaji5VULM0qjd9
	4CpxKQpwqubN6pVEbE=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Wed, 24 Jun 2026 23:31:03 -0400
Received: by auristor.com (208.125.0.237) (MDaemon PRO v26.0.3) with ESMTPSA id md5001005395154.msg; 
	Wed, 24 Jun 2026 23:31:02 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Wed, 24 Jun 2026 23:31:02 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 66.108.136.248
X-MDArrival-Date: Wed, 24 Jun 2026 23:31:02 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=16369f4862=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <4dc5ae26-ef2d-494b-afdd-c723de8bd059@auristor.com>
Date: Wed, 24 Jun 2026 23:31:32 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 01/11] rxrpc: Fix ACKALL packet handling
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yuan Tan <yuantan098@gmail.com>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Zhengchuan Liang <zcliangcn@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, stable@vger.kernel.org
References: <20260624163819.3017002-1-dhowells@redhat.com>
 <20260624163819.3017002-2-dhowells@redhat.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Autocrypt: addr=jaltman@auristor.com; keydata=
 xsFNBEwLlO0BEACu6yWFkd1+qwsGg8ZzgslSkcAKhSegWt5j86DpaRL0W8fxg6YjxwEPvwoH
 BGa/rpSdBd1gkmzeYxD3hVZdj75r6nVS9f/mxNQzW+o1sW4vaeSxKgZSQz5RqHmwPDcqQP66
 +ZSnjV+G88MKwZ9DIzA9AwpJhNAAlAlj3OvsQVsxd1ipc6C4/U3qjHL7Ih22UbPBM71ltIZx
 kqcrAlXPnUTeraJXtfzYbq4mJFJ9JC6/o1NRSjsBvRD+ADxlG50+KccZN4SS5xxdGuh1tA9U
 TydYBQB3YtJbq7CYau2kIYt/3HnyLYGo1s6Ti6cuAJJ/40iIE1xkqhvMiIz/Q+1ztmksJbLQ
 aCtW8kF42nF8MpPdIPTSPr2uGvpRtCjRbh4lgMXgyNUx1wpCEY0X11xce++H8HySmFwryE2y
 kkxUQeMUjaaXZDHYUSyQz7riChFiZ9ax9dmX0wUY/A05v0qcualglpk4wJ2kcsGKUEGkLvnV
 wwvya8zifPwKOw5JlGPvzX8t2m7jB2GXKzvVAsImqOqnDBTKUXWQQZCW9Rqt7acdE8bQ2vqr
 vP+3Ykf4SrPwcuNCDt6QSgjVbhc3hA3hCtE1iW/HhuBAzKiuzJ9era+q9QjTtLPIkQDHRpcC
 MMWvK0Y1uQ34Ql1BfKRA4gc8A7CuVUY6+Ga7PuJWd+FSglvmKQARAQABzTZKZWZmcmV5IEFs
 dG1hbiAoQXVyaVN0b3IsIEluYy4pIDxqYWx0bWFuQGF1cmlzdG9yLmNvbT7CwXkEEwECACMF
 AlY2YwgCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRD3enNVkraaBDdzD/0XQUDW
 UWXrpapHdvZaHzPHc3xobRi4PABWfLW1jfMK5Xy4DP/x7x3I2qAqTD6vv/OPFMx8gG6+Xeod
 Mj5vE7+7ZRd+J76J4DJH2qoaXX8qnUEABUJHZYDhw2/Ij5AQ6ZsuSwXuURGEMi0vu1ihBbP6
 3bt4LRIa+F60ebDvCl9po+UB7TrjQCs+YV1r1YeCSv9hEHBly/W0u1OrnNCMWRcq7dmTCbZ0
 R5w6VJ/+QEio+T6paGGMjJmrNw2qUeuK+SxOOxOWS8lgdqzjcK3NsfiERrVbOWM83ZVy0/GN
 vpusjhI/3Q8lbV/p+IsJk/v1grkRzgU0frES2ANEPTpC4j2ggPOSMpsz3BZ8wIOg17rIWnK+
 gNLQe+XN7kvDwGu0jYhTIZO10jcVsRSrAJGtgBNrYxOjEUhpnaSJDVcjapRvRPCQumA13Zkl
 nm4AYjp7L2oOIeOGcKRZwbrGDakksa5iaSIoywpwECWh2l9V0W3SeynBgPtR4qpt4N8yKCcw
 suLCAKfBv9RcL641XZi/Fp9btSuTPUm5Lw3SIGr5U+SyezmhzlwsObIF9W624aorriWoXNf3
 GgH9ZH0Hkc6aS99pIZhh5USWRO/pS+lv5eNkEdf9LUBGX9b6ZMan0fpoEayqUejtZw3O2rgs
 zA+pTSA+/HobvtL6L3XtlPJ1NXlkgM7BTQRMC5TtARAA88hJdpgcg2RU/uAWfAL46XZHA59c
 VpPNNly1tPWCSbG6+ONH6nOG/NarmNVxX6Mb9YRkEU6wmrZS85inz3otdyz/zlyNSWma8qGN
 UlMbiwFQqfXWVBAPGoRC0a0aJrd4IayLuvv1UqEwx7Otp7y5RNHtRv35/kho0Z+UheYVdGm2
 I06xIc+aNKW2LO7R5BNtjpADPIG+NSdsVIeamhAWPvLrwbf6mUb//eA9pF0w0QixLVrH/cCo
 z+S27gCGJvY6zF22NgdhnkIqNz8E/LKt6S36ZI9Mw/ixpQTozqRmdNzVQNgTHUZClbJj4iq1
 EPHB7XqpxOv+awrxSxq2jt8GFD0rU+sAuzW+F7cBoIw434/IrxKYwcPHpHLEVQ1tLP7d3ZpZ
 R30p3oqoliGiLsWvHHxyXjuMBF4XJ6MRXmD65/qOhuo2DKduHMNlmxzgSzvWgXZeNJq+OcS8
 jQZDt2Na2pMKjWytau7xQu2ndm0FwS48ngMrDYRQMxzL1NfnBnT9BCwjiU+/6NBSwcNKIqye
 a9IpTwsVfkF4/iui7xD9+LtzqeUkBAe7q5jEJmJMZhAfh7usZGT8TGxXegCaF4Jwz2nxS4Fv
 7VRza/yUAOJlc0daR11TPeiUNCQWY7PpL1AXO9vaSyjFuOzTnU8vzXvI9fGoxIxKGRQpKMU8
 PROIFw0AEQEAAcLBXwQYAQIACQUCTAuU7QIbDAAKCRD3enNVkraaBIxXD/4xlaBwW2TLFfMv
 lcY/2XDSm6NO4JaJG2Nzp35xaaBVwMVzWvI+GgTgKNSFot9f4jiLBNQdnq3UKoEThR2ORKVL
 0ZJS1QYR7yyrOo0MteDSy8ofU1FJ6xu4ND3ekOjP20BTrihDpqUdahir2uaRfMkwM+0imOlc
 utGMhJNF/LAjrhoDp9SeDMYBXZ1wfrbrEo/EEu0PbkGyzqPyEPqwN1iSJkcAnjuIA0rTf1jQ
 tJAaDov7yHsSRwUM+qTGsjOGQAN3wtYwjPpw7hI01sE+x0uq0pVeo4qeWTZ2TE4Vtp8FKXFA
 kqnP878q+kNk9Ve+DRs8UlRfa9Lgf5ETjXOTVGaT/UGxi9B4oo8k0lzvM/A1txexL/lLw8AU
 LhUeGtyS6D2X9vFi6azna+o918R9BV86uXPiDOf1nMwqKchNCxmgH9vd0aQm8TKCrWAW4kU1
 Ig6aMNuZiWloVZfKrmWizbgeGKE9rhNPNqxkqBaA4lrJ8L6bdKbhAOe3NQjO2vUAXB53Jphl
 F74GwEsh+85i9/yIbvwJVcsFYhdZz7fCAUOcnFkGnyrwIgkizQ3xXShPW8mqkgUk4kYMnucC
 4kG/E7pI/4lke5X5X9vroXRHB7tkpAgT46SqSM/XTwCaseXG9orDgz3duRTUp6K0++S/qsqT
 akGVmjD5917A1HqWfMmiKA==
Organization: AuriStor, Inc.
In-Reply-To: <20260624163819.3017002-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDCFSigsAdded: auristor.com

On 6/24/2026 12:38 PM, David Howells wrote:

> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> rxrpc_input_ackall() accepts ACKALL packets without checking whether the
> call is in a state that can legitimately have outstanding transmit buffers.
> A forged ACKALL can therefore reach a new service call in
> RXRPC_CALL_SERVER_RECV_REQUEST before any reply packets have been queued.
>
> In that state call->tx_top is zero and call->tx_queue is NULL, so
> rxrpc_rotate_tx_window() dereferences a NULL txqueue and triggers a
> null-pointer dereference.
>
> Fix the handling of ACKALL packets by the following means:
>
>   (1) Add two new call states: RXRPC_CALL_CLIENT_PRE_SEND which indicates
>       that the client call is connected, but nothing has been transmitted as
>       yet; and RXRPC_CALL_CLIENT_AWAIT_ACK, which indicates that everything
>       has been transmitted at least once, but we're now waiting for the
>       stuff remaining in the Tx buffer to be ACK'd (retransmissions may
>       still happen).
>
>       The RXRPC_CALL_CLIENT_PRE_SEND state is set when the call is assigned
>       a channel and transitions to RXRPC_CALL_CLIENT_SEND_REQUEST when the
>       first packet is transmitted.
>
>       RXRPC_CALL_CLIENT_AWAIT_REPLY is then narrowed in scope to indicate
>       that all Tx packets have been ACK'd and we're now waiting for the
>       reply to be received.
>
>   (2) As per Wyatt Feng's original patch[1], the ACKALL handler then checks
>       that the call state is one in which there might be stuff in the Tx
>       buffer to ACK, but now this includes AWAIT_ACK rather than
>       AWAIT_REPLY.  ACKALL packets are ignored if received in the wrong
>       state.
>
>       Note that unlike Wyatt Feng's patch, it's no longer necessary to check
>       to see if the Tx buffer exists as this the state set now covers this.
>
>   (3) Make the ACKALL handler use call->tx_transmitted rather than
>       call->tx_top as the former is explicitly the highest packet seq number
>       transmitted, whereas the latter has a looser definition.
>
> Thanks to Jeffrey Altman for a description of the history of the ACKALL
> packet[1].

The Link reference should be [2] instead of [1].

> Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Ren Wei <n05ec@lzu.edu.cn>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20260616155749.2125907-2-dhowells@redhat.com/ [1]
> Link: https://lore.kernel.org/r/c0fd4fec-1576-4070-b31e-a37d5506f5ed@auristor.com/ [2]
> ---
>   net/rxrpc/ar-internal.h |  2 ++
>   net/rxrpc/call_event.c  |  5 ++++-
>   net/rxrpc/call_object.c |  2 ++
>   net/rxrpc/conn_client.c |  2 +-
>   net/rxrpc/input.c       | 23 +++++++++++++++++++----
>   net/rxrpc/sendmsg.c     |  3 ++-
>   6 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index 98f2165159d7..b6ccd8a8199b 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -650,7 +650,9 @@ enum rxrpc_call_event {
>   enum rxrpc_call_state {
>   	RXRPC_CALL_UNINITIALISED,
>   	RXRPC_CALL_CLIENT_AWAIT_CONN,	/* - client waiting for connection to become available */
> +	RXRPC_CALL_CLIENT_PRE_SEND,	/* - client is connected, but hasn't sent anything yet */
>   	RXRPC_CALL_CLIENT_SEND_REQUEST,	/* - client sending request phase */
> +	RXRPC_CALL_CLIENT_AWAIT_ACK,	/* - client awaiting ACKs of request */
>   	RXRPC_CALL_CLIENT_AWAIT_REPLY,	/* - client awaiting reply */
>   	RXRPC_CALL_CLIENT_RECV_REPLY,	/* - client receiving reply phase */
>   	RXRPC_CALL_SERVER_PREALLOC,	/* - service preallocation */
> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index fec59d9338b9..21be9c86d7a7 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -178,7 +178,7 @@ static void rxrpc_close_tx_phase(struct rxrpc_call *call)
>   
>   	switch (__rxrpc_call_state(call)) {
>   	case RXRPC_CALL_CLIENT_SEND_REQUEST:
> -		rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_AWAIT_REPLY);
> +		rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_AWAIT_ACK);
>   		break;
>   	case RXRPC_CALL_SERVER_SEND_REPLY:
>   		rxrpc_set_call_state(call, RXRPC_CALL_SERVER_AWAIT_ACK);
> @@ -244,6 +244,8 @@ static void rxrpc_transmit_fresh_data(struct rxrpc_call *call, unsigned int limi
>   				break;
>   		} while (req.n < limit && before(seq, send_top));
>   
> +		if (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_PRE_SEND)
> +			rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_SEND_REQUEST);
>   		if (txb->flags & RXRPC_LAST_PACKET) {
>   			rxrpc_close_tx_phase(call);
>   			tq = NULL;
> @@ -267,6 +269,7 @@ void rxrpc_transmit_some_data(struct rxrpc_call *call, unsigned int limit,
>   		fallthrough;
>   
>   	case RXRPC_CALL_SERVER_SEND_REPLY:
> +	case RXRPC_CALL_CLIENT_PRE_SEND:
>   	case RXRPC_CALL_CLIENT_SEND_REQUEST:
>   		if (!rxrpc_tx_window_space(call))
>   			return;
> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
> index fcb9d38bb521..817ed9acb91e 100644
> --- a/net/rxrpc/call_object.c
> +++ b/net/rxrpc/call_object.c
> @@ -18,7 +18,9 @@
>   const char *const rxrpc_call_states[NR__RXRPC_CALL_STATES] = {
>   	[RXRPC_CALL_UNINITIALISED]		= "Uninit  ",
>   	[RXRPC_CALL_CLIENT_AWAIT_CONN]		= "ClWtConn",
> +	[RXRPC_CALL_CLIENT_PRE_SEND]		= "ClPreSnd",
>   	[RXRPC_CALL_CLIENT_SEND_REQUEST]	= "ClSndReq",
> +	[RXRPC_CALL_CLIENT_AWAIT_ACK]		= "ClAwtAck",
>   	[RXRPC_CALL_CLIENT_AWAIT_REPLY]		= "ClAwtRpl",
>   	[RXRPC_CALL_CLIENT_RECV_REPLY]		= "ClRcvRpl",
>   	[RXRPC_CALL_SERVER_PREALLOC]		= "SvPrealc",
> diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
> index 9b757798dedd..48519f0de185 100644
> --- a/net/rxrpc/conn_client.c
> +++ b/net/rxrpc/conn_client.c
> @@ -449,7 +449,7 @@ static void rxrpc_activate_one_channel(struct rxrpc_connection *conn,
>   	trace_rxrpc_connect_call(call);
>   	call->tx_last_sent = ktime_get_real();
>   	rxrpc_start_call_timer(call);
> -	rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_SEND_REQUEST);
> +	rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_PRE_SEND);
>   	wake_up(&call->waitq);
>   }
>   
> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index ce761466b02d..2eedab1b0919 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c
> @@ -181,7 +181,8 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call)
>   	if (call->cong_ca_state != RXRPC_CA_SLOW_START &&
>   	    call->cong_ca_state != RXRPC_CA_CONGEST_AVOIDANCE)
>   		return;
> -	if (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_REPLY)
> +	if (__rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_ACK ||
> +	    __rxrpc_call_state(call) == RXRPC_CALL_CLIENT_AWAIT_REPLY)
>   		return;
>   
>   	rtt = ns_to_ktime(call->srtt_us * (NSEC_PER_USEC / 8));
> @@ -356,6 +357,7 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
>   
>   	switch (__rxrpc_call_state(call)) {
>   	case RXRPC_CALL_CLIENT_SEND_REQUEST:
> +	case RXRPC_CALL_CLIENT_AWAIT_ACK:
>   	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
>   		if (reply_begun) {
>   			rxrpc_set_call_state(call, RXRPC_CALL_CLIENT_RECV_REPLY);
> @@ -694,6 +696,7 @@ static void rxrpc_input_data(struct rxrpc_call *call, struct sk_buff *skb)
>   
>   	switch (__rxrpc_call_state(call)) {
>   	case RXRPC_CALL_CLIENT_SEND_REQUEST:
> +	case RXRPC_CALL_CLIENT_AWAIT_ACK:
>   	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
>   		/* Received data implicitly ACKs all of the request
>   		 * packets we sent when we're acting as a client.
> @@ -1154,10 +1157,12 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
>   	if (hard_ack + 1 == 0)
>   		return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_zero);
>   
> -	/* Ignore ACKs unless we are or have just been transmitting. */
> +	/* Ignore ACKs unless we are transmitting or are waiting for
> +	 * acknowledgement of the packets we've just been transmitting.
> +	 */
>   	switch (__rxrpc_call_state(call)) {
>   	case RXRPC_CALL_CLIENT_SEND_REQUEST:
> -	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
> +	case RXRPC_CALL_CLIENT_AWAIT_ACK:
>   	case RXRPC_CALL_SERVER_SEND_REPLY:
>   	case RXRPC_CALL_SERVER_AWAIT_ACK:
>   		break;
> @@ -1215,7 +1220,17 @@ static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
>   {
>   	struct rxrpc_ack_summary summary = { 0 };
>   
> -	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
> +	switch (__rxrpc_call_state(call)) {
> +	case RXRPC_CALL_CLIENT_SEND_REQUEST:
> +	case RXRPC_CALL_CLIENT_AWAIT_ACK:
> +	case RXRPC_CALL_SERVER_SEND_REPLY:
> +	case RXRPC_CALL_SERVER_AWAIT_ACK:
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	if (rxrpc_rotate_tx_window(call, call->tx_transmitted, &summary))
>   		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
>   }
>   
> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index c35de4fd75e3..ed2c9a51005a 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -366,7 +366,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>   	if (state >= RXRPC_CALL_COMPLETE)
>   		goto maybe_error;
>   	ret = -EPROTO;
> -	if (state != RXRPC_CALL_CLIENT_SEND_REQUEST &&
> +	if (state != RXRPC_CALL_CLIENT_PRE_SEND &&
> +	    state != RXRPC_CALL_CLIENT_SEND_REQUEST &&
>   	    state != RXRPC_CALL_SERVER_ACK_REQUEST &&
>   	    state != RXRPC_CALL_SERVER_SEND_REPLY) {
>   		/* Request phase complete for this client call */
>
Thanks for the update patch.

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>



