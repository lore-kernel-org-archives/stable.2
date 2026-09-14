Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECC49B1E1;
	Mon, 14 Sep 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407774; cv=none; b=qtTy2x+NBhmoK5ChtZ4GHe5Oi4nFyK7fVshSenvJepQYQTI5D4oW6eSIli8BC85o/CKROHWvgqIw82b5JihAccFVwWpLnRcEqew0So6KDhGlPg7f1pEOKLTpGNmZ+AObpqXAsJQgmbm7CHGeYgRNj/+k1rJob58sjpQmXIpO6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407774; c=relaxed/simple;
	bh=PUvlkcnmJaXZt5p8As0KvIuk3AZONRe1vja4HE+7gb4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PROZ46hh8EpIsnCvg14JZin7HD2jgvw+ywoBghVxgjRw7ohOAFY01FmXMJ5oV2lJdAqZPfNzbHJhVwljR50ceank0SvsOGxStJSJgSKohtnbDCg900qQ/NgoJfh4MXjgG6gMoj3WkVk/PUXVF+lN072iIJy2Z6JOukiewZ9Mr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9GMkzQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9GMkzQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 016E0C2BCB8;
	Mon, 14 Sep 2026 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789407774;
	bh=PUvlkcnmJaXZt5p8As0KvIuk3AZONRe1vja4HE+7gb4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=K9GMkzQ4tXQnYcuZuo4qsEOXG8WXJfw6ehXpaMRK/ECEQ0qVPjdMj4jnVma2fyXe3
	 JcyHHoDM5nG/FnjgrOs6iOJQ8V8OljpIcYqZKkqa1cIkONgUGsQ/cOkm0ZB3Q3sKU3
	 K8y6SR1nPGhJ0rCjaJ9Lao8bNuI1ObfHycKP60LhZ7GDYX3w21L2ijbCN35LVYUWdm
	 6KOwVAq5RsA4s0BtH9sTKZrf/+eJduzrP9vOuv8Ib9mZj2eISzAZ0ghvTDWNfk2pKo
	 mwl+rCoha+9hhdR6ZdMuxd6/aWc5Nffcf3yf71ww49BzpopC3VU5cxRw/1OqyFxPbw
	 i9YbeJ2D1qF2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C352EC88E73;
	Mon, 14 Sep 2026 17:42:53 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 0/3] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Date: Mon, 14 Sep 2026 19:42:46 +0200
Message-Id: <20260914-qcom-wled-backlight-v2-0-a908d9233e93@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSxKCMBAFr0LN2rFCABFX3sNiEZIBRvloEhGlu
 LuAe5dd1a/fBI4sk4NTMIGlgR333QJyF4CuVVcRslkYpJAHkYkjPnTf4qshg4XSt4ar2mNpsiS
 NhUyjJIJlebdU8rhVL/mP3bO4kvZrajVqdr637+12CFfv/8MQYog6NiYmVRgl0jOP7Pf6A/k8z
 1+qgE5jxgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=PUvlkcnmJaXZt5p8As0KvIuk3AZONRe1vja4HE+7gb4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqqDIcJVfrVXuYj/bpDoKLOG0YCDlIZtHrntKuG
 wxZR0f1JvmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqgyHAAKCRBgAj/E00kg
 chiGD/0RSVqrVoapWgon9AH1/YrrdXUVhs7NeYk97yKba4FByYxmYxUxhEyFzw3Vs3/3n37ezd5
 k2EB62/9RJUxQLTsJmiOheaSwYwBMC9NBAHUOP5FJponINw0xDfpigHOE0im7qnkzeBU0BAORH2
 EpWkzpwX6fitA8wVyeaAvN3X8XLAiht+U9aDQSlhjIhwTG6vWWdftMwPfS9OoN/7sDMhHrMysIV
 o16MmdHmD5v+gDUMtQC/UIZllBlXXWXcdb4Dt5E5znCnXQTKa+TVZhuo/ZnGB+W0erezMwl69qE
 RGMBW6W+mEzz2w5ZPO/2kjud/WYYfUFJeqBuVO13c06VK17YOa2oTWunhbAEW8rHgaGouxdCzQa
 r8gs2Q53wye/wJQKy+Nh+mfMhGo3SUiU7s3nBD8sB9Wuf+hUwhay2Hdf8FfC2A6KcK46utsg6Dm
 l/9H1iVQhgmiixrAZdJpDnrdn30GAvpS/dGdUiFZfrjom77pmuUnitnaaHXDM0oLxcn3A31RGSw
 eur/3WTXv3hhTjn3Sc8R0XocFa96rLXn/86Zxc0pC5XJ22mJVy6EBHmBQOrP9f0zm61IlH/VNCO
 2aJZ1OqRbuEAb4Zgo2/vek+YjIk73WC92wo4t5rI4Fj3KE1BM3qGSzEx5/jSThRKd0qnDHmkYJl
 ZZaJZK/5nolyKnQ==
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
Changes in v2:
- Add a fix for the WLED3 brightness register stride.
- Add patch reading the programmed brightness back via
  backlight_ops.get_brightness. (Konrad)
- Note the brightness readback is done in the follow-up to the first
  patch.
- Link to v1: https://patch.msgid.link/20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz

---
David Heidelberg (3):
      backlight: qcom-wled: Fix WLED3 brightness register stride
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Read back the programmed brightness at probe

 drivers/video/backlight/qcom-wled.c | 88 +++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 13 deletions(-)
---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260908-qcom-wled-backlight-fd9574027353

Best regards,
--  
David Heidelberg <david@ixit.cz>


