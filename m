Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBCC3D6476;
	Wed, 19 Aug 2026 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123881; cv=none; b=TD1j/7KzMrooKSeEu0GKHtyAtPC57eRJjvum1EekQN2CWrLtLea/fbdfiOpL7FdrIltZKl5OQKkNYdnvFH2SNtc/RTHJ1oh7z1ajOEx3YocstekXS3G05PDIgymcFsK0k02K1dCbKkE1CM5Hw8kfJO3n7jih7RTlp/l74CzCZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123881; c=relaxed/simple;
	bh=nJPv0FsU8yQd3cl+i57E+G3bOHVMBXDauyCziT8meqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXKQ/iDydJNMq6/AuOjofVbEEskcLnTW2gDZskg1qYkqpnNTrgsZG6AcLJGTLVkIeJF6vdG76JW7rP+l1wy+IYYYgnEqAmzQfZtozCQCg6c8jZcVDfyllN7cTa5sm3diQvMfHOK5v3Eus8qVCKSrir9TZTecY3pvWGYg2BnqfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAF8xuWJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAF8xuWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147641F000E9;
	Wed, 19 Aug 2026 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123879;
	bh=9SGcuRYCnyzFASPmzXdMg0CNQg90nsP++ry1445hiS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HAF8xuWJFHDk97YjnAAK3DgkpocHUx0J/wgFVhPv+IRT9jNA6ut4uN5cspIQdjsZr
	 D4/BO/i0wFNxqf/IpmUpfbzaOFA01nQABBZqKhQ9Kg0bep064n7JnQsRxzuizO/ua8
	 e0Pjy6I1Zcf3l05TSGWtf+0Y5hC/hpw3ViBm9+hmGqE7q/i7MQtc+YP165KqAymtUm
	 jISKokqxgrEIPimoWsBg2jwm3DlvsVoYVr1R1n04XgVTr0Hjd3JIWTrRoGpITIyDPP
	 lqnQdl9cJ0TkFV02+Kt2FflOCkQzzDGANQWSIO+NXABnvTWmgdwKQnufiK0wzaP7rS
	 9KvcgrWbBXH6w==
Date: Wed, 19 Aug 2026 09:17:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Mansur Alisha Shaik <mansur@codeaurora.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 5/5] media: iris: Fix frame interval enumeration for
 non-divisor framerates
Message-ID: <20260819-fat-shrew-of-agility-16bb0b@quoll>
References: <20260818-iris-fixes-dma-pseq-fint-v2-0-8dc8c4b3880e@oss.qualcomm.com>
 <20260818-iris-fixes-dma-pseq-fint-v2-5-8dc8c4b3880e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818-iris-fixes-dma-pseq-fint-v2-5-8dc8c4b3880e@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 09:24:18PM +0530, Vishnu Reddy wrote:
> iris_enum_frameintervals() advertised frame intervals using
> V4L2_FRMIVAL_TYPE_STEPWISE with step=1/MAXIMUM_FPS where MAXIMUM_FPS
> is 480. This caused client to enumerate only framerates of the form
> MAXIMUM_FPS/n (where n is a positive integer), restricting support to
> exact divisors of MAXIMUM_FPS (e.g., 480, 240, 160, 120, 96, 80, 60,
> 30, 24, 1).
> 
> Framerates that are not exact divisors of MAXIMUM_FPS, such as 29 fps,
> 25 fps, were excluded from the enumerated list. There is no hardware
> restriction to framerates that are exact divisors of MAXIMUM_FPS. This
> caused GStreamer caps negotiation to fail with an "internal data
> stream error" when encoding content at such framerates.
> 
> Fix this by using V4L2_FRMIVAL_TYPE_CONTINUOUS. With CONTINUOUS type,
> GStreamer creates a continuous framerate range [1, max_fps], allowing
> any integer framerate within the range to pass caps negotiation. The
> step field is set to 1/1 as required by the V4L2 specification for
> continuous frame intervals.
> 
> Fixes: a6882431a138 ("media: iris: Add support for ENUM_FRAMESIZES/FRAMEINTERVALS for encoder")
> Cc: stable@vger.kernel.org

Why is driver patch AFTER the dts? What is the dependency?

Dependency on DTS is in general a no go. I looked at cover letter and
could not find explanation - where is it?

Please read both submitting patches documents.

Best regards,
Krzysztof

