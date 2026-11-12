Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472046;
	b=r+4ghlmRomjeTpJAE8g8kK0YFsFCd1eCIS5Ov3IxiAQrXInV60cytWkrI/LaiwSiC2JK
	 FOVL2Jk+3Fk1KJu1a6sSBDUe9dxkQ3kKE9BjpJF+qpNS0JotTKtIkKGHyXk8FhpXSt3Me
	 Rky9UNGjhWi5JBNV6B5YNejXo1dyXpTbVc03Twivwv7I5jY7mjP+HOwl4fsc7dLSsht/1
	 ldByZmARyrRzOgQkqLO3pP7PnNOW8y7gV6SFhrBwbxg9ECXirleAFfP/gXEYaGCUd45FJ
	 WQzETjxh3dsI3l0zUsG9nz1gG5+tfVobFqLs3UrcsBL4N+jnMQRZHg+ORe4R37Ec/MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472046;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=jhvXTI4sODq2+dggflhtRsWs9TkwJN/yc87cnG7v71M=;
	b=HgRFezF//njjc2OBSw5PdDrnFOMTec/IN8S25IB6jcpQGybZ4rxbGaNtWFf44/ODJNZB
	 VKiEogf5G3vjz4oQyp/LwFwD1VeH5tMtO4BG4AgZiuEUUzCp2laqrtWyUUP5eIMvugeLj
	 8B9GTcxc1un3mQf+CCyGy4ZknwStMCK+Vajnh9Rzn+2iZlabkar1HN2VVoYWFxtO7qNYE
	 Zj0xY7udkglvkEdL2x74MsrJoVauM3kDrwxCrK6WsOHc50i07DeKeXtPK3Qf9iDnaZCjr
	 zFnoswyIx8dV2V4lOgAsbV+h+NMyI0jfDmirhcJ2OrEaTTFY0EagAO278VJG2sMF3vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=fPJ2xZsQ;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D66606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D66606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=fPJ2xZsQ
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id E866220B716A;
	Thu, 12 Nov 2026 00:27:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E866220B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794472042;
	bh=jhvXTI4sODq2+dggflhtRsWs9TkwJN/yc87cnG7v71M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPJ2xZsQioAecDc9d5dNgL8HrNrSXzJoT9HopWH0R3uifF4teTnaHUv6g2yjfHtj2
	 diOpZcEOoPvkZYrjyMt/xvEEkPCokWNM78sZ3f1lzGUXq016m4yEI6/qwCsuQY4MnJ
	 bOux+1db/4EPNmt0gVqBPCiN0HfEzGHr5ikBfhuM=
From: Naman Jain <namjain@linux.microsoft.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: namjain@linux.microsoft.com,
	bp@alien8.de,
	tglx@kernel.org,
	vdso@mailbox.org,
	hargar@linux.microsoft.com,
	decui@microsoft.com
Subject: [PATCH 5.10.y] x86/init: Initialize wall clock in get_rtc_noop()
Date: Thu, 12 Nov 2026 08:27:19 +0000
Message-ID: <20261112082719.555102-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109202714-failed-5.10-7d5af1f256fd@kernel.org>
References: <20261109202714-failed-5.10-7d5af1f256fd@kernel.org>
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
index b758eeea6090b..9b78fb832d9c7 100644
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

