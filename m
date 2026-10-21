Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.2.68.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588707;
	b=5mj1VhRAjIWS/pDhzgGPznq+v/6//3D5M+2st8e8zNG16CJ3bl40sAGwsJfpWbNfYrFl
	 ImO/aQI0gMLWU72rkxl9Whzx3DfiyXe0Cjj/iO99W14iuly//rvMa1Gla7StrIpv6aw+J
	 qdUKKGegRpQjNKHcFqU0AkI6/1DB8DClWCUnBKaOdij0Hcej5W9/4zl+ljgYjcL2lxZwt
	 GpJbtPAwp1ggvr3clmEuPZM7tnEq6KMiXzowoGOgC3ZZrc33OUObC4khEpRikJAffeuJc
	 V3JpHnNI9/Xgvuycb4J3XkEyh4oDGRjK9+LwMx+kI4/AM0+EMb/3cogHC/Igrtu+IGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588707;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HL04sKob+O0U5DYNdA6mQiNeyT9pEAlXbAGZfleg6eE=;
	b=uqpmqZ3n6BQfB5V3/fUxSRsXFjI3tRAHINIqmV38VLlGZYmAuPDOnkagiP6fxQ47DNvS
	 AJJ2QTOy/25TzYWFF6hrxNzqKJXqtqaR9QX3MAtU3JW+P5xtCY7iFIs3yNnq5jjYRo9Vq
	 PRa0scCqyizrf06ypJbkKatEbS3DUQvElyLPYwwY4lZ0FKN8wHy67ZPGLgA8FE2VCchrO
	 +ZfQRw32US9pZOTC38vU+35x3eKmVBlMQrKxteoqfBhKpbKyvipVETDsfahPTILu4KYry
	 TpecnkVvybB63mCHnl0GR6GKB/JkOU1MNFILIyK37VdZEBCkNPbVskVApYArAAscTzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=WPiUH8rF;
	arc=none smtp.remote-ip=34.2.68.31
Received: from sonic.asd.mail.yahoo.com (sonic-usea4-0032.asd.mail.yahoo.com [34.2.68.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C92606A324
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C92606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=WPiUH8rF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792588705; bh=HL04sKob+O0U5DYNdA6mQiNeyT9pEAlXbAGZfleg6eE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WPiUH8rFQVz+qO5QApXhKxxYaGZI/aENP5vbd6ECaPQIjlkJVQPuvQobtgY9vQfH808CF1+rD6Xm642sso7Jhm0Ug8ZbovgKAe8cm6SS1DUHGt1DwNlcV9eW4085yxTWPci106u/3kA6u89bQqEP867+E2xDUt+3z8FM3t8syZR/UZxFhVaz4++OZbEl1+QagQcFUtgP0MIn+nJs+TqvvbTnT3Zd6andDl2cNYf/pTuFpOrj9WHqFC3Hsblj5yQ/hEKknnN08JmONVT1umDNncPLqBGiqq5J9tBzuhWdM+ZqpYLSetWpymvnZaMblFuNePLaiVo+AxmEmlxAqmzQxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792588705; bh=RXNCxdca7U2Huj2Qoh2Pb5aln5/0KAcDkOtYJcZjvE4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mprhhYUL6wAAuDN4Uy9eh/HWOshV15Rg+tXU9KaiPuD69UL2sUBUKLZItUWfcBk7L11Pn+tWnw1+XDBHpnoXft8g2qqPJedDqSG8KJ/47M7T4EzIMhLoAwKBXq7axPtkZHU38yO5Px0wwy7FrDWcUhhkToHwX5On+DVjSSaNv8JiX3NH3S1IC70vw9AaMuk7iRdE1MFL6p3p38vpnLp04IR4+4VYL01eWGpsSjvlKgdb0Wki4qbt6oqqkZL4YTPbdA9Zy/htZkgi5Ta+M6UbEXu1iOacay7ekwRPVizJASGF+Yy6ACcVEoWG7JsqiAUQtXi1HOSV6wnnBxfqCTLJvQ==
X-YMail-OSG: Yn3Ai5EVM1kKK6JXDj.4Cu6S8hG0lFCwCL5pbBMlpnZv3Fl3vESF5.HUK8Zna3f
 1QtKQFer1xf0g1wxEH2rQKCd8VI4aTidWBKVgG47mU.8Sa0RqacnYoew9u7z1uKdYGVDy5QTsmXo
 eFEPioO1liTROlam0ozvvmOuR8i2.4SbHMBwEmaCogsV7h1r3puFUGETY2vXMCZRks6q.uXgRmPk
 KSxaEzvIAdjnLXrVokSEtuMtzV60EKEX.jcq2xP0dGQCfNiyzbVA5YtmOFWpW6XMCT7voVG4wiA5
 WF2mZO4P1E0Jecdr9HQjOTfeleI5T5UyZj4v9zgHhIdpEc8RaxUsKPL7vb6RR3uWiO43fW4vFFLr
 nFYIC9nHmmDI.FqjwcZgPmMT1NtF2ljwUBCmNDmnXx9znyzfLKSzrUZUViEXxR5iU9WaFXH14noh
 _TjL37OO2GCKzvNIGbmcZDrmeJeRLHHzMqxK.HXaF5T6vLjHJcPvVZY4VZj2KS.dthfnIZ44sYHv
 DFAKwunXxmy3Q575kEV0AY_BBsYgE6J4aPIlRAjCjziUF.iVEbE_V731QeiTMKjVwvHKZh2GksW8
 1QeEaOwdbVkQ8Jc7IBxNa0J0zD.7tBT.xTOUnr3UMycr5F_QFVugz1tLBA04LsIVeHe9ZFSWrRyc
 MWfWG23xV5sKQuXvJHqT6811LjghQ69018cmb5mdY5fJr8YDOGt98cHy1tYsLaoqDS53Wf1ePahg
 l2Zrh.lwQ33n8KU7oGhtQnJi522C4HzUi_Umch7Qn4TfqTk5oGt6G4TtdM_YKQOcLjkuvnnZRM.a
 pSbO9PlYi.pNUveHwNijNiX9GNX3Mskqjc1zbgQ8lKZVhMIrDSDvkE0nvCHadlmovl13ZSV9DusQ
 4lOvyk6QDrFhM.4lPxEhc2YaOauB.L0J.hiYhcK57t8X.WN5VHUliFWwGibefBiVmfevZNsBJZPt
 zXPzGQnO9HD1nu_EcCOnPNunKzC.09VmR8wgnWcAfn3f0jdiXihQF7KzLYUGPXVHe0MT_fZbNl1E
 7dFpE.7pcDI5Gv7Ba7amlV0oxzvtOroYaN59qvDM.na7VqNTBsL5KGHQ3KIn2_Fof3eLA1rzIUmy
 fnFwbBHh_LxvG5KUmwzwaFMuCIRaUk1Z_AtZztBdFPDGQFLSClaXB05WIAySrQKPcpK.mj8ABwX0
 Jnj_vXqqpKCjA1evuz0LhnZ3MsVny_oqMI4OOwxUMo.fTeeLxHYv1io0Gq4Kbk7sLfp1Q0Fk_hYQ
 8Bv_.0TK3BoeNESz.6VJemPle1rHAMpeyRc1loclyr6N60fY6iYFie_KRGMBky4V8Kg8OEtxjBoT
 mBAsfEHduUoqhYQQMF5qTqrtIDCiWTrpkf_TTwXEFeODPyHxGbvT8OSo.pDmAY9rXTA8anDKPp8W
 JLR6_TTAqUpVJtiLq8k5.Tg0nf51.D1F1_jYe5It92PA0v5O16tro__E6q.nnZnhnkMwioyMlNGQ
 GmOXvkOvotxuE20y7FiCRESKXPnEIDndvdz_2FjX9oB2Bu8ya2hxTvGrHI3iDt_vz1DHe8gMdX7n
 43cugQqFczAX.x9ni.FumYbKdLbdxITP.rPXwEBu8LRWEGf3b7WpTW3TiRcdgk9p.X_2vIqxDBYq
 P7BjorqmegV9CdNJ3POJK52UCdhCrUzlDHt9VjV.EcWcDnZw_UQpo8GHhz6C6hDB1FBTqwWS3HMT
 l2jc7btsdJ2N5yUj9ExTwrrXTd3TU7aLpXqWeEv7g71qUzTahFe1nljKkrdF.ItN6hnCTZwre2UH
 FDesNpxlreoI0d4ZtB_8jG7LsdaAYkIJiZgcqBzPGXm.YjJ_mzhsxAqZZGPKUHjHkLXcijQrqA.b
 v.9j1_L4w0RHMC0KwiBydeK1jHBI2EfRIojo2M2d0tCF__2OchYiQkxL.6RxEeupCzxkzHDqgPKJ
 K1pT32jmgOJi10w0b13hnPtwetI4oRQgO6X45qpgOlnuconhlDFgIboJs7WHqu7Laihmn_VgnAVK
 C7eZqguUw80Om6emyIKyQjZNp7qg-
X-Sonic-MF: <stealth3m@yahoo.com>
X-Sonic-ID: 962d4f37-e467-495f-a598-a7c0f3dcdb85
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-usea4-prod-sonicconsumer-svc-101 with HTTP; Wed, 21 Oct 2026 13:18:25 +0000
Received: from dip98.lsn.bf1.yahoo.com ([67.195.177.107])
          by hello (SMTP) with SMTP ID 833d5895af9f72b81101e7f0cd9b0417;
          Wed, 21 Oct 2026 13:18:23 +0000 (UTC)
From: Ext745 <stealth3m@yahoo.com>
To: linux-media@vger.kernel.org
Cc: isely@pobox.com,
	mchehab@kernel.org,
	hverkuil@kernel.org,
	ribalda@chromium.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: pvrusb2: fix control enumeration with V4L2_CTRL_FLAG_NEXT_COMPOUND
Date: Wed, 21 Oct 2026 09:18:03 -0400
Message-ID: <20261021131803.1921566-1-stealth3m@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021120819.1870511-1-stealth3m@yahoo.com>
References: <20261021120819.1870511-1-stealth3m@yahoo.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an accidental duplicate of the same patch, sent two minutes
earlier:

https://lore.kernel.org/linux-media/20261021120629.1869411-1-stealth3m@yahoo.com/

The two are identical. Please ignore this copy, sorry for the noise.
