Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D817493D24;
	Mon, 14 Sep 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409658; cv=none; b=eiIf4GJ6LbMKh/i8ZJygqzeQeXHe59nKmD6pNqU8cBvga/qgsUxbYtoVwampBfT26AwgDIIq+375Nn2u7l4WlrYYESlAF+0ofMYAEB92QGsMIPSYB4xk/ej9hEv37LOAqF6AzdAullP5sGaJL8nDC3QTA5uMMZnW63YQsbJL8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409658; c=relaxed/simple;
	bh=BzNNDlBWbA+colU9cHYIGrzDI7xXs6eglG9+G3j4eW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TTS3eDLsqNseURbrDAOZGYoYfOrgrjhOzM7aiC+v5j5QZmSg1+oSqeHfW/Aw6uHivSsBYCZXN0sRYV4WPSFsJv59bdV4rhjX4HsPbOaNmRItBTLqT+HknulE267fNyg0qsT89ZVmbAYzRpQxZzwlvrtx40BDNPOLo/8UjcLx1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T84nfDpt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T84nfDpt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0C76C2BCB8;
	Mon, 14 Sep 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789409657;
	bh=BzNNDlBWbA+colU9cHYIGrzDI7xXs6eglG9+G3j4eW4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=T84nfDpteI/SB1TA8C6x86hSF+uY2w9WHg+wOh6EAiPunh5vaWWn0awIiipKshEVt
	 5pwQ5COn69TJ7KvbGR9YN1IVb192pPdmFquhahKjQumZJydfo4/qf9y9jFj6XrAgTZ
	 54QJSajGrgZ5q0VyB5tdPvpQ3qXRnafxm9hUOqkgCUd5e0D70D4+eHW6ajKJLNZpSw
	 2wKVtvJyXthIgptDKaXjz6fr2ZciE+7noQZ+uZWwpXm55eprY2dgtFR3c0/52kUyQa
	 xtaMbOoOSZxj4Z/TV8fMsZB5oguMN9MBxORmDD9MOBLqtobk/uDDSgbeu+8lLQRjZv
	 1hd0Y6Gc4fcnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A46DC88E73;
	Mon, 14 Sep 2026 18:14:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 0/4] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Date: Mon, 14 Sep 2026 20:14:13 +0200
Message-Id: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NzQ6CMBAE4FchPbumtCDiyfcwHkq7wPoD2mJFC
 e8uxYMejMdJZr4ZmENL6NgmGphFT47aZgpyETFdq6ZCIDNlJrhY8Zyv4arbM9xPaKBQ+niiqu6
 gNHmaJVxkMpVsWl4sltTP6m7/zu5WHFB3gQqNmlzX2sd86+PQ+//gY4hBJ8YkqAqjeLalnrqlf
 rLge/ElxMlvQQAHNfkmF1JiLj/COI4vyqMPAggBAAA=
X-Change-ID: 20260908-qcom-wled-backlight-fd9574027353
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2302; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=BzNNDlBWbA+colU9cHYIGrzDI7xXs6eglG9+G3j4eW4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqqDl3L6sHmxx3RbQizlaqI6YKplobnHS/DSIcg
 sW1D/KZTICJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqg5dwAKCRBgAj/E00kg
 cszcD/9ERKvMkRVLn6ngBc7mKvxrcqi+6gNqjRnFXkQTvrusr1C6zjnAciQn5ey1ogPlr/9ANTo
 3+Weom2qtAdXqQ2mwOwCCJYdqu4Cu6X42RLUAqQFxlPhUxWd5Et2HBg5Lf68jWpVgl8hpnh4a/g
 P6hOzUD00MsvtBaYSRDTCyUwfqpEAFYnoxY2H9coTIQ9CKdv4hZv0Rir7cf6ojCjLL+qQ+kHoHE
 aKrjirirj02PKlFWCxFE3/MP7cDGLXAVq8pgbCNP361Fq4P74AGhopO1xUuOnTp4tlHtv77W7A0
 DbteXpyqVu7LSc7cJ3MeHnEVNSvdX8EUGgBC3hsOEQ/JUV2HyrKQDaRW1+NFU5AAY8DSXaTYiLL
 3AgM8U3BRxYziL16TvcRPbB/fb2gkWOcVExtcLDH7G2tscmf1f86n9J8wMUWgcCyWs0aLtTNBhE
 m57XpkLfwQKtqPrDDRF7Y9hqJ7PIexwWxS6ri+9JbQG+g0cL7cNJeEpciKyEamrO2If5me/e88f
 ugo0kX0++PpaPsOA1DnhzfOp+8pbzZC7C7X62a5b6tqqYbCEXeZYdK3L9mCy3pIik91ZzVeAsjn
 M+y+QBikj2EA7mw8gnvHx/x57bqJIGOfHYc74HLyOQ7vERR7yC7ndMIVwYF48S5zwWqBzN+3nu+
 OExcb3qi1qwy3mg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

The qcom-wled OVP interrupt is enabled at probe whenever the module is
already on, but the driver still believes the backlight is off, so the
first brightness update re-enables the interrupt and trips "Unbalanced
enable for IRQ". sdm845-mainline has carried a workaround for years and
Joel posted a flag-based version last October [1], which Konrad and
Daniel asked to be replaced by something that does not track the IRQ
state by hand.

The first patch is unrelated and fell out of writing the readback: the
WLED3 brightness register stride has been one byte instead of two since
the 2019 restructuring, so multi-string pm8941 boards only program one
string correctly. Untested, I have no WLED3 board; it restores what
pm8941-wled.c did and matches the downstream leds-qpnp.c layout.

[1] https://lore.kernel.org/all/20251021-qcom-wled-fix-unbalanced-ovp-irq-enable-v2-1-7ff115b4ffe7@joelselvaraj.com/

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Fix typo 0x10 != 0b10. (Sashiko)
- Added fix for a unrelated issue, but since reported as critical, let's
  squeeze it:
  Missing platform_set_drvdata() in wled_probe() leads to a guaranteed NULL pointer dereference in wled_remove().
  (Sashiko)
- Link to v2: https://patch.msgid.link/20260914-qcom-wled-backlight-v2-0-a908d9233e93@ixit.cz

Changes in v2:
- Add a fix for the WLED3 brightness register stride.
- Add patch reading the programmed brightness back via
  backlight_ops.get_brightness. (Konrad)
- Note the brightness readback is done in the follow-up to the first
  patch.
- Link to v1: https://patch.msgid.link/20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz

---
David Heidelberg (4):
      backlight: qcom-wled: Fix NULL pointer dereference in PM callbacks
      backlight: qcom-wled: Fix WLED3 brightness register stride
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Read back the programmed brightness at probe

 drivers/video/backlight/qcom-wled.c | 89 +++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 13 deletions(-)
---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260908-qcom-wled-backlight-fd9574027353

Best regards,
--  
David Heidelberg <david@ixit.cz>


