Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930863EA96A;
	Thu,  2 Jul 2026 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783035661; cv=none; b=nUlGwI+cQQ1ZMUuZgmd+29IgYJIioOKgCDz0cxOUYt/0WRHUF4yIfh6a5yXmpQsXoDllCx+ybpI+oYdVgWPiK6WkcOVZnUypLJQfGv8ZA2z91q/VZIZohdhMPpju8cTkxszZ9Jgj/QW3evO6jWywKPdEFVN/e4nkZLPPIl2L0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783035661; c=relaxed/simple;
	bh=Hwx1qpZuVwaL30IKp4VH3yyNQ73sheQp83qEnY2XSAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAaex1QaYUZLMLSdSXjSArLCvcPKASIO1/fT22wxddgrKTpOEYeT6vltcde3zEBNBK8+QfLurJjJ/sMLDTIxIKcy95PYNtpTv20VCE6UuFu2VzXWXco/H+XJOftR5XwudclJPORf/BtXSiKpMN6QdrBAqBd5dOqI2TQdpK7UrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA4L3A7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA4L3A7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08A51F000E9;
	Thu,  2 Jul 2026 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783035660;
	bh=2OQ0fbkG60QACnpioEmS0w+2aF423k9gugmMX7erbzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nA4L3A7SN1EQ07D0EcNFnYkCRwkuHwKz4QN+UNxNrZ0d0+eJBjr6Fw7955klOmfzL
	 xE4KtgIuw1XLX7F53OCtC+CwM6DZu9Yu9RnWbFzwscKXNBSlgFVdfGP03AGWe3o252
	 Ncl1B981fCcP4C+DC3m6Y1sE3LxXo8JxSCo2GfpWUnt3f77FN/uk6CM3hNLuXJOzSz
	 uVlGFGsGbi/a+YF/TMdxgwB/7qUkr9jO0/FeLIx53vakmG7ZjruSIWxHGRpjdPnIvl
	 lF0zewMiwCN7Wd+hFvAxIPt8H4f3AMiw8AaZSk5WKN2tpWvg+54xfMXKLQ0S/ic/Ha
	 H8sdPl/g56dkg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dang Huynh <danct12@riseup.net>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6115-pro1x: Correct touchscreen GPIO flags
Date: Thu,  2 Jul 2026 18:40:34 -0500
Message-ID: <178303563652.359079.2388660419831828479.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413090527.53000-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260413090527.53000-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 13 Apr 2026 11:05:28 +0200, Krzysztof Kozlowski wrote:
> IRQ_TYPE_xxx flags are not correct in the context of GPIO flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning: IRQ_TYPE_LEVEL_LOW = 8 = GPIO_TRANSITORY.
> 
> Correct the touchscreen irq-gpios to use proper flags, assuming the
> author of the code wanted similar logical behavior:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115-pro1x: Correct touchscreen GPIO flags
      commit: 8e73ae5c34e4fbbd25a8324e3c0eb1e845d7f01e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
