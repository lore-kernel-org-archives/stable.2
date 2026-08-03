Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78D430CF8;
	Mon,  3 Aug 2026 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782062; cv=none; b=heDdsLMY1FCbZ7Voq0RHpdQuirArKWKKejqY243EpP95PjAdCI7PMiVQmFAdXcT1bh2Cl6gB6rOKZK21hQ/u9FPskk14lQI4sWy5jmfR7TDtqspeoVME7o3AzY6TxdL19IgyZPEMV8mFOnvJ77wvvZlD+1t7QYSHAA4H4fJGOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782062; c=relaxed/simple;
	bh=LwtbQ4x0I5KiTBxBJqePSCGBv5wKNrfXEbzeV3Y+QqE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OfL5rc1GDF+1Kz5EMgOknPZr8SJpgtAibsT+r6Vw0OXvD5JZCmqXqQ6GTSja+pRWtQDTdzoB8ArbRjc6X1D2EffcZAT1k6HfgswrqRvF3kEFwL3Yl353+d4Fitid1SWYn+otB7AvZ563dMtEvufJiQTnsKlr+O7DpD3XoqokkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYtKSboh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYtKSboh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAAC1F000E9;
	Mon,  3 Aug 2026 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782060;
	bh=rU079syS0fSmf7On9+3DESKMDhK+tUSmUPZWbUaCm50=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=AYtKSbohAoOWgNJOKUCII/3Bx+NlDQm5pQlG8U+A+kmNrTdJ/6KPjVFTm3yyGOd75
	 gZK8hQAaCXuaT7hpuGc7sTpYkClxijbqGdJs5olCeUPjkB/ZQSd2SSgvERA+633JlI
	 f993RudvvgH+w1yPH/+0Mfr1u246qUF7F+hhEl0kv5lVylNILrGQm+KgiHrACpzWF/
	 S6Hy4yUd45TELZhNXWPhxvUZjORCCYMf5DG46nMGEm9+OwX54lSa4ILuNhGAZNeMMH
	 szTO58rghjVvaiJtuek/YRE2nUv+mXraor0NniishBdl1CCVbNSrf8PW9XNyrpxeon
	 P3r33mkCj0djA==
Date: Mon, 3 Aug 2026 20:34:18 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
cc: djogorchock@gmail.com, bentiss@kernel.org, linux-kernel@vger.kernel.org, 
    linux-input@vger.kernel.org, 13667453960@163.com, sashiko-bot@kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: register input device after capabilities
 are set
In-Reply-To: <20260730101506.547340-1-yijiangshan@kylinos.cn>
Message-ID: <np9784o9-856r-977p-03p7-qn1o8s537n23@xreary.bet>
References: <20260730101506.547340-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Jul 2026, Jiangshan Yi wrote:

> input_register_device() exposes the device to userspace immediately.
> In joycon_input_create() it was called before joycon_config_rumble()
> configures the FF_RUMBLE capability and the memless force-feedback
> device, so a concurrent EVIOCSFF could dereference a NULL dev->ff.
> 
> Registering early also means the initial udev event lacks button and
> axis information, which can make input managers ignore the device.
> 
> Move input_register_device() to the end of joycon_input_create(), after
> all capabilities, the IMU input device and the force-feedback callbacks
> have been configured.
> 
> Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260730031927.25444-1-yijiangshan@kylinos.cn?part=1
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

