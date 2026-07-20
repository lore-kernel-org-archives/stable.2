Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023109.outbound.protection.outlook.com [40.107.162.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6539D3F1;
	Mon, 20 Jul 2026 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542178; cv=fail; b=EQHkRJGepsujV5sk96XGUbl6bklCO1v/TxvBCMkAwoSDpztckkf/IalIsifFAjkeCk0I21kFHtWaejXa76UTnqnVpMOYPOop4EpGbAtoWlThAhDSDQj3eIERPDlJ1mEH7xXPS9Xb6FLw2M8DnOLSmXKw2DmDydsId0A3biirGgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542178; c=relaxed/simple;
	bh=jF/GAZvuj65PsLBNUlRkO580DW8irTSpWYETcQujepw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cefhgZi1/Vi5DXJtwUBHhHIhqfwi3PF4OlMTdW516EdZYyT61JgbKX2y47IrHV/ZuMpA/QFrGH3zDOr0o7eE35dcSNF8huHCE/uft01Xwm/ARzWxBr77tgtRbEzq8/ACcvLYqzbam7QTGIdpV/a+iwRlHHudEGOZCcbNxxQHQUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=r5xy2xQt; arc=fail smtp.client-ip=40.107.162.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r5xy2xQt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQpD8WwLe+P6JsAVyEQCl3J1rIZTFDINa/6vBYPhrjxKIZfI8zR5Atki8vsG5zhGHhksPAqLuMnAGKErNnAofzSGO1m7+8pKgzszqbkATVTEv4W1tw4QEdTECo8Dnt1PrJFdYSn1hX2qeM+2pSczTONgK/5QKNCHsBk51JNPnmp8b59Dhybli29xCNTaipHGCyEUpgFt71pFXEzmGwTSoKUqhBiehMAByqF9TFfi0Luzm45D46GmJr3U5fvNH/TjaXwG7d4TChoAnCxuhsmkH16c7QtvJMK4vhFdp9jT0zon6OF8EKBod8R2kRefpXjg+ahF2/7S0YEdAvfXj0NEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YHWNk3N03yMEdVbn6sdbeRmgq0thseOPLDySA68/wQ=;
 b=KnJSHMwgH4Ouokof87ontNJrH7/25H0/2O6lTYHbedQ/6U6b8xHU0lOSOuV7qY1mVHifuF5ZxuzASBeKob1XRnrheG7ujtkVHBlEvhw/7QnaItljlFYu5xjII/SR/KR4W0NcFJhleoUFoDvZG5MEz9KsuV94NO1AeiU00KY3eQ6kOkIoRWV94I/x1kyW2rM6cWRJVnCU/AHFL/LQka9ZYbS3PmS0Ufd0Yf4eZL2FfiNfuwB8M8T3qw4fjwLJL1sZ0hYMCSrqBNQxFPYGOK1Btf33JWklfus7NLJl2wEJGfC7MzyYvJa7l2bbr7y37kUTH7F4/nIRVySkDe1bSGm3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YHWNk3N03yMEdVbn6sdbeRmgq0thseOPLDySA68/wQ=;
 b=r5xy2xQteYNE6p+i5GQUgJ4P2qrE+ORCAeP55Aiiy6fDDjazEFdKkWHl+6hMYK4ifkxa5qnxvBt/iS2i4RTwRKamoA6DHuc5P81Zf81DoSKagdbTHQPF8kx++3HYeq0N6Kya6SSq55SpgZuvzfwPIOZFdctjIoRJ3CwuLyGjiHzwBDwMbYfuWEaBB/MCXlt78W4UOXTKMlxgzY7tQEjc+V5rf/twzK+KyQ9TTSL34Hq34CzrziRz5a+17s2YxXcoG1EW0aZyJj2K5oMXea77hA9zF9j3jAKf7Z8cfty8yVWeh+tegOb3JKAThf93ElP/pxmQM+3c5+sPLqy8Lm9jTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14) by DB8PR08MB5307.eurprd08.prod.outlook.com
 (2603:10a6:10:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:09:21 +0000
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a]) by AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a%6]) with mapi id 15.21.0223.011; Mon, 20 Jul 2026
 10:09:21 +0000
Message-ID: <18813932-6422-4995-a19b-6fd39f1fd679@virtuozzo.com>
Date: Mon, 20 Jul 2026 12:09:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pid: fix cad_pid use-after-free race
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, brauner@kernel.org
Cc: oleg@redhat.com, akpm@linux-foundation.org, jack@suse.cz,
 avagin@gmail.com, mjguzik@gmail.com, include@grrlz.net,
 ebiederm@xmission.com, legion@kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com, stable@vger.kernel.org
References: <20260719155842.7069-1-blbllhy@gmail.com>
 <20260719155842.7069-2-blbllhy@gmail.com>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20260719155842.7069-2-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::14) To AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB11804:EE_|DB8PR08MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: df9ce4b4-7c67-4d14-aba9-08dee646f7a1
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|10070799003|7416014|376014|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LcIPJU4qhS5Y4u4/ZHtGCLW1DJkUChzGjfoK1/uPFnLK99j5BeHfxcLiBrBN3Pdy6A4ZWomrzT+tDTA24vu2k6D8k/lKHonuD1oPKXWUhG8Vv6cJT+pbuLvWH212ng8ZfWZ+6H4LlttWhMcKVNIZ+qW1aWbE1qsTlWlj7+jF/eC7oTpQnkAV7tmdCPyhyF+zsaabnwlbRlfq5JnyxTvew9eJPyYr5jlo88aPiPaov53ThuJpuTtX4Qmi98nCIed5JdHiuEAA9FdJ84Tk4K1/OP7R5WDhJkuQ+9t/wEpzQEkQOhQXpa6rJu2qMwqVuUq0eEx0VZS1v/0O2ePVoBHmcnUfmzOVjAUUWFaS0aIqJbIFO3esmDmsdJujs/TugKOM7vgNA3Hk/b19jechnTuU/R/CIInlrOjLrZlZw9R8ieXa6sYvI7xDcYznvyxw1ZyE6AjwZ7A6APPIqEe+yMfMKLF/CU54u7kupvxeEj8U1qAJCKt+eM2r5ejhG6FJ7V8fTY0n/Sx3KVf4mZ9ku1KsdiP8WIDU+g+FvKV6zQK26k4yZamsczsySAcR5/fUbwXAfwVAWH3WxGd57lpCVla7vocIc8F6IlcE7Mut4GX4mQO1C9vf0NKVHMoM+wvgvMcOfWxe1IFRpOzMO8NyM0F3OUsowd9l3aA6092IJBXZSMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11804.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(7416014)(376014)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVhUEZ5eDNHeVI2Z3p4R0ZHMzMyUE5rOEhXY3pXd3ZoTkZ3cE9HaDJ4UEF6?=
 =?utf-8?B?TGNqOUJ0VURIRnpMVStLYVg5djUyVFRTODU5WXlKY0dqR0ZTK0lSandBM1Vn?=
 =?utf-8?B?NHA0ODlZeGQwZkpxSVZSUlkxZnhMZzJFZWRiQ3NSS2xrZndtYkszWENCZmQ2?=
 =?utf-8?B?Z3pWS1dFamh1MVo5VmRUUU16MXpRdVh1M3dXZDYzcXhtak5aVXpWbElOWWZX?=
 =?utf-8?B?Q2hud2Q1UkF6cUxtWTlZUW9NcC9jODVqTG5XZW1tdFZDaEpwbGRYRDk0NEty?=
 =?utf-8?B?b0FFbUI5UVpQUzQ4UTVOQTB1MVdtTjBiVXZUY005TG1zVHJaODc0c1YxU3NU?=
 =?utf-8?B?a3dVaWo3Y244aGFLNWo2bHZvdkZMV1J4V0phQ2F4eXhxbDF2S2ZmTTg2OHZ2?=
 =?utf-8?B?SEpGaXB2VHFRb1BKcHR4Q0loRlcraitoZElQM3FRa1lWQ2tmMFF2cGRObktX?=
 =?utf-8?B?U3gzZk5lUzV3M01LWU53Smp2eStvU2JKZHdkRWxjUVRmdU53eHNXamt2QWNp?=
 =?utf-8?B?bWwxNS9SUUtCYldhdkMzZnJWL3doZFlPUGlHZnVMYTFwWVJnU1UxbDFOajZl?=
 =?utf-8?B?S0lMcElHOWlVcHdiVzloR3N1cS9aMk1TOTFRMStnWGlwK3pQOTdmcjJvQ1Ja?=
 =?utf-8?B?MmllMkNHbXlLMmJ0Q3ZpU1BUMVptTWNCNHExN2JzanQyM0J5Si96amZuNUI0?=
 =?utf-8?B?VEVlWDF2NEtwOEFZZDV3cndtNGpvS1c0blgwM00xYWdqSlFNd0NWdS95QU1s?=
 =?utf-8?B?ZEk3R0l5c0NxQ29OM3RQWS96SFZjbE5lMmpBZmQycVhFTGd4bnV6cnpLOXhF?=
 =?utf-8?B?OHN5dndBblhQYitRRGVpZENaMHdxUXZLaFM0Y1NGeEE5YTM1R0s3WnZwUDN3?=
 =?utf-8?B?L1YyOEErS3dGem0xNlJxTk5VQzRuTENsQVh2M0RHaFVoWEFRVEd0Qlh1M3VC?=
 =?utf-8?B?QWtwUUF1aGp4bXp5NEF4enhDUTZkRzNBcGxjYlc1ZFRKdERPNjlsMkcramxn?=
 =?utf-8?B?eEdVOWtNYTlGZ2JIdy9QS2tFVzlBdkM3eEtpTElscm8xUnlDd1d5MGtQZ3Zr?=
 =?utf-8?B?UElhdGhWZ0ZLRVRUYWpYTU1IYU9SYmVjY216WnFkTWJSQXlMNGZDVEFZdWNn?=
 =?utf-8?B?WG9hM1lsKy9BMWNMSUwwRXgraEx6ckdXZVFKMEtWcFhJWnVLSXAyOUQ2K1kz?=
 =?utf-8?B?ZE9Dc2h2b3YrOHRoa3hIdjE4d3RSWW4zZHQxWEFmVmE4bVpRRzF1bFVrNDZH?=
 =?utf-8?B?Vyt2Wm5NbmExZlFxL21zb2RYMUFiWE9hTWczc0U5RE84MFlHMURDSDIrSzJK?=
 =?utf-8?B?SE5ZVFVoZlJUWWs0RW0wU21XYWoyb1dOaHhRcyt4THgwRVJMYVNTZkRLUlBJ?=
 =?utf-8?B?UWNvTzRMVG41YldYd2EvVW9ReEZGWE5nTkxmNWkzeGVFNmZHUXVGa2xNRGov?=
 =?utf-8?B?M041Yzd1WWhNQTBZUEtKTUNrUUNvbXI4Y0lFSzBybXZZK3FaclMvTEhXWFU1?=
 =?utf-8?B?ZGtzaEUvb0p6b1g5cmp4SU41dVZ0eEVSY0g4anM1a1QxOUNPdVVqWC9QL3dk?=
 =?utf-8?B?RHZ5VG1vUk41ZTdYb3FRTlFEa0t2WkRNWWZCQW9EQ3ArZVNRT2VxTDdHNUFk?=
 =?utf-8?B?VlJYN29OWHllNEV5TnAzdzRRajBuT05HYTlaSkpubEhXKzd6MDkrVDVBdkFK?=
 =?utf-8?B?RmRnT0pRY0YxUXBYZWM3bnRxSEJ1cGpkMTYwcWpHWDVJODhJK2ZmRWtremtL?=
 =?utf-8?B?SExBSzc1THZhQXlCTWZWK1JueFkwNDM5TUtjcVllVGxtdytFekx5Y0dOQUc2?=
 =?utf-8?B?TGd4R0YwNzY2VWM2R203NFhwN3B0cjkvQlNremRObjRwUlkvZWRLOE5Wam1o?=
 =?utf-8?B?Z3hScStUa2J0eVo5bEVlQi93Y2FqQXZ6SWpjdUZBT20xbkRYeWYwSjkvTXZj?=
 =?utf-8?B?VC95SEdpWnNtd01nYmZZN3g4Z1ZtQWh1aHN5Y2hGbktIRUx5d3A1RUpyZmlr?=
 =?utf-8?B?TnlndU1rOHlIZ2VBQXcrLzdlSEppQzUwY3hwS09ZOWdHNDBIdk5vTkVUQ1lp?=
 =?utf-8?B?NjloWHdBQW5iY2xZZWRaUzN4Z0graXo4RnJpKzhORTJRYXp5WWxJUkpWOTFQ?=
 =?utf-8?B?aXNSS2pzSWFkZHhBYi9yR3JscXFHRzFHMWp6TVJzOFdIVnVtRHBuaFBUZWJo?=
 =?utf-8?B?RHRVYy9Jc0R1QVlZVWVmMXNtakl5dGViUUZYb0R2Y1FXZ08zZzNZYmt6R3NE?=
 =?utf-8?B?VEM0R0k3Y2d0ZEpVY3hKSEpVaThyUDNlNWRmTFo0YXNEUWVSVHJHb0VMdkVL?=
 =?utf-8?B?TVNBU2RlU1BQQStuWUJud2NCK1RQd1FYQk84cCtqbGgydnZzMXlXY0syMFVi?=
 =?utf-8?Q?X7VCz/p+hEpFch+PkPXYVwOz5eAcAdwwNnYga3gLociww?=
X-MS-Exchange-AntiSpam-MessageData-1: qFsCtQjZ4FuYSiI6vdp5JTHiqFLP8MnL8Ms=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9ce4b4-7c67-4d14-aba9-08dee646f7a1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB11804.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:09:21.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUW0T44ft0JiDuEvcyJ93JRuUXQ9/jye4b9jsY5mX+EUUwfm/jI9unb3RTT6yzNjKToxC6mqhlDRkX2KIeao+4YdOPNmYJuPjbQjfe28HDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5307

Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

On 7/19/26 17:58, Cen Zhang (Microsoft) wrote:
> proc_do_cad_pid() reads the global cad_pid pointer and passes it to
> pid_vnr() without protecting the lifetime of the referenced struct pid.
> A concurrent writer can replace cad_pid and drop the final reference to
> the old struct pid after the reader has loaded the pointer but before
> pid_vnr() has finished dereferencing it, causing a use-after-free.
> 
> The sysctl is mode 0600, but access is checked against the owning user
> namespace, so an unprivileged user can reach it via userns, pidns, and a
> proc mount.
> 
> Fix this by treating cad_pid as an RCU-protected pointer at both read
> sites and by waiting for a grace period before dropping the old reference
> on the write side.
> 
> KASAN crash stack:
>   kernel/pid.c:545 pid_nr_ns()        # reads freed pid->level
>   kernel/pid.c:556 pid_vnr()
>   kernel/pid.c:775 proc_do_cad_pid()
>   fs/proc/proc_sysctl.c proc_sys_call_handler()
>   fs/read_write.c vfs_read()
>   fs/read_write.c __x64_sys_pread64()
> 
> Fixes: 9ec52099e4b8 ("[PATCH] replace cad_pid by a struct pid")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Closes: https://lore.kernel.org/all/20260717210143.4734-1-blbllhy@gmail.com/
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v3:
>   - Keep kill_cad_pid() inside the RCU read-side critical section
>     instead of taking a pid reference, as suggested by Oleg.
> 
> v2:
>   - Split out kill_cad_pid() deinline into a preparatory patch.
>   - Annotate cad_pid as __rcu and use rcu_dereference().
>   - Protect kill_cad_pid() by taking a pid reference under RCU.
>   - Add a comment explaining why synchronize_rcu() is used instead of
>     call_rcu().
> 
>  include/linux/sched.h |  2 +-
>  init/main.c           |  2 +-
>  kernel/pid.c          | 22 +++++++++++++++++++---
>  kernel/reboot.c       |  2 +-
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 373bcc0598d1..31ce72b1233c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1767,7 +1767,7 @@ static inline bool is_lazy_mmu_mode_active(void)
>  }
>  #endif
>  
> -extern struct pid *cad_pid;
> +extern struct pid __rcu *cad_pid;
>  
>  /*
>   * Per process flags
> diff --git a/init/main.c b/init/main.c
> index e363232b428b..19a10d0c2760 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1636,7 +1636,7 @@ static noinline void __init kernel_init_freeable(void)
>  	 */
>  	set_mems_allowed(node_states[N_MEMORY]);
>  
> -	cad_pid = get_pid(task_pid(current));
> +	rcu_assign_pointer(cad_pid, get_pid(task_pid(current)));
>  
>  	smp_prepare_cpus(setup_max_cpus);
>  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 234ebee29375..fb7c0d18efa9 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -559,7 +559,13 @@ EXPORT_SYMBOL_GPL(pid_vnr);
>  
>  int kill_cad_pid(int sig, int priv)
>  {
> -	return kill_pid(cad_pid, sig, priv);
> +	int ret;
> +
> +	rcu_read_lock();
> +	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
> +	rcu_read_unlock();
> +
> +	return ret;
>  }
>  
>  pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
> @@ -773,11 +779,15 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
>  		size_t *lenp, loff_t *ppos)
>  {
>  	struct pid *new_pid;
> +	struct pid *old_pid;
>  	pid_t tmp_pid;
>  	int r;
>  	struct ctl_table tmp_table = *table;
>  
> -	tmp_pid = pid_vnr(cad_pid);
> +	rcu_read_lock();
> +	tmp_pid = pid_vnr(rcu_dereference(cad_pid));
> +	rcu_read_unlock();
> +
>  	tmp_table.data = &tmp_pid;
>  
>  	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
> @@ -788,7 +798,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
>  	if (!new_pid)
>  		return -ESRCH;
>  
> -	put_pid(xchg(&cad_pid, new_pid));
> +	old_pid = unrcu_pointer(xchg(&cad_pid, RCU_INITIALIZER(new_pid)));
> +	/*
> +	 * Wait for cad_pid readers before put_pid().  We cannot use
> +	 * call_rcu() here because free_pid() already owns pid->rcu.
> +	 */
> +	synchronize_rcu();
> +	put_pid(old_pid);
>  	return 0;
>  }
>  
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 695c33e75efd..fc191a48c0e9 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -24,7 +24,7 @@
>   */
>  
>  static int C_A_D = 1;
> -struct pid *cad_pid;
> +struct pid __rcu *cad_pid;
>  EXPORT_SYMBOL(cad_pid);
>  
>  #if defined(CONFIG_ARM)

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.

