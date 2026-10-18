Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D393B6364;
	Sun, 18 Oct 2026 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306718; cv=none; b=l4LDTediUqV8mPOWQuergyIth/T7nDFduvvXPpHJSob5aqSilnCjar5GO/lB9hZ3XmC9cyLhzPWOICzLthiMMg/GY/QqgV9Gh0ahqEqsPd9QJQP03i5WzHwuLnZfrAfhiT2QAxZ/AeZnJ1wIqpH216pe2BNk1eFAtXJCEz+6Mjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306718; c=relaxed/simple;
	bh=qvSAkfPXBK85nIKvwlaMA+P/P+Ie/Tb7w5MX7+TjJnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gg31J15/3Ov3PGRm045eh1Yh4lNA3azXMnQAbmwF2Zfr3UVa6pWFpXrdmNON0A9hSmDPJu1FEzTrtKw7/6uOxx+gxWHajKzX3a8B0gW7mInIwNrLKjbD6wAJdmjfwiQVhceJ61FD5VOIfDfd3jMrlf9hevO/K3ApvgVm9Q4okbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=I/5Iwk0m; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="I/5Iwk0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1792306386; bh=qvSAkfPXBK85nIKvwlaMA+P/P+Ie/Tb7w5MX7+TjJnc=;
	h=From:Date:Subject:To:Cc;
	b=I/5Iwk0mCGzuK1LgV8pHZe3TdxIJDUqXuwL09Ck+HuGsz3x1lR0e+g6/rcArr7A32
	 9DSaHKuUGE8QOwHiOICZuNEOl7fKs2QJLwB2hsAOgnFPpJr39hXjyf/YXLgdUliTcu
	 bVTURQVN4cXzA1VhUm/TIxL1z69lYPRlCxtt4GVBgvPXdXcuqxmTzOwFyJ+AWWMIjE
	 AF/NPX6CKOxxFnF3ix/RKCdCwjJJGWS8efiAS01UsxEM7FNoJ60CBQuE6E9uOmoW5D
	 iQTf+qqs3+tQ0ZJK1RL48CttfBwfo/0C400KrN/bghIaROkTauEJgEnWmC6Fnlfu2y
	 urw79LIx1l6bQ==
Received: from pliszka.localdomain (83.24.27.201.ipv4.supernova.orange.pl [83.24.27.201])
	by ms.puri.sm (Postfix) with ESMTPSA id DA1F51F5E8;
	Sat, 17 Oct 2026 23:53:05 -0700 (PDT)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Sun, 18 Oct 2026 08:52:43 +0200
Subject: [PATCH] wifi: brcmfmac: use ISO3166 country code fallback on 43752
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-brcmfmac-country-code-v1-1-54d7cbcce035@puri.sm>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ7CIBBEf6XZs0QgaNRfMT0A3do1lppdMJqm/
 y7oafImM28FQSYUuHQrML5IaEkVzK6DOPl0Q0VDZbDaHo02JxU4zuPso4pLSZk/NQdUeHY2OG0
 cHhDq98k40vvnvfZ/lhLuGHOTtUXwglXmU5xa9aBUZD97yciwbV//tg6OmAAAAA==
X-Change-ID: 20261018-brcmfmac-country-code-e942b4014e5e
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Angus Ainslie <angus@akkea.ca>, Kalle Valo <kvalo@kernel.org>
Cc: kernel@puri.sm, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=sebastian.krzyszkowiak@puri.sm; h=from:subject:message-id;
 bh=qvSAkfPXBK85nIKvwlaMA+P/P+Ie/Tb7w5MX7+TjJnc=;
 b=owEBbQKS/ZANAwAKAejyNc8728P/AcsmYgBq1GzRuycjVCSe47CjuTqsApGrZUTaMen871JOE
 9y4Zgq8yhqJAjMEAAEKAB0WIQQi3Z+uAGoRQ1g2YXzo8jXPO9vD/wUCatRs0QAKCRDo8jXPO9vD
 /9G3EACe3jCcyote0++9/dYWztHQzxQjX1s1HCII9VN7e9h1nCAm96QC0kGSTZAWt2brTz4DJwX
 T/qpnmKJG3Ch3pqnG8k5jD+QBhDlnbEY7q5JKC0IPLt+/eisFmFk5R7h63DbkdG3cqSpxjeVoxH
 8G8xLm4Put35d89Dg1Ndetu13c3XyJDJul039X7NTBn7fi1f8F+H333KakAr3LZ7QPSxVwyIUdb
 8zX8GvW+Cb58wZPXZroaiTXnKXLOIgVhiZLw+3LHpJi/LakPbFZ8eEQj91xamgjWZtQpu0FaZjp
 GOXxn2Vv0SZGSRLrSw93dyzMIlKzzk7Mw43fcc2rrPMmJRFMG45MhlI9cz4OtXaP1Pr1dqbulhn
 335F46D2KfnbOyI/Wsu1FXbrHY1A+ncHnXDBRgCHnSHH1xeRkS7wbngmCmdXDs1e4yebR04UOxK
 G/QckwnRIbxUvby46Dk7yi1XtZkgJ4kUXvkRr4lTqttnnxx9GdpeS4ljp4cmCa6DJcKY1J0Kbvy
 Yxx7StYXQ9QFn39j7uwgafShzsZ0xrp/L2NdYq6O31GiiTUK1hl7WqUntYbuJuUN6NP1XiSBFiY
 M2U6t07K46fYObf3lHBpGoRreyxz8SCclEADK5/U0RDc9SVqjt7IbHcIFM6+b7KAghUbR50QBkC
 MO/iPh3QtH697bw==
X-Developer-Key: i=sebastian.krzyszkowiak@puri.sm; a=openpgp;
 fpr=22DD9FAE006A11435836617CE8F235CF3BDBC3FF

Without this, the interface stays confined to the country set by
ccode iovar default value, which is usually 0 (global).

Tested by verifying that enabling the fallback makes channel 13 APs
visible in scans while in Poland without having to manually change
the ccode variable.

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 872c48806d09..bd6ac29a0471 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7973,6 +7973,7 @@ static bool brmcf_use_iso3166_ccode_fallback(struct brcmf_pub *drvr)
 	case BRCM_CC_4345_CHIP_ID:
 	case BRCM_CC_4356_CHIP_ID:
 	case BRCM_CC_43602_CHIP_ID:
+	case BRCM_CC_43752_CHIP_ID:
 		return true;
 	default:
 		return false;

---
base-commit: 32c52ec87d6245ee2d12ed5dd509e40062939b50
change-id: 20261018-brcmfmac-country-code-e942b4014e5e

Best regards,
--  
Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

