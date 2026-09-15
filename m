Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA99485CCB;
	Tue, 15 Sep 2026 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511156; cv=none; b=phXnFrdGO8NiluZ7HZbywpe1frYiiQwU78dMH+v7O2YaDW7Ibnnd+z2RUaWtw9jnckM0tQ/3D4Cp+rl5GxByith1EC+O5v2OHb/vEpQB6iX1eGPpqIBl17IzrWXTtBGbsOpNyE52+xURt+6qWf7yLpNPZ2XYe0/A6s8ZvYEllIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511156; c=relaxed/simple;
	bh=VZIygbDeKhSInpkJlp86QQMYBs3UwcY2IdgjnMm/luo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NVTuxSuSawbFf68HzrL6NPOAnV8eByJ6QUTaDK5D8MByk1qgb70IPrEQcujD51BRA0Ww4Un+571iGlCHxardNRHlq6pKan8EeAThzliMwwPjFTccvVrBgEVc/R/ZNtI0PNRNC2ReWaXtb2QXRucEIHSU8wMn7wJUcQ4Kf25CVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEMhXEdd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEMhXEdd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14C15C2BCB8;
	Tue, 15 Sep 2026 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789511156;
	bh=VZIygbDeKhSInpkJlp86QQMYBs3UwcY2IdgjnMm/luo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YEMhXEddj2C/nD/jzMInh4+EvkTl1m+nlJFNoO/J49MMC4WoiXtMViHJM2dZZuVn8
	 1W6LJGHUwfuo/1G7Lo3l4Cw4Xjro5wFgbp97SOX9s75GRpOkfSPy1i2XZzWWK7/Vvz
	 74aXo2w6qyJmlN/whS1ExsubOj5eSrnKLvlj8sFfOuDnIk1MOqyczAqPnhQ5bjjxWd
	 nikwra214RPZc4Lr7Ud+kxsyU3c2k9q+LsB0gTaky7taXfJEVK4tKt4C08vi5oQNPS
	 ks8FVTe/RAAiBtjFhOtd9Qx2sd+rchoHf/S7mWBnbeY6uLWR4/6xwE5UeHQx7fbEAd
	 F/pSuB6Y3sbiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E687DC982C1;
	Tue, 15 Sep 2026 22:25:55 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sdm845-xiaomi: Recent firmware needs
 bigger XBL
Date: Wed, 16 Sep 2026 00:25:45 +0200
Message-Id: <20260916-sdm845-xbl-mem-v1-0-6e3c88507997@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB0wQYP2KuJC40w7xVjJ2CKId
 zfa5Vv8v4NSFFJ4ZDtE+onKZ04weQb+1c9PQhmTwRbWFY1xqGOoywq3YcJAAY31rmTPXPcMKVo
 isWz3sO3+1u/wJr9eFziOE/n4X6JyAAAA
X-Change-ID: 20260916-sdm845-xbl-mem-12c64fcff8af
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Amit Pundir <amit.pundir@linaro.org>, 
 Molly Sophia <mollysophia379@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
Cc: Konrad Dybcio <konradybcio@gmail.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=VZIygbDeKhSInpkJlp86QQMYBs3UwcY2IdgjnMm/luo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqqcXyimET/iGGEG5mbRbG1KhPkybeerM2oIatg
 7zjQcHqL9mJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqnF8gAKCRBgAj/E00kg
 ciWJEACL8pVPY6lIDEYPoMdAZygN3sVA7hroVx+xUrCKDJF1IT/w4TE8vuYulkquzgBHSwbATfx
 fU9dfKfMH8DSELF0nggRDBCRXgKWRv/oDuDO0mpCjgNWHkISaB9EjoYYH2CceRK0qg7P9dBjVf8
 NGwpQYwW3Ce7Lc1QwZOjqkmRbP8SCqV/RXN7WZozzshUhZKByZATP7vxDOrS4knR2/SKDx1FKvT
 YFl52nU3vcix8+iHaWJBCQNjPZDpJGrs0iovjJj5KjbtthXZNIIkm74RmicYgwYE6MbszaH+p01
 29xse7M40PB2fIB8KcBvL3SHq1bv5R6YrSaDw7bD7877bwiTm283YbIkoNlv4B4D246PUwKcEgr
 LeQpKBvn5WNIXyWWBstANGamVkZbKuVgcylbudsWcnOSBrRh5HzfbDE1SCrpy5emFgNrTT7GXRj
 A0GiywxsKfktLs2BYb+s9nWRMzK7+b1oP8chZNSDlxYtLiiuhCc/eESDPkqrHXh/+/CjvPuKzZP
 R8g92xL9V95RMyO1zyoo6aSgT7t8qMIXZ6EyhKltGgKmegRQUqObQH1Pdr/cuwRzIqMTNWYxpX/
 OLf0ISOJqe1NznTTxgIcqxHAwjpvXaBjzsj2CAd6nnYTQBSQ1chBYare0+gnnZJE4exJrWjPLan
 DiB4+k7p6JTrVVg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

Applies to all known Snapdragon 845 Xiaomi devices.

Verified against the vendor trees, only vendor trees with smaller XBL
are < Android 9.0.

Needs some Tested-by, I don't own any of these two devices.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (2):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the xbl_mem region
      arm64: dts: qcom: sdm845-xiaomi-polaris: Extend the xbl_mem region

 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 6 ++++++
 2 files changed, 12 insertions(+)
---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260916-sdm845-xbl-mem-12c64fcff8af

Best regards,
--  
David Heidelberg <david@ixit.cz>


