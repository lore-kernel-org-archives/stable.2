Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2393EC812;
	Fri,  7 Aug 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092693; cv=none; b=u8owloOm0Uv1h/mD4WIx3hK1i7YH/gYgTIzUQvEwB11GL6ogSusXSJW5CdWvXMia312hk7epTDiPf5F9sDpw+9jAimWG7evJnWfew+uwA+5qSN7Wueik8WI9cQKBLq8H9hrK1VdwIcs/+p0LVcd4FfNwxxilc/SKKqveloVVCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092693; c=relaxed/simple;
	bh=I+Eiz7/0JxWIupKwIb0quAT+zL2qYcarKFqPL59HulI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJNYZPrFzdCapCOdkjJ5FHZjBc5kq5nZm9TxZGHamvJHCMVApOu9TsM86Syc/HMpP6gSqYikZ7THsk40HUJhAYWpCLrIoB7CdpGx0OBiwoYWXAPTt3vkv4iNzXJHYEVJIyaZxB0+wMdHfSByJel1XYziOPhBz2h/ePPk35/Nu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsS2dPal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsS2dPal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971211F00A3A;
	Fri,  7 Aug 2026 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092692;
	bh=w/L0R+LFU9mVfCT45k6ZWYiIBiaxXWLtIQdg41M+M7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XsS2dPal+tdOeRAz5nhXFzo9g2PTb3JBHHY010D9D4Pcdj9at/G3aJD6aNSbT20Br
	 AtCtkDIeP6SU8xIvwe1iFasCqi6YpTICMrtM4KOt/Wcmd6Kzr7kr2r1xPIBbRzPy+u
	 2HBt+l7igCAgzSaK5vyyjmR4OmNVqt7HQWVb5D4M45ZCHv1fzWyh19450Pu4A+3qAD
	 ZksM1GmBozKWyr6bZ6YaJchUqTgXgFK2GUjAAiwsL27jI3CuXYlEdQkEQSDcZNfApE
	 LHaVeHljMTOq+AY05rSvtOefS1oOjvQHfdNXkR4ZzRgbsWzSlt6IlMg43Rdx5EB5rQ
	 0x2/DOEGfEQIA==
Message-ID: <0b2c4f55-8e61-472e-92d0-05493f552c85@kernel.org>
Date: Fri, 7 Aug 2026 09:51:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] media: iris: Restrict lower IOVA range for Venus
 and Iris VPUs
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Mansur Alisha Shaik <mansur@codeaurora.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Stephen Boyd <sboyd@codeaurora.org>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Marc Gonzalez <mgonzalez@freebox.fr>, cros-qcom-dts-watchers@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Aniket Masule <amasule@codeaurora.org>,
 Malathi Gottam <quic_mgottam@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>, Jonathan Marek
 <jonathan@marek.ca>, Dikshita Agarwal <dikshita@qti.qualcomm.com>,
 Renjiang Han <quic_renjiang@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 stable@vger.kernel.org, Daniel J Blueman <daniel@quora.org>
References: <5BXSXMNl656WiJPJAMmHvb3I2NzYMshRZuGuub3CxEXvdCUlIDKYbnv5jUq-pa6P1NibBLkO3njnKGxi7Al3jQ==@protonmail.internalid>
 <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2026 09:24, Vikash Garodia wrote:
> Qualcomm venus and iris VPUs reserve IOVA addresses below 0x25800000
> (600MB) for non-pixel stream ID in secure mode. When the kernel
> allocates DMA mappings from this restricted range, the VPU generate
> unhandled SMMU page faults, leading to video failures and, in some
> cases, spontaneous system reboots.
> 
> The issue is readily reproducible on affected platforms by running
> multiple concurrent video decode workloads, such as opening several
> browser tabs containing video streams.
> 
> To prevent allocations in the restricted region, this series introduces
> support for an IOMMU IOVA reserve memory-region in the Venus and Iris
> bindings and updates all affected device trees to reserve the low IOVA
> range [0, 0x25800000]. The memory-region is referenced by the video codec
> node, allowing the IOMMU layer to keep DMA allocations above the reserved
> boundary.
> 
> The series consists of:
> 
>    * Binding updates for Venus and Iris schemas to permit an additional
>      memory-region phandle describing the IOVA reservation.
>    * DTS updates for all affected Venus platforms.
>    * DTS updates for all affected Iris platforms.
> 
> This ensures that DMA allocations do not overlap restricted IOVA
> mappings for non-pixel stream IDs and prevents the resulting SMMU
> faults.
LGTM

For the series.

Reviewed-by: Bryan O'Donoghue <bod@kernel.org>

---
bod
