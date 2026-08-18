Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020125.outbound.protection.outlook.com [52.101.84.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B6469827;
	Tue, 18 Aug 2026 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055696; cv=fail; b=ooT7d1avB7ocUu7R9JW64z5Yrs2vfnbUPSfe2TsvCnun+1j7thGT1jdZHbLR2GEa8EuBsus+kZgi1VLBwW+kZyseT2koOmUz/ppIrTuWyDSZUEWy5ID3qxi5cDgNcCzB53GVb7Qr4/jJMqi3o9fBfupaxiuH/3V7TH4gIZJXSgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055696; c=relaxed/simple;
	bh=0LT1RGmtpi7BhO77vgFl7OMThkxraPe6SMGa4SXhpW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GiW9ZMlHYL32oq5OTc/OSOsbSLLkDiAymkM1ODHOYPM8fqP4FKH4WG+dbWLsA1ivWBvTWDVrKIgRu/Rohmr9TSKHbMeKNuaPpd48P1kjqTDD6C0emeL8tBO+oMyZRG4iI2ihhL5xehK/iHglQmghlitCAutzrf3cZJhVPfMMthQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=OlWWQU2u; arc=fail smtp.client-ip=52.101.84.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OlWWQU2u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeDtCDIoOFD3HcrLIuauK/Y9V6AhSMCExAT9409NV+nSLPeZxmtsgp5lXe7LP8UF9Ur+EMRqrsllgDw2X2ZfCNoLPsorWVnER8MRC0GykWtMDYnT9RGBF0lx6taD0ZWG+zBQVeA8A7XBumuRfVSpFHhE1l3zlH43eFyyMCXdU+COEqtvD4oocAAWWIK5EwMtfkNKd74cGL8gdrOb0IBzoEQkIb1V+4NzxIaI61AJWykfq219I6sAKLa6DPrkJcCVft42zsINL3kOejp+2nJ5vlEAlTtdEKp5v70A22e7/+9oyzrQRyODP8xloGo2kHM2gYIY9IT2BYJIzo0oiP1rTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/AEPBUMqy1axBBiAhAfdhW4HLAidhmDtc996/IsD0M=;
 b=xjLhOvqgCRwUV7mZ+SY8kdpwThawOUmk/ERCziWSWkS2zVPuOdLOPU1w6/YD9MAFkNoBO9i4d1BaRnm7uI/UfoM01oYNpf/XrirtHZK/r2RxqKWNd3ZJWIUnfAk8hNMsMwihrl8DVajm39HXAjL8A2+8XylBvnVqc7nKBBal/72AtWK1AK5ZDuHsqQhHNrG4+LTxVDbE4NbmIxEBO7dgsrGEm5E7OYmp989Dj5nhLLpaOeB0m9qhi8hinIVFLrSr9vuZR2HnH8JIFY/y7GCsIu17T23Rh2RiTzAGEg29mk14PCtfkLH4X7KMiluGZmUoefba/EshIgHAqbtx/3bCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/AEPBUMqy1axBBiAhAfdhW4HLAidhmDtc996/IsD0M=;
 b=OlWWQU2u3qm4JaAcJygBZgYz3tww7oiMvM33IVZQsT7jMCrAu0hIZrvobpBnxJ1XSDfM4ZO0V9Y1rPieGFJe432qUi/9pf+TlPns806xr+muetab1pJ7MhB5yuVmQkTo5aPhev2XOJWN/UAp7hUO/8OognC1qWSgpCQrE60wWO3Uzb84O7CPEi6pRJvDgcAHAk0OESU6UIqV2ZUSW4v+a1FBX9eMeAKDPg+L9VgsTSBspX3+fXtcPqfxhr1DPkAETc8x0x1rGjmMqKJkljP4h+D4KsEnwXzNDomCLS+M8JCMTLPMh5dHo2EE+4b0h/KUNsJDofhbisFHiqgsBv3jeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14) by DBBPR08MB10724.eurprd08.prod.outlook.com
 (2603:10a6:10:53d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 12:21:28 +0000
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a]) by AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a%7]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 12:21:27 +0000
Message-ID: <76dccc36-6949-44ad-9091-1d4c424d8faa@virtuozzo.com>
Date: Tue, 18 Aug 2026 14:21:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] reboot: fix cad_pid use-after-free race
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, joel.granados@kernel.org,
 kees@kernel.org
Cc: brauner@kernel.org, oleg@redhat.com, mingo@redhat.com,
 peterz@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
 avagin@gmail.com, mjguzik@gmail.com, include@grrlz.net,
 ebiederm@xmission.com, legion@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
References: <20260814040944.16561-1-blbllhy@gmail.com>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20260814040944.16561-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::20) To AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB11804:EE_|DBBPR08MB10724:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f06945-2efa-4f33-3443-08defd233a1e
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|7416014|23010399003|1800799024|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rhNqfVWJJjZ+o3RzWiR8mg/KQ74UP0FjF0kjwqgWPbSMRCygDwqz39ABenYqqad8y0a9mR1cFkIsQaI7bxSgwUUQKwnvFIufjMY71Huwe7QhIHZT948zaLVOqSteTI9xT4fDasvDt85sfr/Zy8DhQxnK+iqXxLcQUp3OQBAJ0G8y1tW/5t5wWj/mkRz+sZdv6u1CRN6bKE7QIdeB8XISWZvmwVt4O0imFtFa31cwjXy8GkzNgaR9IvgCskRN/YFdENd03Fuq6MwJZx9IqkMdh2krm9xIP9LZOQKj/1E8jRpISJ623hEhut0eDosgRg/rHOYKQjUKWBShb3amKk1IQVgXquwN24u2RWQRrfD8bNcyfPV3W+AMFbxM7aPHpMAlxFP3gCh86J3HiJxdcOfPtTA+ZbjCTM91+ig2k1vQ/v91hDf8owRVEGQvcy3iGdDsuwFkinxANyaBqtI9VHnYpLpKlgriKS9A3mG2OQfojjoNTA+SvU14EPB0zHZzCzSrAukf0M2/+qYEj3ewEQW5UtcnqRJlxGzxbEN6phzZcLLyXo8qlt0GTeuAdhSI0gd8ls+LcaExcibbB/sT/R106gDQBgf0SeiTT67GzuI8gz54ZuCTJ3jbd5n9uL6w9Gj/EKdRTdfj1ThLc+bE9dOQaiNeFYFbtCpngYl9aF1FOqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11804.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(7416014)(23010399003)(1800799024)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG00YVdyNHk3T0NXZ0tTTE5qVGQwVUdkVlhKWTdyaFZrcUo2ano3Z2RjekZ1?=
 =?utf-8?B?bkczeVMzTmZjSCszSmkrcGtaOTJDeGVqVTFrL2pJZHVQSlk3eWhuVkZHOCtJ?=
 =?utf-8?B?SmVESXo0UFh4ZnBYSTNONkJpRUhNUTNmdFdLUDdJdFZhVkU2T0JLQkpXRG5O?=
 =?utf-8?B?UklJeDNldmNqK3BkL3JyVDVhVnNINkxCckFEWVBWVFArUU94eWxEYmVxNnY3?=
 =?utf-8?B?U25ITUVEYkVLeEdya1BtTFRzMHljMHhOdlF6STEwTFdCaE9TMURnZ1I3a29Q?=
 =?utf-8?B?VGo5TEo4QTJFd0xmd2MyeG9vWFRNV2FkbmhaUzdpYXFjenFhZ1JiZG40UVEw?=
 =?utf-8?B?dXg2SEdDb1JpNmcxc3lLbVBRUmVMaDNEOGhpN3c1c2NoVWIvbjVUclVoRVhI?=
 =?utf-8?B?Sy9oYTdxYVFmc2JVRWZzN3VhakJTSEQxK1BIazNJak9RbHlGTmZFZnI4YkQ5?=
 =?utf-8?B?Y0k2UXZOZ0tEc0FMZUdFYUpIQm9XdERCNGduWUtEWVdjc2ZQMHZaMjhrZlE0?=
 =?utf-8?B?aS85UjhONE9LaFNPVkxYNkhOYUorSmlmTzd4TkRBZDd4Z0RuTTZNcVNtVUEv?=
 =?utf-8?B?eG1hWUI3WlcrSktuUjFBRnhyMEswamdsblNSVUhDTFFtd2dFbVpUdVc1WFMv?=
 =?utf-8?B?MGg5bHhHaUlveisraitsSUR4ekJqdVFPZTFnZVR3bS82a1k0WXB4d2s5U3hV?=
 =?utf-8?B?NDR2bkxnRlZYZEtzSE95KzJaTUdtUkxFWjYvN3VuRDloL1ZiUGtENHVxbDVK?=
 =?utf-8?B?V01QZ1dodVIxMGpWRERjZjdxTE5CL1BnZytsUGxYcEVGb2t5c1dGbG9odGhv?=
 =?utf-8?B?aS9qV2NScFRCcG9CV2dSeGk5cjdtbGg3cEsvcVgrK1hWSWt6VU9VeDJ4em8r?=
 =?utf-8?B?aFBZQWlCdkwwUEhJaGtXa3YzSkY2aWRaaXJYK2VpbU51R1JaaFN5N0kxZjVR?=
 =?utf-8?B?Yk9qakkrZGJBczkvbGRyeU1aZjd5RGRPMFd2VkwrZmkxQ2NJWDZjWDgzYnB4?=
 =?utf-8?B?SUkrejFLWnRaWjFJUlhKZVBrb2VSMjg4cGFtNnlxbFZTM3ZBamNWOHhYOE1Z?=
 =?utf-8?B?RFVCRDFHakcrKzFVMXF6K25Wc3lJMEFLb2dTOGxNNllFcGxxUlpZcjlpRjZK?=
 =?utf-8?B?Q0x5TWtBRWFnVmtPUEUrT1ZKd0haUU5KTTkrbmN5VU1HUXl3eXBVUzZrSmZr?=
 =?utf-8?B?SldQendOZGYzK3FNV3lnK1FYaG5OaVR1M3FLVDRpZitpQTg3SG84OVlsNUdw?=
 =?utf-8?B?ZXpVTTUySzdQb1pYQjRRNngzSkMyb3FUSzVGRWtkeStLQ081dlozM04xSnZE?=
 =?utf-8?B?Q0RSODdvQkpZT3A2bWNaalo0R1lSZHIzV1RBMkRTS20waGhYME5pWWJiOEhK?=
 =?utf-8?B?cEwraFRQd2s3aTdpM2pWYmszQkx2Q0dCWlM5cVFGTkVXMHcvRXBObW5vbnZT?=
 =?utf-8?B?L0VRaGdDZnZpZVZmMHpNdHppZDVhWmUvUGtwUjdoYWExdXAzRWFGdzhPbUJq?=
 =?utf-8?B?Z0M2RUNMQnQyVjcxLzNsVE54enVvY2Q2VXpGWkxUOVNvRVdjTGNoRFNvNTZs?=
 =?utf-8?B?WGpySlQ4b25iVXJ2RWhQSzE5dzJjZkx1bFpvdjNMTFBZNTJuSFQvNTA0ei9C?=
 =?utf-8?B?ZHVKd2IrSFhaMmVHTXlDWEhld2h3N29rejNqcXc0REg0eURUYlhMVmRzR3Yx?=
 =?utf-8?B?d0xZWEVpYVlYRlg0R2Z0MTFEQWlYTHU3UzZwQkp1djFZQ3VaMmhxd05ucTlU?=
 =?utf-8?B?SjdoOEFXM09NUW9rbGlOK0did3BpWmFUWlAvQ1pvVE9oMnl1R2FCVm04YU4z?=
 =?utf-8?B?M3V5bDdTN2pFZWcxK3pwT2sxdzVIeEJYZWpQN2VkN2dmY3FvS0FjblFvSzlJ?=
 =?utf-8?B?T0tQNXpaL1U4V25MUEZ0NG00QXRTZkZHT3RlQzF6anR0Z3dNM1Q3S3JrMGx1?=
 =?utf-8?B?LzBqRmFGeCt2anFqeUhESEtGMEV4UlpYejhtZldjQ1FBZXg0TUExT21DWTBk?=
 =?utf-8?B?d3J4Q2NKMk0vT3dBaHUzN3lsU2gxdHE4SlB1ZjdVK0dUSEFIbkR5V0lITVIz?=
 =?utf-8?B?UWdFTXo2aHE3b0s1VDNtZ1B6am96V2ZYL2FNZXAzK0w4YWRLSWpFZ1NGWTZV?=
 =?utf-8?B?emRYTDNnRngyNkdlZ09OWmNtOXovY25zRmUxK1VtZTVPYnlXTGt5RFVnelpP?=
 =?utf-8?B?d0ZBblRKN0xqUFQ0cy96U1ZETkk5OTJIOWlhcE91cldHZWY0clM2YytXa0Fz?=
 =?utf-8?B?aURSbStWOHR5NHk5NVJ5NmZCVW5HemdlMjRCQmovNVNVay85bmZIbERwME1o?=
 =?utf-8?B?TGZCdll2MThlMkhmWFdkZldVSFhmQ1ptWHVBUkVhM0hMZDhsZ3FGYUFiMXUw?=
 =?utf-8?Q?Uw0rbb3125KNUOfnBtGI0LtZDpgrZYyrKRyGPaG8uUKa7?=
X-MS-Exchange-AntiSpam-MessageData-1: AZbPpVRx4l4bhDlBYd6cO1yITUF47dUszvo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f06945-2efa-4f33-3443-08defd233a1e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB11804.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:21:27.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRDCqaJLdnhzqmVuhOyrmpIipNtuw0aLe5PWsDHbY83q6pLT4bOkYobI1HlVR88LWGGadGpXpTcWQhEvyK7pvK6Hng5MrYutyw1oPzIqP1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10724

Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

On 8/14/26 06:09, Cen Zhang (Microsoft) wrote:
> cad_pid is a single kernel-wide struct pid pointer. proc_do_cad_pid()
> reads it and passes it to pid_vnr() without protecting the lifetime of
> the referenced struct pid. A concurrent writer can replace cad_pid and
> drop the final reference to the old struct pid after the reader has
> loaded the pointer but before pid_vnr() has finished dereferencing it,
> causing a use-after-free.
> 
> kill_cad_pid() has the same lifetime race when it passes cad_pid to
> kill_pid().
> 
> At the time this issue was reported, an unprivileged user could reach the
> sysctl through user and PID namespaces because cad_pid was registered in
> pid_table[]. Moving cad_pid back to the global reboot sysctl table
> corrected that namespace and permission mismatch, but did not fix the
> underlying lifetime race.
> 
> Fix this by treating cad_pid as an RCU-protected pointer at both read
> sites and by waiting for a grace period before dropping the old reference
> on the write side.
> 
> call_rcu(&old_pid->rcu, ...) cannot be used here because free_pid()
> also queues pid->rcu; queueing the same rcu_head twice can corrupt the
> RCU callback list.
> 
> Original KASAN crash stack:
>   kernel/pid.c:545 pid_nr_ns()        # reads freed pid->level
>   kernel/pid.c:556 pid_vnr()          # calls pid_nr_ns()
>   kernel/pid.c:775 proc_do_cad_pid()  # calls pid_vnr(cad_pid)
> 
> Fixes: 9ec52099e4b8 ("[PATCH] replace cad_pid by a struct pid")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Closes: https://lore.kernel.org/all/20260717210143.4734-1-blbllhy@gmail.com/
> Link: https://lore.kernel.org/all/alz5ZYLE4kaq_v2P@redhat.com/
> Link: https://lore.kernel.org/all/al4ICz9biJKtdZc4@redhat.com/
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Suggested-by: Bradley Morgan <include@grrlz.net>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Suggested-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v4:
>  - Rebase on sysctl-next after Oleg's cad_pid sysctl placement change.
>  - Fold the two-patch v3 series into a single lifetime fix.
>  - Move kill_cad_pid() implementation to kernel/signal.c.
>  - Export kill_cad_pid() and stop exporting the raw cad_pid pointer.
>  - Update proc_do_cad_pid() in kernel/reboot.c.
>  - Add explicit includes for the RCU API and kill_cad_pid().
>  - Preserve the original unprivileged impact context while noting that
>    the namespace permission path has been fixed separately.
> 
> v3:
>  - Keep kill_cad_pid() inside the RCU read-side critical section
>    instead of taking a pid reference, as suggested by Oleg.
> 
> v2:
>  - Split out kill_cad_pid() deinline into a preparatory patch.
>  - Annotate cad_pid as __rcu and use rcu_dereference().
>  - Protect kill_cad_pid() by taking a pid reference under RCU.
>  - Add a comment explaining why synchronize_rcu() is used instead of
>    call_rcu().
> 
>  include/linux/sched.h        |  2 +-
>  include/linux/sched/signal.h |  5 +----
>  init/main.c                  |  2 +-
>  kernel/reboot.c              | 19 +++++++++++++++----
>  kernel/signal.c              | 12 ++++++++++++
>  5 files changed, 30 insertions(+), 10 deletions(-)
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
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 584ae88b435e..d45a5476b97d 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -562,10 +562,7 @@ static inline sigset_t *sigmask_to_save(void)
>  	return res;
>  }
>  
> -static inline int kill_cad_pid(int sig, int priv)
> -{
> -	return kill_pid(cad_pid, sig, priv);
> -}
> +int kill_cad_pid(int sig, int priv);
>  
>  /* These can be the second arg to send_sig_info/send_group_sig_info.  */
>  #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
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
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index f070c5c1103a..d177d89fcc33 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -13,7 +13,9 @@
>  #include <linux/kexec.h>
>  #include <linux/kmod.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/rcupdate.h>
>  #include <linux/reboot.h>
> +#include <linux/sched/signal.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
>  #include <linux/syscore_ops.h>
> @@ -24,8 +26,7 @@
>   */
>  
>  static int C_A_D = 1;
> -struct pid *cad_pid;
> -EXPORT_SYMBOL(cad_pid);
> +struct pid __rcu *cad_pid;
>  
>  #if defined(CONFIG_ARM)
>  #define DEFAULT_REBOOT_MODE		= REBOOT_HARD
> @@ -1371,10 +1372,14 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
>  {
>  	struct ctl_table tmp_table = *table;
>  	struct pid *new_pid;
> +	struct pid *old_pid;
>  	pid_t tmp_pid;
>  	int r;
>  
> -	tmp_pid = pid_vnr(cad_pid);
> +	rcu_read_lock();
> +	tmp_pid = pid_vnr(rcu_dereference(cad_pid));
> +	rcu_read_unlock();
> +
>  	tmp_table.data = &tmp_pid;
>  
>  	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
> @@ -1385,7 +1390,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
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
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9c2b32c4d755..464732c44554 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1891,6 +1891,18 @@ int kill_pid(struct pid *pid, int sig, int priv)
>  }
>  EXPORT_SYMBOL(kill_pid);
>  
> +int kill_cad_pid(int sig, int priv)
> +{
> +	int ret;
> +
> +	rcu_read_lock();
> +	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(kill_cad_pid);
> +
>  #ifdef CONFIG_POSIX_TIMERS
>  /*
>   * These functions handle POSIX timer signals. POSIX timers use
> 
> base-commit: 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.

