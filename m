Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29B376481
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203711; cv=none; b=ZSyYQlG7srRIlj1L2M1/TfIL0pPfSaDKqawz5iuTOnKy5FsSgBVlN8afM0n12qcsEU1E1gmeljR1axa1q2wYMPjwsURTFwJYuLmA8mLpQ0WCHuauJbwWgj6OgioVKc9CFjq3X1ACrti8jOAZFeW0/H/5bQc8SDD0mOy0aePWI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203711; c=relaxed/simple;
	bh=Z7kFPgQ88Wv2Xf8E4x/R5vvxXua56XhG0Lj1CxJOuUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+CgCOmyZkMCKucZyYLSlTZIe+K91Y7Dz8kbVpleb6U8T9uiG8Ru2PB+odjXqeZKBM4BU0qIVwwgxVN5RCfY0xLQl+MEn/IpxrCEVD8dVZQCHGFJ2HmfK0zshR22EU9l3M4E/tr4lwygzYH+BF2duuNc84TYlXTQoFwklxsx+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea9HuC5P; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea9HuC5P"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso2924864a12.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788203709; x=1788808509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1yjLc9wE+XWjLLJII/RbL4oTPqzzDgXzF/PpO/HPdQ=;
        b=Ea9HuC5PzmRwm5Nai15zSaxspwUNEZtcMtQ6ihkINKeZIn6BHLCVixZQ+Vywxhyg4G
         D2EHvafQOXq5QcJ1aoKigD8fwWthAPvIr2IJCgmohPRf4LS6wJA1l3p6c70WHE1Z9yPl
         VYc9sYTP8MExddqq8lLnJ2xDXQnoCXlPy83H+hW0ipEzNTlbioUTzSpnXAsQxjR6QuIe
         VVW1bM6Ea69W7c6dz7c0ZiHjrTU/0TnhMprEBwWnhYWYESh/ZrpwSFti2fgh1orl1nHl
         zDGyALKwRuPKarEeEm0fKYaUMIk/fBhOYrFAsGck/TqeRveJp0M2tmBHN1kK0OPj9QQ9
         Mlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788203709; x=1788808509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1yjLc9wE+XWjLLJII/RbL4oTPqzzDgXzF/PpO/HPdQ=;
        b=QMrg1uIdtqAP+ZhqgVvhPYA3xaoLzK/8XT8QEVxUfn/u478l4Ut4QB2HjVL/rBb7EI
         a2hOFvHIqUWM0JGiEv8kQP62QVYFs9nBTCYHyUBSq9xP+N3xx4K3z0UQju8Bts1BjsZY
         slo9v35RHhSRs/GfJ+sMMlTmgzvMAwQHm4vXruaDW4i+xxe5iB5Pjmhrh8Er5OnDVAKZ
         gZtYTZKc2/55ErnvCLLq5t2A6UlDQxtprdVQIbAo+NtVbUJq8Js5yhG7omSzmc2HOtaB
         Be92+Zy5SV/HburSD2VKChcrlLUV+8YLlqNdFSSEmn6ISHxtKDaOTJ+n/TbJk4Qg1HQy
         j/ew==
X-Forwarded-Encrypted: i=1; AKwUvBy3m9buT4U8mtAz8pSPfC1k7tGWP7YGdJa+cokA7Tao+k1pTzOfQ4O5sl/UX3bGarrNU6XJXZg=@vger.kernel.org
X-Gm-Message-State: AFuF++mq3MFVbVPNyv8JHL3bP58FBZ/jOYzFIN1KcMrsveSfv4GLocPL
	hN+Owmf1UvZYa1rA50V3Wu+1AAsdbG77H1TsGr9/pIPMNjaEOATKivm3
X-Gm-Gg: AYBFou2aTpkI+qbEL/Ku8xA9WizRo5X4cgMCKuRKOZ0sNoBbuPJgjinne1aowcPjjNF
	KuarJOezscwL++sH2PFBLnxSoNS88lFqoORtLPQofFQ4a0x4aLLBc+bZzhaTxNpzf0bnG5e8XgM
	7SWT/gNLyhplIpr0VyqEzYbrvb1CxGU6NiECY6hnFkg0+RZPM8GiJOqdlbvrxO7Ld97s6Bb2D1d
	WtuCT9CRRbOnnoexgSZTjCxQ8iemxcP+aDrtsjAZV0Az1yWnVte9mH1nFFOru89Aac9HY1lMxmV
	fjjyAwkN+fByXb4NisFOIs3mb4QBQurplKKo6RMlm+L+qvpl86jP+kePHy0LZ6bTZwI00M667E4
	5p0OK2q9fQN9S0u2fpyI3yiaMOaVHPRmr2rUyU7/QLlwFErMsUbXLUdd5N1PU4w5PqncRINu7yn
	8LUGDsedDV5HVp/iQtTPMA/8Jz9TLEscSn9AseZU36BBWReSQVbUnptRdqpmJ/Sgy3wFMHTOlrV
	VxaWIisTNQl/LnuP2nH
X-Received: by 2002:a17:90b:1d4c:b0:398:ea31:2474 with SMTP id 98e67ed59e1d1-39907b5cd26mr4101952a91.9.1788203708934;
        Mon, 31 Aug 2026 12:15:08 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1dcfbsm1110665a91.2.2026.08.31.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:15:08 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pontus Fuchs <pontus.fuchs@gmail.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	co+a27ae3497f0074da@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: ar5523: reject negative reply lengths
Date: Tue,  1 Sep 2026 03:15:02 +0800
Message-ID: <20260831191502.3321906-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reply length is supplied by the USB device as a 32-bit unsigned
integer, but ar5523_read_reply() stores it in an int.  Values with bit 31
set become negative and bypass the existing signed upper-bound check.
memcpy() then converts the value to size_t and overruns the command's small
stack output buffer.

  BUG: KASAN: out-of-bounds in ar5523_cmd_rx_cb
  Read of size 18446744071562067968
  Call Trace:
   __asan_memcpy
   ar5523_cmd_rx_cb
   __usb_hcd_giveback_urb
   usb_hcd_giveback_urb
   dummy_timer
  Kernel panic - not syncing: Fatal exception in interrupt

Reject negative lengths through the existing overflow error path.

Cc: stable@vger.kernel.org
Fixes: b7d572e1871d ("ar5523: Add new driver")
Reported-by: co+a27ae3497f0074da@bugs.sh
Closes: https://lore.kernel.org/all/K9HvthWDvq4gyjBVMeGsnsvA26mYMZ9v4gW7%40bugs.sh/
Assisted-by: Claude:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 66ac396858a5..176e5de6a64e 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -73,7 +73,7 @@ static void ar5523_read_reply(struct ar5523 *ar, struct ar5523_cmd_hdr *hdr,
 		olen = 0;
 
 	if (cmd->odata) {
-		if (cmd->olen < olen) {
+		if (olen < 0 || cmd->olen < olen) {
 			ar5523_err(ar, "olen too small %d < %d\n",
 				   cmd->olen, olen);
 			cmd->olen = 0;
-- 
2.55.0
