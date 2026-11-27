Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795233;
	b=RGV5TVb7uhXtkelvO7Hw7AiUUVWAcc+Sva0jv2YpFkCxmJVcCWwrfw4VN2jdRj4kkId2
	 38ErmoidaXpDByrAwfyIK3u0D+eoA/ZJKVlF50CHMgcxL/lwia0k0o3dXhtXFPWl6dM3C
	 5FasmqMIDmvT8SNf/YGeNS60ma18KhxFH8rr8JeEnYbSZmaGlzBEF9Axtk586YcfrYk9a
	 HTjknaHIrAPCLbkVRZJUnQRRM+GwzakvWodemCjgkU4d79GvRp5Bu4ZLx/iFmCLzrSpEJ
	 qEh3wRzkPTvAzUiBLs1YvpaDAUIKFij/aqAejvE91/Bzo+bC0Xso7MTcIFtvwZ6/Zhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795233;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hdMQHOynBJNwr8LKSNm2gWtwDuDYeFA4vOj21hSPcy4=;
	b=EegwB6/XuMZXJ1xBLdtEreSDMkiueCc2Zrqf/gv+FmbiqYobbZDIa6uD3yN4IjUPsDvW
	 vOCyXfwISqZ4rNFQYaJXHoIrALqABh4lW8qEnJHIWzRZPTWkZYKszno//inH41MWkXopz
	 G6WTGBw2F5leiS2wWgl7vq80cuI5QIWlitNmEU1WnkdPecJDaxe6pR3bn6FKMr1r/1lFq
	 EocsrghrI/c4Hw6jrj3ArMIyCeNizEIzoiRpy0Zi7zV6Gf/DD4QoJsxSH0nhZl/yD/w8b
	 19md8gZq4vb+/iS53Y2aNTiTKlFZ9TPXPyqmUuO3XZvruqBdO73Fip0w0WI5er+7rgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cvx0brI8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC07606A334;
	Fri, 27 Nov 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cvx0brI8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112A91F000C1;
	Fri, 27 Nov 2026 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795232;
	bh=hdMQHOynBJNwr8LKSNm2gWtwDuDYeFA4vOj21hSPcy4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Cvx0brI8+eNOiW3gWRyraep3Y/dVyJDu6O86uz1ZUmUXSEjdn1AmwZBDIF1PHduxl
	 4MGiijFvLGtGXHdaqsamDtaWLJQkUOGrlKqh8trw5PQ+s9Dbl/JYqR+/fdKQk0b0s2
	 KnybaUqfiIABt1sP3dJdB44eAoqCasFMFcB4/XhFIPudWAqDaAsG7gw7hFAiwi9C14
	 U4fx2jPJ0xHFsJbzwOwePf6JAj87/W+4r9MYKdrhhQcmzH2YpuFTELDu5v/WcQKQ39
	 fLjDqLJJQHtZPYZpElGGRx0riQMasjnpNImH3a4Ocl31+wcvvrZfpRO3WZxxAGvEah
	 C7Vo/sFppatUg==
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] phy: exynos5-usbdrd: gs101: re-init PIPE3 on
 orientation change
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, RD Babiera <rdbabiera@google.com>, 
 Juan Yescas <jyescas@google.com>, kernel-team@android.com, 
 phone-devel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261119-gs101-usb-phy-orientation-v1-1-bf3c4bbf328e@linaro.org>
References: <20261119-gs101-usb-phy-orientation-v1-1-bf3c4bbf328e@linaro.org>
Date: Fri, 27 Nov 2026 21:30:23 +0530
Message-Id: <179579522342.13164.9446157230497523223.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=mani@kernel.org;
 h=from:subject:message-id; bh=NADammu9OSZGhY7/SbAUT2FBnMbQq7XdjmIflYFSruI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCakaht52+9QaiSNtYMVLe3tEdYBh2LRAxyq5Z
 32P4zoSZIaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawmpGgAKCRBVnxHm/pHO
 9YAzB/43msrN6YWdU/FJqkxLHEmi/GYqmazI1jqs582mdp/P1bOQvoQeSc0fvbJpjiFZ9djdcEb
 Bzr8S4ufGnecXJC2yi6XJma4ZATNorF3Dx/yO2m59aZefHMgrKcnZQweKd2EEHHQYFmBCleUsov
 KRw7L3+gShJ7yQ8aUABhEgan1lTQHOX1UXV2QCyk/nIDg79h7szJuPaDyw40lI7VpXIb+XgXm0Q
 EqsW4JluUljcEMqH3AvhM59U8aS3KGc5ieIrIy1FVm3PJfafx/FPFpa7QZDGy/b8SrNdHr4G5MZ
 qsqhMY5NVHTo42dlsbkZlkCwBLLvGRc90QDEghbTVd2KRmVb
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-19 19:18 +0000, André Draszik wrote:
> The SS lane mux on gs101 is programmed only when the PIPE3 phy is
> initialized, based on the Type-C orientation known at that time.
> The orientation switch callback just stores the new orientation and
> relies on the USB controller to exit and re-initialize the phy, which
> only happens if DWC3 enters runtime suspend.
> 
> If a cable is connected during boot, the phy is initialized before the
> TCPC reports the orientation (e.g. ~4.0s vs. ~5.3s on Pixel 6), so the
> lanes are programmed for TYPEC_ORIENTATION_NONE, i.e. as if reversed.
> DWC3 doesn't runtime suspend while the cable stays connected (and
> runtime PM is forbidden by default anyway), so the phy is never
> re-initialized and the link comes up in high-speed only.
> 
> Re-run the PIPE3 init from the orientation switch callback if the
> PIPE3 phy is initialized and its lanes are programmed for the other
> orientation. Rewriting the lane mux registers alone isn't sufficient,
> the link still comes up in high-speed only with that. Re-initialize
> before signalling VBUS valid, so that DWC3 only sees VBUS once the
> lanes are right. A failure is only logged, so that the TCPM still
> configures the USB role.
> 
> Mark the PIPE3 phy as initialized in the same critical section that
> programs the lanes, so that an orientation change can't get lost in
> between.
> 
> Also stop storing TYPEC_ORIENTATION_NONE on unplug, so that the stored
> orientation always describes the lanes: while the PIPE3 phy is
> initialized, they stay programmed for it, and when the phy is
> initialized again after phy_exit(), which gates its power, they are
> programmed from it. This avoids re-initializing the PIPE3 phy when a
> cable is plugged in again in the same orientation and the phy stayed
> initialized.
> 
> Cc: stable@vger.kernel.org # 6.15.x: 2ef1e78ef722: phy: samsung: usbdrd: propagate GS101 PIPE3 lock failures
> Cc: stable@vger.kernel.org # 6.15.x
> Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notifier if required")
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


