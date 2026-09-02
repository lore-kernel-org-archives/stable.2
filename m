Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49B3F0A9E;
	Wed,  2 Sep 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382759; cv=none; b=dy8p0lp2k+zGH2b58dlMj4C1pOkHTF2xwt6fLWVu1EsydKn8c5t5gpUxmDWypb20NkDO+wN31ycbCb3toyuV6UmPtHT2jv0nZeolX1cF0soNFWULMEdY+5POy63KW3aNEFKGqGVxTGD636jdZGZqVSJ4OM4r02P/G+s1OwDWqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382759; c=relaxed/simple;
	bh=2yPq24tA6YClNswDNkTds3749+YzYZnAHrZJEVgmSRo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o+7IimLIR6NoaIn/83xAEyh3Bl6gioLVq/cXtQoAGI/VSbk5t1mp8qPv9CIjplot9yWl3AHXj4AXY9Yeb0nNZW6rwOQipvVwmSNpyW7Lwz0FlsHg6Ao57gNL4w8Ao07pUOT9wVB4tiMOroYYkqPKZirYQg1xxMHsiYK2JU3oSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGY0/UN4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGY0/UN4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DB7BC2BCB3;
	Wed,  2 Sep 2026 20:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788382759;
	bh=2yPq24tA6YClNswDNkTds3749+YzYZnAHrZJEVgmSRo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QGY0/UN4Jw5kQ0nJGtNe5SWgcH0dLDJ37N6Tk8nMHnQ/D1HfjB60AFveJ2ohyDyrM
	 hdwR0ReaWr74HYjARAdCVybQhoe0Nlg06N9z21iW0rk60CLZxDq7JPAQPcPvEuQeqD
	 re6mGAXiHxwO3qXGMNTqzA/AbA9MPcGSRoqxAWVQYD3eHQno5H6suSEwEEgLrSDpCX
	 81UftXxA8InSCATklsYx4AZZWQQ0KoyviUy6zZ6OrnF26QajhBqAHzYKkwLfR8cFvk
	 leo9eGS4dm3vPlYvNzju+2d0HMjDHt2IifUk6vsTZFoJ2clHeYcw8HNS0KjcEUtPSO
	 VJeu+/zPSoYvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD99DC624D3;
	Wed,  2 Sep 2026 20:59:18 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH 0/3] NFC fixes for Pixel 3 / 3 XL and support for Pixel 3a
 / 3a XL
Date: Wed, 02 Sep 2026 22:59:11 +0200
Message-Id: <20260902-sdm670-sargo-nfc-v1-0-bed1cbbffc46@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDsQo8baq0gXJk50CkbJWBHEu
 zfV5Vv8f4BQZBJ4ZQdE2lh4Dgn5IwM3dmEg5D4ZtNJGPXWD0k+mVihdHGYM3qGtGm8Lqk3pckj
 ZEsnzfi3b92352g+59f+B8/wBN2vVwXQAAAA=
X-Change-ID: 20260829-sdm670-sargo-nfc-b59fb3e764c1
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Richard Acayan <mailingradian@gmail.com>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=2yPq24tA6YClNswDNkTds3749+YzYZnAHrZJEVgmSRo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqmI4kVvZaT5aEgyznsdkdHm7RGxkfbMrIlMbdb
 VF0rbN2zySJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCapiOJAAKCRBgAj/E00kg
 cnQ2EADPSTvuKtaTyYYEb8gtS/W4rYt9XCqpwYQK/U+0XURknWZemdKvl8OPrZVjE2rz0pdM7uS
 MxKV2qhjMRmlhJp0xR1CxPEJ8JKu0ZgmWkEgsht656KrB9lUyzOROELkwMR3Y1D5wttg+zAbBYM
 SWvzB+V2ZsZLDpWR/zcsJoXcwnjeJ1qRdQWPX4tG+bXSDv46NJpMN0h2BAubVeDhP+l4AymfRmc
 M/f3nGrWO+o3k9PYqOm5n25+4bK6H4VnbePjMgc+uoDBlF2xXR7HBzzkbZQyJ594Hqfq8CT2sGm
 TX4GsIGTimmmUhQSBGUbq46Ycm5o5wzsOr2PyGc9Pfekux29rmzA+Ew9kVJB+veVsmYQsxRyf3i
 Ovr/nhX7amumzeUNpNN3UTOLJKW/GSkMJx1nB6NWX7RkDb5lKbAkdhiF/s2Yu6xkRzctW8OX3I3
 51zPaxa35FtpxsiKY5y6c6GzdAIUzVXu7n+jLrnw8fn+h6Txc4k1EMpVYVy0sAypaCFPtKB4xnQ
 jL2II1HVn9d0bGF4wD5exdaoacolffuTOEvaochv87RU6NJVvRLJAg1n7DglyXfMv6NBiSSQrvW
 QrxwpUMu9WzUwWBD/6SB5EDu1gssm3B9z6zcyLpDWv/AigNsBfql8uCoK57OHtvoFmY5FLU8Df3
 TbPvBk+m70rYO5Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

Increase i2c bus frequency on Pixel 3 to match Android kernel, cleanup
the device-tree and introduce NFC node for Pixel 3a.

Changes to sdm670-google-common compared to sdm670-mainline:
 - rising edge (same as for Pixel 3)
 - split pins of the nfc-default-state
 - removed comments and used right compatible
 - dropped eSE gpio as it's irrelevant for the NFC part for now

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (2):
      arm64: dts: qcom: sdm845-google: Set i2c3 frequency to 400 kHz
      arm64: dts: qcom: sdm845-google: Improve NFC pins description

Richard Acayan (1):
      arm64: dts: qcom: sdm670-google: Add NFC support

 arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi | 42 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi | 36 ++++++++++++-------
 2 files changed, 66 insertions(+), 12 deletions(-)
---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260829-sdm670-sargo-nfc-b59fb3e764c1

Best regards,
--  
David Heidelberg <david@ixit.cz>


