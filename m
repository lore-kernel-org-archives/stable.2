Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A232A3C8;
	Fri, 18 Sep 2026 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695390; cv=none; b=g2vIunFTReECslVOyweS3C94MocMDlEFtnxTdfZffnmhoDFVEmRJdv6ZBSVZcJiXCIvwmFlYNBIUamWiu7KGg7w5TkrM5T3H75tNb+V9IWaxxjq5WZkkViYjvwoVzp3YtfEnRKoGboNUr1KXL1DnsErLMcOhBan3obltg1prmUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695390; c=relaxed/simple;
	bh=DJyqlOQ3txseiN+o6Rk8JIESIVkn8Dq465dyxyYI9iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMZ41NGkocjzZHvi4/Zd2/+uH4yE/7Ii4n+4e7rtF4dnGQF5/OdJvkyRTrlifA1WgyNlsYU8gp2W1m+H6soMQnArj+D7tsH2WlK3OTACqvFld2wk4DH6uf4nYCOhsHO4whJrBYW0jIKtviKvy/5hg4tJJs26eiAigR2UgjrLWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf+ry3Kq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf+ry3Kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094971F000FF;
	Fri, 18 Sep 2026 01:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789695388;
	bh=6IaAWEaBiOKUnROTpq0L5Ofe2m/RZ5CV/7s5WMrgEQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zf+ry3KqTl5J/hsN3Wse1/Fla8guEupSU5Ey4/qM2FcS50i3QCmnovNNbKbomSfLj
	 9wIrPW/1G7tPeB0S6zpvJcR277uqmDQd74JiPfarN4lg6BI+1SqwndJCCPI8swGM/4
	 dLjUkL8qP0IYwfgXcN8eZyHvL3SpRVKvL3QX9SjoPoViH/eyhKi9keRGg15F9AScBh
	 eepP9CCmxo2/bI5SmoTTLZYUZOBSxK9exgQA6yYkU4s5q+OVmdfNjDzms7IPYUR8ma
	 0aV1Zf8cuOAz0nl35JoJb8fOQsuHJIxw/FJ9jZXRB8SZrypLhNDGi/Y1Y2/2cvqtP6
	 byOeGpQZIRTRw==
Date: Fri, 18 Sep 2026 03:36:09 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Bryan O'Donoghue <bod@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v19 0/5] Add phy_get_by_of_node and devm helper
Message-ID: <cqoquu7hzclx54km763745dupaxahv7y4xbzq7vxg23isptgqz@j6los24mhnnn>
References: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v19-0-21ad8a76e941@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v19-0-21ad8a76e941@linaro.org>

On Thu, Sep 17, 2026 at 04:25:05PM +0100, Bryan O'Donoghue wrote:
> This series has evolved from a CAMSS standalone series to a series that is
> mostly on the PHY side now, so I've split the series up to reflect that
> fact.
> 
> Starting off by fixing a long-standing use-after-free race-condition in the
> phy core flagged by Sashiko in v13. While my series doesn't introduce the
> bug it seems appropriate to address it anyway once flagged.
> 
> Once addressed two new helper functions are introduced to the PHY core to
> enable finding of a PHY using the media graph.
> 
> Finally the usage of that new API is shown with CAMSS.
> 

Looks like you completely missed all my comments given in v17 :/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
