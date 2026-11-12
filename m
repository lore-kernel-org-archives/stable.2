Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471435;
	b=g5USb4TRNpu4EE4W5NxAxo82WRSN0PUtoMaDMV5MPDArAlgpQhRPcucAlUFMTw7K/rMJ
	 du5VZxYXH/ppJVBZhgxwu6tnzKDdMqvfR/hjSrI2R+gd6rtwl71A+ZOVTEK00lqJMSjgF
	 MPuQsDD51P0truNQ7b+b3VlCNkvNrOXlo1qBTHbWGAeEuQvl6yelore4OFpy5/ynyR0fL
	 0nDnJ1FDNLDva3gBX9vG2WvYQpTX08a0ijAnDZQzMuI4SryP3eZ4waR6+UHDKpMJAN7/X
	 0d7UGSuwe8n8s7xnu0a6PUrRwQOMpD7ntFTIeu2ES8ucw6mH37I3lMZqcK8ZdmXz9Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471435;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=+lHWtfm+xSrskYimdfnXJQUzTfmOWVpFDI65L1grYT4=;
	b=oLjSGsC8zVQc56QuR+oCfE2kH+cI0u4hj7HD1pzYxihQGA8GRY7F92iof16NW7r0lZwo
	 aQHnshuubtoZagq2kXdpQ+tjFg57kVvxWJ37uvMuOzhiiObNQ6EafnIcR7aM2tlxnieR4
	 RNV69UCdx6+U4+A9FrjvhVwhMriFy7pFiLGbR5gxYCazQ2hWfieyL23sYl/rPL/NAuEuc
	 4WEW8oNxvQnOjKEg7W8qBU4GzrWQGwVnOVDs2e7vraRtkU9JlF4CDa2kSZsAvmbrb/OsZ
	 TwOJzoIcT0QUCDsciOCTJdzJ9gs5rzTL0o7WwafD+ujz2cCsAfXgoxya3w0ihYi5CUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TYKkucNi;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C452606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C452606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TYKkucNi
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0F1CB20B7168;
	Thu, 12 Nov 2026 00:17:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F1CB20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794471431;
	bh=+lHWtfm+xSrskYimdfnXJQUzTfmOWVpFDI65L1grYT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYKkucNiGmjj/aF4FfXtzi4yDsIZZIgw8qs/jnmX7GNKzxr4attxKIJivCMKtJG3G
	 uSNSzanXFRNnWWIThOKF8PLWnfgbiSgS+GM7aVo/dVCFEZkxzPFs39MJJbnMDarmi1
	 SvH5cuKC4wQKJADnLxYwR/64DvlIAycAVwWPiLZs=
From: Naman Jain <namjain@linux.microsoft.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: namjain@linux.microsoft.com,
	bp@alien8.de,
	tglx@kernel.org,
	vdso@mailbox.org,
	hargar@linux.microsoft.com,
	decui@microsoft.com
Subject: [PATCH 6.1.y] x86/init: Initialize wall clock in get_rtc_noop()
Date: Thu, 12 Nov 2026 08:17:08 +0000
Message-ID: <20261112081708.524011-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109201735-failed-6.1-7d5af1f256fd@kernel.org>
References: <20261109201735-failed-6.1-7d5af1f256fd@kernel.org>
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

get_rtc_noop() is used when an RTC is unavailable, but leaves its output
argument untouched. When CONFIG_INIT_STACK_ALL_ZERO is not enabled,
timekeeping_init() may therefore receive a nonzero invalid persistent
clock value and warn:

  "Persistent clock returned invalid value"

Initialize the output to zero, the documented representation of an
unsupported persistent clock.

Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Roman Kisel <vdso@mailbox.org>
Reviewed-by: Hardik Garg <hargar@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260831082528.1623843-1-namjain@linux.microsoft.com
(cherry picked from commit 7d5af1f256fdecff6a7986bbc9146b69cb355bb5)
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/x86_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a4a921b9e6646..e911315c16a8c 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -35,7 +35,7 @@ static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
 static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static void get_rtc_noop(struct timespec64 *now) { }
+static void get_rtc_noop(struct timespec64 *now) { *now = (struct timespec64){0}; }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.43.0

