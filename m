Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779482;
	b=ZdEoZLuDjGGacz9LeuNdz1eSQNIXtOzuTB3JwzgzMXpcZkpRNO03DwXtbIu05PtCyhtO
	 xfSaHwGWdu06xx4GRoVvGlk+6XyKfnH03n5Vjs9vJpxJKJQtrlCkv0SaGS0fsFUcfM+ow
	 izOZNgD8PJpUWsjPcYAe6BSWPgTsAW37Omjw8F1pfA9ioVPYCbEFoOc4MX7EYSyjN1nvk
	 h26T5yqsf+wWWSvNKRNnmEPjyVvvz7837v+CdEjAFbECIrAZIBJPwInNmxnwoEm7T9k0l
	 Z2kmhv5thG+fLz3HVDN21fu5rFDSrLagoPEUE4hhjz/vnHC8LTZYEmIUM3MxQHaBowQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779482;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SKvLV9gGAFbmLUUfmaY/EwUbblYGlJIfsU7Qw4vYhH0=;
	b=p0mn9moqSQSRlHEuUD4hVDqkMTwAWkKmJce4IJT7Scn2ElvqErKuoTUUOWkSd34JtrKy
	 TPmuTpnNxCBd9Gl7BY0U86hX14kS2yX7DNEkQ2D1yBr/hwkmgldx6vlbhvpQzk6iCr5Cb
	 2NGYFjZZ3lqToD7Dpw4e4Nj0/bk5OYkyDcFVvodeLGVZuBzB4ESSF8xgr1He7aaPsKIWj
	 w0DSIE2UuxnHJ9AxUMezfHPvSpscK//dIzGWVc1gtmp5ADJC/xXu1MxubCboDY7f14t7e
	 tpq3DiLVy4JDD1nH7PXbW5/MD3FTP74SVRvo8Veuu5BT3zGoBK6Sak1VgS/ssYZW4Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksVHr6FO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82606606A334;
	Fri, 27 Nov 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksVHr6FO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06691F00893;
	Fri, 27 Nov 2026 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795779482;
	bh=SKvLV9gGAFbmLUUfmaY/EwUbblYGlJIfsU7Qw4vYhH0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ksVHr6FOrjnzTw99X6BvVj0kvkAnLZtb/k30MIzf2UV5DXw3rvGcfhxMrrs8yinZZ
	 24mImNv0ISXZXlPLZG6Yitoxn3SXe3XAuie8089wVylTmvJxP4pp4QgYgMNkoF/3PE
	 CxM0IyW3QB9u+yaGh3AZX3ybpxu/wsbOLOgzF1e7zr5YHz8QnyM4slyvfdMTcKcKJO
	 06vQsHb1P4YespcEYc1yGohArWj9HaT7QTfgGGOs7WScwElrfekINtvVlf+BE6ls4m
	 Rj7tacZyPy5YAyHMnitu0SKZJB9LG7O2bCLqgBilCxRJQCD34LQlSIkXH3wum5LT/7
	 xzUR9LpNlU9jQ==
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
Subject: Re: [PATCH] phy: realtek: usb: fix the USB 2.0 PHY's port range
 check
From: Manivannan Sadhasivam <mani@kernel.org>
To: Joshua Scott <joshua.scott@alliedtelesis.co.nz>
Cc: Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Stanley Chang <stanley_chang@realtek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261103221441.1550058-1-joshua.scott@alliedtelesis.co.nz>
References: <20261103221441.1550058-1-joshua.scott@alliedtelesis.co.nz>
Date: Fri, 27 Nov 2026 17:07:55 +0530
Message-Id: <179577947506.3421.11993830398629700569.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=638; i=mani@kernel.org;
 h=from:subject:message-id; bh=9vNm3HiCCMKNQqyehmMLyhBFKEwiLfnCLd7GeztsIEM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCWuVmXbTvvWQmfQnxDa60Zr7MxL7+figYjcy7
 oENWz4JEXGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawlrlQAKCRBVnxHm/pHO
 9X62CACokLNvKoChF5S8oU8W12pOBBYIdXu3Lydn4eWkpsrN2j7yi/Ymv+jENIaIUTBgSazWVZa
 +L1JKpFbFN4undeQv3hNkZC7zWoGsqTgW6YCBBCnedEYb50F+zlF6mvI6e1lUOzdHpT6SiJIHo2
 WIXpchCFbi+nN3NbGQMHwJGdy2L7/lJpDP9R8nBqZm294NBNqCchxZDrG8AcvKfPTAY30y2NCP5
 qHTJzCkPo1FwgTB+F5TUEU5GNi8Nv6a+e9ZO/jyYuljsdmZFIv68Q0/pgC4PigfBFiHWO/+nTlf
 GGVf8GSg00eRGS/M3q0OlIAGV+bkgFIOKg/8Xo/sKJ4hYMh1
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-04 11:14 +1300, Joshua Scott wrote:
> rtk_phy_toggle() checks the port number before using it to index the
> phy_parameter array, which has num_phy entries. Ports are numbered from
> zero, so the check should reject port == num_phy, but it only rejects
> ports greater than num_phy. Fix the off-by-one.
> 
> Found by code inspection.
> 
> Fixes: eeda494542e5 ("phy: realtek: usb: add new driver for the Realtek RTD SoC USB 2.0 PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Scott <joshua.scott@alliedtelesis.co.nz>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


