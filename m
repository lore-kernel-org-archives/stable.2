Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90A3F39E1
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470166; cv=none; b=tbAqIcgjlX0wcV26lsq5CC/YaKJqG+msH2IW8MHlWixe9KW3igaqdEmdobAHNhvkC7ys2dmFuQELxnSQ5tZBzr2bfVjn3T99rWRWyPrDKZABk6UHpM30m4lVh787lfuEAUZoko42j4+SPE5nECfyhpi2yx23HMMnW4KVPMYYbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470166; c=relaxed/simple;
	bh=h+hvwOkA5BhHvsrilqUGUwfN9ewjk2PjOSqMyuwnOPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHPDvgUiXz/urMynu/6NLISwMLZz8ANgkRFQNntuo4fIYdE/i8tRrCp1x57a6hTT3Ld6o5FpXg8PcEuXBaGJdzneG8a8XacF7jM5+oiLdF5oLkTNoNpOm5DJidw3+g7JAKcIlmkYpUb6RHxyGVewZYR+Lopbfu7bQzNtSXFEglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FIzZSRAm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FIzZSRAm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652HMsPx633201;
	Wed, 3 Jun 2026 07:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SaC0EO5qJoi1hvHJwkWYaIyMzWn4QmKidYQVl7D1b
	4o=; b=FIzZSRAmZc543c1g3UHas3kgZjqO9GU2TCyB1KNXJTCONPsk6SD6JvA0x
	DGDCrCc3BghlXCXwQMWXNetdVboifQesMKJGOgOhC28nv117ZQMuAl+XP2PygeX/
	04bSYbI7PhSNstDNOTS/URhTQ2pVUvQw98L1m9EiQrXnuyvirayCoHllIhj8aXy5
	GnjpBxPqlIBQAN7Y3ERUXL/NvjKBU8OvJmC2OL1IOexJdbuSQoioU+UTfDXqqa+u
	P3/R7zYelUznLY4250vxaikYw1g422l8ImuRbP9L5IYuq1uYNJWwZGHhB30+6spQ
	aOpUD1S5gpm+xjQKgmR3eKxMh2haw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq9kn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 07:02:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536s8dV020114;
	Wed, 3 Jun 2026 07:02:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qf71r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 07:02:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65372SRJ47841612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 07:02:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2488820040;
	Wed,  3 Jun 2026 07:02:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EC5520043;
	Wed,  3 Jun 2026 07:02:25 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 07:02:24 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com,
        adityag@linux.ibm.com, venkat88@linux.ibm.com,
        sourabhjain@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 0/1] powerpc/crash: protect kdump from active watchdogs
Date: Wed,  3 Jun 2026 12:32:16 +0530
Message-ID: <20260603070217.483696-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IYofj_uq1zsZap8sLGx_yn2aCz9LTU-F
X-Proofpoint-GUID: i15bz2LiacFriHudRX8yWWRmc3rBKzbv
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1fd189 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Gk6Qg7I2AAAA:20 a=iox4zFpeAAAA:8
 a=Kzp5J8S8SQhi4zYSBGkA:9 a=O8hF6Hzn-FEA:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2MSBTYWx0ZWRfXz20wtG0XTDgM
 /RfOzuExneTNoRlU9TyA8Zu0d2vZG6pYCKERuvKC+fOsuLFX04jkPE1iVEsqdZprU4zFkhhif67
 GCNCs4UgGblKaYx9bwsQI11D8/2eCH5Nv9jrq64vSiZ4T+pso/CQHOOsoV6M2BKpUPoynJE4Tvn
 8Mc6S1mH3md6B/EqFTp5EJgn+lxRd91ztKBrOzwM9Od3i9Hll8CbgEDSSf3DaLMTQ6T5LWAAMqu
 iHDdXTc4o2f3d1sjL6/wYq4v2YqGN0Xq1o9EfisZNbktt/BDHkYgcfviEwUvVug2k6BW9H30Oor
 WL5ZLqlT5Y9iBD0maDFG/1uSc1nvFvhkxiAmucHRY44PGkLj2qtnWshy9ghbl8PZ8RDKIIWlL/y
 EBbz+lRNBKRyh/BqMJlQqiSc7Jr/H5VXXr4ZsrTDJZe+CUisC2CCBY7+omc1axgdavMnaggVqP6
 n4EDNvL82rO5OS45sJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030061

On pseries LPAR systems in a high-availability environment using the
SBD[1][2] service, I observed that the system abruptly rebooted before
dump capture could complete.

Further investigation showed that SBD had configured a watchdog with
a 30-second timeout. Since the kernel crashes directly into the
kdump kernel without shutting down userspace services, the watchdog
remained active during dump capture. Once the watchdog timeout
expired, PHYP reset the LPAR, causing dump capture to fail.

The issue was reproducible only when the watchdog was active. Dump
capture completed successfully after disabling the watchdog,
stopping the SBD service, or increasing the watchdog timeout value.

This patch fixes the issue by stopping all active watchdogs on the
crash shutdown path before booting the kdump kernel.

Driver that export the hardware watchdog device is:
drivers/watchdog/pseries-wdt.c

[1] https://github.com/clusterlabs/sbd/blob/main/man/sbd.8.pod.in
[2] https://documentation.suse.com/sle-ha/15-SP4/html/SLE-HA-all/cha-ha-storage-protect.html

This issue can be reproduce using below program:

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <linux/watchdog.h>

#define WATCHDOG_DEV    "/dev/watchdog"
#define TIMEOUT         10
#define PET_INTERVAL    1

static int wdt_fd = -1;

static void watchdog_close(int disarm)
{
    int flags;

    if (wdt_fd < 0)
        return;

    if (disarm) {
        flags = WDIOS_DISABLECARD;
        if (ioctl(wdt_fd, WDIOC_SETOPTIONS, &flags) < 0)
            printf("WDIOS_DISABLECARD failed: %m (nowayout may be set)\n");
        else
            printf("Watchdog disabled via WDIOS_DISABLECARD\n");

        if (write(wdt_fd, "V", 1) < 0)
            printf("Magic 'V' write failed: %m\n");
        else
            printf("Magic 'V' written\n");
    } else {
        printf("Closing WITHOUT disarming - watchdog keeps running!\n");
    }

    close(wdt_fd);
    wdt_fd = -1;
    printf("Watchdog fd closed\n");
}

static void safe_exit(int sig)
{
    printf("\nSignal %d received - disarming watchdog...\n", sig);
    watchdog_close(1);
    exit(0);
}

static int watchdog_init(void)
{
    int flags, timeout = TIMEOUT;
    struct watchdog_info ident;

    printf("Opening %s...\n", WATCHDOG_DEV);
    wdt_fd = open(WATCHDOG_DEV, O_WRONLY);
    if (wdt_fd < 0) {
        printf("Failed to open %s: %m\n", WATCHDOG_DEV);
        return -1;
    }
    printf("Watchdog opened and ARMED\n");

    flags = WDIOS_ENABLECARD;
    if (ioctl(wdt_fd, WDIOC_SETOPTIONS, &flags) < 0)
        /* ENOTTY = driver always enabled, that's fine */
        printf("WDIOS_ENABLECARD: %m (ok if ENOTTY)\n");
    else
        printf("Watchdog enabled via WDIOS_ENABLECARD\n");

    if (ioctl(wdt_fd, WDIOC_SETTIMEOUT, &timeout) < 0)
        printf("WDIOC_SETTIMEOUT failed: %m\n");
    else
        printf("Timeout set to %d seconds\n", timeout);

    /* verify what the driver actually set */
    if (ioctl(wdt_fd, WDIOC_GETTIMEOUT, &timeout) == 0)
        printf("Actual timeout  : %d seconds\n", timeout);

    if (ioctl(wdt_fd, WDIOC_GETSUPPORT, &ident) == 0)
        printf("Identity        : %s\n", ident.identity);

    return 0;
}

static void watchdog_tickle(void)
{
    int timeleft = 0;

    if (ioctl(wdt_fd, WDIOC_KEEPALIVE, 0) < 0) {
        printf("WDIOC_KEEPALIVE failed: %m - falling back to write\n");
        write(wdt_fd, "1", 1);
    }

    if (ioctl(wdt_fd, WDIOC_GETTIMELEFT, &timeleft) == 0)
        printf("Petted watchdog. Timeleft: %d sec\n", timeleft);
    else
        printf("Petted watchdog.\n");
}

int main(void)
{
    signal(SIGINT,  safe_exit);
    signal(SIGTERM, safe_exit);

    if (watchdog_init() < 0)
        return 1;

    printf("\nPetting every %d seconds. Ctrl+C to safely stop.\n\n",
           PET_INTERVAL);

    while (1) {
        watchdog_tickle();
        sleep(PET_INTERVAL);
    }

    return 0;
}

Steps to reproduce the issue:
-----------------------------

1. Insert pseries-wdt driver
2. Compile the above proram and run the binary
3. Crash the kernel

Sourabh Jain (1):
  powerpc/crash: stop watchdogs before booting kdump kernel

 arch/powerpc/kexec/crash.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.52.0

