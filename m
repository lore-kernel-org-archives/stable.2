Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com [34.2.64.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC246E00C
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.64.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961536; cv=none; b=O+BT/0uJgblqNT1pzB3+5kw7g1REgADORfMaKMzTeyjWOjNhQilk6thyk54gg46gbjHhEyJA7z5zo0uUlTJ2EHbqNvDPwFvzBUkZIz2nqkieJVVfXzCUut+QLG+Mb2AfcR0AxJHVKcFCFFwI8IlxD4aq4FODEOuG++lqb2sRTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961536; c=relaxed/simple;
	bh=/qUHNOK9yxopZORFNZ1tJgWsEmGkIZVZ/lrNPuRqIdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOOLwbjPq29CQS7jzFVAwSzbAYjg8I4vXiH6+mPQgSpkGk6p+ErVYtjzz+ZaT1oo0JVozV0rWTnmb/bInRVy7y6+X7T+gysUGHuVFdCIeQiSQILqUv/3SPXpS7C7dWCpw86/y2zk9FX5BXxfU5BMmsF/XlzaofDEhOJWs+uYc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BUFw3I1d; arc=none smtp.client-ip=34.2.64.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BUFw3I1d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790961526; bh=/qUHNOK9yxopZORFNZ1tJgWsEmGkIZVZ/lrNPuRqIdQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=BUFw3I1dT92N6Z1iQHptdOrPPG97ArZruch3DPiUSKPIUHovGTm43vJFq6Pl60QjGj0fLZhroTYNZQonexW/CoOq2I9Te0XPG5HicLqE8UyIdlKBr6wJuLapengoy6y/IMXAJTfWfJ7SdF3Dr6hXfZ0Zu+Q7sssiCwx8hoIxNKSxjGrKjoNogCpJW5W6CK9Q37G14dQ7Le0qbu5J3VUd3J53MCWokNSCd+dBOsUnjfP8bQXz37YGALgoH6WrhlHbKIsknxkoPTI98lKOIQmUTwtjMbNj4/kFoOpWo9AQaDgueU++lbjfAf0854Pmnouc1vtsBhv7TDe3oXXcVhyWKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790961526; bh=k9GtaYYUz5IPt/XND5UbyEfiqKqSJdppZar9gENGkeg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XpzNctzlJr+89I/2Wjeg+ehIzDUDPVOhRy/8YUuj0JE6Ps2uh2qHl9AU+7JIM8ay1cc6ocMSPjkcm4qVmLsvstEYOn4Ma2Io+ZeejieWutb72zQDAg8sWrGn2rWcYLJ60g4RPfbaBeGaeFOXSfuwJKlO1jxXwGiVDPd1Honj7Po/bRbPtfXYxRcq3+k5PgZQAAvbvmSvLBgB/vc2y2PSwusUgtxmcPx8qviZfb8CuhWx6MJOfgpwCzvNzhC3UJ6RnSTmEn0ST0u/NZnxt8rlOAcr1Qu2WsTTKGrbcP47NrKq9m12MMow34ZYeWOACMmwcNtxZ03AixpG8TE7expVBw==
X-YMail-OSG: c6M07hMVM1kOhXWn_S6kgVZqw4qxpUefO7jh3Oy.GVQSI_BkFt7UGrxeAXCpGJR
 h7xgPA6r1A_MQiVevb7xX4Zojo8DDPJirbvPq5gEM3Xzu7R4S__f1ftYkkx4X0w7iqGGBkZM5u7e
 U4yr9I2YF_4yfG74krqviIYDMeoMXxkT6FjnXB7.YNaXznjJmNrCez6MwF98S5yERk6J3WdLuZfs
 n23p27xYBmovl4_q_GyCi_Px8aLg0ZKJ0dyfa6TOwMvkIG7noaLooXFXXMCYSTwow8D4rx5HmXOh
 OD0Y5qpIzTfGF5NJzocXFFL86q8.gJ4EwQ_WHy_LZsxU.1xOCGzilxKK4QGqH5VaSd0qEe29ZA.4
 aUt04u7K0JKzde4XXgWISZksQPqhzqgWMNmw8wngWK04of3r5DjYrgf4uudHM2ciz6iYm1YHnC5e
 ASrfdpIWmodBl.Z7nDa881dT_gmhvvZy3.sE3BlNUnSdRXzoHHtmGVw5iaSHYn7mA7VMni3HRpP1
 Wz7De6G_ZtObnKQXifZLgy4bFFZBjcPB82r0o7IVQ0Ic66EGc8AHUPHX21uN1bgaSC79E88lxykl
 ID0NUQ6auHfCulEoQ9TH7AqC4bqroa01YVx.xYN2Ta_RiqpOqH8PvSp555iwL11KdhSo8I0e5TUk
 uzn0SZfvOgIUjr6QDzrTrEJq.0v6uahlY898CM9shbWd8eLJegzE_JqKOgJm1UsKfTFKRrb1_iv3
 5u5X5X6utj609ETNDV_KX6IzEGVL2YcPuJ4Szw2x_4H7ZcZAnpYdMmh6nvx6mrMSq9SB.1di5cEz
 iKyIVjjtgyCp.U1obFGUAibNBvRYasHa4Q3hAd5eH8EgVT2zWOMwI9jBpZi4tPGyNr53oCp64YTg
 qzcUf63pe1dCADnbKgevJ7QN_rHRSHrbDjeQa8Ho0I7TsPIaUdNdqma58vISusvM_nmsDFbPQSbe
 bcRxm_wsQMXH1wF741jDOQwj3H9rM93xA4f78DkJT37TwqzXiFxEt9aKCAy3h8guufzbJAL.CRkc
 mG21H4G8srXPcmNsoiL0WTxO9UtJKY0zWJkygg7gi_v0vsMha9I1.b44.00ABJJp8PkgUfRWieud
 pfO6FKxD92hShOIUu2y6H41uo0aFEujeS8BnK7sP5QOlNtuDpiCI0r6EqO3w93NVq8YNfi7HhdwA
 .vfZjzvxsIU5SlANaxnz3SY_q8PZTTeQK_79.dRlnQS6MEyUYTH87f.mre5cSSNmvZs9Nh4.QKtU
 AtpPEAwAQI3URzkAn3XZWWpJKDi65pp0afnXJfkIW9nplvx4GMWxDQ7uym0JFHAU7yqY3FUvbFeF
 KH__j_b_sEI5tJYcDfpCIM36f1U1dg1bnfZXJT_1YicQdPIkJBXU5l7LtmmvoKXolqVBw.BuqPbI
 pVX88Y1.damYoKP9VVnxdLubXXZLlqSMR9BEd_DF_URh5UpBlF9xD90H4l_F3s6MYYNWkGw5ubGY
 RQAE7yjgZeKS.Roxo.xtK4LUZraF0xOqMV7QhWLOXZbparjkzvp.hp5HxoYDJ1KeOWOCEN0j1tB4
 C7DXiBz.t0eAWp5Z999hmmT8VxiTyttS52XdMOqBw34ZcHbFn328C8cxkzvMhtB1DQGv50BM7oM4
 ybWGoA0wTNO.iwIRg4qRyeeWYprQ2HO5AUCIrOjUBGPNiriZKLXjqNn8vQC37XI2XyHOW7gnI9hW
 mTySX.xbX5mh5VVkiNmL.zKnId4nbshHXyF9LN3yBy3LIQ5CiaYKB4.SBUriv5dmmYwMgBWKzK0u
 tQVlvKXLrFS2F6PBgKGWfsfSGSwUIhE2A5QE3C8OUB1dDlhjNKFaMbQSLSl5D49TH6lHEf7B.GIK
 NqL1ZBZOij8L7F32bE13MCoRj9VCOU3F6btSe74X97uz.qDrQqq72DAcnkXsqZo7yw35bcjI9Z6B
 KN_GYk6VlgwVsE_s8wbrjTTymL2eLx1F524.NTlyZGsTTL_8yc9L2yW2LfMipsI5rMjdOZ38qLL7
 kZGuy3j53omD.wHDC6hPNK9HjhegaEoH2x1R.
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 44f43abe-1d8f-491e-8721-fef69cea284d
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP; Fri, 2 Oct 2026 17:18:46 +0000
Received: from dip117.lsn.bf1.yahoo.com ([67.195.177.126])
          by hello (SMTP) with SMTP ID f4c847716543b17220b197b5028b5c41;
          Fri, 02 Oct 2026 17:18:43 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH 2/2] drm/nouveau: prevent NULL deref of gr in GETPARAM_GRAPH_UNITS
Date: Fri,  2 Oct 2026 14:18:32 -0300
Message-ID: <20261002171838.282505-1-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zhenhao,

Tested on an RTX 3060 (GA106) under nouveau without
firmware-nvidia-gsp, kernel 7.3-rc1.
Together with Jim Cromie's GET_ZCULL_INFO fix, this removes the second
oops (nvkm_gr_units+0x9) that kills kwin_wayland when NVK starts.
KWin then composites, and NVK refuses the device cleanly.
Details in my reply to Jim's patch.

Tested-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>

Daniel
