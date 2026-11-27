Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795761025;
	b=FGEXkUDEWoF/e0zIqJs7pb5D0Ghrm+w1nYUd3CW0XwbK1Po3a4eQL+WD3UZ0TUzcusGa
	 5dT45aK+qy6jBQaSaX3BFdULYMjSOBkUCAifjbdUEpdqUVcc3GFlXaSyly67dQp9DRXGL
	 +YCshbo5RS/3QfvvXYkhvDdY3iUuNqAD0UTShAVvM/pZb3B1ROuki24DqmdMW1yn1X/p0
	 8sKx0HhOz25wrn0ZDK1tK9DLLcidLkJTVfyBf+vWvxUvyDxK8CpM42sOt6A/OVAMv5Bg/
	 dpmc71rf3xSDqnwCp7B6S6xuYvnFsHVn2wrdsQ0FhJ/T3QSg7sfgtXnGnukpppT5gew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761025;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=W+dT6AaBwXfX7XlEhpjtGmIjCkIrjvsrIWMkDm4Zia0=;
	b=Itefw1Kh0X2MCiQBwVrCmCE/2bAjxO3+HJBYcVgBkU5Qv2jesGcNo6RDPapUkSs8DbAt
	 0EgfBYJBlyf4PKlgdHOco+AtxJYHcQz9QFpPUQced4zGzhlspBYWoiR06U2P76TG5w3rH
	 2ZDjsHVgbW0nFfRt8EHbkALG80cbEh+DwXqrsho65fQ/CN7PFlazONgms7ukmSWdtu9Hm
	 w0boJnR/TSGvLTuYEAg173mLY6oksHKlPAtMJXQCDCrT+hI8TLa1TjM8e0kG1sD1DENyY
	 HAg4MKAPR6Oxt4XbqhtN0FtlQUAPPBccmTZhES3aJ6B6HEU62WqqTrvnYLc6pgtdd0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=pdXJwP0g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.135
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021135.outbound.protection.outlook.com [40.107.74.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCC606A324;
	Fri, 27 Nov 2026 06:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1BCC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=pdXJwP0g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otKc9Wl6QlVC1/GN+lOj3qmTl7xXCvKuUKnXU9wudjFa1GcdJampZOzTdgYXnuhid+cwBTrYuUggkI7NonIyvYBku5orv/49Q+1pTy1w1xCPRTCDcfHm/gGeRKrVZSVuZv8ImbLJP6CSBx6ROfOErc4rseKLLfaGCIjGf4Cmo+HAura5nJupE0ygn7oKYggRdttNzH0C/UxB0vOYB6nOGX6kyPwVYGY6ie0xZYSXe7myZDaGlS1ccnWI4HCmuFtaMpkQhfJNu72LlNDOV4GbSfCkP/oaxKbqht+KkhHjBmKZkKjA8A49p0PeKt4hYMW/iAPAIr207o2aBTu/1cvOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+dT6AaBwXfX7XlEhpjtGmIjCkIrjvsrIWMkDm4Zia0=;
 b=unfonzdkruM7TWWtP6uzEF0R2u0ohoruc3MF96SWjNoskMzAm11QfNlhjAuX57kZtHaCOKkkxXSZZvHhvKzyPRME2YMUiUmo+oUPs8zldh6lZxRTvXsppXjJgq4mT2fP8CfDht0DQnOKOX0/qHGUfSOWRpbjYhXuLex2aB82dVOdP8uXqVuuMSpW5cv3ZEUN3u9EfVu54mViYntCp2EfUM6G0w6hFNY8gfJt2q8uR/CWF+Kr1dQllowm9UOhfBHoVqeYXgeGAHvaBymXJ1200ho62y6mquRIMJo40CR1UARUD2EUQW2FkJPM3iJXyBfUXO9U8dI+Q0pcPbH66ysR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+dT6AaBwXfX7XlEhpjtGmIjCkIrjvsrIWMkDm4Zia0=;
 b=pdXJwP0g4l4ba8rulcUkytjRdGNRJt1tI9YT7JSvX5QCV7n8WfFYdKUuIAPBv6AqGyVGM6pPpMRI/wd+JVKo/XkVBc22BYvErEfF+fD0SqAFSuXuHGJNQ8YQURdXsknEyhf6gvu63n9zcl6mZDIYeSu5DuUP/5I+6hU6cLsZOsc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB6833.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 06:30:21 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 06:30:21 +0000
Date: Fri, 27 Nov 2026 15:30:19 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ntb: ntb_tool: fix use-after-free of memory window
 debugfs files on remove
Message-ID: <awke343ZVpkOIDfg@z790sl>
References: <20261126031954.168544-1-kaynak.oguzhan0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126031954.168544-1-kaynak.oguzhan0@gmail.com>
X-ClientProxiedBy: TYCPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: e69da4fb-4816-42f0-28b6-08df4c4fe932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10070799003|261102123227099003|56012099006|10067099003|261022105027099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6YKJxXPp4Wjo+EDElaaXCd+/WxgH2x0akL+wn5b9yAJwFlNMMqLu20NBepcvE+RnSRG4IIyIflC5wxng012ZP4VvYGpoAbdp07As2kyaAJBmGHEkDvhuBWJWdIUC9EOI7ehWjDbmE13uKP8c3+pKdkzUiqfFhfD1QW/1RvS7CFiht2wI5OIOnITwX70WoCms3NwfDIcn9Pe/L0EQx1IxaRcbHflJVDePqUWY1BWszbZuilLR7qqylrqzdqT1VVesB0J08lAs2aNOAiAWAxX28CC1cvn+ri10YlVQWi36/msCQLhpFC/FOPG5wMhsWS3yBj0cr0RV6OjgjzmPvhVcW/G2GomgLo50Mw0pYGHk4d6TzKslZxlEzmJf5GUzviA4SZHM3Jmrm5HiqWbl8km9Z0RRIL+J4ftgD5vbALFAM7jts5aAj0kqjoIJU2vjcivGpqhIK6G+jjmIILxG8Iolw5i+W/BeTkCu+bZ51YikaMfqqwPpgB50OLrvIOaKcyWq3ps01cmTCG/YuglL7XqocKB/Nm4DTJmMfivtjd+QLr1dfmPrbQd++pA5kmCZCDzV6ZO4vQ0Sj2nAvU63QnaLaHwz0kQih/B9j3hSHtPMkj9DI/M+Ig74ItTv+1GKuXRrGKO1kkAmkSvv/TZi603jOUtSuD1hr67QjnYimVJnbco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10070799003)(261102123227099003)(56012099006)(10067099003)(261022105027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sGrQtn4CdryQMIIAqTl8G4SgoxdiUd4g+ZGVdXeBCTT6sNySu9ss2/zMbuW/?=
 =?us-ascii?Q?f115hDkS3XFNw3ANYY5fJ8wofQIwh0bjn3wAo1Gr9UTfJYYZ0uwth1HlpuGd?=
 =?us-ascii?Q?d7Vmeoq47xz87NZr2AwdL/qnVnHff3ushLTDr7fpLy1cy6NLKqZRQ0KeZFZ9?=
 =?us-ascii?Q?TuVbS4uye1I6cE3NHkKW7KHEpsATofZcvlb3Y8Gr51hZoKaX29egIwZTI3O2?=
 =?us-ascii?Q?LYSfP7Dq04vqJX/q0rWJqkZQ7OyevUuiW84TFnrUQbLUnpkbtvM6Wa9JiH/t?=
 =?us-ascii?Q?NU5KcEzQIODWfa+fCulHhI1xYFesfIDt6hDCAtUUUfIol5kIN/FISzEcfMLy?=
 =?us-ascii?Q?0+dXWVnEm2D/eK7N4B1jC2wz+yxMDEimeEK4y76Nak/yMefNC1SkXdJXg8/a?=
 =?us-ascii?Q?sixpbUbcUPt/NitUNuHuNTnxnyjednkjZHUT5gSuwSO7qJSWHhBdH6qbIzV/?=
 =?us-ascii?Q?oKGWqKwDGM8TT2V+a4S0zDA36J47F5crEg8v5TXV5vYzGKUT8e7k3EO5VBYQ?=
 =?us-ascii?Q?wcetXYmzvrahuPJ7kdJ42lVvBMJYR4/A7D/knGCLyeiMYl3ztzcLv/3xekRW?=
 =?us-ascii?Q?phY6pPh+9tpPxII+bB6P2waswAZWWJthylU/a83d9OuM0jFZ46dczybPs/mI?=
 =?us-ascii?Q?kzJb3QSiqwUJTCwuWDUkVr/dPV1cvr2QgBlOdQ66yOEoH6T/0PfeVudvOjB0?=
 =?us-ascii?Q?2s5+/UhQ+iZ+4N1TzFqS0myUmyOcmzPGqjuoh9uVvxDJXU00muiAgj6MHvg/?=
 =?us-ascii?Q?yxVPYZybbLxYiLRYGp4AsNuyMdiTmYaW3fWGYI8f2xgHiu1U6A4u0Ui1KLYD?=
 =?us-ascii?Q?u8C/vrF/3sqfCfg1r0oFqcM0g5b+qqRkEDbs+NGDz/TmbNVaGaOLNwMzXxFv?=
 =?us-ascii?Q?ETS6ZXdnXZ5bdsXnFRTbN4B9U/QecIwDobMG8mwb+AqES2mKOUNh7neRwJ/K?=
 =?us-ascii?Q?8pCJ2vLFbS6tDR3quFn5ckKhlZhXXF+GAPe7gYso4QXz1YQWkqUZvJ8Pz8vz?=
 =?us-ascii?Q?+R/iZVLCiyeLpbVSR413/K05NaF/BAM6PPzgioME/yyPJEqquGtM1nqMJ/Rd?=
 =?us-ascii?Q?ZG5rMCKtppDAa5Stx+NQd26gmw+ZglyH8pCzwvuhnxG4/aFacMBlMl9I0CiN?=
 =?us-ascii?Q?zn23n1OfytA6bgcrqIcZpMxhavsW07FXlhRkD4d6uv/WlPdEORrdp+NZLJZ2?=
 =?us-ascii?Q?66TBR5hYL92QMFsZxJx7VHl4uBxNuYCBM2V9ZIMts3jegLvlEpvnxE21qYt+?=
 =?us-ascii?Q?uxsu/w2c6joy+X0NidtU5snhZ6GQBbcm+NuB4P7iLLzrjJqiSMyAG+2IVj9M?=
 =?us-ascii?Q?jZJbP2QEaky76yf/2UmdQtxKZt/coIxmO30BC8kd8UGb7xT+lfLA6vVbrIKH?=
 =?us-ascii?Q?T+wy486RQwJwOOHUY3zgRhOK++iWqLtpkReKj2hMQyHJEBIDvEJSH/9dp6QC?=
 =?us-ascii?Q?64u0wwjWdl8JGu0TwDJEwvLLqszGNbdOVZ4jxrctDJ6g3oK6f88wXlXPwyD7?=
 =?us-ascii?Q?ZjSNkUdj2DrNtJHyaorj+tKeltbRcaYBeevQaQqdRJYjzp1HoejcG3ZGAXOY?=
 =?us-ascii?Q?/QewIajmq6f3UaC1zW68XgLwzjYvvjXVrBAJcfdxcziB0oRNDFjdLtxq0Bzo?=
 =?us-ascii?Q?FhyICe1Oty4haKF2kXz7tNzHjfS9QdeD61UE4lWJYbfKSIqWzSCxB3UMs+w0?=
 =?us-ascii?Q?BKhFPU6FbRs75yDuMYBoeoJBByOAk9ayKKl0hzOs/aJ4UlR7PA6qKa/cr3wD?=
 =?us-ascii?Q?DcjJS41tUYBWk6Wvn7LbB7GySRfBA2Q5PmDGDYSBmCuP+zr23HRi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e69da4fb-4816-42f0-28b6-08df4c4fe932
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 06:30:21.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpdvlVdfl29LjQF3eetb3aTbc/bDu+Ry5Q9IjpvslhBOXvhgmS0uMOxJ9KpevXvyGoTX52f/FGbmaRIh+LdgjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6833

On Thu, Nov 26, 2026 at 06:19:54AM +0300, Oguzhan KAYNAK wrote:
> tool_remove() removes the device's whole debugfs directory with
> debugfs_remove_recursive() before tool_clear_mws() frees the memory
> windows. The per-window files peer<N>/mw<M> and peer<N>/peer_mw<M> are
> created in that directory, so they are already gone when
> tool_free_mw() and tool_free_peer_mw() pass their stored dentries to
> debugfs_remove() again. Those dentries have been killed (d_inode is
> NULL) and are freed after an RCU grace period.
> 
> Removing ntb_tool, or unbinding it from the device, while a memory
> window is set up therefore crashes. With lockdep on x86-64:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000140
>   ...
>   Call Trace:
>    down_write_nested
>    __simple_recursive_removal
>    debugfs_remove
>    tool_free_peer_mw [ntb_tool]
>    tool_clear_mws [ntb_tool]
>    tool_remove [ntb_tool]
>    ntb_remove [ntb]
> 
> (0x140 is offsetof(struct inode, i_rwsem) + offsetof(struct
> rw_semaphore, dep_map) read through the NULL d_inode.) With KASAN the
> same access is reported as "null-ptr-deref in range
> [0x0000000000000140-0x0000000000000147]". If an RCU grace period has
> passed by then, the dentries themselves are already freed.
> 
> Found and tested on a virtual NTB device in QEMU: removing ntb_tool
> with an inbound window, an outbound window, or both set up crashed every
> time (tool_free_mw() or tool_free_peer_mw() in the trace); with this
> patch it unloads cleanly on lockdep and KASAN kernels.
> 
> Forget the window files once the directory has been removed, so that the
> free functions only release the windows themselves. Removing debugfs
> first is kept: it ends all user space access to the files before the
> windows go away.
> 
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>

Reviewed-by: Koichiro Den <den@valinux.co.jp>
Tested-by: Koichiro Den <den@valinux.co.jp>

> ---
>  drivers/ntb/test/ntb_tool.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -1599,7 +1599,22 @@ static void tool_setup_dbgfs(struct tool
>  
>  static void tool_clear_dbgfs(struct tool_ctx *tc)
>  {
> +	int pidx, widx;
> +
>  	debugfs_remove_recursive(tc->dbgfs_dir);
> +	tc->dbgfs_dir = NULL;
> +
> +	/*
> +	 * The memory window files lived in tc->dbgfs_dir and are gone now.
> +	 * Forget their dentries so that tool_clear_mws() doesn't remove
> +	 * them a second time.
> +	 */
> +	for (widx = 0; widx < tc->outmw_cnt; widx++)
> +		tc->outmws[widx].dbgfs_file = NULL;
> +
> +	for (pidx = 0; pidx < tc->peer_cnt; pidx++)
> +		for (widx = 0; widx < tc->peers[pidx].inmw_cnt; widx++)
> +			tc->peers[pidx].inmws[widx].dbgfs_file = NULL;
>  }
>  
>  static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
> -- 
> 2.34.1
