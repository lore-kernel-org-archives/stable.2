Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471727;
	b=jccuKAIhFa30TKmZOwSjAKR0Bocjl7LBGc31HFJ3vy8alNeR30NzsezoHCHyELIdRI94
	 JExawN0fUI9dc+vPxCFq2bDLbkdZRuKY0QkfwgFl+j3+rixkVWvAGnIEH59gsy4DiGDa/
	 1rXzsTdmXebDV/1TE2ACLewDjJuzjVLeNO96z5od3DsRYA2vI/Pzv1EN8lPMNfk+73q7Z
	 fKh6GriF1w+OHZ93u+/DYdiSB6K2Y830uZai/ApJIGIyYV13hvpTUQ7jp/YXz8/31lySP
	 aeW4KLZfbws4q5WZKSQizErJdO2mIrPIp3dzXBc/ecsUMhKgF1YdwPKENBNocKB+jYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471727;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=5yvOOALHqvMZ8GGXX3bpByU6XUboZdJSD8q5ckm9oqk=;
	b=MsxKGy5jx2mvzDX4hl57eZylz6Tw86nLbIhaYIjVBO5hunb5Z3iJwAeHao5r/+BATtp7
	 F8FZEQyBEF5TIPWgTobfePzguFOlZWW+QFhi9BkelEUuWQeYutroURurzvzPkfqU1EgqA
	 XIeQPTXqRl+Em3RcVeaufSDcZHq6ayg2AI66HPt86r0r/yjWDnixPTFawkxtuQaaxQ5MM
	 OBOZ0nOEB9rJT+vFNt30uXNa0DWNRJjfHk5fntX/7AefPFPVAPizBtI9UzVBQx61ofKon
	 U5tNjYZ4ezVb93fUgnXJxqEtfD9HnliRFb8Zvm8uXLFPlMXhdf0RYROHoekgraQzaPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Sauj21Co;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B9606A33E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 406B9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Sauj21Co
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8FB1E20B7168;
	Thu, 12 Nov 2026 00:22:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FB1E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794471722;
	bh=5yvOOALHqvMZ8GGXX3bpByU6XUboZdJSD8q5ckm9oqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sauj21CoMDMe/mLjVBf7+rMjibBKqE3e0gHiuGdAvhigN54v26cf1JN2uu5Rrok5w
	 vPxTM7N+/nn+m7OhMOvKE7tl/UlGBu6MZzBiNyV5I8Nd007/j1ZTQezLlx9pxYV1gY
	 clY981S7Rpr4niHiBlNw8960iTJPIleiHedHByi4=
From: Naman Jain <namjain@linux.microsoft.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: namjain@linux.microsoft.com,
	bp@alien8.de,
	tglx@kernel.org,
	vdso@mailbox.org,
	hargar@linux.microsoft.com,
	decui@microsoft.com
Subject: [PATCH 5.15.y] x86/init: Initialize wall clock in get_rtc_noop()
Date: Thu, 12 Nov 2026 08:21:59 +0000
Message-ID: <20261112082159.527064-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109202235-failed-5.15-7d5af1f256fd@kernel.org>
References: <20261109202235-failed-5.15-7d5af1f256fd@kernel.org>
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
---
 arch/x86/kernel/x86_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d3e3b16ea9cf3..ef8c7f975f7ad 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -33,7 +33,7 @@ static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
 static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static void get_rtc_noop(struct timespec64 *now) { }
+static void get_rtc_noop(struct timespec64 *now) { *now = (struct timespec64){0}; }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.43.0

