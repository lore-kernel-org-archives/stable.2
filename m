Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017638;
	b=YLFQoQdDnfKgzbGWMBC5WAMc32mMJUtKigRbTj9OalUjRKNTJ5VUOTpodJqZNE5S27eX
	 GBDfEgod2iHuNM8euXgSgGa6bKTAcGDP25ueSDTyTFY54FDpBtXOEOTQlgswDHlMLeGOS
	 o23mYba0SHV7dzefwh1uGxxcmXupboME1haUUuaTVaMl+g/i/Neejc6GrK1Zmtb+3p7CO
	 5+adcs/LJ7dHXX4VJAGqhLERho3qnAlCf2gr2rGRwPbBOm3LY6Fwa20MacY/QIco8ASN5
	 cYs+lQ3KrMn1EootVTruJ8gpHQlQzaT5NA8bGaSTRSwcvVAEMIEQzN+5551hj/mf9nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017638;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cSzRCJe203nG3DjmKreWNmifbqQ6eZroTgaCVpedgq8=;
	b=wsug/zJTNDxUwXHiQiTiIGC0D1A7cIeo3yPL5aSnTb/fYkAoFKnEVBWhubr787RiQB9m
	 RTxHj6ivko7SpS0eGE1Gyopi7nllkoVfWEVzIFLbTvG7SAzGT6F8MQbm8/NC8PXhKIvDc
	 8zV3rMZJLESJ166HV7D5lVJbnP77ULOh1uGLdjhg04KzP0ZCTOJNNrLDFUsfzdU9E5FDM
	 VNK62Xgd6Y9C01uGNR/R5YLafEeMc2UuIKMExrVU4zccU06969Vlfk72H5VJ4+fJrEK3j
	 lNF8CQj+Qpl679N33XET+RwCb6DFtXfGDN7C+gfDty+U8Em7q1eK7dOzvGszHnXOFqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIQpdHT4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82613606A325;
	Wed, 18 Nov 2026 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIQpdHT4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B931F000CE;
	Wed, 18 Nov 2026 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795017638;
	bh=cSzRCJe203nG3DjmKreWNmifbqQ6eZroTgaCVpedgq8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=AIQpdHT4afUI2Yr6DBMBJ538B2Jh9xZElqzRV/cOj/VYB8cAtgJzCBK7UrCXioIsF
	 H47ULU079HX6F41g/CHSqfaIv7Bwuj32R85uJLGeEV2/13wNkoZNMCkVR/AKLPKXyz
	 wuq1IvVsdSV/QSKDgDvQxyV6Uk1SzF5k517NUksbxr27HYvIa6x8dMOaVBJSbYh3dI
	 Tc96qzyeszI7j6l/SY/2msWk+N0GWdRfzByWS63Jscgh4selyjVN8xNHBFct5iF+6v
	 u2tgJXx/Kap7Zt2vMuriPDYSmo9gZE/H+2RNaNXsFOLfRe6DUi4n0LLU0WtO6p7MUn
	 ZEEdKptvA1njQ==
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
Subject: Re: [PATCH 3/3] media: iris: Use firmware reported count for
 output buffers
From: bod@kernel.org
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vedang Nagar <quic_vnagar@quicinc.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261031-fix_dec_seek-v1-3-cfedf0c267ee@oss.qualcomm.com>
References: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
 <20261031-fix_dec_seek-v1-3-cfedf0c267ee@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:00:32 +0000
Message-Id: <179501763210.2846709.2834027862962422789.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=bod@kernel.org;
 h=from:subject:message-id; bh=/AP0CoAgLohhW5HLCcUNA+EpSWZFnT0y2EdkIXNbETE=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBq/cugn7uvdcNTuOfP9Xbb1suR9FMivnTjAW0KV
 QwoeoYaKgSJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCav3LoAAKCRAicTuzoY3I
 OpV2EACQ/TsC5dkjOhP0DBcih24tqd5YR4mkMNv2fqwOCG2fzstzwL3xRzS8zguIjtMrDbrhYOo
 ASQxvbyQUl0lrgpefu4w49HWLJe3on1oScY3IE4wSo0Gm90JVfB+EL1uCYSiSgZES/b6jOhulsc
 TnmFfq9OG/UAF6M1Dp78Olg9AdAxwQgfBwutI2C8XSf53BTG/ah/jpFQHDdz/IgsXWScaggYQHI
 dfHugOSWWUUkI8vahNzNw1NzOA5yGzUGZ8x0iTeKP3vj+8ozDkKOBd56ZAreZ7n/Yq95O0+sDtz
 JymFLEArHN5WJR1uA7CJu9GIzBytDWs1YyB9ECicSaWH4+HdfiwxnDVXK92tIUP+cvxu79dl7vB
 3CqIaat2NH/aXk/3iDMI59ZORZGhKs2uyAjm1kI28niCxaI57QUrPKKRnBXZjuNvJns3D2tJeRN
 q5ldR1+C/y3huHapXc/7zy6/TlSZYg5quu511C7Ofyk9ZZOHlv0nQvC1SAM1DN4Eyp/CE9K14Kb
 FBK8BU1t9biOsj6MOCopt8kax2kouw55EEX7kXfURj8qywRnubbOdcgEgwf3aLqWMYGeCmIhcE0
 8R3npHC9p254L7f3ouIOBMzx5v/TyDVUh217J9zJf8lsWAr+9sCN1AVpn8rTDV69Ii3jIDZ45Wn
 ltM/Y5fxOt7Jmng==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-10-31 01:49 +0530, Vishnu Reddy wrote:
> Once the firmware reports its minimum output buffer count, the driver
> still caps it to 4 for VP9 and AV1 when split mode is enabled. After a
> seek, the output buffer count can be lower than the minimum required by
> the firmware for VP9 streams. This causes the firmware to report
> insufficient output buffers and the seek operation can fail.
> 
> Use the firmware reported minimum count as is. The driver calculated
> count is only used until the firmware reports its own requirement.
> 
> Fixes: e1f5d32608ec ("media: iris: Add internal buffer calculation for HEVC and VP9 decoders")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> index a8170e5fa9e6..57467c952f42 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> @@ -2375,14 +2375,8 @@ static int output_min_count(struct iris_inst *inst)
>  	int output_min_count = 4;
>  
>  	/* fw_min_count > 0 indicates reconfig event has already arrived */
> -	if (inst->fw_min_count) {
> -		if (iris_split_mode_enabled(inst) &&
> -		    (inst->codec == V4L2_PIX_FMT_VP9 ||
> -		     inst->codec == V4L2_PIX_FMT_AV1))
> -			return min_t(u32, 4, inst->fw_min_count);
> -		else
> -			return inst->fw_min_count;
> -	}

Quite a few questions here. Why is the minimum count currently set to four
? Why do we use a hard-coded value of four more than once, why not define a
different minimum count ?
---
bod

