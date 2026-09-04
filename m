Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37444F472E;
	Fri,  4 Sep 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535689; cv=none; b=UN6zkDmen8Q+N72G9WcxPUH+1mA3jitXC1UJNWFT24cPZzT91WQSrgho7OLhirDpLYKID4zm/Rnx5B/mWiGKgC7nae2AkoUpK9v0fVjfwZ/JYV4eKDn2b9XQ5AYvOrM0D6t4gw01WPAJHzZih1/F5t+oGBPYJ/6VbC3hQT6HMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535689; c=relaxed/simple;
	bh=gDTOAP4aopR+lt51OjSkHEb3w6VUP1ti5rerP6KFqAQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=sMuPEf7LM3nDGhxB3Wo0zLpeEPokZQKiSnd544p1gkzUklZBCbH+WZ7bV00+eqZNIR9NmJ4H4GCE1wN4ssSVxKJMQk84Jyb6/BlvwJ9qcFvcS09TOsU33saf0Jye8K/JPF/JHQYEkSXNI194B2xgwNZbc6eOjvC8isG1k9LEHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zyYTGwQ5; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zyYTGwQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788535681; bh=Rv1dxfBRU/2ymYEmCjY2rrUT6woVMRWj+38UuA5GtEE=;
	h=From:To:Cc:Subject:Date;
	b=zyYTGwQ5th7g29vp6CLFWMuyDPVrTXD7NCcfWWjBa36BzIoGPxRNT3KR1r3cXRSf3
	 1y+zNUAbW+m7Pn3mnFC9XUkJ4RLjT7c4iv2dDM+AqQ3GJNeDZxaALUOtn5fadJCzMV
	 JzqO6rD6SO5SABLoEZDTs/S3Mp5qYu6D3Prfor9k=
Received: from xgyy.localdomain ([2408:8352:603:550:ac27:2fd0:a691:b668])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 6ACA42A6; Fri, 04 Sep 2026 23:26:44 +0800
X-QQ-mid: xmsmtpt1788535604twqa0vjmm
Message-ID: <tencent_9A525E0656A4F7D4CA9CFA1AB1A4BFC6D706@qq.com>
X-QQ-XMAILINFO: Md0EpfRTqfgWOA/YCY48b0rpW9CK12nMfBNbllc8o3ISlpNPeN6jo2JQDJG2x/
	 0sa9aDa6/lG4mNwa2Jpos3xembuYxfEpoxPYaMPMdWxYRGrbcBQNQjle0xImxnhRTooEeo4B/DsP
	 4vXaJbmZW8tdIlLO8He37UbzokexRnqjYBQ076BuI96MQUMtWjysBQtBTrVCe96hWJ0dza9fkulK
	 G4fMHHYdWJm8PaJJbJi34EpSWqOVmUwH5Otg9x1L9Nu9xbO3NnRTCVEQ8EpQqiwXzSLArj7e9veU
	 FvbFJddga2Qv6cJgZ7kk41EV+TxvVKnifCCMRxoQl9CAW7vsa0gsOSp7hN5KxhdwyR/JlT/fpstp
	 Rq0ZC7Ra8PHmWyv5nC4FE6iSE8A/w52knHSeKhydvALdVfRwp+GYvtuPQIjcFhjmOl+dXStpUVmB
	 FoA9q4DKaa+hXwOnXPUEyWUFMpESdJLt4I+DmXmV8jEoDBUCXNXjbevZVcZWEY0VVS5y9aZCr3p3
	 CwTNud9ziES/N84RlgBgMatZR+ix5/pfl0jQhL1c0ZBgcvyrWgFxdRMZwtHwbGKLz/gqV9pj+5C+
	 YrzQlOGmEwFpyYVg+HUdaxCyu5CEAz9YT/Ms2Xi9X+P8XpuUDBzE0jllEjtSEjvCsxwRPAhbj7Gc
	 Gtrbvy2T/llW5agvTCnJNThM2G54BEC/hy7L4jnS98e2FtpCsnI8CgLGseirEbiEXJLWi/LP+6cW
	 2STXwltXu92pYfwJJw232JAFCBHWtJG4uLVGDPnAUIvrfDfJr4y+WgvYHBPvwNdPO667ezxvTPdf
	 R5s4lJ7NshUWhAxF4n4E2j/7nrqqB4yYmw5ehwJEE0yVGu04t+Otkasn00h28vyOiiIvdEgvaYty
	 K1DVhBwFoMw+/sBWvxBWPsAwmXGt95WXu3d2mZmWCoCqn1Osnqk49lRKvpnWLj1YKPad9BKgYrhO
	 ZNO+9gyoORfEcAywbDwUJhN+qUzI9j4cx64GMr5b6ArSBscYAA5gMIFeT0LYErdPwf7yrXtovL6i
	 oyEyvZRuKOMlWs1boY58f68PKfW4Q8+WWhS8hV2MPmmFksIHtbHkz3CPIAnWjEgIqlJ4kCfSRXIM
	 qSks5uFiDfSLrjmBhwwbTxGcEMVAEUOwAPL1vtiq+AjU7Z0Ubns6Rpb+YwEr4vPIGZuoA2KvQOq9
	 WBx4HK6kIFeTEi8A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Zhu Ling <zhuling0805@qq.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	socketcan@hartkopp.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhu Ling <zhuling0805@qq.com>
Subject: [PATCH net] can: netlink: fix CAN XL PWM attribute sizing
Date: Fri,  4 Sep 2026 23:26:40 +0800
X-OQ-MSGID: <20260904152641.40965-1-zhuling0805@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_pwm_fill_info() emits the PWM capability limits whenever pwm_const is
present, regardless of whether TMS is enabled. In contrast,
can_pwm_get_size() currently returns zero when TMS is disabled. It
therefore underestimates the required netlink message size by the nested
attribute header and six u32 attributes.

Always account for the PWM capability attributes when pwm_const is
present, and account for the three runtime PWM values only when TMS is
enabled.

Fixes: 46552323fa67 ("can: netlink: add PWM netlink interface")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
---
 drivers/net/can/dev/netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 766d455950f5..0eac5a3f577e 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -780,7 +780,7 @@ static size_t can_pwm_get_size(const struct can_pwm_const *pwm_const,
 {
 	size_t size;
 
-	if (!pwm_const || !pwm_on)
+	if (!pwm_const)
 		return 0;
 
 	size = nla_total_size(0);			/* nest IFLA_CAN_PWM */
@@ -792,9 +792,11 @@ static size_t can_pwm_get_size(const struct can_pwm_const *pwm_const,
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO_MIN */
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO_MAX */
 
-	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMS */
-	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWML */
-	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO */
+	if (pwm_on) {
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWMS */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWML */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWMO */
+	}
 
 	return size;
 }

base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.43.0

