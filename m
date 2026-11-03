Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706876;
	b=kOF4V0TaEKCJ4NcM4wqzUnjXwrdMRQBhJ67R98RF9ZFtTH2r7ArtOYSZX5eWgDj0jVqL
	 AU8UUd31yaTc5UtyG4MdB4GCMR6ys+RKtGUwF24TpivzIBcyWIGgcbM8jAZsSI/nQzcq4
	 CGNT0AZtQBLkQ7MGX7FXN3rbFl1TpUQ0b53CeOPfscfGdGegPwS+GF1ZVuejbsxGtRfk2
	 3V4wVi38ftDLwyMAxCutkb4A3x+V/puI8dktQ/IERMiNIC1csItOSAH0ReOh2CVNjdDAm
	 /YYxqoMKHETVB8qA90oDUyCuBMPW/68nlhU8sjuGWP0e9nahf4qeXn8me1/pwcUO7TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=gc7wGKMftdTOogN4WhTw2Z9/ycUPW2ITHXwzlkwoNwI=;
	b=L8aVeiKQyCuZk6Km67Gy0AuY+BOi/f/3Q2wjoFd/uSsQbhCfdzNfl2dPDyNMEGnL5OM+
	 VNKNeUR1E0te5KsCsRYlakqILNAeCTKQ/jkshbSdz4YlKrHwWNdTSnfZLcizFBRVfavg2
	 c+CxUAYMIWD/LcSN6vtJlUGGnxKiRyMxKBZ8Kcd34pL9VQrZIvBRgX5gdW+jVBi2pubQs
	 EaVVf+vX+B2KzXW2vA+N7T5FtM7Xr6NNWv1rPYJtS+QNqdAiXQOhssahAAsL6AzKOICEp
	 NxauKoHeL1RyZdGdlYojkZQqAHu+qjWu2QY5Ncy4qc7deffrhWbLcZJXP1gfB1AZEqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE83Pxkw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31692606A32F;
	Tue,  3 Nov 2026 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE83Pxkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EF51F00919;
	Tue,  3 Nov 2026 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706875;
	bh=gc7wGKMftdTOogN4WhTw2Z9/ycUPW2ITHXwzlkwoNwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aE83PxkwojHMZUiY6DMHWJE41PYrrLKBmdqNabN2stBxILPTl7ZG0jDEP0Lz1DhVV
	 oc3J7xCf2J+jfnkku50x5PHK4FZgtNelGaySovsEEP3Yx6DCYv8KwGji2m9hnLYvHA
	 Au/C37hIaALFHHohx1i5QKbAisSjRP3m/d1WohSwh8W3V0y5laLW7ipw05FeUnr+jH
	 rL0Wf2qW8+harCwvwy7hSwjPVzEoj1FbVnPIoalfLS7cSWpf6C56FM9EafAKYW0Z8I
	 SVBNbR1wCTgYMiXsemHWIvXwI2bjjR+G9iUa34l8JT/I+0GEVre+jqOR+nNbE+aeo8
	 /VMVNqmAmgCZA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Li Yang <leoyang.li@nxp.com>,
	Liu Shuo <b35362@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Dipen Dudhat <Dipen.Dudhat@freescale.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Reid Downing <skibletz@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] memory: fsl_ifc: Clear fsl_ifc_ctrl_dev on probe failure and removal
Date: Tue,  3 Nov 2026 12:54:27 +0100
Message-ID: <179370686157.132651.15818367772843670877.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101120838.36227-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261101120838.36227-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=krzk@kernel.org; h=from:subject:message-id; bh=7LIDX/5W2wTRXTuSfYOXB2HXy/WMlQUxtqUB4sZ3eIk=; b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq6ct0J2L+37YqOorOQTYQEe3V+v3j8AYDqk6YJ 9qyTNvLU3OJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaunLdAAKCRDBN2bmhouD 1+fXD/496OfsITvJo0gJS3IOfQS+ZpSfEcEpBC9znZma04PLdW0dCWxQnGAtQz9ro/4Y6znQ+V4 QnNJs1Uv3Brd9kXINuglRmbg68qQ/m8OaryJQINj4P7SMxs3R5YgpS3Stw7y5N7DnCknCgaprl4 UmWDnn4Ofs+fEstMEZnQvF+bpqAS6Bkn2PqSUHoiA66J4GrFeHMk9X0SYUlbt8c3xuvoAaulxhp qvZCnmPJa2Isx/suIRUKoDidcrcpJ115KsUxP2Qjo4hgoEmz7w/mye/SFvGgDoWSjIgXBjdG1RN KjuVnrWg4ehOsiigixO4Oj3Mz7Eg5Iz4xDgRgb8laH9rxba9r8Oi63Frk0+uwVyjed4/WjISu47 SIZIqf45mQ7uxDZGl2Dszgmx8zYX8KF3ANKL1uss/uqTOgSHG7E0BK3MbDUDTYEEAx3vGI9se9a 1E3cfSUWHbISDL7HFGfTcGNI8OV2yFadhhwqsGpS5I7GPWQEEVGjDECP7ik4YYdzmHy/KkRpBJk ZAsCqe8o2GFfuHnag9vnGEe31p6EJ6eoMKrQY/XiIjnNAt+MAVr2FWL7wpECICySBmZgjzPS72u xrhnzcLpYcVKvk0LrxD/uZLLvVb7okq0XNuivEaxbkmuvGwcWz81q9gv3cd4Nd7v3RnwjDyvxbW INlIPR12moBEf7
 w==
X-Developer-Key: i=krzk@kernel.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit


On Sun, 01 Nov 2026 13:08:39 +0100, Krzysztof Kozlowski wrote:
> Global fsl_ifc_ctrl_dev is allocated with devm_kzalloc(), so it is freed
> when probe fails or when the device is unbound, but the exported global
> pointer is never reset.  Subsequent calls to fsl_ifc_find() or probing
> of fsl_ifc_nand would then pass the NULL check and dereference freed
> memory.  Issue is mostly theoretical, because there are no users/calls
> to fsl_ifc_find().
> 
> [...]

Applied, thanks!

[1/1] memory: fsl_ifc: Clear fsl_ifc_ctrl_dev on probe failure and removal
      https://git.kernel.org/krzk/linux-mem-ctrl/c/a78ee2e05f7c7dd09e58ea615960105f78dc3c75

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
