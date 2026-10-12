Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4E48F835;
	Mon, 12 Oct 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819294; cv=none; b=NH1ccI/dyo/N1vUGofJureBUq6KR6WeZlNVyvT5nAGbHlsTHIkqfDG6tyKvc/FZcyTnSCrDi/BPBKO7DGwnbOMkbtVuuIp834/G/7IVA2uxvo30zrGuOZgcNuh+HxwgZmaawllHcCw8niZ4V2XKIsxoeIWEC/8gjyhK2l+NqR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819294; c=relaxed/simple;
	bh=/CvxO7x3U+n36HzgwXBUyyjfzFi/SWi9ii/2G/6rHPM=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=L6sBq4DHXP5Uw//ypIMI72I24QKKlbLA0b2iPq69TAyJZtaDjCXyKB0bxffh2yoOilGoPMLm4jFKWFUr923alw1T51u4yJCf7DkVAmUvoi7U56V5G6D5ejvV2mSXooy0XUR2qZnd1tBVfej0NUUlDuzH3PCrI0KAPmXSwE6swr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=rsSNXd4z; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="rsSNXd4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1791819284;
	bh=/CvxO7x3U+n36HzgwXBUyyjfzFi/SWi9ii/2G/6rHPM=;
	h=From:In-Reply-To:References:Date:Cc:To:Subject:From;
	b=rsSNXd4zZoBKrpTCan16D67KPc+cdqAtbmFr6X5FoPq3NQOuvQUdyxtnk7jR/Xq7W
	 P6eg08X8FiAbE3DpT32Pgz5kIMKKQurQLGjArZyataB+0WK7PUyWy2vTWXwhkM2xRl
	 OfVtdf7LfXhj71AjGTjqy5GXveRJQxhpi4V4b9ID2i688EGh7doWxd8eNW7GPxpspZ
	 b+4M+YcxulPaxH9IqJtYVDFmsxb1tN2ltfF/l1UOUVpzFxolIpLbz2mBpofLzNRcHO
	 d9hmfAYoAEVlmNCDJ0Gm7TJCyFU+rn1y0D4IEeulbOGQRVRCRMrgYDuS3yPVw1r+bw
	 9NmcJOyYlJmYg==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id C55EF2743B;
	Mon, 12 Oct 2026 18:34:44 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 18:34:44 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j3M1Z3jKVz3rm;
	Mon, 12 Oct 2026 18:33:22 +0300 (MSK)
From: =?utf-8?q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB_=D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= <mdmitrichenko@astralinux.ru>
In-Reply-To: <7e9af4f7528da1307cf62e53cf6b00fa9c4f674f@linux.dev>
Content-Type: text/plain; charset="utf-8"
X-Forward: 10.198.48.43
References: <20261012140642.1076-1-mdmitrichenko@astralinux.ru> <7e9af4f7528da1307cf62e53cf6b00fa9c4f674f@linux.dev>
Date: Mon, 12 Oct 2026 18:33:22 +0300
Cc: stable@vger.kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Sasha Levin" <sashal@kernel.org>, "Fabio Aiuto" <fabioaiuto83@gmail.com>, "Alexandru Hossu" <hossu.alexandru@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>, "Navaneeth K" <knavaneeth786@gmail.com>, "Michael Straube" <straube.linux@gmail.com>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, "Dan Carpenter" <error27@gmail.com>, "Andrei Khomenkov" <khomenkov@mailbox.org>, "Dalvin-Ehinoma Noah Aiguobas" <fliegbert2@gmail.com>, "Michael Huang" <tehsiu.huang@gmail.com>, "Jinke Wu" <coolbeaner@126.com>, "Nikolay Kulikov" <nikolayof23@gmail.com>, "William Hansen-Baird" <william.hansen.baird@gmail.com>, "Serhat Kumral" <serhatkumral1@gmail.com>, "Nazar Kletskii" <nazar.kletskii@gmail.com>, "Jennifer Guo" <guojy.bj@gmail.com>, "Hans de Goede" <hansg@kernel.org>, lvc-project@linuxtesting.org, "stable" <stable@kernel.org>
To: "Luka Gejak" <luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <fa2a1e43-8b9f-2c0c-609c-ca17bd20b7c0@astralinux.ru>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E10]?==?utf-8?q?_staging=3A?=
 =?utf-8?q?_rtl8723bs=3A?= fix OOB read in OnAssocRsp() IE loop
User-Agent: SOGoMail 5.12.9-rp6
Content-Transfer-Encoding: quoted-printable
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {diag_burst_silent}, {Tracking_from_domain_doesnt_match_to}, {Tracking_Sogomail}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206608 [Oct 12 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/12 14:59:00 #28677641
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

On Mon, 12 Oct 2026 at 17:19 MSK, Luka Gejak <luka.gejak@linux.dev> wro=
te:
> It seems to me that this was sent by accident by running git format-p=
atch -1
>
> You probably forgot to commit so git made last commit into a patch fi=
le.
>
> Either way staging rtl8723bs is getting removed in linux 7.4 so any
> further commits for rtl8723bs are discouraged.

Hi Luka,

Thanks for taking a look. This was intentional: it is a backport of
your reviewed fix f9654207e922 for the 5.10.y stable tree (hence the
[PATCH 5.10] prefix). The upstream commit is tagged Cc: stable and is
already in 5.15.y and newer, but 5.10.y is still missing it
(CVE-2026-64444).=20

As far as I understand, the removal in 7.4 affects mainline only; the
driver is still part of 5.10.y, so the fix is still relevant there.

Best regards,
Mikhail

