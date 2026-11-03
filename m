Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698327;
	b=efdp2zZNb4D1atoR/tK7DSrQbc5fMJU3ehW3sSEjI77DYLcxcRhQPLzeZsMpW+sdokiW
	 xa28FAZI0sZiBLTd1UeYmraCZyw9MSVsssQQYdt75ZEM853KgHhSbyk1wRy47+ICl4kHS
	 DjPkvuKOKnqKjqBOrZFSXTh5MDk/6jA4WONIK+nRp/X8oHSCFglZH8n05F048PadPIfVz
	 QvOkWuGAK/32m0gVX6mFs6iDYnSnM8D2LRdOZ4pjpsRJdhrAgKyj8XHdwCWM1JK9Y1+J9
	 epZVY1/xGBvI9VsdB2Qdn1BaPHXzGwO5gE3ktluynuBnGxz7B+DD5JE8uRdHLoKwgbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698327;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=svEw9j4vz2XAfPUeGFTk6zzUJwNy4pNLV6jlNwXVwUI=;
	b=kjH8LpRJJltyrZZc4Y/+hBJe8SrNyDrpRlT0ePRPwFYlVOeWKiraIfiugLuOCVHoKEB3
	 +20EObdbVqovHbuiHilxv09N+jIgvkcRRwAADTUM1IgFiRrqIdX16cG4nshfyoIzDVlWs
	 yCgCGUznADYmiKe9vsoCNwOl4NomW8v3LAZEdjRpIWprofQNhJ0ltChz3buMqRjhROb9y
	 AF7e/kPPC/nqkVJWTSwp7nh1hCnetQ09mkGKk2Ep2rxNGPmLd/yFtzz8oXXWj0xqeyo4W
	 oITPh/Spvz0E0+a8Zlm4TO1EXowZl7tuZ5JE37DK4XERwr1h/lZacF2uKpzdxEoIP3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=nkB0Z9Yc;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E9606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D2E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=nkB0Z9Yc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1793698275;
	bh=svEw9j4vz2XAfPUeGFTk6zzUJwNy4pNLV6jlNwXVwUI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nkB0Z9YcNQ0z3XIdWMbOKTscvDFEQzATTVXB0z1t+ecTbKiZBdgAyu7wgT3XPwJg3
	 /izoA75IE2n95bO26eQT6hb5p2I0xnqfOSGLKiQrahk+OyEzBqASw+W11SaBHmGT8f
	 7L9X2NYqtLmQ30GFvqHqUEbu8wJi3CTnPoA8Hg1s=
X-QQ-mid: esmtpsz18t1793698257t14d9e1d7
X-QQ-Originating-IP: OOgvOriFHAKnAxK5krETsc6Q141AK2pojOa9UxUR4us=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 17:30:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1873500742947398579
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 5.10.y && 5.15.y && 6.1.y && 6.6.y && 6.12.y && 6.18.y] x86/ioperm: Prevent NULL dereference on theoretical missing IO bitmap
Date: Tue,  3 Nov 2026 17:30:47 +0800
Message-Id: <20261103093047.571626-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MPAlP4yRn0xgT4MtLD/FFPD3ImwXQTfsDrYZfCQOB043521puDvLgHs6
	I6CFkvcADg71Jyu0H81o+hg4YIB6JqyQlG+zBf1yv77x6KhSP/tsKVnqupidEyFl5DHeINn
	QZ05KsvghDxOP9+v4tFflEQc/Pm9BEj7Rg2akToqVqkK0wkgGjKdpWqEjU1kpePKop72acJ
	RfJPBHKZAzwY9CAvhXJiEwjqWqsQKw+qGzO84x2SCi1NGq85Fpp7C+lf8FoQSPmjrYEPIAV
	AB6jdf1kwpXSnsgNn/O3J6Nb4JiulohSs7HPNyhrhLQEkLyuBj1lrQe5t16KbSaJHdmXk1j
	2/fdYa5+C3ePmMIh8roEWkBEsQpF9x/0yWNeF683LbPW32/RuR3YxTycNIHox6/jXw88za3
	MMm9sQpNTJUDmeMibIp0hXZ3jZ6sxzORsR8+LlX92MmWsqUSo6WAj840c0PEhHHIETJzcE3
	t/7pb/cAFnj3TKEQ0rVP3X31e61tKZ2JDvhhTDPMl0cotcoxLkrVBb6jUqcwTguCxpSCORj
	99qVPG0mQpump7yUx2+LmBndCtP9dtJs5tlccRvzrgA4xBhC3Dt+XkZD0z4xk0+GewaEC3x
	hxuo+pkowt6PIXaOwvZEqLKEoqK7BWoYyVqVDFC0ZckLwAqp9vs4sVfDy6jF2sa6eKkPcms
	UJmVUAbIwjr+bBo3vumfk8tS5M5O3lENu1E/CdC6dkGDWkR/tOcNpWsTo2K7aCE9+WA9bVf
	rCC982T1UaqQEHkSYXDSBQvYvPLIDa8OQ9tjlej7cXS0frEMZ4ZmiCJhXlpvtPxlMEq45NR
	nXRzpl6ucN156Iql+tTB72mzjc1rJgSfbFXR3i9nULf7es7/coU8WDg16wI7lPwZG64qN9y
	96oh2KtmDbSvPFDXrq1lDHNBh33uRCJI3byAM2l3abFv6ml8AsOn2BIWjaCKOb8xB3aBmE/
	9O1FguMqdzlPjmIfSbSTvmPwlGm9W410K7Be3aqspZhU4ZPFQmTzB4g2IRjFAzYIolx7T8K
	/L6K5pW6p6V2aIOaN3jNpHHkSqPu7fWdX9NXrlG+lRM1kK99QTvrzlfBEs/Gh16umhfUeFK
	Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Li RongQing <lirongqing@baidu.com>

Outside the IOPL emulation path, the IO bitmap is always expected
to be allocated when TIF_IO_BITMAP is set. The paranoid WARN_ON_ONCE()
handles the case where the flag and the pointer got out of sync.
In this theoretical scenario, which presumes some other bug in the
code that triggers the WARN_ON_ONCe(), return early, instead of
continuing and dereferencing a NULL pointer.

[ mingo: Clarified the changelog. ]

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://patch.msgid.link/20260615070115.4720-1-lirongqing@baidu.com
(cherry picked from commit 2d36d3b451a94899db9c965adde15492ffe6027a)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/x86/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index fd91c301218d5..854aaf390b262 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -405,6 +405,7 @@ void native_tss_update_io_bitmap(void)
 		if (WARN_ON_ONCE(!iobm)) {
 			clear_thread_flag(TIF_IO_BITMAP);
 			native_tss_invalidate_io_bitmap();
+			return;
 		}
 
 		/*
-- 
2.39.5

