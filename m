Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08864F55B3;
	Thu,  3 Sep 2026 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456064; cv=none; b=kGgN6frfx/z3JjvgCHA//apm0nsAvjorM2a1BMJD2ZIEX5oM7vXBmBxi912JK8Z76h67IVLolkMCErAOUajxVs9O1t2A/fQZo+CR8KT5zMnlYEGhsmTTRaBKzVClPLCqM+lPGLOvWuxAb7keseY6lATARNguxbZYcQySt9/MIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456064; c=relaxed/simple;
	bh=OlEhQL685TTIXQE9H57dT5S/MXL5QMIPqFc/CvzY9Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUJP5x0tu8TsGixAzZHlcTt2KxObccUGmYM44YUzEBLOiL2ikzB4R3KrZEJFDvdKabQqtGjdnxJgKJqEXFQmOUlURjNxCLzmyeGo5ucmxO7MxJ0JT+pwyj7Bv+yOSJCZ+qoTFsTbZoayzclF1BUD7n5/ddkYw0XM+j2y9twMtEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3lyIaYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3lyIaYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8D11F00A3E;
	Thu,  3 Sep 2026 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788456062;
	bh=2KET23SjpUDYqvbEzqQjVZ2k8yfpGrBboFN+aHw1AVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M3lyIaYuh8i/ZJ94hLrKmDZlg+CK8O2b4NntvGkHQ7JO+YDN/U9+/oCLGXI5eKiJ8
	 d/VhyNU1xeEG6X1vPWjUzuKkxuk6nkSztnVCro5yqKvZp5eKBkk4lXaGxcWY5IN7c6
	 wwG9ijUqUeNzQ/Gr0kfT5nULTyi2CQ5k4PHBjNHGecRRWAkKG47v6aPvYmOUhOFcwd
	 sLWfoQWo1IpVK9nxBO/vWtwse+ngq0FroacCzSTCGRDrXXgCffhqWYN9rUzM3IHHPB
	 68r6eaLyBJ8mhCqsRlgSaxTFCMfiZTceeEExmKxT1pR8YLwDcvimisaj8dyjNZpZsk
	 LP5zXHwAi5oCA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Richard Acayan <mailingradian@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] NFC fixes for Pixel 3 / 3 XL and support for Pixel 3a / 3a XL
Date: Thu,  3 Sep 2026 12:20:34 -0500
Message-ID: <178845603578.348193.9876065764916660670.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902-sdm670-sargo-nfc-v1-0-bed1cbbffc46@ixit.cz>
References: <20260902-sdm670-sargo-nfc-v1-0-bed1cbbffc46@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 02 Sep 2026 22:59:11 +0200, David Heidelberg wrote:
> Increase i2c bus frequency on Pixel 3 to match Android kernel, cleanup
> the device-tree and introduce NFC node for Pixel 3a.
> 
> Changes to sdm670-google-common compared to sdm670-mainline:
>  - rising edge (same as for Pixel 3)
>  - split pins of the nfc-default-state
>  - removed comments and used right compatible
>  - dropped eSE gpio as it's irrelevant for the NFC part for now
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sdm670-google: Add NFC support
      commit: fdade6ed0b9e5b9f84de63c14fd747b820110b36

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
