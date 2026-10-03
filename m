Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C8243E096;
	Sat,  3 Oct 2026 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791041129; cv=none; b=mL+Lgi/12waPWQ7t9XAXjjZ7QtemTF28/mZfpqaGHtcALCOPAyl8jePJoDjCJflP8FKGk2WMNc4MXoGn3aCCiJEqV4d8FVZIvTQya2AxZBwLFob1e0SrSWVb1RiM8pe7oInWfnOaLbbuoHSbK09WXw89EgCAn8NQlgkOOoXN4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791041129; c=relaxed/simple;
	bh=lx2x1hklsigjm1yShPIOoDaDKiB3yHLeirhQggA1NN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DgSvSIY/zOvtV4ccpb8foGInXMUba3Oy0IUXDcon964KKZ7MnjGXuNo7N8MQvmbhnPsGPx57bcOX8PskbHo+Ztmte2vAql+tIMgTzDR4QgTZgQplUJPUmMEJpnPZ+hOGbwn1ft1njViHO17SM/BPKDyPqy9Zy2mNOPqgW0GQSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA8BBvY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA8BBvY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001C01F0089B;
	Sat,  3 Oct 2026 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791041127;
	bh=23Y/2PgTxZUSaSmiQQfmGqgPefme+EflMV6C57Dhc+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MA8BBvY0ou10kc8WBVXZjL4stUd0LzlylLRTDrUop31oOaz6fkE8QYjQJF9aX4g74
	 cxxeRYPlFn7YiiDxiVbtof6pHcpcA8GA8Tlof/m6YOMeIfl6gTVgr+p6Pre6sgh8wZ
	 Pv1OKhKstaP9k6NxwECz95xX4OT4k2Ev0yNdGAuZJkKKP+o9uMdEKuY1n3iQkWt8yY
	 naO8oaIFK99O/JCIf04jL3UWM34vPeRWb/FVmXsydxmeL3VRURQaCIfixmhLt2U7oq
	 sCYwq/H/CISdQCG8ZZ3T31V4OsXBK/PtLnE05Fon9uLHOnOrYRpnH6LarRCWdzbs52
	 9FziDx0tLUByg==
From: Vinod Koul <vkoul@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Paul Cristian <p4ulcristian@gmail.com>, stable@vger.kernel.org
In-Reply-To: <20260821-b4-atcphy-usb4-v1-0-45c0b741e0c0@kernel.org>
References: <20260821-b4-atcphy-usb4-v1-0-45c0b741e0c0@kernel.org>
Subject: Re: [PATCH 0/3] phy: apple: atc: Prepare USB3-via-4 tunneling
Message-Id: <179104112470.223537.13101636843380037853.b4-ty@kernel.org>
Date: Sat, 03 Oct 2026 17:25:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 21 Aug 2026 15:50:26 +0200, Sven Peter wrote:
> This short series first fixes an oversight that prevents USB2 from
> working when DP AltMode with 4 lanes is used. Then it adds the required
> sequence to point dwc3's PIPE interface to the USB4 Native Host
> Interface which I plan to submit soon to support USB3-via-USB4 tunnels.
> 
> Best,
> 
> [...]

Applied, thanks!

[1/3] phy: apple: atc: Support DUMMY PIPEHANDLER state in configure_pipehandler
      commit: a2fd3d1f4db720ac1deb477ce4811c5e4e60e5f8
[2/3] phy: apple: atc: Factor out the PIPE mux sequence
      commit: 8ca2e111117bf1d571f7c9de5d0dd91f5b770b11
[3/3] phy: apple: atc: Implement the USB4 pipehandler state
      commit: c319906aa47f8616019b01b1dd5c14eef293bb66

Best regards,
-- 
~Vinod


