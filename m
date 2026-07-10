Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073A3FBEAC
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677257; cv=none; b=Eu4ReK3QMWA716PnytkQhPf/G+s8RPXTzvqC/q3fYK1Z0eyoAvbm55tt6WDgrCURibHaGNmcVkPtBj2aYpynSVyJ9m/PlcTimzNjKewqFIaZNG2DUdCrtbyxVJiQehdCC1EiuXjOcO61ZoAOkA1Jka2hUB6k6gkKcmUbV58L5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677257; c=relaxed/simple;
	bh=v8P2Uf45mI/biqxnOxHWfgXQmu+JaXEwT05r7bGVu80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fgUDfuJhDRIddjYTQCQ46yhWkk6E4M+B5QRLsyEEuup4cOk7SppwpXoVraoaFIZmtR+sJiXXmFlF1Bj8nx/QYJZT6uXOwoqXzAaonTcNQnTqiz49PUNulP0jV9Y6phcwlq1JJpn7iqTOO2C/vxfx1lJd1mVp8f1GlTH3DYb626Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ip/hqoeG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ip/hqoeG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47df6a5202bso419109f8f.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783677252; x=1784282052; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v8P2Uf45mI/biqxnOxHWfgXQmu+JaXEwT05r7bGVu80=;
        b=Ip/hqoeGAr/myjEmeIAVuqq/vHDGOW82Jij0v9V7U9rEvPVd9xIOWYyooT6BVXBmQX
         oQtmGVl0uMY1ruyFgsmEHUkL4uUGHUyVEIfFDGOZQIlD95I00sEkYCvvLbsUVaCRcdE/
         21l9ux9MUb0iFF5oP9hKQH6roO+9UKLSfUNsGIWQFMT0Tc948Tjponv4UABojt2vCMnC
         gLTlIF36tLwLlPnNOmJ3i9z8rMMq3NEiQtkOpsuomare+m7yXnB+/mZ0F6cQEI72XISf
         Mm8Wpf/L6vFfce6tR71mQY2uUfqusyRMIGEgWKU19OdDbVQgTfvp33yjhc0PQ3Zo1D9L
         hSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677252; x=1784282052;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8P2Uf45mI/biqxnOxHWfgXQmu+JaXEwT05r7bGVu80=;
        b=nY6s3n9YdWKGmfwdSdgOAcpztiJ/zsL1YAgqAYkxwcjhSO+LFBmYZJJrQVmq/SigBP
         K8eb/24R+hnaFr3z5Lwx2bWs4SpkeYkvbtdzORJ55Wz6zbNbe+4MgBpjmrKkr/Z1PY+S
         paA9WXbZS7H25Wvc9OYXJq6JroH0aagNW4sHpoBHDxwYA+AK19j6yIGZVqt+9XvyNpW1
         HkkE+Lnx+ql82IFjH7zbN0wJkYM76M1IwH/LE1RNduKsh1eEcUltvxunFEgox1ScvU1m
         BQfzYFeQiqTK7bqPvJU3p7bPGcnVQQH8Sa79UGjAgb4cI/FKnZM7MYB4By1FaOXNrTLs
         oDJg==
X-Forwarded-Encrypted: i=1; AHgh+RrbD2RCAXo/R/MYKpKI5BWGk7cikjmCm/kPE1GSQ7JUnWVGnYmymv/G7PSmhglh09XyolICJYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfidrjOIWr9kiF5xhQ8Ki4pNZO2BtN/aQSL2mXgK+FWU6zPDcY
	zEl76aPWR/PcAwMTyD9G/qTfzj0PjqNtgtgxjC2E9VZg5IQry7XYWfNL3Nl5DYh/pig=
X-Gm-Gg: AfdE7ckBStw2WMoINL9WdO0Ssu2MtceiYrzVikvFOeDLDXGZtMDMnvEIoasLYt+20YQ
	GdLU883HaXTzx+9QEmRTz89dyckIFDyFOSBLkSp+IHHzkrv4O1pibPFukLq7NPpiFefmz8BZocz
	CpT1YP35LM4nfq1mrQcEswVJSDAq+MuY9i/YoSku8ELSH+SA8t41huiP5iSGYP7kws4Wo6X2II8
	Xve7L4I2Dr1hZGlNLv59m5o+q+SJaL0htynzPCDiaC9iscaHI9AFx/y9PJqlau43wpf2s1L3dqh
	vxXbrw5oxJPpwtHWO9LlCAGE3sseZ0vEuXcKtmcL5qYL0bzbu+hRujJwwIh/sd9kU0QRnDKt/S5
	1PS/ztn8SW/LSRO937GlFhY0ObE08S8zIQDfo5qomh40pn3h59yRBFWu702k3e5/qnDEbiR+YP2
	QxHKJ3bFzXw/7RtDZERN8bxieG
X-Received: by 2002:a05:6000:27d4:b0:47d:f441:5f93 with SMTP id ffacd0b85a97d-47df4416019mr6854730f8f.25.1783677252374;
        Fri, 10 Jul 2026 02:54:12 -0700 (PDT)
Received: from [192.168.219.26] ([212.129.74.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm55993210f8f.23.2026.07.10.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:54:12 -0700 (PDT)
Message-ID: <a4003ac352f382fa4ff329acdfa561eb06e77289.camel@linaro.org>
Subject: Re: [RFC] Significant Random I/O Performance Regression in Linux
 Kernel 6.18 (Up to 27.7%) Likely Caused by Commit 3c7ac40d7322
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: =?UTF-8?Q?=E5=AD=99=E9=AD=81?= "(Kui Sun)" <kui.sun@unisoc.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Bart Van Assche
 <bvanassche@acm.org>, Alim Akhtar	 <alim.akhtar@samsung.com>, Avri Altman
 <avri.altman@wdc.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "\"Martin K. Petersen\""	
 <martin.petersen@oracle.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam	 <mani@kernel.org>, "kernel-team@android.com"
 <kernel-team@android.com>,  "linux-samsung-soc@vger.kernel.org"	
 <linux-samsung-soc@vger.kernel.org>, "linux-scsi@vger.kernel.org"	
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"	
 <stable@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"	
 <linux-arm-msm@vger.kernel.org>, =?UTF-8?Q?=E5=BC=A0=E5=A6=82=E6=B3=89?=
 "(Rain Zhang)" <Rain.Zhang@unisoc.com>, "cixi.geng@linux.dev"
 <cixi.geng@linux.dev>,  =?UTF-8?Q?=E5=94=90=E6=9C=88=E6=9E=97?= "(Yuelin
 Tang)"	 <yuelin.tang@unisoc.com>, =?UTF-8?Q?=E9=99=88=E6=96=87=E8=B6=85?=
 "(Wenchao Chen)" <Wenchao.Chen@unisoc.com>
Date: Fri, 10 Jul 2026 10:54:19 +0100
In-Reply-To: <12a8417dc8644a71b9cb25c53c93805a@zeshmbx08.spreadtrum.com>
References: <12a8417dc8644a71b9cb25c53c93805a@zeshmbx08.spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2026-07-10 at 07:17 +0000, =E5=AD=99=E9=AD=81 (Kui Sun) wrote:
> Dear Kernel Maintainers,
>=20
> During our upgrade from Linux kernel 5.15 to Linux kernel 6.18, we observ=
ed a significant performance regression in random I/O
> workloads=E2=80=94with a maximum degradation of 27.7%.

[...]

> This issue is particularly pronounced in single-threaded, small-block I/O=
 scenarios=E3=80=82
>=20
> To illustrate the impact, we conducted benchmark tests using AnTuTu on Un=
isoc T615 devices.
> The results are summarized below:

[...]


> Root Cause Identification
>=20
> Through investigation, we identified that upstream commit 3c7ac40d732232f=
ec0ba31d0a5e3cc9c112fc2e7, merged in April 2025, is likely
> responsible for this performance drop.
> After locally reverting this commit on kernel 6.18, performance fully rec=
overed:
>=20
> Table 4=EF=BC=9AMixed Random Read/Write Speed Scores=EF=BC=88After Revert=
=EF=BC=89
> Device=C2=A0 Kernel Version=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Test1=C2=A0=C2=A0=
 Test2=C2=A0=C2=A0 Test3=C2=A0=C2=A0 Average
> T615=C2=A0=C2=A0=C2=A0 5.15=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 18604=C2=A0=C2=A0 18314=C2=A0=C2=A0 17732=C2=A0=C2=A0 18216=
.67
> T615=C2=A0=C2=A0=C2=A0 6.18=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13372=C2=A0=C2=A0 13081=C2=A0=C2=
=A0 13081=C2=A0=C2=A0 13178.00=EF=BC=88=E2=86=9327.66%=EF=BC=89
> T615=C2=A0=C2=A0=C2=A0 6.18=EF=BC=88reverted 3c7ac40)=C2=A0 18314=C2=A0=
=C2=A0 18604=C2=A0=C2=A0 18604=C2=A0=C2=A0 18507.33
>=20

Thank you for your above analysis. Your numbers match up well with my own
observations at the time in
https://lore.kernel.org/all/88d31a258feb36425ad73d0323077972f85f8341.camel@=
linaro.org/

[...]

> Request and Recommendations
>=20
> Given the tangible impact on mobile user experience, we kindly request th=
e community to:
> 1.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Consider reverting commit 3c7ac40d732232=
fec0ba31d0a5e3cc9c112fc2e7, or
> 2.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Re-evaluate the proposed change in light=
 of its effect on low-concurrency I/O paths, as discussed here:
> https://lore.kernel.org/lkml/88d31a258feb36425ad73d0323077972f85f8341.cam=
el@linaro.org/

While originally I was trying to find a solution that doesn't regress exist=
ing
platforms and still works for the newly added platform, I can only second t=
he request
for revert, given how important UFS is for mobile.

Mani was also in favour of reverting:
https://lore.kernel.org/all/4enen7mopxtx4ijl5qyrd2gnxvv3kygtlnhxpr64egckpvk=
ja4@hjli25ndhxwc/


Cheers,
Andre'
