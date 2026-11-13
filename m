Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555174;
	b=EbMyoxZ1IFSFqH2n4SgbdrQZBYqfj7eE2khHv0nJBeeWUlg/r2zeT7DZZMaHy2zAvCGg
	 YQsT6XI+sABH9DqO/NP/S0y7rSt+gdM37ghA1eFVJDs8GwpIzzNrlUXdYwY7aOzFEnWb+
	 b9jVG4mKognHbgXAw/jc+KPsEzUtzrJ73XaxVlLjcqGktpmcFOquQeRB0gm1v2Clb2W4K
	 ZX2+GDJA6pq3Uct+tCVDaMsq9uZNZoGsgIOAWHg6XDtz9id1Sm4EVDshf4yfnHbUC2X4n
	 TI1wNmaBEfNwjOpcFw4bCyhxifsaagz7OwS+pzIs81wBCR2B6Y+bo7MU40Xob/ckNRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jqp8TYr/BxJeYtd0GqFzJoVixzfcdiw2tIdD5ztXl7A=;
	b=CtYSFBI4am2QKnasc8XmkzSzBLTOJqKSW3kWUObm1i+oL7fBWTPv2rq8fL3vyxl1o1Vl
	 KfCnvpAMbp8yKd9I85FWxIeBMtxwlosS4flD0Vvb//+OlDXxGNkYpSAbFhyeT2mgj5YYH
	 Q4nMagM9+upClK3C9+znooLrliJ36iB9Sa7Bix9UeiBo1jnQKIjNKHGuzCZOb0PQh/Lbq
	 wuEizEiZOxERyHXK+Mpkd0OP2OltPH/LjgNVFm4w/hKWuHFqAMiLoakKgOhIXRzLidW0Z
	 90oWMVH4PYzRJNP8Zib9RMsJ4+KaLVjWt6FUvtuooxXqyGKVIJ21ZYPYlBl5cxDWA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW6XVipS;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFE606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CAFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW6XVipS
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4919a880834so246366f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794555172; x=1795159972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jqp8TYr/BxJeYtd0GqFzJoVixzfcdiw2tIdD5ztXl7A=;
        b=jW6XVipSXdMdRTxsiijSiJOltYY8enXMvCw0kLuEMKivD0O8Eam/rZsLu0qkRJmhMg
         0gm77RI+ElgZgUSELzgGh6YYiZ3ekKa2Iuz3V9mzgQLTdzQ1er3kL+6npgfNMjUA3EOg
         q7joZ8ii/JliPk8lGo3/CjkyjggwOpCH4MX048SSOnyj86C1TSRdGoOrVD4Tlp4TnR0C
         nk7RjKDlnoCNZ8RN6LQKArv/horCrm2ZUhYVx8bFJKBCXmPCN1Ww1MgVtmpE+P7Q1q4Q
         Rl+9xxVIEV5+xtc/WqOERzJsW1vxDTEHKmBw8t9dSspbCvVQHudFSzvWptu2E6uzTvLN
         gxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555172; x=1795159972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jqp8TYr/BxJeYtd0GqFzJoVixzfcdiw2tIdD5ztXl7A=;
        b=ZlfBkiNPpI+E83bNVMsm1nsNXIsXgFIZtRM3scH/LQlEBhfCrbI/ldmR367PXqbw0D
         62WDpZtVPJAjnu4mmcLb4RuIVD017VtVdFfOqkw70cSSQ9arJQUJuY7FMXm55N9g844/
         tH9Nvq0MZiL8G+jd9N9gXz74mt0C4bdA0s+7Ta9VvQt3unB+evSspnvGmzmFlhN8gBaM
         XmWUQ+GaGqtsvzO9NuagAzAe4A5rU+oPgU5aupbPag8hkGPrHlUnd5bU/ADxSAxu72YA
         k59fDRX5nkC8P/QJB9ce0DrNjdcdrpxa1m+K1gcrXRtRBLvVFIvlpSW5MWJdXIWBv+CJ
         9Y8Q==
X-Forwarded-Encrypted: i=1; AL+hErEA4Jf8UxNQBm8CucDKlcBbUzB2c5cAfSRLML2MTkcA+gGoMkasPxfesb2gfXKJDAlr0a87PM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CWVccT3tUq8wF5WjITNV5aYwefA+QpFfTcgx0lBxiVjZ2fQDc
	XqQVKo/xL0eO6V44PMsBVHtGt3Hg8AOPvrkGxZb2GMj9uLSBaEFX7Ggy
X-Gm-Gg: AYBFou2rRZlx6UiuhkkfYHuqgB4h8E3Sj4QKxTuGbiDGQoR5pdQZeawR7kBwcT/Qguz
	vDk65mfdlLl2VXqYuB3f2uki/z6tgdAa8gnz0K30IYj/1msN21rUI0VuYQWGnuGiUBdQ8PM35U6
	q4NJKo4AmDHBKmGJBC1NzxBDSBMQu73ANWcqQ7nly7EuEVjNIKWOSBiaV8GPF2YdK0vFIZevo94
	L2knOdJXpVDefer8m98MBy3zfr0mIGidx4gav2qgrV5AFHizlkuWYtiTU13iehczlt0qetj8r9P
	SZYKukwy7R6BnfeCm3WWlLTqSpqHad02KNz6/+WyzT+5Wl11SQ01ZpPRWUW/lCb5udV72f73KyZ
	RAmnEPrA3Yb7nc8YX/bUJJ07dFg7b4Co8DKyjHAffJ/yu5P3PtDyCO1PE1wovNc97cQuwUHvuPC
	Rb7u/II/7kmo3Zni8+efUvJRVmtCln0nAumKlTYt/QFtvXToBR0y6ZUbbxcZ31cNMug0vIMHXQU
	JvC2+hIqTpSgB2WBfDGili1qnD+CUg96nadpM19TzHJltTtn9c89Oa8sv65N1j7b9s59oAWPwrQ
	EbYD6tKPIdTuXWWIoW98zG4cV898N+NKIhg=
X-Received: by 2002:a05:6000:240b:b0:490:39ba:4359 with SMTP id ffacd0b85a97d-49c714a2db3mr3596058f8f.23.1794555172357;
        Thu, 12 Nov 2026 23:32:52 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223a29sm3799903f8f.8.2026.11.12.23.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:32:51 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] i2c: imx: two fixes for a DMA write that is not acknowledged
Date: Fri, 13 Nov 2026 08:32:48 +0100
Message-ID: <20261113073250.1037215-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

A write of DMA_THRESHOLD bytes or more to an address that does not
answer leaves the interrupt status behind, so that the next DMA read
returns 0xff for every byte without an error (patch 1), and it blocks
for DMA_TIMEOUT before it fails with -ETIMEDOUT instead of -ENXIO
(patch 2). Patch 2 needs patch 1.

Tested on a Colibri VF50 (i2c0 at 100 kHz, DMA) with v6.12.117, where
the touched code is the same; on this base compile tested only (W=1,
sparse). 200 rounds of failed write, 32 byte read and acknowledged
18 byte write: 200 times ENXIO at once, no wrong read, every write
acknowledged.

Mehmet Fide (2):
  i2c: imx: do not carry the interrupt status over to the next transfer
  i2c: imx: return -ENXIO at once when a DMA write is not acknowledged

 drivers/i2c/busses/i2c-imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
-- 
2.56.0

