Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794828250;
	b=f+TP3tLP4X6FMc+j185HI3GJ08E1zN5iv3watSf1BtEXQ2lA5j7M5/D4Vpnl4RE8h3Gs
	 9i8cosHmfDn+sOj8rV25uoJ5WrVFnq2StAYEoatuiNF/9mLPQ0P2vspznIDbNQgL3ooX8
	 bxIeBdJxLv9a5qqf+kUcD9kCDdJ48MwVtZbQ08kT1hzfYOwjENmPwGB0iSNoJ799ViiRI
	 TRE8LaXKQ6ZTWMuc4Xk2nc5ENfiMZotSanqy4S6EyQDY26HdmFVuMiwjvjFms2oadVEku
	 yZAG9pI57zpEWLE1OSGlmOpYKjZCDiZTCTe7KwTs/qr7mQ7l9e+FcPLMuWFixV74UMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828250;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IwI3+1R+CO8yt0zBkXWOzlKWJecc+Ta3LKEXca7bH+8=;
	b=0sawZWzen5KRdjANXL3Y+rx7QdEQQL0tYnJSldH5ZVveCall1AvzB1+IH+hwTA5zB/sA
	 AGBSFi8dxrK10Aafi3c4ZgRBLO0Oaws6asILGQ71+u36xsXCZblyPyNsmyFr4zt84Wy+j
	 GAqm1TaC9P1b7GPvxSGvEeyKmdYGnPJFB91YjhrwG4yaO4Cg+oX8XqirezdBaIIeo7PND
	 K0NHX8GSKv3NWo7vAKzmIRVrJ3apMY81iTPGpz9E/sALBYkXCqZfwKbKVbKJge44jLXwH
	 7ehovDgiGlAKLScDWDCYXcgRc1OYGDvE76rvszJLPiKzg+F5COBuIJYDnbsV2RDlRrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=re1kl3IG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.17
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B618606BE0A;
	Mon, 16 Nov 2026 11:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B618606BE0A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=re1kl3IG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7MuCEz86N6wDULrjki3wdp5M72pRMiLi9RsWR/sT7UeX9gpaap3M96N75oSLr0oVVqm3CVfyNnWRaHmWB/f5uA3EQVzbqaDIMUMZa/upu3FoslpiMvFGHNBl1QpVrGfxcmWZ5GmpmH115/JoaWnHSlkkRI/rnQ6wzDckaPhwbKHex+xnMa0/Jril+WakpQKqCTrOoo/exrtOO6DGWZr/ZwgXuxrfJmAujVH/jHlJtjopQ2Kki9PLfarlmcEwFaQCv8Rk0cIh1PJwD6awOdyGXwPKBKZyLGTc+mYPGaH5uIEYV1DscZdJgFgXjZWOPWy8dh8b5UXCsj/KvQHhdhCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwI3+1R+CO8yt0zBkXWOzlKWJecc+Ta3LKEXca7bH+8=;
 b=mnVhcGY5sEPAL4hJSu5fXMv+RNlbHXoMBurhi/cAE/9JMZwlI5LmWrJyjJkJvS/h9zpZEynhf4FP/DSII2u4GN6crldKZ53wg+Bs0yMeRoB5T+Nt/Cp+zjPasu1fFwHUKBNKUXpFpxdjqxolrfs4Drc+b/aZYvZyMEt+sayN4zCavFqv7xXo7xNFxFwnbKYsy6P2gJSMimBvyA08hQfbgFjMFLLndwdnVljzIhHWjluCJFZ8mpe5XNbLoqRnGRGK4kZNORU7fWmZvAm2XIFIpBqbYl/lg30d9eozYoo9bXxmK20BDa6IrFh0+LQPDqMrNlZTh2408LBIC4R5mrhq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=columbia.edu smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwI3+1R+CO8yt0zBkXWOzlKWJecc+Ta3LKEXca7bH+8=;
 b=re1kl3IG/wpsEH3WkZi0ouiA+nAbyJ0MMF/XjbOUPeu5tNUicNsPjHb69e6vAx2UQhpeGrcroFGu/Yw3xfPEBVW1LaZ4YKUv4xOWgpxA2WWCdFiHmc7px0FpsjPrcEIGy//ZWxJ+lm1vixDZIipvsggKm+z0ChO862X8d7IAY9g=
Received: from CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:24:03 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::55) by CH2PR08CA0003.outlook.office365.com
 (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Mon, 16
 Nov 2026 11:24:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 11:24:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 01:31:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 01:31:00 -0600
Received: from [192.168.1.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 01:30:56 -0600
Message-ID: <a2854dd0-fd12-4a7b-81cf-4c9d823030b9@amd.com>
Date: Mon, 16 Nov 2026 13:00:50 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: Use the clocksource under test for the
 skew check timeout
To: <mt4022@columbia.edu>, Thomas Gleixner <tglx@kernel.org>, John Stultz
	<jstultz@google.com>
CC: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
	Borislav Petkov <bp@alien8.de>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <tz2294@columbia.edu>,
	<stable@vger.kernel.org>
References: <20261113-clocksource-skew-timeout-v2-1-9361d9a18262@columbia.edu>
Content-Language: en-US
From: "Aithal, Srikanth" <Srikanth.Aithal@amd.com>
In-Reply-To: <20261113-clocksource-skew-timeout-v2-1-9361d9a18262@columbia.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7aea85-1651-4e40-d2c3-08df43d41e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|6133799003|261009223027099003|13003099007|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	ym86M6yk3inf5i5DsO1j4X/HIn8Mnnd8A6gFo6Q4qYLzhROFmPwDKFeRhMiTUCRVojBESMNyXuGL0ihyHsGOi7Yzr/bdtgHApW60nCg5ryUSPjBYKEScVtAMZgM10fCPOi8GqFAYOpfY/4rASuBoGTUGOjh+IK/2Zy/Co74pQeh+n0qxym1rvPT2EzyPQps3s4QQwsSaMGH2ltY6pNGrT7ofe80VNZZ3fK9YnqsgnEUXl4xD5BH0/GMNI5Hy/vJDgvQqJGMrUDUNUfwN7o6onxz3yz78p0glw5QjLK83ZhKlW/J6H1boEjRKI28eHIQr9BOAR1v49/npapJnJvzefxXe4+d8I0blKorXT7bODgorqOmzx5lSvUHCDZIINEx1j1QUxVAjTM3fwOzVwxTlSccxSB4+VmBWRZTBeexfuhNHpgr0ZMTvtaEcfDVNbugQ0ikyxB3TETZT0lzr8nCCum312hKV7EsbMk5K4SHPWJY85tggDwzT+ZRcSG6keYQtEYnc1Ci7RRcNV3hontQqe/rHDrCJ1hVE63GksXiXNoUvGgaSIVvVh6aOJksmGTw98DMXkioh5sRKzdewwaeB/07aVAhb3+gTLew54q4xN1WXvH6GHpikbjhhGo7q+SkCAiOEDjjLQyVB9cOvCnujQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(13003099007)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Q0jJ5+X4U98B/dsKd/SeGhS9lwMQ7+/JRuZLkqhFltPsJdJIvb9IoaTGjca50nx4ytRiVY0W6oOto9xSMUq1g2jBAH0/plAmMlbwKLwJ068RldMUkhjuqhJ/OZ8PDSjN8nI/zzaUNYBneyUkPxetWUX1EvXcBMC9x7ZIZEV/l7IqPAtOr9DineR6zaY/wYTxYwe8ukYGyRU9XInj3Z3STh4h5zrlPW/bAwUiFVhG2vIiMJxrm/dxkUVm5z9gH5BoqBeaSqyUl2fRIjVSKBxEF7yOzJmr4DaTugOSYQoeWEfogc3IkTL47RPqEkVFanm1HS9wP1UaXWAK/i19T54k+c8S9vBq62h1qYMzQp8eyxrxgfl0bHCYvknZK2nKt0ZyrA4DiT41uNOi9S2i7Lle5+zfyiXFlAOlQ5ei6zI7LVntC22Pqo2cxqU8Xr1eANY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:24:03.4875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7aea85-1651-4e40-d2c3-08df43d41e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647


On 11/14/2026 9:42 AM, Mani Tofigh via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+mt4022.columbia.edu@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> watchdog_check_skew() waits for the remote CPU with interrupts disabled
> and gives up after a timeout measured with ktime_get_raw_fast_ns().
> While the clocksource is still jiffies during boot (or with
> clocksource=jiffies) that timeout can't expire, because only the boot
> CPU's tick advances jiffies and that's the CPU spinning with interrupts
> disabled.
>
> The boot then hangs silently when the remote CPU can't answer, e.g., in
> the stop_machine() of the switch away from jiffies:
>
>    CPU0                                  CPU1
>    multi_cpu_stop()                      multi_cpu_stop()
>                                            local_irq_disable()
>                                            /* waits for CPU0 */
>      <timer interrupt>
>        clocksource_watchdog()
>          /* sends CSD to CPU1 */
>          watchdog_check_skew()
>            /* waits for CPU1 forever */
>
> Measure the timeout with the clocksource under test instead, which keeps
> counting with interrupts disabled.  Also, when the remote CPU still
> hasn't answered by the next watchdog round, report it as stalled and
> mark the clocksource unstable instead of retrying forever.
>
> With the fix, the watchdog gives up after the timeout and the boot
> continues.
>
> Fixes: 763aacf86f1b ("clocksource: Rewrite watchdog code completely")
> Reported-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
> Closes: https://lore.kernel.org/all/e4a41d43-4d60-4132-aa2d-70e038a3e9dd@amd.com/
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
> Cc: stable@vger.kernel.org
> ---
> The reproducer hits it within about 80s on a kernel booted with
> clocksource=jiffies, with both vCPUs of the guest on one host core:
> https://github.com/manitofigh/files/blob/main/linux-repros/wdboot.c
> ---
> Changes in v2:
> - Fold in the stall check (Thomas)
> - Drop the hard lockup backtrace (Thomas)
> - Add Srikanth's Reported-by, Closes and Tested-by
> - Link to v1: https://patch.msgid.link/20261102-clocksource-skew-timeout-v1-1-4ff412918591@columbia.edu
> ---
>   kernel/time/clocksource.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 58c0ca11cdc5..5dfa72a2db68 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -250,6 +250,7 @@ enum wd_result {
>          WD_FREQ_RESET,
>          WD_FREQ_SKEWED,
>          WD_CPU_TIMEOUT,
> +       WD_CPU_STALLED,
>          WD_CPU_SKEWED,
>   };
>
> @@ -305,11 +306,16 @@ static bool watchdog_wait_seq(struct watchdog_cpu_data *wd, u64 start, int seq)
>                  if (READ_ONCE(wd->result) != WD_SUCCESS)
>                          return false;
>
> -               /* Prevent endless loops if the other CPU does not react. */
> +               /*
> +                * Prevent endless loops if the other CPU does not react.  The
> +                * timeout uses the clocksource under test because the timekeeping
> +                * clocksource can be jiffies, which doesn't advance while this CPU
> +                * waits with interrupts disabled.
> +                */
>                  if (cnt == 5000) {
> -                       u64 nsecs = ktime_get_raw_fast_ns();
> +                       struct clocksource *cs = wd->cs;
>
> -                       if (nsecs - start >=wd->timeout_ns) {
> +                       if (cycles_to_nsec_safe(cs, start, cs->read(cs)) >= wd->timeout_ns) {
>                                  watchdog_set_result(wd, WD_CPU_TIMEOUT);
>                                  return false;
>                          }
> @@ -322,12 +328,13 @@ static bool watchdog_wait_seq(struct watchdog_cpu_data *wd, u64 start, int seq)
>
>   static void watchdog_check_skew(struct watchdog_cpu_data *wd, int index)
>   {
> -       u64 prev, now, delta, start = ktime_get_raw_fast_ns();
> +       u64 prev, now, delta, start;
>          int local = index, remote = (index + 1) & 0x1;
>          struct clocksource *cs = wd->cs;
>
>          /* Set the local timestamp so that the first iteration works correctly */
> -       wd->cpu_ts[local] = cs->read(cs);
> +       start = cs->read(cs);
> +       wd->cpu_ts[local] = start;
>
>          /* Signal arrival */
>          atomic_inc(&wd->seq);
> @@ -392,7 +399,7 @@ static void __watchdog_check_cpu_skew(struct clocksource *cs, unsigned int cpu)
>
>          wd = per_cpu_ptr(&watchdog_cpu_data, cpu);
>          if (atomic_read(&wd->remote_inprogress) || wd_csd_locked(wd)) {
> -               watchdog_data.result = WD_CPU_TIMEOUT;
> +               watchdog_data.result = WD_CPU_STALLED;
>                  return;
>          }
>
> @@ -584,11 +591,16 @@ static void watchdog_print_freq_skew(struct clocksource *cs)
>          pr_warn("Clocksource %20s interval: %16lluns\n", cs->name, watchdog_data.cs_delta);
>   }
>
> -static void watchdog_handle_remote_timeout(struct clocksource *cs)
> +static void watchdog_print_remote_timeout(struct clocksource *cs)
>   {
>          pr_info_once("Watchdog remote CPU %u read timed out\n", watchdog_data.curr_cpu);
>   }
>
> +static void watchdog_print_remote_stall(struct clocksource *cs)
> +{
> +       pr_warn("Watchdog remote CPU %u stalled\n", watchdog_data.curr_cpu);
> +}
> +
>   static void watchdog_print_remote_skew(struct clocksource *cs)
>   {
>          pr_warn("Marking clocksource %s unstable due to inter CPU skew\n", cs->name);
> @@ -629,9 +641,13 @@ static void watchdog_check_result(struct clocksource *cs)
>
>          case WD_CPU_TIMEOUT:
>                  /* Remote check timed out. Try again next cycle. */
> -               watchdog_handle_remote_timeout(cs);
> +               watchdog_print_remote_timeout(cs);
>                  return;
>
> +       case WD_CPU_STALLED:
> +               watchdog_print_remote_stall(cs);
> +               break;
> +
>          case WD_CPU_SKEWED:
>                  watchdog_print_remote_skew(cs);
>                  break;
>
> ---
> base-commit: c1b96ba87e3caaa701d6dba254e58db7cc3c99be
> change-id: 20261102-clocksource-skew-timeout-f2a9e5fb3f75
>
> Best regards,
> --
> Mani Tofigh <mt4022@columbia.edu>


Retested v2 on Linus tip aebb727447640 (v7.4-rc3). The issue reported is 
fixed. Tested-by still holds for v2 as posted.


>
>
