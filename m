Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625392;
	b=NkxNyeZgcKtlwDNPmb/1/vhloj8n9aVH7xGf2k7Xt5BJrroJH26/0fqbBEosB7v8Fl7V
	 fA3qxpIGeWxZUtVI+pvZgS6kh216yspGd+BWI6N9cT03yEOEh/OCPb0PoNeuFucFSSPIP
	 UpThilkAwdHS3OFtWI8dpZ1Jkpm1m+P+995wTW2UtW1B59w1fGgBKHA/6Zaw8qgmNjUAz
	 Hbm4a+033n3H2WNjW+yviKKbWGuDVaQCWwA6Yz92LuH3CiPy957GTeXJa+XUEKl8dLyel
	 QTmKoeRsmrRLr+nC4WbRXYJ0+L2AbSDe95BCiW0+YhqQLBLzssV4TU9or3b+paYdL3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625392;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=64OLG8P0V/vt+DC2pOIDmvx8cJ65cBuW3hhgyyT0Ems=;
	b=k5GlnYfVqF09ymH/MtGyJ5JCqxwGIfOsf3yTIam6MhDb+RYL9IbLzwCDYSQYsbXkXPDY
	 kFGTJL1vxq4V3U2vZoMhUJtO3S75PmmMysCgfy02ySvePHVJP/4+LC+kutboeeU5DHgfn
	 7kWojzLRMktY/9lR6bw3ZRHE+Fs7lPgxrLcPm0r1bHYx+JzaxtAjSuciOJN1euOUmCr6e
	 uB/bCL3851w6Xv5jDHFXK38nRa0uC2+iXbHBbrRxaWVZniJg8cOZWZZircM5NRXcJt7Ox
	 jXG3WajAJf/ScHvs91ya+y7UwuhygRHpba0B406FlWB/eAc5H7Q19xJAsLRYqruLALg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5LoiPZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5407606A326;
	Wed, 25 Nov 2026 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5LoiPZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFDB1F000C0;
	Wed, 25 Nov 2026 16:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625392;
	bh=64OLG8P0V/vt+DC2pOIDmvx8cJ65cBuW3hhgyyT0Ems=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=H5LoiPZEwvP7HnPA+yPxlM0TA5e7zWy0aoOpA4KgAyJdjpUqFR3UBhJ5jZ9oHZbch
	 o9nDOCNfuKudS0waCP09gww9Ikqhj4ovPgtWnKVq//UAk2rOl/6cthgVuHBhYZQ0EW
	 svV+Rqi5OX3iR0yKO4as0oU98Ab3Vd8MhLmec/Shb+BlL788Ctj4ba3XwhWYPgp2np
	 YFck8Cgu+bydUTJZaAqauVaxYlo7Wf4dFsxyRZp+/VhrEXHwQRt2zGA8cG5Hunm3kI
	 2TIj14FJIYdoRpYNs2+XUpmLr1sjTMzNAGO/FR4EM2od2cP45K9UjINOunI39ZDpHP
	 vpTeK66MnTeWw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] media: qcom: camss: tpg: Skip the unnamed test pattern
 menu entries
From: bod@kernel.org
To: George Neacsu <geocausa@gmail.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261016-camss-tpg-menu-skip-v1-1-0a0a24e36316@gmail.com>
References: <20261016-camss-tpg-menu-skip-v1-1-0a0a24e36316@gmail.com>
Date: Wed, 25 Nov 2026 16:49:47 +0000
Message-Id: <179562538779.462348.10497766296807730990.b4-reply@b4>
X-Mailer: b4 0.17-dev-cdd92
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=bod@kernel.org;
 h=from:subject:message-id; bh=bCmQQ4xCxmxyTsgqO+Fyl7t/ecS15PDAtJNMfxXszCs=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBrBxGsRXKqFB9Im0TwnQHVHPy+svq/qNqixbqN5
 w+ovsa0DY+JAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCawcRrAAKCRAicTuzoY3I
 OrgqD/9z4/VgGGVC31GSC1ca1LvX0ZZeukfTdDrPAKqAUodKphzebkOUdaqtMMRVnBDbHYlCV1v
 VnxwAfbeCDGK5r1AnJz5p7aK2rOyfe2cHQ0v9TtPP5o8B7JCx2llgB4SusIWoYV4PxFPie57umI
 7IWNHjdv57yKUpKqQzx1WsslPeZ8P+lSBZf4OHhzjH/WpmL2R9+541Ib1F4RufIis3IIAeJ475Y
 mEABlneR3WBv/EBg6UjrgJqQzyshTDpQ25GsGoGmDjF8CpzanHV+S1iAg2Bj/IbZqFHGVfdtLZg
 Qf5PkbijDMoBGuIH5xU/w+TXiwx2EVfVX1TclCp2OnkBFEIz64Lwx7vTR8H/DsGNytp5GtAAwam
 8xGG/DBd2JduS6E/eV/F97I91yDv6ZuS9EsSR8J9KR+JWK+TEO5veMkavOsW6Bc8uQP1BK65qrd
 MB3CL03jjj4ocrPvONbmnwN002QkTuOcNIWFdYkPsA2Z3TGww4wg+egcxgE6C/R7hO1DyIfkTBq
 04IILDXiNjqBqoO+H7BhE/Pyd03kQclTN+r75uqjOVQizeg1X6FfBPkHReaAMT1+6i3yJOzeW/X
 o3Xgrt7z31sbI1chIS/+xP5yHi84fjKQcAOF2i3sRn9Cm5597B8tlQF82C2gHx1NE4gi05gBqsa
 iYkh/1w76x+ZfvA==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-10-16 15:55 +0100, George Neacsu wrote:
> The gen1 TPG names its test patterns in testgen_payload_modes[], which
> is indexed by the hardware payload mode, so entries 3, 4, 7 and 8 are
> NULL. The V4L2_CID_TEST_PATTERN menu is created with that array, a
> maximum of TPG_PAYLOAD_MODE_NUM_SUPPORTED_GEN1 and no skip mask, so
> setting the control to one of the gaps makes
> v4l2_ctrl_type_op_validate() dereference a NULL name. The oops leaves
> the control handler lock held, and a later rmmod of qcom-camss then
> hangs in v4l2_ctrl_handler_free(). v4l2-compliance -m /dev/media0 does
> both on X1E80100.
> 
> Skip the menu entries that have no name, so the core rejects those
> values with -EINVAL and VIDIOC_QUERYMENU leaves them out.
> 
> Tested on the Surface Pro 11 (X1E80100) with next-20261015: the menu
> lists 0, 1, 2, 5, 6 and 9, setting 3, 4, 7 or 8 returns -EINVAL,
> v4l2-compliance -m /dev/media0 completes without an oops, and qcom-camss
> unloads and loads again.
> 
> Fixes: 51fe835c485b ("media: qcom: camss: tpg: Add TPG support for multiple targets")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: George Neacsu <geocausa@gmail.com>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
bod

